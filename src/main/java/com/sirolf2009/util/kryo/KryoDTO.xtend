package com.sirolf2009.util.kryo

import com.esotericsoftware.kryo.Serializer
import com.esotericsoftware.kryo.io.Input
import com.esotericsoftware.kryo.io.Output
import java.lang.annotation.Target
import java.util.Optional
import org.eclipse.xtend.lib.macro.AbstractClassProcessor
import org.eclipse.xtend.lib.macro.Active
import org.eclipse.xtend.lib.macro.RegisterGlobalsContext
import org.eclipse.xtend.lib.macro.TransformationContext
import org.eclipse.xtend.lib.macro.declaration.ClassDeclaration
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration

import static extension com.sirolf2009.util.OptionalUtil.*
import static extension com.sirolf2009.util.StreamUtil.*

@Active(KryoProcessor)
@Target(TYPE)
annotation KryoDTO {

	static class KryoProcessor extends AbstractClassProcessor {
		
		override doRegisterGlobals(ClassDeclaration annotatedClass, extension RegisterGlobalsContext context) {
			context.registerClass(annotatedClass.serializerName)
		}

		override doTransform(MutableClassDeclaration annotatedClass, extension TransformationContext context) {
			determineConstructor(context, annotatedClass).consume([ constructor |
				val serializer = findClass(annotatedClass.serializerName)
				serializer.implementedInterfaces = #[newTypeReference(Serializer, newTypeReference(annotatedClass))]
				serializer.addMethod("write") [
					addParameter("kryo", newTypeReference(com.esotericsoftware.kryo.Kryo))
					addParameter("output", newTypeReference(Output))
					addParameter("object", newTypeReference(annotatedClass))
					body = '''
						«FOR it : constructor.parameters»
							«if(type == newTypeReference(String)) {
								'''output.writeString(object.get«getSimpleName().toFirstUpper()»());'''
							} else if(type == newTypeReference(Boolean) || type == newTypeReference(boolean)) {
								'''output.writeBoolean(object.is«getSimpleName().toFirstUpper()»());'''
							} else if(type == newTypeReference(Byte) || type == newTypeReference(byte)) {
								'''output.writeByte(object.get«getSimpleName().toFirstUpper()»());'''
							} else if(type == newTypeReference(Character) || type == newTypeReference(char)) {
								'''output.writeChar(object.get«getSimpleName().toFirstUpper()»());'''
							} else if(type == newTypeReference(Double) || type == newTypeReference(double)) {
								'''output.writeDouble(object.get«getSimpleName().toFirstUpper()»());'''
							} else if(type == newTypeReference(Float) || type == newTypeReference(float)) {
								'''output.writeFloat(object.get«getSimpleName().toFirstUpper()»());'''
							} else if(type == newTypeReference(Integer) || type == newTypeReference(int)) {
								'''output.writeInt(object.get«getSimpleName().toFirstUpper()»());'''
							} else if(type == newTypeReference(Long) || type == newTypeReference(long)) {
								'''output.writeLong(object.get«getSimpleName().toFirstUpper()»());'''
							} else if(type == newTypeReference(Short) || type == newTypeReference(short)) {
								'''output.writeShort(object.get«getSimpleName().toFirstUpper()»());'''
							} else {
								'''kryo.writeObject(output, object.get«getSimpleName().toFirstUpper()»());'''
							}»
						«ENDFOR»
					'''
				]
				serializer.addMethod("read") [
					addParameter("kryo", newTypeReference(com.esotericsoftware.kryo.Kryo))
					addParameter("input", newTypeReference(Input))
					addParameter("type", newTypeReference(Class, newTypeReference(annotatedClass)))
					returnType = newTypeReference(annotatedClass)
					body = '''
					«FOR it : constructor.parameters»
						«if(type == newTypeReference(String)) {
							'''String «getSimpleName()» = input.readString();'''
						} else if(type == newTypeReference(Boolean) || type == newTypeReference(boolean)) {
							'''Boolean «getSimpleName()» = input.readBoolean();'''
						} else if(type == newTypeReference(Byte) || type == newTypeReference(byte)) {
							'''Byte «getSimpleName()» = input.readByte();'''
						} else if(type == newTypeReference(Character) || type == newTypeReference(char)) {
							'''Character «getSimpleName()» = input.readChar();'''
						} else if(type == newTypeReference(Double) || type == newTypeReference(double)) {
							'''Double «getSimpleName()» = input.readDouble();'''
						} else if(type == newTypeReference(Float) || type == newTypeReference(float)) {
							'''Float «getSimpleName()» = input.readFloat();'''
						} else if(type == newTypeReference(Integer) || type == newTypeReference(int)) {
							'''Integer «getSimpleName()» = input.readInt();'''
						} else if(type == newTypeReference(Long) || type == newTypeReference(long)) {
							'''Long «getSimpleName()» = input.readLong();'''
						} else if(type == newTypeReference(Short) || type == newTypeReference(short)) {
							'''Short «getSimpleName()» = input.readShort();'''
						} else {
							'''«getType().getType().getQualifiedName()» «getSimpleName()» = kryo.readObject(input, «getType().getType().getQualifiedName()».class);'''
						}»
					«ENDFOR»
					return new «newTypeReference(annotatedClass)»(«constructor.parameters.map[getSimpleName()].join(", ")»);'''
				]
			], [
				addError(annotatedClass, "No suitable constructor found for kryo serialization")
			])
		}
		
		def static getSerializerName(ClassDeclaration annotatedClass) {
			return annotatedClass.qualifiedName + "KryoSerializer"
		}

		def static determineConstructor(extension TransformationContext context, MutableClassDeclaration annotatedClass) {
			getFirst(getAnnotatedConstructor(context, annotatedClass), getFieldConstructor(context, annotatedClass), getSimpleConstructor(context, annotatedClass), getEmptyConstructor(context, annotatedClass), getLargestConstructor(context, annotatedClass))
		}

		def static getAnnotatedConstructor(extension TransformationContext context, MutableClassDeclaration annotatedClass) {
			return Optional.ofNullable(annotatedClass.getDeclaredConstructors().findFirst [
				it.findAnnotation(findTypeGlobally(KryoConstructor)) !== null
			])
		}

		def static getFieldConstructor(extension TransformationContext context, MutableClassDeclaration annotatedClass) {
			return Optional.ofNullable(annotatedClass.getDeclaredConstructors().findFirst [
				if(getParameters().size() != annotatedClass.getDeclaredFields().size()) {
					return false
				}
				annotatedClass.getDeclaredFields().map[getType() -> getSimpleName()].zipWithIndex().allMatch [ field |
					val param = getParameters().get(field.getValue().intValue())
					param.getType().equals(field.getKey().getKey()) && param.getSimpleName().equals(field.getKey().getValue())
				]
			])
		}

		def static getSimpleConstructor(extension TransformationContext context, MutableClassDeclaration annotatedClass) {
			return Optional.ofNullable(annotatedClass.getDeclaredConstructors().findFirst [
				if(getParameters().isEmpty()) {
					return false
				}
				annotatedClass.getDeclaredFields().stream().allMatch[getType().isPrimitive()]
			])
		}

		def static getEmptyConstructor(extension TransformationContext context, MutableClassDeclaration annotatedClass) {
			return Optional.ofNullable(annotatedClass.getDeclaredConstructors().findFirst[getParameters().isEmpty()])
		}

		def static getLargestConstructor(extension TransformationContext context, MutableClassDeclaration annotatedClass) {
			return annotatedClass.getDeclaredConstructors().stream().max[a, b|a.getParameters().size().compareTo(b.getParameters().size())]
		}

	}

}
