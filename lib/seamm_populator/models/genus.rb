# coding: utf-8

require_relative '../db'

module SeammPopulator
  class Genus < SeammPopulator::Db
    self.table_name = 'genera'
    has_many :species
  end
end
