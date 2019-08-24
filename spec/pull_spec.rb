# frozen_string_literal: true

require 'fileutils'
require 'ostruct'

module KubsCLI
  RSpec.describe Pull do
    let(:pull) do
      local = File.join(File.dirname(TEST_FILES), 'pull_test_files')
      dotfiles = File.join(TEST_FILES)
      config = OpenStruct.new(dotfiles: dotfiles, local_dir: local)
      Pull.new(config)
    end

    context '#pull_dotfiles' do
      it 'should only pull dotfiles that already exist' do
        FileUtils.mkdir_p(pull.config.local_dir)
        FileUtils.touch(File.join(pull.config.local_dir, '.file2'))
        File.write(File.join(pull.config.dotfiles, 'file2'), 'w+') do
          puts "Hello World"
        end
        pull.pull_dotfiles

        expect(FileUtils.compare_file(File.join(pull.config.dotfiles, 'file2'),
                                      File.join(pull.config.local_dir, '.file2'))).to eq true
        # expect(File.read(pull.config.local_dir, '.file2')).to eq "Hello World"
      end
    end
  end
end
