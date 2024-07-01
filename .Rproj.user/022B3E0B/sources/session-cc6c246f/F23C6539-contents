# luego de que se hayan descargado los informes de la Canasta Básica de Alimentos, se extraen los datos desde esos informes en pdf

# con el paquete tabulapdf, se leen los pdf y se extrae la tabla en la que vienen los datos históricos

# requisito para usar el paquete tabulapdf: instalar java. en mac: `brew install java`
# remotes::install_github(c("ropensci/tabulapdf"))

library(purrr)
library(tabulapdf)
library(tidyr)
library(lubridate)

informes_pdf <- dir("datos_originales", full.names = T)

# extraer todas las tablas de todos los informes
datos_informes <- map(informes_pdf, extract_tables)


# entre todas las tablas de todos los informes, extraer sólo la que nos interesa, según sus características (porque puede estar en cualquier página de los informes)
tablas_cba <- map(datos_informes, \(informe) {
  
  # por cada tabla dentro de cada informe, ...
  tabla_cba <- map(informe, \(tabla) {
    
    # si la tabla es una tabla...
    if ("tbl" %in% class(tabla)) {
      
      # si tiene menos de 4 filas
      if (nrow(tabla) <= 3) {
        
        # si en la primera columna tiene el valor CBA...
        if ("CBA" %in% tabla[1][[1]] & nrow(tabla) <= 4) {
          # retornar tabla
          return(tabla)
        }
      }
    }
  })
  return(tabla_cba)
})

# descartar tablas vacías, dejando solo las que calificaron en el paso anterior
tablas_cba_1 <- tablas_cba |> list_flatten() |> discard(is.null)

# pivotar todas las tablas para compartan la misma estructura de columnas
tablas_cba_2 <- map(tablas_cba_1, \(tabla) {
  tabla |> 
    mutate(across(2:length(tabla), as.numeric)) |>
    pivot_longer(cols = 2:length(tabla), names_to = "fecha", values_to = "valor") |> 
    filter(nchar(fecha) <= 8) |> 
    rename(variable = 1) |> 
    na.omit()
})

# unir todas en un solo dataframe
tablas_cba_3 <- tablas_cba_2 |> 
  list_rbind()

# arreglar cifras
tablas_cba_4 <- tablas_cba_3 |> 
  mutate(valor = ifelse(valor < 10000, valor * 1000, valor))

# arreglar fechas
tablas_cba_5 <- tablas_cba_4 |> 
  mutate(año = str_extract(fecha, "\\d+"),
         mes = str_extract(fecha, "\\w+(?=-)")) |> 
  mutate(mes2 = recode(mes,
                       "ene" = 1, "feb" = 2, "mar" = 3,
                       "abr" = 4, "may" = 5, "jun" = 6,
                       "jul" = 7, "ago" = 8, "sep" = 9, "sept" = 9, 
                       "oct" = 10, "nov" = 11, "dic" = 12)) |> 
  mutate(fecha = lubridate::ymd(paste(año, mes2, "1")))

# ordenar, eliminar repetidos
tablas_cba_6 <- tablas_cba_5 |> 
  group_by(variable) |> 
  arrange(variable, desc(fecha)) |> 
  distinct(fecha, valor, .keep_all = T)

canasta <- tablas_cba_6

# revisar
canasta



# guardar
write.csv2(canasta, "datos_procesados/canasta_basica_alimentos_2018-2024.csv")
writexl::write_xlsx(canasta, "datos_procesados/canasta_basica_alimentos_2018-2024.xlsx")

