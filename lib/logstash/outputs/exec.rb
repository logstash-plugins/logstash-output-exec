# encoding: utf-8
require "logstash/namespace"
require "logstash/outputs/base"

# The exec output will run a command for each event received. Ruby's
# `system()` function will be used, i.e. the command string will
# be passed to a shell. You can use `%{name}` and other dynamic strings
# in the command to pass select fields from the event to the child
# process. Example:
# [source,ruby]
#     output {
#       if [type] == "abuse" {
#         exec {
#           command => "iptables -A INPUT -s %{clientip} -j DROP"
#         }
#       }
#     }
#
# WARNING: If you want it non-blocking you should use `&` or `dtach`
# or other such techniques. There is no timeout for the commands being
# run so misbehaving commands could otherwise stall the Logstash
# pipeline indefinitely.
#
# WARNING: Exercise great caution with `%{name}` field placeholders.
# The contents of the field will be included verbatim without any
# sanitization, i.e. any shell metacharacters from the field values
# will be passed straight to the shell.
class LogStash::Outputs::Exec < LogStash::Outputs::Base

  config_name "exec"

  # Command line to execute via subprocess. Use `dtach` or `screen` to
  # make it non blocking. This value can include `%{name}` and other
  # dynamic strings.
  config :command, :validate => :string, :required => true

  public
  def register
    @logger.debug("exec output registered", :config => @config)
  end # def register

  public
  def receive(event)
    
    @logger.debug("running exec command", :command => event.sprintf(@command))
    system(event.sprintf(@command))
  end # def receive

end
