pipeline {
  agent any
  stages {
    stage('Compile') {
      steps {
        sh 'mvn clean deploy -P release'
      }
    }
  }
}
