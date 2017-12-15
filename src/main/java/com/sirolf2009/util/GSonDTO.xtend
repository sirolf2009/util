package com.sirolf2009.util

import com.google.gson.JsonDeserializationContext
import com.google.gson.JsonDeserializer
import com.google.gson.JsonElement
import com.google.gson.JsonObject
import com.google.gson.JsonParseException
import java.lang.reflect.Type
import java.math.BigDecimal
import java.math.BigInteger
import java.util.List
import org.eclipse.xtend.lib.macro.AbstractClassProcessor
import org.eclipse.xtend.lib.macro.Active
import org.eclipse.xtend.lib.macro.RegisterGlobalsContext
import org.eclipse.xtend.lib.macro.TransformationContext
import org.eclipse.xtend.lib.macro.declaration.ClassDeclaration
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration

@Active(GSonDTOProcessor)
annotation GSonDTO {

	static class GSonDTOProcessor extends AbstractClassProcessor {

		override doRegisterGlobals(ClassDeclaration annotatedClass, RegisterGlobalsContext context) {
			context.registerClass(annotatedClass.serializerName)
		}

		override doTransform(MutableClassDeclaration annotatedClass, extension TransformationContext context) {
			if(annotatedClass.declaredConstructors.size() > 1 || annotatedClass.declaredConstructors.size() == 0) {
				annotatedClass.addError("Only one constructor is allowed")
			} else {
				val serializer = findClass(annotatedClass.serializerName)
				val constructor = annotatedClass.declaredConstructors.get(0)
				serializer.implementedInterfaces = #[newTypeReference(JsonDeserializer, annotatedClass.newSelfTypeReference)]
				serializer.addMethod("deserialize") [
					returnType = annotatedClass.newSelfTypeReference
					// JsonElement json, Type typeOfT, JsonDeserializationContext context) throws JsonParseException
					addParameter("json", newTypeReference(JsonElement))
					addParameter("typeOfT", newTypeReference(Type))
					addParameter("context", newTypeReference(JsonDeserializationContext))
					exceptions = #[newTypeReference(JsonParseException)]
					body = '''
					«newTypeReference(JsonObject)» object = json.getAsJsonObject();
					«FOR type : constructor.parameters»
						«
						if(type == newTypeReference(String)) {
							'''«type.type.type.qualifiedName» «type.simpleName» = object.get("«type.simpleName»").getAsString();'''
						} else if(type == newTypeReference(BigDecimal)) {
							'''«type.type.type.qualifiedName» «type.simpleName» = object.get("«type.simpleName»").getAsBigDecimal();'''
						} else if(type == newTypeReference(BigInteger)) {
							'''«type.type.type.qualifiedName» «type.simpleName» = object.get("«type.simpleName»").getAsBigInteger();'''
						} else if(type == newTypeReference(Number)) {
							'''«type.type.type.qualifiedName» «type.simpleName» = object.get("«type.simpleName»").getAsNumber();'''
						} else if(type == newTypeReference(Boolean) || type == newTypeReference(boolean)) {
							'''«type.type.type.qualifiedName» «type.simpleName» = object.get("«type.simpleName»").getAsBoolean();'''
						} else if(type == newTypeReference(Byte) || type == newTypeReference(byte)) {
							'''«type.type.type.qualifiedName» «type.simpleName» = object.get("«type.simpleName»").getAsByte();'''
						} else if(type == newTypeReference(Character) || type == newTypeReference(char)) {
							'''«type.type.type.qualifiedName» «type.simpleName» = object.get("«type.simpleName»").getAsCharacter();'''
						} else if(type == newTypeReference(Double) || type == newTypeReference(double)) {
							'''«type.type.type.qualifiedName» «type.simpleName» = object.get("«type.simpleName»").getAsDouble();'''
						} else if(type == newTypeReference(Float) || type == newTypeReference(float)) {
							'''«type.type.type.qualifiedName» «type.simpleName» = object.get("«type.simpleName»").getAsFloat();'''
						} else if(type == newTypeReference(Integer) || type == newTypeReference(int)) {
							'''«type.type.type.qualifiedName» «type.simpleName» = object.get("«type.simpleName»").getAsInt();'''
						} else if(type == newTypeReference(Long) || type == newTypeReference(long)) {
							'''«type.type.type.qualifiedName» «type.simpleName» = object.get("«type.simpleName»").getAsLong();'''
						} else if(type == newTypeReference(Short) || type == newTypeReference(short)) {
							'''«type.type.type.qualifiedName» «type.simpleName» = object.get("«type.simpleName»").getAsShort();'''
						} else if(type.type.isAssignableFrom(newTypeReference(List))) {
							'''«type.type.type.qualifiedName» «type.simpleName» = context.deserialize(object.get("«type.simpleName»"), new com.google.gson.reflect.TypeToken<«type.type.type.qualifiedName»<«type.type.actualTypeArguments.get(0).type.qualifiedName»>>(){}.getType());'''
						} else {
							'''«type.type.type.qualifiedName» «type.simpleName» = context.deserialize(object.get("«type.simpleName»"), «type.type.type.qualifiedName».class);'''
						}»
					«ENDFOR»
					return new «annotatedClass»(«constructor.parameters.map[simpleName].join(", ")»);'''
				]
			}
		}

		def getSerializerName(ClassDeclaration annotatedClass) {
			return annotatedClass.qualifiedName + "JsonDeserializer"
		}

	}

}
