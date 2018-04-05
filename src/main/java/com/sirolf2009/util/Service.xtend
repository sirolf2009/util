package com.sirolf2009.util

import java.lang.annotation.Target
import java.util.List
import org.eclipse.xtend.lib.macro.Active
import org.eclipse.xtend.lib.macro.TransformationContext
import org.eclipse.xtend.lib.macro.TransformationParticipant
import org.eclipse.xtend.lib.macro.ValidationContext
import org.eclipse.xtend.lib.macro.ValidationParticipant
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration
import org.eclipse.xtend.lib.macro.declaration.MutableTypeDeclaration
import org.eclipse.xtend.lib.macro.declaration.Visibility

@Target(TYPE)
@Active(ServiceProcessor)
annotation Service {
}

class ServiceProcessor implements TransformationParticipant<MutableTypeDeclaration>, ValidationParticipant<MutableTypeDeclaration> {

	override doTransform(List<? extends MutableTypeDeclaration> annotatedTargetElements,
		extension TransformationContext context) {
		for (annotatedType : annotatedTargetElements) {
			if (annotatedType instanceof MutableClassDeclaration) {
				annotatedType.final = true
				val privateParameterlessConstructors = annotatedType.declaredConstructors.filter [
					visibility == Visibility.PRIVATE && parameters.length == 0
				]
				if (privateParameterlessConstructors.length == 0) {
					annotatedType.addConstructor [
						visibility = Visibility.PRIVATE
						body = ''''''
					]
				}
			}
		}
	}

	override doValidate(List<? extends MutableTypeDeclaration> annotatedTargetElements,
		extension ValidationContext context) {
		for (annotatedType : annotatedTargetElements) {
			if (annotatedType instanceof MutableClassDeclaration) {
				annotatedType.declaredConstructors.filter[visibility != Visibility.PRIVATE || parameters.length > 0].
					forEach [
						addError("A service class may only have a private, parameterless constructor " +
							"(which is added automatically).")
					]
				annotatedType.declaredMethods.filter[!static].forEach [
					addError("A service class may only have static methods.")
				]
				annotatedType.declaredFields.filter[!static].forEach [
					addError("A service class must not have instance fields, as it is never constructed")
				]
				annotatedType.declaredFields.filter[static].filter[!final].forEach [
					addError("A service class may only have final static fields, as it must not store state.")
				]
			} else {
				annotatedType.addError("Only classes can be declared as Utility")
			}
		}
	}
}