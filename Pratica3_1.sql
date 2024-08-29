-- Insert new rows into PAIS
INSERT INTO PAIS (ID, NOME, CONTINENTE, POPULACAO) VALUES (22, 'Coreia do Sul', 'Ásia', 51780579);
INSERT INTO PAIS (ID, NOME, CONTINENTE, POPULACAO) VALUES (37, 'Suíça', 'Europa', 10327589);
INSERT INTO PAIS (ID, NOME, CONTINENTE, POPULACAO) VALUES (24, 'Noruega', 'Europa', 5421241);
INSERT INTO PAIS (ID, NOME, CONTINENTE, POPULACAO) VALUES (25, 'Dinamarca', 'Europa', 5831404);
INSERT INTO PAIS (ID, NOME, CONTINENTE, POPULACAO) VALUES (26, 'Finlândia', 'Europa', 5540720);
INSERT INTO PAIS (ID, NOME, CONTINENTE, POPULACAO) VALUES (251, 'Jamaica', 'África', 5548720);
INSERT INTO PAIS (ID, NOME, CONTINENTE, POPULACAO) VALUES (231, 'Sérvia', 'Europa', 5548332);
INSERT INTO PAIS (ID, NOME, CONTINENTE, POPULACAO) VALUES (151, 'Portugal', 'Europa', 5538720);





-- Insert new rows into OLIMPIADA
INSERT INTO OLIMPIADA (ANO, PAIS, CIDADE_SEDE, DATA_INICIO, DATA_ENCERRAMENTO) 
VALUES (2024, 'França', 'Paris', TO_DATE('2024-07-26', 'YYYY-MM-DD'), TO_DATE('2024-08-11', 'YYYY-MM-DD'));
INSERT INTO OLIMPIADA (ANO, PAIS, CIDADE_SEDE, DATA_INICIO, DATA_ENCERRAMENTO) 
VALUES (2028, 'Estados Unidos', 'Los Angeles', TO_DATE('2028-07-21', 'YYYY-MM-DD'), TO_DATE('2028-08-06', 'YYYY-MM-DD'));
INSERT INTO OLIMPIADA (ANO, PAIS, CIDADE_SEDE, DATA_INICIO, DATA_ENCERRAMENTO) 
VALUES (2032, 'Austrália', 'Brisbane', TO_DATE('2032-07-23', 'YYYY-MM-DD'), TO_DATE('2032-08-08', 'YYYY-MM-DD'));
INSERT INTO OLIMPIADA (ANO, PAIS, CIDADE_SEDE, DATA_INICIO, DATA_ENCERRAMENTO) 
VALUES (2036, 'Alemanha', 'Berlin', TO_DATE('2036-07-24', 'YYYY-MM-DD'), TO_DATE('2036-08-09', 'YYYY-MM-DD'));
INSERT INTO OLIMPIADA (ANO, PAIS, CIDADE_SEDE, DATA_INICIO, DATA_ENCERRAMENTO) 
VALUES (2040, 'China', 'Shanghai', TO_DATE('2040-07-25', 'YYYY-MM-DD'), TO_DATE('2040-08-10', 'YYYY-MM-DD'));

-- Insert new rows into LOCAL
INSERT INTO LOCAL (ID, NOME, TIPO, CAPACIDADE, PAIS) VALUES (11, 'Stade de France', 'ESTAGIO', 81338, 'França');
INSERT INTO LOCAL (ID, NOME, TIPO, CAPACIDADE, PAIS) VALUES (12, 'Los Angeles Memorial Coliseum', 'ESTAGIO', 77500, 'Estados Unidos');
INSERT INTO LOCAL (ID, NOME, TIPO, CAPACIDADE, PAIS) VALUES (13, 'Brisbane Cricket Ground', 'ESTAGIO', 42000, 'Austrália');
INSERT INTO LOCAL (ID, NOME, TIPO, CAPACIDADE, PAIS) VALUES (15, 'Shanghai Stadium', 'ESTAGIO', 80000, 'China');
INSERT INTO LOCAL (ID, NOME, TIPO, CAPACIDADE, PAIS) VALUES (16, 'Tokyo Stadium', 'ESTAGIO', 49000, 'Japão');
-- Insert new rows into MODALIDADE
INSERT INTO MODALIDADE (ID, ESPORTE, GENERO) VALUES (12, 'Basquete', 'M');
INSERT INTO MODALIDADE (ID, ESPORTE, GENERO) VALUES (13, 'Basquete', 'F');
INSERT INTO MODALIDADE (ID, ESPORTE, GENERO) VALUES (14, 'Handebol', 'M');
INSERT INTO MODALIDADE (ID, ESPORTE, GENERO) VALUES (15, 'Handebol', 'F');
INSERT INTO MODALIDADE (ID, ESPORTE, GENERO) VALUES (16, 'Tênis', 'M');
INSERT INTO L03_MODALIDADE (ID, ESPORTE, GENERO) VALUES (17, 'Futebol', 'M');

