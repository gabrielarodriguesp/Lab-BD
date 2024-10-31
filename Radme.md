## Comandos

- shell redis ```./dev redis``` -> useful command -> ```LRANGE sensor_data 0 -1```
- shell postgres ```./dev postgres``` -> password: password
- shell java ```./dev up```
- compilar ```mvn clean package```
- rodar ```java -jar target/java-sensor-app-1.0-SNAPSHOT-jar-with-dependencies.jar```



## Pendecias

- resolver while true do postgres processor
- opcao de remover dados do redis apos serem salvos no postgres
- eliminar queue da aplicação principal e colocar os dados direto no redis
- se possivel colocar algum log para ver a eficiencia do redis

## Redis Commands

### Comandos Gerais:

- ```PING```: Verifica se o servidor Redis está em execução. Se estiver, retorna PONG.
- ```AUTH <senha>```: Autentica no servidor Redis que requer uma senha.
- ```INFO:``` Exibe informações e estatísticas do servidor.
- ``CONFIG GET <parâmetro>``: Recupera os parâmetros de configuração.
- ``CONFIG SET <parâmetro> <valor>``: Define os parâmetros de configuração.
- ``CLIENT LIST``: Lista os clientes conectados.

### Comandos de Chave:

- ``SET <chave> <valor>``: Define uma chave para armazenar o valor especificado.
- ``GET <chave>``: Recupera o valor da chave especificada.
- ``DEL <chave>``: Deleta a(s) chave(s) especificada(s).
- ``EXISTS <chave>``: Verifica se a chave existe.
- ``EXPIRE <chave> <segundos>``: Define um tempo de expiração para uma chave.
- ``TTL <chave>``: Retorna o tempo de vida (TTL) de uma chave.
- ``KEYS <padrão>``: Retorna todas as chaves que correspondem a um determinado padrão (não recomendado para produção).

### Comandos de Lista:

- ``RPUSH <chave> <valor>``: Adiciona um valor no final de uma lista.
- ``LPUSH <chave> <valor>``: Adiciona um valor no início de uma lista.
- ``LPOP <chave>``: Remove e retorna o primeiro elemento de uma lista.
- ``RPOP <chave>``: Remove e retorna o último elemento de uma lista.
- ``LRANGE <chave> <início> <fim>``: Recupera elementos de uma lista dentro do intervalo especificado.

### Comandos de Hash:

- ``HSET <chave> <campo> <valor>``: Define o valor de um campo em um hash.
- ``HGET <chave> <campo>``: Recupera o valor de um campo em um hash.
- ``HDEL <chave> <campo>``: Deleta um campo de um hash.
- ``HGETALL <chave>``: Recupera todos os campos e valores de um hash.

### Comandos de Conjunto:

- ``SADD <chave> <membro>``: Adiciona um membro a um conjunto.
- ``SMEMBERS <chave>``: Retorna todos os membros de um conjunto.
- ``SREM <chave> <membro>``: Remove um membro de um conjunto.

### Comandos de Conjunto Ordenado:

 - ```ZADD <chave> <pontuação> <membro>```: Adiciona um membro a um conjunto ordenado com uma pontuação.
 - ``ZRANGE <chave> <início> <fim>``: Retorna membros dentro de um intervalo por índice.
 - ``ZREM <chave> <membro>``: Remove um membro de um conjunto ordenado.

### Comandos de Pub/Sub:

- ``PUBLISH <canal> <mensagem>``: Publica uma mensagem em um canal.
- ``SUBSCRIBE <canal>``: Inscreve-se em um canal para receber mensagens.
- ``UNSUBSCRIBE <canal>``: Cancela a inscrição em um canal.

### Comandos de Transação:

- ``MULTI``: Inicia uma transação.
- ``EXEC``: Executa uma transação.
- ``DISCARD``: Desfaz uma transação.
- ``WATCH`` <chave>: Monitora uma chave para alterações antes de executar uma transação.

### Comandos de Persistência:

- ``SAVE``: Salva o dataset no disco de forma síncrona.
- ``BGSAVE``: Salva o dataset no disco de forma assíncrona.
- ``LASTSAVE``: Retorna o timestamp UNIX da última vez que o dataset foi salvo com sucesso no disco.