# frozen_string_literal: true

require 'rake'
require 'yaml'

module KubsCLI
  # Used for copying files within kubs_cli
  class FileHelper
    # Copies a file or directory from one spot to another
    # @param from [Dir, File] Where to copy from
    # @param to [Dir, File] Where to copy to
    # @return void
    def copy(from:, to:)
      return if file_does_not_exist(from)

      return Rake.cp(from, to) unless File.directory?(from)

      Rake.mkdir_p(to) unless Dir.exist?(to)
      Rake.cp_r(Dir["#{from}/*"], to)
    end

    # Creates dirs using Rake.mkdir_p if it does not exist
    # @param dirs [Array<String>] The names of the dirs to create
    # @return void
    def mkdirs(*dirs)
      dirs.flatten.each { |dir| Rake.mkdir_p(dir) unless Dir.exist?(dir) }
    end

    # Loads a YAML file
    # @param file [File] Yaml formatted file
    # @return [Hash] Returns a hash from a yaml document
    def load_yaml(file)
      YAML.load_file(file)
    rescue StandardError => e
      KubsCLI.add_error(e: e, msg: "Unable to parse your YAML file - #{file}")
    end

    private

    #:nodoc:
    def file_does_not_exist(file)
      return false if File.exist?(file)

      KubsCLI.add_error(e: KubsCLI::Error, msg: "#{file} does not exist")
      true
    end
  end
end
