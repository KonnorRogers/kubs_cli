# frozen_string_literal: true

require 'rake'

module KubsCLI
  class Copy
    def intitialize(config: KubsCLI.configuration)
      @fh = FileHelper.new
      @config = config
    end

    def copy_all
      copy_gnome_terminal_settings
      copy_dotfiles
    end

    def copy_dotfiles
      Dir.children(@config.dotfiles).each do |file|
        config_file = File.join(@config.dotfiles, file)
        local_file = File.join(@config.local, ".#{file}")

        @fh.copy(from: config_file, to: local_file)
      end
    end

    def copy_gnome_terminal_settings
      # This is the ONLY spot for gnome terminal
      gnome_path = '/org/gnome/terminal/'
      gnome_file = File.join(config.gnome_terminal_settings)

      unless File.exist?(gnome_file)
        add_error(e: KubsCLI::Error, msg: "Could not find #{gnome_file}")
        return
      end

      dconf_load = "dconf load #{gnome_path} < #{config.misc_files}/gnome_terminal_settings"
      Rake.sh(dconf_load)
    rescue RuntimeError => e
      add_error(e: e, msg: 'Unable to copy gnome settings')
    end
  end
end