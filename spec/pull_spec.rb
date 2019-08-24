# frozen_string_literal: true

require 'ostruct'
module KubsCLI
  RSpec.describe Pull do

    let(:pull) do
      local = File.join(File.expand_path(__dir__), 'local_test_files')
      dotfiles = File.join(File.expand_path(__dir__), 'test_files')
      config = OpenStruct.new(dotfiles: dotfiles, local_dir: local)
      Pull.new(config)
    end

    context '#pull_dotfiles' do
      it 'should only pull dotfiles that already exist' do
        pull.pull_dotfiles
      end
    end
  end
end
