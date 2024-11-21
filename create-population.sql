-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema Empresa
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Empresa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Empresa` ;
USE `Empresa` ;

-- -----------------------------------------------------
-- Table `Empresa`.`fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empresa`.`fornecedor` (
  `idfornecedor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `telefone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `endereco` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idfornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empresa`.`produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empresa`.`produtos` (
  `idprodutos` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `descricao` VARCHAR(255) NULL,
  `preco` DECIMAL(6,2) NULL,
  `quantidade_estoque` INT NULL,
  `fornecedor_idfornecedor` INT NOT NULL,
  `fornecedor_idfornecedor1` INT NOT NULL,
  PRIMARY KEY (`idprodutos`, `fornecedor_idfornecedor1`),
  INDEX `fk_produtos_fornecedor1_idx` (`fornecedor_idfornecedor1` ASC) VISIBLE,
  CONSTRAINT `fk_produtos_fornecedor1`
    FOREIGN KEY (`fornecedor_idfornecedor1`)
    REFERENCES `Empresa`.`fornecedor` (`idfornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empresa`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empresa`.`clientes` (
  `idclientes` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `endereco` VARCHAR(45) NULL,
  PRIMARY KEY (`idclientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empresa`.`transportadora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empresa`.`transportadora` (
  `idtransportadora` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `telefone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`idtransportadora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empresa`.`funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empresa`.`funcionario` (
  `idfuncionario` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  `cargo` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`idfuncionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empresa`.`promocao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empresa`.`promocao` (
  `idpromocao` INT NOT NULL,
  `descricao` VARCHAR(45) NULL,
  `percentual_desconto` DECIMAL(2) NULL,
  `data_inicio` DATE NULL,
  `data_fim` DATE NULL,
  PRIMARY KEY (`idpromocao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empresa`.`pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empresa`.`pedidos` (
  `idpedidos` INT NOT NULL,
  `data_pedido` DATETIME(6) NULL,
  `status` VARCHAR(45) NULL,
  `clientes_idclientes` INT NOT NULL,
  `clientes_idclientes1` INT NOT NULL,
  `transportadora_idtransportadora` INT NOT NULL,
  `funcionario_idfuncionario` INT NOT NULL,
  `promocao_idpromocao` INT NOT NULL,
  PRIMARY KEY (`idpedidos`, `clientes_idclientes1`, `transportadora_idtransportadora`, `funcionario_idfuncionario`, `promocao_idpromocao`),
  INDEX `fk_pedidos_clientes_idx` (`clientes_idclientes1` ASC) VISIBLE,
  INDEX `fk_pedidos_transportadora1_idx` (`transportadora_idtransportadora` ASC) VISIBLE,
  INDEX `fk_pedidos_funcionario1_idx` (`funcionario_idfuncionario` ASC) VISIBLE,
  INDEX `fk_pedidos_promocao1_idx` (`promocao_idpromocao` ASC) VISIBLE,
  CONSTRAINT `fk_pedidos_clientes`
    FOREIGN KEY (`clientes_idclientes1`)
    REFERENCES `Empresa`.`clientes` (`idclientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_transportadora1`
    FOREIGN KEY (`transportadora_idtransportadora`)
    REFERENCES `Empresa`.`transportadora` (`idtransportadora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_funcionario1`
    FOREIGN KEY (`funcionario_idfuncionario`)
    REFERENCES `Empresa`.`funcionario` (`idfuncionario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_promocao1`
    FOREIGN KEY (`promocao_idpromocao`)
    REFERENCES `Empresa`.`promocao` (`idpromocao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empresa`.`itens_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empresa`.`itens_pedido` (
  `iditens_pedido` INT NOT NULL AUTO_INCREMENT,
  `quantidade` INT NULL,
  `preco_unitario` DECIMAL(6,2) NULL,
  `produtos_idprodutos` INT NOT NULL,
  `pedidos_idpedidos` INT NOT NULL,
  `pedidos_idpedidos1` INT NOT NULL,
  `pedidos_clientes_idclientes1` INT NOT NULL,
  `produtos_idprodutos1` INT NOT NULL,
  PRIMARY KEY (`iditens_pedido`, `pedidos_idpedidos1`, `pedidos_clientes_idclientes1`, `produtos_idprodutos1`),
  INDEX `fk_itens_pedido_pedidos1_idx` (`pedidos_idpedidos1` ASC, `pedidos_clientes_idclientes1` ASC) VISIBLE,
  INDEX `fk_itens_pedido_produtos1_idx` (`produtos_idprodutos1` ASC) VISIBLE,
  CONSTRAINT `fk_itens_pedido_pedidos1`
    FOREIGN KEY (`pedidos_idpedidos1` , `pedidos_clientes_idclientes1`)
    REFERENCES `Empresa`.`pedidos` (`idpedidos` , `clientes_idclientes1`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_pedido_produtos1`
    FOREIGN KEY (`produtos_idprodutos1`)
    REFERENCES `Empresa`.`produtos` (`idprodutos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Empresa`.`pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empresa`.`pagamento` (
  `idpagamento` INT NOT NULL,
  `data_pagamento` DATE NULL,
  `valor_pago` DECIMAL(15, 2) NULL,
  `metodo_pagamento` VARCHAR(45) NOT NULL,
  `pedidos_idpedidos` INT NOT NULL,
  `pedidos_clientes_idclientes1` INT NOT NULL,
  `pedidos_transportadora_idtransportadora` INT NOT NULL,
  PRIMARY KEY (`idpagamento`, `pedidos_idpedidos`, `pedidos_clientes_idclientes1`, `pedidos_transportadora_idtransportadora`),
  INDEX `fk_pagamento_pedidos1_idx` (`pedidos_idpedidos` ASC, `pedidos_clientes_idclientes1` ASC, `pedidos_transportadora_idtransportadora` ASC) VISIBLE,
  CONSTRAINT `fk_pagamento_pedidos1`
    FOREIGN KEY (`pedidos_idpedidos` , `pedidos_clientes_idclientes1` , `pedidos_transportadora_idtransportadora`)
    REFERENCES `Empresa`.`pedidos` (`idpedidos` , `clientes_idclientes1` , `transportadora_idtransportadora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

DELIMITER $$
CREATE PROCEDURE povoar_transportadora(IN arquivo JSON)
BEGIN
    DECLARE tamanho INT;
    DECLARE indice INT DEFAULT 0;
    DECLARE id INT;

    -- Obtém o próximo ID disponível para inserção
    SELECT IFNULL(MAX(idtransportadora), 0) + 1 INTO id
    FROM transportadora;

    -- Obtém o número de elementos no JSON
    SET tamanho = JSON_LENGTH(arquivo);

    -- Loop para iterar pelos elementos do JSON e inserir no banco
    WHILE indice < tamanho DO
        INSERT INTO transportadora (idtransportadora, nome, telefone, email)
        VALUES (
            id,
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].nome'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].telefone'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].email')))
        );
        
        -- Incrementa o ID e o índice
        SET id = id + 1;
        SET indice = indice + 1;
    END WHILE;
END$$
DELIMITER $$

DELIMITER $$
CREATE PROCEDURE povoar_funcionario(IN arquivo JSON)
BEGIN 
	DECLARE tamanho INT;
    DECLARE indice INT DEFAULT 0;
    DECLARE id INT;
	DECLARE id_inicial INT;
    
    -- Obtém o próximo ID disponível para inserção
    SELECT IFNULL(MAX(idfuncionario), 0) + 1 INTO id
    FROM funcionario;
    
	SET id_inicial = id;

    -- Obtém o número de elementos no JSON
    SET tamanho = JSON_LENGTH(arquivo);
    
	
	WHILE indice < tamanho DO
        INSERT INTO funcionario (idfuncionario, nome, cargo, email)
        VALUES (
            id,
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].nome'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].cargo'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].email')))
        );
        
        -- Incrementa o ID e o índice
        SET id = id + 1;
        SET indice = indice + 1;
    END WHILE;
    
    SELECT *, "Funcionário Cadastrado Com Sucesso" as "Status" 
    FROM funcionario
    where idfuncionario >= id_inicial;
END $$
DELIMITER $$

DELIMITER $$
CREATE PROCEDURE povoar_clientes(IN arquivo JSON)
BEGIN 
	DECLARE tamanho INT;
    DECLARE indice INT DEFAULT 0;
    DECLARE id INT;
	DECLARE id_inicial INT;
    
    -- Obtém o próximo ID disponível para inserção
    SELECT IFNULL(MAX(idclientes), 0) + 1 INTO id
    FROM clientes;
    
	SET id_inicial = id;

    -- Obtém o número de elementos no JSON
    SET tamanho = JSON_LENGTH(arquivo);
    
	
	WHILE indice < tamanho DO
        INSERT INTO clientes (idclientes, nome, telefone, email, endereco)
        VALUES (
            id,
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].nome'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].telefone'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].email'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].endereco')))
        );
        
        -- Incrementa o ID e o índice
        SET id = id + 1;
        SET indice = indice + 1;
    END WHILE;
    
    SELECT *, "Cliente Cadastrado Com Sucesso" as "Status" 
    FROM clientes
    where idclientes >= id_inicial;
END $$
DELIMITER $$

DELIMITER $$
CREATE PROCEDURE povoar_promocao(IN arquivo JSON)
BEGIN 
	DECLARE tamanho INT;
    DECLARE indice INT DEFAULT 0;
    DECLARE id INT;
	DECLARE id_inicial INT;
    
    -- Obtém o próximo ID disponível para inserção
    SELECT IFNULL(MAX(idpromocao), 0) + 1 INTO id
    FROM promocao;
    
	SET id_inicial = id;

    -- Obtém o número de elementos no JSON
    SET tamanho = JSON_LENGTH(arquivo);
    
	
	WHILE indice < tamanho DO
        INSERT INTO promocao (idpromocao, descricao, percentual_desconto, data_inicio, data_fim)
        VALUES (
            id,
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].descricao'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].percentual_desconto'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].data_inicio'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].data_fim')))
        );
        
        -- Incrementa o ID e o índice
        SET id = id + 1;
        SET indice = indice + 1;
    END WHILE;
    
    SELECT *, "Promocao Cadastrada Com Sucesso" as "Status" 
    FROM promocao
    where idpromocao >= id_inicial;
END $$
DELIMITER $$

DELIMITER $$
CREATE PROCEDURE povoar_pedidos(IN arquivo JSON)
BEGIN 
	DECLARE tamanho INT;
    DECLARE indice INT DEFAULT 0;
    DECLARE id INT;
	DECLARE id_inicial INT;
    
    -- Obtém o próximo ID disponível para inserção
    SELECT IFNULL(MAX(idpedidos), 0) + 1 INTO id
    FROM pedidos;
    
	SET id_inicial = id;

    -- Obtém o número de elementos no JSON
    SET tamanho = JSON_LENGTH(arquivo);
    
	
	WHILE indice < tamanho DO
        INSERT INTO pedidos (idpedidos, data_pedido, status, clientes_idclientes, clientes_idclientes1, transportadora_idtransportadora, funcionario_idfuncionario, promocao_idpromocao)
        VALUES (
            id,
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].data_pedido'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].status'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].clientes_idclientes'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].clientes_idclientes'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].transportadora_idtransportadora'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].funcionario_idfuncionario'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].promocao_idpromocao')))
        );
        
        -- Incrementa o ID e o índice
        SET id = id + 1;
        SET indice = indice + 1;
    END WHILE;
    
    SELECT *, "Pedido Cadastrada Com Sucesso" as "Status" 
    FROM pedidos
    where idpedidos >= id_inicial;
END $$
DELIMITER $$
    
DELIMITER $$ 
CREATE PROCEDURE povoar_pagamento(IN arquivo JSON)
BEGIN 
    DECLARE tamanho INT;
    DECLARE indice INT DEFAULT 0;
    DECLARE id INT;
    DECLARE id_inicial INT;
    DECLARE pedido_id INT;
    DECLARE cliente_id INT;
    DECLARE transportadora_id INT;
    
    -- Obtém o próximo ID disponível para inserção
    SELECT IFNULL(MAX(idpagamento), 0) + 1 INTO id
    FROM pagamento;
    
    SET id_inicial = id;

    -- Obtém o número de elementos no JSON
    SET tamanho = JSON_LENGTH(arquivo);
    
    WHILE indice < tamanho DO
        -- Coleta o pedido_id a partir do JSON
        SET pedido_id = JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].pedidos_idpedidos')));
        
        -- Busca o cliente_id e transportadora_id na tabela pedidos com base no pedido_id
        SELECT clientes_idclientes1, transportadora_idtransportadora INTO cliente_id, transportadora_id
        FROM pedidos
        WHERE idpedidos = pedido_id;

        -- Insere o pagamento com os dados extraídos do JSON e da tabela pedidos
        INSERT INTO pagamento (idpagamento, data_pagamento, valor_pago, metodo_pagamento, pedidos_idpedidos, pedidos_clientes_idclientes1, pedidos_transportadora_idtransportadora)
        VALUES (
            id,
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].data_pagamento'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].valor_pago'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].metodo_pagamento'))),
            pedido_id,
            cliente_id,
            transportadora_id
        );
        Select * from pedido;
        
        -- Incrementa o ID e o índice
        SET id = id + 1;
        SET indice = indice + 1;
    END WHILE;
    
    -- Retorna os pagamentos inseridos com status
    SELECT *, "Pedido Cadastrado Com Sucesso" as "Status"
    FROM pagamento
    WHERE idpagamento >= id_inicial;
END $$ 
DELIMITER $$ 
  
DELIMITER $$
CREATE PROCEDURE povoar_fornecedor(IN arquivo JSON)
BEGIN 
	DECLARE tamanho INT;
    DECLARE indice INT DEFAULT 0;
    DECLARE id INT;
	DECLARE id_inicial INT;
    
    -- Obtém o próximo ID disponível para inserção
    SELECT IFNULL(MAX(idfornecedor), 0) + 1 INTO id
    FROM fornecedor;
    
	SET id_inicial = id;

    -- Obtém o número de elementos no JSON
    SET tamanho = JSON_LENGTH(arquivo);
    
	WHILE indice < tamanho DO
        INSERT INTO fornecedor (idfornecedor, nome, telefone, email, endereco)
        VALUES (
            id,
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].nome'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].telefone'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].email'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].endereco')))
        );
        
        -- Incrementa o ID e o índice
        SET id = id + 1;
        SET indice = indice + 1;
    END WHILE;
    
    SELECT *, "Fornecedor Cadastrada Com Sucesso" as "Status" 
    FROM fornecedor
    where idfornecedor >= id_inicial;
END $$
DELIMITER $$

