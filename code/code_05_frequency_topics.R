#### Import 01 Read Raw Data
#### ANALYZE

source("code/code_01_setup_02_libraries.R") #Le pido que corra completo el script indicado

#### Read Data

unidad_data <- read_rds("data/unidad_hermeneutica_02.rds")
View(unidad_data)

####GRAFICOS FRECUENCIA TOPICOS####

####OBSTACULIZADORES CULTURALES####
obstaculos_cult_data <- unidad_data %>% filter(familia == "Obstaculizadores culturales")
obstaculos_cult_data <- text_to_columns(obstaculos_cult_data$codigo, header = FALSE, sep = "{") #### Texto en columnas
obstaculos_cult_data <- obstaculos_cult_data %>% select(V1)
obstaculos_cult_data <- obstaculos_cult_data %>% group_by(V1)
obstaculos_cult_data <- obstaculos_cult_data %>% count(conteo = n())
plot_cult_data       <- obstaculos_cult_data %>% ggplot(aes(x=reorder(V1, conteo), y= conteo, fill=V1))
plot_cult_data       <- plot_cult_data       %+% geom_bar(stat="identity", position = position_dodge())
plot_cult_data       <- plot_cult_data       %+% geom_text(aes(x=V1,y=conteo,label = conteo),position = position_dodge(width = 1), hjust= -0.5, size = 3)
plot_cult_data       <- plot_cult_data       %+% theme(plot.title = element_text(face = "bold"))
plot_cult_data       <- plot_cult_data       %+% theme(legend.position = "none")
plot_cult_data       <- plot_cult_data       %+% theme(axis.line.x = element_blank())
plot_cult_data       <- plot_cult_data       %+% theme(axis.ticks.x = element_blank())
plot_cult_data       <- plot_cult_data       %+% theme(axis.text.x = element_blank())
plot_cult_data       <- plot_cult_data       %+% theme(axis.title.x = element_blank())
plot_cult_data       <- plot_cult_data       %+% theme(axis.line.y = element_line())
plot_cult_data       <- plot_cult_data       %+% theme(axis.title.y = element_blank())
plot_cult_data       <- plot_cult_data       %+% labs(title = "Frecuencia de tópicos", subtitle = "Obstaculizadores culturales")
plot_cult_data       <- plot_cult_data       %+% coord_flip()
plot_cult_data

####OBSTACULIZADORES INSTITUCIONALES#####
obstaculos_inst_data <- unidad_data %>% filter(familia == "Obstaculizadores institucionales")
obstaculos_inst_data <- text_to_columns(obstaculos_inst_data$codigo, header = FALSE, sep = "{") #### Texto en columnas
obstaculos_inst_data <- obstaculos_inst_data %>% select(V1)
obstaculos_inst_data <- obstaculos_inst_data %>% group_by(V1)
obstaculos_inst_data <- obstaculos_inst_data %>% count(conteo = n())
obstaculos_inst_data <- obstaculos_inst_data %>% ungroup()
obstaculos_inst_data <- obstaculos_inst_data %>% filter(V1 != "pero se\npierden\noportunidades,..")
obstaculos_inst_data <- obstaculos_inst_data %>% mutate(V1 = V1 %>% str_wrap(15))
plot_inst_data       <- obstaculos_inst_data %>% ggplot(aes(x=reorder(V1, conteo), y= conteo, fill=V1))
plot_inst_data       <- plot_inst_data       %+% geom_bar(stat="identity", position = position_dodge())
plot_inst_data       <- plot_inst_data       %+% geom_text(aes(x=V1,y=conteo,label = conteo),position = position_dodge(width = 1), hjust = -0.5, size = 3)
plot_inst_data       <- plot_inst_data       %+% theme(plot.title = element_text(face = "bold"))
plot_inst_data       <- plot_inst_data       %+% theme(legend.position = "none")
plot_inst_data       <- plot_inst_data       %+% theme(axis.line.x = element_blank())
plot_inst_data       <- plot_inst_data       %+% theme(axis.line.x = element_blank())
plot_inst_data       <- plot_inst_data       %+% theme(axis.ticks.x = element_blank())
plot_inst_data       <- plot_inst_data       %+% theme(axis.text.x = element_blank())
plot_inst_data       <- plot_inst_data       %+% theme(axis.title.x = element_blank())
plot_inst_data       <- plot_inst_data       %+% theme(axis.line.y = element_line())
plot_inst_data       <- plot_inst_data       %+% theme(axis.title.y = element_blank())
plot_inst_data       <- plot_inst_data       %+% labs(title = "Frecuencia de tópicos", subtitle = "Obstaculizadores institucionales")
plot_inst_data       <- plot_inst_data       %+% coord_flip()
plot_inst_data

