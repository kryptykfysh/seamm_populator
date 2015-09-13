# coding: utf-8

require_relative '../db'

module SeammPopulator
  class AreaInspector < SeammPopulator::Db
    belongs_to :marine_area
    belongs_to :person
    has_many :fishing_licenses

    def self.seed
      new_records = []
      SeammPopulator::MarineArea.ids.each do |ma_id|
        current_time = 20.years.ago.to_date
        most_recent = Faker::Date.between(5.years.ago, 1.day.ago).to_time
        person_ids = SeammPopulator::Person.ids
        until current_time >= most_recent
          ending = Faker::Date.between(current_time + 1.day, 1.day.ago).end_of_day
          new_records << SeammPopulator::AreaInspector.new(
            marine_area_id:           ma_id,
            person_id:                person_ids.sample,
            start_at:                 current_time,
            end_at:                   ending
          )
          current_time = ending + 1.second
        end
        new_records << SeammPopulator::AreaInspector.new(
          marine_area_id:             ma_id,
          person_id:                  person_ids.sample,
          start_at:                   current_time
        )
      end
      SeammPopulator::AreaInspector.import new_records, validate: false
    end
  end
end
