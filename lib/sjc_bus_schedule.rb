# frozen_string_literal: true

require "sjc_bus_schedule/version"
require "sjc_bus_schedule/crawler"

module SJCBusSchedule
  def self.find_by(query)
    Crawler.new(query: query).process
  end

  def self.all
    Crawler.new.process
  end
end
