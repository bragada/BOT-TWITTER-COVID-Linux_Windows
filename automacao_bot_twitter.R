library(cronR)

script <- cron_rscript("Portifolio/bot_twitter.Rbot.R")

cron_add(script,frequency = "27 12 * * 1",description = "twitter bot")