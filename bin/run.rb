require_relative '../config/environment'
require_relative '../app/cli.rb'

cli = CLI.new

cli.welcome

cli.main_menu

