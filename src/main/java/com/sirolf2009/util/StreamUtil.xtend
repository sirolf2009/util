package com.sirolf2009.util

import java.util.Iterator
import java.util.stream.Stream
import java.util.List

import static java.util.stream.Collectors.*
import java.util.ArrayDeque
import java.util.stream.StreamSupport
import java.util.Spliterator
import java.util.function.Consumer
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor
import java.util.Map
import java.util.function.Function

class StreamUtil {
	
	@SafeVarargs
	def static <T> Stream<T> concat(Stream<T>... streams) {
		return Stream.of(streams).flatMap[it]
	}
	
	/**
	 * Effectively as the {@link java.util.stream.Stream.of} function, this just reads nicer
	 */
	def static <T> Stream<T> stream(T t) {
		return Stream.of(t)
	}
	
	/**
	 * Effectively as the {@link java.util.stream.Stream.of} function, this just reads nicer
	 */
	@SafeVarargs
	def static <T> Stream<T> stream(T... t) {
		return Stream.of(t);
	}

	def static <T> Stream<Pair<Long, List<T>>> batch(Stream<T> stream, long count) {
		return groupBy(zipWithIndex(stream), [getValue() / count]).entrySet().stream().map[getKey() -> getValue().map[getKey()].toList()]
	}

	/**
	 * @author http://stackoverflow.com/questions/26403319/skip-last-x-elements-in-streamt
	 */
	def static <T> Stream<T> skipLastElements(Stream<T> s, int count) {
		if (count <= 0) {
			if (count == 0) {
				return s
			}
			throw new IllegalArgumentException(count + " < 0")
		}
		val pending = new ArrayDeque<T>(count + 1)
		val src = s.spliterator()
		return StreamSupport.stream(new Spliterator<T>() {
			override tryAdvance(Consumer<? super T> action) {
				while (pending.size() <= count && src.tryAdvance[pending.add(it)]) {
				}
				if (pending.size() > count) {
					action.accept(pending.remove());
					return true;
				}
				return false;
			}

			override Spliterator<T> trySplit() {
				return null
			}

			override estimateSize() {
				return src.estimateSize() - count
			}

			override characteristics() {
				return src.characteristics()
			}
		}, false)
	}

	/**
	 * @author http://stackoverflow.com/questions/30641383/java-8-stream-with-batch-processing
	 */
	def static <T> Stream<Pair<T, Long>> zipWithIndex(Stream<T> stream) {
		return stream(new ZipWithIndex(stream.iterator()))
	}
	def static <T> Stream<Pair<T, Long>> zipWithIndex(Iterable<T> stream) {
		return stream(new ZipWithIndex(stream.iterator()))
	}
	
	@FinalFieldsConstructor static class ZipWithIndex<T> implements Iterator<Pair<T, Long>> {
		val Iterator<T> itr
		var long index

			override hasNext() {
				return itr.hasNext()
			}

			override next() {
				return Pair.of(itr.next(), index++)
			}
		}

	/**
	 * @author http://stackoverflow.com/questions/30641383/java-8-stream-with-batch-processing
	 */
	def static <K, T> Map<K, List<T>> groupBy(Stream<T> stream, Function<? super T, ? extends K> classifier) {
		return stream.collect(groupingBy(classifier))
	}

	/**
	 * @author http://stackoverflow.com/questions/32317658/simplest-way-to-stream-an-iterator
	 */
	def static <T> Stream<T> stream(Iterable<T> it) {
		return StreamSupport.stream(spliterator(), false)
	}

	/**
	 * @author http://stackoverflow.com/questions/32317658/simplest-way-to-stream-an-iterator
	 */
	def static <T> Stream<T> stream(Iterator<T> it) {
		return stream[it]
	}

}