pipeline {
  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    disableConcurrentBuilds()
  }
  agent {
    label 'docker'
  }
  environment {
    IMAGE      = "rpmbuild-centos8"
    TAG        = "latest"
    TEMP_IMAGE = "rpmbuild8_${TAG}_${BUILD_NUMBER}"
  }
  stages {
    stage('Build') {
      steps {
        ansiColor('xterm') {
          sh 'docker build --pull --no-cache --squash --compress -t ${TEMP_IMAGE} .'
        }
      }
    }
    stage('Publish') {
      steps {
        ansiColor('xterm') {

          // Dockerhub
          sh 'docker tag ${TEMP_IMAGE} docker.io/jc21/${IMAGE}:${TAG}'
          withCredentials([usernamePassword(credentialsId: 'jc21-dockerhub', passwordVariable: 'dpass', usernameVariable: 'duser')]) {
            sh "docker login -u '${duser}' -p '${dpass}'"
            sh 'docker push docker.io/jc21/${IMAGE}:${TAG}'
            sh 'docker rmi docker.io/jc21/${IMAGE}:${TAG}'
          }
        }
      }
    }
  }
  triggers {
    githubPush()
  }
  post {
    success {
      build job: 'Docker/docker-rpmbuild-centos8/golang', wait: false
      build job: 'Docker/docker-rpmbuild-centos8/rust', wait: false

      juxtapose event: 'success'
      sh 'figlet "SUCCESS"'
    }
    failure {
      juxtapose event: 'failure'
      sh 'figlet "FAILURE"'
    }
    always {
      sh 'docker rmi  ${TEMP_IMAGE}'
    }
  }
}
