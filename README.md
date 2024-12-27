# AWS Continuous Integration Setup

This guide provides step-by-step instructions to set up continuous integration for a Python application using AWS services.

## 1. Set up GitHub Repository

1. Create a new GitHub repository for your project.
2. Add the necessary files for your application and version control. Ensure you include files like:
   - `app.py` (your main Python application file)
   - `requirements.txt` (list of dependencies)
   - `.gitignore` (to exclude unnecessary files from version control)

## 2. Configure AWS CodeBuild

AWS CodeBuild will handle building and packaging your application for deployment.

### Steps:

1. Navigate to the AWS CodeBuild service in the AWS Management Console.
2. Create a new build project and provide a name for the project.
3. For the source provider, choose **GitHub**.
4. Select **Public Repository** and connect to your GitHub account.
5. Configure the build environment:
   - Choose the operating system (e.g., Amazon Linux or Ubuntu).
   - Select the runtime (e.g., Python).
   - Specify compute resources as per your application's needs.
6. In the **Role name** field, create a new role in the IAM service with the use case set to **CodeBuild**.

## 3. Create Parameters in AWS Systems Manager

Create secure parameters for your application using AWS Systems Manager Parameter Store.

### Steps:

1. Navigate to AWS Systems Manager in the AWS Management Console.
2. Under **Parameter Store**, create parameters for your application:
   - `username`: Your Docker username.
   - `password`: Your Docker access token.
   - `url`: Your application's Docker image repository URL.

## 4. Create an AWS CodePipeline

Set up an automated pipeline for continuous integration using AWS CodePipeline.

### Steps:

1. Navigate to the AWS CodePipeline service in the AWS Management Console.
2. Click on the **Create pipeline** button.
3. Choose **Build custom pipeline** and provide a name for your pipeline.
4. For the **Source** stage:
   - Select **GitHub** as the source provider.
   - Connect your GitHub account to AWS CodePipeline.
   - Select your repository and branch.
5. For the **Build** stage:
   - Select **AWS CodeBuild** as the build provider.
6. Review the pipeline configuration.
7. Click on the **Create pipeline** button to finalize the setup.

---

Your continuous integration pipeline is now ready to build and deploy your Python application automatically!

# AWS Continuous Delivery Setup

## Steps to Set Up Continuous Delivery with AWS CodeDeploy

8. **Create an Application on CodeDeploy**  
   - Navigate to AWS CodeDeploy in the Management Console.
   - Create a new application and provide the required details.

9. **Tag the EC2 Instance**  
   - Go to your EC2 instance in the AWS Management Console.
   - Add a tag to the instance to identify it for deployment.

10. **Connect to EC2 Instance via SSH**  
   - Open your terminal or Git Bash and type the following command:
     ```bash
     ssh -i <key_pair_file> ubuntu@<ec2_ipv4_address>
     ```

11. **Install CodeDeploy Agent**  
   - Follow the steps in the [CodeDeploy Agent Installation Guide](https://docs.aws.amazon.com/codedeploy/latest/userguide/codedeploy-agent-operations-install-ubuntu.html).

12. **Create an IAM Role for CodeDeploy**  
   - Create an IAM role with the following:
     - **AWS Service**: EC2
     - Attach the required policies for CodeDeploy access.

13. **Attach IAM Role to EC2 Instance**  
   - Go to the EC2 instance in the AWS Management Console.
   - Navigate to **Actions** -> **Security** -> **Modify IAM Role**.
   - Attach the newly created IAM role to the instance.

14. **Restart the CodeDeploy Agent**  
   - In the terminal, type:
     ```bash
     sudo service codedeploy-agent restart
     ```

15. **Add EC2 Full Permissions to IAM Role**  
   - Ensure the IAM role attached to the EC2 instance has `AmazonEC2FullAccess` permissions.

16. **Create a Deployment Group in CodeDeploy**  
   - Go to the CodeDeploy application and create a deployment group.

17. **Create a Deployment**  
    - Create a deployment using the deployment group.
    - If errors occur due to missing Docker, install Docker by typing:
      ```bash
      sudo apt install docker.io -y
      ```

18. **Verify Deployment and Set Up CodePipeline**  
    - After a successful deployment, go to **CodePipeline**.
    - Edit the pipeline and add a new stage.
      - Choose **AWS CodeDeploy** as the action provider.
    - Test the pipeline by modifying any line in a file within your repository.

19. **Debugging Tips**  
    - If errors persist, remove and restart Docker containers using:
      ```bash
      docker rm -f <container_id>
      