-- Insert new rows into PATROCINADOR
INSERT INTO PATROCINADOR (ID, NOME, RAMO) VALUES (1, 'Nike', 'Esportes');
INSERT INTO PATROCINADOR (ID, NOME, RAMO) VALUES (2, 'Adidas', 'Esportes');
INSERT INTO PATROCINADOR (ID, NOME, RAMO) VALUES (3, 'Puma', 'Esportes');
INSERT INTO PATROCINADOR (ID, NOME, RAMO) VALUES (4, 'Samsung', 'Tecnlogia');
INSERT INTO PATROCINADOR (ID, NOME, RAMO) VALUES (5, 'Toyota', 'Automobilistica');

-- Insert new rows into ATLETA
INSERT INTO ATLETA (PASSAPORTE, NOME, PAIS, GENERO, MODALIDADE) VALUES ('1', 'U. Bolt', 'Jamaica', 'M', 1);
INSERT INTO ATLETA (PASSAPORTE, NOME, PAIS, GENERO, MODALIDADE) VALUES ('2', 'M. Phelps', 'Estados Unidos', 'M', 3);
INSERT INTO ATLETA (PASSAPORTE, NOME, PAIS, GENERO, MODALIDADE) VALUES ('3', 'S. Biles', 'Estados Unidos', 'F', 6);
INSERT INTO ATLETA (PASSAPORTE, NOME, PAIS, GENERO, MODALIDADE) VALUES ('4', 'Neymar', 'Brasil', 'M', 11);
INSERT INTO ATLETA (PASSAPORTE, NOME, PAIS, GENERO, MODALIDADE) VALUES ('5', 'N.Djokovic', 'Sérvia', 'M', 16);
INSERT INTO ATLETA (PASSAPORTE, NOME, PAIS, GENERO, MODALIDADE) VALUES ('6', 'L. Messi', 'Argentina', 'M', 17);
INSERT INTO ATLETA (PASSAPORTE, NOME, PAIS, GENERO, MODALIDADE) VALUES ('7', 'C. Ronaldo', 'Portugal', 'M', 17);
INSERT INTO ATLETA (PASSAPORTE, NOME, PAIS, GENERO, MODALIDADE) VALUES ('8', 'R. Federer', 'Suíça', 'M', 16);
INSERT INTO ATLETA (PASSAPORTE, NOME, PAIS, GENERO, MODALIDADE) VALUES ('9', 'R. Nadal', 'Espanha', 'M', 16);
INSERT INTO ATLETA (PASSAPORTE, NOME, PAIS, GENERO, MODALIDADE) VALUES ('10', 'L.Hamilton', 'Reino Unido', 'M', 12);
INSERT INTO ATLETA (PASSAPORTE, NOME, PAIS, GENERO, MODALIDADE) VALUES ('11', 'S.Williams', 'Estados Unidos', 'F', 15);
INSERT INTO ATLETA (PASSAPORTE, NOME, PAIS, GENERO, MODALIDADE) VALUES ('12', 'K. Bryant', 'Estados Unidos', 'M', 12);
INSERT INTO ATLETA (PASSAPORTE, NOME, PAIS, GENERO, MODALIDADE) VALUES ('13', 'M. V.Silva', 'Brasil', 'F', 11);
INSERT INTO ATLETA (PASSAPORTE, NOME, PAIS, GENERO, MODALIDADE) VALUES ('14', 'T. Brady', 'Estados Unidos', 'M', 17);
INSERT INTO ATLETA (PASSAPORTE, NOME, PAIS, GENERO, MODALIDADE) VALUES ('15', 'L. Messi', 'Argentina', 'M', 17);
-- Insert new rows into MIDIA
INSERT INTO MIDIA (ID, NOME, TIPO) VALUES (1, 'NBC', 'TV');
INSERT INTO MIDIA (ID, NOME, TIPO) VALUES (2, 'BBC', 'TV');
INSERT INTO MIDIA (ID, NOME, TIPO) VALUES (3, 'ESPN', 'TV');
INSERT INTO MIDIA (ID, NOME, TIPO) VALUES (4, 'Fox Sports', 'TV');
INSERT INTO MIDIA (ID, NOME, TIPO) VALUES (5, 'CCTV', 'TV');

-- Insert rows into JOGA table
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('M. Phelps', 61);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('S. Biles', 63);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('Neymar', 67);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('Neymar', 68);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('U. Bolt', 73);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('S. Biles', 75);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('S. Biles', 76);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('Neymar', 77);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('M. Phelps', 78);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('S. Biles', 79);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('M. Phelps', 80);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('U. Bolt', 81);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('M. Phelps', 82);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('S. Biles', 83);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('Neymar', 84);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('N.Djokovic', 85);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('U. Bolt', 86);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('S. Biles', 87);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('Neymar', 88);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('M. Phelps', 89);
INSERT INTO JOGA (ATLETA, DISPUTA) VALUES ('S. Biles', 90);


