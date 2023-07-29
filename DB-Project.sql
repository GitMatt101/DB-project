-- *********************************************
-- * Standard SQL generation                   
-- *--------------------------------------------
-- * DB-MAIN version: 11.0.2              
-- * Generator date: Sep 14 2021              
-- * Generation date: Sat Jul 29 12:52:53 2023 
-- * LUN file: C:\Users\Utente\Desktop\Mattia Università\Basi di Dati\DB-project\DB-Project.lun 
-- * Schema: Spedizioni/SQL 
-- ********************************************* 


-- Database Section
-- ________________ 

create database spedizioni;


-- DBSpace Section
-- _______________


-- Tables Section
-- _____________ 

create table spedizioni.analisi (
     CodiceAnalisi varchar(10) not null,
     CodicePrelievo varchar(10) not null,
     Descrizione text not null,
     IDlaboratorio varchar(10) not null,
     constraint ID_ANALISI_ID primary key (CodiceAnalisi),
     constraint SID_ANALI_PRELI_ID unique (CodicePrelievo));

create table spedizioni.associazione (
     Nome char(30) not null,
     Citta char(25) not null,
     Via_Piazza char(25) not null,
     Numero_civico numeric(6) not null,
     constraint ID_ASSOCIAZIONE_ID primary key (Nome));

create table spedizioni.avvistamento (
     Codice varchar(10) not null,
     Numero tinyint not null,
     Profondita smallint,
     Foto char(1) not null,
     Note text,
     IDrelitto varchar(5),
     NomeFormazioneGeologica char(30),
     IDorganismo varchar(10),
     CodiceSpedizione varchar(10) not null,
     constraint ID_AVVISTAMENTO_ID primary key (Codice));

create table spedizioni.casa_produttrice (
     Nome char(30) not null,
     Citta char(25) not null,
     Via_Piazza char(25) not null,
     Numero_civico numeric(6) not null,
     constraint ID_CASA_PRODUTTRICE_ID primary key (Nome));

create table spedizioni.formazione_geologica (
     Nome char(30) not null,
     Dimensioni numeric(1) not null,
     Grado_di_pericolo numeric(1) not null,
     Descrizione text not null,
     constraint ID_FORMAZIONE_GEOLOGICA_ID primary key (Nome));

create table spedizioni.gruppo_di_esplorazione (
     NomeAssociazione char(30) not null,
     ID varchar(5) not null,
     Nome_gruppo char(20) not null,
     constraint ID_GRUPPO_DI_ESPLORAZIONE_ID primary key (NomeAssociazione, ID));

create table spedizioni.laboratorio (
     Nome char(30) not null,
     ID varchar(10) not null,
     Citta char(25) not null,
     Via_Piazza char(25) not null,
     Numero_civico numeric(6) not null,
     constraint ID_LABORATORIO_ID primary key (ID));

create table spedizioni.luogo (
     Nome char(30) not null,
     NomePaese char(30),
     constraint ID_LUOGO_ID primary key (Nome));

create table spedizioni.materiale (
     Nome char(30) not null,
     constraint ID_MATERIALE_ID primary key (Nome));

create table spedizioni.operatore (
     Nome char(1) not null,
     Cognome char(1) not null,
     Codice_Fiscale char(1) not null,
     ID varchar(5) not null,
     NomeAssociazione char(30) not null,
     IDgruppo varchar(5) not null,
     constraint ID_OPERATORE_ID primary key (Codice_Fiscale),
     constraint SID_OPERATORE_ID unique (NomeAssociazione, IDgruppo, ID));

create table spedizioni.organismo (
     ID varchar(10) not null,
     Specie char(30),
     Nome_provvisorio char(30),
     Nome_comune char(30),
     Descrizione text not null,
     constraint SID_ORGANISMO_1_ID unique (Specie),
     constraint SID_ORGANISMO_ID unique (Nome_provvisorio),
     constraint ID_ORGANISMO_ID primary key (ID));

create table spedizioni.paese (
     Nome char(30) not null,
     constraint ID_PAESE_ID primary key (Nome));

create table spedizioni.prelievo (
     Codice varchar(10) not null,
     Numero tinyint not null,
     Profondita smallint,
     Quantita float not null,
     Note text,
     CodiceSpedizione varchar(10) not null,
     NomeMateriale char(30) not null,
     constraint ID_PRELIEVO_ID primary key (Codice));

