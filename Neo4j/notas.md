# Neo4j

## Cheatsheet
  * [Cheatsheet](https://neo4j.com/docs/cypher-refcard/current/)

## Fazer reset a um schema
````cypher

````
  
## Merge de nodos + ligações
````cypher
MERGE (u1:PROC_FUNC { name: "PCK_COMMON.SP_GETWITHDRAWAMOUNT" }) MERGE (u2:PROC_FUNC { name:"PCK_COMMON.FC_GETMORTGAGEVALUE" }) MERGE (u1)-[:CALLS]-(u2)
with 1 as dummy 
```` 

## Ligação entre dois nodos
````cypher
MATCH (f{name:"PN.INSERT_ORDER"})-[:CALLS*1..3]-(m)-[:CALLS*1..3]-(e:EVENTO) return f, m, e
```` 

## Menor ligação (direccionada) entre 2 nodos 
```` 
MATCH (f{name:"PN.INSERT_ORDER"}),(e:EVENTO{name:"0103"}), p = shortestPath((e)-[*..15]->(f)) RETURN p
```` 

## Links 
  * [Quickly create example graph data for Neo4j using form fields in a Browser Guide](https://www.youtube.com/watch?v=9ejX6JWky6o)
