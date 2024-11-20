use Empresa;

/**
 * Procedimento que cria uma nova promoção na tabela `promocao` que contém a data de inicio
 * igual a data atual
 * 
 * Parâmetros de entrada:
 * - `descricao` (VARCHAR(45)): Descrição da promoção.
 * - `percentual` (DECIMAL(2)): Percentual de desconto da promoção.
 * - `data_fim` (DATE): Data final da promoção.
 */
DELIMITER $$

CREATE PROCEDURE criar_promocao_hoje(
    IN descricao VARCHAR(45), 
    IN percentual DECIMAL(2), 
    IN data_fim DATE
)
BEGIN
    -- Declaração de variáveis locais
    DECLARE id INT;
    DECLARE data_inicio DATE;

    -- Atribuição da data de início como a data atual
    SET data_inicio = CURDATE();

    -- Verificação: A data final não pode ser menor que a data de início
    IF data_fim < data_inicio THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Erro: A data final da promoção não pode ser menor que a data atual.';
    END IF;

    -- Determinação do próximo ID para a nova promoção
    SELECT (COUNT(*) + 1) INTO id
    FROM promocao;

    -- Inserção dos valores na tabela
    INSERT INTO promocao (idpromocao, descricao, percentual, data_inicio, data_fim)
    VALUES (id, descricao, percentual, data_inicio, data_fim);

    -- Consulta para exibir a promoção cadastrada com mensagem de sucesso
    SELECT *, 'Promoção cadastrada com sucesso' AS resultado
    FROM promocao
    WHERE idpromocao = id;
END $$

DELIMITER ;