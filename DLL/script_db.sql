-- ===========================================
-- DATABASE: GameCatalogDB
-- Script de criação das tabelas Master-Detail
-- Compatível com Azure SQL Server (PaaS)
-- ===========================================

-- Criação do banco (opcional - se você quiser criar manualmente no Azure, pode omitir)
CREATE DATABASE GameCatalogDB;
GO

USE GameCatalogDB;
GO

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
-- TABELA DETAIL: GameDetails
-- Cada jogo pode ter vários detalhes (por exemplo, plataforma, idioma, descrição)
-- ===========================================
CREATE TABLE GameDetails (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    GameId INT NOT NULL,
    Platform NVARCHAR(50) NOT NULL,
    Language NVARCHAR(50) NOT NULL,
    Description NVARCHAR(255),
    CreatedAt DATETIME2 DEFAULT GETDATE(),

    CONSTRAINT FK_GameDetails_Games FOREIGN KEY (GameId)
        REFERENCES Games(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
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

INSERT INTO GameDetails (GameId, Platform, Language, Description)
VALUES
(1, 'PC', 'English', 'Action RPG in an open world.'),
(1, 'Xbox', 'Portuguese', 'Versão com dublagem PT-BR.'),
(2, 'Xbox', 'English', 'Sci-fi shooter from Microsoft.'),
(3, 'PC', 'Spanish', 'Racing across Mexico.'),
(3, 'Xbox', 'Portuguese', 'Jogo de corrida em mundo aberto.');
GO
