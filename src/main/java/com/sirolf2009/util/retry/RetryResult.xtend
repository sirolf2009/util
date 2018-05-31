package com.sirolf2009.util.retry

import java.util.List
import java.util.Optional
import java.util.function.Supplier
import org.eclipse.xtend.lib.annotations.Data
import java.util.function.Consumer
import java.util.function.Function

@Data class RetryResult<T> implements Supplier<Optional<T>> {
	
	val Optional<T> value
	val int attempts
	val List<? extends Exception> errors
	
	def T getOrThrow() throws Exception {
		return value.orElseThrow[errors.stream().findFirst().get()]
	}

	def <U> RetryResult<U> map(Function<? super T, ? extends U> mapper) {
		return new RetryResult<U>(value.map(mapper), attempts, errors)
	}

	def void consume(Consumer<? super T> onSucceeded, Consumer<List<? extends Exception>> onFailed) {
		ifSucceeded(onSucceeded)
		ifFailed(onFailed)
	}

	def void ifSucceeded(Consumer<? super T> consumer) {
		value.ifPresent(consumer)
	}

	def void ifFailed(Consumer<List<? extends Exception>> consumer) {
		if(failed()) {
			consumer.accept(getErrors())
		}
	}

	def boolean succeeded() {
		return value.isPresent()
	}

	def boolean failed() {
		return !value.isPresent()
	}

	override Optional<T> get() {
		return value
	}
	
}