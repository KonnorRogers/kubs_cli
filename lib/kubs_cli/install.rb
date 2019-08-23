# frozen_string_literal: true

module KubsCLI
  # Used to install items from a YAML file
  class Install
    def initialize(yaml_file:)
      @fh = FileHelper.new
      @yaml_file = yaml_file
    end

    # Installs dependencies from a given YAML file
    # @see lib/examples/dependencies.yaml
    # @return Array<String> Returns an array of strings to run via Rake to install
    #   various packages
    def create_dependencies_ary
      hash = @fh.load_yaml(@yaml_file)
      hash.map do |_key, value|
        command = value['command']

        packages = value['packages']
        packages = packages.join("\n") if packages.is_a?(Array)

        "#{command} #{packages}"
      end
    rescue StandardError => e
      KubsCLI.add_error(e: e, msg: "There was an issue with creating a dependencies array from #{@yaml_file}")
    end
  end

  # Installs dependencies from a give yaml_file via Rake.sh
  # @return void
  def install_from_file
    ary = create_dependencies_ary

    ary.each do |command|
      Rake.sh(command.to_s)
    rescue StandardError => e
      KubsCLI.add_error(e: e, msg: "Failed with #{command}")
    end
  end
end
