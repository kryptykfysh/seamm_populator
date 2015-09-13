# coding: utf-8

require_relative '../db'

module SeammPopulator
  class Fisherman < SeammPopulator::Db
    self.table_name = 'fishermen'

    belongs_to :person
    has_many :fishing_licenses
    has_many :quotas
    has_and_belongs_to_many :fishing_expeditions, join_table: 'fishermen_fishing_expeditions',
      class_name: 'SeammPopulator::FishingExpedition',
      foreign_key: 'fisherman_id',
      association_foreign_key: 'fishing_expedition_id'

    def self.seed
      count = Random.rand(100..500)
      person_ids = SeammPopulator::Person.ids.shuffle.take(count)
      new_records = person_ids.map do |p_id|
        SeammPopulator::Fisherman.new(person_id: p_id)
      end
      SeammPopulator::Fisherman.import new_records, validate: false
    end
  end
end
