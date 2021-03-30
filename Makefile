.PHONY: build clean deploy gomodgen

build: gomodgen
	export GO111MODULE=on
	env GOOS=linux go build -ldflags="-s -w" -o bin/hello hello/main.go
	env GOOS=linux go build -ldflags="-s -w" -o bin/world world/main.go

clean:
	rm -rf ./bin ./vendor go.sum

deploy: clean build
	sls deploy --verbose
deploy-dev: clean build
	sls deploy --verbose --stage dev
deploy-stg: clean build
	sls deploy --verbose --stage stg

remove:
	sls remove
remove-dev:
	sls remove --stage dev

gomodgen:
	chmod u+x gomod.sh
	./gomod.sh
