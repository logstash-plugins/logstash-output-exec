# encoding: utf-8
require "logstash/outputs/exec"
require "logstash/event"
require "logstash/devutils/rspec/spec_helper"
require "tempfile"

describe LogStash::Outputs::Exec do
  let(:event) { LogStash::Event.new({ "params" => "1234" }) }
  let(:output) { "1" }
  let(:command) { "echo #{output}" }

  let(:config) do
    { "command" => command }
  end

  let(:error_message) { "Oulala" }
  let(:stderr) { Tempfile.new(error_message) }
  let(:stdout) { Tempfile.new(output) }
  let(:stdin) { Tempfile.new("") }

  subject { described_class.new(config) }

  it "receive a command and execute it" do
    expect(Open3).to receive(:popen3).with(command)
    subject.receive(event)
  end

  context "when debugging" do
    before :each do
      allow(subject.logger).to receive(:debug?).and_return(true)
      expect(Open3).to receive(:popen3).with(command).and_yield(stdin, stdout, stderr)
    end

    it "register the stdout and stderr to the logger" do
      expect(subject.logger).to receive(:debug).with(/running exec command/, hash_including(:command))
      expect(subject.logger).to receive(:debug).with(/debugging/, hash_including(:stdout, :stderr))
      subject.receive(event)
    end
  end

  context "When debugging is off" do
    context "when quiet is off" do
      it "write output to the terminal" do
        expect(subject.logger).to receive(:info).with(output)
        subject.receive(event)
      end
    end
  end
end