create table spedizioni.relitto (
     ID varchar(5) not null,
     Nome char(30),
     Data_affondamento_stimata date,
     Dimensioni numeric(1) not null,
     Descrizione text not null,
     constraint ID_RELITTO_ID primary key (ID));

create table spedizioni.rov (
     Targa varchar(7) not null,
     Numero_di_serie varchar(10) not null,
     NomeCasaProduttrice char(30) not null,
     DataProduzione date not null,
     constraint ID_ROV_ID primary key (Targa),
     constraint SID_ROV_ID unique (NomeCasaProduttrice, Numero_di_serie));

create table spedizioni.spedizione (
     Codice varchar(10) not null,
     Data date not null,
     NomeLuogo char(30) not null,
     TargaROV varchar(7) not null,
     NomeAssociazione char(30) not null,
     IDgruppo varchar(5) not null,
     constraint ID_SPEDIZIONE_ID primary key (Codice));


-- Constraints Section
-- ___________________ 

alter table spedizioni.analisi add constraint SID_ANALI_PRELI_FK
     foreign key (CodicePrelievo)
     references spedizioni.prelievo(Codice);

alter table spedizioni.analisi add constraint EQU_ANALI_LABOR_FK
     foreign key (IDlaboratorio)
     references spedizioni.laboratorio(ID);

-- alter table spedizioni.associazione add constraint ID_ASSOCIAZIONE_CHK
--     check(exists(select * from spedizioni.gruppo_di_esplorazione
--                  where spedizioni.gruppo_di_esplorazione.NomeAssociazione = Nome)); 

alter table spedizioni.avvistamento add constraint EQU_AVVIS_RELIT_FK
     foreign key (IDrelitto)
     references spedizioni.relitto(ID);

alter table spedizioni.avvistamento add constraint EQU_AVVIS_FORMA_FK
     foreign key (NomeFormazioneGeologica)
     references spedizioni.formazione_geologica(Nome);

alter table spedizioni.avvistamento add constraint EQU_AVVIS_ORGAN_FK
     foreign key (IDorganismo)
     references spedizioni.organismo(ID);

alter table spedizioni.avvistamento add constraint REF_AVVIS_SPEDI_FK
     foreign key (CodiceSpedizione)
     references spedizioni.spedizione(Codice);

-- alter table spedizioni.formazione_geologica add constraint ID_FORMAZIONE_GEOLOGICA_CHK
--     check(exists(select * from spedizioni.avvistamento
--                  where spedizioni.avvistamento.NomeFormazioneGeologica = Nome)); 

-- alter table spedizioni.gruppo_di_esplorazione add constraint ID_GRUPPO_DI_ESPLORAZIONE_CHK
--     check(exists(select * from spedizioni.operatore
--                  where spedizioni.operatore.NomeAssociazione = NomeAssociazione and spedizioni.operatore.IDgruppo = ID)); 

alter table spedizioni.gruppo_di_esplorazione add constraint EQU_GRUPP_ASSOC
     foreign key (NomeAssociazione)
     references spedizioni.associazione(Nome);

-- alter table spedizioni.laboratorio add constraint ID_LABORATORIO_CHK
--     check(exists(select * from spedizioni.analisi
--                  where spedizioni.analisi.IDlaboratorio = ID)); 

alter table spedizioni.luogo add constraint EQU_LUOGO_PAESE_FK
     foreign key (NomePaese)
     references spedizioni.paese(Nome);

-- alter table spedizioni.materiale add constraint ID_MATERIALE_CHK
--     check(exists(select * from spedizioni.prelievo
--                  where spedizioni.prelievo.NomeMateriale = Nome)); 

alter table spedizioni.operatore add constraint EQU_OPERA_GRUPP
     foreign key (NomeAssociazione, IDgruppo)
     references spedizioni.gruppo_di_esplorazione(NomeAssociazione, ID);

-- alter table spedizioni.organismo add constraint ID_ORGANISMO_CHK
--     check(exists(select * from spedizioni.avvistamento
--                  where spedizioni.avvistamento.IDorganismo = ID)); 

-- alter table spedizioni.paese add constraint ID_PAESE_CHK
--     check(exists(select * from spedizioni.luogo
--                  where spedizioni.luogo.NomePaese = Nome)); 

-- alter table spedizioni.prelievo add constraint ID_PRELIEVO_CHK
--     check(exists(select * from spedizioni.analisi
--                  where spedizioni.analisi.CodicePrelievo = Codice)); 

alter table spedizioni.prelievo add constraint REF_PRELI_SPEDI_FK
     foreign key (CodiceSpedizione)
     references spedizioni.spedizione(Codice);

