# Terraform Documentation
This package documents usages of Terraform with examples. I've personally written these examples to better understand how Terraform works. As my experience is mostly with AWS, they are going to be AWS leaning.

### Terraform Installation on Mac

`brew tap hashicorp/tap`

`brew install hashicorp/tap/terraform`

NOTE: In order to run the examples, you will need to provide credentials. For AWS resources for examples, create an iam role that will have access to the resources specified in the examples and then add the credentials to your AWS CLI configuration.

1. Navigate to the AWS console to create the IAM user roles needed if it hasn't been created.
2. Click into the user role.
3. Click on "Create Access Key".
4. Copy the Access Key ID and Secret Access Key.
5. On your PC terminal run this. When going through the configuration promots, enter the Access Key ID and Secret Access Key as directed.
   * `aws configure`
6. Now when you run the testing commands below, you will have the correct permission access to connect to the AWS provider and create the resources.

### Testing

`terraform init`

`terraform plan`

`terraform apply` **Be sure this is what you want to do. Running this will possibly incur actual cloud usage fees**