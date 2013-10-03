require 'date'

class Journal < Hash

  def initialize(file)
    @file = file
  end

  def sort
    self.keys.sort.reverse.each { |k| self[k] = self.delete k }
  end

  # Reads the markdown file and converts it to a hash
  def serialize
    active_date = ""
    entries = []
    return "File not found." if !File.exist?(@file)
    File.foreach(@file) do |line|
      if line.start_with?("###")
        active_date = line[4..-1].chomp.to_sym
        self[active_date] = {}
        entries = []
      elsif line.start_with?(" *")
        entry = line[3..-1].chomp
        self[active_date] = entries.push(entry)
      end
    end
  end

  # Converts the hash to a markdown file
  def deserialize
    File.open(@file, "w") do |file|
      self.each_pair do |date, entries|
        file << "### #{date}\n"
        entries.each do |e|
          file << " * #{e}\n"
        end
        file << "\n"
      end
    end
  end

  # Adds an entry to the hash
  def add(string)
    today = Date.today.strftime("%y.%m.%d").to_sym
    entries = self[today] || []
    self[today] = entries.push(string)
  end
end

# j = Journal.new
# j.serialize
# j.sort
# j.add("hi")
# j.add("hello")
# j.deserialize
# p j