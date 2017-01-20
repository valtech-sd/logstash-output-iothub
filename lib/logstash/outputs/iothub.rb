# encoding: utf-8
require "logstash/outputs/base"
require "logstash/namespace"

# An iothub output that does nothing.
class LogStash::Outputs::Iothub < LogStash::Outputs::Base
  config_name "iothub"

  public
  def register
  end # def register

  public
  def receive(event)
    return "Event received"
  end # def event
end # class LogStash::Outputs::Iothub
