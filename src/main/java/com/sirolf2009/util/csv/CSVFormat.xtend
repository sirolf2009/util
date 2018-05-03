package com.sirolf2009.util.csv

import org.eclipse.xtend.lib.annotations.Data
import java.util.regex.Pattern

@Data class CSVFormat {

	val CSVRegex regex
	val String delimiter
	val Pattern pattern

	new(CSVRegex regex, String delimiter) {
		this.regex = regex
		this.delimiter = delimiter
		this.pattern = regex.getPattern(delimiter)
	}
}