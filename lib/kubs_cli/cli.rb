module KubsCLI
  class CLI < Thor
    desc 'version', 'prints the kubs-cli version information'
    def version
      puts "kubs-cli version #{VpsCli::VERSION}"
    end
    map %w[-v --version] => :version

    desc 'init', 'initializes the ~/.kubs dir'
    def init
      puts "Adding .kubs to #{Dir.home}..."
    end
  end
end
