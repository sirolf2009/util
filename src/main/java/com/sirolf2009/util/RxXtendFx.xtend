package com.sirolf2009.util

import io.reactivex.Flowable
import io.reactivex.Observable
import io.reactivex.rxjavafx.schedulers.JavaFxScheduler
import io.reactivex.Single
import io.reactivex.Maybe

/**
 * import static extension com.sirolf2009.util.RxXtendFx.*
 */
class RxXtendFx {
	
	def static <T> Observable<T> platform(Observable<T> source) {
		source.observeOn(JavaFxScheduler.platform())
	}
	
	def static <T> Flowable<T> platform(Flowable<T> source) {
		source.observeOn(JavaFxScheduler.platform())
	}
	
	def static <T> Single<T> platform(Single<T> source) {
		source.observeOn(JavaFxScheduler.platform())
	}
	
	def static <T> Maybe<T> platform(Maybe<T> source) {
		source.observeOn(JavaFxScheduler.platform())
	}
	
}