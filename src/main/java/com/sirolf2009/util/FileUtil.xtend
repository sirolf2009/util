package com.sirolf2009.util

import java.nio.file.Files
import java.nio.file.Paths

class FileUtil {

	//The path to the file in classpath, no leading /	
	def static getResourceLines(String file) {
		Files.lines(getResourcePath(file))
	}
		
	def static getResourceInputstream(String file) {
		Files.lines(getResourcePath(file))
	}
	
	def static getResourcePath(String file) {
		Paths.get(FileUtil.getClassLoader().getResource(file).toURI())
	}
	
}