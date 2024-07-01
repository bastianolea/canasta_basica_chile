# Canasta Básica de Alimentos y Línea de Pobreza

Datos históricos de la Canasta Básica de Alimentos y Línea de Pobreza, directo del [Observatorio Social del Ministerio de Desarrollo Social y Familia](https://observatorio.ministeriodesarrollosocial.gob.cl/nueva-serie-cba-2024).

En la carpeta `datos_procesados` se encuentran los datos históricos del precio de la canasta básica y de la línea de pobreza, en formato Excel y CSV, ordenados por fecha.

Los datos se obtienen desde la [fuente oficial](https://observatorio.ministeriodesarrollosocial.gob.cl/nueva-serie-cba-2024), y luego son procesados en R para producir la salida histórica y ordenada.

Para obtener los datos, en el script `obtener_informes_canasta.R` se realiza web scraping de los sitios del Ministerio para obtener los enlaces a todos los informes mensuales _”Valor de la Canasta Básica de Alimentos y Líneas de Pobreza”_. Estos archivos se descargan en la carpeta `datos_originales`. Luego, en el script `extraer_datos_canasta.R` se utiliza el excelente [paquete de R `{tabulapdf}`](https://github.com/ropensci/tabulapdf) para cargar cada uno de los informes en PDF y extraer todos los datos que contengan. Posteriormente estos datos se procesan y limpian, y finalmente se guardan en `datos_procesados`.


