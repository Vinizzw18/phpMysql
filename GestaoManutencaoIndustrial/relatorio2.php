<?php
include 'conexao.php';

$sql = "SELECT t.nome_tecnico, t.especialidade, 
               COUNT(os.id_os) as total_os,
               SUM(os.custo) as custo_total,
               AVG(os.custo) as custo_medio
        FROM tecnicos t
        LEFT JOIN ordens_servico os ON t.id_tecnico = os.id_tecnico
        GROUP BY t.id_tecnico
        ORDER BY total_os DESC";

$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Relatório 2 - OS por Técnico</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Relatório 2: Ordens de Serviço por Técnico</h1>
    <a href="index.php">Voltar</a>
    
    <?php
    if ($result->num_rows > 0) {
        echo "<table>";
        echo "<tr><th>Técnico</th><th>Especialidade</th><th>Total de OS</th><th>Custo Total</th><th>Custo Médio</th></tr>";
        
        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row['nome_tecnico'] . "</td>";
            echo "<td>" . $row['especialidade'] . "</td>";
            echo "<td>" . $row['total_os'] . "</td>";
            echo "<td>R$ " . number_format($row['custo_total'] ?? 0, 2, ',', '.') . "</td>";
            echo "<td>R$ " . number_format($row['custo_medio'] ?? 0, 2, ',', '.') . "</td>";
            echo "</tr>";
        }
        echo "</table>";
    }
    
    $conn->close();
    ?>
</body>
</html>