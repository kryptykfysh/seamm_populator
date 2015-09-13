# coding: utf-8

require_relative '../db'

module SeammPopulator
  class Scientist < SeammPopulator::Db
    belongs_to :person
    has_and_belongs_to_many :population_surveys, join_table: 'survey_scientists'
    has_and_belongs_to_many :catch_limits, join_table: 'catch_limit_scientists'

    def self.seed
      count = Random.rand(100..500)
      person_ids = SeammPopulator::Person.ids.shuffle.take(count)
      new_records = person_ids.map do |p_id|
        SeammPopulator::Scientist.new(person_id: p_id)
      end
      SeammPopulator::Scientist.import new_records, validate: false
    end
  end
end