DELIMITER $$ 
CREATE PROCEDURE povoar_produtos(IN arquivo JSON)
BEGIN 
    DECLARE tamanho INT;
    DECLARE indice INT DEFAULT 0;
    DECLARE id INT;
    DECLARE id_inicial INT;

    -- Obtém o próximo ID disponível para inserção
    SELECT IFNULL(MAX(idprodutos), 0) + 1 INTO id
    FROM produtos;
    
    SET id_inicial = id;

    -- Obtém o número de elementos no JSON
    SET tamanho = JSON_LENGTH(arquivo);
    
    WHILE indice < tamanho DO
        -- Insere o produto com os dados extraídos do JSON
        INSERT INTO produtos (idprodutos, nome, descricao, preco, quantidade_estoque, fornecedor_idfornecedor, fornecedor_idfornecedor1)
        VALUES (
            id,
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].nome'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].descricao'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].preco'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].quantidade_estoque'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].fornecedor_idfornecedor1'))),
			JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].fornecedor_idfornecedor1')))
        );
        
        -- Incrementa o ID e o índice
        SET id = id + 1;
        SET indice = indice + 1;
    END WHILE;
    
    -- Retorna os produtos inseridos com status
    SELECT *, "Produto Cadastrado Com Sucesso" as "Status"
    FROM produtos
    WHERE idprodutos >= id_inicial;
END $$ 
DELIMITER $$;

DELIMITER $$ 
CREATE PROCEDURE povoar_itens_pedido(IN arquivo JSON)
BEGIN 
    DECLARE tamanho INT;
    DECLARE indice INT DEFAULT 0;
    DECLARE id INT;
    DECLARE id_inicial INT;
    DECLARE pedido_id INT;
    DECLARE cliente_id INT;
    DECLARE produto_id INT;
    DECLARE preco_unitario INT;
    
    -- Obtém o próximo ID disponível para inserção
    SELECT IFNULL(MAX(iditens_pedido), 0) + 1 INTO id
    FROM itens_pedido;
    
    SET id_inicial = id;

    -- Obtém o número de elementos no JSON
    SET tamanho = JSON_LENGTH(arquivo);
    
    WHILE indice < tamanho DO
        -- Coleta o pedido_id a partir do JSON
        SET pedido_id = JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].pedidos_idpedidos')));
        SET produto_id = JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].produtos_idprodutos')));
        
        -- Busca o cliente_id e transportadora_id na tabela pedidos com base no pedido_id
        SELECT clientes_idclientes1 INTO cliente_id
        FROM pedidos
        WHERE idpedidos = pedido_id;
        
        SELECT preco INTO preco_unitario
        FROM produtos
		WHERE produto_id = idprodutos;
        
        -- Insere o pagamento com os dados extraídos do JSON e da tabela pedidos
        INSERT INTO itens_pedido (iditens_pedido, quantidade, preco_unitario, produtos_idprodutos, pedidos_idpedidos, pedidos_idpedidos1, pedidos_clientes_idclientes1, produtos_idprodutos1)
        VALUES (
            id,
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].quantidade'))),
            preco_unitario,
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].produtos_idprodutos'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].pedidos_idpedidos'))),
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].pedidos_idpedidos'))),
            cliente_id,
            JSON_UNQUOTE(JSON_EXTRACT(arquivo, CONCAT('$[', indice, '].produtos_idprodutos')))
        );
        
        -- Incrementa o ID e o índice
        SET id = id + 1;
        SET indice = indice + 1;
    END WHILE;
    
    -- Retorna os pagamentos inseridos com status
    SELECT *, "Item Cadastrado Com Sucesso" as "Status"
    FROM itens_pedido
    WHERE iditens_pedido >= id_inicial;
END $$ 
DELIMITER $$ 

CALL povoar_promocao('[
{
  "descricao": "aliquam",
  "percentual_desconto": 58,
  "data_inicio": "2024/01/21",
  "data_fim": "2024/08/15"
}, {
  "descricao": "diam",
  "percentual_desconto": 66,
  "data_inicio": "2024/01/06",
  "data_fim": "2024/03/19"
}, {
  "descricao": "amet sapien dignissim",
  "percentual_desconto": 36,
  "data_inicio": "2024/01/22",
  "data_fim": "2024/11/08"
}, {
  "descricao": "velit vivamus vel",
  "percentual_desconto": 63,
  "data_inicio": "2023/12/06",
  "data_fim": "2024/06/29"
}, {
  "descricao": "in consequat ut",
  "percentual_desconto": 23,
  "data_inicio": "2024/01/23",
  "data_fim": "2024/09/05"
}, {
  "descricao": "sapien",
  "percentual_desconto": 44,
  "data_inicio": "2023/11/28",
  "data_fim": "2024/11/08"
}, {
  "descricao": "posuere nonummy integer",
  "percentual_desconto": 84,
  "data_inicio": "2023/12/11",
  "data_fim": "2024/03/23"
}, {
  "descricao": "lobortis",
  "percentual_desconto": 68,
  "data_inicio": "2024/01/27",
  "data_fim": "2024/09/02"
}, {
  "descricao": "venenatis non sodales",
  "percentual_desconto": 72,
  "data_inicio": "2024/02/04",
  "data_fim": "2024/10/02"
}, {
  "descricao": "tristique in",
  "percentual_desconto": 5,
  "data_inicio": "2023/12/30",
  "data_fim": "2024/07/15"
}, {
  "descricao": "morbi",
  "percentual_desconto": 46,
  "data_inicio": "2023/11/27",
  "data_fim": "2024/05/19"
}, {
  "descricao": "congue",
  "percentual_desconto": 15,
  "data_inicio": "2023/12/10",
  "data_fim": "2024/11/11"
}, {
  "descricao": "vehicula",
  "percentual_desconto": 96,
  "data_inicio": "2024/01/12",
  "data_fim": "2024/11/01"
}, {
  "descricao": "congue",
  "percentual_desconto": 62,
  "data_inicio": "2024/01/14",
  "data_fim": "2024/11/06"
}, {
  "descricao": "scelerisque mauris",
  "percentual_desconto": 69,
  "data_inicio": "2024/01/02",
  "data_fim": "2024/09/30"
}, {
  "descricao": "vestibulum ac est",
  "percentual_desconto": 7,
  "data_inicio": "2024/02/11",
  "data_fim": "2024/04/15"
}, {
  "descricao": "orci luctus et",
  "percentual_desconto": 11,
  "data_inicio": "2024/01/07",
  "data_fim": "2024/04/30"
}, {
  "descricao": "integer a",
  "percentual_desconto": 1,
  "data_inicio": "2024/01/19",
  "data_fim": "2024/07/06"
}, {
  "descricao": "vitae mattis nibh",
  "percentual_desconto": 66,
  "data_inicio": "2024/01/02",
  "data_fim": "2024/04/07"
}, {
  "descricao": "faucibus orci luctus",
  "percentual_desconto": 57,
  "data_inicio": "2024/02/18",
  "data_fim": "2024/07/28"
}, {
  "descricao": "dapibus at diam",
  "percentual_desconto": 44,
  "data_inicio": "2024/01/10",
  "data_fim": "2024/05/24"
}, {
  "descricao": "vitae nisi nam",
  "percentual_desconto": 63,
  "data_inicio": "2024/01/04",
  "data_fim": "2024/03/15"
}, {
  "descricao": "pede libero",
  "percentual_desconto": 52,
  "data_inicio": "2023/12/07",
  "data_fim": "2024/03/08"
}, {
  "descricao": "sit amet",
  "percentual_desconto": 14,
  "data_inicio": "2023/11/23",
  "data_fim": "2024/04/22"
}, {
  "descricao": "interdum mauris non",
  "percentual_desconto": 31,
  "data_inicio": "2023/11/30",
  "data_fim": "2024/03/19"
}, {
  "descricao": "risus dapibus",
  "percentual_desconto": 62,
  "data_inicio": "2024/02/23",
  "data_fim": "2024/04/14"
}, {
  "descricao": "quisque erat",
  "percentual_desconto": 18,
  "data_inicio": "2024/01/18",
  "data_fim": "2024/08/18"
}, {
  "descricao": "in faucibus",
  "percentual_desconto": 80,
  "data_inicio": "2024/01/06",
  "data_fim": "2024/09/28"
}, {
  "descricao": "posuere cubilia curae",
  "percentual_desconto": 42,
  "data_inicio": "2024/02/13",
  "data_fim": "2024/05/05"
}, {
  "descricao": "dapibus augue",
  "percentual_desconto": 47,
  "data_inicio": "2023/11/24",
  "data_fim": "2024/09/15"
}
]');

