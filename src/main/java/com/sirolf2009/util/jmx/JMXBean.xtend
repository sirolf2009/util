package com.sirolf2009.util.jmx

import javax.management.InstanceAlreadyExistsException
import javax.management.MBeanException
import javax.management.MXBean
import javax.management.MalformedObjectNameException
import javax.management.NotCompliantMBeanException
import org.eclipse.xtend.lib.macro.AbstractClassProcessor
import org.eclipse.xtend.lib.macro.Active
import org.eclipse.xtend.lib.macro.RegisterGlobalsContext
import org.eclipse.xtend.lib.macro.TransformationContext
import org.eclipse.xtend.lib.macro.declaration.ClassDeclaration
import org.eclipse.xtend.lib.macro.declaration.MethodDeclaration
import org.eclipse.xtend.lib.macro.declaration.MutableClassDeclaration
import org.eclipse.xtend.lib.macro.declaration.MutableInterfaceDeclaration
import java.util.Date

@Active(JMXBeanProcessor)
annotation JMXBean {
	static class JMXBeanProcessor extends AbstractClassProcessor {
		override doRegisterGlobals(ClassDeclaration annotatedClass, RegisterGlobalsContext context) {
			context.registerInterface(annotatedClass.beanName)
		}

		override doTransform(MutableClassDeclaration annotatedClass, extension TransformationContext context) {
			val beanDeclaration = findInterface(annotatedClass.beanName)
			beanDeclaration.addAnnotation(newAnnotationReference(MXBean))
			annotatedClass.implementedInterfaces = annotatedClass.implementedInterfaces + #[beanDeclaration.newTypeReference()]
			annotatedClass.declaredMethods.filter[
				returnType == newTypeReference(Date) ||
				returnType == newTypeReference(String) ||
				returnType == newTypeReference(Integer) || returnType == newTypeReference(int) ||
				returnType == newTypeReference(Double) || returnType == newTypeReference(double) ||
				returnType == newTypeReference(Float) || returnType == newTypeReference(float) ||
				returnType == newTypeReference(Long) || returnType == newTypeReference(long) ||
				returnType == newTypeReference(Short) || returnType == newTypeReference(short) ||
				returnType == newTypeReference(Byte) || returnType == newTypeReference(byte) ||
				returnType == newTypeReference(Boolean) || returnType == newTypeReference(boolean)
			].forEach [
				addDeclaration(beanDeclaration)
			]
			annotatedClass.addMethod("registerAs") [
				addParameter("name", newTypeReference(String))
				body = '''java.lang.management.ManagementFactory.getPlatformMBeanServer().registerMBean(this, javax.management.ObjectName.getInstance(name));'''
				exceptions = exceptions + #[newTypeReference(MBeanException), newTypeReference(InstanceAlreadyExistsException), newTypeReference(NotCompliantMBeanException), newTypeReference(MalformedObjectNameException)]
			]
		}

		def static addDeclaration(MethodDeclaration methodDeclaration, MutableInterfaceDeclaration beanDeclaration) {
			beanDeclaration.addMethod(methodDeclaration.simpleName) [
				exceptions = methodDeclaration.exceptions
				docComment = methodDeclaration.docComment
				returnType = methodDeclaration.returnType
				methodDeclaration.parameters.forEach [ param |
					addParameter(param.simpleName, param.type)
				]
			]
		}

		def static getBeanName(ClassDeclaration clazz) {
			clazz.qualifiedName + "MXBean"
		}
	}

}
