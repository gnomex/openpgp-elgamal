require 'gpgme'

module CRY
  class Crypto
    def ecrypt
      plain = File.open('mussum_ipsum', "r").read

      file = File.open("signed.sec","w+")
      crypto = GPGME::Crypto.new(:armor => true)
      crypto.encrypt plain, sign: true, recipients: "kenner.hp@gmail.com", output: file
    end

    def self.decrypt(signed_message)
      begin
        decrypto = GPGME::Crypto.new(:armor => true)

        #encrypted_data = File.open("signed.sec", "r").read
        encrypted_data = GPGME::Data.new(signed_message)

        # crypto.decrypt encrypted_cipher, output: decrypted_file

        plain_text = decrypto.decrypt encrypted_data do |signature|
          puts signature
          raise "Signature could not be verified" unless signature.valid?
        end

        puts plain_text

        #decrypted_file = File.open("plain.unsec","w+").write(plain_text) 
      rescue Exception => e
        puts e.inspect
      end
    end
  end
end