# CARREGA O PACOTE RESPONSAVEL PELA AUTOMACAO
library(cronR)

# CRIA UM COMANDO PARA A EXECUCAO DO SCRIPT
script <- cron_rscript("Portifolio/script_bot.R")

# AUTOMATIZA AS TEREFAS PRESENTES NO SCRIPT 
# i.e EXECUTA O SCRIPT semanalmente nas segundas as 12:27AM 
cron_add(script,frequency = "27 12 * * 1",description = "twitter bot")
