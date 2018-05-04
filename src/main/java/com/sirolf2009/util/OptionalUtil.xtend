package com.sirolf2009.util

import java.util.List
import java.util.Optional
import java.util.function.Supplier
import java.util.stream.Stream
import java.util.function.Consumer

class OptionalUtil {
	
	def static <T> consume(Optional<T> optional, Consumer<? super T> ifPresent, Runnable ifMissing) {
		if(optional.isPresent()) {
			optional.ifPresent(ifPresent)
		} else {
			ifMissing.run()
		}
	}
	
	def static <T> Optional<? extends T> getFirst(List<Optional<? extends T>> optionals) {
		return getFirst(optionals.stream())
	}
	
	def static <T> Optional<? extends T> getFirst(Optional<? extends T>... optionals) {
		return getFirst(optionals.stream())
	}
	
	def static <T> Optional<? extends T> getFirst(Stream<Optional<? extends T>> optionals) {
		return optionals.filter[isPresent()].map[get()].findFirst()
	}
	
	def static <T> Optional<T> getFirstLazy(List<Supplier<Optional<T>>> optionals) {
		return getFirstLazy(optionals.stream())
	}
	
	def static <T> Optional<T> getFirstLazy(Supplier<Optional<T>>... optionals) {
		return getFirstLazy(optionals.stream())
	}
	
	def static <T> Optional<T> getFirstLazy(Stream<Supplier<Optional<T>>> optionals) {
		return optionals.map[get()].filter[isPresent()].map[get()].findFirst()
	}
	
}