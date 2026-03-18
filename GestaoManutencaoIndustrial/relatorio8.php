<?php
include 'conexao.php';

$sql = "SELECT os.id_os, 
               m.nome_maquina,
               s.nome_setor,
               t.nome_tecnico,
               t.especialidade,
               os.data_abertura,
               os.data_conclusao,
               os.tipo_manutencao,
               os.descricao_problema,
               os.custo,
               os.status_os,
               DATEDIFF(IFNULL(os.data_conclusao, CURDATE()), os.data_abertura) as duracao
        FROM ordens_servico os
        INNER JOIN maquinas m ON os.id_maquina = m.id_maquina
        INNER JOIN setores s ON m.id_setor = s.id_setor
        INNER JOIN tecnicos t ON os.id_tecnico = t.id_tecnico
        ORDER BY os.data_abertura DESC";

$result = $conn->query($sql);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Relatório 8 - Histórico Completo</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <h1>Relatório 8: Histórico Completo de Manutenções</h1>
    <a href="index.php">Voltar</a>
    
    <?php
    if ($result->num_rows > 0) {
        echo "<table>";
        echo "<tr>
                <th>ID</th>
                <th>Máquina</th>
                <th>Setor</th>
                <th>Técnico</th>
                <th>Especialidade</th>
                <th>Abertura</th>
                <th>Conclusão</th>
                <th>Tipo</th>
                <th>Problema</th>
                <th>Custo</th>
                <th>Status</th>
                <th>Duração (dias)</th>
              </tr>";
        
        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row['id_os'] . "</td>";
            echo "<td>" . $row['nome_maquina'] . "</td>";
            echo "<td>" . $row['nome_setor'] . "</td>";
            echo "<td>" . $row['nome_tecnico'] . "</td>";
            echo "<td>" . $row['especialidade'] . "</td>";
            echo "<td>" . date('d/m/Y', strtotime($row['data_abertura'])) . "</td>";
            echo "<td>" . ($row['data_conclusao'] ? date('d/m/Y', strtotime($row['data_conclusao'])) : '-') . "</td>";
            echo "<td>" . $row['tipo_manutencao'] . "</td>";
            echo "<td>" . $row['descricao_problema'] . "</td>";
            echo "<td>R$ " . number_format($row['custo'], 2, ',', '.') . "</td>";
            echo "<td>" . $row['status_os'] . "</td>";
            echo "<td>" . $row['duracao'] . "</td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "<p>Nenhum histórico encontrado.</p>";
    }
    
    $conn->close();
    ?>
</body>
</html>