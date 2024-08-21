CREATE TABLE Atleta (
    idAtleta NUMBER(10) NOT NULL,
    Nome VARCHAR2(50) NOT NULL,
    Modalidade VARCHAR(20) NOT NULL,
    Genero CHAR(9) NOT NULL,
    Nacionalidade CHAR(20),
    Delegacao NUMBER(5),
    CONSTRAINT PK_Atleta PRIMARY KEY(idAtleta),
    CONSTRAINT UN_Atleta UNIQUE(Nome, Modalidade),
    CONSTRAINT FK_Atleta FOREIGN KEY(Delegacao) REFERENCES Delegacao(idDelegacao)
                                    ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CK_Atleta CHECK (Genero IN UPPER('MASCULINO', 'FEMININO'))
);

CREATE TABLE Pais (
    idPais NUMBER(3) NOT NULL,
    Nome VARCHAR2(20) NOT NULL,
    Continente CHAR(7) NOT NULL, 
    Populacao NUMBER(10),
    CONSTRAINT PK_Pais PRIMARY KEY(idPais),
    CONSTRAINT UN_Pais UNIQUE(Nome),
    CONSTRAINT CK_Pais CHECK (Continente IN UPPER('ASIA', 'EUROPA', 'AMERICA',
                                                  'AFRICA', 'OCEANIA'))

);

CREATE TABLE Olimpiada(
    Sede VARCHAR(20) NOT NULL,
    Ano NUMBER(4) NOT NULL,
    Mascote VARCHAR(15) NOT NULL,
    QtdeModalidades INTEGER NOT NULL,
    CONSTRAINT PK_Olimpiada PRIMARY KEY(Sede, Ano)
);

CREATE TABLE Delegacao(
    idDelegacao NUMBER(5) NOT NULL,
    Pais NUMBER(3) NOT NULL,
    SedeOlimp VARCHAR2(20) NOT NULL,
    AnoOlimp NUMBER(4) NOT NULL,
    QtdeAtletas NUMBER(4) NOT NULL,
    CorPrincipal VARCHAR2(20) NOT NULL,
    CorSecundaria VARCHAR2(20),
    CONSTRAINT PK_Delegacao PRIMARY KEY(idDelegacao),
    CONSTRAINT UN_Delegacao UNIQUE(Pais, SedeOlimp, AnoOlimp),
    CONSTRAINT FK1_Delegacao FOREIGN KEY (Pais) REFERENCES PAIS(idPais),
    CONSTRAINT FK2_Delegacao FOREIGN KEY (SedeOlimp, AnoOlimp) REFERENCES 
                                          Olimpiada(Sede, Ano) ON DELETE CASCADE
                                            ON UPDATE CASCADE
    
);

CREATE TABLE Modalidade(
     Nome VARCHAR(20) NOT NULL,
     MascFem CHAR(9) NOT NULL,
     Descricao VARCHAR(200),
     DataInicio DATE NOT NULL,
     DataFim DATE NOT NULL, 
     DuracaoPartida NUMBER(3),
     PracaEsportiva VARCHAR2(50) NOT NULL,
     CONSTRAINT PK_Modalidade PRIMARY KEY (Nome),
     CONSTRAINT FK_Modalidade FOREIGN KEY (PracaEsportiva) 
                                REFERENCES PracaEsportiva(Nome)
                                ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT CK_Modalidade CHECK (MascFem IN UPPER('MASCULINO', 'FEMININO'))
);

