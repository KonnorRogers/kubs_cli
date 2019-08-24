# frozen_string_literal: true

module KubsCLI
  # Used to pull items into your config-files repo
  class Pull
    attr_writer :config

    def initialize(config = KubsCLI.configuration)
      @config = config
      @fh = FileHelper.new
    end

    # @see #pull_dotfiles
    # @see #pull_gnome_terminal_settings
    def pull_all
      pull_dotfiles
      pull_gnome_terminal_settings
    end

    # Pulls dotfiles into your dotfiles inside your repo
    def pull_dotfiles
      Dir.children(@config.local_files).each do |local|
        Dir.children(@config.dotfiles).each do |remote|
          next if local != ".#{remote}"

          local = File.join(@config.local_files, local)
          remote = File.join(@config.dotfiles, remote)

          @fh.copy(from: local, to: remote)
        end
      end
    end

    # Pulls gnome_terminal_settings into your dotfiles inside your repo
    def pull_gnome_terminal_settings
      # This is where dconf stores gnome terminal
      gnome_dconf = '/org/gnome/terminal/'

      orig_remote_contents = File.read(@config.gnome_terminal_settings)

      Rake.sh("dconf dumb #{gnome_dconf} > #{@config.gnome_terminal_settings}")
    rescue RuntimeError => e
      add_error(e: e, msg: 'Ran into issues dumping gnome terminal settings')

      # if dconf errors, it will erase the config file contents
      # So this protects against that
      File.write(@config.gnome_terminal_settings, orig_remote_contents)
    end
  end
end
