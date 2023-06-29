# MongoDB Compass Private Link Setup with Terraform

## Description

This project demonstrates how to use Terraform to set up a secure connection between MongoDB Compass and a MongoDB Atlas cluster using a private link from a private network via a Socks5 tunnel.

This README file will guide you through the necessary steps to deploy the infrastructure using Terraform and configure MongoDB Compass to connect to the Atlas cluster through the private link.

## Prerequisites

Before starting, ensure that you have the following:

1. An active MongoDB Atlas account.
2. MongoDB Compass installed on your local machine.
3. Terraform installed on your local machine.
4. AWS account credentials with necessary permissions to create resources.

## Getting Started

To set up the MongoDB Compass private link with Terraform, follow these steps:

### Step 1: Clone the Repository

Clone the repository to your local machine:

```shell
git clone https://github.com/ctcac00/mongodb-compass-socks5
cd mongodb-compass-socks5
```

### Step 2: Configure Terraform

1. Install the necessary Terraform providers by running the following command:

   ```shell
   terraform init
   ```

2. Open the `variables.tf` file and update the variable values as per your requirements. You will need to provide the MongoDB Atlas connection details, AWS credentials, and other configuration parameters.

### Step 3: Deploy the Infrastructure

1. Run the Terraform plan command to review the changes that will be applied:

   ```shell
   terraform plan
   ```

2. If the plan looks correct, apply the changes by running:

   ```shell
   terraform apply
   ```

   This command will create the necessary resources in your AWS account, including the VPC, EC2 instance for the SOCKS5 server, and the required security groups.

3. Login remotely to the EC2 VM and start microsocks:

   ```shell
   microsocks
   ```

   This command will start microsocks and will ouput the client connections and the end destinations.

### Step 4: Configure MongoDB Compass

1. Launch MongoDB Compass on your local machine.

2. Click on "New Connection" to create a new connection.

3. Paste the connection string from the terraform output.

4. Open the "Advanced Connection Options" area, select "Proxy/SSH", then "Socks5".

5. Paste the EC2 instance public DNS name in the "Proxy Hostname".

6. Save the connection and test the connection to ensure that MongoDB Compass can connect to the Atlas cluster via the private link.

## Cleaning Up

To clean up the resources created by Terraform, run the following command:

```shell
terraform destroy
```

This command will delete all the resources created by Terraform, including the VPC, EC2 instance, and security groups.

## Conclusion

By following the steps outlined in this README file, you can easily set up a secure connection between MongoDB Compass and a MongoDB Atlas cluster using Terraform and a private link from a private network through the Socks5 server.