CALL povoar_clientes('[{
  "nome": "Ronna Trosdall",
  "telefone": "+62 (759) 722-6002",
  "email": "rtrosdall0@chron.com",
  "endereco": "58085 Grasskamp Center"
}, {
  "nome": "Janean Humburton",
  "telefone": "+62 (312) 936-5383",
  "email": "jhumburton1@cisco.com",
  "endereco": "75102 Northland Street"
}, {
  "nome": "Dacey Skermer",
  "telefone": "+235 (465) 931-6630",
  "email": "dskermer2@cpanel.net",
  "endereco": "7605 Northfield Point"
}, {
  "nome": "Sonia Budding",
  "telefone": "+86 (676) 458-8786",
  "email": "sbudding3@salon.com",
  "endereco": "19 Thierer Avenue"
}, {
  "nome": "Marcille Tierney",
  "telefone": "+976 (744) 776-0556",
  "email": "mtierney4@illinois.edu",
  "endereco": "454 Havey Court"
}, {
  "nome": "Darbie Treadgear",
  "telefone": "+380 (505) 380-6671",
  "email": "dtreadgear5@webmd.com",
  "endereco": "72 Florence Place"
}, {
  "nome": "Kris Dryburgh",
  "telefone": "+62 (546) 734-5145",
  "email": "kdryburgh6@miitbeian.gov.cn",
  "endereco": "4 Saint Paul Road"
}, {
  "nome": "Cointon Kaemena",
  "telefone": "+66 (354) 112-7737",
  "email": "ckaemena7@scribd.com",
  "endereco": "65901 Sherman Crossing"
}, {
  "nome": "Vilma Bushe",
  "telefone": "+598 (223) 305-5107",
  "email": "vbushe8@state.tx.us",
  "endereco": "62994 Laurel Pass"
}, {
  "nome": "Coralie Uttermare",
  "telefone": "+351 (533) 300-3980",
  "email": "cuttermare9@who.int",
  "endereco": "2117 Vera Terrace"
}, {
  "nome": "Rikki Willmot",
  "telefone": "+86 (314) 952-5256",
  "email": "rwillmota@comcast.net",
  "endereco": "648 Caliangt Plaza"
}, {
  "nome": "Robinet Stranks",
  "telefone": "+30 (367) 657-0508",
  "email": "rstranksb@gnu.org",
  "endereco": "83 Anzinger Circle"
}, {
  "nome": "Robbie Loney",
  "telefone": "+86 (318) 662-4240",
  "email": "rloneyc@edublogs.org",
  "endereco": "8 Cherokee Avenue"
}, {
  "nome": "Wittie Cankett",
  "telefone": "+1 (159) 691-8495",
  "email": "wcankettd@deliciousdays.com",
  "endereco": "6 Oneill Court"
}, {
  "nome": "Kaia Belham",
  "telefone": "+7 (169) 849-9550",
  "email": "kbelhame@mtv.com",
  "endereco": "7 1st Street"
}, {
  "nome": "Auberta Goves",
  "telefone": "+250 (346) 575-4289",
  "email": "agovesf@mozilla.org",
  "endereco": "76 Scoville Place"
}, {
  "nome": "Elly Rylatt",
  "telefone": "+55 (624) 643-1444",
  "email": "erylattg@fda.gov",
  "endereco": "72489 Sunfield Road"
}, {
  "nome": "Gabie Squires",
  "telefone": "+380 (594) 169-8022",
  "email": "gsquiresh@slideshare.net",
  "endereco": "7 Moulton Avenue"
}, {
  "nome": "Hamlen Jeakins",
  "telefone": "+970 (113) 608-4266",
  "email": "hjeakinsi@tinypic.com",
  "endereco": "72 Golf Course Alley"
}, {
  "nome": "Pamelina Kruschev",
  "telefone": "+30 (470) 429-6562",
  "email": "pkruschevj@bing.com",
  "endereco": "32203 Tony Avenue"
}, {
  "nome": "Geoffrey Seakings",
  "telefone": "+420 (753) 915-8920",
  "email": "gseakingsk@europa.eu",
  "endereco": "4 North Lane"
}, {
  "nome": "Hayes Howson",
  "telefone": "+86 (316) 355-6983",
  "email": "hhowsonl@blogger.com",
  "endereco": "9504 Colorado Avenue"
}, {
  "nome": "Saundra Purcer",
  "telefone": "+48 (854) 489-9819",
  "email": "spurcerm@addtoany.com",
  "endereco": "18735 Del Sol Crossing"
}, {
  "nome": "Hali Skirrow",
  "telefone": "+55 (814) 893-1788",
  "email": "hskirrown@sfgate.com",
  "endereco": "62622 Ridgeview Terrace"
}, {
  "nome": "Elane Edwardes",
  "telefone": "+48 (857) 956-6413",
  "email": "eedwardeso@acquirethisname.com",
  "endereco": "5954 Sycamore Hill"
}, {
  "nome": "Emlyn Fealey",
  "telefone": "+7 (695) 655-6390",
  "email": "efealeyp@privacy.gov.au",
  "endereco": "890 Talmadge Park"
}, {
  "nome": "Eldredge Moreinu",
  "telefone": "+62 (428) 700-0718",
  "email": "emoreinuq@oakley.com",
  "endereco": "1 Hermina Lane"
}, {
  "nome": "Morgun Cade",
  "telefone": "+57 (877) 199-3027",
  "email": "mcader@i2i.jp",
  "endereco": "04 Emmet Street"
}, {
  "nome": "Tim Dyerson",
  "telefone": "+86 (151) 264-4174",
  "email": "tdyersons@google.cn",
  "endereco": "79560 Texas Court"
}, {
  "nome": "Clarance Dobel",
  "telefone": "+62 (515) 435-9328",
  "email": "cdobelt@utexas.edu",
  "endereco": "41792 Prairie Rose Trail"
}, {
  "nome": "Win Hercock",
  "telefone": "+66 (317) 543-0446",
  "email": "whercocku@opera.com",
  "endereco": "6 Hoepker Center"
}, {
  "nome": "Evita Furmedge",
  "telefone": "+86 (509) 609-2829",
  "email": "efurmedgev@elegantthemes.com",
  "endereco": "6658 Shasta Court"
}, {
  "nome": "Eda Utton",
  "telefone": "+225 (613) 553-6818",
  "email": "euttonw@msn.com",
  "endereco": "9635 Stuart Road"
}, {
  "nome": "Ryan McGuiney",
  "telefone": "+966 (744) 933-4196",
  "email": "rmcguineyx@jalbum.net",
  "endereco": "66751 Cascade Alley"
}, {
  "nome": "Fancie Cochern",
  "telefone": "+98 (527) 953-9282",
  "email": "fcocherny@aol.com",
  "endereco": "70639 Hoard Center"
}, {
  "nome": "Ruth Gelly",
  "telefone": "+86 (369) 132-6581",
  "email": "rgellyz@networksolutions.com",
  "endereco": "1104 Northport Court"
}, {
  "nome": "Aleta Yo",
  "telefone": "+1 (585) 361-6411",
  "email": "ayo10@statcounter.com",
  "endereco": "964 Lakeland Parkway"
}, {
  "nome": "Everett Hollow",
  "telefone": "+86 (582) 119-1378",
  "email": "ehollow11@instagram.com",
  "endereco": "6 Warbler Plaza"
}, {
  "nome": "Alikee Eixenberger",
  "telefone": "+7 (278) 748-7809",
  "email": "aeixenberger12@amazon.de",
  "endereco": "748 Petterle Way"
}, {
  "nome": "Lorilee Bardey",
  "telefone": "+86 (890) 236-2042",
  "email": "lbardey13@jimdo.com",
  "endereco": "2169 Canary Terrace"
}, {
  "nome": "Neel Bunclark",
  "telefone": "+86 (356) 813-5917",
  "email": "nbunclark14@hibu.com",
  "endereco": "467 Maple Alley"
}, {
  "nome": "Hart Huccaby",
  "telefone": "+86 (874) 523-8982",
  "email": "hhuccaby15@hostgator.com",
  "endereco": "3 Mallard Plaza"
}, {
  "nome": "Toby Critten",
  "telefone": "+98 (754) 846-3273",
  "email": "tcritten16@bandcamp.com",
  "endereco": "91393 Swallow Avenue"
}, {
  "nome": "Myrwyn Schruurs",
  "telefone": "+51 (800) 535-9879",
  "email": "mschruurs17@zimbio.com",
  "endereco": "51 Sachs Lane"
}, {
  "nome": "Lindsey Bleakley",
  "telefone": "+86 (853) 193-4487",
  "email": "lbleakley18@goo.gl",
  "endereco": "51 Stoughton Crossing"
}, {
  "nome": "Andre Matej",
  "telefone": "+234 (683) 786-3944",
  "email": "amatej19@multiply.com",
  "endereco": "93383 Fairfield Circle"
}, {
  "nome": "Rickard Drei",
  "telefone": "+226 (762) 214-3419",
  "email": "rdrei1a@house.gov",
  "endereco": "6013 Kim Drive"
}, {
  "nome": "Harrie Solomonides",
  "telefone": "+254 (566) 170-1311",
  "email": "hsolomonides1b@amazon.co.jp",
  "endereco": "3 Carioca Drive"
}, {
  "nome": "Afton McDell",
  "telefone": "+255 (104) 177-4511",
  "email": "amcdell1c@wp.com",
  "endereco": "5279 Monterey Place"
}, {
  "nome": "Aleda Parkhouse",
  "telefone": "+81 (860) 705-5404",
  "email": "aparkhouse1d@i2i.jp",
  "endereco": "5136 Summerview Parkway"
}, {
  "nome": "Merry Escale",
  "telefone": "+33 (796) 722-4030",
  "email": "mescale1e@howstuffworks.com",
  "endereco": "0390 8th Circle"
}, {
  "nome": "Krispin Von Brook",
  "telefone": "+591 (170) 531-9571",
  "email": "kvon1f@bbc.co.uk",
  "endereco": "5724 Northport Way"
}, {
  "nome": "Marga Weiss",
  "telefone": "+62 (125) 175-2938",
  "email": "mweiss1g@cafepress.com",
  "endereco": "130 Harper Plaza"
}, {
  "nome": "Hunfredo Ruegg",
  "telefone": "+86 (764) 287-8479",
  "email": "hruegg1h@comsenz.com",
  "endereco": "630 Gulseth Circle"
}, {
  "nome": "Fenelia Prater",
  "telefone": "+62 (445) 564-8821",
  "email": "fprater1i@goo.ne.jp",
  "endereco": "5 Eagle Crest Trail"
}, {
  "nome": "Andy Fashion",
  "telefone": "+55 (121) 564-9929",
  "email": "afashion1j@hp.com",
  "endereco": "4380 Charing Cross Way"
}, {
  "nome": "Towny Clemes",
  "telefone": "+46 (238) 802-8375",
  "email": "tclemes1k@freewebs.com",
  "endereco": "021 Arkansas Avenue"
}, {
  "nome": "Clair Ivory",
  "telefone": "+58 (102) 119-7570",
  "email": "civory1l@hubpages.com",
  "endereco": "1054 Towne Plaza"
}, {
  "nome": "Elie Coller",
  "telefone": "+385 (533) 360-9355",
  "email": "ecoller1m@webeden.co.uk",
  "endereco": "3742 Carey Alley"
}, {
  "nome": "Papagena Normabell",
  "telefone": "+62 (820) 353-7376",
  "email": "pnormabell1n@microsoft.com",
  "endereco": "55 Lien Circle"
}, {
  "nome": "Klaus Dingwall",
  "telefone": "+86 (738) 908-4752",
  "email": "kdingwall1o@csmonitor.com",
  "endereco": "68589 Amoth Park"
}, {
  "nome": "Lizbeth Zielinski",
  "telefone": "+98 (581) 414-2028",
  "email": "lzielinski1p@merriam-webster.com",
  "endereco": "66 Drewry Point"
}, {
  "nome": "Nydia Doughtery",
  "telefone": "+7 (491) 270-8250",
  "email": "ndoughtery1q@wired.com",
  "endereco": "23056 Namekagon Crossing"
}, {
  "nome": "Sinclair Doge",
  "telefone": "+249 (675) 822-6707",
  "email": "sdoge1r@blogger.com",
  "endereco": "9042 Lakewood Parkway"
}, {
  "nome": "Parry Bockmann",
  "telefone": "+55 (924) 972-6028",
  "email": "pbockmann1s@intel.com",
  "endereco": "38376 Hoard Avenue"
}, {
  "nome": "Ole Mackney",
  "telefone": "+33 (190) 539-6998",
  "email": "omackney1t@discovery.com",
  "endereco": "2288 Lighthouse Bay Road"
}, {
  "nome": "Aymer Wasmuth",
  "telefone": "+420 (215) 895-3183",
  "email": "awasmuth1u@sciencedaily.com",
  "endereco": "52374 Bayside Street"
}, {
  "nome": "Aleksandr Boyton",
  "telefone": "+86 (328) 310-5330",
  "email": "aboyton1v@earthlink.net",
  "endereco": "9804 Moland Crossing"
}, {
  "nome": "Sven Thon",
  "telefone": "+55 (574) 423-3749",
  "email": "sthon1w@washingtonpost.com",
  "endereco": "2 Namekagon Junction"
}, {
  "nome": "Minette Viegas",
  "telefone": "+62 (109) 736-5692",
  "email": "mviegas1x@pinterest.com",
  "endereco": "007 Norway Maple Terrace"
}, {
  "nome": "Christa Okell",
  "telefone": "+86 (132) 474-6994",
  "email": "cokell1y@w3.org",
  "endereco": "6260 Eagan Alley"
}, {
  "nome": "Jennee Plomer",
  "telefone": "+374 (933) 641-2143",
  "email": "jplomer1z@latimes.com",
  "endereco": "7 Park Meadow Place"
}, {
  "nome": "Gleda Dugue",
  "telefone": "+62 (744) 147-3289",
  "email": "gdugue20@sphinn.com",
  "endereco": "0 Talmadge Crossing"
}, {
  "nome": "Vivyanne Boeter",
  "telefone": "+46 (187) 899-9590",
  "email": "vboeter21@ask.com",
  "endereco": "606 Delladonna Avenue"
}, {
  "nome": "Arin Stiegar",
  "telefone": "+420 (608) 810-4448",
  "email": "astiegar22@yelp.com",
  "endereco": "60228 Merchant Junction"
}, {
  "nome": "Matthias Warlawe",
  "telefone": "+63 (161) 959-9544",
  "email": "mwarlawe23@friendfeed.com",
  "endereco": "5424 Orin Junction"
}, {
  "nome": "Queenie Lathleiffure",
  "telefone": "+62 (794) 503-3894",
  "email": "qlathleiffure24@sciencedirect.com",
  "endereco": "03162 Montana Point"
}, {
  "nome": "Janey Jakeman",
  "telefone": "+675 (988) 448-1586",
  "email": "jjakeman25@com.com",
  "endereco": "1085 Manitowish Street"
}, {
  "nome": "Alford Gemmell",
  "telefone": "+86 (931) 266-8295",
  "email": "agemmell26@skype.com",
  "endereco": "272 Goodland Road"
}, {
  "nome": "Karlan Narramore",
  "telefone": "+251 (865) 100-1259",
  "email": "knarramore27@live.com",
  "endereco": "2440 Lunder Drive"
}, {
  "nome": "Egor Adamsen",
  "telefone": "+221 (754) 366-5634",
  "email": "eadamsen28@va.gov",
  "endereco": "174 Columbus Street"
}, {
  "nome": "Whitman Rosenberg",
  "telefone": "+254 (577) 503-0528",
  "email": "wrosenberg29@skyrock.com",
  "endereco": "0 Arizona Plaza"
}, {
  "nome": "Waldemar Harkins",
  "telefone": "+33 (386) 140-1817",
  "email": "wharkins2a@ftc.gov",
  "endereco": "16808 Waxwing Alley"
}, {
  "nome": "Candie Redrup",
  "telefone": "+33 (394) 398-8767",
  "email": "credrup2b@marriott.com",
  "endereco": "10 Packers Way"
}, {
  "nome": "Gussi Burns",
  "telefone": "+48 (560) 513-8982",
  "email": "gburns2c@mayoclinic.com",
  "endereco": "201 Farragut Lane"
}, {
  "nome": "Eran Du Barry",
  "telefone": "+30 (524) 439-2762",
  "email": "edu2d@imgur.com",
  "endereco": "2 Shopko Lane"
}, {
  "nome": "Gabriel Grummitt",
  "telefone": "+63 (890) 773-6615",
  "email": "ggrummitt2e@squarespace.com",
  "endereco": "0 Mifflin Court"
}, {
  "nome": "Stanly Le Monnier",
  "telefone": "+7 (733) 624-8540",
  "email": "sle2f@phoca.cz",
  "endereco": "5 Sachs Terrace"
}, {
  "nome": "Jabez Hazeldean",
  "telefone": "+86 (276) 152-3526",
  "email": "jhazeldean2g@phoca.cz",
  "endereco": "43857 Dapin Way"
}, {
  "nome": "Deanna Hintzer",
  "telefone": "+86 (511) 577-9990",
  "email": "dhintzer2h@themeforest.net",
  "endereco": "0 Northfield Road"
}, {
  "nome": "Leeann Tesauro",
  "telefone": "+381 (506) 122-3997",
  "email": "ltesauro2i@storify.com",
  "endereco": "6 Moland Avenue"
}, {
  "nome": "Lindsey Langshaw",
  "telefone": "+996 (704) 768-9794",
  "email": "llangshaw2j@chron.com",
  "endereco": "09 Esch Center"
}, {
  "nome": "Orland Lamplugh",
  "telefone": "+86 (393) 881-2206",
  "email": "olamplugh2k@ycombinator.com",
  "endereco": "3 Farwell Parkway"
}, {
  "nome": "Alidia Lawry",
  "telefone": "+81 (646) 301-2463",
  "email": "alawry2l@washingtonpost.com",
  "endereco": "5 West Lane"
}, {
  "nome": "Vinni Salazar",
  "telefone": "+63 (496) 337-9633",
  "email": "vsalazar2m@artisteer.com",
  "endereco": "207 Myrtle Terrace"
}, {
  "nome": "Gail Letertre",
  "telefone": "+33 (646) 228-8938",
  "email": "gletertre2n@samsung.com",
  "endereco": "5 Manitowish Pass"
}, {
  "nome": "Ulric Langridge",
  "telefone": "+66 (511) 715-4210",
  "email": "ulangridge2o@slashdot.org",
  "endereco": "441 Straubel Pass"
}, {
  "nome": "Garfield Poundford",
  "telefone": "+33 (313) 894-2333",
  "email": "gpoundford2p@whitehouse.gov",
  "endereco": "08034 Loomis Terrace"
}, {
  "nome": "Joceline Cauldfield",
  "telefone": "+351 (678) 977-1576",
  "email": "jcauldfield2q@japanpost.jp",
  "endereco": "77 Petterle Point"
}, {
  "nome": "Bonnie Siney",
  "telefone": "+86 (574) 148-6178",
  "email": "bsiney2r@admin.ch",
  "endereco": "4 Eggendart Parkway"
}]');

CALL povoar_transportadora('[
    {"nome":"Heaney-Tillman","telefone":"+51 (186) 509-2711","email":"mbloxsome0@smh.com.au"},
    {"nome":"Toy-Lueilwitz","telefone":"+385 (588) 801-0629","email":"ejoyes1@eventbrite.com"},
    {"nome":"Konopelski, Wilkinson and Lakin","telefone":"+375 (583) 444-7413","email":"tcrosher2@sogou.com"},
    {"nome":"Prosacco-Wiza","telefone":"+86 (415) 753-5057","email":"dlghan3@behance.net"},
    {"nome":"Wehner-Powlowski","telefone":"+62 (283) 565-2323","email":"gkermitt4@answers.com"},
    {"nome":"Barrows, Spencer and Beer","telefone":"+63 (405) 496-7583","email":"opeck5@is.gd"},
    {"nome":"Jaskolski Group","telefone":"+98 (954) 477-1308","email":"cmclagain6@yahoo.co.jp"},
    {"nome":"Heidenreich and Sons","telefone":"+62 (458) 105-7151","email":"nalbany7@amazon.co.uk"},
    {"nome":"Towne Group","telefone":"+86 (776) 224-8001","email":"rwaylett8@loc.gov"},
    {"nome":"Reilly-Hoeger","telefone":"+86 (324) 321-7398","email":"sdark9@amazon.co.jp"}
]');

