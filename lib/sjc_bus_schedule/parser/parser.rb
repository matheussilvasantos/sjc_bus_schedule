# frozen_string_literal: true

require "nokogiri"

module SJCBusSchedule::Parser
  class Bus
    def initialize(doc:)
      @doc = doc
    end

    def number
      @number ||= @doc.css("span[id*=NumeroLinha]").first.text.strip
    end

    def name
      @name ||= @doc.css("span[id*=NomeLinha]").first.text.strip
    end

    def direction
      @direction ||= @doc.css("span[id*=Sentido]").first.text.strip
    end

    def itinerary
      @itinerary ||= @doc.css("span[id*=Itinerario]").first.text.split(/[-–]/).map(&:strip)
    end

    def note
      @note ||= @doc.css("span[id*=Observacao]").first.text.strip
    end
  end

  class Schedules
    def initialize(doc:)
      @doc = doc
    end

    def schedules
      @schedules ||= @doc.css("span[id*=Resultado] > table").map do |schedule|
        { period: period(schedule), hours: hours(schedule) }
      end
    end

    def references
      @references ||= @doc.css("span[id*=Resultado] .textosm").children.map(&:text).reject { |it| it.empty? }
    end

    private

    def period(schedule)
      schedule.css("table tr:first-of-type td").first.text.strip
    end

    def hours(schedule)
      schedule.css("table tr:nth-of-type(n+4) td").map(&:text).reject { |it| it.empty? }
    end
  end
end
