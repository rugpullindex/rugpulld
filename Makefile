# NOTE: We include all variables from our env file
# # - Via: https://unix.stackexchange.com/a/348432
include .env
export

.PHONY: setup
setup:
	curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
	sudo apt-get install -y nodejs
	npm i --ignore-scripts

.PHONY: run
run:
	nohup node -r dotenv/config --no-warnings ./src/launch.mjs &

.PHONY: deploy
deploy:
	rsync -avz . root@$(IPV4):./rugpulld --exclude="node_modules" --exclude=".env" --exclude=".git"

.PHONY: connect
connect:
	ssh root@$(IPV4)
