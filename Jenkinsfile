node {
    currentBuild.result = "SUCCESS"
    def mkdocsImage

    try {

       stage('Checkout'){
          checkout scm
       }

       stage('Build Docker') {
         mkdocsImage = docker.build("darknerd/mkdocs:${env.BUILD_ID}")
       }

       stage('Test') {
          def doc_mount = "${pwd()}/test/mock:/opt/docs"
          def options = "-v ${doc_mount} -p 8000:8000"
          mkdocsImage.withRun(options, 'serve') { c ->
            // Install Ruby + InSpec
            sh 'apk --update add --virtual build-dependencies ruby-dev build-base libxml2-dev libffi-dev git openssh-client'
            //sh 'gem update --system'
            sh 'gem install inspec --no-ri --no-rdoc'
            sh "inspec exec ${pwd()}/test/integration/default -t docker://${c.id}"
          }

       }

      // ##### CREDENTIALS NEEDED FOR THIS PROCESS TO WORK
      //  stage('Push'){
      //    mkdocsImage.push('latest')
      //  }

    }
    catch (err) {
        currentBuild.result = "FAILURE"
        throw err
    }

}
