-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: spedizioni
-- ------------------------------------------------------
-- Server version	8.0.34

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `analisi`
--

DROP TABLE IF EXISTS `analisi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analisi` (
  `CodiceAnalisi` varchar(10) NOT NULL,
  `CodicePrelievo` varchar(10) NOT NULL,
  `Descrizione` text NOT NULL,
  `IDlaboratorio` varchar(10) NOT NULL,
  PRIMARY KEY (`CodiceAnalisi`),
  UNIQUE KEY `SID_ANALI_PRELI_ID` (`CodicePrelievo`),
  UNIQUE KEY `ID_ANALISI_IND` (`CodiceAnalisi`),
  UNIQUE KEY `SID_ANALI_PRELI_IND` (`CodicePrelievo`),
  KEY `EQU_ANALI_LABOR_IND` (`IDlaboratorio`),
  CONSTRAINT `EQU_ANALI_LABOR_FK` FOREIGN KEY (`IDlaboratorio`) REFERENCES `laboratorio` (`ID`),
  CONSTRAINT `SID_ANALI_PRELI_FK` FOREIGN KEY (`CodicePrelievo`) REFERENCES `prelievo` (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analisi`
--

LOCK TABLES `analisi` WRITE;
/*!40000 ALTER TABLE `analisi` DISABLE KEYS */;
/*!40000 ALTER TABLE `analisi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `associazione`
--

DROP TABLE IF EXISTS `associazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `associazione` (
  `Nome` char(30) NOT NULL,
  `Indirizzo` varchar(100) NOT NULL,
  PRIMARY KEY (`Nome`),
  UNIQUE KEY `ID_ASSOCIAZIONE_IND` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `associazione`
--

LOCK TABLES `associazione` WRITE;
/*!40000 ALTER TABLE `associazione` DISABLE KEYS */;
INSERT INTO `associazione` VALUES ('JAMSTEC','2-15 Natsushimacho, Yokosuka, Kanagawa 237-0061, Giappone'),('NOAA','Herbert C. Hoover Building, 1401 Constitution Ave. NW, Washington, DC 20230, Stati Uniti'),('Ocean Exploration Trust','2500 Signal St, San Pedro, CA 90731, Stati Uniti'),('OceanX AG','Fluhgasse 135, 5080 Laufenburg, Svizzera'),('Odyssey Marine Exploration','205 S. Hoover Blvd, Suite 210, Tampa, FL 33609, Stati Uniti');
/*!40000 ALTER TABLE `associazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avvistamento`
--

DROP TABLE IF EXISTS `avvistamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avvistamento` (
  `Codice` varchar(10) NOT NULL,
  `Numero` tinyint NOT NULL,
  `Profondita` smallint DEFAULT NULL,
  `Foto` char(1) NOT NULL,
  `Note` text,
  `IDrelitto` varchar(5) DEFAULT NULL,
  `NomeFormazioneGeologica` char(30) DEFAULT NULL,
  `IDorganismo` varchar(10) DEFAULT NULL,
  `CodiceSpedizione` varchar(10) NOT NULL,
  PRIMARY KEY (`Codice`),
  UNIQUE KEY `ID_AVVISTAMENTO_IND` (`Codice`),
  KEY `EQU_AVVIS_RELIT_IND` (`IDrelitto`),
  KEY `EQU_AVVIS_FORMA_IND` (`NomeFormazioneGeologica`),
  KEY `EQU_AVVIS_ORGAN_IND` (`IDorganismo`),
  KEY `REF_AVVIS_SPEDI_IND` (`CodiceSpedizione`),
  CONSTRAINT `EQU_AVVIS_FORMA_FK` FOREIGN KEY (`NomeFormazioneGeologica`) REFERENCES `formazione_geologica` (`Nome`),
  CONSTRAINT `EQU_AVVIS_ORGAN_FK` FOREIGN KEY (`IDorganismo`) REFERENCES `organismo` (`ID`),
  CONSTRAINT `EQU_AVVIS_RELIT_FK` FOREIGN KEY (`IDrelitto`) REFERENCES `relitto` (`ID`),
  CONSTRAINT `REF_AVVIS_SPEDI_FK` FOREIGN KEY (`CodiceSpedizione`) REFERENCES `spedizione` (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avvistamento`
--

LOCK TABLES `avvistamento` WRITE;
/*!40000 ALTER TABLE `avvistamento` DISABLE KEYS */;
/*!40000 ALTER TABLE `avvistamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `casa_produttrice`
--

DROP TABLE IF EXISTS `casa_produttrice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `casa_produttrice` (
  `Nome` char(30) NOT NULL,
  `Indirizzo` varchar(100) NOT NULL,
  PRIMARY KEY (`Nome`),
  UNIQUE KEY `ID_CASA_PRODUTTRICE_IND` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `casa_produttrice`
--

LOCK TABLES `casa_produttrice` WRITE;
/*!40000 ALTER TABLE `casa_produttrice` DISABLE KEYS */;
INSERT INTO `casa_produttrice` VALUES ('Blue Robotics Inc.','2740 California St, Torrance, CA 90503, Stati Uniti'),('EyeROV','Maker Village,Kerala Technology Innovation Zone, Kalamassery, Kochi, Kerala 683503, India'),('Oceaneering','5875 North Sam Houston Pkwy W #400, Houston, TX 77086, Stati Uniti'),('Seatrepid International','23083 U.S. Hwy 190, Robert, LA 70455, Stati Uniti'),('VideoRay','580 Wall St, Phoenixville, PA 19460, Stati Uniti');
/*!40000 ALTER TABLE `casa_produttrice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formazione_geologica`
--

DROP TABLE IF EXISTS `formazione_geologica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formazione_geologica` (
  `Nome` char(30) NOT NULL,
  `Dimensioni` decimal(1,0) NOT NULL,
  `Grado_di_pericolo` decimal(1,0) NOT NULL,
  `Descrizione` text NOT NULL,
  PRIMARY KEY (`Nome`),
  UNIQUE KEY `ID_FORMAZIONE_GEOLOGICA_IND` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formazione_geologica`
--

LOCK TABLES `formazione_geologica` WRITE;
/*!40000 ALTER TABLE `formazione_geologica` DISABLE KEYS */;
/*!40000 ALTER TABLE `formazione_geologica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gruppo_di_esplorazione`
--

DROP TABLE IF EXISTS `gruppo_di_esplorazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gruppo_di_esplorazione` (
  `NomeAssociazione` char(30) NOT NULL,
  `ID` varchar(5) NOT NULL,
  `Nome_gruppo` char(20) NOT NULL,
  PRIMARY KEY (`NomeAssociazione`,`ID`),
  UNIQUE KEY `ID_GRUPPO_DI_ESPLORAZIONE_IND` (`NomeAssociazione`,`ID`),
  CONSTRAINT `EQU_GRUPP_ASSOC` FOREIGN KEY (`NomeAssociazione`) REFERENCES `associazione` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gruppo_di_esplorazione`
--

LOCK TABLES `gruppo_di_esplorazione` WRITE;
/*!40000 ALTER TABLE `gruppo_di_esplorazione` DISABLE KEYS */;
INSERT INTO `gruppo_di_esplorazione` VALUES ('Ocean Exploration Trust','WK8OQ','Nautilus');
/*!40000 ALTER TABLE `gruppo_di_esplorazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laboratorio`
--

DROP TABLE IF EXISTS `laboratorio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laboratorio` (
  `ID` varchar(10) NOT NULL,
  `Nome` char(30) NOT NULL,
  `Indirizzo` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_LABORATORIO_IND` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratorio`
--

LOCK TABLES `laboratorio` WRITE;
/*!40000 ALTER TABLE `laboratorio` DISABLE KEYS */;
/*!40000 ALTER TABLE `laboratorio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `luogo`
--

DROP TABLE IF EXISTS `luogo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `luogo` (
  `Nome` char(30) NOT NULL,
  `NomePaese` char(30) DEFAULT NULL,
  PRIMARY KEY (`Nome`),
  UNIQUE KEY `ID_LUOGO_IND` (`Nome`),
  KEY `EQU_LUOGO_PAESE_IND` (`NomePaese`),
  CONSTRAINT `EQU_LUOGO_PAESE_FK` FOREIGN KEY (`NomePaese`) REFERENCES `paese` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `luogo`
--

LOCK TABLES `luogo` WRITE;
/*!40000 ALTER TABLE `luogo` DISABLE KEYS */;
/*!40000 ALTER TABLE `luogo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materiale`
--

DROP TABLE IF EXISTS `materiale`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materiale` (
  `Nome` char(30) NOT NULL,
  PRIMARY KEY (`Nome`),
  UNIQUE KEY `ID_MATERIALE_IND` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materiale`
--

LOCK TABLES `materiale` WRITE;
/*!40000 ALTER TABLE `materiale` DISABLE KEYS */;
/*!40000 ALTER TABLE `materiale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operatore`
--

DROP TABLE IF EXISTS `operatore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operatore` (
  `Nome` char(1) NOT NULL,
  `Cognome` char(1) NOT NULL,
  `Codice_Fiscale` char(1) NOT NULL,
  `NomeAssociazione` char(30) NOT NULL,
  `IDgruppo` varchar(5) NOT NULL,
  `ID` varchar(5) NOT NULL,
  PRIMARY KEY (`Codice_Fiscale`),
  UNIQUE KEY `SID_OPERATORE_ID` (`NomeAssociazione`,`IDgruppo`,`ID`),
  UNIQUE KEY `ID_OPERATORE_IND` (`Codice_Fiscale`),
  UNIQUE KEY `SID_OPERATORE_IND` (`NomeAssociazione`,`IDgruppo`,`ID`),
  CONSTRAINT `EQU_OPERA_GRUPP` FOREIGN KEY (`NomeAssociazione`, `IDgruppo`) REFERENCES `gruppo_di_esplorazione` (`NomeAssociazione`, `ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operatore`
--

LOCK TABLES `operatore` WRITE;
/*!40000 ALTER TABLE `operatore` DISABLE KEYS */;
/*!40000 ALTER TABLE `operatore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organismo`
--

DROP TABLE IF EXISTS `organismo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organismo` (
  `ID` varchar(10) NOT NULL,
  `Specie` char(30) DEFAULT NULL,
  `Nome_provvisorio` char(30) DEFAULT NULL,
  `Nome_comune` char(30) DEFAULT NULL,
  `Descrizione` text NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_ORGANISMO_IND` (`ID`),
  UNIQUE KEY `SID_ORGANISMO_1_ID` (`Specie`),
  UNIQUE KEY `SID_ORGANISMO_ID` (`Nome_provvisorio`),
  UNIQUE KEY `SID_ORGANISMO_1_IND` (`Specie`),
  UNIQUE KEY `SID_ORGANISMO_IND` (`Nome_provvisorio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organismo`
--

LOCK TABLES `organismo` WRITE;
/*!40000 ALTER TABLE `organismo` DISABLE KEYS */;
/*!40000 ALTER TABLE `organismo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paese`
--

DROP TABLE IF EXISTS `paese`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paese` (
  `Nome` char(30) NOT NULL,
  PRIMARY KEY (`Nome`),
  UNIQUE KEY `ID_PAESE_IND` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paese`
--

LOCK TABLES `paese` WRITE;
/*!40000 ALTER TABLE `paese` DISABLE KEYS */;
/*!40000 ALTER TABLE `paese` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prelievo`
--

DROP TABLE IF EXISTS `prelievo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prelievo` (
  `Codice` varchar(10) NOT NULL,
  `Numero` tinyint NOT NULL,
  `Profondita` smallint DEFAULT NULL,
  `Quantita` float NOT NULL,
  `Note` text,
  `CodiceSpedizione` varchar(10) NOT NULL,
  `NomeMateriale` char(30) NOT NULL,
  PRIMARY KEY (`Codice`),
  UNIQUE KEY `ID_PRELIEVO_IND` (`Codice`),
  KEY `REF_PRELI_SPEDI_IND` (`CodiceSpedizione`),
  KEY `EQU_PRELI_MATER_IND` (`NomeMateriale`),
  CONSTRAINT `EQU_PRELI_MATER_FK` FOREIGN KEY (`NomeMateriale`) REFERENCES `materiale` (`Nome`),
  CONSTRAINT `REF_PRELI_SPEDI_FK` FOREIGN KEY (`CodiceSpedizione`) REFERENCES `spedizione` (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prelievo`
--

LOCK TABLES `prelievo` WRITE;
/*!40000 ALTER TABLE `prelievo` DISABLE KEYS */;
/*!40000 ALTER TABLE `prelievo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relitto`
--

DROP TABLE IF EXISTS `relitto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relitto` (
  `ID` varchar(5) NOT NULL,
  `Nome` char(30) DEFAULT NULL,
  `Data_affondamento_stimata` date DEFAULT NULL,
  `Dimensioni` decimal(1,0) NOT NULL,
  `Descrizione` text NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_RELITTO_IND` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relitto`
--

LOCK TABLES `relitto` WRITE;
/*!40000 ALTER TABLE `relitto` DISABLE KEYS */;
/*!40000 ALTER TABLE `relitto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rov`
--

DROP TABLE IF EXISTS `rov`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rov` (
  `Targa` varchar(7) NOT NULL,
  `Numero_di_serie` varchar(10) NOT NULL,
  `NomeCasaProduttrice` char(30) NOT NULL,
  `DataProduzione` date NOT NULL,
  PRIMARY KEY (`Targa`),
  UNIQUE KEY `SID_ROV_ID` (`NomeCasaProduttrice`,`Numero_di_serie`),
  UNIQUE KEY `ID_ROV_IND` (`Targa`),
  UNIQUE KEY `SID_ROV_IND` (`NomeCasaProduttrice`,`Numero_di_serie`),
  CONSTRAINT `REF_ROV_CASA_` FOREIGN KEY (`NomeCasaProduttrice`) REFERENCES `casa_produttrice` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rov`
--

LOCK TABLES `rov` WRITE;
/*!40000 ALTER TABLE `rov` DISABLE KEYS */;
/*!40000 ALTER TABLE `rov` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spedizione`
--

DROP TABLE IF EXISTS `spedizione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spedizione` (
  `Codice` varchar(10) NOT NULL,
  `Data` date NOT NULL,
  `NomeLuogo` char(30) NOT NULL,
  `TargaROV` varchar(7) NOT NULL,
  `NomeAssociazione` char(30) NOT NULL,
  `IDgruppo` varchar(5) NOT NULL,
  PRIMARY KEY (`Codice`),
  UNIQUE KEY `ID_SPEDIZIONE_IND` (`Codice`),
  KEY `REF_SPEDI_LUOGO_IND` (`NomeLuogo`),
  KEY `REF_SPEDI_ROV_IND` (`TargaROV`),
  KEY `REF_SPEDI_GRUPP_IND` (`NomeAssociazione`,`IDgruppo`),
  CONSTRAINT `REF_SPEDI_GRUPP_FK` FOREIGN KEY (`NomeAssociazione`, `IDgruppo`) REFERENCES `gruppo_di_esplorazione` (`NomeAssociazione`, `ID`),
  CONSTRAINT `REF_SPEDI_LUOGO_FK` FOREIGN KEY (`NomeLuogo`) REFERENCES `luogo` (`Nome`),
  CONSTRAINT `REF_SPEDI_ROV_FK` FOREIGN KEY (`TargaROV`) REFERENCES `rov` (`Targa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spedizione`
--

LOCK TABLES `spedizione` WRITE;
/*!40000 ALTER TABLE `spedizione` DISABLE KEYS */;
/*!40000 ALTER TABLE `spedizione` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-05 17:04:20
