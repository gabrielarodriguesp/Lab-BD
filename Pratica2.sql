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
    CONSTRAINT CK_Pais CHECK (Continente IN ('ASIA', 'EUROPA', 'AMERICA',
                                                  'AFRICA', 'OCEANIA'))

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
    CONSTRAINT CK_Atleta CHECK (Genero IN ('MASCULINO', 'FEMININO'))
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
    CONSTRAINT CK_Modalidade CHECK (MascFem IN ('MASCULINO', 'FEMININO'))
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
    CONSTRAINT CK_Patrocinio CHECK (Pacote IN ('SILVER', 'GOLD', 'DIAMOND',
                                                  'PLATINUM'))
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





