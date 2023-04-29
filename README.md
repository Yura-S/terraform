creating vpc with public ec2 inside and backuping to s3 bucket

1) terraform init - with commented backend file(backend_s3.tf)
2) terraform apply - create vpc with public ec2 inside and s3 bucket for backup
3) remove comment characters in backend file
4) terraform init - for initialize backup in created s3 bucket


for delete

1) terraform destroy - will delete all resources except s3 bucket, because backup there
2) delete created s3 bucket manually
3) delete created by terraform files manually
4) put back comment characters in backend_s3.tf for next time