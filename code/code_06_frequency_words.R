#### Import 01 Read Raw Data
#### ANALYZE

source("code/code_01_setup_02_libraries.R") #Le pido que corra completo el script indicado

#### Read Data

unidad_data <- read_rds("data/unidad_hermeneutica_02.rds")
View(unidad_data)

#####GRAFICO FRECUENCIA DE PALABRAS####
##OBSTACULIZADORES CULTURALES#####
obstaculos_cult_palabras <- unidad_data %>% filter(familia == "Obstaculizadores culturales")
obstaculos_cult_palabras$nueva_frase <- tolower(obstaculos_cult_palabras$frase) #Elimina mayusculas
obstaculos_cult_palabras$nueva_frase <- str_replace_all(obstaculos_cult_palabras$nueva_frase,"[[:punct:]]", " ") #Elimina puntuacion
obstaculos_cult_palabras$nueva_frase <- str_replace_all(obstaculos_cult_palabras$nueva_frase,"[[:digit:]]", " ") #Elimina numeros
obstaculos_cult_palabras$nueva_frase <- str_replace_all(obstaculos_cult_palabras$nueva_frase,"[\\s]+", " ") #Elimina espacios en blanco extras
obstaculos_culturales <- obstaculos_cult_palabras$nueva_frase
obstaculos_culturales <- tibble(obstaculos_culturales) %>% unnest_tokens(palabra, obstaculos_culturales, strip_numeric = TRUE) %>% count(palabra, sort = TRUE)

#Cargar stopwords
stopwords_es <- read_csv("https://raw.githubusercontent.com/7PartidasDigital/AnaText/master/datos/diccionarios/vacias.txt")
mis_stopwords <- tibble(palabra = c("puedo","eh","hoy","día","creo","bien","tienen","fondo","ejemplo","existe","chile","viene","tengo","decir","walmart","contexto"))


obstaculos_culturales <- obstaculos_culturales %>% anti_join(stopwords_es) %>% anti_join(mis_stopwords)


obstaculos_culturales <- obstaculos_culturales %>% top_n(10)
data_culturales <- obstaculos_culturales %>% ggplot(aes(x=reorder(palabra,n), y= n, fill=palabra))
data_culturales <- data_culturales %+% geom_bar(stat="identity", position = position_dodge())
data_culturales <- data_culturales %+% geom_text(aes(x=palabra,y=n,label = n),position = position_dodge(width = 1), hjust = -0.5, size = 3)
data_culturales <- data_culturales %+% theme(plot.title = element_text(face = "bold"))
data_culturales <- data_culturales %+% theme(legend.position = "none")
data_culturales <- data_culturales %+% theme(axis.line.x = element_blank())
data_culturales <- data_culturales %+% theme(axis.line.x = element_blank())
data_culturales <- data_culturales %+% theme(axis.ticks.x = element_blank())
data_culturales <- data_culturales %+% theme(axis.text.x = element_blank())
data_culturales <- data_culturales %+% theme(axis.title.x = element_blank())
data_culturales <- data_culturales %+% theme(axis.line.y = element_line())
data_culturales <- data_culturales %+% theme(axis.title.y = element_blank())
data_culturales <- data_culturales %+% labs(title = "Frecuencia de palabras", subtitle = "Obstaculizadores culturales")
data_culturales <- data_culturales %+% coord_flip()
data_culturales

cult <- grid.arrange(plot_cult_data,data_culturales, ncol = 2)
ggsave("cult.jpg", plot = cult, width = 10, height = 4)

####OBSTACULIZADORES INSTITUCIONALES####
obstaculos_inst_palabras <- unidad_data %>% filter(familia == "Obstaculizadores institucionales")
obstaculos_inst_palabras$nueva_frase <- tolower(obstaculos_inst_palabras$frase) #Elimina mayusculas
obstaculos_inst_palabras$nueva_frase <- str_replace_all(obstaculos_inst_palabras$nueva_frase,"[[:punct:]]", " ") #Elimina puntuacion
obstaculos_inst_palabras$nueva_frase <- str_replace_all(obstaculos_inst_palabras$nueva_frase,"[[:digit:]]", " ") #Elimina numeros
obstaculos_inst_palabras$nueva_frase <- str_replace_all(obstaculos_inst_palabras$nueva_frase,"[\\s]+", " ") #Elimina espacios en blanco extras
obstaculos_institucionales <- obstaculos_inst_palabras$nueva_frase
obstaculos_institucionales <- tibble(obstaculos_institucionales) %>% unnest_tokens(palabra, obstaculos_institucionales, strip_numeric = TRUE) %>% count(palabra, sort = TRUE)

