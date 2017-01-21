Gem::Specification.new do |s|
  s.name          = 'logstash-output-iothub'
  s.version       = '1.1.0'
  s.licenses      = ['Apache-2.0']
  s.summary       = 'Output plugin for Logstash for sending Azure IoTHub'
  s.description   = 'Output plugin for Logstash for sending Azure IoTHub'
  s.homepage      = 'https://github.com/tac0x2a/logstash-output-iothub'
  s.authors       = ['TAC']
  s.email         = 'tac@tac42.net'
  s.require_paths = ['lib']

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
   # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "output" }

  s.requirements << "jar 'com.microsoft.azure.sdk.iot:iot-device-client', '1.0.17'"
  s.add_development_dependency 'jar-dependencies'

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0"
  s.add_runtime_dependency "logstash-codec-plain"
  s.add_development_dependency "logstash-devutils"
  s.add_development_dependency "fuubar"

end
