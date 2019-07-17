# SJCBusSchedule

Crawler that gets the bus schedules from the official website.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sjc_bus_schedule'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sjc_bus_schedule

## Usage

### Searching for a bus

```ruby
SJCBusSchedule.find_by(number: 101)
# => [#<SJCBusSchedule::Bus:0x0000559b884e35a8 @number="101", @name="REPRESA / TERMINAL CENTRAL (RADIAL) O.S.O 41", ...]

SJCBusSchedule.find_by(name: "Represa")
# => [#<SJCBusSchedule::Bus:0x0000559b884e35a8 @number="101", @name="REPRESA / TERMINAL CENTRAL (RADIAL) O.S.O 41", ...]

SJCBusSchedule.find_by(itinerary: "São João")
# => [#<SJCBusSchedule::Bus:0x000055f98013a0e0 @number="111", @name="VALE DOS PINHEIROS / MONTE CASTELO (CIRCULAR NO MONTE CASTELO) O.S.O. 31", ...]
```

### Getting all buses

```ruby
SJCBusSchedule.all
# => [#<SJCBusSchedule::Bus:0x0000559b884e35a8 ...]
```

### The response

#### SJCBusSchedule::Bus

```ruby
bus.number # => "101"
bus.name # => "101"
bus.direction # => "REPRESA / TERMINAL CENTRAL"
bus.itinerary # => ["BAIRRO RIO DAS COBRAS", "ESTR. JUCA CARVALHO", ...]
bus.note # => "-"
bus.schedules # => [#<SJCBusSchedule::Schedule:0x00005592d1dde0a0 @period="De segunda-feira a sexta-feira", ...]
```

#### SJCBusSchedule::Schedule

```ruby
schedule.period # => "De segunda-feira a sexta-feira"
schedule.hours # => ["05:20(1)", "09:50(3)", "14:15(3)", "18:45(6)", ...]
schedule.references # => ["(1) SANTO AGOSTINHO DE CIMA - VILA PAIVA", "(2) GUIRRA - PAÇO MUNICIPAL", ...]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sjc_bus_schedule. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SjcBusSchedule project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sjc_bus_schedule/blob/master/CODE_OF_CONDUCT.md).