-- Insert rows into DISPUTA table
-- Insert rows into DISPUTA table
INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (200, 'Brasil', 'Estados Unidos', 'Brasil', 3, 2024, TO_DATE('2024-08-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (201, 'China', 'Japão', 'China', 3, 2024, TO_DATE('2024-08-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (202, 'Alemanha', 'França', 'Alemanha', 3, 2024, TO_DATE('2024-08-10 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (203, 'Reino Unido', 'Rússia', 'Reino Unido', 3, 2024, TO_DATE('2024-08-10 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (204, 'Brasil', 'China', 'Brasil', 3, 2024, TO_DATE('2024-08-12 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (205, 'Alemanha', 'Reino Unido', 'Alemanha', 3, 2024, TO_DATE('2024-08-12 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (206, 'Brasil', 'Alemanha', 'Brasil', 3, 2024, TO_DATE('2024-08-14 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (207, 'Brasil', 'Alemanha', 'Brasil', 6, 2024, TO_DATE('2024-08-16 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (208, 'Estados Unidos', 'China', 'Estados Unidos', 6, 2024, TO_DATE('2024-08-16 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (209, 'Japão', 'França', 'Japão', 6, 2024, TO_DATE('2024-08-16 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (210, 'Rússia', 'Reino Unido', 'Rússia', 6, 2024, TO_DATE('2024-08-16 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (211, 'Austrália', 'Nigéria', 'Austrália', 6, 2024, TO_DATE('2024-08-16 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (212, 'Brasil', 'Estados Unidos', 'Brasil', 6, 2024, TO_DATE('2024-08-18 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (213, 'Japão', 'Rússia', 'Japão', 6, 2024, TO_DATE('2024-08-18 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (214, 'Austrália', 'Brasil', 'Brasil', 6, 2024, TO_DATE('2024-08-20 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (215, 'Japão', 'Brasil', 'Brasil', 6, 2024, TO_DATE('2024-08-22 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (216, 'Brasil', 'Alemanha', 'Brasil', 11, 2024, TO_DATE('2024-08-24 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (217, 'Estados Unidos', 'China', 'Estados Unidos', 11, 2024, TO_DATE('2024-08-24 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (218, 'Japão', 'França', 'Japão', 11, 2024, TO_DATE('2024-08-24 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (381, 'Brasil', 'Argentina', 'Brasil', 11, 2024, TO_DATE('2024-08-26 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (382, 'Canadá', 'México', 'Canadá', 11, 2024, TO_DATE('2024-08-26 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (383, 'Itália', 'Espanha', 'Itália', 11, 2024, TO_DATE('2024-08-26 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (384, 'Portugal', 'Jamaica', 'Portugal', 11, 2024, TO_DATE('2024-08-26 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (385, 'Suíça', 'Noruega', 'Suíça', 11, 2024, TO_DATE('2024-08-26 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (386, 'Dinamarca', 'Finlândia', 'Dinamarca', 11, 2024, TO_DATE('2024-08-28 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (387, 'Suíça', 'Jamaica', 'Suíça', 11, 2024, TO_DATE('2024-08-28 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (388, 'Suíça', 'Jamaica', 'Suíça', 11, 2024, TO_DATE('2024-08-28 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (389, 'Grécia', 'Turquia', 'Grécia', 11, 2024, TO_DATE('2024-08-28 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (390, 'Egito', 'Suíça', 'Egito', 11, 2024, TO_DATE('2024-08-28 18:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);
INSERT INTO DISPUTA (ID, PAIS1, PAIS2, VENCEDOR, MODALIDADE, OLIMPIADA, DATA_HORA, LOCAL) 
VALUES (393, 'Rússia', 'Reino Unido', 'Rússia', 11, 2024, TO_DATE('2024-08-24 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

-- Insert rows into L11_TRANSMITE table
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (1, 385);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (2, 384);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (3, 389);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (4, 201);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (5, 202);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (1, 203);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (1, 205);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (1, 206);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (1, 207);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (2, 208);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (2, 209);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (2, 210);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (2, 211);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (2, 212);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (3, 213);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (3, 214);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (3, 215);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (4, 381);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (4, 382);
INSERT INTO L11_TRANSMITE (MIDIA, DISPUTA) VALUES (4, 383);

-- Insert rows into PATROCINA table
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (2, '15', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 1600000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (3, '13', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 1700000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (4, '2', TO_DATE('2016-01-01', 'YYYY-MM-DD'), 12, 1800000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (3, '4', TO_DATE('2016-01-01', 'YYYY-MM-DD'), 12, 1900000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (2, '12', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 2000000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (1, '10', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 500000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (2, '9', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 400000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (3, '8', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 300000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (4, '7', TO_DATE('2016-01-01', 'YYYY-MM-DD'), 12, 200000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (5, '4', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 100000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (3, '5', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 600000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (2, '4', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 700000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (1, '14', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 800000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (3, '11', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 900000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (4, '3', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 1000000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (3, '6', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 1100000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (2, '5', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 1200000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (1, '1', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 1300000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (5, '7', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 1400000);
INSERT INTO PATROCINA (PATROCINADOR, ATLETA, INICIO, VIGENCIA, VALOR_TOTAL) 
VALUES (5, '2', TO_DATE('2020-01-01', 'YYYY-MM-DD'), 12, 1500000);
