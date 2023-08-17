-- *********************************************
-- * Standard SQL generation                   
-- *--------------------------------------------
-- * DB-MAIN version: 11.0.2              
-- * Generator date: Sep 14 2021              
-- * Generation date: Thu Aug 17 11:35:55 2023 
-- * LUN file: C:\Users\utente\Desktop\uni\2 anno\Basi di dati\DB-project\DB-Project.lun 
-- * Schema: spedizioni/SQL 
-- ********************************************* 


-- Database Section
-- ________________ 

create database spedizioni;

-- DBSpace Section
-- _______________

use spedizioni;

-- Tables Section
-- _____________ 

create table analisi (
     Codice varchar(10) not null,
     CodicePrelievo varchar(10) not null,
     Descrizione text not null,
     IDlaboratorio varchar(10) not null,
     constraint ID_ANALISI_ID primary key (Codice),
     constraint SID_ANALI_PRELI_ID unique (CodicePrelievo));

create table associazione (
     Nome char(30) not null,
     Indirizzo text not null,
     constraint ID_ASSOCIAZIONE_ID primary key (Nome));

create table avvistamento (
     Codice varchar(10) not null,
     Numero decimal(2,0) not null,
     CodiceSpedizione varchar(10) not null,
     Profondita decimal(5,0),
     Note text,
     IDorganismo varchar(10),
     IDrelitto varchar(5),
     IDformazionegeologica varchar(5),
     constraint ID_AVVISTAMENTO_ID primary key (Codice),
     constraint SID_AVVISTAMENTO_ID unique (CodiceSpedizione, Numero));

create table casa_produttrice (
     Nome char(30) not null,
     Indirizzo text not null,
     constraint ID_CASA_PRODUTTRICE_ID primary key (Nome));

create table formazione_geologica (
     ID varchar(5) not null,
     Tipologia char(30) not null,
     Dimensioni decimal(5,0) not null,
     GradoPericolo decimal(1,0) not null,
     Descrizione text not null,
     constraint ID_FORMAZIONE_GEOLOGICA_ID primary key (ID));

create table gruppo_di_esplorazione (
     NomeAssociazione char(30) not null,
     ID varchar(5) not null,
     Nome char(30) not null,
     constraint ID_GRUPPO_DI_ESPLORAZIONE_ID primary key (NomeAssociazione, ID));

create table laboratorio (
     Nome char(30) not null,
     ID varchar(10) not null,
     Indirizzo text not null,
     constraint ID_LABORATORIO_ID primary key (ID));

create table luogo (
     Nome char(30) not null,
     NomePaese char(30),
     constraint ID_LUOGO_ID primary key (Nome));

create table materiale (
     Nome char(30) not null,
     constraint ID_MATERIALE_ID primary key (Nome));

create table membro (
     Nome char(30) not null,
     Cognome char(30) not null,
     CodiceFiscale varchar(16) not null,
     ID varchar(5) not null,
     NomeAssociazione char(30) not null,
     IDgruppo varchar(5) not null,
     Ruolo char(30) not null,
     constraint ID_MEMBRO_ID primary key (CodiceFiscale),
     constraint SID_MEMBRO_ID unique (NomeAssociazione, IDgruppo, ID));

create table organismo (
     ID varchar(10) not null,
     Specie char(50),
     NomeProvvisorio char(50),
     NomeComune char(50),
     Descrizione text not null,
     constraint ID_ORGANISMO_ID primary key (ID),
     constraint SID_ORGANISMO_1_ID unique (Specie),
     constraint SID_ORGANISMO_ID unique (NomeProvvisorio));

create table paese (
     Nome char(30) not null,
     constraint ID_PAESE_ID primary key (Nome));

create table prelievo (
     Codice varchar(10) not null,
     Numero decimal(2,0) not null,
     CodiceSpedizione varchar(10) not null,
     Profondita decimal(5,0),
     Note text,
     Quantita float(4,2) not null,
     NomeMateriale char(30) not null,
     constraint ID_PRELIEVO_ID primary key (Codice),
     constraint SID_PRELIEVO_ID unique (CodiceSpedizione, Numero));

create table relitto (
     ID varchar(5) not null,
     Nome char(50),
     DataAffondamento date,
     Dimensioni decimal(3,0) not null,
     Descrizione text not null,
     constraint ID_RELITTO_ID primary key (ID));

create table rov (
     Targa varchar(7) not null,
     NumeroSerie varchar(10) not null,
     NomeCasaProduttrice char(30) not null,
     DataProduzione date not null,
     constraint ID_ROV_ID primary key (Targa),
     constraint SID_ROV_ID unique (NomeCasaProduttrice, NumeroSerie));

create table spedizione (
     Codice varchar(10) not null,
     Data date not null,
     NomeAssociazione char(30) not null,
     IDgruppo varchar(5) not null,
     NomeLuogo char(30) not null,
     TargaROV varchar(7) not null,
     constraint ID_SPEDIZIONE_ID primary key (Codice),
     constraint SID_SPEDIZIONE_ID unique (Data, NomeAssociazione, IDgruppo));


