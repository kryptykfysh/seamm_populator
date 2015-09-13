# coding: utf-8

require_relative '../db'

module SeammPopulator
  class Person < SeammPopulator::Db
    self.table_name = 'people'

    has_many :area_inspectors
    has_many :fishermen,  class_name: 'SeammPopulator::Fisherman',
                          foreign_key: 'person_id'
    has_many :scientists

    def self.seed
      self.connection.execute(
        'TRUNCATE TABLE people RESTART IDENTITY CASCADE;'
      )
      new_records = []
      until new_records.size == 1_000
         new_records << SeammPopulator::Person.new(
          first_name:         Faker::Name.first_name,
          last_name:          Faker::Name.last_name,
          date_of_birth:      Faker::Date.between(80.years.ago, 18.years.ago)
        )
      end
      SeammPopulator::Person.import new_records, validate: false
    end
  end
end
