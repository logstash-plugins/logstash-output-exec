## 3.1.2
  - Fix some documentation issues

## 3.1.0
  - Log output of the exec'd command using log4j info and debug

## 3.0.3
  - Relax constraint on logstash-core-plugin-api to >= 1.60 <= 2.99

## 3.0.2
 - Replace `Kernel.system` with `Open3.open3` and fixes `ThreadDeath` issues
 - Will now log stdout and stderr of the command when running logstash in debug mode, the response is streamed to the log.
 - Added a `quiet` option to not print the result of the command to stdout, this option is on by default for backward compatibility
 - Added tests

## 3.0.1
  - Republish all the gems under jruby.

## 3.0.0
  - Update the plugin to the version 2.0 of the plugin api, this change is required for Logstash 5.0 compatibility. See https://github.com/elastic/logstash/issues/5141

## 2.0.4
  - Depend on logstash-core-plugin-api instead of logstash-core, removing the need to mass update plugins on major releases of logstash

## 2.0.3
  - New dependency requirements for logstash-core for the 5.0 release

## 2.0.0
 - Plugins were updated to follow the new shutdown semantic, this mainly allows Logstash to instruct input plugins to terminate gracefully, 
   instead of using Thread.raise on the plugins' threads. Ref: https://github.com/elastic/logstash/pull/3895
 - Dependency on logstash-core update to 2.0

