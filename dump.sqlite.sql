-- TABLE
CREATE TABLE demo (ID integer primary key, Name varchar(20), Hint text );
 
-- INDEX
 
-- TRIGGER
 
-- VIEW
 
CREATE TABLE Livros (
    idLivro INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    autor VARCHAR(255) NOT NULL,
    categoria VARCHAR(100),
    quantidadeDisponivel INT NOT NULL
);

CREATE TABLE Usuarios (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    idade INT NOT NULL
);
CREATE TABLE Emprestimos (
    idEmprestimo INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario INT,
    idLivro INT,
    dataEmprestimo DATE,
    dataDevolucao DATE,
    status VARCHAR(50),
    FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
    FOREIGN KEY (idLivro) REFERENCES Livros(idLivro)
);

INSERT INTO Livros (titulo, autor, categoria, quantidadeDisponivel)
VALUES ('O Senhor dos Anéis', 'J.R.R. Tolkien', 'Fantasia', 5);

INSERT INTO Usuarios (nome, idade)
VALUES ('Ana', 25);

-- Verificar a disponibilidade do livro
SELECT quantidadeDisponivel FROM Livros WHERE idLivro = 1;

-- Se quantidadeDisponivel > 0, realizar o empréstimo
INSERT INTO Emprestimos (idUsuario, idLivro, dataEmprestimo, status)
VALUES (1, 1, CURDATE(), 'Em andamento');

-- Atualizar a quantidade disponível
UPDATE Livros
SET quantidadeDisponivel = quantidadeDisponivel - 1
WHERE idLivro = 1;

-- Atualizar a data de devolução e o status
UPDATE Emprestimos
SET dataDevolucao = CURDATE(), status = 'Devolvido'
WHERE idEmprestimo = 1;

-- Atualizar a quantidade disponível do livro devolvido
UPDATE Livros
SET quantidadeDisponivel = quantidadeDisponivel + 1
WHERE idLivro = (SELECT idLivro FROM Emprestimos WHERE idEmprestimo = 1);

SELECT * FROM Livros;

SELECT e.idEmprestimo, u.nome, l.titulo, e.dataEmprestimo
FROM Emprestimos e
JOIN Usuarios u ON e.idUsuario = u.idUsuario
JOIN Livros l ON e.idLivro = l.idLivro
WHERE e.status = 'Em andamento';

SELECT e.idEmprestimo, l.titulo, e.dataEmprestimo, e.dataDevolucao, e.status
FROM Emprestimos e
JOIN Livros l ON e.idLivro = l.idLivro
WHERE e.idUsuario = 1;