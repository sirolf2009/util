package com.sirolf2009.util

import java.text.ParseException
import java.text.SimpleDateFormat
import java.time.Instant
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.ZoneId
import java.time.ZonedDateTime
import java.time.temporal.ChronoUnit
import java.util.ArrayList
import java.util.Calendar
import java.util.Date
import java.util.List
import java.util.TimeZone

class TimeUtil {

	public static val ISO = "yyyy-MM-dd'T'HH:mm:ssX"
	public static val amsterdam = TimeZone.getTimeZone("Europe/Amsterdam")
	public static val UTC = TimeZone.getTimeZone("UTC")
	public static TimeZone timezone = amsterdam

	def static String formatForUrl(Date date) {
		return format(date).replace("+", "%2B").replace("-", "%2D")
	}

	def static String format(Date date) {
		return getIsoParser().format(date)
	}

	def static String format(List<Date> dates) {
		return dates.map[format(it)].join(", ")
	}

	def static Date parseISO(String string) throws ParseException {
		return getIsoParser().parse(string)
	}

	def static SimpleDateFormat getIsoParser() {
		return getParser(ISO);
	}

	def static SimpleDateFormat getParser(String format) {
		return new SimpleDateFormat(format) => [
			timeZone = timezone
		]
	}

	def static Date toDate(LocalDateTime date) {
		return toDate(date, amsterdam)
	}

	def static Date toDate(LocalDateTime date, TimeZone zone) {
		return toDate(date.atZone(zone.toZoneId()))
	}

	def static Date toDate(ZonedDateTime date) {
		return toDate(date.toInstant())
	}

	def static Date toDate(Instant instant) {
		return Date.from(instant)
	}

	def static Date asAmsterdamDay(Date date) {
		val cal = getCalendar(amsterdam) => [
			time = date
			set(Calendar.MILLISECOND, 0)
			set(Calendar.SECOND, 0)
			set(Calendar.MINUTE, 0)
			set(Calendar.HOUR_OF_DAY, 0)
		]
		return cal.time
	}

	def static List<Date> getPointsToDate(Date startdate, Date enddate, int intervallength) {
		val dates =	new ArrayList()
		val calendar = getCalendar()
		calendar.setTime(startdate)

		while(calendar.getTime().before(enddate)) {
			val	result = calendar.getTime()
			dates.add(result)
			calendar.add(Calendar.MINUTE, intervallength)
		}
		return dates
	}

	def static long getDaysBetween(Date from, Date to) {
		return ChronoUnit.DAYS.between(toLocalDate(from), toLocalDate(to))
	}

	def static LocalDate toLocalDate(Date date) {
		return date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate()
	}

	def static Date dayBeforeYesterday() {
		return dayBeforeYesterday(timezone)
	}

	def static Date dayBeforeYesterday(TimeZone zone) {
		val cal = getCalendar(zone)
		cal.setTime(yesterday(zone))
		cal.add(Calendar.DATE, -1)
		return cal.getTime()
	}

	def static Date yesterday() {
		return yesterday(timezone)
	}

	def static Date yesterday(TimeZone zone) {
		val cal = getCalendar(zone)
		cal.setTime(today(zone))
		cal.add(Calendar.DATE, -1)
		return cal.getTime()
	}

	def static Date today() {
		return today(timezone)
	}

	def static Date today(TimeZone zone) {
		val cal = getCalendar(zone)
		cal.set(Calendar.HOUR_OF_DAY, 0)
		cal.clear(Calendar.MINUTE)
		cal.clear(Calendar.SECOND)
		cal.clear(Calendar.MILLISECOND)
		return cal.getTime()
	}

	def static Date tomorrow() {
		return tomorrow(timezone)
	}

	def static Date tomorrow(TimeZone zone) {
		val cal = getCalendar(zone)
		cal.setTime(today(zone))
		cal.add(Calendar.DATE, 1)
		return cal.getTime()
	}

	def static Date dayAfterTomorrow() {
		return dayAfterTomorrow(timezone)
	}

	def static Date dayAfterTomorrow(TimeZone zone) {
		val cal = getCalendar(zone)
		cal.setTime(tomorrow(zone))
		cal.add(Calendar.DATE, 1)
		return cal.getTime()
	}

	def static Date getDateForOffset(int offset) {
		return getDateForOffset(offset, timezone)
	}

	def static Date getDateForOffset(int offset, TimeZone zone) {
		val cal = getCalendar(zone)
		cal.setTime(today(zone))
		cal.add(Calendar.DATE, offset)
		return cal.getTime()
	}

	def static int get(int field) {
		return getCalendar().get(field)
	}

	def static int get(TimeZone zone, int field) {
		return getCalendar(zone).get(field)
	}

	def static int get(Date date, int field) {
		return getCalendar(date).get(field)
	}

	def static int get(Date date, TimeZone zone, int field) {
		return getCalendar(date, zone).get(field)
	}

	def static Calendar getCalendar(Date date) {
		return getCalendar(date, timezone)
	}

	def static Calendar getCalendar(Date date, TimeZone zone) {
		val cal = getCalendar(zone)
		cal.setTime(date)
		return cal
	}

	def static Calendar getCalendar() {
		return getCalendar(timezone)
	}

	def static Calendar getCalendar(TimeZone zone) {
		return Calendar.getInstance(zone)
	}

	def static Date addMillis(Date startTime, int n) {
		val Calendar cal = TimeUtil.getCalendar(startTime)
		cal.add(Calendar.MILLISECOND, n)
		return cal.getTime()
	}

	def static Date addSeconds(Date startTime, int n) {
		val Calendar cal = TimeUtil.getCalendar(startTime)
		cal.add(Calendar.SECOND, n)
		return cal.getTime()
	}

	def static Date addMinutes(Date startTime, int n) {
		val Calendar cal = TimeUtil.getCalendar(startTime)
		cal.add(Calendar.MINUTE, n)
		return cal.getTime()
	}

	def static Date addHours(Date startTime, int n) {
		val Calendar cal = TimeUtil.getCalendar(startTime)
		cal.add(Calendar.HOUR_OF_DAY, n)
		return cal.getTime()
	}

	def static Date addDays(Date startTime, int n) {
		val Calendar cal = TimeUtil.getCalendar(startTime)
		cal.add(Calendar.DATE, n)
		return cal.getTime()
	}

	def static Date addMonths(Date startTime, int n) {
		val Calendar cal = TimeUtil.getCalendar(startTime)
		cal.add(Calendar.MONTH, n)
		return cal.getTime()
	}

	def static Date addYears(Date startTime, int n) {
		val Calendar cal = TimeUtil.getCalendar(startTime)
		cal.add(Calendar.YEAR, n)
		return cal.getTime()
	}
}
