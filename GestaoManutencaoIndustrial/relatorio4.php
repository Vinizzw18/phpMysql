<?php
include 'conexao.php';

$sql = "SELECT os.id_os, m.nome_maquina, t.nome_tecnico,
               os.data_abertura, os.tipo_manutencao,
               os.descricao_problema, os.custo,
               DATEDIFF(CURDATE(), os.data_abertura) as dias_em_aberto
        FROM ordens_servico os
        INNER JOIN maquinas m ON os.id_maquina = m.id_maquina
        INNER JOIN tecnicos t ON os.id_tecnico = t.id_tecnico
        WHERE os.status_os IN ('Em andamento', 'Aguardando peças', 'Aguardando liberação')
        ORDER BY os.data_abertura";

$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Relatório 4 - OS em Andamento</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Relatório 4: Ordens de Serviço em Andamento</h1>
    <a href="index.php">Voltar</a>
    
    <?php
    if ($result->num_rows > 0) {
        echo "<table>";
        echo "<tr><th>ID OS</th><th>Máquina</th><th>Técnico</th><th>Abertura</th><th>Tipo</th><th>Problema</th><th>Dias</th><th>Custo</th></tr>";
        
        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row['id_os'] . "</td>";
            echo "<td>" . $row['nome_maquina'] . "</td>";
            echo "<td>" . $row['nome_tecnico'] . "</td>";
            echo "<td>" . date('d/m/Y', strtotime($row['data_abertura'])) . "</td>";
            echo "<td>" . $row['tipo_manutencao'] . "</td>";
            echo "<td>" . $row['descricao_problema'] . "</td>";
            echo "<td>" . $row['dias_em_aberto'] . " dias</td>";
            echo "<td>R$ " . number_format($row['custo'], 2, ',', '.') . "</td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "<p>Nenhuma OS em andamento no momento.</p>";
    }
    
    $conn->close();
    ?>
</body>
</html>