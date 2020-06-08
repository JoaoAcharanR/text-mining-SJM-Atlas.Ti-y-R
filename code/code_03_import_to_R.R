#### Import 01 Read Raw Data
#### Set-up

source("code/code_01_setup_02_libraries.R") #Le pido que corra completo el script indicado

pattern_codigo  = "\r\n\r\nCódigo: (.*?)\r\n\r\nP 1: "
pattern_familia = " - Familia: (.*?)]"
pattern_frase   = "No memos\r\n\r\n(.*?)\r\n\r\n"

#### Read Directory 

unidad_dir  <- tibble(dir = dir("raw")) #Genera una tabla de una columna con los archivos txt en la carpeta "raw". Los nombres de cada archivo quedan como filas
unidad_dir  <- unidad_dir  %>% mutate(dir = paste0("raw/", dir)) #Al nombre de cada archivo le pega la expresión "raw\" antepuesta 
unidad_dir  <- unidad_dir  %>% group_by(dir) #Transforma cada fila en un grupo
unidad_dir  <- unidad_dir  %>% nest() #Pega una nueva columna que permite ver la cantidad observaciones de cada fila

#### Read Raw Data

unidad_data <- unidad_dir  %>% mutate(data = dir %>% map(read_file, locale = locale(encoding = "ISO-8859-1"))) #Transofrma el contenido de cada archivo en una observación del tipo character

#### Tidy Data

unidad_data <- unidad_data %>% mutate(data = data %>% map(str_split, pattern = "______________________________________________________________________")) 
unidad_data <- unidad_data %>% unnest(cols = data)
unidad_data <- unidad_data %>% mutate(data = data %>% map(tail,-2))
unidad_data <- unidad_data %>% unnest(cols = data)
unidad_data <- unidad_data %>% mutate(codigo  = data   %>% str_match(pattern_codigo) %>% magrittr::extract(,2))
unidad_data <- unidad_data %>% mutate(codigo  = codigo %>% str_remove_all("\""))
unidad_data <- unidad_data %>% mutate(data2   = data   %>% str_remove(pattern = pattern_codigo))
unidad_data <- unidad_data %>% mutate(data2   = data2  %>% str_remove(pattern = pattern_codigo))
unidad_data <- unidad_data %>% mutate(data2   = data2  %>% str_split("P 1: "))
unidad_data <- unidad_data %>% unnest(cols    = data2)
unidad_data <- unidad_data %>% mutate(familia = data2   %>% str_match(pattern_familia) %>% magrittr::extract(,2))
unidad_data <- unidad_data %>% mutate(frase   = data2   %>% str_match(pattern_frase  ) %>% magrittr::extract(,2))
unidad_data <- unidad_data %>% select(-data,-data2)
unidad_data %>% View

#### Save Data

write_rds(unidad_data, "data/unidad_hermeneutica_01.rds")


#### Read Data

unidad_data <- read_rds("data/unidad_hermeneutica_01.rds")
View(unidad_data)

write.csv(unidad_data, file="Codificacion.csv", row.names = F)

