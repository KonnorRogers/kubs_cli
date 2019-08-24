# frozen_string_literal: true

module KubsCLI
  RSpec.describe Copy do
    before(:each) do
      KubsCLI.configure do |c|
        c.dotfiles = 'test_files'
        c.local_dir = 'local_test_files'
      end
    end

    after(:each) do
      KubsCLI.reset_configuration
    end

    let(:copy) { KubsCLI::Copy.new }

    context '#copy_dotfiles' do
      it 'Should turn non dotfiles into dotfiles' do

        expect(KubsCLI.configuration.dotfiles).to eq('test_files')
        copy.copy_dotfiles

        ary = ['.dir', '.file1', 'file2']
        expect(KubsCLI.local_dir).to match_array(ary)
      end
    end
  end
end
