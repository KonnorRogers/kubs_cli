require 'thor'

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

    desc 'copy [-d DOTFILES -g GNOME_TERMINAL_SETTINGS]', 'copies from KUBS_DOTFILES/* to $HOME/*'
    def copy

    end

    desc 'pull [-d DOTFILES -g GNOME_TERMINAL_SETTINGS]', 'copies to your config repo'
    def pull

    end

    desc 'git push [-c CONFIG_FILES]', 'pushes your config_files upstream'
    def git_push
    end

    desc 'git pull [-c CONFIG_FILES]', 'pulls your config_files downstream'
    def git_pull
    end
  end
end