#Cargar stopwords
mis_stopwords <- tibble(palabra = c("puedo","eh","hoy","día","creo","bien","tienen","fondo","ejemplo","existe","chile","tiene","mucho","tener","pasa","tenemos","hacer","finalmente",
                                    "ningún","parte","ser","ver","manera","teniendo","poder"))

obstaculos_institucionales <- obstaculos_institucionales %>% anti_join(stopwords_es) %>% anti_join(mis_stopwords)


obstaculos_institucionales <- obstaculos_institucionales %>% top_n(10)
data_institucionales <- obstaculos_institucionales %>% ggplot(aes(x=reorder(palabra,n), y= n, fill=palabra))
data_institucionales <- data_institucionales %+% geom_bar(stat="identity", position = position_dodge())
data_institucionales <- data_institucionales %+% geom_text(aes(x=palabra,y=n,label = n),position = position_dodge(width = 1), hjust = -0.5, size = 3)
data_institucionales <- data_institucionales %+% theme(plot.title = element_text(face = "bold"))
data_institucionales <- data_institucionales %+% theme(legend.position = "none")
data_institucionales <- data_institucionales %+% theme(axis.line.x = element_blank())
data_institucionales <- data_institucionales %+% theme(axis.line.x = element_blank())
data_institucionales <- data_institucionales %+% theme(axis.ticks.x = element_blank())
data_institucionales <- data_institucionales %+% theme(axis.text.x = element_blank())
data_institucionales <- data_institucionales %+% theme(axis.title.x = element_blank())
data_institucionales <- data_institucionales %+% theme(axis.line.y = element_line())
data_institucionales <- data_institucionales %+% theme(axis.title.y = element_blank())
data_institucionales <- data_institucionales %+% labs(title = "Frecuencia de palabras", subtitle = "Obstaculizadores institucionales")
data_institucionales <- data_institucionales %+% coord_flip()
data_institucionales

inst <- grid.arrange(plot_inst_data,data_institucionales, ncol = 2)
ggsave("inst.jpg", plot = inst, width = 10, height = 4)


####ROL DEL ESTADO####
rol_estado_palabras <- unidad_data %>% filter(familia == "Rol del Estado")
rol_estado_palabras$nueva_frase <- tolower(rol_estado_palabras$frase) #Elimina mayusculas
rol_estado_palabras$nueva_frase <- str_replace_all(rol_estado_palabras$nueva_frase,"[[:punct:]]", " ") #Elimina puntuacion
rol_estado_palabras$nueva_frase <- str_replace_all(rol_estado_palabras$nueva_frase,"[[:digit:]]", " ") #Elimina numeros
rol_estado_palabras$nueva_frase <- str_replace_all(rol_estado_palabras$nueva_frase,"[\\s]+", " ") #Elimina espacios en blanco extras
rol_estado <- rol_estado_palabras$nueva_frase
rol_estado <- tibble(rol_estado) %>% unnest_tokens(palabra, rol_estado, strip_numeric = TRUE) %>% count(palabra, sort = TRUE)

#Cargar stopwords
mis_stopwords <- tibble(palabra = c("puedo","eh","hoy","día","creo","bien","tienen","fondo","ejemplo","existe","chile","tiene","mucho","tener","pasa","tenemos","hacer","finalmente",
                                    "efectivamente","siento","establecer","puede","generar","digamos","tengo","tenga","ser","puedan","pudiese","poder","manera"))

rol_estado <- rol_estado %>% anti_join(stopwords_es) %>% anti_join(mis_stopwords)