alter table spedizioni.prelievo add constraint EQU_PRELI_MATER_FK
     foreign key (NomeMateriale)
     references spedizioni.materiale(Nome);

-- alter table spedizioni.relitto add constraint ID_RELITTO_CHK
--     check(exists(select * from spedizioni.avvistamento
--                  where spedizioni.avvistamento.IDrelitto = ID)); 

alter table spedizioni.rov add constraint REF_ROV_CASA_
     foreign key (NomeCasaProduttrice)
     references spedizioni.casa_produttrice(Nome);

alter table spedizioni.spedizione add constraint REF_SPEDI_LUOGO_FK
     foreign key (NomeLuogo)
     references spedizioni.luogo(Nome);

alter table spedizioni.spedizione add constraint REF_SPEDI_ROV_FK
     foreign key (TargaROV)
     references spedizioni.rov(Targa);

alter table spedizioni.spedizione add constraint REF_SPEDI_GRUPP_FK
     foreign key (NomeAssociazione, IDgruppo)
     references spedizioni.gruppo_di_esplorazione(NomeAssociazione, ID);


-- Index Section
-- _____________ 

create unique index ID_ANALISI_IND
     on spedizioni.analisi (CodiceAnalisi);

create unique index SID_ANALI_PRELI_IND
     on spedizioni.analisi (CodicePrelievo);

create index EQU_ANALI_LABOR_IND
     on spedizioni.analisi (IDlaboratorio);

create unique index ID_ASSOCIAZIONE_IND
     on spedizioni.associazione (Nome);

create unique index ID_AVVISTAMENTO_IND
     on spedizioni.avvistamento (Codice);

create index EQU_AVVIS_RELIT_IND
     on spedizioni.avvistamento (IDrelitto);

create index EQU_AVVIS_FORMA_IND
     on spedizioni.avvistamento (NomeFormazioneGeologica);

create index EQU_AVVIS_ORGAN_IND
     on spedizioni.avvistamento (IDorganismo);

create index REF_AVVIS_SPEDI_IND
     on spedizioni.avvistamento (CodiceSpedizione);

create unique index ID_CASA_PRODUTTRICE_IND
     on spedizioni.casa_produttrice (Nome);

create unique index ID_FORMAZIONE_GEOLOGICA_IND
     on spedizioni.formazione_geologica (Nome);

create unique index ID_GRUPPO_DI_ESPLORAZIONE_IND
     on spedizioni.gruppo_di_esplorazione (NomeAssociazione, ID);

create unique index ID_LABORATORIO_IND
     on spedizioni.laboratorio (ID);

create unique index ID_LUOGO_IND
     on spedizioni.luogo (Nome);

create index EQU_LUOGO_PAESE_IND
     on spedizioni.luogo (NomePaese);

create unique index ID_MATERIALE_IND
     on spedizioni.materiale (Nome);

create unique index ID_OPERATORE_IND
     on spedizioni.operatore (Codice_Fiscale);

create unique index SID_OPERATORE_IND
     on spedizioni.operatore (NomeAssociazione, IDgruppo, ID);

create unique index SID_ORGANISMO_1_IND
     on spedizioni.organismo (Specie);

create unique index SID_ORGANISMO_IND
     on spedizioni.organismo (Nome_provvisorio);

create unique index ID_ORGANISMO_IND
     on spedizioni.organismo (ID);

create unique index ID_PAESE_IND
     on spedizioni.paese (Nome);

create unique index ID_PRELIEVO_IND
     on spedizioni.prelievo (Codice);

create index REF_PRELI_SPEDI_IND
     on spedizioni.prelievo (CodiceSpedizione);

create index EQU_PRELI_MATER_IND
     on spedizioni.prelievo (NomeMateriale);

create unique index ID_RELITTO_IND
     on spedizioni.relitto (ID);

create unique index ID_ROV_IND
     on spedizioni.rov (Targa);

create unique index SID_ROV_IND
     on spedizioni.rov (NomeCasaProduttrice, Numero_di_serie);

create unique index ID_SPEDIZIONE_IND
     on spedizioni.spedizione (Codice);

create index REF_SPEDI_LUOGO_IND
     on spedizioni.spedizione (NomeLuogo);

create index REF_SPEDI_ROV_IND
     on spedizioni.spedizione (TargaROV);

create index REF_SPEDI_GRUPP_IND
     on spedizioni.spedizione (NomeAssociazione, IDgruppo);

