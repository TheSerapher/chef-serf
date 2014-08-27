# encoding: utf-8
require 'spec_helper'

# Find more details on ChefSpec here: https://github.com/sethvargo/chefspec#readme
describe 'chef-skeleton::default' do
  [{ 'name' => 'centos', 'version' => '6.5' },
   { 'name' => 'debian', 'version' => '7.5' }
  ].each do |platform|
    describe "for #{platform['name']}-#{platform['version']}" do
      before(:all) do
        @chef_run = ChefSpec::Runner.new(platform: platform['name'],
                                         version: platform['version']).converge(described_recipe)
      end
    end
  end
end
