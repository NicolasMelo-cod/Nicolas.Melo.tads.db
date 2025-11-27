-- PROCEDURE: AGENDAR_ATENDIMENTO
-- Objetivo: Registrar um atendimento garantindo validações:
--   1) Paciente existe
--   2) Médico existe
--   3) Leito (se informado) está livre
--   4) Insere o atendimento

*/
CREATE OR REPLACE PROCEDURE AGENDAR_ATENDIMENTO (
    p_diagnostico IN VARCHAR2,
    p_observacoes IN VARCHAR2,
    p_id_paciente IN NUMBER,
    p_id_medico   IN NUMBER,
    p_id_leito    IN NUMBER DEFAULT NULL
)
AS
    v_exists NUMBER;
    v_status VARCHAR2(200);
BEGIN
    -- Validar paciente
    SELECT COUNT(*) INTO v_exists FROM PACIENTE WHERE ID = p_id_paciente;
    IF v_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20011, 'Paciente inexistente.');
    END IF;

    -- Validar médico
    SELECT COUNT(*) INTO v_exists FROM MEDICO WHERE ID = p_id_medico;
    IF v_exists = 0 THEN
        RAISE_APPLICATION_ERROR(-20012, 'Médico inexistente.');
    END IF;

    -- Validar leito
    IF p_id_leito IS NOT NULL THEN
        SELECT STATUS_LEITO INTO v_status
        FROM LEITO
        WHERE ID = p_id_leito
        FOR UPDATE; -- Bloqueia o leito para evitar conflito

        IF v_status = 'OCUPADO' THEN
            RAISE_APPLICATION_ERROR(-20013, 'Leito já está ocupado.');
        END IF;
    END IF;

    -- Inserir atendimento com data e hora atual (SYSDATE)
    INSERT INTO ATENDIMENTO (
        AGENDAMENTO, DIAGNOSTICO, OBSERVACOES,
        ID_PACIENTE, ID_MEDICO, ID_LEITO
    )
    VALUES (
        SYSDATE, p_diagnostico, p_observacoes,
        p_id_paciente, p_id_medico, p_id_leito
    );

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/


BEGIN
    AGENDAR_ATENDIMENTO(
        p_diagnostico => 'Gripe',
        p_observacoes => 'Paciente está estável',
        p_id_paciente => 1,
        p_id_medico   => 1,
        p_id_leito    => 21
    );
END;
/


-- PROCEDURE: CADASTRAR_PACIENTE
-- Objetivo: Registrar um atendimento garantindo validações:
--   1) Paciente existe
--   2) Médico existe
--   3) Leito (se informado) está livre
--   4) Insere o atendimento


CREATE OR REPLACE PROCEDURE CADASTRAR_PACIENTE (
    p_nome  IN  VARCHAR2,
    p_cpf   IN  VARCHAR2,
    p_plano IN  VARCHAR2,
    p_data_nascimento IN DATE
)
AS
    v_count NUMBER;
BEGIN
    -- Verificando duplicidade do CPF
    SELECT COUNT(*) INTO v_count FROM PACIENTE WHERE CPF = p_cpf;
    
    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20010, 'CPF já cadastrado.');
    END IF;

    -- Inserção do novo paciente
    INSERT INTO PACIENTE (NOME, CPF, PLANO, DATA_NASCIMENTO)
    VALUES (p_nome, p_cpf, p_plano, p_data_nascimento);

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/

EXEC CADASTRAR_PACIENTE('Vinicius Vieira da Silva', '55555522555', 'Unimed', DATE '2003-07-01');

