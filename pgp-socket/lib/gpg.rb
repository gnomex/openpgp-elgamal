require 'rubygems'
require 'eventmachine'
require 'gpgme'
#require 'yaml'
#require 'json'

require_relative 'gpg/gpg_tcp_server'
require_relative 'gpg/crypto'

module CRY
  VERSION = "0.1.0"

  # Run the event machine and start the server socket
  def CRY.start_server
    EventMachine.run do
      # hit Control + C to stop
      Signal.trap("INT")  { EventMachine.stop }
      Signal.trap("TERM") { EventMachine.stop }

      puts "Starting the server..."
      
      EventMachine.start_server('0.0.0.0', 10000, SDServer)
    end
  end
end
