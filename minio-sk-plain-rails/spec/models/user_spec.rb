require 'spec_helper'

describe User do
  it 'is signed in' do
    expect(subject).to be_signed_in
  end
end
