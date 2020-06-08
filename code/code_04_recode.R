#### Import 01 Read Raw Data
#### ANALYZE

source("code/code_01_setup_02_libraries.R") #Le pido que corra completo el script indicado

#### Read Data

unidad_data <- read_rds("data/unidad_hermeneutica_01.rds")
View(unidad_data)

####RECODIFICACION####
table(unidad_data$codigo)

unidad_data <- unidad_data %>% mutate(codigo = case_when(codigo == "Discriminación como barrera {2-0}"            ~ "Discriminación social {3-0}",
                                                         codigo == "categorías de migración como barrera {2-0}"   ~ "Categorías de migrantes",
                                                         codigo == "Expectativa de potenciales problemas {1-0}"   ~ "Problemas de convivencia {1-0}",
                                                         codigo == "Miedo a la otredad {1-0}"                     ~ "Problemas de convivencia {1-0}",
                                                         codigo == "Cuota de contratación como barrera {4-0}"     ~ "Tope legal de migrantes {3-0}",
                                                         codigo == "Discrecionalidad de quien atiende {1-0}"      ~ "Burocracia e ineficiencia {7-0}",
                                                         codigo == "requisitos legales {2-0}"                     ~ "Requisitos legales para contratación",
                                                         codigo == "Procesos de transición {3-0}"                 ~ "Facilitar inserción laboral {1-0}",
                                                         codigo == "Procesos de postulación ciegos {2-0}"         ~ "Buenas prácticas de reclutamiento",
                                                         codigo == "Regularización de procesos de selección {1-0}"~ "Buenas prácticas de reclutamiento",
                                                         codigo == "Reclutamiento sin discriminación {1-0}"       ~ "Buenas prácticas de reclutamiento",
                                                         codigo == "Selección masiva {1-0}"                       ~ "Buenas prácticas de reclutamiento",
                                                         codigo == "Capacitaciones de españlol {1-0}"             ~ "Capacitación {2-0}",
                                                         codigo == "Brechas de formación profesional {1-0}"       ~ "Capacitación {2-0}",
                                                         codigo == "Valoración de la diversidad {1-0}"            ~ "Misión institucional {1-0}",
                                                         codigo == "Precondición para sostener proyectos de vida {2-0}" ~ "Generar certeazas y seguridades para los migrantes {6-0}",
                                                         codigo == "Establcimiento de derechos y deberes {2-0}" ~ "Generar certeazas y seguridades para los migrantes {6-0}",
                                                         codigo == "Pasantías laborales {1-0}"                  ~ "Cooperación público-privado {2-0}",
                                                         codigo == "Orientación para regularización {1-0}"      ~ "Buenas prácticas de reclutamiento",
                                                         codigo == "Espacios de innovación {1-0}"               ~ "Cooperación público-privado {2-0}",
                                                         codigo == "Nivelar expectativas {1-0}"                 ~ "Generar certeazas y seguridades para los migrantes {6-0}",  
                                                         TRUE ~ codigo))

#### Save Data

write_rds(unidad_data, "data/unidad_hermeneutica_02.rds")