CALL povoar_funcionario('[
  {
    "nome": "Shannon Clubley",
    "cargo": "Health Care",
    "email": "sclubley0@deliciousdays.com"
  },
  {
    "nome": "Courtenay Elsmore",
    "cargo": "Technology",
    "email": "celsmore1@imageshack.us"
  },
  {
    "nome": "Jules Jeffes",
    "cargo": "Energy",
    "email": "jjeffes2@privacy.gov.au"
  },
  {
    "nome": "Sutherland Dumsday",
    "cargo": "Finance",
    "email": "sdumsday3@w3.org"
  },
  {
    "nome": "Hilda Biaggioni",
    "cargo": "Finance",
    "email": "hbiaggioni4@ucsd.edu"
  },
  {
    "nome": "Elka Skellorne",
    "cargo": "Finance",
    "email": "eskellorne5@twitpic.com"
  },
  {
    "nome": "Baudoin Charrett",
    "cargo": "Consumer Services",
    "email": "bcharrett6@blog.com"
  },
  {
    "nome": "Eveleen Heamus",
    "cargo": "Health Care",
    "email": "eheamus7@apple.com"
  },
  {
    "nome": "Aura Doll",
    "cargo": "Finance",
    "email": "adoll8@ask.com"
  },
  {
    "nome": "Constantina Alleyn",
    "cargo": "Miscellaneous",
    "email": "calleyn9@marriott.com"
  },
  {
    "nome": "Giulia Beever",
    "cargo": "Consumer Non-Durables",
    "email": "gbeevera@last.fm"
  },
  {
    "nome": "Alana Caldroni",
    "cargo": "Finance",
    "email": "acaldronib@rakuten.co.jp"
  },
  {
    "nome": "Mallory Haine",
    "cargo": "Health Care",
    "email": "mhainec@earthlink.net"
  },
  {
    "nome": "Mommy Scutchin",
    "cargo": "Capital Goods",
    "email": "mscutchind@weibo.com"
  },
  {
    "nome": "Lock Mainson",
    "cargo": "Finance",
    "email": "lmainsone@java.com"
  },
  {
    "nome": "Terri Paine",
    "cargo": "Consumer Durables",
    "email": "tpainef@wikimedia.org"
  },
  {
    "nome": "Mildrid Eschalotte",
    "cargo": "Miscellaneous",
    "email": "meschalotteg@people.com.cn"
  },
  {
    "nome": "Danya Critchley",
    "cargo": "Health Care",
    "email": "dcritchleyh@nps.gov"
  },
  {
    "nome": "Analise Libbie",
    "cargo": "Technology",
    "email": "alibbiei@ucla.edu"
  },
  {
    "nome": "Celle Widdison",
    "cargo": "Finance",
    "email": "cwiddisonj@un.org"
  },
  {
    "nome": "Rosie Worboys",
    "cargo": "Finance",
    "email": "rworboysk@ning.com"
  },
  {
    "nome": "Enid Aleksashin",
    "cargo": "Health Care",
    "email": "ealeksashinl@pagesperso-orange.fr"
  },
  {
    "nome": "Ninnette Jenkinson",
    "cargo": "Energy",
    "email": "njenkinsonm@twitpic.com"
  },
  {
    "nome": "Isadore Walster",
    "cargo": "Consumer Services",
    "email": "iwalstern@tuttocitta.it"
  },
  {
    "nome": "Murielle Duffit",
    "cargo": "Consumer Services",
    "email": "mduffito@amazon.co.jp"
  },
  {
    "nome": "Alic Hulson",
    "cargo": "Energy",
    "email": "ahulsonp@mtv.com"
  },
  {
    "nome": "Leeanne Poulston",
    "cargo": "Consumer Services",
    "email": "lpoulstonq@twitpic.com"
  },
  {
    "nome": "Mozelle Hustings",
    "cargo": "Health Care",
    "email": "mhustingsr@microsoft.com"
  },
  {
    "nome": "Kane Tallow",
    "cargo": "Capital Goods",
    "email": "ktallows@phoca.cz"
  },
  {
    "nome": "Arny Robinson",
    "cargo": "Finance",
    "email": "arobinsont@gizmodo.com"
  },
  {
    "nome": "Alyosha Mullen",
    "cargo": "Finance",
    "email": "amullenu@forbes.com"
  },
  {
    "nome": "Mitzi Renne",
    "cargo": "Health Care",
    "email": "mrennev@netvibes.com"
  },
  {
    "nome": "Barnabe Guilloton",
    "cargo": "Capital Goods",
    "email": "bguillotonw@godaddy.com"
  },
  {
    "nome": "Tabina Roony",
    "cargo": "Consumer Services",
    "email": "troonyx@amazon.co.uk"
  },
  {
    "nome": "Marna McLaggan",
    "cargo": "Consumer Durables",
    "email": "mmclaggany@nhs.uk"
  },
  {
    "nome": "Gaby Poleye",
    "cargo": "Technology",
    "email": "gpoleyez@nba.com"
  },
  {
    "nome": "Marion Southey",
    "cargo": "Consumer Durables",
    "email": "msouthey10@yellowpages.com"
  },
  {
    "nome": "Linoel Kemmet",
    "cargo": "Technology",
    "email": "lkemmet11@dmoz.org"
  },
  {
    "nome": "Gibbie Tomaszynski",
    "cargo": "Consumer Non-Durables",
    "email": "gtomaszynski12@sciencedaily.com"
  },
  {
    "nome": "Hilliard Hansmann",
    "cargo": "Consumer Services",
    "email": "hhansmann13@flickr.com"
  },
  {
    "nome": "Abbey Szymanek",
    "cargo": "Consumer Non-Durables",
    "email": "aszymanek14@about.me"
  },
  {
    "nome": "Serene Morsom",
    "cargo": "Technology",
    "email": "smorsom15@unc.edu"
  },
  {
    "nome": "Malissia Tanswell",
    "cargo": "Finance",
    "email": "mtanswell16@huffingtonpost.com"
  },
  {
    "nome": "Georgeanne Yakhin",
    "cargo": "Finance",
    "email": "gyakhin17@europa.eu"
  },
  {
    "nome": "Clotilda Keenlyside",
    "cargo": "Capital Goods",
    "email": "ckeenlyside18@deviantart.com"
  },
  {
    "nome": "Vivienne Brugh",
    "cargo": "Basic Industries",
    "email": "vbrugh19@tripadvisor.com"
  },
  {
    "nome": "Jenelle McCoish",
    "cargo": "Health Care",
    "email": "jmccoish1a@is.gd"
  },
  {
    "nome": "Darcie Wollacott",
    "cargo": "Consumer Services",
    "email": "dwollacott1b@fastcompany.com"
  }, 
  {
    "nome": "Talbert Hutable",
    "cargo": "Technology",
    "email": "thutable1c@tinypic.com"
  },
  {
    "nome": "Alexandros Skittle",
    "cargo": "Technology",
    "email": "askittle1d@wunderground.com"
  },
  {
    "nome": "Rudd Hamper",
    "cargo": "Consumer Services",
    "email": "rhamper1e@businesswire.com"
  },
  {
    "nome": "Faythe McCumesky",
    "cargo": "Consumer Services",
    "email": "fmccumesky1f@wikimedia.org"
  },
  {
    "nome": "Cindra Tice",
    "cargo": "Health Care",
    "email": "ctice1g@liveinternet.ru"
  },
  {
    "nome": "Vivyan Lathwell",
    "cargo": "Finance",
    "email": "vlathwell1h@photobucket.com"
  },
  {
    "nome": "Angil Downse",
    "cargo": "Energy",
    "email": "adownse1i@ca.gov"
  },
  {
    "nome": "Van Leftridge",
    "cargo": "Health Care",
    "email": "vleftridge1j@unicef.org"
  },
  {
    "nome": "Blinny Kees",
    "cargo": "Energy",
    "email": "bkees1k@ehow.com"
  }
]');

