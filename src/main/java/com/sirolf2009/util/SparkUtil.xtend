package com.sirolf2009.util

import org.apache.commons.lang3.exception.ExceptionUtils
import org.slf4j.Logger
import spark.Spark

class SparkUtil {
	
	def static readableExceptions(Logger log) {
		Spark.exception(Exception) [ exception, request, response |
			log.error("Failed to handle " + request.url(), exception)
			response.status(500)
			response.type("text/plain")
			response.body(ExceptionUtils.getStackTrace(exception))
		]
	}
	
	def static enableCORS() {
		Spark.options("/*") [req, res|
			val accessControlRequestHeaders = req.headers("Access-Control-Request-Headers")
			if(accessControlRequestHeaders !== null) {
				res.header("Access-Control-Allow-Headers", accessControlRequestHeaders)
			}
			
			val accessControlMethod = req.headers("Access-Control-Request-Method")
			if(accessControlMethod !== null) {
				res.header("Access-Control-Allow-Methods", accessControlMethod)
			}
			return "OK"
		]
		Spark.before [req,res|
			res.header("Access-Control-Allow-Origin", "*")
		]
	}
	
}