# coding: utf-8

require_relative '../db'

module SeammPopulator
  class CatchReport < SeammPopulator::Db
    belongs_to :fishing_expedition
    belongs_to :quota
    has_one :species, through: :quota

    def self.seed
      self.connection.execute(
        'TRUNCATE TABLE catch_reports RESTART IDENTITY CASCADE;'
      )
      new_records = []
      quotas = SeammPopulator::Quota.all
      SeammPopulator::FishingExpedition.all.each do |expedition|
        report_count = Random.rand(1..5)
        report_count.times do |_j|
          quota = quotas.sample
          new_records << SeammPopulator::CatchReport.new(
            catch_amount:           Random.rand(1.0..10_000.0),
            fishing_expedition:     expedition,
            logged_at:              Faker::Time.between(quota.start_at, quota.start_at + 1.year),
            quota:                  quota
          )
        end
      end
      SeammPopulator::CatchReport.import new_records, validate: false
    end
  end
end
