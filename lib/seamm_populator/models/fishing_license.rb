# coding: utf-8

require_relative '../db'

module SeammPopulator
  class FishingLicense < SeammPopulator::Db
    belongs_to :fisherman, class_name: 'SeammPopulator::Fisherman'
    belongs_to :area_inspector

    def self.seed
      new_records = []
      fisherman_ids = SeammPopulator::Fisherman.ids
      area_inspectors = SeammPopulator::AreaInspector.all
      Random.rand(1_000..2_000).times do |_i|
        area_inspector = area_inspectors.sample
        start_at = Faker::Time.between(
          area_inspector.start_at,
          (area_inspector.end_at || Time.now)
        )
        end_at = Faker::Time.between(start_at + 1.year, start_at + 5.years)
        new_records << SeammPopulator::FishingLicense.new(
          fisherman_id:       fisherman_ids.sample,
          area_inspector:     area_inspector,
          start_at:           start_at,
          end_at:             end_at
        )
      end
      SeammPopulator::FishingLicense.import new_records, validate: false
    end
  end
end
