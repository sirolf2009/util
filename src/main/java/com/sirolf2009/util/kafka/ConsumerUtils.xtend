package com.sirolf2009.util.kafka

import java.util.Properties
import org.apache.kafka.clients.consumer.ConsumerConfig
import java.util.UUID

class ConsumerUtils {
	
	def static startFromBeginning(extension Properties properties, String groupPrefix) {
		put(ConsumerConfig.AUTO_OFFSET_RESET_CONFIG, "earliest") // If no offsets are found for this consumer, start from beginning of topic
		put(ConsumerConfig.GROUP_ID_CONFIG, groupPrefix+UUID.randomUUID()) //The group ID, the UUID makes sure that we start a new group every time
		return properties
	}
	
}