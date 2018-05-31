package com.sirolf2009.util.retry

import java.util.function.Supplier

interface RetryStrategy {

	def <T> RetryResult<T> run(Supplier<T> supplier)
	
}