/**
* Copyright (c) 2000-2014 Liferay, Inc. All rights reserved.
*
* This library is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1 of the License, or (at your option)
* any later version.
*
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
* details.
*/

/**
* @author Silvio Santos
*/
class DateUtil {

	class func format(time: Int64) -> String {
		var time: Double = Double(time) / 1000

		var currentDate: NSDate = NSDate()
		var	date: NSDate = NSDate(timeIntervalSince1970: time)

		if ((time == 0) || (currentDate.timeIntervalSince1970 < time)) {
			return String(NSLocalizedString("just-now", comment: ""))
		}

		var calendar: NSCalendar = NSCalendar.currentCalendar()

		var flags =
			NSCalendarUnit.SecondCalendarUnit |
			NSCalendarUnit.MinuteCalendarUnit |
			NSCalendarUnit.HourCalendarUnit |
			NSCalendarUnit.DayCalendarUnit |
			NSCalendarUnit.MonthCalendarUnit |
			NSCalendarUnit.YearCalendarUnit

		var components: NSDateComponents = calendar.components(
			flags, fromDate: date, toDate: currentDate,
			options: NSCalendarOptions(0))

		if (components.year != 0) {
			return _formatTimeUnit(
				components.year, singularKey: "time-year-ago",
				pluralKey: "time-years-ago")
		}

		if (components.month != 0) {
			return _formatTimeUnit(
				components.month, singularKey: "time-month-ago",
				pluralKey: "time-months-ago")
		}

		if (components.day != 0) {
			return _formatTimeUnit(
				components.day, singularKey: "time-day-ago",
				pluralKey: "time-days-ago")
		}

		if (components.hour != 0) {
			return _formatTimeUnit(
				components.hour, singularKey: "time-hour-ago",
				pluralKey: "time-hours-ago")
		}

		if (components.minute != 0) {
			return _formatTimeUnit(
				components.minute, singularKey: "time-minute-ago",
				pluralKey: "time-minutes-ago")
		}

		return String(format:"Just now")
	}

	private class func _formatTimeUnit(
		timeField: Int, singularKey: String, pluralKey: String) -> String {

		var formatKey = pluralKey

		if (timeField == 1) {
			formatKey = singularKey
		}

		var format = NSLocalizedString(formatKey, comment: "")

		return String(format: format, timeField)
	}

}