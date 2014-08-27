# encoding: utf-8
require 'resolv'

actions :create, :delete
default_action :create

attribute :name, name_attribute: true, kind_of: String,
          required: true
attribute :cookbook, kind_of: String
