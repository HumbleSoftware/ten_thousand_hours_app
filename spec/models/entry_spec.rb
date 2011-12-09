require 'spec_helper'

describe "Entry Model" do
  let(:entry) { Entry.new }
  it 'can be created' do
    entry.should_not be_nil
  end

  it "doesn't validate" do
    entry.valid?.should_not be_true
  end

  let(:entry) { Entry.new(:date => '10/10/2010') }
  it "doesn't validate with only a date" do
    entry.valid?.should_not be_true
  end

  let(:entry) { Entry.new(:time => '10/10/2010') }
  it "doesn't validate with only a time" do
    entry.valid?.should_not be_true
  end

  let(:entry) { Entry.new(:time => '10/10/2010', :date => '10/10/2010') }
  it 'validates' do
    entry.valid?.should_not be_true
  end

end
