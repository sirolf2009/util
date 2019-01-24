package com.sirolf2009.util

class LongExtensions {

	def static String humanReadableByteCount(long bytes) {
		return humanReadableByteCount(bytes, false)
	}

	/**
	 * @author https://stackoverflow.com/questions/3758606/how-to-convert-byte-size-into-human-readable-format-in-java
	 */
	def static String humanReadableByteCount(long bytes, boolean si) {
		val unit = if(si) 1000 else 1024
		if(bytes < unit) return bytes + " B"
		val exp = (Math.log(bytes) / Math.log(unit)) as int
		val pre = (if(si) "kMGTPE" else "KMGTPE").charAt(exp - 1) + (if(si) "" else "i")
		return String.format("%.1f %sB", bytes / Math.pow(unit, exp), pre)
	}

}