rol_estado <- rol_estado %>% top_n(10)
data_rol_estado <- rol_estado %>% ggplot(aes(x=reorder(palabra,n), y= n, fill=palabra))
data_rol_estado <- data_rol_estado %+% geom_bar(stat="identity", position = position_dodge())
data_rol_estado <- data_rol_estado %+% geom_text(aes(x=palabra,y=n,label = n),position = position_dodge(width = 1), hjust = -0.5, size = 3)
data_rol_estado <- data_rol_estado %+% theme(plot.title = element_text(face = "bold"))
data_rol_estado <- data_rol_estado %+% theme(legend.position = "none")
data_rol_estado <- data_rol_estado %+% theme(axis.line.x = element_blank())
data_rol_estado <- data_rol_estado %+% theme(axis.line.x = element_blank())
data_rol_estado <- data_rol_estado %+% theme(axis.ticks.x = element_blank())
data_rol_estado <- data_rol_estado %+% theme(axis.text.x = element_blank())
data_rol_estado <- data_rol_estado %+% theme(axis.title.x = element_blank())
data_rol_estado <- data_rol_estado %+% theme(axis.line.y = element_line())
data_rol_estado <- data_rol_estado %+% theme(axis.title.y = element_blank())
data_rol_estado <- data_rol_estado %+% labs(title = "Frecuencia de palabras", subtitle = "Rol del Estado")
data_rol_estado <- data_rol_estado %+% coord_flip()
data_rol_estado

estado <- grid.arrange(plot_estado_data,data_rol_estado, ncol = 2)
ggsave("estado.jpg", plot = estado, width = 10, height = 4)

####ROL DE EMPRESAS####
rol_empresas_palabras <- unidad_data %>% filter(familia == "Rol de la empresa")
rol_empresas_palabras$nueva_frase <- tolower(rol_empresas_palabras$frase) #Elimina mayusculas
rol_empresas_palabras$nueva_frase <- str_replace_all(rol_empresas_palabras$nueva_frase,"[[:punct:]]", " ") #Elimina puntuacion
rol_empresas_palabras$nueva_frase <- str_replace_all(rol_empresas_palabras$nueva_frase,"[[:digit:]]", " ") #Elimina numeros
rol_empresas_palabras$nueva_frase <- str_replace_all(rol_empresas_palabras$nueva_frase,"[\\s]+", " ") #Elimina espacios en blanco extras
rol_empresas <- rol_empresas_palabras$nueva_frase
rol_empresas <- tibble(rol_empresas) %>% unnest_tokens(palabra, rol_empresas, strip_numeric = TRUE) %>% count(palabra, sort = TRUE)

#Cargar stopwords
mis_stopwords <- tibble(palabra = c("puedo","eh","hoy","día","creo","bien","tienen","fondo","ejemplo","existe","chile","tiene","mucho","tener","pasa","tenemos","hacer","finalmente",
                                    "efectivamente","siento","establecer","puede","generar","digamos","tengo","tenga","ser","va","cuenta","manera","hacemos","dimos"))

rol_empresas <- rol_empresas %>% anti_join(stopwords_es) %>% anti_join(mis_stopwords)


rol_empresas <- rol_empresas %>% top_n(10)
data_rol_empresas <- rol_empresas %>% ggplot(aes(x=reorder(palabra,n), y= n, fill=palabra))
data_rol_empresas <- data_rol_empresas %+% geom_bar(stat="identity", position = position_dodge())
data_rol_empresas <- data_rol_empresas %+% geom_text(aes(x=palabra,y=n,label = n),position = position_dodge(width = 1), hjust = -0.5, size = 3)
data_rol_empresas <- data_rol_empresas %+% theme(plot.title = element_text(face = "bold"))
data_rol_empresas <- data_rol_empresas %+% theme(legend.position = "none")
data_rol_empresas <- data_rol_empresas %+% theme(axis.line.x = element_blank())
data_rol_empresas <- data_rol_empresas %+% theme(axis.line.x = element_blank())
data_rol_empresas <- data_rol_empresas %+% theme(axis.ticks.x = element_blank())
data_rol_empresas <- data_rol_empresas %+% theme(axis.text.x = element_blank())
data_rol_empresas <- data_rol_empresas %+% theme(axis.title.x = element_blank())
data_rol_empresas <- data_rol_empresas %+% theme(axis.line.y = element_line())
data_rol_empresas <- data_rol_empresas %+% theme(axis.title.y = element_blank())
data_rol_empresas <- data_rol_empresas %+% labs(title = "Frecuencia de palabras", subtitle = "Rol de empresas")
data_rol_empresas <- data_rol_empresas %+% coord_flip()
data_rol_empresas

empresas <- grid.arrange(plot_empresa_data,data_rol_empresas, ncol = 2)
ggsave("empresas.jpg", plot = empresas, width = 10, height = 4)
