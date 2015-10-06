module CRY
  # Eventmachine runner
  class SDServer < EM::Connection
    attr_reader :queue

    @@debug = false

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
      puts "[INFO] Chunk{ #{data}  } \n" if @@debug

      begin
        if @queue.empty?
          @queue.push data if data.include?("-----BEGIN PGP MESSAGE-----") #Start buffer

          handle_pgp if data.include?("-----END PGP MESSAGE-----")
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

      plain = Crypto.decrypt key

      @queue.clear

      send_line "--- MESSAGE FROM SOCKET ---"
        puts "[INFO] -- MESSAGE --" if @@debug

      send_line plain 
        puts "[INFO] -- #{plain}" if @@debug

      send_line "--- END OF MESSAGE ---"
        puts "[INFO] -- END OF MESSAGE --" if @@debug
    end

    # Close a connection
    def handle_close
      send_line "Closing the server. Come back later!"
      self.close_connection
    end
  end
end