CALL povoar_pedidos('[
{
  "data_pedido": "2024/12/07",
  "status": "ultrices",
  "clientes_idclientes": 94,
  "transportadora_idtransportadora": 3,
  "funcionario_idfuncionario": 35,
  "promocao_idpromocao": 2
}, {
  "data_pedido": "2024/04/20",
  "status": "erat",
  "clientes_idclientes": 86,
  "transportadora_idtransportadora": 7,
  "funcionario_idfuncionario": 8,
  "promocao_idpromocao": 7
}, {
  "data_pedido": "2023/04/01",
  "status": "dapibus",
  "clientes_idclientes": 41,
  "transportadora_idtransportadora": 9,
  "funcionario_idfuncionario": 50,
  "promocao_idpromocao": 16
}, {
  "data_pedido": "2023/11/10",
  "status": "in",
  "clientes_idclientes": 47,
  "transportadora_idtransportadora": 7,
  "funcionario_idfuncionario": 21,
  "promocao_idpromocao": 9
}, {
  "data_pedido": "2024/08/06",
  "status": "sed",
  "clientes_idclientes": 68,
  "transportadora_idtransportadora": 9,
  "funcionario_idfuncionario": 41,
  "promocao_idpromocao": 18
}, {
  "data_pedido": "2023/12/11",
  "status": "nullam",
  "clientes_idclientes": 24,
  "transportadora_idtransportadora": 8,
  "funcionario_idfuncionario": 28,
  "promocao_idpromocao": 21
}, {
  "data_pedido": "2023/04/05",
  "status": "at",
  "clientes_idclientes": 94,
  "transportadora_idtransportadora": 2,
  "funcionario_idfuncionario": 9,
  "promocao_idpromocao": 28
}, {
  "data_pedido": "2024/11/25",
  "status": "vitae",
  "clientes_idclientes": 38,
  "transportadora_idtransportadora": 6,
  "funcionario_idfuncionario": 29,
  "promocao_idpromocao": 24
}, {
  "data_pedido": "2024/08/31",
  "status": "ornare",
  "clientes_idclientes": 65,
  "transportadora_idtransportadora": 4,
  "funcionario_idfuncionario": 39,
  "promocao_idpromocao": 28
}, {
  "data_pedido": "2024/05/09",
  "status": "lorem",
  "clientes_idclientes": 15,
  "transportadora_idtransportadora": 9,
  "funcionario_idfuncionario": 37,
  "promocao_idpromocao": 23
}, {
  "data_pedido": "2023/08/04",
  "status": "lacus",
  "clientes_idclientes": 26,
  "transportadora_idtransportadora": 10,
  "funcionario_idfuncionario": 18,
  "promocao_idpromocao": 6
}, {
  "data_pedido": "2023/05/29",
  "status": "eu",
  "clientes_idclientes": 47,
  "transportadora_idtransportadora": 4,
  "funcionario_idfuncionario": 23,
  "promocao_idpromocao": 6
}, {
  "data_pedido": "2024/07/31",
  "status": "nulla",
  "clientes_idclientes": 35,
  "transportadora_idtransportadora": 9,
  "funcionario_idfuncionario": 19,
  "promocao_idpromocao": 4
}, {
  "data_pedido": "2024/10/01",
  "status": "id",
  "clientes_idclientes": 64,
  "transportadora_idtransportadora": 4,
  "funcionario_idfuncionario": 37,
  "promocao_idpromocao": 9
}, {
  "data_pedido": "2024/03/07",
  "status": "libero",
  "clientes_idclientes": 60,
  "transportadora_idtransportadora": 4,
  "funcionario_idfuncionario": 37,
  "promocao_idpromocao": 21
}, {
  "data_pedido": "2024/02/02",
  "status": "mauris",
  "clientes_idclientes": 9,
  "transportadora_idtransportadora": 8,
  "funcionario_idfuncionario": 40,
  "promocao_idpromocao": 28
}, {
  "data_pedido": "2023/08/17",
  "status": "augue",
  "clientes_idclientes": 46,
  "transportadora_idtransportadora": 1,
  "funcionario_idfuncionario": 22,
  "promocao_idpromocao": 11
}, {
  "data_pedido": "2023/06/08",
  "status": "at",
  "clientes_idclientes": 52,
  "transportadora_idtransportadora": 5,
  "funcionario_idfuncionario": 15,
  "promocao_idpromocao": 23
}, {
  "data_pedido": "2024/01/09",
  "status": "ante",
  "clientes_idclientes": 40,
  "transportadora_idtransportadora": 8,
  "funcionario_idfuncionario": 40,
  "promocao_idpromocao": 26
}, {
  "data_pedido": "2024/03/30",
  "status": "aliquam",
  "clientes_idclientes": 33,
  "transportadora_idtransportadora": 5,
  "funcionario_idfuncionario": 57,
  "promocao_idpromocao": 14
}, {
  "data_pedido": "2024/02/29",
  "status": "felis",
  "clientes_idclientes": 68,
  "transportadora_idtransportadora": 4,
  "funcionario_idfuncionario": 48,
  "promocao_idpromocao": 13
}, {
  "data_pedido": "2024/06/14",
  "status": "felis",
  "clientes_idclientes": 3,
  "transportadora_idtransportadora": 10,
  "funcionario_idfuncionario": 49,
  "promocao_idpromocao": 16
}, {
  "data_pedido": "2023/11/21",
  "status": "et",
  "clientes_idclientes": 90,
  "transportadora_idtransportadora": 1,
  "funcionario_idfuncionario": 25,
  "promocao_idpromocao": 15
}, {
  "data_pedido": "2024/10/18",
  "status": "congue",
  "clientes_idclientes": 79,
  "transportadora_idtransportadora": 10,
  "funcionario_idfuncionario": 54,
  "promocao_idpromocao": 17
}, {
  "data_pedido": "2024/10/18",
  "status": "nulla",
  "clientes_idclientes": 54,
  "transportadora_idtransportadora": 3,
  "funcionario_idfuncionario": 48,
  "promocao_idpromocao": 3
}, {
  "data_pedido": "2023/07/10",
  "status": "consequat",
  "clientes_idclientes": 58,
  "transportadora_idtransportadora": 7,
  "funcionario_idfuncionario": 31,
  "promocao_idpromocao": 23
}, {
  "data_pedido": "2023/06/03",
  "status": "nulla",
  "clientes_idclientes": 31,
  "transportadora_idtransportadora": 10,
  "funcionario_idfuncionario": 56,
  "promocao_idpromocao": 14
}, {
  "data_pedido": "2023/04/06",
  "status": "varius",
  "clientes_idclientes": 8,
  "transportadora_idtransportadora": 5,
  "funcionario_idfuncionario": 22,
  "promocao_idpromocao": 7
}, {
  "data_pedido": "2024/06/28",
  "status": "vitae",
  "clientes_idclientes": 52,
  "transportadora_idtransportadora": 5,
  "funcionario_idfuncionario": 47,
  "promocao_idpromocao": 29
}, {
  "data_pedido": "2023/07/29",
  "status": "id",
  "clientes_idclientes": 91,
  "transportadora_idtransportadora": 10,
  "funcionario_idfuncionario": 57,
  "promocao_idpromocao": 18
}, {
  "data_pedido": "2023/09/25",
  "status": "lorem",
  "clientes_idclientes": 48,
  "transportadora_idtransportadora": 9,
  "funcionario_idfuncionario": 54,
  "promocao_idpromocao": 9
}, {
  "data_pedido": "2023/01/04",
  "status": "suscipit",
  "clientes_idclientes": 39,
  "transportadora_idtransportadora": 10,
  "funcionario_idfuncionario": 16,
  "promocao_idpromocao": 10
}, {
  "data_pedido": "2024/05/03",
  "status": "turpis",
  "clientes_idclientes": 18,
  "transportadora_idtransportadora": 4,
  "funcionario_idfuncionario": 18,
  "promocao_idpromocao": 23
}, {
  "data_pedido": "2023/10/15",
  "status": "mi",
  "clientes_idclientes": 28,
  "transportadora_idtransportadora": 8,
  "funcionario_idfuncionario": 18,
  "promocao_idpromocao": 16
}, {
  "data_pedido": "2024/09/24",
  "status": "dolor",
  "clientes_idclientes": 29,
  "transportadora_idtransportadora": 8,
  "funcionario_idfuncionario": 22,
  "promocao_idpromocao": 3
}, {
  "data_pedido": "2023/10/04",
  "status": "nec",
  "clientes_idclientes": 78,
  "transportadora_idtransportadora": 9,
  "funcionario_idfuncionario": 36,
  "promocao_idpromocao": 30
}, {
  "data_pedido": "2024/07/20",
  "status": "tortor",
  "clientes_idclientes": 45,
  "transportadora_idtransportadora": 7,
  "funcionario_idfuncionario": 34,
  "promocao_idpromocao": 23
}, {
  "data_pedido": "2024/09/04",
  "status": "quam",
  "clientes_idclientes": 12,
  "transportadora_idtransportadora": 8,
  "funcionario_idfuncionario": 35,
  "promocao_idpromocao": 26
}, {
  "data_pedido": "2023/09/25",
  "status": "morbi",
  "clientes_idclientes": 25,
  "transportadora_idtransportadora": 6,
  "funcionario_idfuncionario": 36,
  "promocao_idpromocao": 24
}, {
  "data_pedido": "2023/07/11",
  "status": "sem",
  "clientes_idclientes": 86,
  "transportadora_idtransportadora": 10,
  "funcionario_idfuncionario": 23,
  "promocao_idpromocao": 23
}, {
  "data_pedido": "2024/03/10",
  "status": "id",
  "clientes_idclientes": 79,
  "transportadora_idtransportadora": 1,
  "funcionario_idfuncionario": 17,
  "promocao_idpromocao": 5
}, {
  "data_pedido": "2023/03/10",
  "status": "enim",
  "clientes_idclientes": 94,
  "transportadora_idtransportadora": 10,
  "funcionario_idfuncionario": 55,
  "promocao_idpromocao": 5
}, {
  "data_pedido": "2024/06/16",
  "status": "quam",
  "clientes_idclientes": 39,
  "transportadora_idtransportadora": 4,
  "funcionario_idfuncionario": 7,
  "promocao_idpromocao": 30
}, {
  "data_pedido": "2023/01/06",
  "status": "aliquam",
  "clientes_idclientes": 4,
  "transportadora_idtransportadora": 8,
  "funcionario_idfuncionario": 1,
  "promocao_idpromocao": 30
}, {
  "data_pedido": "2023/08/29",
  "status": "turpis",
  "clientes_idclientes": 78,
  "transportadora_idtransportadora": 10,
  "funcionario_idfuncionario": 33,
  "promocao_idpromocao": 8
}, {
  "data_pedido": "2023/12/15",
  "status": "mi",
  "clientes_idclientes": 86,
  "transportadora_idtransportadora": 1,
  "funcionario_idfuncionario": 21,
  "promocao_idpromocao": 17
}, {
  "data_pedido": "2024/09/10",
  "status": "ultrices",
  "clientes_idclientes": 33,
  "transportadora_idtransportadora": 1,
  "funcionario_idfuncionario": 41,
  "promocao_idpromocao": 3
}, {
  "data_pedido": "2023/01/04",
  "status": "pellentesque",
  "clientes_idclientes": 1,
  "transportadora_idtransportadora": 10,
  "funcionario_idfuncionario": 5,
  "promocao_idpromocao": 27
}, {
  "data_pedido": "2024/08/10",
  "status": "nibh",
  "clientes_idclientes": 100,
  "transportadora_idtransportadora": 7,
  "funcionario_idfuncionario": 47,
  "promocao_idpromocao": 3
}, {
  "data_pedido": "2024/06/23",
  "status": "nullam",
  "clientes_idclientes": 49,
  "transportadora_idtransportadora": 7,
  "funcionario_idfuncionario": 1,
  "promocao_idpromocao": 8
}, {
  "data_pedido": "2024/05/01",
  "status": "interdum",
  "clientes_idclientes": 32,
  "transportadora_idtransportadora": 3,
  "funcionario_idfuncionario": 19,
  "promocao_idpromocao": 10
}, {
  "data_pedido": "2024/08/14",
  "status": "nunc",
  "clientes_idclientes": 70,
  "transportadora_idtransportadora": 8,
  "funcionario_idfuncionario": 53,
  "promocao_idpromocao": 15
}, {
  "data_pedido": "2024/08/31",
  "status": "eget",
  "clientes_idclientes": 70,
  "transportadora_idtransportadora": 8,
  "funcionario_idfuncionario": 47,
  "promocao_idpromocao": 18
}, {
  "data_pedido": "2024/02/05",
  "status": "scelerisque",
  "clientes_idclientes": 98,
  "transportadora_idtransportadora": 3,
  "funcionario_idfuncionario": 35,
  "promocao_idpromocao": 13
}, {
  "data_pedido": "2024/01/14",
  "status": "nam",
  "clientes_idclientes": 91,
  "transportadora_idtransportadora": 7,
  "funcionario_idfuncionario": 35,
  "promocao_idpromocao": 5
}, {
  "data_pedido": "2023/10/18",
  "status": "nulla",
  "clientes_idclientes": 19,
  "transportadora_idtransportadora": 6,
  "funcionario_idfuncionario": 29,
  "promocao_idpromocao": 13
}, {
  "data_pedido": "2023/08/26",
  "status": "purus",
  "clientes_idclientes": 95,
  "transportadora_idtransportadora": 2,
  "funcionario_idfuncionario": 44,
  "promocao_idpromocao": 28
}, {
  "data_pedido": "2023/03/30",
  "status": "in",
  "clientes_idclientes": 36,
  "transportadora_idtransportadora": 2,
  "funcionario_idfuncionario": 21,
  "promocao_idpromocao": 8
}, {
  "data_pedido": "2024/07/09",
  "status": "congue",
  "clientes_idclientes": 89,
  "transportadora_idtransportadora": 5,
  "funcionario_idfuncionario": 22,
  "promocao_idpromocao": 6
}, {
  "data_pedido": "2024/06/04",
  "status": "sed",
  "clientes_idclientes": 69,
  "transportadora_idtransportadora": 5,
  "funcionario_idfuncionario": 9,
  "promocao_idpromocao": 26
}, {
  "data_pedido": "2023/12/27",
  "status": "donec",
  "clientes_idclientes": 96,
  "transportadora_idtransportadora": 8,
  "funcionario_idfuncionario": 53,
  "promocao_idpromocao": 19
}, {
  "data_pedido": "2023/07/31",
  "status": "egestas",
  "clientes_idclientes": 80,
  "transportadora_idtransportadora": 5,
  "funcionario_idfuncionario": 46,
  "promocao_idpromocao": 9
}, {
  "data_pedido": "2023/08/25",
  "status": "quis",
  "clientes_idclientes": 100,
  "transportadora_idtransportadora": 2,
  "funcionario_idfuncionario": 27,
  "promocao_idpromocao": 17
}, {
  "data_pedido": "2023/10/31",
  "status": "mi",
  "clientes_idclientes": 34,
  "transportadora_idtransportadora": 8,
  "funcionario_idfuncionario": 35,
  "promocao_idpromocao": 25
}, {
  "data_pedido": "2024/05/31",
  "status": "elementum",
  "clientes_idclientes": 11,
  "transportadora_idtransportadora": 1,
  "funcionario_idfuncionario": 12,
  "promocao_idpromocao": 16
}, {
  "data_pedido": "2024/05/07",
  "status": "posuere",
  "clientes_idclientes": 26,
  "transportadora_idtransportadora": 3,
  "funcionario_idfuncionario": 45,
  "promocao_idpromocao": 12
}, {
  "data_pedido": "2023/10/03",
  "status": "mollis",
  "clientes_idclientes": 63,
  "transportadora_idtransportadora": 4,
  "funcionario_idfuncionario": 20,
  "promocao_idpromocao": 1
}, {
  "data_pedido": "2024/08/22",
  "status": "adipiscing",
  "clientes_idclientes": 8,
  "transportadora_idtransportadora": 5,
  "funcionario_idfuncionario": 46,
  "promocao_idpromocao": 13
}, {
  "data_pedido": "2023/01/10",
  "status": "eu",
  "clientes_idclientes": 98,
  "transportadora_idtransportadora": 6,
  "funcionario_idfuncionario": 50,
  "promocao_idpromocao": 14
}, {
  "data_pedido": "2023/06/04",
  "status": "suspendisse",
  "clientes_idclientes": 68,
  "transportadora_idtransportadora": 7,
  "funcionario_idfuncionario": 12,
  "promocao_idpromocao": 17
}, {
  "data_pedido": "2023/04/15",
  "status": "pede",
  "clientes_idclientes": 85,
  "transportadora_idtransportadora": 7,
  "funcionario_idfuncionario": 53,
  "promocao_idpromocao": 4
}, {
  "data_pedido": "2023/04/20",
  "status": "ipsum",
  "clientes_idclientes": 4,
  "transportadora_idtransportadora": 3,
  "funcionario_idfuncionario": 15,
  "promocao_idpromocao": 28
}, {
  "data_pedido": "2023/06/15",
  "status": "suscipit",
  "clientes_idclientes": 92,
  "transportadora_idtransportadora": 9,
  "funcionario_idfuncionario": 25,
  "promocao_idpromocao": 19
}, {
  "data_pedido": "2023/01/23",
  "status": "ultrices",
  "clientes_idclientes": 56,
  "transportadora_idtransportadora": 9,
  "funcionario_idfuncionario": 20,
  "promocao_idpromocao": 18
}, {
  "data_pedido": "2023/11/24",
  "status": "sem",
  "clientes_idclientes": 58,
  "transportadora_idtransportadora": 8,
  "funcionario_idfuncionario": 27,
  "promocao_idpromocao": 26
}, {
  "data_pedido": "2023/03/20",
  "status": "libero",
  "clientes_idclientes": 79,
  "transportadora_idtransportadora": 2,
  "funcionario_idfuncionario": 50,
  "promocao_idpromocao": 13
}, {
  "data_pedido": "2023/12/24",
  "status": "sit",
  "clientes_idclientes": 6,
  "transportadora_idtransportadora": 9,
  "funcionario_idfuncionario": 36,
  "promocao_idpromocao": 14
}, {
  "data_pedido": "2023/06/04",
  "status": "at",
  "clientes_idclientes": 94,
  "transportadora_idtransportadora": 6,
  "funcionario_idfuncionario": 45,
  "promocao_idpromocao": 16
}, {
  "data_pedido": "2023/05/15",
  "status": "condimentum",
  "clientes_idclientes": 85,
  "transportadora_idtransportadora": 9,
  "funcionario_idfuncionario": 43,
  "promocao_idpromocao": 3
}, {
  "data_pedido": "2023/04/07",
  "status": "nec",
  "clientes_idclientes": 18,
  "transportadora_idtransportadora": 7,
  "funcionario_idfuncionario": 7,
  "promocao_idpromocao": 19
}, {
  "data_pedido": "2024/12/21",
  "status": "justo",
  "clientes_idclientes": 98,
  "transportadora_idtransportadora": 2,
  "funcionario_idfuncionario": 50,
  "promocao_idpromocao": 3
}, {
  "data_pedido": "2023/10/06",
  "status": "proin",
  "clientes_idclientes": 14,
  "transportadora_idtransportadora": 10,
  "funcionario_idfuncionario": 44,
  "promocao_idpromocao": 16
}, {
  "data_pedido": "2024/01/21",
  "status": "vestibulum",
  "clientes_idclientes": 11,
  "transportadora_idtransportadora": 1,
  "funcionario_idfuncionario": 2,
  "promocao_idpromocao": 4
}, {
  "data_pedido": "2023/09/15",
  "status": "sollicitudin",
  "clientes_idclientes": 37,
  "transportadora_idtransportadora": 2,
  "funcionario_idfuncionario": 2,
  "promocao_idpromocao": 1
}, {
  "data_pedido": "2023/04/23",
  "status": "eros",
  "clientes_idclientes": 90,
  "transportadora_idtransportadora": 5,
  "funcionario_idfuncionario": 12,
  "promocao_idpromocao": 23
}, {
  "data_pedido": "2023/08/29",
  "status": "enim",
  "clientes_idclientes": 36,
  "transportadora_idtransportadora": 8,
  "funcionario_idfuncionario": 5,
  "promocao_idpromocao": 20
}, {
  "data_pedido": "2023/02/12",
  "status": "blandit",
  "clientes_idclientes": 40,
  "transportadora_idtransportadora": 1,
  "funcionario_idfuncionario": 32,
  "promocao_idpromocao": 1
}, {
  "data_pedido": "2024/03/29",
  "status": "lectus",
  "clientes_idclientes": 40,
  "transportadora_idtransportadora": 8,
  "funcionario_idfuncionario": 48,
  "promocao_idpromocao": 16
}, {
  "data_pedido": "2023/03/07",
  "status": "nulla",
  "clientes_idclientes": 27,
  "transportadora_idtransportadora": 3,
  "funcionario_idfuncionario": 46,
  "promocao_idpromocao": 15
}, {
  "data_pedido": "2024/04/25",
  "status": "nunc",
  "clientes_idclientes": 76,
  "transportadora_idtransportadora": 9,
  "funcionario_idfuncionario": 9,
  "promocao_idpromocao": 21
}, {
  "data_pedido": "2023/12/01",
  "status": "augue",
  "clientes_idclientes": 94,
  "transportadora_idtransportadora": 6,
  "funcionario_idfuncionario": 7,
  "promocao_idpromocao": 29
}, {
  "data_pedido": "2024/01/04",
  "status": "adipiscing",
  "clientes_idclientes": 97,
  "transportadora_idtransportadora": 4,
  "funcionario_idfuncionario": 3,
  "promocao_idpromocao": 17
}, {
  "data_pedido": "2023/02/22",
  "status": "lorem",
  "clientes_idclientes": 59,
  "transportadora_idtransportadora": 8,
  "funcionario_idfuncionario": 54,
  "promocao_idpromocao": 14
}, {
  "data_pedido": "2023/05/13",
  "status": "massa",
  "clientes_idclientes": 48,
  "transportadora_idtransportadora": 3,
  "funcionario_idfuncionario": 17,
  "promocao_idpromocao": 23
}, {
  "data_pedido": "2023/12/26",
  "status": "congue",
  "clientes_idclientes": 1,
  "transportadora_idtransportadora": 4,
  "funcionario_idfuncionario": 48,
  "promocao_idpromocao": 2
}, {
  "data_pedido": "2023/01/23",
  "status": "eget",
  "clientes_idclientes": 43,
  "transportadora_idtransportadora": 10,
  "funcionario_idfuncionario": 17,
  "promocao_idpromocao": 19
}, {
  "data_pedido": "2024/08/20",
  "status": "fusce",
  "clientes_idclientes": 88,
  "transportadora_idtransportadora": 4,
  "funcionario_idfuncionario": 11,
  "promocao_idpromocao": 29
}, {
  "data_pedido": "2024/08/16",
  "status": "elit",
  "clientes_idclientes": 92,
  "transportadora_idtransportadora": 4,
  "funcionario_idfuncionario": 48,
  "promocao_idpromocao": 26
}, {
  "data_pedido": "2024/12/15",
  "status": "vel",
  "clientes_idclientes": 1,
  "transportadora_idtransportadora": 1,
  "funcionario_idfuncionario": 3,
  "promocao_idpromocao": 10
}, {
  "data_pedido": "2024/06/24",
  "status": "elementum",
  "clientes_idclientes": 33,
  "transportadora_idtransportadora": 5,
  "funcionario_idfuncionario": 40,
  "promocao_idpromocao": 7
}
]');

