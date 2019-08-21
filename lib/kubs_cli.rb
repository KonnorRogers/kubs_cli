# frozen_string_literal: true

require 'kubs_cli/version'

# Top level class
module KubsCLI
  class Error < StandardError; end

  # Speciies class methods
  class << self
    attr_accessor :errors

    # Adds an error to KubsCLI#errors
    # @param e [Error]
    def add_error(e:, msg: nil)
      KubsCLI << e.exception(msg)
    end

    # Prints the errors when finished running
    def print_errors
      KubsCli << errors.each { |e| puts e.message }
    end
  end

  @errors ||= []
end
