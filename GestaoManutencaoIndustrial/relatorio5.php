<?php
include 'conexao.php';

$sql = "SELECT t.especialidade, 
               COUNT(t.id_tecnico) as qtd_tecnicos,
               GROUP_CONCAT(t.nome_tecnico SEPARATOR ', ') as lista_tecnicos,
               SUM(CASE WHEN os.id_os IS NOT NULL THEN 1 ELSE 0 END) as tecnicos_com_os
        FROM tecnicos t
        LEFT JOIN ordens_servico os ON t.id_tecnico = os.id_tecnico
        GROUP BY t.especialidade
        ORDER BY qtd_tecnicos DESC";

$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Relatório 5 - Técnicos por Especialidade</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Relatório 5: Técnicos por Especialidade</h1>
    <a href="index.php">Voltar</a>
    
    <?php
    if ($result->num_rows > 0) {
        echo "<table>";
        echo "<tr><th>Especialidade</th><th>Quantidade de Técnicos</th><th>Técnicos</th><th>Técnicos com OS</th></tr>";
        
        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row['especialidade'] . "</td>";
            echo "<td>" . $row['qtd_tecnicos'] . "</td>";
            echo "<td>" . $row['lista_tecnicos'] . "</td>";
            echo "<td>" . $row['tecnicos_com_os'] . "</td>";
            echo "</tr>";
        }
        echo "</table>";
    }
    
    $conn->close();
    ?>
</body>
</html>