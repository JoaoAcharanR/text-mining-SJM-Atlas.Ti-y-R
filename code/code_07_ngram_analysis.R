#### Import 01 Read Raw Data
#### ANALYZE

source("code/code_01_setup_02_libraries.R") #Le pido que corra completo el script indicado

#### Read Data

unidad_data <- read_rds("data/unidad_hermeneutica_02.rds")
View(unidad_data)

####CARGAR FICHERO DE STOPWORDS####
stopwords_es <- read_csv("https://raw.githubusercontent.com/7PartidasDigital/AnaText/master/datos/diccionarios/vacias.txt")

####ANÁLISIS DE N-GRAM####

####OBSTACULIZADORES CULTURALES#####
obstaculos_cult_palabras <- unidad_data %>% filter(familia == "Obstaculizadores culturales")
obstaculos_cult_palabras$nueva_frase <- tolower(obstaculos_cult_palabras$frase) #Elimina mayusculas
obstaculos_cult_palabras$nueva_frase <- str_replace_all(obstaculos_cult_palabras$nueva_frase,"[[:punct:]]", " ") #Elimina puntuacion
obstaculos_cult_palabras$nueva_frase <- str_replace_all(obstaculos_cult_palabras$nueva_frase,"[[:digit:]]", " ") #Elimina numeros
obstaculos_cult_palabras$nueva_frase <- str_replace_all(obstaculos_cult_palabras$nueva_frase,"[\\s]+", " ") #Elimina espacios en blanco extras
obstaculos_culturales <- obstaculos_cult_palabras$nueva_frase
obstaculos_culturales <- tibble(obstaculos_culturales) %>% unnest_tokens(bigramas, obstaculos_culturales, token = "ngrams", n = 2) 

##Borrar palabras vacias
bigramas_separados <- obstaculos_culturales %>% separate(bigramas, c("palabra1", "palabra2"), sep = " ")
bigramas_separados <- bigramas_separados %>% filter(!palabra1 %in% stopwords_es$palabra, !palabra2 %in% stopwords_es$palabra)
bigramas_separados <- bigramas_separados %>% filter(!palabra1 %in% c("eh","cierto","claudio","ejemplo","creo","ver","walmart","ir","ser","queso","viene","hoy","día","ok","decir","puede","puedo","ven","mucho","silos","bien","vamos"),
                                                    !palabra2 %in% c("eh","cierto","claudio","ejemplo","creo","ver","walmart","ir","ser","queso","viene","hoy","día","ok","decir","puede","puedo","ven","mucho","silos","bien","vamos"))
bigramas_unidos   <- bigramas_separados %>% unite(bigramas, palabra1, palabra2, sep = " ")
recuento_bigramas <- bigramas_separados %>% count(palabra1, palabra2, sort = T)
grafo_culturales  <- recuento_bigramas  %>% graph_from_data_frame()
plot_culturales   <- ggraph(grafo_culturales, layout = "nicely") + geom_edge_link(aes(edge_alpha = n), show.legend = FALSE, arrow = arrow(type = "closed", length = unit(3, "mm"))) + geom_node_point(color = "lightblue", size = 3) + geom_node_text(aes(label = name), vjust = 1, hjust = 1) + theme_void() + ggtitle("Obstaculizadores culturales")
plot_culturales

ggsave("plot_culturales.jpg", plot = plot_culturales, width = 10, height = 8)

####OBSTACULIZADORES INSTITUCIONALES####
obstaculos_inst_palabras <- unidad_data %>% filter(familia == "Obstaculizadores institucionales")
obstaculos_inst_palabras$nueva_frase <- tolower(obstaculos_inst_palabras$frase) #Elimina mayusculas
obstaculos_inst_palabras$nueva_frase <- str_replace_all(obstaculos_inst_palabras$nueva_frase,"[[:punct:]]", " ") #Elimina puntuacion
obstaculos_inst_palabras$nueva_frase <- str_replace_all(obstaculos_inst_palabras$nueva_frase,"[[:digit:]]", " ") #Elimina numeros
obstaculos_inst_palabras$nueva_frase <- str_replace_all(obstaculos_inst_palabras$nueva_frase,"[\\s]+", " ") #Elimina espacios en blanco extras
obstaculos_institucionales <- obstaculos_inst_palabras$nueva_frase
obstaculos_institucionales <- tibble(obstaculos_institucionales) %>% unnest_tokens(bigramas, obstaculos_institucionales, token = "ngrams", n = 2)

