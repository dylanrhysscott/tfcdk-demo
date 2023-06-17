#!/bin/bash

# Currently broken https://github.com/hashicorp/terraform-cdk/issues/2882
cat main.tf | cdktf convert --provider hashicorp/aws --language go