Generating a token
Go to : http://192.168.1.60:9000/account/security/

You can generate new tokens at User > My Account > Security.
Under Generate Tokens
 Type your token name: Sonar-Token
 Click Generate 
 Copy The Tockern
The form at the top of the page allows you to generate new tokens, specifying their token type.
Once you click the Generate button, you will see the token value. 
Copy it immediately; 
once you dismiss the notification you will not be able to retrieve it.



 Got To Jenkins:
 http://192.168.1.215:8080/
	Manage Jenkins
		Configure System
			SonarQube servers
				Name: sonarqube-9.1											((Any meneanigful name))
				Server URL: http://192.168.1.60:9000/
				Server authentication token
					Add:
						Domain: GLobal Credential
						Kind: Secret Text
							Scope: Global
							Secret: Paste the Text Generate from Sonarqube
						ID: sonarqube-9.1									(Any meneanigful name)
						Description: sonarqube-9.1  						(Any meneanigful name)
					Add
			Select: Sonarqube-9.1
		Save


Create a pipeline Job:
Enter an item name	
	Any Meaningful name
Select Pipeline
Copy From if you have previous project
Ok

Pipeline suntax ok:

pipeline{
    agent any
       tools {
        maven 'apache-maven-3.6.3'
        jdk 'jdk-11.0.10'
        
    }
    stages{
        stage('SCM'){
            steps{
                //git branch: "${env.BRANCH_NAME}",credentialsId: 'Gitlab-DevOps', url: "${env.GIT_REPO}"
                git branch: 'dev', credentialsId: 'create it again by pipeline syntax', url: 'https://gitlab.ibcs-primax.com/ngpims/microservice/ngpims-eureka.git'
            }
        }
        
        stage('Version') {
            steps {
                sh 'mvn --version'
            }
        }
        
        stage('Update'){
            steps{
                sh "mvn clean install -X"
            }
        }
        
        stage('Quality Gate Status Check'){
         steps{
            script{
                withSonarQubeEnv('sonarqube-9.1){
                 sh "mvn sonar:sonar"
                 }
                   }
                  }
                }
            }
    }
    
