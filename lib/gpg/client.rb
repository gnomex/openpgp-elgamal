require 'socket'

class Client
  def initialize( server )
    @server = server
    @request = nil
    @response = nil
    listen
    send
    @request.join
    @response.join
  end

  def listen
    @response = Thread.new do
      loop {
        begin
          msg = @server.gets.chomp
          puts "#{msg}"
        rescue Exception => e
          puts e.inspect
        end
      }
    end
  end

  def send
    @request = Thread.new do
      loop {
        msg = $stdin.gets.chomp
        @server.puts( msg )
      }
    end
  end
end

#s = TCPSocket.new 'localhost', 10000
server = TCPSocket.open "localhost", 10000 
Client.new( server )
