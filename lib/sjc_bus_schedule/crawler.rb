# frozen_string_literal: true

require "sjc_bus_schedule/parser/parser"
require "sjc_bus_schedule/bus"
require "sjc_bus_schedule/schedule"

require "httparty"
require "nokogiri"

class SJCBusSchedule::Crawler
  BASE_URL = "http://servicos2.sjc.sp.gov.br/servicos/horario-e-itinerario.aspx"
  FILTERS = { number: 0, name: 1, itinerary: 2 }.freeze

  def initialize(http: HTTParty, query: { number: "" })
    @http = http
    set_url(*query.first)
  end

  def process
    response = HTTParty.get(@url)

    doc = Nokogiri::HTML(response)

    schedule_links(doc).map do |schedule_link|
      bus_url = "http://servicos2.sjc.sp.gov.br#{schedule_link["href"]}"

      response = HTTParty.get(bus_url)
      doc = Nokogiri::HTML(response)

      bus_parser = SJCBusSchedule::Parser::Bus.new(doc: doc)
      schedules_parser = SJCBusSchedule::Parser::Schedules.new(doc: doc)

      build_buses(bus_parser: bus_parser, schedules_parser: schedules_parser)
    end
  end

  private

  def set_url(filter, query)
    @url = "#{BASE_URL}?acao=p&opcao=#{FILTERS[filter]}&txt=#{URI.encode(query.to_s)}"
  end

  def schedule_links(doc)
    doc.css("a[href*='/servicos/horario-e-itinerario.aspx?acao=d&id_linha=']")
  end

  def build_buses(bus_parser:, schedules_parser:)
    SJCBusSchedule::Bus.new(
      number: bus_parser.number,
      name: bus_parser.name,
      direction: bus_parser.direction,
      itinerary: bus_parser.itinerary,
      note: bus_parser.note,
      schedules: build_schedules(schedules_parser: schedules_parser)
    )
  end

  def build_schedules(schedules_parser: schedules_parser)
    schedules_parser.schedules.map do |schedule|
      SJCBusSchedule::Schedule.new(
        period: schedule[:period],
        hours: schedule[:hours],
        references: schedules_parser.references
      )
    end
  end
end
