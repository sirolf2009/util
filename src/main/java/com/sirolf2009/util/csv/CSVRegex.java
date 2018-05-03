package com.sirolf2009.util.csv;

import java.util.regex.Pattern;

public enum CSVRegex {

	QUOTED("(?:^|%s)(?:(?:(?=\")\"([^\"].*?)\")|(?:(?!\")(.*?)))(?=%s|$)"),
	QUOTED_TRIMMED("(?:^|%s)\\s*(?:(?:(?=\")\"([^\"].*?)\")|(?:(?!\")(.*?)))(?=%s|$)");

	private final String regex;

	private CSVRegex(String regex) {
		this.regex = regex;
	}

	public Pattern getPattern(String delimiter) {
		return Pattern.compile(String.format(regex, delimiter, delimiter));
	}

	public String getRegex() {
		return regex;
	}

}
