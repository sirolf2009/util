package com.sirolf2009.util.akka

import akka.actor.Actor
import akka.actor.ActorRef
import akka.japi.pf.ReceiveBuilder
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor

@FinalFieldsConstructor class ActorHelper {

	val Actor me

	def =>(ActorRef actor, Object response) {
		actor.tell(response, me.self())
	}

	def ->(ReceiveBuilder builder, (ReceiveBuilder)=>ReceiveBuilder init) {
		init.apply(builder)
		return builder.build()
	}

}
