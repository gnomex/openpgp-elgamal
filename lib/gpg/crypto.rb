require 'gpgme'

module CRY
  class Crypto
    def self.encrypt(data_to_encrypt)
      crypto = GPGME::Crypto.new(:armor => true)
      crypto.encrypt data_to_encrypt, sign: true, recipients: "john@doe.foo"
    end

    def self.decrypt(signed_message)
      begin
        decrypto = GPGME::Crypto.new(:armor => true)
        encrypted_data = GPGME::Data.new(signed_message)

        #plain_text = decrypto.decrypt encrypted_data do |signature|
         # puts signature
          # raise "Signature could not be verified" unless signature.valid?
        #end

        decrypto.decrypt encrypted_data
      rescue Exception => e
        puts "Ops"
        puts e.inspect
      end
    end
  end
end