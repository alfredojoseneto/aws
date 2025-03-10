# AWS

This repository contains AWS automation codes related to Bootcamp Imersão AWS
that was teached by Henrylle Maia.


## How to use

These scripts are organized in a way that allow to understand how each part of
the proccess to lunch an EC2 intance and connect to it using ssm tunnel works.

The principals arguments to run the scripts are:
- profile
- instance_name


### How to initialize an instance 

```bash
$ source ./scripts/start_instance.sh && start <profile> <instance-name>
```


### How to stop an instance

```bash
$ source ./scripts/stop_instance.sh && stop <profile> <instance-name>
```


### How to connect to an EC2 instance using tunnel

To this connection the *port number* was provided as 3001 to ec2 instance and localhost.

```bash

$ ./connect_ec2_gateway.sh <profile> <instance-name>
```