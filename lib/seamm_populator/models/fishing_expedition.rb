# coding: utf-8

require_relative '../db'

module SeammPopulator
  class FishingExpedition < SeammPopulator::Db
    has_and_belongs_to_many :fishermen, join_table: 'fishermen_fishing_expeditions',
                                        class_name: 'SeammPopulator::Fisherman',
                                        foreign_key: 'fishing_expedition_id',
                                        association_foreign_key: 'fisherman_id'
    has_many :catch_reports

    def self.seed
      self.connection.execute(
        'TRUNCATE TABLE fishing_expeditions RESTART IDENTITY CASCADE;'
      )
      new_records = []
      fishers = SeammPopulator::Fisherman.all
      1_000.times do |_i|
        start_at = Faker::Time.between(5.years.ago, 1.day.ago)
        end_at = Faker::Time.between(start_at + 1.day, Time.now)
        new_records << SeammPopulator::FishingExpedition.new(
          start_at:           start_at,
          end_at:             end_at
        )
      end
      SeammPopulator::FishingExpedition.import new_records, validate: false
      SeammPopulator::FishingExpedition.all.each do |expedition|
        fisher_count = Random.rand(1..10)
        expedition.fishermen += fishers.sample(fisher_count)
      end
    end
  end
end
