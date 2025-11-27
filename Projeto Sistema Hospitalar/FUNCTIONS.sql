-- FUNCTION: FN_CALCULA_IDADE
-- Objetivo: Calcular a idade de um paciente com base na
-- data de nascimento.
CREATE OR REPLACE FUNCTION FN_CALCULA_IDADE (p_id_paciente NUMBER)
RETURN NUMBER
AS
-- Declara variaveis internas
    v_data_nasc DATE;
    v_idade NUMBER;
BEGIN
    -- Buscar a data de nascimento
    SELECT DATA_NASCIMENTO 
    INTO v_data_nasc
    FROM PACIENTE
    WHERE ID = p_id_paciente;

    -- Calcular a idade
    v_idade := TRUNC(MONTHS_BETWEEN(SYSDATE, v_data_nasc) / 12);

    RETURN v_idade;

-- Tratamento de erro caso não encontre

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20020, 'Paciente não encontrado.');
END;
/

SELECT FN_CALCULA_IDADE(1) FROM dual;

-- FUNCTION: FN_TOTAL_EXAMES_ATENDIMENTO
-- Objetivo: Somar o valor total dos exames solicitados
-- para um atendimento específico.
CREATE OR REPLACE FUNCTION FN_TOTAL_FINANCEIRO_ATENDIMENTO(p_id_atendimento NUMBER)
RETURN NUMBER
AS
    v_total NUMBER;
BEGIN
    -- Soma todos os valores do atendimento
    SELECT NVL(SUM(VALOR),0)
    INTO v_total
    FROM FINANCEIRO
    WHERE ID_ATENDIMENTO = p_id_atendimento;

    RETURN v_total;
END;
/

SELECT FN_TOTAL_FINANCEIRO_ATENDIMENTO(1) FROM dual;
