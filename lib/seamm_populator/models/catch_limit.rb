# coding: utf-8

require_relative '../db'

module SeammPopulator
  class CatchLimit < SeammPopulator::Db
    belongs_to :marine_area
    belongs_to :species
    has_and_belongs_to_many :scientists, join_table: 'catch_limit_scientists'

    def self.seed
      SeammPopulator::MarineArea.all.each do |marine_area|
        species = SeammPopulator::Species.where(
          id: marine_area.population_surveys.pluck(:species_id).uniq
        )
        species.each do |spec|
          current_time = 5.years.ago
          until current_time > 1.year.ago
            scientist_count = Random.rand(1..5)
            scientist_ids = SeammPopulator::Scientist.ids.sample(scientist_count)
            minimum_viable_population = Random.rand(10.0..1_000_000.0)
            max_sustainable_yield = Random.rand(5.0..500_000.0)
            SeammPopulator::CatchLimit.create!(
              scientists:       SeammPopulator::Scientist.where(id: scientist_ids),
              minimum_viable_population:  minimum_viable_population,
              maximum_sustainable_yield:  max_sustainable_yield,
              marine_area:                marine_area,
              species:                    spec,
              start_at:                   current_time
            )
            current_time += 1.year
          end
        end
      end
    end
  end
end
