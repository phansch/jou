require_relative '../lib/jou'
require 'tempfile'

describe 'Journal' do
  before do
    # Create a basic temporary journal file
    @journal_file = Tempfile.new('jou_test')
    @journal = Journal.new(@journal_file.path)
  end

  it "adds entries to the journal hash" do
    @journal.add("hi!")
    today = Date.today.strftime("%y.%m.%d").to_sym

    @journal.should == {today => ["hi!"]}
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
    j = Journal.new(@journal_file.path) # Load previous journal file
    j.should be_a(Hash)
  end
end