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
  `estoque_idestoque` INT NOT NULL,
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
  `telefone` INT NULL,
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
-- Table `Empresa`.`estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Empresa`.`estoque` (
  `idestoque` INT NOT NULL AUTO_INCREMENT,
  `quantidade_disponivel` INT NULL,
  `data_atualizacao` DATETIME NULL,
  `produtos_idprodutos` INT NOT NULL,
  PRIMARY KEY (`idestoque`),
  INDEX `fk_estoque_produtos1_idx` (`produtos_idprodutos` ASC) VISIBLE,
  CONSTRAINT `fk_estoque_produtos1`
    FOREIGN KEY (`produtos_idprodutos`)
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
  `valor_pago` DECIMAL(2) NULL,
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
