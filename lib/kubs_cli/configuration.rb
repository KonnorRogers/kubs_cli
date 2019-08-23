module KubsCLI
  # Used for keeping a consistent config across the entire project
  class Configuration
    # local files
    attr_accessor :local_dir

    # remote files to be used
    attr_accessor :config_files, :misc_files, :dotfiles

    def initialize
      # Values for items to be copied to
      @local_dir = Dir.home

      # values for items to be copied from
      # set to nil so that someone must set a path
      @config_files = nil
      @dotfiles = nil
      @misc_files = nil
    end
  end

  def self.configure
    @configuration ||= Configuration.new
    yield(configuration)
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset_configuration
    @configuration = Configuration.new
  end

  def self.load_configuration(file = File.join(Dir.home, '.vps_cli'))
    msg = 'Unable to location a configuration file. The default location is'
    msg += '$HOME/.kubs/config.rb'
    msg += "\nTo create a standard default config, run 'kubs init'"

    raise Exception, msg unless File.exist?(file)

    load file
  end

  def self.create_configuration(path = File.join(Dir.home, '.kubs'))
    puts "Creating a default configuration files @ #{file}"

    create_config_dir(path)
  end

  private

  def create_config_dir(path = File.join(Dir.home, '.kubs'))
    mkdirs(path)
    copy(from: EXAMPLES, to: path)
  end
end
