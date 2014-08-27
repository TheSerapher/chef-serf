# encoding: utf-8
require 'resolv'

actions :join, :leave
default_action :join

attribute :ipv4_address, name_attribute: true, kind_of: String,
          required: true, regex: Resolv::IPv4::Regex
