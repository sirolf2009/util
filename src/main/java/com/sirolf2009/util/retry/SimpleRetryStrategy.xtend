package com.sirolf2009.util.retry

import java.util.ArrayList
import java.util.Optional
import java.util.function.Supplier
import org.eclipse.xtend.lib.annotations.Data

@Data class SimpleRetryStrategy  implements RetryStrategy {
	
	val int retryCount;

	override <T> RetryResult<T> run(Supplier<T> supplier) {
		val errors = new ArrayList<Exception>(retryCount)
		(0 ..< retryCount).toList().stream().map[
			try {
				return new RetryResult<T>(Optional.of(supplier.get()), it, errors)
			} catch(Exception e) {
				errors.add(e)
				return null
			}
		].filter[it !== null].findFirst().orElse(new RetryResult<T>(Optional.empty(), retryCount, errors))
	}
	
	
}