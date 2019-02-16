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
          def options = "-v ${doc_mount} -p 8000:8000 --name mkdocs_jenkins"
          mkdocsImage.withRun(options, 'serve') { c ->
            // // Install Ruby + InSpec
            // def sys_libs = "build-dependencies build-base"
            // def ruby_base = "ruby ruby-bundler ruby-dev ruby-json ruby-io-console ruby-bundler ruby-rdoc"
            // def ruby_libs = "libxml2-dev libffi-dev libxslt-dev zlib-dev"
            // sh "apk --update add --virtual ${sys_libs} ${ruby_base} ${ruby_libs}"
            // // git openssh-client

            // //sh 'gem update --system'
            // sh 'gem install --no-document inspec'
            sh 'docker ps'
            sh 'curl localhost:8000'
            //sh "inspec exec ${pwd()}/test/integration/default -t docker://mkdocs_jenkins_1"
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
