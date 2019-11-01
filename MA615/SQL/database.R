library(tidyverse)
library(RSQLite)
library(DBI)
library(readxl)

contrib_all = read_excel("Top MA Donors 2016-2020.xlsx",
                         sheet = "Direct Contributions & JFC Dist")

Field = read_excel("Top MA Donors 2016-2020.xlsx",
                   sheet = "Field Descriptions")


## code from Kerui Cao
contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = ", ",replacement = ",")

contrib_all['contrib'] = gsub(contrib_all$contrib,pattern = "\\s\\w*",replacement = "")


contribution = select(contrib_all, cycle, contribid, fam, date,amount, recipid, type, fectransid, cmteid) %>% distinct()
contributor = select(contrib_all, contribid, fam, contrib, City, State, Zip, Fecoccemp,orgname,lastname) %>% distinct()
recipient = select(contrib_all, recipid,party, recipient,recipcode) %>% distinct()
organization = select(contrib_all, orgname, ultorg) %>% distinct() %>% na.omit()


Con = dbConnect(SQLite(),"Yiru_Fei.sqlite")
dbWriteTable(Con,"Contribution",contribution)
dbWriteTable(Con,"Contributor",contributor)
dbWriteTable(Con,"Recipient",recipient)
dbWriteTable(Con,"Organization",organization)



