import pandas as pd

# Carregar o arquivo CSV
df = pd.read_csv("carros.csv")

# Criar tabela de marcas
tabela_marcas = df[['marca']].drop_duplicates().reset_index(drop=True)
tabela_marcas['id_marca'] = tabela_marcas.index + 1

# Juntar IDs na tabela original
df = df.merge(tabela_marcas, on='marca')
df = df.drop(columns=['marca'])

# Repetir para combustíveis, câmbios, motores, etc.

# Salvar os dados normalizados
tabela_marcas.to_csv("marcas.csv", index=False)
df.to_csv("carros_normalizado.csv", index=False)
