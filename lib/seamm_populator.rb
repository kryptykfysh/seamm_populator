# coding: utf-8

require_relative 'seamm_populator/version'
require_relative 'seamm_populator/db'
Dir[
  File.join(
    File.dirname(__FILE__),
    'seamm_populator/models/*.rb'
  )
].each { |file| require file }

module SeammPopulator
  SEED_SEQUENCE = [
    SeammPopulator::Country,
    SeammPopulator::Species,
    SeammPopulator::Person,
    SeammPopulator::Fisherman,
    SeammPopulator::Scientist,
    SeammPopulator::MarineArea,
    SeammPopulator::AreaInspector,
    SeammPopulator::PopulationSurvey,
    SeammPopulator::CatchLimit,
    SeammPopulator::FishingLicense,
    SeammPopulator::Quota,
    SeammPopulator::FishingExpedition,
    SeammPopulator::CatchReport
  ]

  def self.seed
    SEED_SEQUENCE.each(&:seed)
  end
end
