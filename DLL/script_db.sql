-- ===========================================
-- DATABASE: GameCatalogDB
-- Script de criação das tabelas Master-Detail
-- Compatível com Azure SQL Server (PaaS)
-- ===========================================

-- Criação do banco (opcional - se você quiser criar manualmente no Azure, pode omitir)
CREATE DATABASE GameCatalogDB;
GO
-- ===========================================
-- Script de criação das tabelas Master-Detail
-- Para Azure SQL Database
-- ===========================================

-- ===========================================
-- TABELA MASTER: Games
-- ===========================================
CREATE TABLE Games (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(100) NOT NULL,
    Genre NVARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    ReleaseDate DATE NOT NULL,
    CreatedAt DATETIME2 DEFAULT GETDATE()
);
GO



-- ===========================================
-- DADOS INICIAIS (opcionais)
-- ===========================================
INSERT INTO Games (Title, Genre, Price, ReleaseDate)
VALUES 
('The Witcher 3', 'RPG', 199.90, '2015-05-19'),
('Halo Infinite', 'FPS', 249.90, '2021-12-08'),
('Forza Horizon 5', 'Racing', 299.90, '2021-11-09');
GO

SELECT * FROM Games;
INSERT INTO Games (Title, Genre, Price, ReleaseDate)
VALUES
('Jogos', 'RPG', 200.90, '2015-05-19');
GO

-- Atualiza o preço do jogo com Id = 1
UPDATE Games
SET Price = 179.90
WHERE Id = 1;
GO
-- Altera a data de lançamento para '2025-01-01' para todos jogos do gênero 'RPG'
UPDATE Games
SET ReleaseDate = '2025-01-01'
WHERE Genre = 'RPG';
GO
-- Deleta o jogo com Id = 2
DELETE FROM Games
WHERE Id = 2;
GO

