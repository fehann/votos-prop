# libraries
library(tidyverse)

# working with APIs
library(httr)

# working with XML file
library(XML)
library(xml2)
library(plyr)

# dataset
# votos para determinada proposição - http://www2.camara.leg.br/transparencia/dados-abertos/dados-abertos-legislativo/webservices/proposicoes-1/obtervotacaoproposicao
url  <- "https://www.camara.leg.br"
path <- "SitCamaraWS/Proposicoes.asmx/ObterVotacaoProposicao?tipo=PEC&numero=282&ano=2016"
raw_result <- GET(url = url, path = path)
# check status, 200 is OK. Status codes: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes
status_code(raw_result)
print(raw_result)

# XML data
# source: https://stackoverflow.com/questions/17198658/how-to-parse-xml-to-r-data-frame
data_proposicao <- xmlParse(raw_result)
xmlToList(data_proposicao)

# testing to confirm if it is an XML file - https://www.coursera.org/learn/data-cleaning/lecture/cieIu/reading-xml
doc <- xmlTreeParse(raw_result,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)

# Testando como acessar os valores do XML
rootNode[[1]]
rootNode[[4]][[1]][[2]]

# Consegui loadar o arquivo XML e consigo acessar os valores no primeiro nível do rootNode (Sigla, Numero, Ano), mas não estou conseguindo entender como acessar a lista Votacoes (é uma lista que dentro dela tem outra lista com os votos de cada deputado). Tentei varias coisas, inclusive o comando abaixo. O objetivo, caso esteja pensando correto, é extrair os dados do XML para um data frame com todos os dados arrumados. Tem alguma ideia?
votacao <- xmlSApply(rootNode,"//Votacao",xmlValue)
votacao

