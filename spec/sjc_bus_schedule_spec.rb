RSpec.describe SJCBusSchedule do
  it "has a version number" do
    expect(SJCBusSchedule::VERSION).not_to be nil
  end

  describe ".find_by" do
    context "when filtering by number" do
      let(:bus_number) { "101" }

      it "returns buses with the number given" do
        VCR.use_cassette("buses_by_number") do
          buses = SJCBusSchedule.find_by(number: bus_number)
          expect(buses.first.number).to eq(bus_number)
        end
      end
    end

    context "when filtering by name" do
      let(:bus_name) { "REPRESA" }

      it "returns buses with the name given" do
        VCR.use_cassette("buses_by_name") do
          buses = SJCBusSchedule.find_by(name: bus_name)
          expect(buses.first.name).to include(bus_name)
        end
      end
    end

    context "when filtering by itinerary" do
      let(:bus_itinerary) { "São João" }
      let(:bus_itinerary_without_accents) { "Sao Joao" }

      it "returns buses with the itinerary given" do
        VCR.use_cassette("buses_by_itinerary") do
          buses = SJCBusSchedule.find_by(itinerary: bus_itinerary)
          has_itinerary = buses.first.itinerary.any? do |itinerary|
            itinerary.downcase.include?(bus_itinerary_without_accents.downcase)
          end
          expect(has_itinerary).to be_truthy
        end
      end
    end

    context "when filtering by a non-valid value" do
      let(:non_valid_value) { "non-valid-value" }

      it "returns an empty array" do
        VCR.use_cassette("non_valid_value") do
          buses = SJCBusSchedule.find_by(name: non_valid_value)
          expect(buses).to be_empty
        end
      end
    end

    context "when filtering by a non-valid filter" do
      let(:valid_value) { "101" }

      it "raises an exception" do
        expect do
          SJCBusSchedule.find_by(non_valid_filter: valid_value)
        end.to raise_exception(ArgumentError)
      end
    end
  end

  describe ".all" do
    it "returns all buses" do
      VCR.use_cassette("all_buses") do
        buses = SJCBusSchedule.all
        expect(buses).not_to be_empty
      end
    end
  end
end
