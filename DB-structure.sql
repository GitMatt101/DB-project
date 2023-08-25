-- *********************************************
-- * Standard SQL generation                   
-- *--------------------------------------------
-- * DB-MAIN version: 11.0.2              
-- * Generator date: Sep 14 2021              
-- * Generation date: Fri Aug 25 19:02:16 2023 
-- * LUN file: C:\Users\Utente\Desktop\Mattia Università\Basi di Dati\DB-project\DB-Project.lun 
-- * Schema: esplorazioni/SQL 
-- ********************************************* 


-- Database Section
-- ________________ 

create database esplorazioni;

-- DBSpace Section
-- _______________

use esplorazioni;

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
     constraint ID_ASSOCIAZIONI_ID primary key (Nome));

create table avvistamenti (
     Codice varchar(10) not null,
     Numero decimal(2,0) not null,
     CodiceSpedizione varchar(10) not null,
     Profondita decimal(5,0),
     Note text,
     IDorganismo varchar(10),
     IDrelitto varchar(5),
     IDformazionegeologica varchar(5),
     constraint ID_AVVISTAMENTI_ID primary key (Codice),
     constraint SID_AVVISTAMENTI_ID unique (CodiceSpedizione, Numero));

create table case_produttrici (
     Nome char(30) not null,
     Indirizzo text not null,
     constraint ID_CASE_PRODUTTRICI_ID primary key (Nome));

create table tipologie (
     Nome char(50) not null,
     Descrizione text not null,
     constraint ID_TIPOLOGIE_ID primary key (Nome));

create table formazioni_geologiche (
     ID varchar(5) not null,
     Dimensioni decimal(6,0) not null,
     GradoPericolo decimal(1,0) not null,
     Descrizione text not null,
     Tipologia char(50) not null,
     constraint ID_FORMAZIONI_GEOLOGICHE_ID primary key (ID));

create table gruppi_di_esplorazione (
     NomeAssociazione char(30) not null,
     Nome char(30) not null,
     constraint ID_GRUPPI_DI_ESPLORAZIONE_ID primary key (NomeAssociazione, Nome));

create table laboratori (
     Nome char(30) not null,
     ID varchar(10) not null,
     Indirizzo text not null,
     constraint ID_LABORATORI_ID primary key (ID));

create table luoghi (
     Nome char(30) not null,
     NomePaese char(30),
     constraint ID_LUOGHI_ID primary key (Nome));

create table materiali (
     Nome char(30) not null,
     constraint ID_MATERIALI_ID primary key (Nome));

create table membri (
     Nome char(30) not null,
     Cognome char(30) not null,
     CodiceFiscale varchar(16) not null,
     ID varchar(5) not null,
     NomeAssociazione char(30) not null,
     NomeGruppo char(30) not null,
     Ruolo char(50) not null,
     constraint ID_MEMBRI_ID primary key (CodiceFiscale),
     constraint SID_MEMBRI_ID unique (NomeAssociazione, NomeGruppo, ID));

create table organismi (
     ID varchar(10) not null,
     Specie char(50),
     NomeProvvisorio char(50),
     NomeComune char(50),
     AnnoScoperta date not null,
     Descrizione text not null,
     constraint ID_ORGANISMI_ID primary key (ID),
     constraint SID_ORGANISMI_1_ID unique (Specie),
     constraint SID_ORGANISMI_ID unique (NomeProvvisorio));

create table paesi (
     Nome char(30) not null,
     constraint ID_PAESI_ID primary key (Nome));

create table prelievi (
     Codice varchar(10) not null,
     Numero decimal(2,0) not null,
     CodiceSpedizione varchar(10) not null,
     Profondita decimal(5,0),
     Note text,
     Quantita float(4,2) not null,
     NomeMateriale char(30) not null,
     constraint ID_PRELIEVI_ID primary key (Codice),
     constraint SID_PRELIEVI_ID unique (CodiceSpedizione, Numero));

create table relitti (
     ID varchar(5) not null,
     Nome char(50),
     AnnoAffondamento date,
     Dimensioni decimal(4,1) not null,
     Descrizione text not null,
     constraint ID_RELITTI_ID primary key (ID));

create table rov (
     Targa varchar(7) not null,
     NumeroSerie varchar(10) not null,
     NomeCasaProduttrice char(30) not null,
     DataProduzione date not null,
     constraint ID_ROV_ID primary key (Targa),
     constraint SID_ROV_ID unique (NomeCasaProduttrice, NumeroSerie));

