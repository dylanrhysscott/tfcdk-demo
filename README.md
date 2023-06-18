# CDKTF Demo

A demo of the Terraform CDK [https://developer.hashicorp.com/terraform/cdktf](https://developer.hashicorp.com/terraform/cdktf).

## Pre requistes 

* CDKTF - [https://developer.hashicorp.com/terraform/tutorials/cdktf/cdktf-install#install-cdktf](https://developer.hashicorp.com/terraform/tutorials/cdktf/cdktf-install#install-cdktf)

## Overview

This demo creates:

* A VPC with an existing Terraform module written in regular HCL as Terraform files
* A VPC written natively in Go using the SDK
* Each VPC is maintained in a different state file using two different stacks
* To deploy run `make` and to destroy run `make destroy-all`