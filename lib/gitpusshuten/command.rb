module GitPusshuTen
  class Command
    
    ##
    # Initializes the specified command if it exists or
    # errors out when it does not exist in the commands/*.rb
    def initialize(cli, configuration)
      unless available_commands.include?(cli.command)
        GitPusshuTen::Log.error "Command <#{cli.command}> not found."
        exit
      end
      
      "GitPusshuTen::Command::#{cli.command.classify}".constantize.new(cli, configuration)
    end
    
    ##
    # Returns an array of available commands
    def available_commands
      commands_directory.map do |command|
        command.gsub(/\.rb/,'').split('/').last
      end
    end
    
    ##
    # Returns the absolute path to each command (ruby file)
    # insidethe commands directory and returns an array of each entry
    def commands_directory
      Dir[File.expand_path(File.join(File.dirname(__FILE__), 'commands/*.rb'))]
    end
    
  end
end