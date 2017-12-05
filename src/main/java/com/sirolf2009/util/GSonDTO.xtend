package com.sirolf2009.util

import com.google.gson.JsonDeserializationContext
import com.google.gson.JsonDeserializer
import com.google.gson.JsonElement
import com.google.gson.JsonObject
import com.google.gson.JsonParseException
import java.lang.reflect.Type
import org.eclipse.xtend.lib.macro.AbstractClassProcessor
import org.eclipse.xtend.lib.macro.Active
import org.eclipse.xtend.lib.macro.RegisterGlobalsContext
import org.eclipse.xtend.lib.macro.TransformationContext
import org.eclipse.xtend.lib.macro.declaration.ClassDeclaration
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration
import java.math.BigDecimal
import java.math.BigInteger

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
					«constructor.parameters.map[
						if(type == newTypeReference(String)) {
							'''«type» «simpleName» = object.get("«simpleName»").getAsString();'''
						} else if(type == newTypeReference(BigDecimal)) {
							'''«type» «simpleName» = object.get("«simpleName»").getAsBigDecimal();'''
						} else if(type == newTypeReference(BigInteger)) {
							'''«type» «simpleName» = object.get("«simpleName»").getAsBigInteger();'''
						} else if(type == newTypeReference(Boolean)) {
							'''«type» «simpleName» = object.get("«simpleName»").getAsBoolean();'''
						} else if(type == newTypeReference(Byte)) {
							'''«type» «simpleName» = object.get("«simpleName»").getAsByte();'''
						} else if(type == newTypeReference(Character)) {
							'''«type» «simpleName» = object.get("«simpleName»").getAsCharacter();'''
						} else if(type == newTypeReference(Double)) {
							'''«type» «simpleName» = object.get("«simpleName»").getAsDouble();'''
						} else if(type == newTypeReference(Float)) {
							'''«type» «simpleName» = object.get("«simpleName»").getAsFloat();'''
						} else if(type == newTypeReference(Integer) || type == newTypeReference(int)) {
							'''«type» «simpleName» = object.get("«simpleName»").getAsInt();'''
						} else if(type == newTypeReference(Long)) {
							'''«type» «simpleName» = object.get("«simpleName»").getAsLong();'''
						} else if(type == newTypeReference(Number)) {
							'''«type» «simpleName» = object.get("«simpleName»").getAsNumber();'''
						} else if(type == newTypeReference(Short)) {
							'''«type» «simpleName» = object.get("«simpleName»").getAsShort();'''
						} else {
							'''«type» «simpleName» = context.deserialize(object.get("«simpleName»"), «type».class);'''
						}
					].join("\n")»
					return new «annotatedClass»(«constructor.parameters.map[simpleName].join(", ")»);'''
				]
			}
		}

		def getSerializerName(ClassDeclaration annotatedClass) {
			return annotatedClass.qualifiedName + "JsonDeserializer"
		}

	}

}
