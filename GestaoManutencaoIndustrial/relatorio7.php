<?php
include 'conexao.php';

$sql = "SELECT m.nome_maquina, s.nome_setor,
               COUNT(os.id_os) as total_os,
               SUM(CASE WHEN os.status_os = 'Concluída' THEN 1 ELSE 0 END) as os_concluidas,
               SUM(CASE WHEN os.status_os != 'Concluída' THEN 1 ELSE 0 END) as os_pendentes,
               AVG(DATEDIFF(os.data_conclusao, os.data_abertura)) as dias_medio_execucao
        FROM maquinas m
        INNER JOIN setores s ON m.id_setor = s.id_setor
        LEFT JOIN ordens_servico os ON m.id_maquina = os.id_maquina
        GROUP BY m.id_maquina
        HAVING total_os > 0
        ORDER BY total_os DESC";

$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Relatório 7 - Máquinas com mais OS</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Relatório 7: Máquinas com mais Ordens de Serviço</h1>
    <a href="index.php">Voltar</a>
    
    <?php
    if ($result->num_rows > 0) {
        echo "<table>";
        echo "<tr><th>Máquina</th><th>Setor</th><th>Total OS</th><th>Concluídas</th><th>Pendentes</th><th>Dias Médio</th></tr>";
        
        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row['nome_maquina'] . "</td>";
            echo "<td>" . $row['nome_setor'] . "</td>";
            echo "<td>" . $row['total_os'] . "</td>";
            echo "<td>" . $row['os_concluidas'] . "</td>";
            echo "<td>" . $row['os_pendentes'] . "</td>";
            echo "<td>" . round($row['dias_medio_execucao'] ?? 0, 1) . " dias</td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "<p>Nenhum dado encontrado.</p>";
    }
    
    $conn->close();
    ?>
</body>
</html>