CALL povoar_pagamento('[{
  "data_pagamento": "2024/05/03",
  "valor_pago": 7427,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 81,
  "pedidos_clientes_idclientes1": 89,
  "pedidos_transportadora_idtransportadora": 13
}, {
  "data_pagamento": "2024/10/25",
  "valor_pago": 80707,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 49,
  "pedidos_clientes_idclientes1": 100,
  "pedidos_transportadora_idtransportadora": 7
}, {
  "data_pagamento": "2024/02/17",
  "valor_pago": 14892,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 62,
  "pedidos_clientes_idclientes1": 22,
  "pedidos_transportadora_idtransportadora": 2
}, {
  "data_pagamento": "2023/09/07",
  "valor_pago": 64341,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 34,
  "pedidos_clientes_idclientes1": 6,
  "pedidos_transportadora_idtransportadora": 1
}, {
  "data_pagamento": "2024/03/31",
  "valor_pago": 6116,
  "metodo_pagamento": "Boleto bancário",
  "pedidos_idpedidos": 68,
  "pedidos_clientes_idclientes1": 14,
  "pedidos_transportadora_idtransportadora": 10
}, {
  "data_pagamento": "2024/06/09",
  "valor_pago": 63123,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 66,
  "pedidos_clientes_idclientes1": 28,
  "pedidos_transportadora_idtransportadora": 8
}, {
  "data_pagamento": "2023/04/26",
  "valor_pago": 22396,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 44,
  "pedidos_clientes_idclientes1": 73,
  "pedidos_transportadora_idtransportadora": 3
}, {
  "data_pagamento": "2024/03/23",
  "valor_pago": 3386,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 27,
  "pedidos_clientes_idclientes1": 85,
  "pedidos_transportadora_idtransportadora": 8
}, {
  "data_pagamento": "2024/07/28",
  "valor_pago": 65105,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 84,
  "pedidos_clientes_idclientes1": 19,
  "pedidos_transportadora_idtransportadora": 8
}, {
  "data_pagamento": "2024/02/04",
  "valor_pago": 18669,
  "metodo_pagamento": "Boleto bancário",
  "pedidos_idpedidos": 21,
  "pedidos_clientes_idclientes1": 97,
  "pedidos_transportadora_idtransportadora": 2
}, {
  "data_pagamento": "2023/02/05",
  "valor_pago": 37717,
  "metodo_pagamento": "Boleto bancário",
  "pedidos_idpedidos": 90,
  "pedidos_clientes_idclientes1": 51,
  "pedidos_transportadora_idtransportadora": 9
}, {
  "data_pagamento": "2023/03/27",
  "valor_pago": 18343,
  "metodo_pagamento": "Crédito",
  "pedidos_idpedidos": 7,
  "pedidos_clientes_idclientes1": 55,
  "pedidos_transportadora_idtransportadora": 5
}, {
  "data_pagamento": "2024/03/24",
  "valor_pago": 85404,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 21,
  "pedidos_clientes_idclientes1": 35,
  "pedidos_transportadora_idtransportadora": 2
}, {
  "data_pagamento": "2023/10/04",
  "valor_pago": 27437,
  "metodo_pagamento": "Crédito",
  "pedidos_idpedidos": 35,
  "pedidos_clientes_idclientes1": 47,
  "pedidos_transportadora_idtransportadora": 14
}, {
  "data_pagamento": "2024/01/18",
  "valor_pago": 60943,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 34,
  "pedidos_clientes_idclientes1": 10,
  "pedidos_transportadora_idtransportadora": 11
}, {
  "data_pagamento": "2024/04/03",
  "valor_pago": 44113,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 74,
  "pedidos_clientes_idclientes1": 63,
  "pedidos_transportadora_idtransportadora": 9
}, {
  "data_pagamento": "2023/04/07",
  "valor_pago": 95189,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 69,
  "pedidos_clientes_idclientes1": 98,
  "pedidos_transportadora_idtransportadora": 11
}, {
  "data_pagamento": "2023/03/18",
  "valor_pago": 23889,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 70,
  "pedidos_clientes_idclientes1": 64,
  "pedidos_transportadora_idtransportadora": 12
}, {
  "data_pagamento": "2024/06/28",
  "valor_pago": 96112,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 38,
  "pedidos_clientes_idclientes1": 70,
  "pedidos_transportadora_idtransportadora": 13
}, {
  "data_pagamento": "2024/07/25",
  "valor_pago": 20019,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 82,
  "pedidos_clientes_idclientes1": 42,
  "pedidos_transportadora_idtransportadora": 8
}, {
  "data_pagamento": "2023/02/09",
  "valor_pago": 44484,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 53,
  "pedidos_clientes_idclientes1": 100,
  "pedidos_transportadora_idtransportadora": 3
}, {
  "data_pagamento": "2024/10/24",
  "valor_pago": 49120,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 29,
  "pedidos_clientes_idclientes1": 61,
  "pedidos_transportadora_idtransportadora": 10
}, {
  "data_pagamento": "2024/05/12",
  "valor_pago": 73480,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 87,
  "pedidos_clientes_idclientes1": 30,
  "pedidos_transportadora_idtransportadora": 3
}, {
  "data_pagamento": "2024/05/31",
  "valor_pago": 47909,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 4,
  "pedidos_clientes_idclientes1": 92,
  "pedidos_transportadora_idtransportadora": 10
}, {
  "data_pagamento": "2024/09/05",
  "valor_pago": 22421,
  "metodo_pagamento": "Boleto bancário",
  "pedidos_idpedidos": 7,
  "pedidos_clientes_idclientes1": 44,
  "pedidos_transportadora_idtransportadora": 10
}, {
  "data_pagamento": "2023/03/20",
  "valor_pago": 34978,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 90,
  "pedidos_clientes_idclientes1": 13,
  "pedidos_transportadora_idtransportadora": 3
}, {
  "data_pagamento": "2024/05/10",
  "valor_pago": 62034,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 21,
  "pedidos_clientes_idclientes1": 58,
  "pedidos_transportadora_idtransportadora": 6
}, {
  "data_pagamento": "2024/07/31",
  "valor_pago": 84611,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 7,
  "pedidos_clientes_idclientes1": 77,
  "pedidos_transportadora_idtransportadora": 7
}, {
  "data_pagamento": "2024/01/05",
  "valor_pago": 62094,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 96,
  "pedidos_clientes_idclientes1": 8,
  "pedidos_transportadora_idtransportadora": 8
}, {
  "data_pagamento": "2024/01/07",
  "valor_pago": 38368,
  "metodo_pagamento": "Crédito",
  "pedidos_idpedidos": 93,
  "pedidos_clientes_idclientes1": 100,
  "pedidos_transportadora_idtransportadora": 12
}, {
  "data_pagamento": "2023/08/06",
  "valor_pago": 32139,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 79,
  "pedidos_clientes_idclientes1": 58,
  "pedidos_transportadora_idtransportadora": 1
}, {
  "data_pagamento": "2023/01/01",
  "valor_pago": 98527,
  "metodo_pagamento": "Crédito",
  "pedidos_idpedidos": 96,
  "pedidos_clientes_idclientes1": 14,
  "pedidos_transportadora_idtransportadora": 10
}, {
  "data_pagamento": "2023/10/14",
  "valor_pago": 65090,
  "metodo_pagamento": "Transferência bancária",
  "pedidos_idpedidos": 16,
  "pedidos_clientes_idclientes1": 53,
  "pedidos_transportadora_idtransportadora": 7
}, {
  "data_pagamento": "2023/11/28",
  "valor_pago": 58386,
  "metodo_pagamento": "Boleto bancário",
  "pedidos_idpedidos": 27,
  "pedidos_clientes_idclientes1": 84,
  "pedidos_transportadora_idtransportadora": 2
}, {
  "data_pagamento": "2023/10/09",
  "valor_pago": 59243,
  "metodo_pagamento": "Transferência bancária",
  "pedidos_idpedidos": 19,
  "pedidos_clientes_idclientes1": 18,
  "pedidos_transportadora_idtransportadora": 7
}, {
  "data_pagamento": "2024/07/19",
  "valor_pago": 19557,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 97,
  "pedidos_clientes_idclientes1": 94,
  "pedidos_transportadora_idtransportadora": 1
}, {
  "data_pagamento": "2024/05/01",
  "valor_pago": 62196,
  "metodo_pagamento": "Transferência bancária",
  "pedidos_idpedidos": 47,
  "pedidos_clientes_idclientes1": 54,
  "pedidos_transportadora_idtransportadora": 8
}, {
  "data_pagamento": "2023/07/15",
  "valor_pago": 96375,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 65,
  "pedidos_clientes_idclientes1": 76,
  "pedidos_transportadora_idtransportadora": 2
}, {
  "data_pagamento": "2024/03/09",
  "valor_pago": 3032,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 16,
  "pedidos_clientes_idclientes1": 78,
  "pedidos_transportadora_idtransportadora": 11
}, {
  "data_pagamento": "2024/06/18",
  "valor_pago": 18934,
  "metodo_pagamento": "Boleto bancário",
  "pedidos_idpedidos": 96,
  "pedidos_clientes_idclientes1": 50,
  "pedidos_transportadora_idtransportadora": 9
}, {
  "data_pagamento": "2024/12/03",
  "valor_pago": 69342,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 89,
  "pedidos_clientes_idclientes1": 12,
  "pedidos_transportadora_idtransportadora": 10
}, {
  "data_pagamento": "2024/03/04",
  "valor_pago": 62562,
  "metodo_pagamento": "Boleto bancário",
  "pedidos_idpedidos": 75,
  "pedidos_clientes_idclientes1": 19,
  "pedidos_transportadora_idtransportadora": 5
}, {
  "data_pagamento": "2023/10/31",
  "valor_pago": 47036,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 45,
  "pedidos_clientes_idclientes1": 77,
  "pedidos_transportadora_idtransportadora": 3
}, {
  "data_pagamento": "2024/12/30",
  "valor_pago": 85285,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 56,
  "pedidos_clientes_idclientes1": 26,
  "pedidos_transportadora_idtransportadora": 3
}, {
  "data_pagamento": "2024/10/12",
  "valor_pago": 81113,
  "metodo_pagamento": "Boleto bancário",
  "pedidos_idpedidos": 92,
  "pedidos_clientes_idclientes1": 69,
  "pedidos_transportadora_idtransportadora": 6
}, {
  "data_pagamento": "2024/11/13",
  "valor_pago": 99825,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 47,
  "pedidos_clientes_idclientes1": 8,
  "pedidos_transportadora_idtransportadora": 14
}, {
  "data_pagamento": "2023/06/17",
  "valor_pago": 64299,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 96,
  "pedidos_clientes_idclientes1": 8,
  "pedidos_transportadora_idtransportadora": 5
}, {
  "data_pagamento": "2023/08/21",
  "valor_pago": 73279,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 40,
  "pedidos_clientes_idclientes1": 39,
  "pedidos_transportadora_idtransportadora": 3
}, {
  "data_pagamento": "2023/03/07",
  "valor_pago": 54626,
  "metodo_pagamento": "Boleto bancário",
  "pedidos_idpedidos": 85,
  "pedidos_clientes_idclientes1": 18,
  "pedidos_transportadora_idtransportadora": 13
}, {
  "data_pagamento": "2023/06/26",
  "valor_pago": 82791,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 41,
  "pedidos_clientes_idclientes1": 66,
  "pedidos_transportadora_idtransportadora": 1
}, {
  "data_pagamento": "2024/07/30",
  "valor_pago": 91722,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 54,
  "pedidos_clientes_idclientes1": 83,
  "pedidos_transportadora_idtransportadora": 7
}, {
  "data_pagamento": "2024/08/05",
  "valor_pago": 38014,
  "metodo_pagamento": "Transferência bancária",
  "pedidos_idpedidos": 22,
  "pedidos_clientes_idclientes1": 35,
  "pedidos_transportadora_idtransportadora": 8
}, {
  "data_pagamento": "2024/07/03",
  "valor_pago": 12995,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 90,
  "pedidos_clientes_idclientes1": 68,
  "pedidos_transportadora_idtransportadora": 10
}, {
  "data_pagamento": "2024/10/15",
  "valor_pago": 43928,
  "metodo_pagamento": "Crédito",
  "pedidos_idpedidos": 58,
  "pedidos_clientes_idclientes1": 94,
  "pedidos_transportadora_idtransportadora": 1
}, {
  "data_pagamento": "2024/10/14",
  "valor_pago": 40764,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 12,
  "pedidos_clientes_idclientes1": 64,
  "pedidos_transportadora_idtransportadora": 3
}, {
  "data_pagamento": "2024/12/01",
  "valor_pago": 55262,
  "metodo_pagamento": "Transferência bancária",
  "pedidos_idpedidos": 91,
  "pedidos_clientes_idclientes1": 48,
  "pedidos_transportadora_idtransportadora": 6
}, {
  "data_pagamento": "2023/10/29",
  "valor_pago": 80074,
  "metodo_pagamento": "Transferência bancária",
  "pedidos_idpedidos": 44,
  "pedidos_clientes_idclientes1": 2,
  "pedidos_transportadora_idtransportadora": 9
}, {
  "data_pagamento": "2024/08/28",
  "valor_pago": 37369,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 44,
  "pedidos_clientes_idclientes1": 14,
  "pedidos_transportadora_idtransportadora": 14
}, {
  "data_pagamento": "2023/05/25",
  "valor_pago": 66911,
  "metodo_pagamento": "Crédito",
  "pedidos_idpedidos": 28,
  "pedidos_clientes_idclientes1": 80,
  "pedidos_transportadora_idtransportadora": 9
}, {
  "data_pagamento": "2023/09/28",
  "valor_pago": 62994,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 11,
  "pedidos_clientes_idclientes1": 35,
  "pedidos_transportadora_idtransportadora": 12
}, {
  "data_pagamento": "2024/07/20",
  "valor_pago": 10496,
  "metodo_pagamento": "Boleto bancário",
  "pedidos_idpedidos": 100,
  "pedidos_clientes_idclientes1": 40,
  "pedidos_transportadora_idtransportadora": 1
}, {
  "data_pagamento": "2024/03/02",
  "valor_pago": 50068,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 73,
  "pedidos_clientes_idclientes1": 17,
  "pedidos_transportadora_idtransportadora": 11
}, {
  "data_pagamento": "2024/05/12",
  "valor_pago": 99357,
  "metodo_pagamento": "Crédito",
  "pedidos_idpedidos": 87,
  "pedidos_clientes_idclientes1": 79,
  "pedidos_transportadora_idtransportadora": 1
}, {
  "data_pagamento": "2024/10/14",
  "valor_pago": 62958,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 47,
  "pedidos_clientes_idclientes1": 78,
  "pedidos_transportadora_idtransportadora": 6
}, {
  "data_pagamento": "2023/04/06",
  "valor_pago": 85880,
  "metodo_pagamento": "Crédito",
  "pedidos_idpedidos": 52,
  "pedidos_clientes_idclientes1": 69,
  "pedidos_transportadora_idtransportadora": 14
}, {
  "data_pagamento": "2023/09/30",
  "valor_pago": 95111,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 86,
  "pedidos_clientes_idclientes1": 3,
  "pedidos_transportadora_idtransportadora": 5
}, {
  "data_pagamento": "2024/05/06",
  "valor_pago": 65879,
  "metodo_pagamento": "Transferência bancária",
  "pedidos_idpedidos": 64,
  "pedidos_clientes_idclientes1": 56,
  "pedidos_transportadora_idtransportadora": 13
}, {
  "data_pagamento": "2024/10/13",
  "valor_pago": 6249,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 16,
  "pedidos_clientes_idclientes1": 50,
  "pedidos_transportadora_idtransportadora": 3
}, {
  "data_pagamento": "2024/11/20",
  "valor_pago": 85712,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 61,
  "pedidos_clientes_idclientes1": 94,
  "pedidos_transportadora_idtransportadora": 13
}, {
  "data_pagamento": "2024/04/29",
  "valor_pago": 92339,
  "metodo_pagamento": "Transferência bancária",
  "pedidos_idpedidos": 87,
  "pedidos_clientes_idclientes1": 11,
  "pedidos_transportadora_idtransportadora": 6
}, {
  "data_pagamento": "2023/03/20",
  "valor_pago": 27976,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 79,
  "pedidos_clientes_idclientes1": 43,
  "pedidos_transportadora_idtransportadora": 2
}, {
  "data_pagamento": "2024/12/10",
  "valor_pago": 53575,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 63,
  "pedidos_clientes_idclientes1": 9,
  "pedidos_transportadora_idtransportadora": 7
}, {
  "data_pagamento": "2024/03/12",
  "valor_pago": 10269,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 29,
  "pedidos_clientes_idclientes1": 98,
  "pedidos_transportadora_idtransportadora": 12
}, {
  "data_pagamento": "2023/05/06",
  "valor_pago": 96516,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 22,
  "pedidos_clientes_idclientes1": 2,
  "pedidos_transportadora_idtransportadora": 14
}, {
  "data_pagamento": "2024/05/08",
  "valor_pago": 86227,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 6,
  "pedidos_clientes_idclientes1": 51,
  "pedidos_transportadora_idtransportadora": 1
}, {
  "data_pagamento": "2024/11/28",
  "valor_pago": 20203,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 32,
  "pedidos_clientes_idclientes1": 35,
  "pedidos_transportadora_idtransportadora": 10
}, {
  "data_pagamento": "2023/08/15",
  "valor_pago": 26235,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 44,
  "pedidos_clientes_idclientes1": 21,
  "pedidos_transportadora_idtransportadora": 10
}, {
  "data_pagamento": "2024/04/04",
  "valor_pago": 94676,
  "metodo_pagamento": "Boleto bancário",
  "pedidos_idpedidos": 82,
  "pedidos_clientes_idclientes1": 30,
  "pedidos_transportadora_idtransportadora": 9
}, {
  "data_pagamento": "2023/07/09",
  "valor_pago": 8535,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 51,
  "pedidos_clientes_idclientes1": 55,
  "pedidos_transportadora_idtransportadora": 6
}, {
  "data_pagamento": "2024/12/27",
  "valor_pago": 24757,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 65,
  "pedidos_clientes_idclientes1": 82,
  "pedidos_transportadora_idtransportadora": 5
}, {
  "data_pagamento": "2023/04/16",
  "valor_pago": 91657,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 8,
  "pedidos_clientes_idclientes1": 76,
  "pedidos_transportadora_idtransportadora": 1
}, {
  "data_pagamento": "2024/09/07",
  "valor_pago": 97588,
  "metodo_pagamento": "Boleto bancário",
  "pedidos_idpedidos": 38,
  "pedidos_clientes_idclientes1": 88,
  "pedidos_transportadora_idtransportadora": 1
}, {
  "data_pagamento": "2023/02/13",
  "valor_pago": 67580,
  "metodo_pagamento": "Boleto bancário",
  "pedidos_idpedidos": 58,
  "pedidos_clientes_idclientes1": 30,
  "pedidos_transportadora_idtransportadora": 1
}, {
  "data_pagamento": "2023/08/24",
  "valor_pago": 95636,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 77,
  "pedidos_clientes_idclientes1": 41,
  "pedidos_transportadora_idtransportadora": 8
}, {
  "data_pagamento": "2024/07/07",
  "valor_pago": 65244,
  "metodo_pagamento": "Transferência bancária",
  "pedidos_idpedidos": 58,
  "pedidos_clientes_idclientes1": 71,
  "pedidos_transportadora_idtransportadora": 12
}, {
  "data_pagamento": "2023/09/21",
  "valor_pago": 12899,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 90,
  "pedidos_clientes_idclientes1": 62,
  "pedidos_transportadora_idtransportadora": 2
}, {
  "data_pagamento": "2024/11/21",
  "valor_pago": 59977,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 92,
  "pedidos_clientes_idclientes1": 2,
  "pedidos_transportadora_idtransportadora": 10
}, {
  "data_pagamento": "2024/11/06",
  "valor_pago": 75151,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 68,
  "pedidos_clientes_idclientes1": 82,
  "pedidos_transportadora_idtransportadora": 8
}, {
  "data_pagamento": "2024/07/21",
  "valor_pago": 91164,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 22,
  "pedidos_clientes_idclientes1": 61,
  "pedidos_transportadora_idtransportadora": 6
}, {
  "data_pagamento": "2023/08/02",
  "valor_pago": 41896,
  "metodo_pagamento": "Transferência bancária",
  "pedidos_idpedidos": 11,
  "pedidos_clientes_idclientes1": 85,
  "pedidos_transportadora_idtransportadora": 3
}, {
  "data_pagamento": "2024/05/26",
  "valor_pago": 66725,
  "metodo_pagamento": "Boleto bancário",
  "pedidos_idpedidos": 37,
  "pedidos_clientes_idclientes1": 100,
  "pedidos_transportadora_idtransportadora": 1
}, {
  "data_pagamento": "2023/12/31",
  "valor_pago": 35938,
  "metodo_pagamento": "PIX",
  "pedidos_idpedidos": 46,
  "pedidos_clientes_idclientes1": 88,
  "pedidos_transportadora_idtransportadora": 2
}, {
  "data_pagamento": "2023/02/15",
  "valor_pago": 81602,
  "metodo_pagamento": "Débito",
  "pedidos_idpedidos": 29,
  "pedidos_clientes_idclientes1": 22,
  "pedidos_transportadora_idtransportadora": 7
}, {
  "data_pagamento": "2023/10/31",
  "valor_pago": 52851,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 62,
  "pedidos_clientes_idclientes1": 38,
  "pedidos_transportadora_idtransportadora": 4
}, {
  "data_pagamento": "2023/08/09",
  "valor_pago": 95957,
  "metodo_pagamento": "Transferência bancária",
  "pedidos_idpedidos": 24,
  "pedidos_clientes_idclientes1": 98,
  "pedidos_transportadora_idtransportadora": 1
}, {
  "data_pagamento": "2023/05/07",
  "valor_pago": 1586,
  "metodo_pagamento": "Crédito",
  "pedidos_idpedidos": 31,
  "pedidos_clientes_idclientes1": 25,
  "pedidos_transportadora_idtransportadora": 12
}, {
  "data_pagamento": "2024/07/24",
  "valor_pago": 43888,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 9,
  "pedidos_clientes_idclientes1": 68,
  "pedidos_transportadora_idtransportadora": 7
}, {
  "data_pagamento": "2024/06/07",
  "valor_pago": 99528,
  "metodo_pagamento": "Transferência bancária",
  "pedidos_idpedidos": 60,
  "pedidos_clientes_idclientes1": 85,
  "pedidos_transportadora_idtransportadora": 1
}, {
  "data_pagamento": "2024/08/27",
  "valor_pago": 18593,
  "metodo_pagamento": "Á Vista",
  "pedidos_idpedidos": 55,
  "pedidos_clientes_idclientes1": 88,
  "pedidos_transportadora_idtransportadora": 8
}, {
  "data_pagamento": "2023/05/22",
  "valor_pago": 45886,
  "metodo_pagamento": "Crédito",
  "pedidos_idpedidos": 75,
  "pedidos_clientes_idclientes1": 52,
  "pedidos_transportadora_idtransportadora": 7
}]');