-- Constraints Section
-- ___________________ 

alter table analisi add constraint SID_ANALI_PRELI_FK
     foreign key (CodicePrelievo)
     references prelievo(Codice);

alter table analisi add constraint EQU_ANALI_LABOR_FK
     foreign key (IDlaboratorio)
     references laboratorio(ID);

alter table avvistamento add constraint REF_AVVIS_SPEDI
     foreign key (CodiceSpedizione)
     references spedizione(Codice);

alter table avvistamento add constraint EQU_AVVIS_ORGAN_FK
     foreign key (IDorganismo)
     references organismo(ID);

alter table avvistamento add constraint EQU_AVVIS_RELIT_FK
     foreign key (IDrelitto)
     references relitto(ID);

alter table avvistamento add constraint EQU_AVVIS_FORMA_FK
     foreign key (IDformazionegeologica)
     references formazione_geologica(ID);

alter table gruppo_di_esplorazione add constraint EQU_GRUPP_ASSOC
     foreign key (NomeAssociazione)
     references associazione(Nome);

alter table luogo add constraint EQU_LUOGO_PAESE_FK
     foreign key (NomePaese)
     references paese(Nome);

alter table membro add constraint EQU_MEMBR_GRUPP
     foreign key (NomeAssociazione, IDgruppo)
     references gruppo_di_esplorazione(NomeAssociazione, ID);

alter table prelievo add constraint EQU_PRELI_MATER_FK
     foreign key (NomeMateriale)
     references materiale(Nome);

alter table prelievo add constraint REF_PRELI_SPEDI
     foreign key (CodiceSpedizione)
     references spedizione(Codice);

alter table rov add constraint REF_ROV_CASA_
     foreign key (NomeCasaProduttrice)
     references casa_produttrice(Nome);

alter table spedizione add constraint REF_SPEDI_GRUPP_FK
     foreign key (NomeAssociazione, IDgruppo)
     references gruppo_di_esplorazione(NomeAssociazione, ID);

alter table spedizione add constraint REF_SPEDI_LUOGO_FK
     foreign key (NomeLuogo)
     references luogo(Nome);

alter table spedizione add constraint REF_SPEDI_ROV_FK
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
     on associazione (Nome);

create unique index ID_AVVISTAMENTO_IND
     on avvistamento (Codice);

create unique index SID_AVVISTAMENTO_IND
     on avvistamento (CodiceSpedizione, Numero);

create index EQU_AVVIS_ORGAN_IND
     on avvistamento (IDorganismo);

create index EQU_AVVIS_RELIT_IND
     on avvistamento (IDrelitto);

create index EQU_AVVIS_FORMA_IND
     on avvistamento (IDformazionegeologica);

create unique index ID_CASA_PRODUTTRICE_IND
     on casa_produttrice (Nome);

create unique index ID_FORMAZIONE_GEOLOGICA_IND
     on formazione_geologica (ID);

create unique index ID_GRUPPO_DI_ESPLORAZIONE_IND
     on gruppo_di_esplorazione (NomeAssociazione, ID);

create unique index ID_LABORATORIO_IND
     on laboratorio (ID);

create unique index ID_LUOGO_IND
     on luogo (Nome);

create index EQU_LUOGO_PAESE_IND
     on luogo (NomePaese);

create unique index ID_MATERIALE_IND
     on materiale (Nome);

create unique index ID_MEMBRO_IND
     on membro (CodiceFiscale);

create unique index SID_MEMBRO_IND
     on membro (NomeAssociazione, IDgruppo, ID);

create unique index ID_ORGANISMO_IND
     on organismo (ID);

create unique index SID_ORGANISMO_1_IND
     on organismo (Specie);

create unique index SID_ORGANISMO_IND
     on organismo (NomeProvvisorio);

create unique index ID_PAESE_IND
     on paese (Nome);

create unique index ID_PRELIEVO_IND
     on prelievo (Codice);

create unique index SID_PRELIEVO_IND
     on prelievo (CodiceSpedizione, Numero);

create index EQU_PRELI_MATER_IND
     on prelievo (NomeMateriale);

create unique index ID_RELITTO_IND
     on relitto (ID);

create unique index ID_ROV_IND
     on rov (Targa);

create unique index SID_ROV_IND
     on rov (NomeCasaProduttrice, NumeroSerie);

create unique index ID_SPEDIZIONE_IND
     on spedizione (Codice);

create unique index SID_SPEDIZIONE_IND
     on spedizione (Data, NomeAssociazione, IDgruppo);

create index REF_SPEDI_GRUPP_IND
     on spedizione (NomeAssociazione, IDgruppo);

create index REF_SPEDI_LUOGO_IND
     on spedizione (NomeLuogo);

create index REF_SPEDI_ROV_IND
     on spedizione (TargaROV);

