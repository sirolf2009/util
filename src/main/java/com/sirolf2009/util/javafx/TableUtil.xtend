package com.sirolf2009.util.javafx

import java.util.function.Function
import java.util.function.Supplier
import javafx.beans.property.SimpleObjectProperty
import javafx.beans.value.ObservableValue
import javafx.scene.control.TableCell
import javafx.scene.control.TableColumn
import javafx.scene.control.TableColumn.CellDataFeatures
import javafx.util.Callback

class TableUtil {
	
	def static <T> propertyFactory(Function<T, ObservableValue<String>> function) {
		return new Callback<CellDataFeatures<T, String>, ObservableValue<String>>() {
			override call(CellDataFeatures<T, String> param) {
				return function.apply(param.getValue())
			}
		}
	}
	
	def static <T,R> getterFactory(Function<T, R> function) {
		return new Callback<CellDataFeatures<T, R>, ObservableValue<R>>() {
			override call(CellDataFeatures<T, R> param) {
				return new SimpleObjectProperty<R>(function.apply(param.getValue()))
			}
		}
	}
	
	def static <T,R> cellFactory(Supplier<TableCell<T, R>> supplier) {
		return new Callback<TableColumn<T, R>, TableCell<T, R>>() {
			override call(TableColumn<T, R> param) {
				return supplier.get()
			}
		}
	}
	
}