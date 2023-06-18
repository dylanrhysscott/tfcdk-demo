package main

import (
	existingvpc "cdk.tf/go/stack/generated/vpc"
	"github.com/aws/constructs-go/constructs/v10"
	"github.com/aws/jsii-runtime-go"
	"github.com/cdktf/cdktf-provider-aws-go/aws/v15/provider"
	nativevpc "github.com/cdktf/cdktf-provider-aws-go/aws/v15/vpc"
	"github.com/hashicorp/terraform-cdk-go/cdktf"
)

type MultiStackConfig struct {
	Region    string
	useNative bool
}

func NewMultiStack(scope constructs.Construct, id string, name string, config MultiStackConfig) cdktf.TerraformStack {
	var stack cdktf.TerraformStack
	if config.useNative {
		// If native is set create a VPC using the CDKTF directly in Golang
		stack = cdktf.NewTerraformStack(scope, &id)
		provider.NewAwsProvider(stack, jsii.String("AWS"), &provider.AwsProviderConfig{
			Region: jsii.String(config.Region),
		})
		nativevpc.NewVpc(stack, jsii.String(name), &nativevpc.VpcConfig{
			CidrBlock: jsii.String("10.100.0.0/16"),
			Tags: &map[string]*string{
				"Name": &name,
			},
		})
	} else {
		// If native is not set creating using a regular Terraform module. The CDK when run
		// will generate Go files from the module code so it can be executed programatically
		stack = cdktf.NewTerraformStack(scope, &id)
		provider.NewAwsProvider(stack, jsii.String("AWS"), &provider.AwsProviderConfig{
			Region: jsii.String(config.Region),
		})
		existingvpc.NewVpc(stack, jsii.String(name), &existingvpc.VpcConfig{
			Name: jsii.String(name),
		})
	}

	return stack
}

func main() {
	app := cdktf.NewApp(nil)
	// One stack (state file) using native SDK
	NewMultiStack(app, "native-module", "native-vpc", MultiStackConfig{
		Region:    "eu-west-2",
		useNative: true,
	})
	// One stack (state file) using a generated Terraform module code in the SDK
	NewMultiStack(app, "existing-module", "existing-vpc", MultiStackConfig{
		Region:    "eu-west-2",
		useNative: false,
	})
	app.Synth()
}
