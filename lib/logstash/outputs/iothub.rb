# encoding: utf-8
require "logstash/outputs/base"
require "logstash/namespace"
require 'java'
require 'logstash-output-iothub_jars.rb'

java_import "com.microsoft.azure.sdk.iot.device.DeviceClient"
java_import "com.microsoft.azure.sdk.iot.device.IotHubClientProtocol"
java_import "com.microsoft.azure.sdk.iot.device.Message"
java_import "com.microsoft.azure.sdk.iot.device.IotHubEventCallback"

$wait_queue = {}

class EventCallback
  include IotHubEventCallback
  def execute(status, context)
    $wait_queue.delete(context) if $wait_queue[context]
# puts("Callback #{context} : #{status.to_s}")
  end
end

class LogStash::Outputs::Iothub < LogStash::Outputs::Base
  config_name "iothub"

  config :connection_string, :validate => :string, :required => true
  config :use_mqtt_websockets, :validate => :boolean, :required => false

  # Todo: support for AMQPS.
  # config :sas_token_expiry_time_sec, :validte => :number, :default => 2400

  public
  def register
    # Todo: Get hang in an open with AMQPS.
    #protocol = IotHubClientProtocol::AMQPS

    if @use_mqtt_websockets
      protocol = IotHubClientProtocol::MQTT_WS
    else
      protocol = IotHubClientProtocol::MQTT
    end

    @client = DeviceClient.new(@connection_string, protocol)

    # Todo: use params for AMQPS protocol.
    # @client.setOption(
    #   "SetCertificatePath",
    #   "/Users/tac/Desktop/logstash-output-iothub/cert.crt")

    # @client.setOption(
    #   "SetSASTokenExpiryTime",
    #   @sas_token_expiry_time_sec)

    @client.open()
  end # def register


  public
  def receive(event)
    m = event.to_json
    $wait_queue[m] = true
    msg = Message.new(m)
    msg.setExpiryTime(3000)
    @client.sendEventAsync(
      msg,
      EventCallback.new, m)

    return "Event received"
  end # def receive

  public
  def close()
    begin
      # waiting callbacks for all sent messages.
      sleep 1 unless $wait_queue.empty?

      @client.close() if @client
    rescue => e
    end
  end
end # class LogStash::Outputs::Iothub