CALL povoar_fornecedor('[
{
  "nome": "Daniel-Kerluke",
  "telefone": "+86 (787) 934-6600",
  "email": "sneil0@virginia.edu",
  "endereco": "scasero0@berkeley.edu"
}, {
  "nome": "Ortiz-Jacobs",
  "telefone": "+86 (451) 284-4401",
  "email": "sprophet1@statcounter.com",
  "endereco": "efynan1@e-recht24.de"
}, {
  "nome": "Wisoky and Sons",
  "telefone": "+51 (219) 593-5450",
  "email": "chark2@rediff.com",
  "endereco": "lseymer2@mit.edu"
}, {
  "nome": "Auer Group",
  "telefone": "+86 (600) 796-6744",
  "email": "agaffey3@arstechnica.com",
  "endereco": "orough3@google.cn"
}, {
  "nome": "Lesch, Little and Stanton",
  "telefone": "+355 (744) 769-7423",
  "email": "itailour4@myspace.com",
  "endereco": "smonier4@paypal.com"
}, {
  "nome": "Walker LLC",
  "telefone": "+353 (497) 660-2341",
  "email": "iwaterland5@bbc.co.uk",
  "endereco": "rnovakovic5@alibaba.com"
}, {
  "nome": "Koepp-Erdman",
  "telefone": "+30 (154) 788-6550",
  "email": "cgerhold6@artisteer.com",
  "endereco": "jmanktelow6@nasa.gov"
}, {
  "nome": "Metz and Sons",
  "telefone": "+63 (433) 237-2162",
  "email": "chugnin7@wsj.com",
  "endereco": "tcolam7@cnbc.com"
}, {
  "nome": "Mertz Inc",
  "telefone": "+1 (332) 679-4884",
  "email": "ecantopher8@census.gov",
  "endereco": "pashbee8@indiatimes.com"
}, {
  "nome": "Macejkovic Inc",
  "telefone": "+46 (339) 392-5033",
  "email": "rserfati9@parallels.com",
  "endereco": "lmclemon9@gnu.org"
}
]')

CALL povoar_produtos('[
{
  "nome": "Coconut - Shredded, Sweet",
  "descricao": "neque aenean",
  "preco": 589,
  "quantidade_estoque": 1461,
  "fornecedor_idfornecedor1": 4
}, {
  "nome": "Olives - Morracan Dired",
  "descricao": "suscipit",
  "preco": 1302,
  "quantidade_estoque": 1703,
  "fornecedor_idfornecedor1": 4
}, {
  "nome": "Juice - V8, Tomato",
  "descricao": "diam",
  "preco": 1351,
  "quantidade_estoque": 1224,
  "fornecedor_idfornecedor1": 2
}, {
  "nome": "Sobe - Cranberry Grapefruit",
  "descricao": "luctus",
  "preco": 1483,
  "quantidade_estoque": 259,
  "fornecedor_idfornecedor1": 9
}, {
  "nome": "Sour Cream",
  "descricao": "eget",
  "preco": 1367,
  "quantidade_estoque": 760,
  "fornecedor_idfornecedor1": 5
}, {
  "nome": "Momiji Oroshi Chili Sauce",
  "descricao": "justo",
  "preco": 182,
  "quantidade_estoque": 800,
  "fornecedor_idfornecedor1": 3
}, {
  "nome": "Containter - 3oz Microwave Rect.",
  "descricao": "cubilia",
  "preco": 650,
  "quantidade_estoque": 1570,
  "fornecedor_idfornecedor1": 1
}, {
  "nome": "Blueberries",
  "descricao": "ultricies eu",
  "preco": 1996,
  "quantidade_estoque": 794,
  "fornecedor_idfornecedor1": 6
}, {
  "nome": "Bread - Corn Muffaletta",
  "descricao": "purus",
  "preco": 197,
  "quantidade_estoque": 963,
  "fornecedor_idfornecedor1": 5
}, {
  "nome": "Doilies - 5, Paper",
  "descricao": "ac leo",
  "preco": 837,
  "quantidade_estoque": 1374,
  "fornecedor_idfornecedor1": 5
}, {
  "nome": "Pie Pecan",
  "descricao": "eget tempus",
  "preco": 855,
  "quantidade_estoque": 1681,
  "fornecedor_idfornecedor1": 1
}, {
  "nome": "Pork - Tenderloin, Fresh",
  "descricao": "id",
  "preco": 565,
  "quantidade_estoque": 148,
  "fornecedor_idfornecedor1": 2
}, {
  "nome": "Uniform Linen Charge",
  "descricao": "metus vitae",
  "preco": 863,
  "quantidade_estoque": 1274,
  "fornecedor_idfornecedor1": 4
}, {
  "nome": "Lamb - Whole, Fresh",
  "descricao": "sem sed",
  "preco": 242,
  "quantidade_estoque": 1079,
  "fornecedor_idfornecedor1": 5
}, {
  "nome": "Icecream - Dstk Cml And Fdg",
  "descricao": "sed accumsan",
  "preco": 1743,
  "quantidade_estoque": 420,
  "fornecedor_idfornecedor1": 6
}, {
  "nome": "Arctic Char - Fresh, Whole",
  "descricao": "platea",
  "preco": 1275,
  "quantidade_estoque": 591,
  "fornecedor_idfornecedor1": 6
}, {
  "nome": "Sambuca - Opal Nera",
  "descricao": "tristique est",
  "preco": 288,
  "quantidade_estoque": 557,
  "fornecedor_idfornecedor1": 10
}, {
  "nome": "Kiwano",
  "descricao": "dapibus",
  "preco": 1974,
  "quantidade_estoque": 1747,
  "fornecedor_idfornecedor1": 5
}, {
  "nome": "Mix - Cocktail Ice Cream",
  "descricao": "interdum",
  "preco": 623,
  "quantidade_estoque": 1967,
  "fornecedor_idfornecedor1": 2
}, {
  "nome": "Wine - Piper Heidsieck Brut",
  "descricao": "dictumst",
  "preco": 1856,
  "quantidade_estoque": 890,
  "fornecedor_idfornecedor1": 2
}, {
  "nome": "Melon - Watermelon, Seedless",
  "descricao": "massa donec",
  "preco": 371,
  "quantidade_estoque": 608,
  "fornecedor_idfornecedor1": 4
}, {
  "nome": "Apples - Spartan",
  "descricao": "vestibulum",
  "preco": 1350,
  "quantidade_estoque": 1987,
  "fornecedor_idfornecedor1": 7
}, {
  "nome": "Bread - Bagels, Mini",
  "descricao": "viverra dapibus",
  "preco": 800,
  "quantidade_estoque": 645,
  "fornecedor_idfornecedor1": 5
}, {
  "nome": "Coffee Cup 16oz Foam",
  "descricao": "morbi",
  "preco": 1207,
  "quantidade_estoque": 1394,
  "fornecedor_idfornecedor1": 10
}, {
  "nome": "Chervil - Fresh",
  "descricao": "curabitur",
  "preco": 1088,
  "quantidade_estoque": 961,
  "fornecedor_idfornecedor1": 4
}, {
  "nome": "Guava",
  "descricao": "integer",
  "preco": 1189,
  "quantidade_estoque": 201,
  "fornecedor_idfornecedor1": 5
}, {
  "nome": "Rum - Dark, Bacardi, Black",
  "descricao": "est",
  "preco": 1016,
  "quantidade_estoque": 1683,
  "fornecedor_idfornecedor1": 8
}, {
  "nome": "Wine - Beringer Founders Estate",
  "descricao": "lacinia",
  "preco": 471,
  "quantidade_estoque": 1339,
  "fornecedor_idfornecedor1": 2
}, {
  "nome": "Sea Urchin",
  "descricao": "interdum in",
  "preco": 1439,
  "quantidade_estoque": 315,
  "fornecedor_idfornecedor1": 5
}, {
  "nome": "Coffee Cup 16oz Foam",
  "descricao": "ridiculus mus",
  "preco": 662,
  "quantidade_estoque": 567,
  "fornecedor_idfornecedor1": 5
}, {
  "nome": "Soup - Knorr, Chicken Gumbo",
  "descricao": "congue etiam",
  "preco": 837,
  "quantidade_estoque": 1960,
  "fornecedor_idfornecedor1": 1
}, {
  "nome": "Bread Sour Rolls",
  "descricao": "rhoncus",
  "preco": 1963,
  "quantidade_estoque": 1817,
  "fornecedor_idfornecedor1": 8
}, {
  "nome": "Butter - Salted, Micro",
  "descricao": "tristique est",
  "preco": 1056,
  "quantidade_estoque": 943,
  "fornecedor_idfornecedor1": 10
}, {
  "nome": "Pasta - Gnocchi, Potato",
  "descricao": "et ultrices",
  "preco": 226,
  "quantidade_estoque": 413,
  "fornecedor_idfornecedor1": 8
}, {
  "nome": "Pineapple - Golden",
  "descricao": "mauris",
  "preco": 1012,
  "quantidade_estoque": 124,
  "fornecedor_idfornecedor1": 2
}, {
  "nome": "Beef - Top Sirloin",
  "descricao": "interdum",
  "preco": 1426,
  "quantidade_estoque": 791,
  "fornecedor_idfornecedor1": 8
}, {
  "nome": "Clams - Littleneck, Whole",
  "descricao": "cras non",
  "preco": 648,
  "quantidade_estoque": 330,
  "fornecedor_idfornecedor1": 4
}, {
  "nome": "Juice - Pineapple, 341 Ml",
  "descricao": "dapibus nulla",
  "preco": 1595,
  "quantidade_estoque": 1684,
  "fornecedor_idfornecedor1": 5
}, {
  "nome": "Cocoa Butter",
  "descricao": "felis ut",
  "preco": 506,
  "quantidade_estoque": 482,
  "fornecedor_idfornecedor1": 3
}, {
  "nome": "Bag Clear 10 Lb",
  "descricao": "potenti nullam",
  "preco": 1427,
  "quantidade_estoque": 654,
  "fornecedor_idfornecedor1": 9
}, {
  "nome": "Squid - U - 10 Thailand",
  "descricao": "a",
  "preco": 1774,
  "quantidade_estoque": 1927,
  "fornecedor_idfornecedor1": 4
}, {
  "nome": "Compound - Raspberry",
  "descricao": "arcu",
  "preco": 1379,
  "quantidade_estoque": 1832,
  "fornecedor_idfornecedor1": 3
}, {
  "nome": "Soup - Campbells - Chicken Noodle",
  "descricao": "integer",
  "preco": 1197,
  "quantidade_estoque": 637,
  "fornecedor_idfornecedor1": 1
}, {
  "nome": "Broom - Push",
  "descricao": "in",
  "preco": 965,
  "quantidade_estoque": 360,
  "fornecedor_idfornecedor1": 3
}, {
  "nome": "Pineapple - Golden",
  "descricao": "velit nec",
  "preco": 1610,
  "quantidade_estoque": 298,
  "fornecedor_idfornecedor1": 6
}, {
  "nome": "Meldea Green Tea Liquor",
  "descricao": "sed lacus",
  "preco": 773,
  "quantidade_estoque": 549,
  "fornecedor_idfornecedor1": 1
}, {
  "nome": "Crawfish",
  "descricao": "nonummy",
  "preco": 734,
  "quantidade_estoque": 245,
  "fornecedor_idfornecedor1": 1
}, {
  "nome": "Wine - Pinot Noir Mondavi Coastal",
  "descricao": "consequat",
  "preco": 801,
  "quantidade_estoque": 1616,
  "fornecedor_idfornecedor1": 5
}, {
  "nome": "Apple - Northern Spy",
  "descricao": "eu tincidunt",
  "preco": 606,
  "quantidade_estoque": 189,
  "fornecedor_idfornecedor1": 5
}, {
  "nome": "Beans - Fava, Canned",
  "descricao": "nibh",
  "preco": 1235,
  "quantidade_estoque": 588,
  "fornecedor_idfornecedor1": 2
}
]');

