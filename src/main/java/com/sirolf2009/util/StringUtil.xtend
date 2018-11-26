package com.sirolf2009.util

import java.util.Arrays
import java.util.concurrent.atomic.AtomicReference

class StringUtil {
	
	def static String combineMultiline(String... strings) {
		if(strings.size() == 0) {
			return ""
		} else if(strings.size() == 1) {
			return strings.get(0)
		}
		val combined = new AtomicReference<String>(strings.get(0))
		strings.stream().skip(1).forEach[combined.set(combineMultiline(combined.get(), it))]
		return combined.get()
	}

	def static String combineMultiline(String a, String b) {
		val aLines = a.split("\n")
		val bLines = b.split("\n")
		if (aLines.size() == 1 && bLines.size() == 1) {
			return a + b
		}
		val sizeA = getWidthOfMultiline(a)
		val sizeB = getWidthOfMultiline(b)
		return (0 ..< Math.max(aLines.size(), bLines.size())).map[
			val aLine = if(it < aLines.size()) aLines.get(it) else ""
			val aLinePadded = if(aLine.length() < sizeA) aLine + padding(sizeA - aLine.length()) else aLine
			val bLine = if(it < bLines.size()) bLines.get(it) else ""
			val bLinePadded = if(bLine.length() < sizeB) bLine + padding(sizeB - bLine.length()) else bLine
			return aLinePadded + bLinePadded
		].join("\n")
	}

	def static int getWidthOfMultiline(String multilineString) {
		return multilineString.split("\n").map[length].max()
	}

	def static int getHeightOfMultiline(String multilineString) {
		return multilineString.split("\n").length
	}

	def static String padding(int size) {
		return padding(size, " ");
	}

	def static String padding(int size, String character) {
		if (size <= 0) {
			return ""
		}
		return (0 ..< size).map[character].join()
	}

	def static String vpadding(int size) {
		return vpadding(size, " ")
	}

	def static String vpadding(int size, String character) {
		if (size <= 0) {
			return ""
		}
		(0 ..< size).map[character].join("\n")
	}
	
}