CREATE TABLE PracaEsportiva (
    Nome VARCHAR2(50) NOT NULL,
    Endereco VARCHAR2(50) NOT NULL,
    Area NUMBER(5) NOT NULL,
    Perimetro NUMBER(5),
    LotacaoMaxima NUMBER(5) NOT NULL,
    OlimpiadaSede VARCHAR(20) NOT NULL,
    OlimpiadaAno NUMBER(4) NOT NULL,
    CONSTRAINT PK_PracaEsportiva PRIMARY KEY (Nome),
    CONSTRAINT FK_PracaEsportiva FOREIGN KEY (OlimpiadaSede, OlimpiadaAno)
                                REFERENCES Olimpiada(Sede, Ano)
                                ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Disputa (
    idDisputa NUMBER(7) NOT NULL,
    Atleta1 NUMBER(10) NOT NULL,
    Atleta2 NUMBER(10) NOT NULL,
    Modalidade VARCHAR(20) NOT NULL,
    DataHora DATE NOT NULL,
    Vencedor NUMBER(10) NOT NULL,
    CONSTRAINT PK_Disputa PRIMARY KEY (idDisputa, Atleta1, Atleta2),
    CONSTRAINT FK1_Disputa FOREIGN KEY (Atleta1) REFERENCES Atleta(idAtleta)
                                        ON DELETE CASCADE ON UPDATE SET NULL,
    CONSTRAINT FK2_Disputa FOREIGN KEY (Atleta2) REFERENCES Atleta(idAtleta)
                                        ON DELETE CASCADE ON UPDATE SET NULL,
    CONSTRAINT FK3_Disputa FOREIGN KEY (Vencedor) REFERENCES Atleta(idAtleta)
                                        ON DELETE CASCADE ON UPDATE SET NULL,
    CONSTRAINT FK4_Disputa FOREIGN KEY (Modalidade) REFERENCES Modalidade(Nome)
                                        ON DELETE CASCADE ON UPDATE SET NULL,
    CONSTRAINT CK1_Disputa CHECK (Atleta1 != Atleta2),
    CONSTRAINT CK2_Disputa CHECK Vencedor IN (Atleta1, Atleta2)
);

CREATE TABLE Transmissora (
    Nome VARCHAR2(10) NOT NULL,
    Narrador VARCHAR2(40) NOT NULL,
    Canal NUMBER(3),
    Estacao VARCHAR2(5),
    Plataforma VARCHAR(10),
    CONSTRAINT PK_Transmissora PRIMARY KEY(Nome),
);

CREATE TABLE Transmissao (
    NomeTransmissora VARCHAR2(10) NOT NULL,
    idDisputa NUMBER(7) NOT NULL,
    CONSTRAINT PK_Transmissao PRIMARY KEY(NomeTransmissora, idDisputa),
    CONSTRAINT FK1_Transmissao FOREIGN KEY (NomeTransmissora) REFERENCES
                                Transmissora(Nome) ON DELETE CASCADE ON UPDATE
                                CASCADE,
    CONSTRAINT FK2_Transmissao FOREIGN KEY (idDisputa) REFERENCES 
                                Disputa(idDisputa) ON DELETE CASCADE 
                                ON UPDATE CASCADE
);

CREATE TABLE Patrocinio (
    Nome VARCHAR2(30) NOT NULL,
    Descricao VARCHAR2(200),
    AtletaPatrocinado NUMBER(10) NOT NULL,
    Pacote CHAR(8),
    Valor NUMBER(6) NOT NULL,
    CONSTRAINT PK_Patrocinio PRIMARY KEY (Nome, AtletaPatrocinado),
    CONSTRAINT FK_Patrocinio FOREIGN KEY (AtletaPatrocinado) 
                            REFERENCES Atleta(idAtleta) ON DELETE CASCADE
                            ON UPDATE SET NULL,
    CONSTRAINT CK_Patrocinio CHECK (Pacote IN UPPER('SILVER', 'GOLD', 'DIAMOND',
                                                  'PLATINUM'))
);

CREATE TABLE ProdutoPatrocinio(
    NomePatrocinio VARCHAR2(30) NOT NULL,
    Produto VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_ProdutoPatrocinio PRIMARY KEY (NomePatrocinio, Produto),
    CONSTRAINT FK_ProdutoPatrocinado FOREIGN KEY (NomePatrocinio) REFERENCES
                                    Patrocinio(Nome) ON DELETE CASCADE ON UPDATE
                                    CASCADE
); 

CREATE TABLE ModalidadeOlimpiada (
    Sede VARCHAR(20) NOT NULL,
    Ano NUMBER(4) NOT NULL,
    Modalidade VARCHAR(20) NOT NULL,
    CONSTRAINT PK_ModalidadeOlimpiada PRIMARY KEY (Sede, Ano, Modalidade)
    CONSTRAINT FK1_ModalidadeOlimpiada FOREIGN KEY (Sede, Ano) REFERENCES 
                                    Olimpiada(Sede, Ano) ON DELETE CASCADE 
                                    ON UPDATE CASCADE,
    CONSTRAINT FK2_ModalidadeOlimpiada FOREIGN KEY (Modalidade) REFERENCES 
                                    Modalidade(Nome) ON DELETE CASCADE 
                                    ON UPDATE CASCADE
);