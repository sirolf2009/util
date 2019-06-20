package com.sirolf2009.util

import io.jaegertracing.Configuration
import io.jaegertracing.Configuration.ReporterConfiguration
import io.jaegertracing.Configuration.SamplerConfiguration
import io.jaegertracing.Configuration.SenderConfiguration
import io.opentracing.Scope
import io.opentracing.Span
import io.opentracing.Tracer
import java.util.function.BiConsumer
import java.util.function.Consumer
import org.apache.commons.lang3.exception.ExceptionUtils

class SpanUtil {

	def static <R, E extends Exception> R span(Tracer tracer, String name, Function_WithExceptions<Span, R, E> scopeConsumer) throws E {
		return span(tracer, name, scopeConsumer, [ scope, error |
			scope.setTag("error", "true")
			scope.log(ExceptionUtils.getStackTrace(error))
		])
	}

	def static <R, E extends Exception> R span(Tracer tracer, String name, Function_WithExceptions<Span, R, E> spanFunction, BiConsumer<Span, Throwable> errorConsumer) throws E {
		var Span span = tracer.buildSpan(name).asChildOf(tracer.activeSpan()).start()
		try (var Scope scope=tracer.activateSpan(span)) {
			return spanFunction.apply(span)
		} catch(Exception e) {
			errorConsumer.accept(span, e)
			throw e
		} finally {
			span.finish()
		}
	}

	def static void span(Tracer tracer, String name, Consumer<Span> scopeConsumer) {
		span(tracer, name, scopeConsumer, [ scope, error |
			scope.setTag("error", "true")
			scope.log(ExceptionUtils.getStackTrace(error))
		])
	}

	def static void span(Tracer tracer, String name, Consumer<Span> scopeConsumer, BiConsumer<Span, Throwable> errorConsumer) {
		var Span span = tracer.buildSpan(name).asChildOf(tracer.activeSpan()).start()
		try (var Scope scope=tracer.activateSpan(span)) {
			scopeConsumer.accept(span)
		} catch(Exception e) {
			errorConsumer.accept(span, e)
		} finally {
			span.finish()
		}
	}

	def static Tracer getTracer(String jaegerHost, String service) {
		var SamplerConfiguration samplerConfig = SamplerConfiguration.fromEnv().withType("const").withParam(1)
		var ReporterConfiguration reporterConfig = ReporterConfiguration.fromEnv().withSender(SenderConfiguration.fromEnv().withAgentHost(jaegerHost)).withLogSpans(true)
		var Configuration config = new Configuration(service).withSampler(samplerConfig).withReporter(reporterConfig)
		return config.getTracer()
	}

	@FunctionalInterface interface Consumer_WithExceptions<T, E extends Exception> {
		def void accept(T t) throws E

	}

	@FunctionalInterface interface BiConsumer_WithExceptions<T, U, E extends Exception> {
		def void accept(T t, U u) throws E

	}

	@FunctionalInterface interface Function_WithExceptions<T, R, E extends Exception> {
		def R apply(T t) throws E

	}

	@FunctionalInterface interface Supplier_WithExceptions<T, E extends Exception> {
		def T get() throws E

	}

	@FunctionalInterface interface Runnable_WithExceptions<E extends Exception> {
		def void run() throws E

	}

	@FunctionalInterface interface Predicate_WithExceptions<T, E extends Exception> {
		def boolean test(T t) throws E

	}
}
