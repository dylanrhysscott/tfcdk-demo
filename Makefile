all:
	cdktf get
	make native-deploy
	make existing-deploy


destroy-all:
	make native-destroy
	make existing-destroy

native-deploy:
	cdktf deploy native-module

existing-deploy:
	cdktf deploy existing-module

native-destroy:
	cdktf destroy native-module

existing-destroy:
	cdktf destroy existing-module