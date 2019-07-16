# frozen_string_literal: true

class SJCBusSchedule::Bus
  attr_reader :number, :name, :direction, :itinerary, :note, :schedules

  def initialize(number:, name:, direction:, itinerary:, note:, schedules:)
    @number = number
    @name = name
    @direction = direction
    @itinerary = itinerary
    @note = note
    @schedules = schedules
  end
end