create table ruoli (
     Tipo char(50) not null,
     Descrizione text not null,
     constraint ID_RUOLI_ID primary key (Tipo));

create table spedizioni (
     Codice varchar(10) not null,
     Data date not null,
     NomeAssociazione char(30) not null,
     NomeGruppo char(30) not null,
     NomeLuogo char(30) not null,
     TargaROV varchar(7) not null,
     constraint ID_SPEDIZIONI_ID primary key (Codice),
     constraint SID_SPEDIZIONI_ID unique (Data, NomeAssociazione, NomeGruppo));


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

alter table formazioni_geologiche add constraint REF_FORMA_TIPOL_FK
     foreign key (Tipologia)
     references tipologie(Nome);

alter table gruppi_di_esplorazione add constraint EQU_GRUPP_ASSOC
     foreign key (NomeAssociazione)
     references associazioni(Nome);

alter table luoghi add constraint EQU_LUOGHI_PAESI_FK
     foreign key (NomePaese)
     references paesi(Nome);

alter table membri add constraint EQU_MEMBR_GRUPP
     foreign key (NomeAssociazione, NomeGruppo)
     references gruppi_di_esplorazione(NomeAssociazione, Nome);

alter table membri add constraint REF_MEMBR_RUOLI_FK
     foreign key (Ruolo)
     references ruoli(Tipo);

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

alter table spedizioni add constraint REF_SPEDI_LUOGHI_FK
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

create unique index ID_ASSOCIAZIONI_IND
     on associazioni (Nome);

create unique index ID_AVVISTAMENTI_IND
     on avvistamenti (Codice);

create unique index SID_AVVISTAMENTI_IND
     on avvistamenti (CodiceSpedizione, Numero);

create index EQU_AVVIS_ORGAN_IND
     on avvistamenti (IDorganismo);

create index EQU_AVVIS_RELIT_IND
     on avvistamenti (IDrelitto);

create index EQU_AVVIS_FORMA_IND
     on avvistamenti (IDformazionegeologica);

create unique index ID_CASE_PRODUTTRICI_IND
     on case_produttrici (Nome);

create unique index ID_TIPOLOGIE_IND
     on tipologie (Nome);

create unique index ID_FORMAZIONI_GEOLOGICHE_IND
     on formazioni_geologiche (ID);

create index REF_FORMA_TIPOL_IND
     on formazioni_geologiche (Tipologia);

create unique index ID_GRUPPI_DI_ESPLORAZIONE_IND
     on gruppi_di_esplorazione (NomeAssociazione, Nome);

create unique index ID_LABORATORI_IND
     on laboratori (ID);

create unique index ID_LUOGHI_IND
     on luoghi (Nome);

create index EQU_LUOGHI_PAESI_IND
     on luoghi (NomePaese);

create unique index ID_MATERIALI_IND
     on materiali (Nome);

create unique index ID_MEMBRI_IND
     on membri (CodiceFiscale);

create unique index SID_MEMBRI_IND
     on membri (NomeAssociazione, NomeGruppo, ID);

create index REF_MEMBR_RUOLI_IND
     on membri (Ruolo);

create unique index ID_ORGANISMI_IND
     on organismi (ID);

create unique index SID_ORGANISMI_1_IND
     on organismi (Specie);

create unique index SID_ORGANISMI_IND
     on organismi (NomeProvvisorio);

create unique index ID_PAESI_IND
     on paesi (Nome);

create unique index ID_PRELIEVI_IND
     on prelievi (Codice);

create unique index SID_PRELIEVI_IND
     on prelievi (CodiceSpedizione, Numero);

create index EQU_PRELI_MATER_IND
     on prelievi (NomeMateriale);

create unique index ID_RELITTI_IND
     on relitti (ID);

create unique index ID_ROV_IND
     on rov (Targa);

create unique index SID_ROV_IND
     on rov (NomeCasaProduttrice, NumeroSerie);

create unique index ID_RUOLI_IND
     on ruoli (Tipo);

create unique index ID_SPEDIZIONI_IND
     on spedizioni (Codice);

create unique index SID_SPEDIZIONI_IND
     on spedizioni (Data, NomeAssociazione, NomeGruppo);

create index REF_SPEDI_GRUPP_IND
     on spedizioni (NomeAssociazione, NomeGruppo);

create index REF_SPEDI_LUOGHI_IND
     on spedizioni (NomeLuogo);

create index REF_SPEDI_ROV_IND
     on spedizioni (TargaROV);

