<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Gestão de Manutenção Industrial 4.0</title>
    <style>
        body { font-family: Arial; margin: 20px; background: #f4f4f4; }
        h1 { color: #333; }
        .menu { margin: 20px 0; }
        .menu a { 
            padding: 10px 15px; 
            background: #007bff; 
            color: white; 
            text-decoration: none; 
            margin-right: 10px;
            border-radius: 5px;
        }
        table { 
            width: 100%; 
            border-collapse: collapse; 
            margin-top: 20px;
            background: white;
        }
        th, td { 
            border: 1px solid #ddd; 
            padding: 8px; 
            text-align: left; 
        }
        th { background: #007bff; color: white; }
        tr:nth-child(even) { background: #f2f2f2; }
    </style>
</head>
<body>
    <h1>Sistema de Gestão de Manutenção Industrial 4.0</h1>
    
    <div class="menu">
        <a href="index.php">Início</a>
        <a href="relatorio1.php">Máquinas por Setor</a>
        <a href="relatorio2.php">OS por Técnico</a>
        <a href="relatorio3.php">Custos por Máquina</a>
        <a href="relatorio4.php">OS em Andamento</a>
        <a href="relatorio5.php">Técnicos por Especialidade</a>
        <a href="relatorio6.php">Manutenções por Tipo</a>
        <a href="relatorio7.php">Máquinas com mais OS</a>
        <a href="relatorio8.php">Histórico Completo</a>
    </div>

    <h2>Últimas Ordens de Serviço</h2>
    
    <?php
    include 'conexao.php';
    
    $sql = "SELECT os.id_os, m.nome_maquina, t.nome_tecnico, 
                   os.data_abertura, os.status_os, os.custo
            FROM ordens_servico os
            INNER JOIN maquinas m ON os.id_maquina = m.id_maquina
            INNER JOIN tecnicos t ON os.id_tecnico = t.id_tecnico
            ORDER BY os.data_abertura DESC
            LIMIT 10";
    
    $result = $conn->query($sql);
    
    if ($result->num_rows > 0) {
        echo "<table>";
        echo "<tr><th>ID OS</th><th>Máquina</th><th>Técnico</th><th>Data Abertura</th><th>Status</th><th>Custo</th></tr>";
        
        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row['id_os'] . "</td>";
            echo "<td>" . $row['nome_maquina'] . "</td>";
            echo "<td>" . $row['nome_tecnico'] . "</td>";
            echo "<td>" . date('d/m/Y', strtotime($row['data_abertura'])) . "</td>";
            echo "<td>" . $row['status_os'] . "</td>";
            echo "<td>R$ " . number_format($row['custo'], 2, ',', '.') . "</td>";
            echo "</tr>";
        }
        echo "</table>";
    } else {
        echo "Nenhum registro encontrado.";
    }
    
    $conn->close();
    ?>
</body>
</html>