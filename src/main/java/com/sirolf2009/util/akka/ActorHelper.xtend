package com.sirolf2009.util.akka

import akka.actor.AbstractActor
import akka.actor.ActorRef
import akka.event.Logging
import akka.event.LoggingAdapter
import akka.japi.pf.ReceiveBuilder

class ActorHelper {

	val AbstractActor me
	val LoggingAdapter log
	
	new(AbstractActor me) {
		this.me = me
		this.log = Logging.getLogger(me.getContext().getSystem(), me)
	}

	def =>(ActorRef actor, Object response) {
		actor.tell(response, me.self())
	}

	def ->(ReceiveBuilder builder, (ReceiveBuilder)=>ReceiveBuilder init) {
		init.apply(builder)
		return builder.build()
	}
	
	def getLog() {
		return log
	}
	
	def info(Object msg) {
		log.info(msg+"")
	}
	
	def debug(Object msg) {
		log.debug(msg+"")
	}
	
	def error(Object msg) {
		log.error(msg+"")
	}
	
	def warning(Object msg) {
		log.warning(msg+"")
	}

}
