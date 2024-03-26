# aws-vpc-good-practices
The objective of this project is to demonstrate the 13 best practices for VPCs according to HyperGlance (https://www.hyperglance.com/blog/aws-vpc-security-best-practices/) 

✔  1. Choose the Appropriate VPC Type 
When setting up a VPC, think carefully about its requirements (now and in the future). Make the right choice now, save valuable time later!

The four initial choices are:

VPC with a single public subnet only
VPC with public and private subnets
VPC with public and private subnets and AWS Site-to-Site VPN access
VPC with a private subnet only and AWS Site-to-Site VPN access

Implementation:
I am going to use both private and public subnets in this project only, in order to keep the cluster internal traffic protected and to use public subnet to expose the ingress for external requests

✔ 2. Choose the Right CIDR Block  
You should consider the number of IP addresses you require, and data center connectivity before you choose your CIDR block.

VPC IPv4 blocks can be between /28 and /16 in size. An IPv6 VPC is a fixed size of /56 (in CIDR notation).

Pick carefully, and leave some capacity. You can change your IPv4 VPC size by adding/removing up to 4 'secondary' CIDRs. You can't change the size of the IPv6 address range of your VPC.

Also, make sure that your VPC IP address ranges of your VPC don't overlap with the IP address ranges of your existing network.
Implementation:
I am using a /16 cidr block for this project 


✔ 3. Use Multi-AZ Deployments  
Hopefully, when it comes to data, the cost is less critical to your organization than high availability... if that's the case then be sure to choose Multi-AZ deployments. Each AZ runs using its own power and connectivity, giving you the best chances in the case of an AZ failing completely.

Implementation:
I am going to use the following AZs in this project: "us-east-1a","us-east-1b","us-east-1c

✔ 4. Isolate Your Environments  
You'd do this on-premises, and it's much safer to do the same in the cloud. The best practice is to split your production, staging, and pre-production environments across different VPCs.

Image courtesy of AWS

Implementation:
I am going to use a single environment for this project

✔ 5. Use Security Groups To Control Resource Access   
It's vital that you factor in AWS Identity Access Management (IAM) when you're planning and setting up your VPC. Think about the users, applications and services that need to access your VPC. VPCs are a high-risk area, so don't be afraid to create and assign granular resource-level permissions that reflect your organization's requirements.

Where possible, ensure that IAM roles and security group rules follow the principle of least privilege, granting only the necessary access required for a task.

Instances can have up to 5 groups assigned to them. When you create your new security groups, no inbound traffic is allowed by default - you'll need to create a rule if you want to change that. Ingress & egress traffic is controlled separately, so will require separate rules.

Implementation:
Created some security groups for port 22 in order to be able to reach worker nodes via ssh 

✔ 6. Create a Network Access Control List (NACL)   
IAM security groups should be your primary method for controlling VPC network access. Importantly, security groups can contain rules that reference other groups, and they can perform stateful packet filtering - which makes them more flexible than NACLs. However, NACLs can be used (sparingly) to create secondary, stateless guardrails, e.g denying a specific subset of traffic, or high-level subnet controls.

Unlike security groups, NACL gives you the option to create allow and deny rules. To help you manage your list, NACL rules are also numbered (by you). The rules are then evaluated and run in order of their number, lowest to highest.

By default, a VPC has a default NACL that allows all inbound and outbound traffic. A custom NACL, when you create one, does the opposite. Each subnet can only be associated with one NACL, but an NACL can be attached to multiple subnets. Be careful with subnets that aren't associated with an NACL as they will automatically inherit your default NACL (allowing all ingress and egress traffic).

Implementation:
Created an NACL for ports 443 and 80 for external requests

✔ 7. Use VPC Flow Logs to Monitor IP Traffic  
Given that your VPC is your packet gateway, we'd recommend using VPC Flow Logs to capture information about the IP traffic that's going to and from network interfaces in your VPC (or subnet).

VPC Flow Logs are a great way to monitor traffic that reaches your instance, but they're also great for diagnosing common problems, e.g. overly prohibitive security group rules preventing traffic. Don't forget to publish flow log data to CloudWatch and/or S3.

Implementation:
Created a s3 bucket for all logs from my VPC

N/A 8. Use an Elastic IP For External Communication
When a service needs to be able to communicate externally, be sure to associate it with AWS Elastic IP (EIP). An EIP allows you to quickly remap addresses to different instances - should you need to, you can use them to mask the failure of some software or an instance. EIPs are also great for when you need a consistent IP, e.g. for DNS.

Once you've done associated an EIP, whitelist those IPv4 (EIP doesn't currently support IPv6) addresses within the services that need the access.

N/A 9. Be Mindful When Using Elastic Load Balancing
Whenever you're using Elastic Load Balancing (ELB) for web applications, make sure you place other EC2 instances (that don't require outside-world access) into private subnets. Only the ELBs should be in a public subnet.

N/A 10. Use AWS SFTP
If you ever need to transfer files/objects into a VPC, we'd recommend using AWS SFTP. When you do this, you utilize VPC endpoints, avoiding public IP addresses (and the internet) altogether. You also get to leverage AWS PrivateLink.

❌ 11. Set Up VPC Peering
VPC Peering allows you to route traffic between two AWS VPCs, via private IPs.

Importantly, VPC Peering connections don't depend on physical hardware like a gateway or VPN connection. Instead, peering connections are created using utilize the VPC's existing infrastructure. This can be especially useful if you have applications that require private & secure connections across multiple VPCs or accounts, or even a supplier's infrastructure.

✔ 12. Forge a Tagging Strategy  
Securing your resources is tricky when you can't identify them in the first place - let alone keep track of what happens after. When it comes to setting up and optimizing your cloud, an effective resource tagging strategy is a must.

If you're unsure what to do here, our detailed tagging guide & best practices is a must-read.

Implementation:
Added default tags to all resources

13. Implement Monitoring & Automation
After all the effort, it would be silly not to utilize AWS Config, or a time-saving alternative like Hyperglance, to make sure that your best practices stay that way.

The best-in-class cloud security tools include hundreds of rule-based checks (here are Hyperglance's security checks as an example). Also, look out for codeless implementations, the ability to customise and create your own rules, as well as flexible notification options (e.g. SNS, email, Slack).

Ideally, choose a tool that also lets you plug all those checks into a suite of automations. Having the option to automate remediations is a gamechanger for most, and will save your team valuable time and risk. Also, look for a tool that has built-in cost management - chances are that it'll quickly pay for itself, potentially many times over.

