package com.sirolf2009.util.jmx

import java.io.IOException
import java.lang.management.ManagementFactory
import java.rmi.registry.LocateRegistry
import javax.management.remote.JMXConnectorServerFactory
import javax.management.remote.JMXServiceURL
import javax.management.ObjectName

class JMXUtil {
	
	def static registerObject(Object object, String name) {
		ManagementFactory.getPlatformMBeanServer().registerMBean(object, new ObjectName(name))
	}
	
	def static void startJMX(int port) throws IOException {
		LocateRegistry.createRegistry(port)
		val mbs = ManagementFactory.getPlatformMBeanServer()
		JMXConnectorServerFactory.newJMXConnectorServer(getURLForPort(port), null, mbs).start()
	}
	
	def static JMXServiceURL getURLForPort(int port) {
		return new JMXServiceURL('''service:jmx:rmi://localhost/jndi/rmi://localhost:«port»/jmxrmi''')
	}
	
}