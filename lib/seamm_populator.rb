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
    SeammPopulator::Species
  ]

  def self.seed
    SEED_SEQUENCE.each(&:seed)
  end
end
