CREATE SEQUENCE Seq_idAtleta
    START WITH 1000
    INCREMENT BY 1
    NOCYCLE;
    
CREATE SEQUENCE Seq_idPais
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;
    
CREATE SEQUENCE Seq_idDelegacao
    START WITH 10
    INCREMENT BY 1
    NOCYCLE;
    
CREATE SEQUENCE Seq_idDisputa
    START WITH 1
    INCREMENT BY 1
    NOCYCLE;

CREATE TABLE Pais(
    idPais INTEGER NOT NULL,
    Nome VARCHAR(20) NOT NULL,
    Continente VARCHAR(8) NOT NULL, 
    Populacao INTEGER,
    CONSTRAINT PK_Pais PRIMARY KEY(idPais),
    CONSTRAINT UN_Pais UNIQUE(Nome),
    CONSTRAINT CK_Pais CHECK (Continente IN ('Asia', 'Europa', 'America',
                                                  'Africa', 'Oceania'))

);

CREATE TABLE Olimpiada(
    Sede VARCHAR(20) NOT NULL,
    Ano INTEGER NOT NULL,
    Mascote VARCHAR(15) NOT NULL,
    QtdeModalidades INTEGER NOT NULL,
    CONSTRAINT PK_Olimpiada PRIMARY KEY(Sede, Ano)
);

CREATE TABLE Delegacao(
    idDelegacao INTEGER NOT NULL,
    Pais INTEGER NOT NULL,
    SedeOlimp VARCHAR(20) NOT NULL,
    AnoOlimp INTEGER NOT NULL,
    QtdeAtletas INTEGER NOT NULL,
    CorPrincipal VARCHAR(20) NOT NULL,
    CorSecundaria VARCHAR(20),
    CONSTRAINT PK_Delegacao PRIMARY KEY(idDelegacao),
    CONSTRAINT UN_Delegacao UNIQUE(Pais, SedeOlimp, AnoOlimp),
    CONSTRAINT FK1_Delegacao FOREIGN KEY (Pais) REFERENCES PAIS(idPais),
    CONSTRAINT FK2_Delegacao FOREIGN KEY (SedeOlimp, AnoOlimp) REFERENCES 
                                          Olimpiada(Sede, Ano) ON DELETE CASCADE
    
);

CREATE TABLE Atleta (
    idAtleta INTEGER NOT NULL,
    Nome VARCHAR(50) NOT NULL,
    Modalidade VARCHAR(20) NOT NULL,
    Genero CHAR(9) NOT NULL,
    Nacionalidade CHAR(20),
    Delegacao INTEGER,
    CONSTRAINT PK_Atleta PRIMARY KEY(idAtleta),
    CONSTRAINT UN_Atleta UNIQUE(Nome, Modalidade),
    CONSTRAINT FK_Atleta FOREIGN KEY(Delegacao) REFERENCES Delegacao(idDelegacao)
                                    ON DELETE CASCADE,
    CONSTRAINT CK_Atleta CHECK (Genero IN ('Masculino', 'Feminino'))
);

CREATE TABLE PracaEsportiva (
    Nome VARCHAR(50) NOT NULL,
    Endereco VARCHAR(50) NOT NULL,
    Area INTEGER NOT NULL,
    Perimetro INTEGER,
    LotacaoMaxima INTEGER NOT NULL,
    OlimpiadaSede VARCHAR(20) NOT NULL,
    OlimpiadaAno INTEGER NOT NULL,
    CONSTRAINT PK_PracaEsportiva PRIMARY KEY (Nome),
    CONSTRAINT FK_PracaEsportiva FOREIGN KEY (OlimpiadaSede, OlimpiadaAno)
                                REFERENCES Olimpiada(Sede, Ano)
                                ON DELETE CASCADE
);


CREATE TABLE Modalidade(
     Nome VARCHAR(20) NOT NULL,
     MascFem VARCHAR(9) NOT NULL,
     Descricao VARCHAR(200),
     DataInicio DATE NOT NULL,
     DataFim DATE NOT NULL, 
     DuracaoPartida INTEGER DEFAULT '90',
     PracaEsportiva VARCHAR(50) NOT NULL,
     CONSTRAINT PK_Modalidade PRIMARY KEY (Nome),
     CONSTRAINT FK_Modalidade FOREIGN KEY (PracaEsportiva) 
                                REFERENCES PracaEsportiva(Nome)
                                ON DELETE CASCADE,
    CONSTRAINT CK_Modalidade CHECK (MascFem IN ('Masculino', 'Feminino'))
);


