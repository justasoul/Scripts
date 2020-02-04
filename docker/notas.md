# Docker

## Ver lista de volumes 
  
````
docker volume list 
````

## Ver onde um dado volume está mounted

```` 

docker inspect <nome_ou_id_do_volume>

```` 

# Docker Compose
  
## Ver logs de um dado container

```` 

docker-compose logs -f <nome_do_container>

```` 

## Parar um dado container

```` 

docker-compose stop <nome_do_container>

```` 


## Iniciar um dado container

```` 

docker-compose start <nome_do_container>

```` 

## "Reboot-ar" um container
  
````
docker-compose stop <nome_do_container>
docker-compose rm <nome_do_container>
docker-compose start <nome_do_container>

```` 

## Ver o estado dos vários containers

```` 

docker-compose status

```` 

## Ligar a linha de commandos de um dado container

```` 

docker-compose exec <nome_do_container> bash

```` 

## Forçar um container que esteja a dar erro e a ser imediatamente reiniciado, a ficar a executar na mesma
[Link](https://vsupalov.com/debug-docker-compose-service/)
````
Adicionar isto ao docker-compose.yml para o container em causa:
entrypoint: ["sh", "-c", "sleep 2073600"]
````
  
## Abrir uma consola dentro de um container que esteja a correr
  
````
docker-compose exec SERVICE_NAME bash
````
  
## Projectos Interessantes 
  
````
  * https://github.com/Trendyol/docker-shell
````
