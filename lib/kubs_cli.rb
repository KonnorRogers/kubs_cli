# frozen_string_literal: true

require 'kubs_cli/file_helper'
require 'kubs_cli/configuration'
require 'kubs_cli/version'
require 'kubs_cli/cli'
require 'kubs_cli/install'
require 'kubs_cli/copy'
require 'kubs_cli/pull'

# Top level class
module KubsCLI
  # Location of default config and dependencies
  EXAMPLES = File.join(File.expand_path(__dir__), 'examples')

  class Error < StandardError; end
  # Specifies class methods
  class << self
    attr_accessor :errors

    # Allows users to specify various configurations based on their liking
    attr_writer :configuration

    # Adds an error to KubsCLI#errors
    # @param e [Error] Error raised
    # @param msg [String] Message to display
    # return Array<Error> Implicitly reutrns the array of errors
    def add_error(e:, msg: nil)
      KubsCLI.errors << e.exception(msg)
    end

    # Prints the errors when finished running
    def print_errors
      KubsCLI.errors.each { |e| puts e.message }
    end

    # Resets errors to a blank array
    def clear_errors
      @errors = []
    end
  end

  # Allows access via KubsCLI.errors
  @errors ||= []
end
