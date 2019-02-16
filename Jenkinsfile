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
            sh 'apk --update add --virtual build-dependencies ruby-dev build-base'
            sh 'gem install inspec --no-ri --no-rdoc'
            sh "ls ${pwd()}/test/integration"
            sh "inspec exec test/integration -t docker://${c.id}"
          }
          // { c ->
          //  sh 'echo INNER PWD=$(pwd)'
          //  docker.image('chef/inspec').withRun("-t --rm -v ${env.PWD}:/share","exec test/integration") 
          //}
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
