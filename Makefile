all: app gems rails

app:
	docker build -t atlantico-portugues .

gems:
	docker build -f docker/gems/Dockerfile -t niltonvasques/atlantico-gems .

rails:
	docker build -f docker/rails/Dockerfile -t niltonvasques/rails .

run:
	docker run --name atlantico-portugues-server -p 8080:3000 -d atlantico-portugues
	echo "RUNNING IN http://localhost:8080"
