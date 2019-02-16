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
          mkdocsImage.withRun("-v ${pwd()}/test/mock:/opt/docs -p 8000:8000", 'serve') { c ->
            sh "gem install inspec --no-ri --no-rdoc"
            // sh 'apt-get -yqq update'
            // sh 'apt install build-essential'
            // sh 'ruby --version'
            // mkdocsImage.inside("--link ${c.id}:mk") {
            //   sh 'echo MKDOCS PWD=$(pwd)' 
            // }
            // docker.image('chef/inspec').inside("-t --rm -v /opt/docs:/share","exec test/integration") {
            //   sh 'echo INSPEC PWD=$(pwd)'

            // }
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
