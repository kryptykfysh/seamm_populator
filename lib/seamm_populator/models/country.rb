# coding: utf-8

require 'csv'
require_relative '../db'

module SeammPopulator
  class Country < SeammPopulator::Db
    @source_file = File.expand_path(
      '../../source_data/countries.csv',
      __FILE__
    )

    has_many :marine_areas

    def self.seed
      self.connection.execute(
        'TRUNCATE TABLE countries RESTART IDENTITY CASCADE;'
      )
      new_records = []
      CSV.foreach(
        @source_file,
        headers: true,
        header_converters: :symbol,
        converters: [:all]
      ) do |row|
        new_records << self.new(
          name: row.to_hash[:country_or_dependent_territory]
        )
      end
      self.import new_records, validate: false
    end
  end
end