##Borrar palabras vacias
bigramas_separados1 <- obstaculos_institucionales %>% separate(bigramas, c("palabra1", "palabra2"), sep = " ")
bigramas_separados1 <- bigramas_separados1 %>% filter(!palabra1 %in% stopwords_es$palabra, !palabra2 %in% stopwords_es$palabra)
bigramas_separados1 <- bigramas_separados1 %>% filter(!palabra1 %in% c("eh","cierto","claudio","ejemplo","creo","ver","walmart","ir","ser","queso","viene","hoy","día","ok","decir","puede","puedo","ven","mucho","silos","bien","vamos","necesito","deberían","pueden","da","veo","tenido","toca","hacer","ojo","dice","paso","pareció","diciéndoles","decirlo","quiero","ósea","tengo","ibm","pasa","optando"),
                                                    !palabra2 %in% c("eh","cierto","claudio","ejemplo","creo","ver","walmart","ir","ser","queso","viene","hoy","día","ok","decir","puede","puedo","ven","mucho","silos","bien","vamos"  ,"necesito","deberían","pueden","da","veo","tenido","toca","hacer","ojo","dice","paso","pareció","diciéndoles","decirlo","quiero","ósea","tengo","ibm","pasa","optando"))
bigramas_unidos1   <- bigramas_separados1 %>% unite(bigramas, palabra1, palabra2, sep = " ")
recuento_bigramas1 <- bigramas_separados1 %>% count(palabra1, palabra2, sort = T)
grafo_institucionales  <- recuento_bigramas1  %>% graph_from_data_frame()
plot_institucionales   <- ggraph(grafo_institucionales, layout = "nicely") + geom_edge_link(aes(edge_alpha = n), show.legend = FALSE, arrow = arrow(type = "closed", length = unit(3, "mm"))) + geom_node_point(color = "lightblue", size = 3) + geom_node_text(aes(label = name), vjust = 1, hjust = 1) + theme_void()  + ggtitle("Obstaculizadores institucionales")
plot_institucionales

ggsave("plot_institucionales.jpg", plot = plot_institucionales, width = 10, height = 8)

####ROL DEL ESTADO####
rol_estado_palabras <- unidad_data %>% filter(familia == "Rol del Estado")
rol_estado_palabras$nueva_frase <- tolower(rol_estado_palabras$frase) #Elimina mayusculas
rol_estado_palabras$nueva_frase <- str_replace_all(rol_estado_palabras$nueva_frase,"[[:punct:]]", " ") #Elimina puntuacion
rol_estado_palabras$nueva_frase <- str_replace_all(rol_estado_palabras$nueva_frase,"[[:digit:]]", " ") #Elimina numeros
rol_estado_palabras$nueva_frase <- str_replace_all(rol_estado_palabras$nueva_frase,"[\\s]+", " ") #Elimina espacios en blanco extras
rol_estado <- rol_estado_palabras$nueva_frase
rol_estado <- tibble(rol_estado) %>% unnest_tokens(bigramas, rol_estado, token = "ngrams", n = 2) 

##Borrar palabras vacias
bigramas_separados2 <- rol_estado %>% separate(bigramas, c("palabra1", "palabra2"), sep = " ")
bigramas_separados2 <- bigramas_separados2 %>% filter(!palabra1 %in% stopwords_es$palabra, !palabra2 %in% stopwords_es$palabra)
bigramas_separados2 <- bigramas_separados2 %>% filter(!palabra1 %in% c("eh","cierto","claudio","ejemplo","creo","ver","walmart","ir","ser","queso","viene","hoy","día","ok","decir","puede","puedo","ven","mucho","silos","bien","vamos","necesito","deberían","pueden","da","veo","tenido","toca","hacer","ojo","dice","paso","pareció","diciéndoles","decirlo","quiero","ósea","tengo","ibm","pasa","optando"),
                                                      !palabra2 %in% c("eh","cierto","claudio","ejemplo","creo","ver","walmart","ir","ser","queso","viene","hoy","día","ok","decir","puede","puedo","ven","mucho","silos","bien","vamos"  ,"necesito","deberían","pueden","da","veo","tenido","toca","hacer","ojo","dice","paso","pareció","diciéndoles","decirlo","quiero","ósea","tengo","ibm","pasa","optando"))
bigramas_unidos2   <- bigramas_separados2 %>% unite(bigramas, palabra1, palabra2, sep = " ")
recuento_bigramas2 <- bigramas_separados2 %>% count(palabra1, palabra2, sort = T)
grafo_estado  <- recuento_bigramas2  %>% graph_from_data_frame()
plot_estado   <- ggraph(grafo_estado, layout = "nicely") + geom_edge_link(aes(edge_alpha = n), show.legend = FALSE, arrow = arrow(type = "closed", length = unit(3, "mm"))) + geom_node_point(color = "lightblue", size = 3) + geom_node_text(aes(label = name), vjust = 1, hjust = 1) + theme_void() + ggtitle("Rol del Estado")
plot_estado

