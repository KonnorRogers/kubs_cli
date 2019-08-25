# frozen_string_literal: true

require 'fileutils'
require 'ostruct'

module KubsCLI
  RSpec.describe Copy do
    let(:copy) do
      local = File.join(TEST_FILES, 'local_test_files')
      dotfiles = File.join(TEST_FILES)
      config = OpenStruct.new(dotfiles: dotfiles, local_dir: local)

      Copy.new(config)
    end

    context '#copy_dotfiles' do
      it 'Should turn non dotfiles into dotfiles' do
        expect(copy.config.dotfiles).to eq(TEST_FILES)
        test_files = %w[dir file1 file2 local_test_files]
        expect(Dir.children(copy.config.dotfiles)).to match_array(test_files)

        copy.copy_dotfiles

        ary = ['.dir', '.file1', '.file2', '.local_test_files']
        expect(Dir.children(copy.config.local_dir)).to match_array(ary)
        FileUtils.rm_rf(copy.config.local_dir)
      end
    end
  end
end
