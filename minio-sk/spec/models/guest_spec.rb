require 'spec_helper'

describe Guest do
  it 'is not signed in' do
    expect(subject).not_to be_signed_in
  end
end
