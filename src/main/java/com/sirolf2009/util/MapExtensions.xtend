package com.sirolf2009.util

import java.util.Map
import java.util.Optional

class MapExtensions {

	def static <K, V> getOptional(Map<K, V> map, K key) {
		return Optional.ofNullable(map.get(key))
	}

}
