package com.sirolf2009.util

class DoubleExtensions {

	def static double map(double x, double in_min, double in_max, double out_min, double out_max) {
		return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
	}

	def static double clamp(double value, double min, double max) {
		return Math.max(min, Math.min(max, value))
	}

}
