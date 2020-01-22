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

docker-compose logs -f dremio

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

