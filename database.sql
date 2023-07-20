CREATE DATABASE  IF NOT EXISTS `spedizioni_rov` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `spedizioni_rov`;
-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: spedizioni_rov
-- ------------------------------------------------------
-- Server version	8.0.33

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
-- Table structure for table `associazione`
--

DROP TABLE IF EXISTS `associazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `associazione` (
  `Nome` char(30) NOT NULL,
  `Città` char(25) NOT NULL,
  `Via/Piazza` char(25) NOT NULL,
  `Numero_civico` decimal(6,0) NOT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `associazione`
--

LOCK TABLES `associazione` WRITE;
/*!40000 ALTER TABLE `associazione` DISABLE KEYS */;
INSERT INTO `associazione` VALUES ('JAMSTEC','Yokosuka','Natsushimacho',2),('NOAA','Washington','Constitution Avenue',1401),('Ocean Exploration Trust','San Pedro','Signal St',2500);
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
  `Codice_spedizione` varchar(10) NOT NULL,
  `Numero` decimal(4,0) NOT NULL,
  `Profondità` float NOT NULL,
  PRIMARY KEY (`Codice`),
  UNIQUE KEY `Codice_spedizione` (`Codice_spedizione`,`Numero`),
  CONSTRAINT `avvistamento_ibfk_1` FOREIGN KEY (`Codice_spedizione`) REFERENCES `spedizione` (`Codice`)
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
  `Città` char(25) NOT NULL,
  `Via/Piazza` char(25) NOT NULL,
  `Numero_civico` decimal(6,0) NOT NULL,
  PRIMARY KEY (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `casa_produttrice`
--

LOCK TABLES `casa_produttrice` WRITE;
/*!40000 ALTER TABLE `casa_produttrice` DISABLE KEYS */;
INSERT INTO `casa_produttrice` VALUES ('TechnipFMC','Londra','Fetter Lane',1);
/*!40000 ALTER TABLE `casa_produttrice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gruppo_di_esplorazione`
--

DROP TABLE IF EXISTS `gruppo_di_esplorazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gruppo_di_esplorazione` (
  `Nome` char(20) NOT NULL,
  `ID` varchar(5) NOT NULL,
  `Nome_associazione` char(30) NOT NULL,
  UNIQUE KEY `Nome_associazione` (`Nome_associazione`,`ID`),
  KEY `gruppo_di_esplorazione_jbfk_2` (`ID`),
  CONSTRAINT `gruppo_di_esplorazione_ibfk_1` FOREIGN KEY (`Nome_associazione`) REFERENCES `associazione` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gruppo_di_esplorazione`
--

