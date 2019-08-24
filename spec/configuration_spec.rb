# frozen_string_literal: true

module KubsCLI
  RSpec.describe Configuration do
    describe '#dotfiles' do
      it 'default value is nil' do
        config = Configuration.new
        expect(config.dotfiles).to eq(nil)
        config.dotfiles = 'test_files'
        expect(config.dotfiles).to eq('test_files')
      end
    end

    describe '#dotfiles=' do
      it 'can set value' do
        config = Configuration.new
        config.dotfiles = 'new_test_files'
        expect(config.dotfiles).to eq('new_test_files')
      end
    end
  end
end
