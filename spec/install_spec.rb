# frozen_string_literal: true

RSpec.describe KubsCLI::Install do
  root = File.expand_path('../', File.dirname(__FILE__))
  DEPENDENCIES_FILE = File.join(root, 'lib',
                                'examples', 'dependencies.yaml')
  let(:install) { KubsCLI::Install.new(yaml_file: DEPENDENCIES_FILE) }

  context '#create_dependencies_ary' do
    it "Should create an array in the form \#{command} \#{value}" do
      ary = install.create_dependencies_ary
      expect(ary).to be_an_instance_of(Array)
    end

    it 'should include npm install -g' do
      ary = install.create_dependencies_ary
      expect(ary).to include(/(npm install -g)/)
    end

    it 'should include sudo apt install -y tmux' do
      ary = install.create_dependencies_ary
      expect(ary).to include(/(sudo apt install -y)/)
    end
  end
end