CREATE TABLE Disputa (
    idDisputa INTEGER NOT NULL,
    Atleta1 INTEGER NOT NULL,
    Atleta2 INTEGER NOT NULL,
    Modalidade VARCHAR(20) NOT NULL,
    DataHora DATE NOT NULL,
    Vencedor INTEGER NOT NULL,
    CONSTRAINT PK_Disputa PRIMARY KEY (idDisputa),
    CONSTRAINT FK1_Disputa FOREIGN KEY (Atleta1) REFERENCES Atleta(idAtleta)
                                        ON DELETE CASCADE,
    CONSTRAINT FK2_Disputa FOREIGN KEY (Atleta2) REFERENCES Atleta(idAtleta)
                                        ON DELETE CASCADE,
    CONSTRAINT FK3_Disputa FOREIGN KEY (Vencedor) REFERENCES Atleta(idAtleta)
                                        ON DELETE CASCADE,
    CONSTRAINT FK4_Disputa FOREIGN KEY (Modalidade) REFERENCES Modalidade(Nome)
                                        ON DELETE CASCADE,
    CONSTRAINT CK1_Disputa CHECK (Atleta1 != Atleta2),
    CONSTRAINT CK2_Disputa CHECK (Vencedor IN (Atleta1, Atleta2))
);


CREATE TABLE Transmissora (
    Nome VARCHAR(10) NOT NULL,
    Narrador VARCHAR(40) NOT NULL,
    Canal INTEGER,
    Estacao VARCHAR(5),
    Plataforma VARCHAR(10),
    CONSTRAINT PK_Transmissora PRIMARY KEY(Nome)
);

CREATE TABLE Transmissao (
    NomeTransmissora VARCHAR(10) NOT NULL,
    idDisputa INTEGER NOT NULL,
    CONSTRAINT FK1_Transmissao FOREIGN KEY (NomeTransmissora) REFERENCES
                                Transmissora(Nome) ON DELETE CASCADE,
    CONSTRAINT FK2_Transmissao FOREIGN KEY (idDisputa) REFERENCES 
                                Disputa(idDisputa) ON DELETE CASCADE, 
    CONSTRAINT PK_Transmissao PRIMARY KEY(NomeTransmissora, idDisputa)
);

CREATE TABLE Patrocinio (
    Nome VARCHAR(30) NOT NULL,
    Descricao VARCHAR(200),
    AtletaPatrocinado INTEGER NOT NULL,
    Pacote VARCHAR(8),
    Valor INTEGER NOT NULL,
    CONSTRAINT PK_Patrocinio PRIMARY KEY (Nome, AtletaPatrocinado),
    CONSTRAINT FK_Patrocinio FOREIGN KEY (AtletaPatrocinado) 
                            REFERENCES Atleta(idAtleta) ON DELETE CASCADE,
    CONSTRAINT CK_Patrocinio CHECK (Pacote IN ('Silver', 'Gold', 'Diamond',
                                                  'Platinum'))
);

CREATE TABLE ProdutoPatrocinio(
    NomePatrocinio VARCHAR(30) NOT NULL,
    Atleta INTEGER NOT NULL,
    Produto VARCHAR(50) NOT NULL,
    CONSTRAINT FK_ProdutoPatrocinado FOREIGN KEY (NomePatrocinio, Atleta) REFERENCES
                                    Patrocinio(Nome, AtletaPatrocinado) ON DELETE CASCADE,
    CONSTRAINT PK_ProdutoPatrocinio PRIMARY KEY (NomePatrocinio, Produto)
); 

CREATE TABLE ModalidadeOlimpiada (
    Sede VARCHAR(20) NOT NULL,
    Ano INTEGER NOT NULL,
    Modalidade VARCHAR(20) NOT NULL,
    CONSTRAINT PK_ModalidadeOlimpiada PRIMARY KEY (Sede, Ano, Modalidade),
    CONSTRAINT FK1_ModalidadeOlimpiada FOREIGN KEY (Sede, Ano) REFERENCES 
                                    Olimpiada(Sede, Ano) ON DELETE CASCADE, 
    CONSTRAINT FK2_ModalidadeOlimpiada FOREIGN KEY (Modalidade) REFERENCES 
                                    Modalidade(Nome) ON DELETE CASCADE 
);


