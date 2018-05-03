package com.sirolf2009.util.csv

import java.util.LinkedList
import java.util.Collection
import com.sirolf2009.util.StreamUtil
import java.util.stream.Collectors

class Line extends LinkedList<String> {
	
	val long lineNumber
	val String seperator

	new(long lineNumber, String seperator) {
		super()
		this.lineNumber = lineNumber
		this.seperator = seperator
	}

	new(long lineNumber, String seperator, Collection<? extends String> c) {
		super(c)
		this.lineNumber = lineNumber
		this.seperator = seperator
	}

	override String toString() {
		return '''«lineNumber»: «join(seperator)»'''
	}

	def String toStringWithIndeces() {
		return '''Line: «lineNumber»:
		«StreamUtil.zipWithIndex(stream()).map['''«getValue()»: «getKey()»'''].collect(Collectors.toList()).join("\n")»'''
	}
	
}