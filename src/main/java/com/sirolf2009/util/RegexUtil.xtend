package com.sirolf2009.util

import java.util.NoSuchElementException
import java.util.regex.Pattern

class RegexUtil {

	def static String extract(String string, String pattern) {
		return extract(string, Pattern.compile(pattern))
	}

	def static String extract(String string, Pattern pattern) {
		val matcher = pattern.matcher(string)
		if (matcher.find()) {
			return matcher.group(1)
		} else {
			throw new NoSuchElementException("The string \"" + string + "\" does not contain the pattern \"" + pattern.pattern() + "\"")
		}
	}
	
}