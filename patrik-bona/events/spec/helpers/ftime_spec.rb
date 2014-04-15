require 'spec_helper'

describe '#time' do
  it 'returns Time in HH:MM format' do
    time_obj = Time.new(2014, 03, 31, 10, 25)

    expect(helper.time(time_obj)).to eq "10:25"
  end

  it 'returns empty string when nil is given' do
    expect(helper.time(nil)).to be nil
  end
end
