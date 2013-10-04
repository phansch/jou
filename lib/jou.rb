require 'date'
require_relative 'journal_config'

class Journal < Hash
  def initialize(active_file = nil)
    # Setup config
    config_file = Dir.home + "/.jou"
    JournalConfig.create(config_file) unless File.exists?(config_file)
    JournalConfig.configure_with(config_file)

    # if no journal file is specified with -f, use the configured file
    @active_file = active_file || JournalConfig.config[:journal_file]

    # On first run, set first_run to false
    JournalConfig.config[:first_run] = false if JournalConfig.config[:first_run]
    JournalConfig.create(config_file)
  end

  def reverse_sort
    self.keys.sort.reverse.each { |k| self[k] = self.delete k }
  end

  # Reads the markdown file and converts it to a hash
  def serialize
    active_date = ""
    entries = []
    begin
      File.foreach(@active_file) do |line|
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
      puts "If jou is running for the first time, your journal  #{@active_file}"
    end

  end

  # Converts the hash to a markdown file
  def deserialize
    begin
      File.open(@active_file, "w") do |file|
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
