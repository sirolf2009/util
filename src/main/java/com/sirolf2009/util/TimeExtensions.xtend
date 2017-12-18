package com.sirolf2009.util

class TimeExtensions {
	
	def static century() {
		return 1.century
	}
	
	def static century(int amount) {
		return centuries(amount)
	}
	
	def static centuries(int amount) {
		return amount*1000*60*60*24*7*365*100
	}
	
	def static year() {
		return 1.year
	}
	
	def static year(int amount) {
		return years(amount)
	}
	
	def static years(int amount) {
		return amount*1000*60*60*24*7*365
	}
	
	def static week() {
		return 1.week
	}
	
	def static week(int amount) {
		return weeks(amount)
	}
	
	def static weeks(int amount) {
		return amount*1000*60*60*24*7
	}
	
	def static day() {
		return 1.day
	}
	
	def static day(int amount) {
		return days(amount)
	}
	
	def static days(int amount) {
		return amount*1000*60*60*24
	}
	
	def static hour() {
		return 1.hour
	}
	
	def static hour(int amount) {
		return hours(amount)
	}
	
	def static hours(int amount) {
		return amount*1000*60*60
	}
	
	def static minute() {
		return 1.minute
	}
	
	def static minute(int amount) {
		return minutes(amount)
	}
	
	def static minutes(int amount) {
		return amount*1000*60
	}
	
	def static second() {
		return 1.second
	}
	
	def static second(int amount) {
		return seconds(amount)
	}
	
	def static seconds(int amount) {
		return amount*1000
	}
	
	def static millisecond() {
		return 1.millisecond
	}
	
	def static millisecond(int amount) {
		return milliseconds(amount)
	}
	
	def static milliseconds(int amount) {
		return amount
	}
	
}