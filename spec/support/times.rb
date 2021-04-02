# frozen_string_literal: true

require 'time'

module Times
  def self.hours_in_seconds(hours)
    hours * 60
  end

  def self.one_hour_in_seconds
    hours_in_seconds(1)
  end

  def self.hours_from(time, hours)
    time + hours_in_seconds(hours)
  end

  def self.hours_from_now(hours)
    hours_from(Time.now, hours)
  end

  def self.one_hour_from_now
    hours_from_now(1)
  end

  def self.one_hour_from(time)
    hours_from(time, 1)
  end
end
