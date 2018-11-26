package com.sirolf2009.util

import io.reactivex.Flowable
import io.reactivex.Maybe
import io.reactivex.Observable
import io.reactivex.Single
import io.reactivex.schedulers.Schedulers
import java.util.Optional
import java.util.function.Function
import io.vavr.control.Try

/**
 * import static extension com.sirolf2009.util.RxXtend.*
 */
class RxXtend {
	
	def static <T, R> mapMaybe(Observable<T> obs, Function<? super T, ? extends R> mapper) {
		obs.map [
			Try.of[mapper.apply(it)]
		]
	}
	
	def static <T, R> mapMaybe(Flowable<T> obs, Function<? super T, ? extends R> mapper) {
		obs.map [
			Try.of[mapper.apply(it)]
		]
	}
	
	def static <T> Observable<T> unpackSuccess(Observable<Try<T>> source) {
		source.filterSuccess().map[get()]
	}
	
	def static <T> Flowable<T> unpackSuccess(Flowable<Try<T>> source) {
		source.filterSuccess().map[get()]
	}
	
	def static <T> Maybe<T> unpackSuccess(Single<Try<T>> source) {
		source.filterSuccess().map[get()]
	}
	
	def static <T> Maybe<T> unpackSuccess(Maybe<Try<T>> source) {
		source.filterSuccess().map[get()]
	}
	
	def static <T> Observable<Try<T>> filterSuccess(Observable<Try<T>> source) {
		source.filter[isSuccess()]
	}
	
	def static <T> Flowable<Try<T>> filterSuccess(Flowable<Try<T>> source) {
		source.filter[isSuccess()]
	}
	
	def static <T> Maybe<Try<T>> filterSuccess(Single<Try<T>> source) {
		source.filter[isSuccess()]
	}
	
	def static <T> Maybe<Try<T>> filterSuccess(Maybe<Try<T>> source) {
		source.filter[isSuccess()]
	}
	
	def static <T> Observable<T> unpack(Observable<Optional<T>> source) {
		source.filterEmpty().map[get()]
	}
	
	def static <T> Flowable<T> unpack(Flowable<Optional<T>> source) {
		source.filterEmpty().map[get()]
	}
	
	def static <T> Maybe<T> unpack(Single<Optional<T>> source) {
		source.filterEmpty().map[get()]
	}
	
	def static <T> Maybe<T> unpack(Maybe<Optional<T>> source) {
		source.filterEmpty().map[get()]
	}
	
	def static <T> Observable<Optional<T>> filterEmpty(Observable<Optional<T>> source) {
		source.filter[isPresent()]
	}
	
	def static <T> Flowable<Optional<T>> filterEmpty(Flowable<Optional<T>> source) {
		source.filter[isPresent()]
	}
	
	def static <T> Maybe<Optional<T>> filterEmpty(Single<Optional<T>> source) {
		source.filter[isPresent()]
	}
	
	def static <T> Maybe<Optional<T>> filterEmpty(Maybe<Optional<T>> source) {
		source.filter[isPresent()]
	}
	
	def static <T> Observable<T> toObservable(Iterable<T> source) {
		Observable.fromIterable(source)
	}
	
	def static <T> Flowable<T> toFlowable(Iterable<T> source) {
		Flowable.fromIterable(source)
	}
	
	def static <T> Observable<T> io(Observable<T> source) {
		source.observeOn(Schedulers.io())
	}
	
	def static <T> Flowable<T> io(Flowable<T> source) {
		source.observeOn(Schedulers.io())
	}
	
	def static <T> Single<T> io(Single<T> source) {
		source.observeOn(Schedulers.io())
	}
	
	def static <T> Maybe<T> io(Maybe<T> source) {
		source.observeOn(Schedulers.io())
	}
	
	def static <T> Observable<T> computation(Observable<T> source) {
		source.observeOn(Schedulers.computation())
	}
	
	def static <T> Flowable<T> computation(Flowable<T> source) {
		source.observeOn(Schedulers.computation())
	}
	
	def static <T> Single<T> computation(Single<T> source) {
		source.observeOn(Schedulers.computation())
	}
	
	def static <T> Maybe<T> computation(Maybe<T> source) {
		source.observeOn(Schedulers.computation())
	}
	
	def static <T> Observable<T> newThread(Observable<T> source) {
		source.observeOn(Schedulers.newThread())
	}
	
	def static <T> Flowable<T> newThread(Flowable<T> source) {
		source.observeOn(Schedulers.newThread())
	}
	
	def static <T> Single<T> newThread(Single<T> source) {
		source.observeOn(Schedulers.newThread())
	}
	
	def static <T> Maybe<T> newThread(Maybe<T> source) {
		source.observeOn(Schedulers.newThread())
	}
	
	def static <T> Observable<T> single(Observable<T> source) {
		source.observeOn(Schedulers.single())
	}
	
	def static <T> Flowable<T> single(Flowable<T> source) {
		source.observeOn(Schedulers.single())
	}
	
	def static <T> Single<T> single(Single<T> source) {
		source.observeOn(Schedulers.single())
	}
	
	def static <T> Maybe<T> single(Maybe<T> source) {
		source.observeOn(Schedulers.single())
	}
	
}