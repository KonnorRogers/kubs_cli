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
      dotfiles = @config.dotfiles
      local_dir = @config.local_dir

      shared_dotfiles(dotfiles, local_dir) do |remote, local|
        copy_files(local, remote)
      end
    end

    def copy_files(orig_file, new_file)
      # @fh.copy(from: orig_file, to: new_file)
      return @fh.copy(from: orig_file, to: new_file) unless File.directory?(new_file)
      return @fh.copy(from: orig_file, to: new_file) unless File.directory?(orig_file)

      Dir.each_child(orig_file) do |o_file|
        Dir.each_child(new_file) do |n_file|
          next unless o_file == n_file

          o_file = File.join(File.expand_path(orig_file), o_file)
          n_file = File.expand_path(new_file)

          @fh.copy(from: o_file, to: n_file)
        end
      end
    end

    def shared_dotfiles(dotfiles, local_dir)
      Dir.each_child(dotfiles) do |remote_file|
        Dir.each_child(local_dir) do |local_file|
          next unless local_file == ".#{remote_file}"

          remote_file = File.join(dotfiles, remote_file)
          local_file = File.join(local_dir, local_file)
          yield(remote_file, local_file)
        end
      end
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
