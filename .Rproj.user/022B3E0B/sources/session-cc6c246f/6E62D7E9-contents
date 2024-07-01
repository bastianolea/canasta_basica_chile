# este script obtiene los datos de Canasta Básica de Alimentos y Líneas de Pobreza desde el Observatorio Social del Ministerio de Desarrollo Social y Familia 
# https://observatorio.ministeriodesarrollosocial.gob.cl/nueva-serie-cba-2024

# se hace web scraping de los sitios y se descargan todos los informes en la carpeta datos/

library(dplyr)
library(rvest)
library(stringr)
library(purrr)

# enlaces anuales ----
enlaces_sitios_canasta <- c("https://observatorio.ministeriodesarrollosocial.gob.cl/nueva-serie-cba-2024",
                            "https://observatorio.ministeriodesarrollosocial.gob.cl/nueva-serie-cba-2023",
                            "https://observatorio.ministeriodesarrollosocial.gob.cl/nueva-serie-cba-2022",
                            "https://observatorio.ministeriodesarrollosocial.gob.cl/nueva-serie-cba-2021",
                            "https://observatorio.ministeriodesarrollosocial.gob.cl/nueva-serie-cba-2020",
                            "https://observatorio.ministeriodesarrollosocial.gob.cl/nueva-serie-cba-2019",
                            "https://observatorio.ministeriodesarrollosocial.gob.cl/nueva-serie-cba-2018"
)


# enlaces informes ----
# obtener los enlaces de todos los informes de canasta básica de alimentos
enlaces_informes_canasta <- map(enlaces_sitios_canasta, \(url_canasta) {
  
  message(url_canasta)
  
  sitio_canasta <- session(url_canasta) |> 
    read_html()
  
  enlaces_canasta <- sitio_canasta |> 
    html_element(".tab-content") |> 
    html_elements("a") |> 
    html_attr("href")
  
  informes_canasta <- enlaces_canasta |> 
    str_subset("_CBA|_cba")
  
  return(informes_canasta)
})

enlaces_informes_canasta

# descargar informes pdf ----
# por cada uno de los enlaces, descargar el pdf
for (informe in unlist(enlaces_informes_canasta)) {
  # url completa al informe
  url_archivo = paste0("https://observatorio.ministeriodesarrollosocial.gob.cl/", informe)
  
  # nombre del archivo
  nombre_archivo <- informe |> str_extract("(?=\\d{4}).*$") |> str_extract("(?<=/).*$")
  
  message("descargando ", nombre_archivo, "...")
  
  # descargar
  download.file(url_archivo, destfile = paste0("datos_originales/", nombre_archivo))
  
  Sys.sleep(1)
}

message("archivos descargados: ", length(dir("datos_originales/")))
