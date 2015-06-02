all: rails data gems dev

dev:
	docker build -f docker/dev/Dockerfile -t atlantico-portugues .

gems:
	docker build -f docker/gems/Dockerfile -t niltonvasques/atlantico-gems .

rails:
	docker build -f docker/rails/Dockerfile -t niltonvasques/rails .
data:
	docker create -v /usr/src/app/public/system -v /usr/src/app/public/uploads --name container-data niltonvasques/rails /bin/true

run-dev:
	docker run --name atlantico-portugues-server -p 8080:3000 -d --volumes-from container-data atlantico-portugues
	echo "RUNNING IN http://localhost:8080"
