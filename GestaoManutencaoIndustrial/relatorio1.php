<?php
include 'conexao.php';

$sql = "SELECT m.nome_maquina, m.modelo, m.status, s.nome_setor, s.responsavel
        FROM maquinas m
        INNER JOIN setores s ON m.id_setor = s.id_setor
        ORDER BY s.nome_setor, m.nome_maquina";

$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Relatório 1 - Máquinas por Setor</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Relatório 1: Máquinas por Setor</h1>
    <a href="index.php">Voltar</a>
    
    <?php
    if ($result->num_rows > 0) {
        echo "<table>";
        echo "<tr><th>Setor</th><th>Responsável</th><th>Máquina</th><th>Modelo</th><th>Status</th></tr>";
        
        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row['nome_setor'] . "</td>";
            echo "<td>" . $row['responsavel'] . "</td>";
            echo "<td>" . $row['nome_maquina'] . "</td>";
            echo "<td>" . $row['modelo'] . "</td>";
            echo "<td>" . $row['status'] . "</td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "Nenhum resultado encontrado.";
    }
    
    $conn->close();
    ?>
</body>
</html>