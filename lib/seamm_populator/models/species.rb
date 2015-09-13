# coding: utf-8

require 'csv'
require 'set'
require_relative '../db'

module SeammPopulator
  class Species < SeammPopulator::Db
    @source_file = File.expand_path(
      '../../source_data/fish_list.csv',
      __FILE__
    )

    belongs_to :genus
    has_many :population_surveys
    has_many :catch_limits
    has_many :quotas

    def self.seed
      add_genera
      add_species
    end

    private

    def self.add_genera
      self.connection.execute(
        'TRUNCATE TABLE genera RESTART IDENTITY CASCADE;'
      )
      new_records = genus_hash.keys.map do |k|
        SeammPopulator::Genus.new(name: k)
      end
      SeammPopulator::Genus.import new_records, validate: false
    end

    def self.add_species
      g_map = genus_map
      new_records = genus_hash.each_with_object([]) do |(genus_name, species_array), new_species|
        genus_id = g_map[genus_name]
        species_array.each do |species_hash|
          new_species << SeammPopulator::Species.new(
            genus_id:     genus_id,
            name:         species_hash[:species],
            caab:         species_hash[:caab]
          )
        end
        new_species
      end
      SeammPopulator::Species.import new_records, validate: false
    end

    def self.genus_map
      Hash[SeammPopulator::Genus.pluck(:name, :id)]
    end

    def self.raw_data
      CSV.read(
        @source_file,
        headers: true,
        header_converters: :symbol,
        skip_blanks: true,
        converters: [:all]
      ).map(&:to_hash).reject { |x| [:scientific_name, :caab_code].any? { |y| x[y].nil? } }
    end

    def self.genus_hash
      raw_data.each_with_object({}) do |row, result|
        caab = row[:caab_code].gsub(/\s+/, '').to_i
        genus_array = row[:scientific_name].gsub(/\(\.*\)/, '').split(/,|\&/).map do |pair|
          pair.gsub(' spp.', '').strip.split(/\s+/, 2)
        end
        genus_array.each do |species_array|
          genus = species_array.first
          species = species_array.size > 1 ? species_array[1] : '- undifferentiated'
          current_genus = result.fetch(genus, Set.new)
          current_genus << { species: species, caab: caab }
          result[genus] = current_genus
        end
        result
      end
    end
  end
end
