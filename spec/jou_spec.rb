require_relative '../lib/jou'
require 'tempfile'

describe 'Journal' do
  before do
    # Create a basic temporary journal file
    @journal_file = Tempfile.new('jou_test')
    @journal = Journal.new(@journal_file.path)

    @today = Date.today.strftime("%y.%m.%d").to_sym
  end

  it "adds entries to the journal hash" do
    @journal.add("hi!")
    @journal.should == {@today => ["hi!"]}
  end

  it "correctly (de)serializes the journal file" do
    @journal.add("hi!")
    @journal.reverse_sort
    @journal.deserialize # save

    #Now load the journal file from another object
    j2 = Journal.new(@journal_file.path)
    j2.serialize

    @journal.should == j2
  end

  it "creates a hash from a properly formatted journal file" do
    @journal.should be_a(Hash)
  end

  it "returns a string with entries from today" do
    @journal.add("hi!")
    @journal.add("ho!")
    @journal.get_recent(1).should == "### 13.10.27­\n * hi!\n * ho!\n\n"
  end
end