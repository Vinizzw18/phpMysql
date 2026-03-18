<?php
include 'conexao.php';

$sql = "SELECT os.tipo_manutencao,
               COUNT(os.id_os) as quantidade,
               SUM(os.custo) as custo_total,
               AVG(os.custo) as custo_medio,
               MIN(os.data_abertura) as primeira_os,
               MAX(os.data_abertura) as ultima_os
        FROM ordens_servico os
        WHERE os.tipo_manutencao IS NOT NULL
        GROUP BY os.tipo_manutencao
        UNION
        SELECT 'TODAS' as tipo_manutencao,
               COUNT(id_os) as quantidade,
               SUM(custo) as custo_total,
               AVG(custo) as custo_medio,
               MIN(data_abertura) as primeira_os,
               MAX(data_abertura) as ultima_os
        FROM ordens_servico
        ORDER BY tipo_manutencao";

$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Relatório 6 - Manutenções por Tipo</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Relatório 6: Manutenções por Tipo</h1>
    <a href="index.php">Voltar</a>
    
    <?php
    if ($result->num_rows > 0) {
        echo "<table>";
        echo "<tr><th>Tipo</th><th>Quantidade</th><th>Custo Total</th><th>Custo Médio</th><th>Primeira OS</th><th>Última OS</th></tr>";
        
        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row['tipo_manutencao'] . "</td>";
            echo "<td>" . $row['quantidade'] . "</td>";
            echo "<td>R$ " . number_format($row['custo_total'] ?? 0, 2, ',', '.') . "</td>";
            echo "<td>R$ " . number_format($row['custo_medio'] ?? 0, 2, ',', '.') . "</td>";
            echo "<td>" . ($row['primeira_os'] ? date('d/m/Y', strtotime($row['primeira_os'])) : '-') . "</td>";
            echo "<td>" . ($row['ultima_os'] ? date('d/m/Y', strtotime($row['ultima_os'])) : '-') . "</td>";
            echo "</tr>";
        }
        echo "</table>";
    }
    
    $conn->close();
    ?>
</body>
</html>