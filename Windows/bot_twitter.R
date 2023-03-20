pacman::p_load(tidyverse,RSelenium,netstat,wdman)

setwd("C:/Users/hk")

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
rD <- rsDriver(browser=c("chrome"),chromever = "111.0.5563.64",verbose = T, port=free_port())
remDr <- rD$client

remDr$navigate("https://transparencia.unicamp.br/paginas/casos-positivos-semanais-hc/")
Sys.sleep(3)
# DOWNLOAD CASOS - HC
hc = remDr$findElement(
  using = "xpath",
  value = "/html/body/div/main/div[2]/div/div[2]/div/div[2]/div[1]/div[3]/div/div[2]/div/div/img[1]")$clickElement()
Sys.sleep(3)


hc <- read.csv("Downloads/casos-positivos-semanais-hc.csv",sep = "|")[1,] %>% 
  select(Unidade,Semanas,Positivos = "Total.Casos.Positivos")
#############################################################################

# CASOS - CECOM -----------------------------------------------------------
remDr$navigate("https://transparencia.unicamp.br/paginas/casos-positivos-semanais-cecom/")
Sys.sleep(3)
# DOWNLOAD CASOS - CECOM
cecom = remDr$findElement(
  using = "xpath",
  value = "/html/body/div[1]/main/div[2]/div/div[2]/div/div[2]/div[2]/div[3]/div/div[2]/div/div/img[1]")$clickElement()
Sys.sleep(3)

cecom <- read.csv("Downloads/casos-positivos-semanais-cecom.csv",sep = "|")[1,] %>% 
  select(Unidade,Semanas,Positivos)
#############################################################################

# CASOS - CAISM -----------------------------------------------------------
remDr$navigate("https://transparencia.unicamp.br/paginas/casos-positivos-semanais-caism/")
Sys.sleep(3)
# DOWNLOAD CASOS - CAISM
caism = remDr$findElement(
  using = "xpath",
  value = "/html/body/div[1]/main/div[2]/div/div[2]/div/div[2]/div[1]/div[3]/div/div[2]/div/div/img[1]")$clickElement()
Sys.sleep(3)

caism <- read.csv("Downloads/casos-positivos-semanais-caism.csv",sep = "|")[1,] %>% 
  select(Unidade,Semanas,Positivos = "Total.Casos.Positivos")
#############################################################################


# TWITTER LOGIN -----------------------------------------------------------
# cria um rsClientServer(abre um navegador)
# salva o remote driver em um objeto apenas

# URL(acessa um site)
remDr$navigate("https://twitter.com/i/flow/login")
Sys.sleep(3)
# Encontrar elemento
username = remDr$findElement(
  using = "xpath",
  value = "/html/body/div/div/div/div[1]/div/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div/div/div/div[5]/label/div/div[2]/div/input")

username$clickElement()
Sys.sleep(2)
username$sendKeysToElement(list("HKBragada"))

av_1 <- remDr$findElement(
  "xpath",
  value = "/html/body/div/div/div/div[1]/div/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div/div/div/div[6]/div"
)$clickElement()

Sys.sleep(2)
senha <- remDr$findElement(
  "xpath",
  "/html/body/div/div/div/div[1]/div/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div[1]/div/div/div[3]/div/label/div/div[2]/div[1]/input")

senha$sendKeysToElement(list("Ihavemacbook13?"))

login <- remDr$findElement(
  "xpath",
  "/html/body/div/div/div/div[1]/div/div/div/div/div/div/div[2]/div[2]/div/div/div[2]/div[2]/div[2]/div/div[1]/div/div/div/div"
)$clickElement()
Sys.sleep(3)
####################################################################



# TWEET -------------------------------------------------------------------
tweetar <- remDr$findElement(
  "xpath",
  "/html/body/div[1]/div/div/div[2]/header/div/div/div/div[1]/div[3]/a/div"
  
  #"/html/body/div[1]/div/div/div[2]/header/div/div/div/div[1]/div[3]/a/div/span/div/div/span/span"
)
tweetar$clickElement()
Sys.sleep(2)
tweet_texto <- remDr$findElement(
  "xpath",
  "/html/body/div[1]/div/div/div[1]/div[2]/div/div/div/div/div/div[2]/div[2]/div/div/div/div[3]/div[2]/div[1]/div/div/div/div/div[2]/div[1]/div/div/div/div/div/div[2]/div/div/div/div/label/div[1]/div/div/div/div/div/div[2]/div"
)
Sys.sleep(2)
tweet_texto$sendKeysToElement(list(paste0("⚠ ATUALIZAÇÃO - COVID ⚠","\n", "\n",
                                          "▫ Fonte: https://transparencia.unicamp.br/","\n","\n",
                                          "▫ Semana: ",hc %>% pull(Semanas),"\n","\n",
                                          "▫ Número de casos confirmados de COVID (#coranavirus) nos ambientes hospitalares da UNICAMP (@unicampoficial)","\n","\n",
                                          "▫️",hc %>% pull(Unidade), ": ", hc %>% pull(Positivos), " casos","\n",
                                          "▫️",cecom %>% pull(Unidade), ": ", cecom %>% pull(Positivos), " casos","\n",
                                          "▫️",caism %>% pull(Unidade), ": ", caism %>% pull(Positivos), " casos")))


publicar_tweet <- remDr$findElement(
  "xpath",
  "/html/body/div[1]/div/div/div[1]/div[2]/div/div/div/div/div/div[2]/div[2]/div/div/div/div[3]/div[2]/div[1]/div/div/div/div/div[2]/div[3]/div/div/div[2]/div[4]/div/span/span"
)$clickElement()

remDr$close()
###########################################################################


