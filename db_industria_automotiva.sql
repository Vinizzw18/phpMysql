-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 09/03/2026 às 17:43
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `db_industria_automotiva`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_maquinas`
--

CREATE TABLE `tb_maquinas` (
  `id_maquina` int(11) NOT NULL,
  `tag_maquina` varchar(20) NOT NULL,
  `tipo_maquina` varchar(50) DEFAULT NULL,
  `status_operacional` enum('ativo','manutencao','parado') DEFAULT 'ativo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tb_maquinas`
--

INSERT INTO `tb_maquinas` (`id_maquina`, `tag_maquina`, `tipo_maquina`, `status_operacional`) VALUES
(1, 'CNC-01', 'Torno CNC', 'ativo'),
(2, 'CNC-02', 'Torno CNC', 'ativo'),
(3, 'CNC-03', 'Torno CNC', 'manutencao'),
(4, 'ROB-01', 'Braço Robótico', 'ativo'),
(5, 'ROB-02', 'Braço Robótico', 'parado'),
(6, 'ROB-03', 'Braço Robótico', 'ativo'),
(7, 'PRE-01', 'Prensa Hidráulica', 'ativo'),
(8, 'PRE-02', 'Prensa Hidráulica', 'ativo'),
(9, 'COR-01', 'Corte a Laser', 'ativo'),
(10, 'COR-02', 'Corte a Laser', 'manutencao'),
(11, 'EXT-01', 'Extrusora', 'ativo'),
(12, 'EXT-02', 'Extrusora', 'ativo'),
(13, 'SOL-01', 'Solda Robotizada', 'ativo'),
(14, 'SOL-02', 'Solda Robotizada', 'ativo'),
(15, 'MON-01', 'Linha de Montagem', 'ativo'),
(16, 'MON-02', 'Linha de Montagem', 'ativo'),
(17, 'PNT-01', 'Célula de Pintura', 'parado'),
(18, 'PNT-02', 'Célula de Pintura', 'ativo'),
(19, 'EMB-01', 'Embaladora', 'ativo'),
(20, 'EMB-02', 'Embaladora', 'ativo');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_producao`
--

CREATE TABLE `tb_producao` (
  `id_registro` int(11) NOT NULL,
  `id_maquina` int(11) DEFAULT NULL,
  `qtd_produzida` int(11) NOT NULL,
  `data_producao` date NOT NULL,
  `turno` enum('A','B','C') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tb_producao`
--

INSERT INTO `tb_producao` (`id_registro`, `id_maquina`, `qtd_produzida`, `data_producao`, `turno`) VALUES
(1, 1, 150, '2024-05-01', 'A'),
(2, 1, 140, '2024-05-01', 'B'),
(3, 2, 200, '2024-05-01', 'A'),
(4, 4, 450, '2024-05-01', 'C'),
(5, 6, 420, '2024-05-01', 'A'),
(6, 7, 95, '2024-05-02', 'B'),
(7, 8, 110, '2024-05-02', 'A'),
(8, 9, 300, '2024-05-02', 'C'),
(9, 11, 500, '2024-05-02', 'B'),
(10, 12, 480, '2024-05-02', 'A'),
(11, 13, 210, '2024-05-03', 'C'),
(12, 14, 190, '2024-05-03', 'A'),
(13, 15, 600, '2024-05-03', 'B'),
(14, 16, 580, '2024-05-03', 'C'),
(15, 18, 320, '2024-05-03', 'A'),
(16, 19, 1000, '2024-05-04', 'B'),
(17, 20, 950, '2024-05-04', 'C'),
(18, 1, 160, '2024-05-04', 'A'),
(19, 4, 470, '2024-05-04', 'B'),
(20, 9, 310, '2024-05-04', 'A');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tb_usuarios`
--

CREATE TABLE `tb_usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nome_usuario` varchar(100) NOT NULL,
  `login` varchar(50) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `nivel_acesso` enum('admin','operador','gerente') DEFAULT 'operador'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tb_usuarios`
--

INSERT INTO `tb_usuarios` (`id_usuario`, `nome_usuario`, `login`, `senha`, `nivel_acesso`) VALUES
(1, 'Carlos Augusto', 'carlos.admin', 'admin123', 'admin'),
(2, 'Ana Paula', 'ana.gerente', 'gerente456', 'gerente'),
(3, 'Bruno Lima', 'bruno.op', 'op789', 'operador'),
(4, 'Daniela Silva', 'daniela.op', 'op789', 'operador'),
(5, 'Emerson Camargo', 'admin', 'admin', 'admin');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `tb_maquinas`
--
ALTER TABLE `tb_maquinas`
  ADD PRIMARY KEY (`id_maquina`),
  ADD UNIQUE KEY `tag_maquina` (`tag_maquina`);

--
-- Índices de tabela `tb_producao`
--
ALTER TABLE `tb_producao`
  ADD PRIMARY KEY (`id_registro`),
  ADD KEY `id_maquina` (`id_maquina`);

--
-- Índices de tabela `tb_usuarios`
--
ALTER TABLE `tb_usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `login` (`login`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `tb_maquinas`
--
ALTER TABLE `tb_maquinas`
  MODIFY `id_maquina` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `tb_producao`
--
ALTER TABLE `tb_producao`
  MODIFY `id_registro` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `tb_usuarios`
--
ALTER TABLE `tb_usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `tb_producao`
--
ALTER TABLE `tb_producao`
  ADD CONSTRAINT `tb_producao_ibfk_1` FOREIGN KEY (`id_maquina`) REFERENCES `tb_maquinas` (`id_maquina`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
