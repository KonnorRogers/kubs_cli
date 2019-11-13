# frozen_string_literal: true

module KubsCLI
  # Used to install items from a YAML file
  class Install
    def initialize(config = KubsCLI.configuration)
      @fh = FileHelper.new
      @dependencies = config.dependencies
      @packages = config.packages
    end

    def install_dependencies
      install_from_file(@dependencies)
    end

    def install_packages
      install_from_file(@packages)
    end

    # Installs dependencies from a given YAML file
    # @see lib/examples/dependencies.yaml
    # @return Array<String> Returns an array of strings to run via Rake to install
    #   various packages
    def create_ary_from_yaml(file)
      hash = @fh.load_yaml(file)
      hash.map do |_key, value|
        command = value['command']

        packages = value['packages']
        packages = packages.join(' ') if packages.is_a?(Array)

        "#{command} #{packages}"
      end
    rescue StandardError => e
      msg = "There was an issue with creating a dependencies array from #{file}"
      KubsCLI.add_error(e: e, msg: msg)
    end

    # Installs dependencies from a give yaml_file via Rake.sh
    # @return void
    def install_from_file(file)
      ary = create_ary_from_yaml(file)

      ary.each do |command|
        Rake.sh(command.to_s)
      rescue StandardError => e
        KubsCLI.add_error(e: e, msg: "Failed with #{command}")
      end
    end
  end
end
