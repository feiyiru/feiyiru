library(tidyverse)
library(RSQLite)
library(DBI)
library(readxl)

contrib_all = read_excel("Top MA Donors 2016-2020.xlsx",
                         sheet = "Direct Contributions & JFC Dist")

Field = read_excel("Top MA Donors 2016-2020.xlsx",
                   sheet = "Field Descriptions")


contrib_all$contrib[contrib_all$contrib == "SLIFKA, RICHARD B"] = "SLIFKA, RICHARD"
contrib_all$contrib[contrib_all$contrib == "RASKY, LAWRENCE B"] = "RASKY, LAWRENCE"
contrib_all$contrib[contrib_all$contrib == "SLIFKA, RICHARD BARRY"] = "SLIFKA, RICHARD"
contrib_all$contrib[contrib_all$contrib == "SLIFKA, ROSALYN ROSALYN"] = "SLIFKA, ROSALYN"
contrib_all$contrib[contrib_all$contrib == "SLIFKA, RICHARD MR"] = "SLIFKA, RICHARD"
contrib_all$contrib[contrib_all$contrib == "ABERLY, NAOMI D"] = "ABERLY, NAOMI"
contrib_all$contrib[contrib_all$contrib == "ABERLY, NAOMI D MS"] = "ABERLY, NAOMI"
contrib_all$contrib[contrib_all$contrib == "ABERLY, NAOMI DIANA"] = "ABERLY, NAOMI"
contrib_all$contrib[contrib_all$contrib == "ATKIN S, CHESTER G"] = "ATKINS, CHESTER"
contrib_all$contrib[contrib_all$contrib == "ATKINS, CHESTER G"] = "ATKINS, CHESTER"
contrib_all$contrib[contrib_all$contrib == "ATKINS, CHESTER G MR"] = "ATKINS, CHESTER"
contrib_all$contrib[contrib_all$contrib == "ATKINS, CORINNE C"] = "ATKINS, CORINNE"
contrib_all$contrib[contrib_all$contrib == "ATKINS, CORY C"] = "ATKINS, CORY"
contrib_all$contrib[contrib_all$contrib == "BARZUN, MATTHEW W"] = "BARZUN, MATTHEW"
contrib_all$contrib[contrib_all$contrib == "BEKENSTEIN, ANITA S"] = "BEKENSTEIN, ANITA"
contrib_all$contrib[contrib_all$contrib == "BARZUN, MATTHEW SPIESSBACH"] = "BEKENSTEIN, ANITA"
contrib_all$contrib[contrib_all$contrib == "ATKINS, CHESTER GREENOUGH"] = "ATKINS, CHESTER"
contrib_all$contrib[contrib_all$contrib == "ATKINS, CHET O"] = "ATKINS, CHET"
contrib_all$contrib[contrib_all$contrib == "FEELEY, THOMAS M"] = "FEELEY, THOMAS"
contrib_all$contrib[contrib_all$contrib == "FEELEY, THOMAS M MR"] = "FEELEY, THOMAS"
contrib_all$contrib[contrib_all$contrib == "FISH, JOHN , , ,"] = "FISH, JOHN"
contrib_all$contrib[contrib_all$contrib == "FISH, JOHN D"] = "FISH, JOHN"
contrib_all$contrib[contrib_all$contrib == "FISH, JOHN F"] = "FISH, JOHN"
contrib_all$contrib[contrib_all$contrib == "FISH, JOHN F MR"] = "FISH, JOHN"
contrib_all$contrib[contrib_all$contrib == "BEKENSTEIN, JOSHUA M"] = "BEKENSTEIN, JOSHUA"
contrib_all$contrib[contrib_all$contrib == "BEKENSTEIN, JOSHUA B"] = "BEKENSTEIN, JOSHUA"
contrib_all$contrib[contrib_all$contrib == "BEKENSTEIN, JOSHUA MR"] = "BEKENSTEIN, JOSHUA"
contrib_all$contrib[contrib_all$contrib == "EGERMAN, JOANNE H"] = "EGERMAN, JOANNE"
contrib_all$contrib[contrib_all$contrib == "EGERMAN, JOANNE H MS"] = "EGERMAN, JOANNE"
contrib_all$contrib[contrib_all$contrib == "EGERMAN, JOANNE MS"] = "EGERMAN, JOANNE"
contrib_all$contrib[contrib_all$contrib == "SOLOMONT, SUSAN L"] = "SOLOMONT, SUSAN"
contrib_all$contrib[contrib_all$contrib == "SOLOMONT, SUSAN LEWIS"] = "SOLOMONT, SUSAN"
contrib_all$contrib[contrib_all$contrib == "ZWANZIGER, RON MR"] = "ZWANZIGER, RON"
contrib_all$contrib[contrib_all$contrib == "SOLOMONT, ALAN D"] = "SOLOMONT, ALAN"
contrib_all$contrib[contrib_all$contrib == "SOLOMONT, ALAN DANA"] = "SOLOMONT, ALAN"
contrib_all$contrib[contrib_all$contrib == "BEKENSTEIN, ANITA MS"] = "BEKENSTEIN, ANITA"
contrib_all$contrib[contrib_all$contrib == "BEKENSTEIN, ANITA SPIESSBACH"] = "BEKENSTEIN, ANITA"
contrib_all$contrib[contrib_all$contrib == "CITRIN, ANNE J"] = "CITRIN, ANNE"
contrib_all$contrib[contrib_all$contrib == "SCITRIN, JACOB"] = "SCITRIN, JACOB A"
contrib_all$contrib[contrib_all$contrib == "SIMMONS, IAN T"] = "SIMMONS, IAN"
contrib_all$contrib[contrib_all$contrib == "SIMMONS, IAN THORNE"] = "SIMMONS, IAN"
contrib_all$contrib[contrib_all$contrib == "RESNICK, STEWART A"] = "RESNICK, STEWART"
contrib_all$contrib[contrib_all$contrib == "RESNICK, LYNDA R"] = "RESNICK, LYNDA"
contrib_all$contrib[contrib_all$contrib == "RESNICK, LYNDA RAE"] = "RESNICK, LYNDA"
contrib_all$contrib[contrib_all$contrib == "RESNICK, LYNDA RAE"] = "RESNICK, LYNDA"
contrib_all$contrib[contrib_all$contrib == "RESNICK, LYNDA RAE R"] = "RESNICK, LYNDA"
contrib_all$contrib[contrib_all$contrib == "RESNICK, LYNDA RAE RAE"] = "RESNICK, LYNDA"
contrib_all$contrib[contrib_all$contrib == "FISH, CYNTHIA G"] = "FISH, CYNTHIA"
contrib_all$contrib[contrib_all$contrib == "FISH, CYNTHIA GELSTHORPE"] = "FISH, CYNTHIA"
contrib_all$contrib[contrib_all$contrib == "FISH, CYNTHIA MRS"] = "FISH, CYNTHIA"
contrib_all$contrib[contrib_all$contrib == "FISH, JOHN, F"] = "FISH, JOHN"
contrib_all$contrib[contrib_all$contrib == "HOSTETTER, AMOS B"] = "HOSTETTER, AMOS"
contrib_all$contrib[contrib_all$contrib == "HOSTETTER, BARBARA W"] = "HOSTETTER, BARBARA"
contrib_all$contrib[contrib_all$contrib == "HOSTETTER, BARBARA WALSH"] = "HOSTETTER, BARBARA"
contrib_all$contrib[contrib_all$contrib == "KANIN, CAROL A"] = "KANIN, CAROL"
contrib_all$contrib[contrib_all$contrib == "KANIN, CAROL ANN"] = "KANIN, CAROL"
contrib_all$contrib[contrib_all$contrib == "KANIN, DENNIS R"] = "KANIN, DENNIS"
contrib_all$contrib[contrib_all$contrib == "KANIN, DENNIS ROY"] = "KANIN, DENNIS"
contrib_all$contrib[contrib_all$contrib == "KRUPP, GEORGE D"] = "KRUPP, GEORGE"
contrib_all$contrib[contrib_all$contrib == "KRUPP, LIZBETH H"] = "KRUPP, LIZBETH"
contrib_all$contrib[contrib_all$contrib == "LAVINE, JEANNE B"] = "LAVINE, JEANNE"
contrib_all$contrib[contrib_all$contrib == "LAVINE, JEANNE BACHELOR"] = "LAVINE, JEANNE"
contrib_all$contrib[contrib_all$contrib == "LAVINE, JEANNE DIANE"] = "LAVINE, JEANNE"
contrib_all$contrib[contrib_all$contrib == "FEELEY, JOAN M MS"] = "FEELEY, JOAN"
contrib_all$contrib[contrib_all$contrib == "FEELEY, JOAN M"] = "FEELEY, JOAN"
contrib_all$contrib[contrib_all$contrib == "HOSTETTER, AMOS B OTHER JR"] = "HOSTETTER, AMOS"
contrib_all$contrib[contrib_all$contrib == "HOSTETTER, AMOS B,"] = "HOSTETTER, AMOS"
contrib_all$contrib[contrib_all$contrib == "HOSTETTER, AMOS JR"] = "HOSTETTER, AMOS"
contrib_all$contrib[contrib_all$contrib == "LAVINE, JEANNIE B"] = "LAVINE, JEANNIE"
contrib_all$contrib[contrib_all$contrib == "LAVINE, JEANNIE D"] = "LAVINE, JEANNIE"
contrib_all$contrib[contrib_all$contrib == "LAVINE, JEANNIE DIANE"] = "LAVINE, JEANNIE"
contrib_all$contrib[contrib_all$contrib == "LAVINE, JONATHAN S"] = "LAVINE, JONATHAN"
contrib_all$contrib[contrib_all$contrib == "LAVINE, JONATHAN SCOTT"] = "LAVINE, JONATHAN"
contrib_all$contrib[contrib_all$contrib == "ATKINS, CHET G"] = "ATKINS, CHET"
contrib_all$contrib[contrib_all$contrib == "BARZUN, BROOKE BROWN"] = "BARZUN, BROOKE"
contrib_all$contrib[contrib_all$contrib == "CITRIN, JACOB A"] = "CITRIN, JACOB"
contrib_all$contrib[contrib_all$contrib == "EGERMAN, PAUL & JOANNE"] = "EGERMAN, PAUL"
contrib_all$contrib[contrib_all$contrib == "EGERMAN, PAUL L"] = "EGERMAN, PAUL"
contrib_all$contrib[contrib_all$contrib == "EGERMAN, PAUL OTHER"] = "EGERMAN, PAUL"
contrib_all$contrib[contrib_all$contrib == "RASKY, LAWRENCE B MR"] = "RASKY, LAWRENCE"
contrib_all$contrib[contrib_all$contrib == "RASKY, LAWRENCE B,"] = "RASKY, LAWRENCE"
contrib_all$contrib[contrib_all$contrib == "RESNICK, STEWART A MR"] = "RESNICK, STEWART"
contrib_all$contrib[contrib_all$contrib == "RESNICK, STEWART ALLEN"] = "RESNICK, STEWART"
contrib_all$contrib[contrib_all$contrib == "RESNICK, STEWART MR"] = "RESNICK, STEWART"
contrib_all$contrib[contrib_all$contrib == "SABAN, CHERYL LYNN"] = "SABAN, CHERYL"
contrib_all$contrib[contrib_all$contrib == "SABAN, CHERYL PHD"] = "SABAN, CHERYL"
contrib_all$contrib[contrib_all$contrib == "SABAN, HAIM,,"] = "SABAN, HAIM"
contrib_all$contrib[contrib_all$contrib == "LEBOWITZ, LAURENCE H"] = "LEBOWITZ, LAURENCE"
contrib_all$contrib[contrib_all$contrib == "SCHUSTER, ELAINE M"] = "SCHUSTER, ELAINE"
contrib_all$contrib[contrib_all$contrib == "SIMMONS, LIESEL ANN PRITZKER"] = "SIMMONS, LIESEL"
contrib_all$contrib[contrib_all$contrib == "HOSTETTER, AMOS B JR"] = "HOSTETTER, AMOS"



contribution = select(contrib_all, cycle, contribid, fam, date,amount, recipid, type, fectransid, cmteid) %>% distinct()
contributor = select(contrib_all, contribid, fam, contrib, City, State, Zip, Fecoccemp,orgname,lastname) %>% distinct()
recipient = select(contrib_all, recipid,party, recipient,recipcode) %>% distinct()
organization = select(contrib_all, orgname, ultorg) %>% distinct() %>% na.omit()


Con = dbConnect(SQLite(),"Yiru.sqlite")
dbWriteTable(Con,"Contribution",contribution)
dbWriteTable(Con,"Contributor",contributor)
dbWriteTable(Con,"Recipient",recipient)
dbWriteTable(Con,"Organization",organization)



