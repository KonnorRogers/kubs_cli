# frozen_string_literal: true

require 'thor'

module KubsCLI
  class CLI < Thor
    class_option(:config, aliases: :c,
                          default: File.join(Dir.home, '.kubs', 'config.rb'))

    desc 'version', 'prints the kubs-cli version information'
    def version
      puts "kubs-cli version #{KubsCLI::VERSION}"
    end
    map %w[-v --version] => :version

    # desc 'init [-c CONFIG_DIRECTORY]', 'initializes the ~/.kubs dir'
    desc 'init', 'initializes the ~/.kubs dir'
    def init
      puts "Adding .kubs to #{Dir.home}..."
      KubsCLI.create_config_dir
    end

    # desc 'copy [-d DOTFILES -g GNOME_TERMINAL_SETTINGS]', 'copies from KUBS_DOTFILES/* to $HOME/*'
    desc 'copy', 'copies from KUBS_DOTFILES/* to $HOME/*'
    def copy
      run_command { KubsCLI::Copy.new.copy_all }
    end

    # desc 'pull [-d DOTFILES -g GNOME_TERMINAL_SETTINGS]', 'copies to your config repo'
    desc 'pull', 'copies to your config repo'
    def pull
      run_command { KubsCLI::Pull.new.pull_all }
    end

    desc 'install', 'installs from .kubs/dependencies.yaml'
    def install
      run_command { KubsCLI::Install.new.install_all }
    end

    # desc 'git push [-r CONFIG_FILES_REPO]', 'pushes your config_files upstream'
    desc 'git_push', 'pushes your config_files upstream'
    def git_push
      message ||= 'auto push files'

      swap_dir do
        Rake.sh('git add -A')
        Rake.sh("git commit -m \"#{message}\"")
        Rake.sh('git push')
      rescue RuntimeError => e
        KubsCLI.add_error(e: e, msg: 'Something went wrong pushing your repo')
      end
    end

    # desc 'git pull [-r CONFIG_FILES_REPO]', 'pulls your config_files downstream'
    desc 'git_pull', 'pulls your config_files downstream'
    def git_pull
      swap_dir { Rake.sh('git pull') }
    rescue RuntimeError => e
      KubsCLI.add_error(e: e, msg: 'Ran into an error pulling down your repo')
    end

    desc 'git_status', 'provides the status of your config_files'
    def git_status
      swap_dir { Rake.sh('git status') }
    end

    no_commands do
      def swap_dir
        KubsCLI.load_configuration
        Rake.cd(KubsCLI.configuration.config_files)
        yield
      end

      def run_command
        KubsCLI.load_configuration
        yield
        KubsCLI.print_errors
      end
    end
  end
end
