# frozen_string_literal: true

KubsCLI.configure do |config|
  # Where you want the dotfiles to be saved
  config.local_dir = Dir.home

  # Where you have your dotfiles / misc_files saved
  config.config_files = File.join(Dir.home, 'config-files')

  # Where you have you dotfiles
  config.dotfiles = File.join(config.config_files, 'dotfiles')

  # Gnome Terminal Settings
  config.gnome_terminal_settings = File.join(config.config_files,
                                             'gnome_terminal_settings')

end
