package com.sirolf2009.util

import java.util.List
import java.util.function.Function
import java.util.stream.Collectors
import java.util.stream.Stream

class DoubleExtensions {
	
	/**
	 * @author https://stackoverflow.com/questions/22186778/using-math-round-to-round-to-one-decimal-place
	 */
	def static round(double value, int precision) {
		val scale = Math.pow(10, precision) as int
		return Math.round(value * scale) / scale
	}
	
	def static mode(List<Double> values) {
		values.stream().collect(Collectors.groupingBy(Function.identity(), Collectors.counting())).entrySet().stream().max[a,b| a.value.compareTo(b.value)]
	}
	
	def static mode(Stream<Double> values) {
		values.collect(Collectors.groupingBy(Function.identity(), Collectors.counting())).entrySet().stream().max[a,b| a.value.compareTo(b.value)]
	}

	def static double map(double x, double in_min, double in_max, double out_min, double out_max) {
		return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min
	}

	def static double clamp(double value, double min, double max) {
		return Math.max(min, Math.min(max, value))
	}

}