ggsave("plot_estado.jpg", plot = plot_estado, width = 10, height = 8)

####ROL DE EMPRESAS####
rol_empresas_palabras <- unidad_data %>% filter(familia == "Rol de la empresa")
rol_empresas_palabras$nueva_frase <- tolower(rol_empresas_palabras$frase) #Elimina mayusculas
rol_empresas_palabras$nueva_frase <- str_replace_all(rol_empresas_palabras$nueva_frase,"[[:punct:]]", " ") #Elimina puntuacion
rol_empresas_palabras$nueva_frase <- str_replace_all(rol_empresas_palabras$nueva_frase,"[[:digit:]]", " ") #Elimina numeros
rol_empresas_palabras$nueva_frase <- str_replace_all(rol_empresas_palabras$nueva_frase,"[\\s]+", " ") #Elimina espacios en blanco extras
rol_empresas <- rol_empresas_palabras$nueva_frase
rol_empresas <- tibble(rol_empresas) %>% unnest_tokens(bigramas, rol_empresas, token = "ngrams", n = 2)

##Borrar palabras vacias
bigramas_separados3 <- rol_empresas %>% separate(bigramas, c("palabra1", "palabra2"), sep = " ")
bigramas_separados3 <- bigramas_separados3 %>% filter(!palabra1 %in% stopwords_es$palabra, !palabra2 %in% stopwords_es$palabra)
bigramas_separados3 <- bigramas_separados3 %>% filter(!palabra1 %in% c("eh","cierto","claudio","ejemplo","creo","ver","walmart","ir","ser","queso","viene","hoy","día","ok","decir","puede","puedo","ven","mucho","silos","bien","vamos","necesito","deberían","pueden","da","veo","tenido","toca","hacer","ojo","dice","paso","pareció","diciéndoles","decirlo","quiero","ósea","tengo","ibm","pasa","optando","poder","genera","pretende","punta","arenas","siento","llama","llegabas","tenía","sabía","existía","venir","seguir","traer","dar","puedan","vea","podía","va","sigue","di","dimos","dado","decía","incluye","llegan","queríamos","tomen","tienen","ende","hace","ablo"),
                                                      !palabra2 %in% c("eh","cierto","claudio","ejemplo","creo","ver","walmart","ir","ser","queso","viene","hoy","día","ok","decir","puede","puedo","ven","mucho","silos","bien","vamos","necesito","deberían","pueden","da","veo","tenido","toca","hacer","ojo","dice","paso","pareció","diciéndoles","decirlo","quiero","ósea","tengo","ibm","pasa","optando","poder","genera","pretende","punta","arenas","siento","llama","llegabas","tenía","sabía","existía","venir","seguir","traer","dar","puedan","vea","podía","va","sigue","di","dimos","dado","decía","incluye","llegan","queríamos","tomen","tienen","ende","hace","ablo"))
bigramas_unidos3   <- bigramas_separados3 %>% unite(bigramas, palabra1, palabra2, sep = " ")
recuento_bigramas3 <- bigramas_separados3 %>% count(palabra1, palabra2, sort = T)
grafo_mercado  <- recuento_bigramas3  %>% graph_from_data_frame()
plot_mercado   <- ggraph(grafo_mercado, layout = "nicely") + geom_edge_link(aes(edge_alpha = n), show.legend = FALSE, arrow = arrow(type = "closed", length = unit(3, "mm"))) + geom_node_point(color = "lightblue", size = 3) + geom_node_text(aes(label = name), vjust = 1, hjust = 1) + theme_void() + ggtitle("Rol de las empresas")
plot_mercado   

ggsave("plot_mercado.jpg", plot = plot_mercado, width = 10, height = 8)

####GRIDARRANGES####

obstaculizadores <- grid.arrange(plot_culturales,plot_institucionales, ncol = 2,
                                 top = textGrob("Grafos de bigramas",gp=gpar(fontface = "bold", fontsize = 15)))
ggsave("obstaculizadores.jpg", plot = obstaculizadores, width = 12, height = 8)

propuestas <- grid.arrange(plot_mercado, plot_estado, ncol = 2,
                           top = textGrob("Grafos de bigramas",gp=gpar(fontface = "bold", fontsize = 15)))
ggsave("propuestas.jpg", plot = propuestas, width = 12, height = 8)
