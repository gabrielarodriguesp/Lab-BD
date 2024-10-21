



-- exercicio 1
SELECT PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL FROM L05_DISPUTA
WHERE DATA_HORA = TO_DATE('2016-08-06 10:00:00', 'YYYY-MM-DD HH24:MI:SS');
 
-- exercicio 2 nao entendi o que é um evento
SELECT nome from local;

-- SELECT * FROM DISPUTA GROUP BY LOCAL;

-- exercicio 3


SELECT
    A.NOME,
    O.ANO,
    SUM(P.VALOR_TOTAL) AS TOTAL_GANHO_PATROCINIO
FROM
    L09_PATROCINA P
JOIN
    L06_ATLETA A ON P.ATLETA = A.PASSAPORTE
JOIN
    L08_PATROCINADOR SP ON P.PATROCINADOR = SP.ID
JOIN
    L02_OLIMPIADA O ON O.ANO = EXTRACT(YEAR FROM P.INICIO) -- Adjusted to use EXTRACT
GROUP BY
    A.NOME,
    O.ANO
ORDER BY
    A.NOME,
    O.ANO;

-- SELECT
--     M.ESPORTE,
--     T.MIDIA
-- FROM
--     L03_MODALIDADE M
-- JOIN
--     TRANSMISSAO T ON M.ID = T.MODALIDADE_ID -- Supondo que a tabela de transmissão tenha a coluna MODALIDADE_ID
-- WHERE
--     M.ESPORTE = 'nome_da_modalidade';  -- Substitua 'nome_da_modalidade' pelo nome da modalidade específica.

-- SELECT
--     M.ESPORTE,
--     T.DATA_HORA,
--     T.MIDIA
-- FROM
--     L03_MODALIDADE M
-- JOIN
--     TRANSMITE T ON M.ID = T.MODALIDADE_ID -- Supondo que a tabela de transmissão tenha a coluna MODALIDADE_ID
-- WHERE
--     M.ESPORTE = 'nome_da_modalidade'  -- Substitua 'nome_da_modalidade' pelo nome da modalidade específica
-- ORDER BY
--     T.DATA_HORA;