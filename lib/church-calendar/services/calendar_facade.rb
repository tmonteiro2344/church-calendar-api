require 'ordinalize_full/integer'

module ChurchCalendar
  # perpetual calendar + additional methods + metadata

  class DateRangeEnumerator < ::CalendariumRomanum::Util::DateEnumerator
    def initialize(from, to)
      @start = from
      @stop = to
    end

    # @param date [Date]
    # @return [Boolean]
    def enumeration_over?(date)
      @stop < date
    end
  end

  class CalendarFacade
    def initialize(perpetual_calendar, metadata)
      @perpetual_calendar = perpetual_calendar
      @metadata = metadata
    end

    attr_reader :metadata

    def perpetual_calendar_day(date)
      @perpetual_calendar.day date.year, date.month, date.day, vespers: false, vigils: true
    end

    def day(date)
      perpetual_calendar_day date
    end

    def days_of_month(year, month)
      month_enum = CR::Util::Month.new(year, month)
      month_enum.collect {|date| perpetual_calendar_day(date) }
    end

    def days_of_year(year)
      year_enum = CR::Util::Year.new(year)
      year_enum.collect {|date| perpetual_calendar_day(date) }
    end

    def days_between(start, stop)
      year_enum = DateRangeEnumerator.new(start, stop)
      year_enum.collect {|date| perpetual_calendar_day(date) }
    end

    def days_between_today_and_365
      now = Time.now
      start = Date.new now.year, now.month, now.day
      days_between start, start + 365
    end

    def spell_out_ordinals(string)
      m = /\b(\d+)(?:th|st|nd|rd)/.match(string)
      if !m
        return string
      end

      ordinal = m[1].to_i.ordinalize_in_full.gsub(' ', '-')
      string.gsub(m[0], ordinal)
    end

    def title_includes_query?(title, query)
      title = title.downcase
      query = query.downcase
      title_with_spelled_out_ordinals = spell_out_ordinals title
      title.include?(query) or title_with_spelled_out_ordinals.include?(query)
    end

    def search_title(query)
      results = []
      all_result = days_between_today_and_365

      if !query
        return all_result
      end

      all_result.each do |day|
        matches = day.celebrations.select {|cel| title_includes_query?(cel.title, query.downcase)}
        if matches.length > 0
          results.push(CalendariumRomanum::Day.new(
            date: day.date,
            season: day.season,
            season_week: day.season_week,
            vespers: day.vespers,
            celebrations: matches,
          ))
        end
      end

      return results
    end

    def year(year)
      @perpetual_calendar.calendar_for_year year
    end
  end
end
