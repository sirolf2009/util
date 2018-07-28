package com.sirolf2009.util.retry

import java.util.function.Supplier

class Retry {

	public static RetryStrategy defaultStrategy = new SimpleRetryStrategy(3)

	def static void retry(Runnable runnable) {
		retry(new Supplier<Void>() {
			override Void get() {
				runnable.run()
				return null;
			}
		})
	}

	def static <T> RetryResult<T> retry(Supplier<T> supplier) {
		return retry(supplier, defaultStrategy)
	}

	def static <T> RetryResult<T> retry(Supplier<T> supplier, int attempts) {
		return retry(supplier, new SimpleRetryStrategy(attempts))
	}

	def static <T> RetryResult<T> retry(Supplier<T> supplier, RetryStrategy strategy) {
		return strategy.run(supplier)
	}
	
}