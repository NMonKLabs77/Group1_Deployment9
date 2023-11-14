<p align="center">
<img src="https://github.com/kura-labs-org/kuralabs_deployment_1/blob/main/Kuralogo.png">
</p>

## Group Instructions:
1. **Everyone is responsible for submitting the main repository link and updating the main repository**  
2. Each person in a group must pick one role from below:
```
Project Manager:
- Make sure everyone is working on their part of the deployment
- Manage the time for each deliverable
- Create the main deployment repo in GitHub (and invite team members to it)
- Create a Jira board (and invite team members to it)

Chief Architect:
- Create the deployment diagram
- Create the Terraform files
- Create the ALB controller
- Create the Cloudwatch Agent on AWS EKS

System Administrator:
- Create the Docker container images for EKS
- Create the Kubernetes manifest
- Create AWS user accounts for each member of your group to access your account with

Data Engineer:
- See "DataOps Engineer Instructions" below

```
3. Here are your groups and roles:
```
1. Aubrey- Data, Nehemiah- Manager, Darrielle- Chief Architect, Jo- System Admin, Nalani- System Admin
2. Annie- Data, Jorge- Manager, Sameen- Chief Architect, Kevin E- System Admin
3. Ethan- Manager, Khalil- Data, Luis- System Admin, Danielle- Chief Architect
4. Dwayne- System Admin, Saraswati- Data, Andrew- Manager, Kevin G- Chief Architect
5. Brittney-System Admin, Dolma- Manager, Belinda- Chief Architect

```

*********************************************************************************************************************************************************************
## DevOps Deployment Instructions:

1. Create a Python script that will send a Slack message to your group chat when the Jenkins pipeline is done.
2. Create a Jenkins manager and agent architecture:
```
Instance 1:
- Jenkins, Docker pipeline plugin
Instance 2 (T.2 medium):
- Docker and default-jre 
Instance 3 (T.2 medium):
- Kubectl, EKS and default-jre (Manually install your cluster and add the loadbalancer)
- Please run the following command for creating your cluster:

    eksctl create cluster cluster01  --vpc-private-subnets=subnet-02d4cc65e8dde7a07,subnet-0952efd7d50fc7f11  --vpc-public-subnets=subnet-003ea84136dc93f2e,subnet-0bcb542a46061faa1 --without-nodegroup

    And then:

    eksctl create nodegroup --cluster cluster02 --node-type t2.medium --nodes 2

- The above commands will allow you to create t2.medium nodes instad of a m5.large nodes
```
3. Create a VPC with the following components:
    - 2 Public subnets
    - 2 Private subnets
    - Internet Gateway
    - Nat Gateway  
4. Create a deployment and services manifest for the E-commerce application:
    - Create a service and deployment for the backend
    - Create a service and deployment for the frontend
      ```
        Follow these steps
        - node 10 required
        - git clone {Your repo}
        - cd frontend
        - npm install --save-dev @babel/plugin-proposal-private-property-in-object
        - npm install
        - npm start
      ```   
6. Make sure your cluster is created and the instance 3 is connected to the cluster
7. Create your ALB controller: [instructions here](https://docs.google.com/document/d/1Y_c_ByV8y9I1CL8NJvZLqo6ftahcJJD5qG0WA_PkqTM/edit?usp=sharing)
8. Use your Docker image of the Backend from Deployment 8
9. Create the frontend image and place the service name into the package.json file
10. Now have Jenkins create the docker image and deploy to EKS
11. [Install Cloudwatch Agent on AWS EKS](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/Container-Insights-setup-EKS-addon.html)


## DataOps Engineer Instructions:

Using the following 5 tables from db.sqlite3 file:

"auth_user"
"account_stripemodel"
"account_billingaddress"
"product_product"
"account_ordermodel"

Answer the following questions and create visualizations that will best illustrate your response. 
The choice of how to query the database is yours (SQL, pandas, python) as is the BI tool to create visualizations.   

1. Create a diagram of the schema and relationship between the tables (keys). (Use draw.io for this question)

2. What is the distribution of the amount of products ORDERED?  How much revenue would each product have generated IF the order was completed? 

3. Which states ordered the most products? Least products?  How does the revenue generated compare to the amount of products sold?  What were the top 5 products sold in each of those states? (Answer should include all states)

4.  There are orders that were placed that weren't paid for.  Those shouldn't have been shipped out.  How much money did this company lose by delivering products that were not paid for?  How does this compare to how much revenue would have been generated?  

5.  Taking into consideration that some orders were not completed, how much money was ACTUALLY generated compared to the answer from Question 1?  

All of the prices are in Rupees.  Don't forget to convert all of those to USD. 

Remember: For each of these insights, provide a CSV of the aggregate data and a visualization that summarizes it.  Good Luck!
