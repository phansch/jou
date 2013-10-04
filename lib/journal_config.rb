require 'yaml'
require 'fileutils'

# Taken from http://stackoverflow.com/questions/6233124/where-to-place-access-config-file-in-gem
module JournalConfig

  # Set defaults values
  @config = {
    :journal_file => Dir.home + "/Documents/journal.md",
    :first_run => true
  }
  @valid_config_keys = @config.keys

  def self.configure(opts = {})
    opts.each {|k,v| @config[k.to_sym] = v if @valid_config_keys.include? k.to_sym}
  end

  def self.configure_with(config_file)
    begin
      config = YAML.load_file(config_file)
    rescue Errno::ENOENT
      puts "YAML configuration file couldn't be found. Using defaults."; return
    rescue Psych::SyntaxError
      puts "YAML configuration file contains invalid syntax. Using defaults."; return
    end

    configure(config)
  end

  def self.create(config_file)
    File.open(config_file, "w") do |file|
      file.write @config.to_yaml
    end
  end

  def self.config
    @config
  end
end