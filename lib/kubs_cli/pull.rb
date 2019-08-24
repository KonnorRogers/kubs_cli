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
      local = @config.local_dir
      remote = @config.dotfiles
      same_files(local: local, remote: remote).each do |ary|
        # local
        l = ary[0]
        # remote
        r = ary[1]

        unless File.directory?(local) || File.directory?(remote)
          @fh.copy(from: l, to: r)
          next
        end

        same_files(local: l, remote: r, remote_prefix: '').each do |nested_ary|
          nested_local = nested_ary[0]
          nested_remote = nested_ary[1]

          @fh.copy(from: nested_local, to: nested_remote)
        end
      end
    end

    def same_files(local:, remote:, remote_prefix: '.')
      ary = []

      Dir.each_child(local) do |l_file|
        Dir.each_child(remote) do |r_file|
          next if l_file != "#{remote_prefix}#{r_file}"

          ary << [l_file, r_file]
        end
      end
      ary
    end

    def files_only(directory)
      Dir["#{directory}/**/*"].reject { |f| File.directory?(f) }
    end

    # Pulls gnome_terminal_settings into your dotfiles inside your repo
    def pull_gnome_terminal_settings
      # This is where dconf stores gnome terminal
      gnome_dconf = '/org/gnome/terminal/'

      orig_remote_contents = File.read(@config.gnome_terminal_settings)

      Rake.sh("dconf dump #{gnome_dconf} > #{@config.gnome_terminal_settings}")
    rescue RuntimeError => e
      KubsCLI.add_error(e: e, msg: 'Ran into issues dumping gnome terminal settings')

      # if dconf errors, it will erase the config file contents
      # So this protects against that
      File.write(@config.gnome_terminal_settings, orig_remote_contents)
    end
  end
end
