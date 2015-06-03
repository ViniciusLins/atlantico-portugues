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

run-server:
	docker run --name=atlantico-container --volumes-from atlantico-data -w /home/app/atlantico-portugues --rm -p 80:80  atlantico-server  

server:
	docker build -f docker/server/Dockerfile -t atlantico-server .
	docker create -v /home/app/atlantico-portugues/public/system -v /home/app/atlantico-portugues/public/uploads --name atlantico-data atlantico-server /bin/true


run-digitalocean:
	docker run --name container-postgres -e POSTGRES_PASSWORD=atlantico -d postgres
	docker run --name=atlantico-container --link container-postgres:postgres --volumes-from atlantico-data -w /home/app/atlantico-portugues -d -p 80:80  atlantico-server