BEGIN
   FOR s IN (SELECT sequence_name FROM user_sequences) LOOP
      EXECUTE IMMEDIATE 'DROP SEQUENCE ' || s.sequence_name;
   END LOOP;
END;

BEGIN
   FOR t IN (SELECT table_name FROM user_tables) LOOP
      EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS';
   END LOOP;
END;


INSERT INTO Pais (idPais, Nome, Continente, Populacao) 
VALUES (Seq_idAtleta.NEXTVAL, 'Argentina', 'America', 46230000);
INSERT INTO Pais (idPais, Nome, Continente, Populacao)
VALUES (Seq_idAtleta.NEXTVAL, 'Brasil', 'America', 213994000);
INSERT INTO Pais (idPais, Nome, Continente, Populacao) 
VALUES (Seq_idAtleta.NEXTVAL, 'França', 'Europa', 67971000);

INSERT INTO Olimpiada (Sede, Ano, Mascote, QtdeModalidades) 
VALUES ('França', 2024, 'Phryge' ,48);
INSERT INTO Olimpiada (Sede, Ano, Mascote, QtdeModalidades) 
VALUES ('Japao', 2020, 'Maraitowa' ,33);
INSERT INTO Olimpiada (Sede, Ano, Mascote, QtdeModalidades) 
VALUES ('Brasil', 2016, 'Vinicius' ,42);


INSERT INTO Delegacao(idDelegacao, Pais, SedeOlimp, AnoOlimp, QtdeAtletas, CorPrincipal, CorSecundaria)
VALUES (Seq_idDelegacao.NEXTVAL, 1006, 'França', 2024, 277, 'Amarelo', NULL);
INSERT INTO Delegacao(idDelegacao, Pais, SedeOlimp, AnoOlimp, QtdeAtletas, CorPrincipal, CorSecundaria)
VALUES (Seq_idDelegacao.NEXTVAL, 1005, 'França', 2024, 148, 'Azul Claro', 'Branco');
INSERT INTO Delegacao(idDelegacao, Pais, SedeOlimp, AnoOlimp, QtdeAtletas, CorPrincipal, CorSecundaria)
VALUES (Seq_idDelegacao.NEXTVAL, 1007, 'França', 2024, 609, 'Azul Escuro', NULL);

INSERT INTO Atleta(idAtleta, Nome, Modalidade, Genero, Nacionalidade, Delegacao)
VALUES (Seq_idAtleta.NEXTVAL, 'Marta', 'Futebol', 'Feminino', NULL, 12);
INSERT INTO Atleta(idAtleta, Nome, Modalidade, Genero, Nacionalidade, Delegacao)
VALUES (Seq_idAtleta.NEXTVAL, 'Rebeca Andrade', 'Ginastica', 'Feminino', 'Brasileira', 12);
INSERT INTO Atleta(idAtleta, Nome, Modalidade, Genero, Nacionalidade, Delegacao)
VALUES (Seq_idAtleta.NEXTVAL, 'Flavia Saraiva', 'Ginastica', 'Feminino', 'Brasileira', NULL);
INSERT INTO Atleta(idAtleta, Nome, Modalidade, Genero, Nacionalidade, Delegacao)
VALUES (Seq_idAtleta.NEXTVAL, 'Simone Biles', 'Ginastica', 'Feminino', NULL, NULL);

INSERT INTO PracaEsportiva(Nome, Endereco, Area, Perimetro, LotacaoMaxima, OlimpiadaSede, OlimpiadaAno)
VALUES ('Roland Garros', 'Rua 1009, Paris', 10000, NULL, 34000, 'França', 2024);
INSERT INTO PracaEsportiva(Nome, Endereco, Area, Perimetro, LotacaoMaxima, OlimpiadaSede, OlimpiadaAno)
VALUES ('Parc des Princes', 'Avenida Central, Paris', 16437, NULL, 47926, 'França', 2024);
INSERT INTO PracaEsportiva(Nome, Endereco, Area, Perimetro, LotacaoMaxima, OlimpiadaSede, OlimpiadaAno)
VALUES ('Place de la Concorde', 'Parque Nacional Paris', 57348202, NULL, 30000, 'França', 2024);

