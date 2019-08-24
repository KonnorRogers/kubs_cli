# frozen_string_literal: true

module KubsCLI
  RSpec.describe FileHelper do
    let(:fh) { FileHelper.new }

    context '#copy' do
      it 'Should add an error to KubsCli if no from file found' do
        fh.copy(from: 'fake-file', to: 'fake-file')
        expect(KubsCLI.errors.length).to eq 1
        KubsCLI.clear_errors
      end

      it 'Should copy if the file is not a directory' do
        from = File.join(TEST_FILES, 'file1')
        to = File.join(TEST_FILES, 'fake-file1')
        fh.copy(from: from, to: to)

        expect(FileUtils.compare_file(to, from)).to eq(true)
        FileUtils.rm(to)
      end

      it 'Should copy the entire contents of a directory' do
        from = File.join(TEST_FILES, 'dir')
        to = File.join(TEST_FILES, 'fake-dir')

        fh.copy(from: from, to: to)

        from_files = Dir.children(from)
        to_files = Dir.children(File.join(to, 'dir'))
        expect(from_files).to match_array(to_files)

        FileUtils.rm_rf(to)
      end
    end

    context '#mkdirs' do
      it 'Should make multiple dirs' do
        dirs = %w[a b c]
        fh.mkdirs(dirs)

        dirs.each { |dir| FileUtils.rm_rf dir }
      end

      it 'Should not error if the dir exists' do
        dir = 'a'
        fh.mkdirs(dir)
        fh.mkdirs(dir)
        FileUtils.rm_rf(dir)
      end
    end

    context '#load_yaml' do
      it 'Should error if the file does not exist' do
        fh.load_yaml('nonexistent-file')
        expect(KubsCLI.errors.length).to eq 1
        KubsCLI.clear_errors
      end

      it 'Should return a hash of values' do
        root = File.expand_path('../', File.dirname(__FILE__))
        default_dep = File.join(root, 'lib', 'examples', 'dependencies.yaml')
        hash = fh.load_yaml(default_dep)

        expect(hash).to_not be_nil
        expect(hash).to be_an_instance_of(Hash)
      end
    end
  end
end
