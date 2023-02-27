# CARREGA OS PACOTES NECESSARIOS
pacman::p_load(tidyverse,RSelenium,RCurl,wdman)

# LOGICA RESPONSAVEL POR MANTER APENAS UM ARQUIVO NO COMPUTADOR/SERVIDOR UMA VEZ QUE OS DADOS ATUALIZADOS CONTÉM AS OBSERVACOES ANTIGAS
if(file.exists("Downloads/casos-positivos-semanais-hc.csv")) {
  file.remove("Downloads/casos-positivos-semanais-hc.csv")
}
if(file.exists("Downloads/casos-positivos-semanais-cecom.csv")) {
  file.remove("Downloads/casos-positivos-semanais-cecom.csv")
}
if(file.exists("Downloads/casos-positivos-semanais-caism.csv")) {
  file.remove("Downloads/casos-positivos-semanais-caism.csv")
}


# CASOS - HC --------------------------------------------------------------
# ABRE O NAVEGADOR COMO UM BOT
rD <- rsDriver(browser=c("firefox"), chromever = NULL,check = T, iedrver = NULL)
remDr <- rD$client

# ACESSA O SITE 
remDr$navigate("https://transparencia.unicamp.br/paginas/casos-positivos-semanais-hc/")
Sys.sleep(3)

# DOWNLOAD CASOS - HC
hc = remDr$findElement(
  using = "xpath",
  value = "/html/body/div/main/div[2]/div/div[2]/div/div[2]/div[1]/div[3]/div/div[2]/div/div/img[1]")$clickElement()
Sys.sleep(3)
remDr$close()

# EXTRAI INFORMACOES DO COVID E DA UNIDADE HOSPITALAR 
hc <- read.csv("Downloads/casos-positivos-semanais-hc.csv",sep = "|")[1,] %>% 
  select(Unidade,Semanas,Positivos = "Total.Casos.Positivos")
#############################################################################

# ESSA SECCAO EXECUTA AS MESMAS TAREFAS QUE FORAM FEITAS EM # CASOS - HC
# CASOS - CECOM -----------------------------------------------------------
rD <- rsDriver(browser=c("firefox"), chromever = NULL,check = T, iedrver = NULL)
remDr <- rD$client

remDr$navigate("https://transparencia.unicamp.br/paginas/casos-positivos-semanais-cecom/")
Sys.sleep(3)
# DOWNLOAD CASOS - CECOM
cecom = remDr$findElement(
  using = "xpath",
  value = "/html/body/div[1]/main/div[2]/div/div[2]/div/div[2]/div[2]/div[3]/div/div[2]/div/div/img[1]")$clickElement()
Sys.sleep(3)
remDr$close()

cecom <- read.csv("Downloads/casos-positivos-semanais-cecom.csv",sep = "|")[1,] %>% 
  select(Unidade,Semanas,Positivos)
#############################################################################

# ESSA SECCAO EXECUTA AS MESMAS TAREFAS QUE FORAM FEITAS EM # CASOS - HC e # CASOS - CECOM
# CASOS - CAISM -----------------------------------------------------------
rD <- rsDriver(browser=c("firefox"), chromever = NULL,check = T, iedrver = NULL)
remDr <- rD$client

remDr$navigate("https://transparencia.unicamp.br/paginas/casos-positivos-semanais-caism/")
Sys.sleep(3)
# DOWNLOAD CASOS - CAISM
caism = remDr$findElement(
  using = "xpath",
  value = "/html/body/div[1]/main/div[2]/div/div[2]/div/div[2]/div[1]/div[3]/div/div[2]/div/div/img[1]")$clickElement()
Sys.sleep(3)
remDr$close()

caism <- read.csv("Downloads/casos-positivos-semanais-caism.csv",sep = "|")[1,] %>% 
  select(Unidade,Semanas,Positivos = "Total.Casos.Positivos")
#############################################################################


# SECCAO RESPONSAVEL POR FAZER O LOGIN DA CONTA NO TWITTER 
# TWITTER LOGIN -----------------------------------------------------------
rD <- rsDriver(browser=c("firefox"), chromever = NULL,check = T, iedrver = NULL)
# salva o remote driver em um objeto apenas
remDr <- rD$client

remDr$navigate("https://twitter.com/i/flow/login")
Sys.sleep(2)

username = remDr$findElement(
  using = "xpath",
  value = "/html/body/div/div/div/div[1]/div/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div/div/div/div[5]/label/div/div[2]/div/input")

username$clickElement()
Sys.sleep(2)

## INSERE O USERNAME DA CONTA DO TWITTER
username$sendKeysToElement(list("USERNAME"))

av_1 <- remDr$findElement(
  "xpath",
  value = "/html/body/div/div/div/div[1]/div/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div/div/div/div[6]/div"
)$clickElement()

Sys.sleep(2)
senha <- remDr$findElement(
  "xpath",
  "/html/body/div/div/div/div[1]/div/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div[1]/div/div/div[3]/div/label/div/div[2]/div[1]/input")

# INSERE A SENHA DA CONTA DO TWITTER
senha$sendKeysToElement(list("PASSAWORD"))

login <- remDr$findElement(
  "xpath",
  "/html/body/div/div/div/div[1]/div/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div[2]/div/div[1]/div/div/div/div"
)$clickElement()
Sys.sleep(1)
####################################################################


# SECCAO RESPONSAVEL POR PUBLICAR O TWEET 
# TWEET -------------------------------------------------------------------
tweetar <- remDr$findElement(
  "xpath",
  "/html/body/div[1]/div/div/div[2]/header/div/div/div/div[1]/div[3]/a/div/span/div/div/span/span"
)
tweetar$clickElement()
Sys.sleep(2)
tweet_texto <- remDr$findElement(
  "xpath",
  "/html/body/div[1]/div/div/div[1]/div[2]/div/div/div/div/div/div[2]/div[2]/div/div/div/div[3]/div[2]/div[1]/div/div/div/div/div[2]/div[1]/div/div/div/div/div/div[2]/div/div/div/div/label/div[1]/div/div/div/div/div/div[2]/div"
)
Sys.sleep(2)
tweet_texto$sendKeysToElement(list(paste0("⚠ ATUALIZAÇÃO - COVID ⚠","\r","\r",
                                          "🔗 Fonte:https://transparencia.unicamp.br/","\r\r",
                                          "📅 Semana: ",hc %>% pull(Semanas),"\r\r",
                                          "📈 Número de casos confirmados de COVID (#coranavirus) nos ambientes hospitalares da UNICAMP (@unicampoficial)","\r\r",
                                          "▫️",hc %>% pull(Unidade), ": ", hc %>% pull(Positivos), " casos","\r",
                                          "▫️",cecom %>% pull(Unidade), ": ", cecom %>% pull(Positivos), " casos","\r",
                                          "▫️",caism %>% pull(Unidade), ": ", caism %>% pull(Positivos), " casos")))
publicar_tweet <- remDr$findElement(
  "xpath",
  "/html/body/div[1]/div/div/div[1]/div[2]/div/div/div/div/div/div[2]/div[2]/div/div/div/div[3]/div[2]/div[1]/div/div/div/div/div[2]/div[3]/div/div/div[2]/div[4]/div/span/span"
)$clickElement()

remDr$close()
###########################################################################


