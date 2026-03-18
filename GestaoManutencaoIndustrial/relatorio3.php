<?php
include 'conexao.php';

$sql = "SELECT m.nome_maquina, s.nome_setor,
               COUNT(os.id_os) as qtd_manutencoes,
               SUM(os.custo) as custo_total,
               MAX(os.custo) as maior_custo,
               MIN(os.custo) as menor_custo
        FROM maquinas m
        INNER JOIN setores s ON m.id_setor = s.id_setor
        LEFT JOIN ordens_servico os ON m.id_maquina = os.id_maquina
        GROUP BY m.id_maquina
        ORDER BY custo_total DESC";

$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Relatório 3 - Custos por Máquina</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Relatório 3: Custos de Manutenção por Máquina</h1>
    <a href="index.php">Voltar</a>
    
    <?php
    if ($result->num_rows > 0) {
        echo "<table>";
        echo "<tr><th>Máquina</th><th>Setor</th><th>Qtd Manutenções</th><th>Custo Total</th><th>Maior Custo</th><th>Menor Custo</th></tr>";
        
        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row['nome_maquina'] . "</td>";
            echo "<td>" . $row['nome_setor'] . "</td>";
            echo "<td>" . $row['qtd_manutencoes'] . "</td>";
            echo "<td>R$ " . number_format($row['custo_total'] ?? 0, 2, ',', '.') . "</td>";
            echo "<td>R$ " . number_format($row['maior_custo'] ?? 0, 2, ',', '.') . "</td>";
            echo "<td>R$ " . number_format($row['menor_custo'] ?? 0, 2, ',', '.') . "</td>";
            echo "</tr>";
        }
        echo "</table>";
    }
    
    $conn->close();
    ?>
</body>
</html>