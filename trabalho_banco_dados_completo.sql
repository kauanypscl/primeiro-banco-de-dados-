

    DROP DATABASE IF EXISTS LocadoraVeiculos;
    CREATE DATABASE LocadoraVeiculos;
    USE LocadoraVeiculos;

    -- Tabela Cliente
    CREATE TABLE Cliente (
        id_cliente INT PRIMARY KEY,
        nome VARCHAR(100) NOT NULL,
        telefone VARCHAR(20) NOT NULL
    );

    -- Tabela Veiculo
    CREATE TABLE Veiculo (
        id_veiculo INT PRIMARY KEY,
        modelo VARCHAR(100) NOT NULL,
        marca VARCHAR(100) NOT NULL,
        ano INT NOT NULL
    );

    -- Tabela Aluguel
    CREATE TABLE Aluguel (
        id_aluguel INT PRIMARY KEY,
        id_cliente INT NOT NULL,
        id_veiculo INT NOT NULL,
        data_aluguel DATE NOT NULL,
        FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
        FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
    );

    -- Tabela Pagamento
    CREATE TABLE Pagamento (
        id_pagamento INT PRIMARY KEY,
        id_aluguel INT NOT NULL,
        valor DECIMAL(10,2) NOT NULL,
        status VARCHAR(20) NOT NULL,
        FOREIGN KEY (id_aluguel) REFERENCES Aluguel(id_aluguel)
    );

    -- Tabela Manutencao
    CREATE TABLE Manutencao (
        id_manutencao INT PRIMARY KEY,
        id_veiculo INT NOT NULL,
        descricao TEXT NOT NULL,
        data_manutencao DATE NOT NULL,
        custo DECIMAL(10,2) NOT NULL,
        FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo)
    );

    -- Populando Cliente
    INSERT INTO Cliente VALUES
    (1, 'Lucas Martins', '41988887777'),
    (2, 'Pedro dos Santos', '41999998888'),
    (3, 'Beatriz Rocha', '41911112222'),
    (4, 'Carlos Mendes', '41977776666');

    -- Populando Veiculo
    INSERT INTO Veiculo VALUES
    (1, 'HB20', 'Hyundai', 2020),
    (2, 'Gol', 'Volkswagen', 2019),
    (3, 'Onix', 'Chevrolet', 2021),
    (4, 'Fiesta', 'Ford', 2018),
    (5, 'Civic', 'Honda', 2022),
    (6, 'Duster', 'Renault', 2020),
    (7, 'Compass', 'Jeep', 2023),
    (8, 'Toro', 'Fiat', 2022),
    (9, 'Cruze', 'Chevrolet', 2020),
    (10, 'Corolla', 'Toyota', 2023);

    -- Populando Aluguel
    INSERT INTO Aluguel VALUES
    (1, 1, 1, '2024-01-10'),
    (2, 2, 2, '2024-01-11'),
    (3, 3, 3, '2024-01-12'),
    (4, 4, 4, '2024-01-13'),
    (5, 1, 5, '2024-01-14'),
    (6, 2, 6, '2024-01-15'),
    (7, 3, 7, '2024-01-16'),
    (8, 4, 8, '2024-01-17'),
    (9, 1, 9, '2024-01-18'),
    (10, 2, 10, '2024-01-19'),
    (11, 3, 1, '2024-01-20'),
    (12, 4, 2, '2024-01-21'),
    (13, 1, 3, '2024-01-22'),
    (14, 2, 4, '2024-01-23'),
    (15, 3, 5, '2024-01-24');

    -- Populando Pagamento
    INSERT INTO Pagamento VALUES
    (1, 1, 360.00, 'Pago'),
    (2, 2, 140.00, 'Pago'),
    (3, 3, 480.00, 'Pago'),
    (4, 4, 1100.00, 'Pago'),
    (5, 5, 1350.00, 'Pago'),
    (6, 6, 2210.00, 'Pago'),
    (7, 7, 1080.00, 'Pago'),
    (8, 8, 2200.00, 'Pago'),
    (9, 9, 500.00, 'Pendente'),
    (10, 10, 840.00, 'Pendente'),
    (11, 11, 520.00, 'Pago'),
    (12, 12, 900.00, 'Pendente'),
    (13, 13, 260.00, 'Pago'),
    (14, 14, 1120.00, 'Pendente'),
    (15, 15, 600.00, 'Pago');

    -- Populando Manutencao
    INSERT INTO Manutencao VALUES
    (1, 1, 'Troca de óleo e revisão geral', '2024-12-09', 200),
    (2, 2, 'Substituição de pneu', '2024-12-10', 600),
    (3, 3, 'Troca de pastilhas de freio', '2024-12-14', 450),
    (4, 4, 'Alinhamento e balanceamento', '2024-12-18', 150),
    (5, 5, 'Revisão elétrica completa', '2024-12-28', 500),
    (6, 6, 'Reparo na suspensão', '2025-01-05', 700),
    (7, 7, 'Troca do sistema de escapamento', '2025-01-07', 750),
    (8, 8, 'Troca de bateria', '2025-01-17', 400),
    (9, 9, 'Substituição do filtro de ar', '2025-01-17', 120),
    (10, 10, 'Pintura e retoques na lataria', '2025-01-28', 900);

    -- Consultas SQL
    -- Consulta 1
    SELECT descricao, data_manutencao, custo FROM Manutencao;

    
    SELECT SUM(valor) AS total_arrecadado FROM Pagamento WHERE status = 'Pago';

    
    SELECT V.modelo, V.marca, COUNT(A.id_aluguel) AS total_locacoes
    FROM Veiculo V
    JOIN Aluguel A ON V.id_veiculo = A.id_veiculo
    GROUP BY V.id_veiculo
    ORDER BY total_locacoes DESC;

    -- Consulta 4
    SELECT C.nome, SUM(P.valor) AS valor_pendente
    FROM Cliente C
    JOIN Aluguel A ON C.id_cliente = A.id_cliente
    JOIN Pagamento P ON A.id_aluguel = P.id_aluguel
    WHERE P.status = 'Pendente'
    GROUP BY C.id_cliente
    ORDER BY C.nome ASC;



