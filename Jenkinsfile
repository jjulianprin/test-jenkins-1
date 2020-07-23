// comment
pipeline {
 agent any
 stages {
        stage('Checkout-git'){
               steps{
		git poll: true, url: 'https://github.com/jjulianprin/test-jenkins-1.git'
               }
        }
        stage('CreateVirtualEnv') {
            steps {
				sh '''
					bash -c "python3 -m venv venv && source venv/bin/activate"
				'''
            }
        }
        stage('InstallRequirements') {
            steps {
            	sh '''
            		bash -c "source ${WORKSPACE}/venv/bin/activate && ${WORKSPACE}/venv/bin/python3 ${WORKSPACE}/venv/bin/pip3 install -r requirements.txt"
                '''
            }
        }   
        stage('TestApp') {
            steps {
            	sh '''
            		bash -c "source ${WORKSPACE}/venv/bin/activate &&  cd src && ${WORKSPACE}/venv/bin/python3 ${WORKSPACE}/venv/bin/pytest && cd .."
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
            		docker build -t pythonappPL:latest .
                '''
            }
        } 
    stage('PushDockerImage') {
            steps {
            	sh '''
            		docker tag pythonappPL:latest jjulianprin/pythonappPL:latest
					docker push jjulianprin/pythonappPL:latest
					docker rmi -f pythonappPL:latest
                '''
            }
        } 
  }
}
