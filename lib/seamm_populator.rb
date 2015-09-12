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
  # Your code goes here...
end
