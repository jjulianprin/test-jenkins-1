
// comment
pipeline {
 agent any
 stages {
        stage('CheckingGitRepository'){
               steps{
		git poll: true, url: 'https://github.com/jjulianprin/test-jenkins-1.git'
               }
        }
        stage('CreatingVirualEnvironment') {
            steps {
				sh '''
					bash -c "python3 -m venv venv && source venv/bin/activate"
				'''
            }
        }
        stage('InstallingRequirements') {
            steps {
            	sh '''
            		bash -c "source ${WORKSPACE}/venv/bin/activate && pip3 install -r requirements.txt"
                '''
            }
        }   
        stage('TestApp') {
            steps {
            	sh '''
            		bash -c "source ${WORKSPACE}/venv/bin/activate &&  cd src && ${WORKSPACE}/venv/bin/pytest"
                '''
            }
        }  
        stage('RunApp') {
            steps {
            	sh '''
            		bash -c "source venv/bin/activate ; ${WORKSPACE}/venv/bin/python3 src/hello.py &"
                '''
            }
        } 
        stage('BuildDocker') {
            steps {
            	sh '''
            		docker build -t pythonapppipeline:latest .
                '''
            }
        } 
    stage('PushDockerImage') {
            steps {
            	sh '''
            		docker tag pythonapppipeline:latest jjulianprin/pythonapppipeline:latest
					docker push jjulianprin/pythonapppipeline:latest
					docker rmi -f pythonapppipeline:latest
                '''
            }
        } 
  }
}
