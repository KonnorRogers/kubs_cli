# frozen_string_literal: true

require 'fileutils'
require 'ostruct'

module KubsCLI
  RSpec.describe Pull do
    let(:pull) do
      dotfiles = File.join(File.dirname(TEST_FILES), 'pull_test_files')
      local = File.join(TEST_FILES, 'local_pull_test_files')
      config = OpenStruct.new(dotfiles: dotfiles, local_dir: local)
      Pull.new(config)
    end

    context '#pull_dotfiles' do
      it 'should only pull dotfiles that already exist' do
        FileUtils.mkdir_p(pull.config.local_dir)

        FileUtils.touch(File.join(pull.config.local_dir, '.file2'))
        pull.pull_dotfiles
      end
    end

  end
end
