pipeline {
  agent {
    docker {
      image 'darknerd/inspec'
      docker { image 'ruby' }.inside {
        checkout scm
        sh 'gem install inspec'
      }
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