package com.sirolf2009.util.csv

import java.util.stream.Stream
import com.sirolf2009.util.StreamUtil
import java.util.Arrays
import java.util.LinkedList

class CSVParser {
	
	def static Stream<Line> parse(String text, CSVFormat format) {
		return StreamUtil.zipWithIndex(Arrays.stream(text.replace("\r\n", "\n").replace("\r", "\n").split("\n"))).map[
			val matcher = format.getPattern().matcher(getKey())
			val cols = new LinkedList<String>()
			while(matcher.find()) {
				if(matcher.group(2) !== null) {
					cols.add(matcher.group(2))
				} else {
					cols.add(matcher.group(1))
				}
			}
			return new Line(getValue() + 1l, format.getDelimiter(), cols)
		]
	}
}