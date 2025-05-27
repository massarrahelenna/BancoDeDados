--Criação de tabelas para normalizar os dados 
CREATE TABLE marcas (
    id_marca SERIAL PRIMARY KEY,
    nome VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE combustiveis (
    id_combustivel SERIAL PRIMARY KEY,
    tipo VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE cambios (
    id_cambio SERIAL PRIMARY KEY,
    tipo VARCHAR(30) UNIQUE NOT NULL
);

CREATE TABLE carros (
    id_carro SERIAL PRIMARY KEY,
    modelo VARCHAR(50) NOT NULL,
    ano INTEGER NOT NULL,
    engine_size NUMERIC(3,1) NOT NULL,
    mileage INTEGER NOT NULL,
    doors INTEGER NOT NULL,
    owner_count INTEGER NOT NULL,
    preco INTEGER NOT NULL,
    
    id_marca INTEGER NOT NULL REFERENCES marcas(id_marca),
    id_combustivel INTEGER NOT NULL REFERENCES combustiveis(id_combustivel),
    id_cambio INTEGER NOT NULL REFERENCES cambios(id_cambio)
);

-- Criação de tabelas temporárias para transferir os dados
CREATE TABLE carros_temp (
    Brand VARCHAR(50),
    Model VARCHAR(50),
    Year INTEGER,
    Engine_Size NUMERIC(3,1),
    Fuel_Type VARCHAR(20),
    Transmission VARCHAR(30),
    Mileage INTEGER,
    Doors INTEGER,
    Owner_Count INTEGER,
    Price INTEGER
);

SELECT * FROM carros_temp;
INSERT IGNORE INTO marcas (nome)
SELECT DISTINCT Brand FROM carros_temp;
INSERT IGNORE INTO combustiveis (tipo)
SELECT DISTINCT Fuel_Type FROM carros_temp;
INSERT IGNORE INTO cambios (tipo)
SELECT DISTINCT Transmission FROM carros_temp;

--Passando para a tabela carros
INSERT INTO carros (
    modelo, ano, engine_size, mileage, doors, owner_count, preco,
    id_marca, id_combustivel, id_cambio
)
SELECT
    ct.Model,
    ct.Year,
    ct.Engine_Size,
    ct.Mileage,
    ct.Doors,
    ct.Owner_Count,
    ct.Price,
    m.id_marca,
    c.id_combustivel,
    cam.id_cambio
FROM
    carros_temp ct
    JOIN marcas m ON ct.Brand = m.nome
    JOIN combustiveis c ON ct.Fuel_Type = c.tipo
    JOIN cambios cam ON ct.Transmission = cam.tipo;
    
DROP TABLE carros_temp; --Apagando a tabela temporária

SELECT * FROM carros;

-- Pesquisas 
SELECT COUNT(*) AS TOTAL_CARROS FROM carros;
SELECT COUNT(*) AS TOTAL_MARCAS FROM marcas;
SELECT COUNT(*) AS TOTAL_COMBUSTIVEIS FROM combustiveis;
SELECT COUNT(*) AS TOTAL_CAMBIO FROM cambios;

-- Verificar se algum carro foi inserido com referência inválida
SELECT * FROM carros
WHERE id_marca IS NULL OR id_combustivel IS NULL OR id_cambio IS NULL;

-- Mostrar os dados completos com nomes desnormalizados
SELECT
    c.id_carro,
    c.modelo,
    m.nome AS marca,
    cb.tipo AS combustivel,
    cm.tipo AS cambio,
    c.ano, c.engine_size, c.mileage, c.doors, c.owner_count, c.preco
FROM
    carros c
JOIN marcas m ON c.id_marca = m.id_marca
JOIN combustiveis cb ON c.id_combustivel = cb.id_combustivel
JOIN cambios cm ON c.id_cambio = cm.id_cambio
LIMIT 10;

-- Para garantir que um mesmo carro não foi importado mais de uma vez:
SELECT modelo, ano, mileage, preco, COUNT(*) as repeticoes
FROM carros
GROUP BY modelo, ano, mileage, preco
HAVING COUNT(*) > 1;

-- Marcas mais comuns
SELECT m.nome, COUNT(*) AS total
FROM carros c
JOIN marcas m ON c.id_marca = m.id_marca
GROUP BY m.nome
ORDER BY total DESC;

-- Tipos de câmbio
SELECT cm.tipo, COUNT(*) AS total
FROM carros c
JOIN cambios cm ON c.id_cambio = cm.id_cambio
GROUP BY cm.tipo;

-- Intervalo de anos
SELECT MIN(ano) AS ano_mais_antigo, MAX(ano) AS ano_mais_recente FROM carros;

-- Preço médio
SELECT AVG(preco) AS preco_medio FROM carros;

-- Exportar o arquivo CSV
SELECT * FROM carros;
SELECT * FROM cambios;
SELECT * FROM combustiveis;
SELECT * FROM marcas;