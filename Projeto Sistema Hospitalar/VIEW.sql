-------------------------------------------------------------
-- VIEW: VW_RESUMO_ATENDIMENTO
-- Objetivo: Exibir um resumo completo dos atendimentos,
-- agrupando informações de várias tabelas em uma única visão.
-------------------------------------------------------------
CREATE OR REPLACE VIEW VW_RESUMO_ATENDIMENTO AS
SELECT 
    A.ID AS ID_ATENDIMENTO,
    P.NOME AS NOME_PACIENTE,  -- Paciente relacionado
    M.CRM AS CRM_MEDICO,      -- CRM do médico responsável
    M.ESPECIALIDADE,
    A.DIAGNOSTICO,
    A.OBSERVACOES,
    A.AGENDAMENTO,
    A.DATA_ALTA,              -- Data de alta (se houver)
    L.ID AS ID_LEITO,
    L.STATUS_LEITO
FROM ATENDIMENTO A
JOIN PACIENTE P ON A.ID_PACIENTE = P.ID
JOIN MEDICO M ON A.ID_MEDICO = M.ID
LEFT JOIN LEITO L ON A.ID_LEITO = L.ID;

SELECT ID_ATENDIMENTO, NOME_PACIENTE, CRM_MEDICO
FROM VW_RESUMO_ATENDIMENTO;

-- VIEW: VW_OCUPACAO_LEITOS
-- Objetivo: Mostrar o status dos leitos e seus respectivos
-- setores, facilitando o controle da ocupação hospitalar.
CREATE OR REPLACE VIEW VW_OCUPACAO_LEITOS AS
SELECT 
    S.NOME_SETOR,
    S.BLOCO,
    L.ID_LEITO,
    L.STATUS_LEITO
FROM LEITO L
JOIN SETOR S ON L.ID_SETOR = S.ID_SETOR;

SELECT NOME_SETOR, BLOCO, ID_LEITO, STATUS_LEITO
FROM VW_OCUPACAO_LEITOS;

-- VIEW: VW_FINANCEIRO_RESUMO
-- Objetivo: Mostrar os registros financeiros junto com
-- informações do atendimento, paciente e setor.

CREATE OR REPLACE VIEW VW_HISTORICO_FINANCEIRO AS
SELECT
    F.ID AS ID_FINANCEIRO,
    F.ID AS ID_ATENDIMENTO,
    P.NOME AS NOME_PACIENTE,
    M.CRM AS CRM_MEDICO,
    F.VALOR,
    F.TIPO_PAGAMENTO,
    A.DIAGNOSTICO,
    L.ID AS ID_LEITO,
    S.NOME_SETOR AS SETOR
FROM FINANCEIRO F
JOIN ATENDIMENTO A ON F.ID_ATENDIMENTO = A.ID
JOIN PACIENTE P ON A.ID_PACIENTE = P.ID
JOIN MEDICO M ON A.ID_MEDICO = M.ID
LEFT JOIN LEITO L ON A.ID_LEITO = L.ID
LEFT JOIN SETOR S ON L.ID_SETOR = S.ID;

SELECT 
    ID_ATENDIMENTO,
    NOME_PACIENTE,
    VALOR,
    TIPO_PAGAMENTO,
    SETOR
FROM VW_HISTORICO_FINANCEIRO;