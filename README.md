# BOT-TWITTER-COVID - Linux e Windows

O material desse repositório é um projeto desenvolvido por mim: https://www.linkedin.com/in/henrique-bragada-6a5967222/

O conjunto de arquivos desse repositório tem como objetivo publicar semanalmente tweets com o número de casos confirmados de COVID dentro dos ambientes hospitalares da UNICAMP, disponibilizados em https://transparencia.unicamp.br/, em uma conta no TWITTER (no caso a conta utilizada por mim se encontra em: https://twitter.com/HKBragada). 

O projeto visa demonstrar parte do meu conhecimento em web scraping e tarefas de automação dentro da web/internet utilizando a linguagem de programação R.

# Descrição dos arquivos:
O arquivo bot_twitter.R é um script criado a partir da linguagem R. O script é responsável por:
  
  * Baixar os dados da COVID (casos confirmados) dos ambiente hospitalares da UNICAMP (HC, CECOM e CAISM)
  * Extrair informações relevantes do banco de dados
  * Logar em uma conta do TWITTER (https://twitter.com/HKBragada)
  * Publicar um tweet com o número de casos confirmados em casa ambiente hospitalar 
  
Tal script é executado de forma automática e periódica a partir de uma execução única do script automacao_bot_twitter.R, de modo que, as tarefas realizadas em bot_twitter.R podem ser programadas para serem repetidas segundo a frequência e horário inseridas em automacao_bot_twitter.R, segundo as regras de expressão crontab que podem ser melhor compreendidas em: https://crontab.guru/
