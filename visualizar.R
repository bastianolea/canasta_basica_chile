library(ggplot2)
library(readr)

canasta <- read_csv2("datos_procesados/canasta_basica_alimentos_2018-2024.csv")

# visualizar
canasta |> 
  ggplot(aes(fecha, valor, color = variable)) +
  geom_point(size = 1, alpha = .7) +
  geom_line() +
  theme_minimal() +
  theme(legend.position = "bottom")


# thematic::thematic_on()
