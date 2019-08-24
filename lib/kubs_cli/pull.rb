# frozen_string_literal: true

module KubsCLI
  # Used to pull items into your config-files repo
  class Pull
    attr_accessor :config

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
      # Dir.each_child(@config.local_dir) do |local|
      #   Dir.each_child(@config.dotfiles) do |remote|
      #     next if local != ".#{remote}"

      #     local = File.join(@config.local_dir, local)
      #     remote = File.join(@config.dotfiles, remote)

      #     @fh.copy(from: local, to: remote)
      #   end
      # end
      # walk recursively

      local_files = files_only(@config.local_dir)
      remote_files = files_only(@config.dotfiles)

      local_files.each do |l_file|
        remote_files.each do |r_file|
          next if l_file != ".#{r_file}"

          @fh.copy(from: local, to: remote)
        end
      end
    end

    def files_only(directory)
      Dir["#{directory}/**/*"].reject { |f| File.directory?(f) }
    end

    # Pulls gnome_terminal_settings into your dotfiles inside your repo
    def pull_gnome_terminal_settings
      # This is where dconf stores gnome terminal
      gnome_dconf = '/org/gnome/terminal/'

      orig_remote_contents = File.read(@config.gnome_terminal_settings)

      Rake.sh("dconf dumb #{gnome_dconf} > #{@config.gnome_terminal_settings}")
    rescue RuntimeError => e
      KubsCLI.add_error(e: e, msg: 'Ran into issues dumping gnome terminal settings')

      # if dconf errors, it will erase the config file contents
      # So this protects against that
      File.write(@config.gnome_terminal_settings, orig_remote_contents)
    end
  end
end
