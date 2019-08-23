# frozen_string_literal: true

RSpec.describe KubsCLI do
  it 'has a version number' do
    expect(KubsCLI::VERSION).not_to be nil
  end

  context '#errors' do
    it 'Should create an array of errors when none added' do
      expect(KubsCLI.errors).to be_empty
    end

    it 'Should add an error with add_error(e:, msg:)' do
      KubsCLI.add_error(e: KubsCLI::Error, msg: "I'm an error message")
      expect(KubsCLI.errors).to_not be_empty
      KubsCLI.clear_errors
    end
  end
end
