# coding: utf-8

require_relative '../db'

module SeammPopulator
  class Quota < SeammPopulator::Db
    self.table_name = 'quotas'

    belongs_to :fisherman
    belongs_to :area_inspector
    belongs_to :species

    def self.seed
      new_records = []
      inspector_ids = SeammPopulator::AreaInspector.ids
      fisherman_ids = SeammPopulator::Fisherman.ids
      species_ids = SeammPopulator::Species.ids
      1_000.times do |_i|
        new_records << SeammPopulator::Quota.new(
          fisherman_id:       fisherman_ids.sample,
          area_inspector_id:  inspector_ids.sample,
          species_id:         species_ids.sample,
          start_at:           Faker::Time.between(5.years.ago, Time.now),
          catch_limit:        Random.rand(1_000.0..500_000.0)
        )
      end
      SeammPopulator::Quota.import new_records, validate: false
    end
  end
end
