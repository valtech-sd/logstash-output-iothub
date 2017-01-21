# encoding: utf-8
require "logstash/outputs/base"
require "logstash/namespace"
require 'java'
require 'logstash-output-iothub_jars.rb'

# require "./iot-device-client-1.0.17-with-deps.jar"

# An iothub output that does nothing.
class LogStash::Outputs::Iothub < LogStash::Outputs::Base
  config_name "iothub"

  config :connection_string, :validate => :string, :required => true

  private
  def import_jar_namespaces
    java_import "com.microsoft.azure.sdk.iot.device.DeviceClient"
    java_import "com.microsoft.azure.sdk.iot.device.IotHubClientProtocol"
    java_import "com.microsoft.azure.sdk.iot.device.Message"
    java_import "com.microsoft.azure.sdk.iot.device.IotHubEventCallback"
  end

  private
  def open_connection(
    connection_string = @connection_string,
    protocol = IotHubClientProtocol::AMQPS)
    client = DeviceClient.new(connection_string, protocol)
  end

  public
  def register
    import_jar_namespaces()

    open_connection()
  end # def register

  public
  def receive(event)
    return "Event received"
  end # def event
end # class LogStash::Outputs::Iothub
