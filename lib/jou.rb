require 'date'
require_relative 'journal_config'

class Journal < Hash
  def initialize(active_file = nil)
    config_setup(active_file)
    @journal_file = JournalConfig.config[:journal_file]
  end

  def config_setup(file = nil)
    # Create a new config file on first run
    if JournalConfig.config[:first_run]
      config_file = Dir.home + "/.jou"
      JournalConfig.create(config_file) unless File.exists?(config_file)
      JournalConfig.configure_with(config_file)
      JournalConfig.config[:first_run] = false
    end
  end

  def reverse_sort
    self.keys.sort.reverse.each { |k| self[k] = self.delete k }
  end

  # Reads the markdown file and converts it to a hash
  def serialize
    active_date = ""
    entries = []
    begin
      File.foreach(@journal_file) do |line|
        if line.start_with?("###")
          active_date = line[4..-1].chomp.to_sym
          self[active_date] = {}
          entries = []
        elsif line.start_with?(" *")
          entry = line[3..-1].chomp
          self[active_date] = entries.push(entry)
        end
      end
    rescue Errno::ENOENT => e
      puts e.message
    end

  end

  # Converts the hash to a markdown file
  def deserialize
    begin
      File.open(@journal_file, "w") do |file|
        self.each_pair do |date, entries|
          file << "### #{date}\n"
          entries.each do |e|
            file << " * #{e}\n"
          end
          file << "\n"
        end
      end
    rescue Errno::ENOENT => e
      puts e.message
    end
  end

  # Adds an entry to the hash
  def add(string)
    today = Date.today.strftime("%y.%m.%d").to_sym
    entries = self[today] || []
    self[today] = entries.push(string)
  end
end
