package main

import (
	"cdk.tf/go/stack/generated/vpc"
	"github.com/aws/constructs-go/constructs/v10"
	"github.com/aws/jsii-runtime-go"
	"github.com/hashicorp/terraform-cdk-go/cdktf"
)

func NewMyStack(scope constructs.Construct, id string) cdktf.TerraformStack {
	stack := cdktf.NewTerraformStack(scope, &id)

	vpc.NewVpc(stack, jsii.String("AWS"), &vpc.VpcConfig{
		Name: jsii.String("vpc-from-existing"),
	})
	return stack
}

func main() {
	app := cdktf.NewApp(nil)

	NewMyStack(app, "existing-module")

	app.Synth()
}
