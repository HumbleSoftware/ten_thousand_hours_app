require 'spec_helper'

describe "Reset Model" do
  let(:reset) { Reset.new }
  it 'can be created' do
    reset.should_not be_nil
  end
end
