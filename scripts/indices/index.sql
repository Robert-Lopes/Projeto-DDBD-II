CREATE INDEX idx_nome_produto ON produtos(nome);
CREATE INDEX idx_fornecedor_preco ON produtos(fornecedor_id, preco);

CREATE INDEX idx_data_pedido ON pedidos(data_pedido);
CREATE INDEX idx_cliente_status ON pedidos(clientes_id, status);

CREATE INDEX idx_produto ON itens_pedido(produto_id);
CREATE INDEX idx_pedido ON itens_pedido(pedido_id);

CREATE INDEX idx_data_pagamento ON pagamento(data_pagamento);
CREATE INDEX idx_metodo_pagamento ON pagamento(metodo_pagamento);

CREATE INDEX idx_nome_cliente ON clientes(nome);
CREATE INDEX idx_email_cliente ON clientes(email);

-- Consulta sem índice
SELECT * 
FROM pedidos 
WHERE clientes_id = 1 AND data_pedido BETWEEN '2024-11-01' AND '2024-11-20' AND status = 'em andamento';
-- obs: O índice idx_cliente_status e idx_data_pedido vão acelerar essa consulta.
-- Plano de execução
EXPLAIN SELECT * 
FROM pedidos 
WHERE clientes_id = 1 AND data_pedido BETWEEN '2024-11-01' AND '2024-11-20' AND status = 'em andamento';

SELECT p.nome, ip.quantidade 
FROM produtos p
JOIN itens_pedido ip ON p.idprodutos = ip.produto_id
JOIN pedidos pd ON ip.pedido_id = pd.idpedidos
WHERE pd.clientes_id = 1;
-- obs: O índice idx_produto e idx_pedido otimizam a busca nos joins.

-- função
DELIMITER $$

CREATE FUNCTION calcular_cambio (
    id INT, 
    taxa DECIMAL(5,2)
) 
RETURNS DECIMAL(10,2) 
DETERMINISTIC
BEGIN
    DECLARE valor DECIMAL(7,2);

    -- Valida se o ID existe e obtém o saldo
    SELECT avail_balance INTO valor
    FROM account
    WHERE account_id = id;

    -- Calcula e retorna o valor convertido
    RETURN taxa * valor;
END$$

DELIMITER ;

SELECT calcular_cambio(1, 5.25);
  
  
  -- Função para Calcular Desconto em um Pedido
  DELIMITER $$

CREATE FUNCTION calcular_desconto(
    total DECIMAL(10,2), 
    porcentagem DECIMAL(5,2)
) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN total - (total * (porcentagem / 100));
END$$

DELIMITER ;

SELECT calcular_desconto(500.00, 10.00) AS valor_com_desconto;

-- Essa função pode ser chamada dentro de outras consultas, por exemplo:
SELECT pedido_id, calcular_desconto(total_pedido, desconto_percentual) AS valor_final
FROM pedidos;
