
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

library(ggplot2) # Produzir mapas baseado na gramática de gráficos
library(dplyr) # Usar código pipe para selecionar dados e fazer cálculos 
library(maps) # Criar o mapa
library(ggrepel) # Adicionar texto ao mapa
library(viridis) # Adicionar paleta de cores ao mapa

# Extraindo o polígono do país -------------------------------------------------------------------------------------------------------------

UK <- map_data("world") %>% 
  filter(region == "UK") 
UK

### O segundo passo é carregar o data frame com as informações do bubble map que você
### quer desenhar. O pacote maps promove a lista das maiores cidades do mundo. Vamos
### usar as informações do UK.

data <- world.cities %>% filter(country.etc == "UK")
data # Informa o tamanho da população de cada local

# Basic scatterplot map --------------------------------------------------------------------------------------------------------------------

### O pacote ggplot2 torna fácil a construção do mapa básico. Use geom_polygon() para
### o formato do mapa do UK, depois adicione o scatterplot sobre ele com o geom_point().

### O pacote ggrepel evita a sobreposição entre os nomes das cidades.

ggplot() +
  geom_polygon(data = UK, aes(x = long, y = lat, group = group), 
               fill = "grey", alpha = 0.3) +
  geom_point(data = data, aes(x = long, y = lat)) +
  theme_void() + ylim(50,59) + coord_map() 

### Gráfico com os nomes das 10 maiores cidades:

ggplot() +
  geom_polygon(data = UK, aes(x = long, y = lat, group = group), 
               fill = "grey", alpha = 0.3) +
  geom_point(data = data, aes(x = long, y = lat, alpha = pop)) +
  geom_text_repel( data = data %>% arrange(pop) %>% tail(10), 
                   aes(x = long, y = lat,label = name), size = 5) +
  geom_point(data = data %>% arrange(pop) %>% tail(10), aes(x = long, y = lat), 
              color = "red", size = 3) +
  theme_void() + ylim(50,59) + coord_map() +
  theme(legend.position = "none")

# Basic bubble map -------------------------------------------------------------------------------------------------------------------------

### Agora nós queremos adicionar uma outra informação. O número de habitantes por 
### cidade irá ser mapeado para cor e tamanho das bolhas. Note que a ordem da cidade
### importa! Aconselha-se mostrar a informação mais importante no topo. 
 
### Adicionar cor e tamanho

ggplot() +
  geom_polygon(data = UK, aes(x = long, y = lat, group = group), fill = "grey",
               alpha = 0.3) +
  geom_point( data = data, aes(x = long, y = lat, size = pop, color = pop)) +
  scale_size_continuous(range = c(1,12)) +
  scale_color_viridis(trans = "log") +
  theme_void() + ylim(50,59) + coord_map()

