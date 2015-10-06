#!/usr/bin/env ruby
require 'gpgme'

# http://tools.ietf.org/html/rfc4880

unless ENV['GPG_AGENT_INFO']
  $stderr.puts("gpg-agent is not running.  See the comment in #{$0}.")
  exit(1)
end

plain = File.open('ipsums', "r").read

file = File.open("signed.sec-for_dear_john","w+")
crypto = GPGME::Crypto.new(:armor => true)
#crypto.encrypt plain, sign: true, recipients: "kenner.hp@gmail.com", output: file

crypto.encrypt plain, sign: true, recipients: "john@doe.foo", output: file

decrypto = GPGME::Crypto.new(:armor => true)

encrypted_data = File.open("signed.sec", "r").read
# encrypted_cipher = GPGME::Data.new(encrypted_data)

# crypto.decrypt encrypted_cipher, output: decrypted_file

plain_text = decrypto.decrypt encrypted_data do |signature|
  puts signature
  raise "Signature could not be verified" unless signature.valid?
end

decrypted_file = File.open("plain.unsec","w+").write(plain_text)
