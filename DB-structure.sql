-- *********************************************
-- * Standard SQL generation                   
-- *--------------------------------------------
-- * DB-MAIN version: 11.0.2              
-- * Generator date: Sep 14 2021              
-- * Generation date: Tue Aug 22 16:37:12 2023 
-- * LUN file: C:\Users\utente\Desktop\uni\2 anno\Basi di dati\DB-project\DB-Project.lun 
-- * Schema: esplorazioni/SQL 
-- ********************************************* 


-- Database Section
-- ________________ 

create database esplorazioni;
use esplorazioni;

-- DBSpace Section
-- _______________


-- Tables Section
-- _____________ 

create table analisi (
     Codice varchar(10) not null,
     CodicePrelievo varchar(10) not null,
     Descrizione text not null,
     IDlaboratorio varchar(10) not null,
     constraint ID_ANALISI_ID primary key (Codice),
     constraint SID_ANALI_PRELI_ID unique (CodicePrelievo));

create table associazioni (
     Nome char(30) not null,
     Indirizzo text not null,
     constraint ID_ASSOCIAZIONE_ID primary key (Nome));

create table avvistamenti (
     Codice varchar(10) not null,
     Numero decimal(2,0) not null,
     CodiceSpedizione varchar(10) not null,
     Profondita numeric(5),
     Note text,
     IDorganismo varchar(10),
     IDrelitto varchar(5),
     IDformazionegeologica varchar(5),
     constraint ID_AVVISTAMENTO_ID primary key (Codice),
     constraint SID_AVVISTAMENTO_ID unique (CodiceSpedizione, Numero));

create table case_produttrici (
     Nome char(30) not null,
     Indirizzo text not null,
     constraint ID_CASA_PRODUTTRICE_ID primary key (Nome));

create table formazioni_geologiche (
     ID varchar(5) not null,
     Tipologia char(30) not null,
     Dimensioni decimal(6,0) not null,
     GradoPericolo decimal(1,0) not null,
     Descrizione text not null,
     constraint ID_FORMAZIONE_GEOLOGICA_ID primary key (ID));

create table gruppi_di_esplorazione (
     NomeAssociazione char(30) not null,
     Nome char(30) not null,
     constraint ID_GRUPPO_DI_ESPLORAZIONE_ID primary key (NomeAssociazione, Nome));

create table laboratori (
     Nome char(30) not null,
     ID varchar(10) not null,
     Indirizzo text not null,
     constraint ID_LABORATORIO_ID primary key (ID));

create table luoghi (
     Nome char(30) not null,
     NomePaese char(30),
     constraint ID_LUOGO_ID primary key (Nome));

create table materiali (
     Nome char(30) not null,
     constraint ID_MATERIALE_ID primary key (Nome));

create table membri (
     Nome char(30) not null,
     Cognome char(30) not null,
     CodiceFiscale varchar(16) not null,
     ID varchar(5) not null,
     NomeAssociazione char(30) not null,
     NomeGruppo char(30) not null,
     Ruolo char(30) not null,
     constraint ID_MEMBRO_ID primary key (CodiceFiscale),
     constraint SID_MEMBRO_ID unique (NomeAssociazione, NomeGruppo, ID));

create table organismi (
     ID varchar(10) not null,
     Specie char(50),
     NomeProvvisorio char(50),
     NomeComune char(50),
     AnnoScoperta smallint not null,
     Descrizione text not null,
     constraint ID_ORGANISMO_ID primary key (ID),
     constraint SID_ORGANISMO_1_ID unique (Specie),
     constraint SID_ORGANISMO_ID unique (NomeProvvisorio));

create table paesi (
     Nome char(30) not null,
     constraint ID_PAESE_ID primary key (Nome));

create table prelievi (
     Codice varchar(10) not null,
     Numero decimal(2,0) not null,
     CodiceSpedizione varchar(10) not null,
     Profondita numeric(5),
     Note text,
     Quantita float(2,2) not null,
     NomeMateriale char(30) not null,
     constraint ID_PRELIEVO_ID primary key (Codice),
     constraint SID_PRELIEVO_ID unique (CodiceSpedizione, Numero));

create table relitti (
     ID varchar(5) not null,
     Nome char(50),
     AnnoAffondamento date,
     Dimensioni decimal(4,1) not null,
     Descrizione text not null,
     constraint ID_RELITTO_ID primary key (ID));

create table rov (
     Targa varchar(7) not null,
     NumeroSerie varchar(10) not null,
     NomeCasaProduttrice char(30) not null,
     DataProduzione date not null,
     constraint ID_ROV_ID primary key (Targa),
     constraint SID_ROV_ID unique (NomeCasaProduttrice, NumeroSerie));

create table spedizioni (
     Codice varchar(10) not null,
     Data date not null,
     NomeAssociazione char(30) not null,
     NomeGruppo char(30) not null,
     NomeLuogo char(30) not null,
     TargaROV varchar(7) not null,
     constraint ID_SPEDIZIONE_ID primary key (Codice),
     constraint SID_SPEDIZIONE_ID unique (Data, NomeAssociazione, NomeGruppo));


-- Constraints Section
-- ___________________ 

