# Neo4j
  
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

## Match simples 
```` 
```` 
