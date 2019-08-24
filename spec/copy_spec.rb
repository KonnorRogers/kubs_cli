# frozen_string_literal: true
require 'fileutils'
require 'ostruct'

module KubsCLI
  RSpec.describe Copy do
    let(:copy) do
      local = File.join(File.expand_path(__dir__), 'local_test_files')
      dotfiles = File.join(File.expand_path(__dir__), 'test_files')
      config = OpenStruct.new(dotfiles: dotfiles, local_dir: local)

      Copy.new(config)
    end

    context '#copy_dotfiles' do
      it 'Should turn non dotfiles into dotfiles' do
        expect(copy.config.dotfiles).to eq(File.join(File.expand_path(__dir__), 'test_files'))
        test_files = %w[dir file1 file2]
        expect(Dir.children(copy.config.dotfiles)).to match_array(test_files)

        copy.copy_dotfiles

        ary = ['.dir', '.file1', '.file2']
        expect(Dir.children(copy.config.local_dir)).to match_array(ary)
        FileUtils.rm_rf(copy.config.local_dir)
      end
    end
  end
end
