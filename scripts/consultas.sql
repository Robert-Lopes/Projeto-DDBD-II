-- Consultas --

 -- Produtos com estoque crítico
 -- Quantidade em estoque abaixo de 500 unidades. --

SELECT nome, quantidade_estoque
FROM produtos
WHERE quantidade_estoque < 500;

 -- Fornecedores que fornecem os produtos mais caros
 -- Produtos que o preço está entre os 5 mais caros.
SELECT p.nome AS produto, p.preco, f.nome AS fornecedor
FROM produtos p
JOIN fornecedor f ON p.fornecedor_idfornecedor1 = f.idfornecedor
ORDER BY p.preco DESC
LIMIT 5;


 -- Promoções ativas no momento
 -- Liste as promoções ativas no dia específico, em um intervalo de datas.
SELECT descricao, percentual_desconto, data_inicio, data_fim
FROM Empresa.promocao
WHERE '2024-11-01' BETWEEN data_inicio AND data_fim;

 -- Consultar a quantidade total de pedidos por cliente, ordenada por volume de pedidos
 -- Descubra quais clientes têm mais pedidos realizados.
SELECT c.nome AS cliente, COUNT(p.idpedidos) AS total_pedidos
FROM clientes c
JOIN pedidos p ON c.idclientes = p.clientes_idclientes1
GROUP BY c.nome
ORDER BY total_pedidos DESC;


 -- Receita total por método de pagamento
 -- Somando os valores pagos e agrupando por cada método.
SELECT metodo_pagamento, SUM(valor_pago) AS receita_total
FROM pagamento
GROUP BY metodo_pagamento
ORDER BY receita_total DESC;

-- Funcionários responsáveis por pedidos atrasados.
-- Identificar os incompetentes.

SELECT f.nome AS funcionario, COUNT(p.idpedidos) AS pedidos_pendentes
FROM Empresa.funcionario f
JOIN Empresa.pedidos p ON f.idfuncionario = p.funcionario_idfuncionario
WHERE p.status NOT IN ('Finalizado', 'Entregue')
GROUP BY f.idfuncionario;
