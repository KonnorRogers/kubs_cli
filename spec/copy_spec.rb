RSpec.describe KubsCLI::Copy do
  KubsCLI.configure do |c|
    c.dotfiles = 'test_files'
    c.local_dir = 'local_test_files'
  end

  let(:copy) { KubsCLI.copy.new }

  context "#copy_dotfiles" do
    it 'Should turn non dotfiles into dotfiles' do
    end
  end
end
