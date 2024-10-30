## Comandos

- shell redis ```./dev redis``` -> useful command -> ```LRANGE sensor_data 0 -1```
- shell postgres ```./dev postgres``` -> password: password
- shell java ```./dev up```
- compilar ```mvn clean package```
- rodar ```java -jar target/java-sensor-app-1.0-SNAPSHOT-jar-with-dependencies.jar```



## Pendecias

- ~~resolver while true do postgres processor~~
- opcao de remover dados do redis apos serem salvos no postgres
- eliminar queue da aplicação principal e colocar os dados direto no redis
- se possivel colocar algum log para ver a eficiencia do redis