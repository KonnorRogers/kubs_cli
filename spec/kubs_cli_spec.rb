# frozen_string_literal: true

RSpec.describe KubsCLI do
  it 'has a version number' do
    expect(KubsCLI::VERSION).not_to be nil
  end

  it 'Should create an array of errors when non specified' do
    expect(KubsCLI.errors).to be_empty
  end

  it 'Should add an error with add_error(e:, msg:)' do
    KubsCLI.add_error(error: KubsCLI::Error, msg: "I'm an error message")
    expect(KubsCLI.errors).to_not be_empty
    expect(KubsCLI.errors[0].message).to eql "I'm an error message"
    expect(KubsCLI.errors[0].class).to eql KubsCLI::Error
  end
end
