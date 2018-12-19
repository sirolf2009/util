package com.sirolf2009.util.javafx

import java.util.function.Function
import javafx.beans.binding.Bindings
import javafx.beans.value.ObservableValue

class ObservableExtensions {
	
	def static <T,R> ObservableValue<R> map(ObservableValue<T> value, Function<T,R> mapper) {
		return Bindings.createObjectBinding([mapper.apply(value.getValue())], value)
	}
	
}