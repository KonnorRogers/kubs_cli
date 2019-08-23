# frozen_string_literal: true

require 'kubs_cli/version'

# Top level class
module KubsCLI
  class Error < StandardError; end
  # Specifies class methods
  class << self
    attr_accessor :errors

    # Adds an error to KubsCLI#errors
    # @param error [Error]
    # return Array<Error> Implicitly reutrns the array of errors
    def add_error(error:, msg: nil)
      KubsCLI.errors << error.exception(msg)
    end

    # Prints the errors when finished running
    def print_errors
      KubsCli << errors.each { |e| puts e.message }
    end
  end

  # Allows access via KubsCLI.errors
  @errors ||= []
end
