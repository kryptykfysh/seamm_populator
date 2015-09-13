# coding: utf-8

require 'active_record'
require 'activerecord-import'
require 'faker'
require 'pg'
require 'yaml'

module SeammPopulator
  class Db < ActiveRecord::Base
    @config = YAML.load_file(
      File.join(
        File.dirname(__FILE__),
        '../../database.yml'
      )
    )

    class << self; attr_reader :config; end;

    self.abstract_class = true
    establish_connection @config
  end
end
