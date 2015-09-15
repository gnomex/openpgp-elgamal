#!/usr/bin/env ruby

require 'socket'

require_relative 'gpg/client'

Client.new( TCPSocket.open('192.168.122.137', 10000) )
