# Automate-Multi-Tier-Java-Web-Application-on-AWS-Using-Scripts-
This project focuses on automating the deployment of a multi-tier Java web application on AWS using  AWS CLI and shell scripts. Participants will learn to provision, configure, and manage AWS resources  programmatically

<img width="919" height="715" alt="Screenshot 2025-09-18 233857" src="https://github.com/user-attachments/assets/56b1c0ca-18bf-4cce-b04c-6332eee7157e" />


# Project Summary

Users will access our web application by using a domain name bought from public dns provider. The domain name URL will point to the ELB endpoint.

Users browsers will use this endpoint to connect to the load balancer by using HTTP on port 80. The ELB will be in a security group that only allows HTTP traffic on port 80.

The application load balancer will then route the request to Tomcat servers (EC2) running in a security group that accepts connection only from the load balancer on port 8080.

The backend servers (MySQL, Memcache and RabbitMQ) for our application will sit in a separate security group.

# Project Implementation

# Step 1: Create 3 VM 

 
We’ll create one vm  for the application server (tomcat instance) 


<img width="1902" height="823" alt="image" src="https://github.com/user-attachments/assets/ca2ec190-6c4c-42e1-a53b-52cc442a50ea" />


We’ll create one vm  for the database server (database instance) 


<img width="1897" height="830" alt="image" src="https://github.com/user-attachments/assets/db5e5d8f-fae7-4396-a349-5c658fcc1cfb" />


We’ll create one vm  for 3 instance (Nginx,memcached,rabbitmq)


<img width="1911" height="852" alt="image" src="https://github.com/user-attachments/assets/a3a0b730-30f4-403b-8800-0e314476ce6b" />


# step 2: chose application and os image 


<img width="1886" height="818" alt="image" src="https://github.com/user-attachments/assets/a254187a-e966-4dce-ae15-6d6be48e98a0" />


# step 3: choose instance type 


<img width="1253" height="251" alt="image" src="https://github.com/user-attachments/assets/2ec3b8c2-679e-485a-a87c-bd433998d388" />


# step 4: create key pair 


<img width="677" height="636" alt="image" src="https://github.com/user-attachments/assets/b14db209-2084-4156-87de-5272ce6f9b6a" />


# step 5: create security Group 


 add roles in inbound roles 


<img width="1902" height="753" alt="image" src="https://github.com/user-attachments/assets/5b35bc8d-4f02-4759-b7a3-dde76d9730d9" />


# step 5: add script in user data


add Tomcat script


<img width="1917" height="827" alt="image" src="https://github.com/user-attachments/assets/7d7ee3b5-f869-4003-98d1-6e875f636769" />


add database script 


<img width="1910" height="830" alt="image" src="https://github.com/user-attachments/assets/d373bd72-ce5f-4bfb-a755-892c40df04ec" />


add (Nginx,rabbitmq,memcahed) script


<img width="1916" height="821" alt="image" src="https://github.com/user-attachments/assets/eb2d5523-3927-4280-beef-61fe928f4f8d" />


# step 6: check vms are running


<img width="1888" height="832" alt="image" src="https://github.com/user-attachments/assets/0f6362ba-cc7a-455e-88d4-0c7987c28f8e" />


# step 7: connect publice ip of Tomcat on port 8080

http://3.250.22.166:8080/login


<img width="987" height="562" alt="image" src="https://github.com/user-attachments/assets/513e0f67-5f88-42ad-8678-db6038731b7d" />

# what learn from this project?



![thx4w-8 (1)](https://github.com/user-attachments/assets/469311fb-d559-44c1-a2a3-3563a7f7dfca)


