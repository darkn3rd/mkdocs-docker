pipeline {
  agent {
    docker {
      image 'darknerd/inspec'
    }
  }
  environment {
    CI = 'true'
  }
  stages {
    stage('Build') {
      steps {
        sh 'make build'
      }
    }
    stage('Test') {
      steps {
        sh 'make mock'
        sh 'docker ps'
        sh 'make test'
      }
    }
  }
}