CREATE TABLE alunos (
    id INT PRIMARY KEY,
    nome VARCHAR (400),
    materia VARCHAR (100),
    nota INT
);

INSERT INTO alunos (id, nome, materia, nota) VALUES (
    1, João Silva, Matemática, 2,
    2, Maria Jesus, Matemática, 8,
    3, Rodolfo Lopes, Matemática, 7
);

SELECT nome, materia WHERE nota > 7;
SELECT nome, materia WHERE nota < 5;

GRANT SELECT ON alunos TO usuarioX;
REVOKE INSERT ON alunos FROM usuarioX;

START TRANSACTION;
UPDATE alunos SET nota = nota * 3 WHERE id = 1;
COMMIT;