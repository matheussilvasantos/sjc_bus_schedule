# frozen_string_literal: true

class SJCBusSchedule::Schedule
  attr_reader :period, :hours, :references

  def initialize(period:, hours:, references:)
    @period = period
    @hours = hours
    @references = references
  end
end