CALL povoar_itens_pedido('[{
  "quantidade": 6,
  "produtos_idprodutos": 27,
  "pedidos_idpedidos": 27
}, {
  "quantidade": 11,
  "produtos_idprodutos": 38,
  "pedidos_idpedidos": 2
}, {
  "quantidade": 10,
  "produtos_idprodutos": 61,
  "pedidos_idpedidos": 29
}, {
  "quantidade": 11,
  "produtos_idprodutos": 64,
  "pedidos_idpedidos": 48
}, {
  "quantidade": 7,
  "produtos_idprodutos": 17,
  "pedidos_idpedidos": 10
}, {
  "quantidade": 3,
  "produtos_idprodutos": 84,
  "pedidos_idpedidos": 46
}, {
  "quantidade": 13,
  "produtos_idprodutos": 81,
  "pedidos_idpedidos": 39
}, {
  "quantidade": 10,
  "produtos_idprodutos": 86,
  "pedidos_idpedidos": 2
}, {
  "quantidade": 6,
  "produtos_idprodutos": 3,
  "pedidos_idpedidos": 23
}, {
  "quantidade": 10,
  "produtos_idprodutos": 96,
  "pedidos_idpedidos": 2
}, {
  "quantidade": 3,
  "produtos_idprodutos": 64,
  "pedidos_idpedidos": 18
}, {
  "quantidade": 10,
  "produtos_idprodutos": 46,
  "pedidos_idpedidos": 29
}, {
  "quantidade": 1,
  "produtos_idprodutos": 25,
  "pedidos_idpedidos": 23
}, {
  "quantidade": 11,
  "produtos_idprodutos": 98,
  "pedidos_idpedidos": 26
}, {
  "quantidade": 13,
  "produtos_idprodutos": 41,
  "pedidos_idpedidos": 6
}, {
  "quantidade": 4,
  "produtos_idprodutos": 39,
  "pedidos_idpedidos": 38
}, {
  "quantidade": 5,
  "produtos_idprodutos": 43,
  "pedidos_idpedidos": 13
}, {
  "quantidade": 9,
  "produtos_idprodutos": 12,
  "pedidos_idpedidos": 6
}, {
  "quantidade": 6,
  "produtos_idprodutos": 58,
  "pedidos_idpedidos": 48
}, {
  "quantidade": 5,
  "produtos_idprodutos": 94,
  "pedidos_idpedidos": 5
}, {
  "quantidade": 8,
  "produtos_idprodutos": 88,
  "pedidos_idpedidos": 48
}, {
  "quantidade": 2,
  "produtos_idprodutos": 22,
  "pedidos_idpedidos": 30
}, {
  "quantidade": 7,
  "produtos_idprodutos": 49,
  "pedidos_idpedidos": 48
}, {
  "quantidade": 1,
  "produtos_idprodutos": 24,
  "pedidos_idpedidos": 4
}, {
  "quantidade": 9,
  "produtos_idprodutos": 30,
  "pedidos_idpedidos": 2
}, {
  "quantidade": 9,
  "produtos_idprodutos": 30,
  "pedidos_idpedidos": 31
}, {
  "quantidade": 6,
  "produtos_idprodutos": 39,
  "pedidos_idpedidos": 20
}, {
  "quantidade": 8,
  "produtos_idprodutos": 12,
  "pedidos_idpedidos": 22
}, {
  "quantidade": 2,
  "produtos_idprodutos": 89,
  "pedidos_idpedidos": 8
}, {
  "quantidade": 10,
  "produtos_idprodutos": 1,
  "pedidos_idpedidos": 2
}, {
  "quantidade": 15,
  "produtos_idprodutos": 89,
  "pedidos_idpedidos": 14
}, {
  "quantidade": 5,
  "produtos_idprodutos": 2,
  "pedidos_idpedidos": 8
}, {
  "quantidade": 7,
  "produtos_idprodutos": 9,
  "pedidos_idpedidos": 46
}, {
  "quantidade": 3,
  "produtos_idprodutos": 60,
  "pedidos_idpedidos": 2
}, {
  "quantidade": 12,
  "produtos_idprodutos": 94,
  "pedidos_idpedidos": 19
}, {
  "quantidade": 13,
  "produtos_idprodutos": 53,
  "pedidos_idpedidos": 18
}, {
  "quantidade": 15,
  "produtos_idprodutos": 33,
  "pedidos_idpedidos": 25
}, {
  "quantidade": 3,
  "produtos_idprodutos": 90,
  "pedidos_idpedidos": 36
}, {
  "quantidade": 1,
  "produtos_idprodutos": 31,
  "pedidos_idpedidos": 15
}, {
  "quantidade": 15,
  "produtos_idprodutos": 11,
  "pedidos_idpedidos": 14
}, {
  "quantidade": 8,
  "produtos_idprodutos": 11,
  "pedidos_idpedidos": 9
}, {
  "quantidade": 1,
  "produtos_idprodutos": 2,
  "pedidos_idpedidos": 25
}, {
  "quantidade": 14,
  "produtos_idprodutos": 40,
  "pedidos_idpedidos": 19
}, {
  "quantidade": 4,
  "produtos_idprodutos": 67,
  "pedidos_idpedidos": 12
}, {
  "quantidade": 9,
  "produtos_idprodutos": 50,
  "pedidos_idpedidos": 28
}, {
  "quantidade": 6,
  "produtos_idprodutos": 52,
  "pedidos_idpedidos": 36
}, {
  "quantidade": 11,
  "produtos_idprodutos": 20,
  "pedidos_idpedidos": 30
}, {
  "quantidade": 13,
  "produtos_idprodutos": 72,
  "pedidos_idpedidos": 39
}, {
  "quantidade": 4,
  "produtos_idprodutos": 45,
  "pedidos_idpedidos": 45
}, {
  "quantidade": 10,
  "produtos_idprodutos": 27,
  "pedidos_idpedidos": 21
}, {
  "quantidade": 6,
  "produtos_idprodutos": 100,
  "pedidos_idpedidos": 40
}, {
  "quantidade": 12,
  "produtos_idprodutos": 6,
  "pedidos_idpedidos": 47
}, {
  "quantidade": 15,
  "produtos_idprodutos": 62,
  "pedidos_idpedidos": 42
}, {
  "quantidade": 15,
  "produtos_idprodutos": 63,
  "pedidos_idpedidos": 34
}, {
  "quantidade": 8,
  "produtos_idprodutos": 88,
  "pedidos_idpedidos": 25
}, {
  "quantidade": 8,
  "produtos_idprodutos": 26,
  "pedidos_idpedidos": 39
}, {
  "quantidade": 9,
  "produtos_idprodutos": 49,
  "pedidos_idpedidos": 46
}, {
  "quantidade": 6,
  "produtos_idprodutos": 61,
  "pedidos_idpedidos": 33
}, {
  "quantidade": 9,
  "produtos_idprodutos": 72,
  "pedidos_idpedidos": 16
}, {
  "quantidade": 8,
  "produtos_idprodutos": 27,
  "pedidos_idpedidos": 9
}, {
  "quantidade": 14,
  "produtos_idprodutos": 25,
  "pedidos_idpedidos": 9
}, {
  "quantidade": 12,
  "produtos_idprodutos": 88,
  "pedidos_idpedidos": 43
}, {
  "quantidade": 10,
  "produtos_idprodutos": 37,
  "pedidos_idpedidos": 5
}, {
  "quantidade": 9,
  "produtos_idprodutos": 44,
  "pedidos_idpedidos": 20
}, {
  "quantidade": 8,
  "produtos_idprodutos": 64,
  "pedidos_idpedidos": 8
}, {
  "quantidade": 13,
  "produtos_idprodutos": 94,
  "pedidos_idpedidos": 8
}, {
  "quantidade": 1,
  "produtos_idprodutos": 94,
  "pedidos_idpedidos": 31
}, {
  "quantidade": 12,
  "produtos_idprodutos": 55,
  "pedidos_idpedidos": 34
}, {
  "quantidade": 14,
  "produtos_idprodutos": 58,
  "pedidos_idpedidos": 48
}, {
  "quantidade": 2,
  "produtos_idprodutos": 97,
  "pedidos_idpedidos": 26
}, {
  "quantidade": 14,
  "produtos_idprodutos": 70,
  "pedidos_idpedidos": 9
}, {
  "quantidade": 14,
  "produtos_idprodutos": 24,
  "pedidos_idpedidos": 27
}, {
  "quantidade": 5,
  "produtos_idprodutos": 17,
  "pedidos_idpedidos": 6
}, {
  "quantidade": 13,
  "produtos_idprodutos": 20,
  "pedidos_idpedidos": 30
}, {
  "quantidade": 9,
  "produtos_idprodutos": 87,
  "pedidos_idpedidos": 16
}, {
  "quantidade": 5,
  "produtos_idprodutos": 73,
  "pedidos_idpedidos": 35
}, {
  "quantidade": 2,
  "produtos_idprodutos": 67,
  "pedidos_idpedidos": 1
}, {
  "quantidade": 15,
  "produtos_idprodutos": 83,
  "pedidos_idpedidos": 1
}, {
  "quantidade": 10,
  "produtos_idprodutos": 52,
  "pedidos_idpedidos": 45
}, {
  "quantidade": 13,
  "produtos_idprodutos": 71,
  "pedidos_idpedidos": 5
}, {
  "quantidade": 10,
  "produtos_idprodutos": 86,
  "pedidos_idpedidos": 24
}, {
  "quantidade": 2,
  "produtos_idprodutos": 87,
  "pedidos_idpedidos": 7
}, {
  "quantidade": 9,
  "produtos_idprodutos": 12,
  "pedidos_idpedidos": 2
}, {
  "quantidade": 14,
  "produtos_idprodutos": 75,
  "pedidos_idpedidos": 47
}, {
  "quantidade": 10,
  "produtos_idprodutos": 7,
  "pedidos_idpedidos": 25
}, {
  "quantidade": 13,
  "produtos_idprodutos": 100,
  "pedidos_idpedidos": 43
}, {
  "quantidade": 8,
  "produtos_idprodutos": 26,
  "pedidos_idpedidos": 1
}, {
  "quantidade": 4,
  "produtos_idprodutos": 83,
  "pedidos_idpedidos": 11
}, {
  "quantidade": 1,
  "produtos_idprodutos": 88,
  "pedidos_idpedidos": 9
}, {
  "quantidade": 13,
  "produtos_idprodutos": 55,
  "pedidos_idpedidos": 14
}, {
  "quantidade": 11,
  "produtos_idprodutos": 92,
  "pedidos_idpedidos": 13
}, {
  "quantidade": 6,
  "produtos_idprodutos": 95,
  "pedidos_idpedidos": 3
}, {
  "quantidade": 6,
  "produtos_idprodutos": 71,
  "pedidos_idpedidos": 40
}, {
  "quantidade": 13,
  "produtos_idprodutos": 49,
  "pedidos_idpedidos": 4
}, {
  "quantidade": 1,
  "produtos_idprodutos": 85,
  "pedidos_idpedidos": 23
}, {
  "quantidade": 12,
  "produtos_idprodutos": 95,
  "pedidos_idpedidos": 49
}, {
  "quantidade": 9,
  "produtos_idprodutos": 39,
  "pedidos_idpedidos": 18
}, {
  "quantidade": 10,
  "produtos_idprodutos": 47,
  "pedidos_idpedidos": 4
}, {
  "quantidade": 5,
  "produtos_idprodutos": 30,
  "pedidos_idpedidos": 27
}, {
  "quantidade": 13,
  "produtos_idprodutos": 97,
  "pedidos_idpedidos": 44
}]');



