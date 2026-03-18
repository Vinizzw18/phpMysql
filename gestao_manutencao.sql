-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 18/03/2026 às 21:02
-- Versão do servidor: 10.4.28-MariaDB
-- Versão do PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `gestao_manutencao`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `maquinas`
--

CREATE TABLE `maquinas` (
  `id_maquina` int(11) NOT NULL,
  `nome_maquina` varchar(100) NOT NULL,
  `modelo` varchar(50) DEFAULT NULL,
  `data_aquisicao` date DEFAULT NULL,
  `id_setor` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'Ativa'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `maquinas`
--

INSERT INTO `maquinas` (`id_maquina`, `nome_maquina`, `modelo`, `data_aquisicao`, `id_setor`, `status`) VALUES
(1, 'Torno CNC', 'Romi C420', '2020-05-10', 5, 'Ativa'),
(2, 'Fresadora', 'Bridgeport V2', '2019-08-22', 5, 'Ativa'),
(3, 'Prensa Hidráulica', 'Prensa 200T', '2018-03-15', 1, 'Em manutenção'),
(4, 'Robô de Solda', 'Fanuc Arc Mate', '2021-11-30', 9, 'Ativa'),
(5, 'Máquina de Corte a Laser', 'Trumpf 3000', '2022-01-20', 9, 'Ativa'),
(6, 'Centro de Usinagem', 'Haas VF2', '2019-07-05', 5, 'Em manutenção'),
(7, 'Empilhadeira', 'Toyota 8FGCU25', '2020-09-12', 4, 'Ativa'),
(8, 'Compressor', 'Schulz MSV30', '2018-12-03', 2, 'Manutenção preventiv'),
(9, 'Esteira Transportadora', 'Esteira 12m', '2021-04-18', 1, 'Ativa'),
(10, 'Máquina de Pintura', 'Graco ProMix', '2020-06-25', 6, 'Desativada');

-- --------------------------------------------------------

--
-- Estrutura para tabela `ordens_servico`
--

CREATE TABLE `ordens_servico` (
  `id_os` int(11) NOT NULL,
  `id_maquina` int(11) DEFAULT NULL,
  `id_tecnico` int(11) DEFAULT NULL,
  `data_abertura` date DEFAULT NULL,
  `data_conclusao` date DEFAULT NULL,
  `tipo_manutencao` varchar(30) DEFAULT NULL,
  `descricao_problema` text DEFAULT NULL,
  `custo` decimal(10,2) DEFAULT NULL,
  `status_os` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `ordens_servico`
--

INSERT INTO `ordens_servico` (`id_os`, `id_maquina`, `id_tecnico`, `data_abertura`, `data_conclusao`, `tipo_manutencao`, `descricao_problema`, `custo`, `status_os`) VALUES
(1, 1, 1, '2024-01-10', '2024-01-12', 'Corretiva', 'Troca de rolamentos do eixo principal', 850.00, 'Concluída'),
(2, 2, 3, '2024-01-15', '2024-01-16', 'Preventiva', 'Lubrificação e ajustes gerais', 350.00, 'Concluída'),
(3, 3, 2, '2024-01-20', NULL, 'Corretiva', 'Vazamento no sistema hidráulico', 1200.00, 'Em andamento'),
(4, 4, 7, '2024-01-22', '2024-01-23', 'Corretiva', 'Falha no braço robótico', 2100.00, 'Concluída'),
(5, 5, 4, '2024-01-25', '2024-01-26', 'Preventiva', 'Calibração do laser', 550.00, 'Concluída'),
(6, 6, 1, '2024-01-28', NULL, 'Corretiva', 'Barulho excessivo no eixo', 950.00, 'Aguardando peças'),
(7, 7, 5, '2024-02-01', '2024-02-02', 'Preventiva', 'Troca de filtros e óleo', 280.00, 'Concluída'),
(8, 8, 2, '2024-02-05', '2024-02-06', 'Corretiva', 'Motor superaquecendo', 750.00, 'Concluída'),
(9, 9, 3, '2024-02-08', NULL, 'Preventiva', 'Inspeção geral', 0.00, 'Aguardando liberação'),
(10, 10, 6, '2024-02-10', '2024-02-10', 'Corretiva', 'Problemas elétricos no painel', 430.00, 'Concluída'),
(11, 3, 1, '2024-02-12', NULL, 'Corretiva', 'Prensa não atinge pressão', 1800.00, 'Em andamento'),
(12, 2, 5, '2024-02-15', '2024-02-16', 'Corretiva', 'Travamento do eixo', 620.00, 'Concluída');

-- --------------------------------------------------------

--
-- Estrutura para tabela `setores`
--

CREATE TABLE `setores` (
  `id_setor` int(11) NOT NULL,
  `nome_setor` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `responsavel` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `setores`
--

INSERT INTO `setores` (`id_setor`, `nome_setor`, `descricao`, `responsavel`) VALUES
(1, 'Produção', 'Setor responsável pela fabricação de peças', 'Carlos Silva'),
(2, 'Manutenção', 'Setor de manutenção preventiva e corretiva', 'Ana Oliveira'),
(3, 'Qualidade', 'Controle de qualidade dos produtos', 'Roberto Santos'),
(4, 'Expedição', 'Embalagem e envio de produtos', 'Mariana Costa'),
(5, 'Usinagem', 'Setor de usinagem de precisão', 'João Mendes'),
(6, 'Pintura', 'Pintura industrial', 'Paula Souza'),
(7, 'Montagem', 'Montagem de conjuntos mecânicos', 'Lucas Ferreira'),
(8, 'Almoxarifado', 'Controle de peças e insumos', 'Fernando Lima'),
(9, 'Solda', 'Soldagem de estruturas metálicas', 'Ricardo Alves'),
(10, 'Caldeiraria', 'Fabricação de caldeiras e tanques', 'Patrícia Rocha');

-- --------------------------------------------------------

--
-- Estrutura para tabela `tecnicos`
--

CREATE TABLE `tecnicos` (
  `id_tecnico` int(11) NOT NULL,
  `nome_tecnico` varchar(100) NOT NULL,
  `especialidade` varchar(50) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `data_contratacao` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `tecnicos`
--

INSERT INTO `tecnicos` (`id_tecnico`, `nome_tecnico`, `especialidade`, `telefone`, `data_contratacao`) VALUES
(1, 'João Pedro', 'Mecânico', '(11) 98765-4321', '2019-02-10'),
(2, 'Maria Santos', 'Eletricista', '(11) 97654-3210', '2020-03-15'),
(3, 'Carlos Eduardo', 'Hidráulico', '(11) 96543-2109', '2018-07-22'),
(4, 'Ana Beatriz', 'Automação', '(11) 95432-1098', '2021-01-05'),
(5, 'Paulo Roberto', 'Mecânico', '(11) 94321-0987', '2019-11-12'),
(6, 'Fernanda Lima', 'Eletricista', '(11) 93210-9876', '2020-09-30'),
(7, 'Ricardo Souza', 'Soldador', '(11) 92109-8765', '2022-02-18'),
(8, 'Luciana Mendes', 'Automação', '(11) 91098-7654', '2021-06-14'),
(9, 'Marcos Paulo', 'Mecânico', '(11) 90987-6543', '2020-04-07'),
(10, 'Juliana Costa', 'Hidráulico', '(11) 89876-5432', '2019-08-25');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `maquinas`
--
ALTER TABLE `maquinas`
  ADD PRIMARY KEY (`id_maquina`),
  ADD KEY `id_setor` (`id_setor`);

--
-- Índices de tabela `ordens_servico`
--
ALTER TABLE `ordens_servico`
  ADD PRIMARY KEY (`id_os`),
  ADD KEY `id_maquina` (`id_maquina`),
  ADD KEY `id_tecnico` (`id_tecnico`);

--
-- Índices de tabela `setores`
--
ALTER TABLE `setores`
  ADD PRIMARY KEY (`id_setor`);

--
-- Índices de tabela `tecnicos`
--
ALTER TABLE `tecnicos`
  ADD PRIMARY KEY (`id_tecnico`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `maquinas`
--
ALTER TABLE `maquinas`
  MODIFY `id_maquina` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `ordens_servico`
--
ALTER TABLE `ordens_servico`
  MODIFY `id_os` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `setores`
--
ALTER TABLE `setores`
  MODIFY `id_setor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `tecnicos`
--
ALTER TABLE `tecnicos`
  MODIFY `id_tecnico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `maquinas`
--
ALTER TABLE `maquinas`
  ADD CONSTRAINT `maquinas_ibfk_1` FOREIGN KEY (`id_setor`) REFERENCES `setores` (`id_setor`);

--
-- Restrições para tabelas `ordens_servico`
--
ALTER TABLE `ordens_servico`
  ADD CONSTRAINT `ordens_servico_ibfk_1` FOREIGN KEY (`id_maquina`) REFERENCES `maquinas` (`id_maquina`),
  ADD CONSTRAINT `ordens_servico_ibfk_2` FOREIGN KEY (`id_tecnico`) REFERENCES `tecnicos` (`id_tecnico`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
