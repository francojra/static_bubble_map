
# Static bubble map ------------------------------------------------------------------------------------------------------------------------
# Autoria do script: Jeanne Franco ---------------------------------------------------------------------------------------------------------
# Data: 29/05/22 ---------------------------------------------------------------------------------------------------------------------------
# Referência: The R Graph Galery -----------------------------------------------------------------------------------------------------------

# Conceito ---------------------------------------------------------------------------------------------------------------------------------

### ggplot2 é provavelmente a melhor opção para construir um estastíco bubble map.
### Ele oferece toda flexibilidade da gramática de gráficos, e permite reusar todo
### conhecimento que você aprendeu construindo outros tipos de gráficos. 

### Ele usa uma lista de coordenadas de GPS (latitude e longitude) e adiciona no topo 
### do mapa com tamanho e cor mapeados de acordo com os dados das variáveis numéricas.

### Esse script mostra o passo a passo para construir um mapa mostrando as 1000
### maiores cidades de UK.

# Passo a passo -------------------------------------------------------------------------------------------------------------------------

### O primeiro passo é obter os limites/fronteiras das zonas de interesse. Várias 
### opções estão disponíveis no R. Brevemente você pode encontrar essa informação
### em shapefiles ou sobre o formato geoJSON. Você também pode carregar do Google
### como backgrounds com o pacote ggmap.

### Nesse post nós carregamos o pacote map que promove as fronteiras de todos os
### países do mundo.

# Carregar pacotes -------------------------------------------------------------------------------------------------------------------------

library(ggplot2)
library(dplyr)
library(maps)

# Extraindo o polígono do país -------------------------------------------------------------------------------------------------------------

UK <- map_data("world") %>% 
  filter(region == "UK") 
UK

# O segundo passo é carregar o data frame com as informações do bubble map que você
# quer desenhar. O pacote maps promove a lista das maiores cidades do mundo. Vamos
# usar as informações do UK.

data <- world.cities %>% filter(country.etc == "UK")
data # Informa o tamanho da população de cada local