LOCK TABLES `gruppo_di_esplorazione` WRITE;
/*!40000 ALTER TABLE `gruppo_di_esplorazione` DISABLE KEYS */;
/*!40000 ALTER TABLE `gruppo_di_esplorazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `istituto_professionale_specializzato`
--

DROP TABLE IF EXISTS `istituto_professionale_specializzato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `istituto_professionale_specializzato` (
  `Nome` char(30) NOT NULL,
  `ID` varchar(10) NOT NULL,
  `Città` char(25) NOT NULL,
  `Via/Piazza` char(25) NOT NULL,
  `Numero_civico` decimal(6,0) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `istituto_professionale_specializzato`
--

LOCK TABLES `istituto_professionale_specializzato` WRITE;
/*!40000 ALTER TABLE `istituto_professionale_specializzato` DISABLE KEYS */;
/*!40000 ALTER TABLE `istituto_professionale_specializzato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laboratorio`
--

DROP TABLE IF EXISTS `laboratorio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laboratorio` (
  `Nome` char(30) NOT NULL,
  `ID` varchar(10) NOT NULL,
  `Città` char(25) NOT NULL,
  `Via/Piazza` char(25) NOT NULL,
  `Numero_civico` decimal(6,0) NOT NULL,
  PRIMARY KEY (`ID`)
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
-- Table structure for table `licenza_manutentore`
--

DROP TABLE IF EXISTS `licenza_manutentore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `licenza_manutentore` (
  `ID` varchar(10) NOT NULL,
  `Data_rilascio` date NOT NULL,
  `Data_rinnovo` date DEFAULT NULL,
  `Data_scadenza` date NOT NULL,
  `Istituto_rilasciante` varchar(10) NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `licenza_manutentore_fk1_idx` (`Istituto_rilasciante`),
  CONSTRAINT `licenza_manutentore_fk1` FOREIGN KEY (`Istituto_rilasciante`) REFERENCES `istituto_professionale_specializzato` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `licenza_manutentore`
--

LOCK TABLES `licenza_manutentore` WRITE;
/*!40000 ALTER TABLE `licenza_manutentore` DISABLE KEYS */;
/*!40000 ALTER TABLE `licenza_manutentore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `licenza_operatore_rov`
--

DROP TABLE IF EXISTS `licenza_operatore_rov`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `licenza_operatore_rov` (
  `ID` varchar(10) NOT NULL,
  `Data_rilascio` date NOT NULL,
  `Data_rinnovo` date DEFAULT NULL,
  `Data_scadenza` date NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `licenza_operatore_rov`
--

LOCK TABLES `licenza_operatore_rov` WRITE;
/*!40000 ALTER TABLE `licenza_operatore_rov` DISABLE KEYS */;
/*!40000 ALTER TABLE `licenza_operatore_rov` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `luogo`
--

DROP TABLE IF EXISTS `luogo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `luogo` (
  `Nome` char(20) NOT NULL,
  `Paese` char(20) DEFAULT NULL,
  PRIMARY KEY (`Nome`),
  KEY `luogo_fk1_idx` (`Paese`),
  CONSTRAINT `luogo_fk1` FOREIGN KEY (`Paese`) REFERENCES `paese` (`Nome`)
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
  `Nome` char(20) NOT NULL,
  `Quantità` decimal(4,2) NOT NULL,
  `Descrizione` char(200) NOT NULL,
  `Codice_prelievo` varchar(10) NOT NULL,
  `Laboratorio_analisi` varchar(10) NOT NULL,
  KEY `fk1_idx` (`Codice_prelievo`),
  KEY `materiale_fk2_idx` (`Laboratorio_analisi`),
  CONSTRAINT `materiale_fk1` FOREIGN KEY (`Codice_prelievo`) REFERENCES `prelievo` (`Codice`),
  CONSTRAINT `materiale_fk2` FOREIGN KEY (`Laboratorio_analisi`) REFERENCES `laboratorio` (`ID`)
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
-- Table structure for table `organismo`
--

DROP TABLE IF EXISTS `organismo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organismo` (
  `Specie` text,
  `Nome_comune` text,
  `Dimensioni` double NOT NULL,
  `Descrizione_comportamento` text NOT NULL,
  `URL_foto` text NOT NULL,
  `Codice_avvistamento` varchar(10) NOT NULL,
  KEY `fk1_idx` (`Codice_avvistamento`),
  CONSTRAINT `organismo_fk1` FOREIGN KEY (`Codice_avvistamento`) REFERENCES `avvistamento` (`Codice`)
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
  `Nome` char(20) NOT NULL,
  PRIMARY KEY (`Nome`)
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
-- Table structure for table `persona`
--

DROP TABLE IF EXISTS `persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `persona` (
  `Nome` char(20) NOT NULL,
  `Cognome` char(20) NOT NULL,
  `Codice_fiscale` varchar(16) NOT NULL,
  `ID_gruppo` varchar(5) DEFAULT NULL,
  `Casa_produttrice` char(30) DEFAULT NULL,
  `ID_operatore` varchar(5) DEFAULT NULL,
  `ID_manutentore` varchar(5) DEFAULT NULL,
  `URL_foto` text NOT NULL,
  PRIMARY KEY (`Codice_fiscale`),
  UNIQUE KEY `ID_gruppo` (`ID_gruppo`,`ID_operatore`),
  UNIQUE KEY `Casa_produttrice` (`Casa_produttrice`,`ID_manutentore`),
  CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`ID_gruppo`) REFERENCES `gruppo_di_esplorazione` (`ID`),
  CONSTRAINT `persona_ibfk_2` FOREIGN KEY (`Casa_produttrice`) REFERENCES `casa_produttrice` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `persona`
--

LOCK TABLES `persona` WRITE;
/*!40000 ALTER TABLE `persona` DISABLE KEYS */;
/*!40000 ALTER TABLE `persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prelievo`
--

DROP TABLE IF EXISTS `prelievo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prelievo` (
  `Codice` varchar(10) NOT NULL,
  `Numero` decimal(3,0) NOT NULL,
  `Codice_spedizione` varchar(10) NOT NULL,
  PRIMARY KEY (`Codice`),
  UNIQUE KEY `Codice_spedizione` (`Codice_spedizione`,`Numero`),
  CONSTRAINT `prelievo_ibfk_1` FOREIGN KEY (`Codice_spedizione`) REFERENCES `spedizione` (`Codice`)
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
-- Table structure for table `rov`
--

DROP TABLE IF EXISTS `rov`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rov` (
  `Targa` varchar(7) NOT NULL,
  `Numero_serie` varchar(10) NOT NULL,
  `Casa_produttrice` char(30) NOT NULL,
  PRIMARY KEY (`Targa`),
  UNIQUE KEY `Casa_produttrice` (`Casa_produttrice`,`Numero_serie`),
  CONSTRAINT `rov_ibfk_1` FOREIGN KEY (`Casa_produttrice`) REFERENCES `casa_produttrice` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rov`
--

LOCK TABLES `rov` WRITE;
/*!40000 ALTER TABLE `rov` DISABLE KEYS */;
INSERT INTO `rov` VALUES ('CSGQN8M','0UY3D7PMBJ','TechnipFMC'),('U1AAH99','3IN8UHN2Y2','TechnipFMC'),('2JZSQ1T','5FP53UELVR','TechnipFMC'),('EOHO13K','B9RZI3QDBZ','TechnipFMC'),('FERIZQD','EULM5AIUMF','TechnipFMC'),('GAZKSTI','I6YEDPKFX7','TechnipFMC'),('E4A9496','MXCAXR614T','TechnipFMC'),('MWGCIPB','QQ1D8RHHR8','TechnipFMC'),('XAVRNKZ','UGU9O298WH','TechnipFMC'),('T0C5MYN','WNXDE5813F','TechnipFMC');
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
  `ROV_utilizzato` varchar(7) NOT NULL,
  `Luogo_esplorato` char(20) NOT NULL,
  PRIMARY KEY (`Codice`),
  KEY `spedizione_fk1_idx` (`ROV_utilizzato`),
  KEY `spedizione_fk2_idx` (`Luogo_esplorato`),
  CONSTRAINT `spedizione_fk1` FOREIGN KEY (`ROV_utilizzato`) REFERENCES `rov` (`Targa`),
  CONSTRAINT `spedizione_fk2` FOREIGN KEY (`Luogo_esplorato`) REFERENCES `luogo` (`Nome`)
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

-- Dump completed on 2023-07-20 16:46:04
