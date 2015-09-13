# coding: utf-8

require_relative '../db'

module SeammPopulator
  class MarineArea < SeammPopulator::Db
    belongs_to :country
    has_many :area_inspectors
    has_many :catch_limits
    has_many :population_surveys

    def self.seed
      country_ids = SeammPopulator::Country.ids
      count = Random.rand(500..1_000)
      new_records = []
      until new_records.size == count
        new_records << SeammPopulator::MarineArea.new(
          country_id:         country_ids.sample,
          name:               Faker::Company.name
        )
      end
      SeammPopulator::MarineArea.import new_records, validate: false
    end
  end
end
