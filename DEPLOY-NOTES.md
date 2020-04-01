- Install ansible
- Launch EC2, create new keypair
- chmod 400 .pem
- cat ssh keys
- Provision with python and nginx
- ping ec2
  - ansible all -m ping --key-file=./rel/ansible/certs/webhook_processor.pem -i ./rel/ansible/hosts.yml -u ec2-user
- Create ./rel/ansible/ansible.cfg
- Set HTTP/S rules on ec2

## CodePipeline


