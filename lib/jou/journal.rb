require 'date'
require_relative 'journal_config'

class Journal < Hash
  def initialize(active_journal)
    config_setup(active_journal)
    @journal_file = active_journal
  end

  def config_setup(file)
    config_file = Dir.home + "/.jou"

    if JournalConfig.config[:first_run]
      # Create a new config file on first run
      JournalConfig.config[:first_run] = false
      JournalConfig.config[:journal_file] = file
      JournalConfig.create(config_file)
    end

    JournalConfig.configure_with(config_file)
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

  def get_recent(limit = 5)
    out = ""

    self.each_pair do |date, entries|
      break if limit == 0

      out << "### #{date}\n"
      entries.each { |e| out << " * #{e}\n" }
      out << "\n"
      limit -= 1
    end

    out
  end


end
