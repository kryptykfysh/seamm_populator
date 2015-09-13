# coding: utf-8

require_relative '../db'

module SeammPopulator
  class PopulationSurvey < SeammPopulator::Db
    has_and_belongs_to_many :scientists, join_table: 'survey_scientists'
    belongs_to :marine_area
    belongs_to :species

    def self.seed
      SeammPopulator::MarineArea.all.each do |marine_area|
        species_count = Random.rand(1.10)
        species_ids = SeammPopulator::Species.ids.sample(species_count)
        species_ids.each do |spec_id|
          current_time = 10.years.ago
          latest_time = Faker::Time.between(1.year.ago, Time.now)
          until current_time >= latest_time
            scientist_count = Random.rand(1..5)
            scientist_ids = SeammPopulator::Scientist.ids.sample(scientist_count)
            population = Random.rand(100.0..10_000_000.0)
            SeammPopulator::PopulationSurvey.create!(
              scientists:         SeammPopulator::Scientist.where(id: scientist_ids),
              population:         population,
              species_id:         spec_id,
              marine_area:        marine_area,
              logged_at:          current_time
            )
            current_time = Faker::Time.between(current_time + 6.months, current_time + 5.years)
          end
        end
      end
    end
  end
end
