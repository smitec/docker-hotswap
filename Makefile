.PHONY: build
build:
	cd nginx; docker build -t nginx .
	cd flask; docker build -t flask .
	cd flask2; docker build -t flask2 .

.PHONY: start
start:
	docker run -t -i -d -p 8000:8000 --name flask flask
	docker run -t -i -d --name nginx \
		--link flask:primary \
		--add-host='secondary:127.0.0.1' \
		-p 8080:80 nginx

.PHONY: swap
swap:
	docker run -t -i -d -p 8001:8000 --name flask2 flask2
	$(eval IP = $(shell docker inspect --format '{{ .NetworkSettings.IPAddress }}' flask2))
	echo $(IP)
	docker exec nginx cp /etc/hosts /oldhosts
	docker exec nginx sed -i "s/.*secondary/$(IP)$(shell echo "\t")secondary/" /oldhosts
	docker exec nginx dd if=/oldhosts of=/etc/hosts
	docker exec nginx rm /oldhosts
	docker exec nginx service nginx reload
	docker stop flask

ragequit:
	docker ps -a | awk 'NR>1 {print $$1}' | xargs  docker stop
	docker ps -a | awk 'NR>1 {print $$1}' | xargs  docker rm
