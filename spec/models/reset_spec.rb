require 'spec_helper'

describe "Reset Model" do
  let(:reset) { Reset.new }
  it 'can be created' do
    reset.should_not be_nil
  end

  let(:reset) { Reset.new }
  it 'should set used to true' do
    reset.valid?
    reset.used.should be_true
  end

  let(:reset) { Reset.new }
  it 'should set 32 character key' do
    reset.valid?
    (reset.password_key.length == 32).should be_true
  end

  let(:reset) { Reset.new }
  it 'should not validate with defaults and no account' do
    reset.valid?.should_not be_true
  end

  let(:reset) { Reset.new }
  it 'should validate with defaults and account' do
    reset.account_id = 1
    reset.valid?.should be_true
  end

  let(:reset_a) { Reset.new }
  let(:reset_b) { Reset.new }
  it 'should have different keys' do
    (reset_a.password_key == reset_b.password_key).should be_false
  end

end