alter table analisi add constraint SID_ANALI_PRELI_FK
     foreign key (CodicePrelievo)
     references prelievi(Codice);

alter table analisi add constraint EQU_ANALI_LABOR_FK
     foreign key (IDlaboratorio)
     references laboratori(ID); 

alter table avvistamenti add constraint REF_AVVIS_SPEDI
     foreign key (CodiceSpedizione)
     references spedizioni(Codice);

alter table avvistamenti add constraint EQU_AVVIS_ORGAN_FK
     foreign key (IDorganismo)
     references organismi(ID);

alter table avvistamenti add constraint EQU_AVVIS_RELIT_FK
     foreign key (IDrelitto)
     references relitti(ID);

alter table avvistamenti add constraint EQU_AVVIS_FORMA_FK
     foreign key (IDformazionegeologica)
     references formazioni_geologiche(ID);

alter table gruppi_di_esplorazione add constraint EQU_GRUPP_ASSOC
     foreign key (NomeAssociazione)
     references associazioni(Nome);

alter table luoghi add constraint EQU_LUOGO_PAESE_FK
     foreign key (NomePaese)
     references paesi(Nome);

alter table membri add constraint EQU_MEMBR_GRUPP
     foreign key (NomeAssociazione, Nomegruppo)
     references gruppi_di_esplorazione(NomeAssociazione, Nome);

alter table prelievi add constraint EQU_PRELI_MATER_FK
     foreign key (NomeMateriale)
     references materiali(Nome);

alter table prelievi add constraint REF_PRELI_SPEDI
     foreign key (CodiceSpedizione)
     references spedizioni(Codice);

alter table rov add constraint REF_ROV_CASA_
     foreign key (NomeCasaProduttrice)
     references case_produttrici(Nome);

alter table spedizioni add constraint REF_SPEDI_GRUPP_FK
     foreign key (NomeAssociazione, NomeGruppo)
     references gruppi_di_esplorazione(NomeAssociazione, Nome);

alter table spedizioni add constraint REF_SPEDI_LUOGO_FK
     foreign key (NomeLuogo)
     references luoghi(Nome);

alter table spedizioni add constraint REF_SPEDI_ROV_FK
     foreign key (TargaROV)
     references rov(Targa);


-- Index Section
-- _____________ 

create unique index ID_ANALISI_IND
     on analisi (Codice);

create unique index SID_ANALI_PRELI_IND
     on analisi (CodicePrelievo);

create index EQU_ANALI_LABOR_IND
     on analisi (IDlaboratorio);

create unique index ID_ASSOCIAZIONE_IND
     on associazioni (Nome);

create unique index ID_AVVISTAMENTO_IND
     on avvistamenti (Codice);

create unique index SID_AVVISTAMENTO_IND
     on avvistamenti (CodiceSpedizione, Numero);

create index EQU_AVVIS_ORGAN_IND
     on avvistamenti (IDorganismo);

create index EQU_AVVIS_RELIT_IND
     on avvistamenti (IDrelitto);

create index EQU_AVVIS_FORMA_IND
     on avvistamenti (IDformazionegeologica);

create unique index ID_CASA_PRODUTTRICE_IND
     on case_produttrici (Nome);

create unique index ID_FORMAZIONE_GEOLOGICA_IND
     on formazioni_geologiche (ID);

create unique index ID_GRUPPO_DI_ESPLORAZIONE_IND
     on gruppi_di_esplorazione (NomeAssociazione, Nome);

create unique index ID_LABORATORIO_IND
     on laboratori (ID);

create unique index ID_LUOGO_IND
     on luoghi (Nome);

create index EQU_LUOGO_PAESE_IND
     on luoghi (NomePaese);

create unique index ID_MATERIALE_IND
     on materiali (Nome);

create unique index ID_MEMBRO_IND
     on membri (CodiceFiscale);

create unique index SID_MEMBRO_IND
     on membri (NomeAssociazione, NomeGruppo, ID);

create unique index ID_ORGANISMO_IND
     on organismi (ID);

create unique index SID_ORGANISMO_1_IND
     on organismi (Specie);

create unique index SID_ORGANISMO_IND
     on organismi (NomeProvvisorio);

create unique index ID_PAESE_IND
     on paesi (Nome);

create unique index ID_PRELIEVO_IND
     on prelievi (Codice);

create unique index SID_PRELIEVO_IND
     on prelievi (CodiceSpedizione, Numero);

create index EQU_PRELI_MATER_IND
     on prelievi (NomeMateriale);

create unique index ID_RELITTO_IND
     on relitti (ID);

create unique index ID_ROV_IND
     on rov (Targa);

create unique index SID_ROV_IND
     on rov (NomeCasaProduttrice, NumeroSerie);

create unique index ID_SPEDIZIONE_IND
     on spedizioni (Codice);

create unique index SID_SPEDIZIONE_IND
     on spedizioni (Data, NomeAssociazione, NomeGruppo);

create index REF_SPEDI_GRUPP_IND
     on spedizioni (NomeAssociazione, NomeGruppo);

create index REF_SPEDI_LUOGO_IND
     on spedizioni (NomeLuogo);

create index REF_SPEDI_ROV_IND
     on spedizioni (TargaROV);