####ROL DE EMPRESA#####
rol_empresa_data  <- unidad_data %>% filter(familia == "Rol de la empresa")
rol_empresa_data  <- text_to_columns(rol_empresa_data$codigo, header = FALSE, sep = "{") #### Texto en columnas
rol_empresa_data  <- rol_empresa_data %>% select(V1)
rol_empresa_data  <- rol_empresa_data %>% group_by(V1)
rol_empresa_data  <- rol_empresa_data %>% count(conteo = n())
rol_empresa_data  <- rol_empresa_data %>% ungroup()
rol_empresa_data  <- rol_empresa_data %>% mutate(V1 = V1 %>% str_wrap(15))
plot_empresa_data <- rol_empresa_data %>% ggplot(aes(x=reorder(V1, conteo), y= conteo, fill=V1))
plot_empresa_data <- plot_empresa_data %+% geom_bar(stat="identity", position = position_dodge())
plot_empresa_data <- plot_empresa_data %+% geom_text(aes(x=V1,y=conteo,label = conteo),position = position_dodge(width = 1), hjust = -0.5, size = 3)
plot_empresa_data <- plot_empresa_data %+% theme(plot.title = element_text(face = "bold"))
plot_empresa_data <- plot_empresa_data %+% theme(legend.position = "none")
plot_empresa_data <- plot_empresa_data %+% theme(axis.line.x = element_blank())
plot_empresa_data <- plot_empresa_data %+% theme(axis.line.x = element_blank())
plot_empresa_data <- plot_empresa_data %+% theme(axis.ticks.x = element_blank())
plot_empresa_data <- plot_empresa_data %+% theme(axis.text.x = element_blank())
plot_empresa_data <- plot_empresa_data %+% theme(axis.title.x = element_blank())
plot_empresa_data <- plot_empresa_data %+% theme(axis.line.y = element_line())
plot_empresa_data <- plot_empresa_data %+% theme(axis.title.y = element_blank())
plot_empresa_data <- plot_empresa_data %+% labs(title = "Frecuencia de tópicos", subtitle = "Rol de la empresa")
plot_empresa_data <- plot_empresa_data %+% coord_flip()
plot_empresa_data

####ROL DE ESTADO#####
rol_estado_data  <- unidad_data %>% filter(familia == "Rol del Estado")
rol_estado_data  <- text_to_columns(rol_estado_data$codigo, header = FALSE, sep = "{") #### Texto en columnas
rol_estado_data  <- rol_estado_data %>% select(V1)
rol_estado_data  <- rol_estado_data %>% group_by(V1)
rol_estado_data  <- rol_estado_data %>% count(conteo = n())
rol_estado_data  <- rol_estado_data %>% ungroup()
rol_estado_data  <- rol_estado_data %>% mutate(V1 = V1 %>% str_wrap(15))
plot_estado_data <- rol_estado_data %>% ggplot(aes(x=reorder(V1, conteo), y= conteo, fill=V1))
plot_estado_data <- plot_estado_data %+% geom_bar(stat="identity", position = position_dodge())
plot_estado_data <- plot_estado_data %+% geom_text(aes(x=V1,y=conteo,label = conteo),position = position_dodge(width = 1), hjust = -0.5, size = 3)
plot_estado_data <- plot_estado_data %+% theme(plot.title = element_text(face = "bold"))
plot_estado_data <- plot_estado_data %+% theme(legend.position = "none")
plot_estado_data <- plot_estado_data %+% theme(axis.line.x = element_blank())
plot_estado_data <- plot_estado_data %+% theme(axis.line.x = element_blank())
plot_estado_data <- plot_estado_data %+% theme(axis.ticks.x = element_blank())
plot_estado_data <- plot_estado_data %+% theme(axis.text.x = element_blank())
plot_estado_data <- plot_estado_data %+% theme(axis.title.x = element_blank())
plot_estado_data <- plot_estado_data %+% theme(axis.line.y = element_line())
plot_estado_data <- plot_estado_data %+% theme(axis.title.y = element_blank())
plot_estado_data <- plot_estado_data %+% labs(title = "Frecuencia de tópicos", subtitle = "Rol de la empresa")
plot_estado_data <- plot_estado_data %+% coord_flip()
plot_estado_data
