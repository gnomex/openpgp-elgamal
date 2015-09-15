module CRY
  # Eventmachine runner
  class SDServer < EM::Connection
    attr_reader :queue

    def initialize(*args)
      super

      @queue = Array.new
    end

    #
    # EventMachine handlers
    #

    # Handle the TCP SYN flag
    def post_init
      puts "TCP connection attempt completed successfully and a new client has connected."
      send_line("-> Welcome abord bro")
    end

    # Handle the TCP FIN flag
    def unbind
      send_line "TCP connection closed successfully. Come back soon"
      puts "A client leaves us"
    end

    # Handle the TCP PUSH flag
    def receive_data(row)
      puts "Received #{row.bytesize.to_s} bytes from someplace"
      handle_raw_data row
      puts ["Queue", @queue.size].join(' ')
    end

    #
    # Actions handling
    #

    def handle_actions(hash)
      case hash['action']
      when "create" then handle_create(hash)
      when "show" then handle_show(hash)
      when "delete" then handle_delete(hash)
      when "marmota" then handle_close
      when "status" then status
      else self.send_line "What? I cannot understand you, bro!"
      end
    end

    def handle_raw_data(data)
      begin
        if @queue.empty?
          @queue.push data if data.include?("-----BEGIN PGP MESSAGE-----") #Start buffer
        else
          @queue.push data
          handle_pgp if data.include?("-----END PGP MESSAGE-----")
        end
      rescue Exception => error
        send_line "What? I cannot understand you, bro!"
        puts "Error #{error.inspect}"
      end
    end

    #
    # Helpers
    #
   
    # Sent data
    def send_line(line)
      self.send_data("#{line}\n")
    end

    private
    def handle_pgp
      key = @queue.join('').to_s
      send_line "Decrypting #{key.bytesize} bytes"

      Crypto.decrypt key

      @queue.clear
    end

    # Close a connection
    def handle_close
      send_line "Closing the server. Come back later!"
      self.close_connection
    end
  end
end