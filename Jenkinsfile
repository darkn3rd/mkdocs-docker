node {
    currentBuild.result = "SUCCESS"
    def mkdocsImage

    try {

       stage('Checkout'){
          checkout scm
       }

      //  stage('Test') {
      //    def mkdocsImage = docker.build("darknerd/mkdocs:${env.BUILD_ID}")
      //    mkdocsImage.withRun() { c ->
      //     mkdocsImage.inside("--link ${c.id}:mk") { } 
      //     docker.image('chef/inspec').inside("--link ${c.id}:mk") {
      //       sh "inspec exec test/integration -t docker://${c.id}"
      //     }
      //   }
      //  }

       stage('Build Docker') {
         mkdocsImage = docker.build("darknerd/mkdocs:${env.BUILD_ID}")
       }

       stage('Push'){
         mkdocsImage.push('latest')
       }

    }
    catch (err) {
        currentBuild.result = "FAILURE"
        throw err
    }

}