INSERT INTO Modalidade(Nome, MascFem, Descricao, DataInicio, DataFim, DuracaoPartida, PracaEsportiva)
VALUES ('Boxe', 'Masculino', 'Luta que consiste principalmente em utilizar as maos', 
        TO_DATE('2024-08-05', 'YYYY-MM-DD'), 
        TO_DATE('2024-08-12', 'YYYY-MM-DD'), 
        25, 'Roland Garros');
INSERT INTO Modalidade(Nome, MascFem, Descricao, DataInicio, DataFim, DuracaoPartida, PracaEsportiva)
VALUES ('Tenis', 'Feminino', NULL, 
        TO_DATE('2024-08-04', 'YYYY-MM-DD'), 
        TO_DATE('2024-08-22', 'YYYY-MM-DD'), 
        120, 'Roland Garros');
INSERT INTO Modalidade(Nome, MascFem, Descricao, DataInicio, DataFim, DuracaoPartida, PracaEsportiva)
VALUES ('Futebol', 'Masculino', 'Jogo em campo com 11 participantes de cada time', 
        TO_DATE('2024-08-01', 'YYYY-MM-DD'), 
        TO_DATE('2024-08-30', 'YYYY-MM-DD'), 
        90, 'Parc des Princes');
        
INSERT INTO Modalidade(Nome, MascFem, Descricao, DataInicio, DataFim, DuracaoPartida, PracaEsportiva)
VALUES ('Ginastica', 'Feminino', NULL, 
        TO_DATE('2024-08-01', 'YYYY-MM-DD'), 
        TO_DATE('2024-08-30', 'YYYY-MM-DD'), 
        90, 'Parc des Princes');

INSERT INTO Disputa (idDisputa, Atleta1, Atleta2, Modalidade, DataHora, Vencedor)
VALUES (Seq_idDisputa.NEXTVAL, 1009, 1010, 'Ginastica', TO_DATE('2024-08-10', 'YYYY-MM-DD'), 1009);
INSERT INTO Disputa (idDisputa, Atleta1, Atleta2, Modalidade, DataHora, Vencedor)
VALUES (Seq_idDisputa.NEXTVAL, 1009, 1011, 'Ginastica', TO_DATE('2024-08-13', 'YYYY-MM-DD'), 1009);

INSERT INTO Transmissora(Nome, Narrador, Canal, Estacao, Plataforma)
VALUES('Caze TV', 'Casemiro', NULL, NULL, 'Youtube');
INSERT INTO Transmissora(Nome, Narrador, Canal, Estacao, Plataforma)
VALUES('SporTV', 'Galvao Bueno', 132, NULL, NULL);
INSERT INTO Transmissora(Nome, Narrador, Canal, Estacao, Plataforma)
VALUES('Radio PAN', 'Mauricio Silva', NULL, '103.4', NULL);

INSERT INTO Transmissao(NomeTransmissora, idDisputa)
VALUES('SporTV', 3);
INSERT INTO Transmissao(NomeTransmissora, idDisputa)
VALUES('SporTV', 4);
INSERT INTO Transmissao(NomeTransmissora, idDisputa)
VALUES('Caze TV', 3);

INSERT INTO Patrocinio(Nome, Descricao, AtletaPatrocinado, Pacote, Valor) 
VALUES ('Nike', NULL, 1008, 'Diamond', 100000);
INSERT INTO Patrocinio(Nome, Descricao, AtletaPatrocinado, Pacote, Valor) 
VALUES ('Red Bull', NULL, 1008, NULL, 5000);
INSERT INTO Patrocinio(Nome, Descricao, AtletaPatrocinado, Pacote, Valor) 
VALUES ('Adidas', NULL, 1010, 'Diamond', 100000);

INSERT INTO ProdutoPatrocinio(NomePatrocinio, Atleta, Produto) 
VALUES ('Nike', 1005, 'Camisa Nike');
INSERT INTO ProdutoPatrocinio(NomePatrocinio, Atleta, Produto) 
VALUES ('Nike', 1005, 'Camiseta de Time');
INSERT INTO ProdutoPatrocinio(NomePatrocinio, Atleta, Produto) 
VALUES ('Nike', 1005, 'Tenis Air Force');

