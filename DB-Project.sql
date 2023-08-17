-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: spedizioni
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
-- Table structure for table `analisi`
--

DROP TABLE IF EXISTS `analisi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `analisi` (
  `Codice` varchar(10) NOT NULL,
  `CodicePrelievo` varchar(10) NOT NULL,
  `Descrizione` text NOT NULL,
  `IDlaboratorio` varchar(10) NOT NULL,
  PRIMARY KEY (`Codice`),
  UNIQUE KEY `SID_ANALI_PRELI_ID` (`CodicePrelievo`),
  UNIQUE KEY `ID_ANALISI_IND` (`Codice`),
  UNIQUE KEY `SID_ANALI_PRELI_IND` (`CodicePrelievo`),
  KEY `EQU_ANALI_LABOR_IND` (`IDlaboratorio`),
  CONSTRAINT `EQU_ANALI_LABOR_FK` FOREIGN KEY (`IDlaboratorio`) REFERENCES `laboratori` (`ID`),
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
-- Table structure for table `associazioni`
--

DROP TABLE IF EXISTS `associazioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `associazioni` (
  `Nome` char(30) NOT NULL,
  `Indirizzo` text NOT NULL,
  PRIMARY KEY (`Nome`),
  UNIQUE KEY `ID_ASSOCIAZIONE_IND` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `associazioni`
--

LOCK TABLES `associazioni` WRITE;
/*!40000 ALTER TABLE `associazioni` DISABLE KEYS */;
INSERT INTO `associazioni` VALUES ('JAMSTEC','2-15 Natsushimacho, Yokosuka, Kanagawa 237-0061, Giappone'),('NOAA','Herbert C. Hoover Building, 1401 Constitution Ave. NW, Washington, DC 20230, Stati Uniti'),('Ocean Exploration Trust','2500 Signal St, San Pedro, CA 90731, Stati Uniti'),('OceanX AG','Fluhgasse 135, 5080 Laufenburg, Svizzera'),('Odyssey Marine Exploration','205 S. Hoover Blvd, Suite 210, Tampa, FL 33609, Stati Uniti');
/*!40000 ALTER TABLE `associazioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avvistamenti`
--

DROP TABLE IF EXISTS `avvistamenti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avvistamenti` (
  `Codice` varchar(10) NOT NULL,
  `Numero` decimal(2,0) NOT NULL,
  `CodiceSpedizione` varchar(10) NOT NULL,
  `Profondita` decimal(5,0) DEFAULT NULL,
  `Note` text,
  `IDorganismo` varchar(10) DEFAULT NULL,
  `IDrelitto` varchar(5) DEFAULT NULL,
  `IDformazionegeologica` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`Codice`),
  UNIQUE KEY `SID_AVVISTAMENTO_ID` (`CodiceSpedizione`,`Numero`),
  UNIQUE KEY `ID_AVVISTAMENTO_IND` (`Codice`),
  UNIQUE KEY `SID_AVVISTAMENTO_IND` (`CodiceSpedizione`,`Numero`),
  KEY `EQU_AVVIS_ORGAN_IND` (`IDorganismo`),
  KEY `EQU_AVVIS_RELIT_IND` (`IDrelitto`),
  KEY `EQU_AVVIS_FORMA_IND` (`IDformazionegeologica`),
  CONSTRAINT `EQU_AVVIS_FORMA_FK` FOREIGN KEY (`IDformazionegeologica`) REFERENCES `formazioni_geologiche` (`ID`),
  CONSTRAINT `EQU_AVVIS_ORGAN_FK` FOREIGN KEY (`IDorganismo`) REFERENCES `organismi` (`ID`),
  CONSTRAINT `EQU_AVVIS_RELIT_FK` FOREIGN KEY (`IDrelitto`) REFERENCES `relitti` (`ID`),
  CONSTRAINT `REF_AVVIS_SPEDI` FOREIGN KEY (`CodiceSpedizione`) REFERENCES `spedizioni` (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avvistamenti`
--

LOCK TABLES `avvistamenti` WRITE;
/*!40000 ALTER TABLE `avvistamenti` DISABLE KEYS */;
INSERT INTO `avvistamenti` VALUES ('7876I2RYN3',2,'VJ4EIJACWK',NULL,'Il pesce mantiene una posizione verticale, con la testa rivolta verso l\'alto. Dopo essersi accorto della presenza del ROV è fuggito.','ACGEAS7P9A',NULL,NULL),('8RRJGLX6NQ',3,'FKCHELYUK3',NULL,'La medusa presenta un tentacolo centrale più lungo degli altri esemplari, facendo pensare che quelli visti finora potrebbero non essere completamente formati.','364FIFD9JR',NULL,NULL),('9KCBSNB37Q',1,'SSEY2O52BP',NULL,NULL,'P4FPZBSA8O',NULL,NULL),('9T3MWRVPM5',1,'FKCHELYUK3',NULL,NULL,'364FIFD9JR',NULL,NULL),('AZQ7W1DHDV',3,'VJ4EIJACWK',700,'Il sifonoforo non ha eseguito alcun movimento per tutta la durata dell\'osservazione. Attorno all\'organismo sono presenti degli altri più piccoli, non si sa se fanno parte del sifonoforo.','KHRIIMYK0J',NULL,NULL),('EODISH5X48',3,'SSEY2O52BP',NULL,NULL,'AI4CEQC9PM',NULL,NULL),('FRG2FXY0E5',2,'SSEY2O52BP',NULL,NULL,'P4FPZBSA8O',NULL,NULL),('JTXMQ1M1JV',4,'VJ4EIJACWK',NULL,'L\'esemplare sembra muoversi all\'interno della sua casa di muco che utilizza per filtrare i nutrimenti. La massa di muco è completamente trasparente e sembra catturare diverse particelle fluttuanti presenti nell\'acqua.','6567LBSV3P',NULL,NULL),('KASMNK5P8H',1,'VJ4EIJACWK',NULL,'L\'esemplare sembra fluttuare in posizione verticale, con il mantello rivolto verso il basso.','UDPDW13YB8',NULL,NULL),('W7UXUWRWBN',2,'FKCHELYUK3',NULL,'Utilizzando lo zoom per vedere meglio l\'esemplare, il team si è accorto che i filamenti seghettati della medusa si muovono, probabilmente significando che trasportano le sostanze nutritive al resto del corpo.','A69M3QUS9A',NULL,NULL),('X98MJF28RS',4,'FKCHELYUK3',900,NULL,'0F5W9M2W7L',NULL,NULL);
/*!40000 ALTER TABLE `avvistamenti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `case_produttrici`
--

DROP TABLE IF EXISTS `case_produttrici`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `case_produttrici` (
  `Nome` char(30) NOT NULL,
  `Indirizzo` text NOT NULL,
  PRIMARY KEY (`Nome`),
  UNIQUE KEY `ID_CASA_PRODUTTRICE_IND` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `case_produttrici`
--

LOCK TABLES `case_produttrici` WRITE;
/*!40000 ALTER TABLE `case_produttrici` DISABLE KEYS */;
INSERT INTO `case_produttrici` VALUES ('Blue Robotics Inc.','2740 California St, Torrance, CA 90503, Stati Uniti'),('EyeROV','Maker Village,Kerala Technology Innovation Zone, Kalamassery, Kochi, Kerala 683503, India'),('Oceaneering','5875 North Sam Houston Pkwy W #400, Houston, TX 77086, Stati Uniti'),('Seatrepid International','23083 U.S. Hwy 190, Robert, LA 70455, Stati Uniti'),('VideoRay','580 Wall St, Phoenixville, PA 19460, Stati Uniti');
/*!40000 ALTER TABLE `case_produttrici` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formazioni_geologiche`
--

DROP TABLE IF EXISTS `formazioni_geologiche`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `formazioni_geologiche` (
  `ID` varchar(5) NOT NULL,
  `Tipologia` char(30) NOT NULL,
  `Dimensioni` decimal(5,0) NOT NULL,
  `GradoPericolo` decimal(1,0) NOT NULL,
  `Descrizione` text NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_FORMAZIONE_GEOLOGICA_IND` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formazioni_geologiche`
--

LOCK TABLES `formazioni_geologiche` WRITE;
/*!40000 ALTER TABLE `formazioni_geologiche` DISABLE KEYS */;
/*!40000 ALTER TABLE `formazioni_geologiche` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gruppi_di_esplorazione`
--

DROP TABLE IF EXISTS `gruppi_di_esplorazione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gruppi_di_esplorazione` (
  `NomeAssociazione` char(30) NOT NULL,
  `ID` varchar(5) NOT NULL,
  `Nome` char(30) NOT NULL,
  PRIMARY KEY (`NomeAssociazione`,`ID`),
  UNIQUE KEY `ID_GRUPPO_DI_ESPLORAZIONE_IND` (`NomeAssociazione`,`ID`),
  CONSTRAINT `EQU_GRUPP_ASSOC` FOREIGN KEY (`NomeAssociazione`) REFERENCES `associazioni` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gruppi_di_esplorazione`
--

LOCK TABLES `gruppi_di_esplorazione` WRITE;
/*!40000 ALTER TABLE `gruppi_di_esplorazione` DISABLE KEYS */;
INSERT INTO `gruppi_di_esplorazione` VALUES ('JAMSTEC','4XPCU','Mirai'),('JAMSTEC','6G11M','Shinsei Maru'),('JAMSTEC','A9MFE','Yokosuka'),('NOAA','DEIJB','Falkor'),('NOAA','QHK1T','Atlantis'),('NOAA','R67EF','Pisces'),('Ocean Exploration Trust','WK8OQ','Nautilus'),('OceanX AG','ABB37','OceanXplorer'),('Odyssey Marine Exploration','R6ZLS','Odyssey DNA');
/*!40000 ALTER TABLE `gruppi_di_esplorazione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laboratori`
--

DROP TABLE IF EXISTS `laboratori`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laboratori` (
  `Nome` char(30) NOT NULL,
  `ID` varchar(10) NOT NULL,
  `Indirizzo` text NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_LABORATORIO_IND` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratori`
--

LOCK TABLES `laboratori` WRITE;
/*!40000 ALTER TABLE `laboratori` DISABLE KEYS */;
/*!40000 ALTER TABLE `laboratori` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `luoghi`
--

DROP TABLE IF EXISTS `luoghi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `luoghi` (
  `Nome` char(30) NOT NULL,
  `NomePaese` char(30) DEFAULT NULL,
  PRIMARY KEY (`Nome`),
  UNIQUE KEY `ID_LUOGO_IND` (`Nome`),
  KEY `EQU_LUOGO_PAESE_IND` (`NomePaese`),
  CONSTRAINT `EQU_LUOGO_PAESE_FK` FOREIGN KEY (`NomePaese`) REFERENCES `paesi` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `luoghi`
--

LOCK TABLES `luoghi` WRITE;
/*!40000 ALTER TABLE `luoghi` DISABLE KEYS */;
INSERT INTO `luoghi` VALUES ('Oceano Indiano',NULL),('Fossa delle Aleutine','Alaska'),('Isole Galapagos','Ecuador'),('Baia Sagami','Giappone'),('Fossa del Giappone','Giappone'),('Golfo del Messico','Messico'),('Manus Basin','Papua Nuova Guinea');
/*!40000 ALTER TABLE `luoghi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `materiali`
--

DROP TABLE IF EXISTS `materiali`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `materiali` (
  `Nome` char(30) NOT NULL,
  PRIMARY KEY (`Nome`),
  UNIQUE KEY `ID_MATERIALE_IND` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `materiali`
--

LOCK TABLES `materiali` WRITE;
/*!40000 ALTER TABLE `materiali` DISABLE KEYS */;
INSERT INTO `materiali` VALUES ('Acqua'),('Alghe'),('Fanghiglia'),('Rocce effusive'),('Sabbia');
/*!40000 ALTER TABLE `materiali` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membri`
--

DROP TABLE IF EXISTS `membri`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membri` (
  `Nome` char(30) NOT NULL,
  `Cognome` char(30) NOT NULL,
  `CodiceFiscale` varchar(16) NOT NULL,
  `ID` varchar(5) NOT NULL,
  `NomeAssociazione` char(30) NOT NULL,
  `IDgruppo` varchar(5) NOT NULL,
  `Ruolo` char(30) NOT NULL,
  PRIMARY KEY (`CodiceFiscale`),
  UNIQUE KEY `SID_MEMBRO_ID` (`NomeAssociazione`,`IDgruppo`,`ID`),
  UNIQUE KEY `ID_MEMBRO_IND` (`CodiceFiscale`),
  UNIQUE KEY `SID_MEMBRO_IND` (`NomeAssociazione`,`IDgruppo`,`ID`),
  CONSTRAINT `EQU_MEMBR_GRUPP` FOREIGN KEY (`NomeAssociazione`, `IDgruppo`) REFERENCES `gruppi_di_esplorazione` (`NomeAssociazione`, `ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membri`
--

LOCK TABLES `membri` WRITE;
/*!40000 ALTER TABLE `membri` DISABLE KEYS */;
INSERT INTO `membri` VALUES ('Cleopatra','Badolato','BDLCPT05T58D958T','2U93A','Ocean Exploration Trust','WK8OQ','Pilota ROV'),('Libero','Barbaresco','BRBLBR77A13F102K','QYA2L','NOAA','DEIJB','Navigatore'),('Brandolisi','Gemma','BRNGMM55E51C488N','7JZ3N','JAMSTEC','4XPCU','Biologa Marina'),('Licia','Beradino','BRRLCI00A60A579V','SV05U','JAMSTEC','4XPCU','Ingegnere informatico'),('Consolata','Bratus','BRTCSL99H56D005K','L4IAK','Ocean Exploration Trust','WK8OQ','Mappatrice dei fondali'),('Lodovico','Bertucci','BRTLVC61S11I243D','27QUX','NOAA','QHK1T','Mappatore dei fondali'),('Monica','Biti','BTIMNC13H69D261D','FZ7CG','JAMSTEC','6G11M','Mappatrice dei fondali'),('Fabio','Bottega','BTTFBA40B11A945I','0J4Q3','NOAA','QHK1T','Mappatore dei fondali'),('Nazario','Bozzi','BZZNZR05P10H850O','ASIEA','Ocean Exploration Trust','WK8OQ','Ingegnere informatico'),('Arrigo','Acca','CCARRG05B27B829D','INNJ6','Ocean Exploration Trust','WK8OQ','Ingegnere informatico'),('Beatrice','Ceccadrini','CCCBRC71R71B748T','7CT2Y','Ocean Exploration Trust','WK8OQ','Pilota ROV'),('Romina','Cecio','CCERMN71D44B778Q','JALWM','Ocean Exploration Trust','WK8OQ','Biologa Marina'),('Casimiro','Clun','CLNCMR30S02I565H','6Q9ER','NOAA','DEIJB','Biologo Marino'),('Elisabetta','Celentani','CLNLBT70R66C904O','LVXPW','NOAA','R67EF','Biologa Marina'),('Ezechiele','Clerico','CLRZHL62M16A736H','6RBB6','Ocean Exploration Trust','WK8OQ','Navigatore'),('Raffaella','Iacopo','CPIRFL51S45L019B','231RK','JAMSTEC','A9MFE','Ingegnere informatico'),('Moreno','Cipollini','CPLMRN81T24B559M','E5W7D','JAMSTEC','4XPCU','Biologo Marino'),('Igino','Coppola','CPPGNI04S11E390S','8DBPE','NOAA','DEIJB','Mappatore dei fondali'),('Alfonso','Acerbis','CRBLNS06A07B719G','0HQIG','NOAA','QHK1T','Ingegnere informatico'),('Giuda','Cornaro','CRNGDI74B05G978U','Y61FC','JAMSTEC','6G11M','Ingegnere informatico'),('Gaia','Corti','CRTGAI87H57H439A','4TWU0','NOAA','R67EF','Biologo Marino'),('Camillo','Ciussani','CSSCLL36C19B368V','84CAM','JAMSTEC','A9MFE','Mappatrice dei fondali'),('Susanna','Castagna','CSTSNN43P54G955G','0PQ1K','JAMSTEC','4XPCU','Biologa Marina'),('Fiorella','Catania','CTNFLL41E70C409T','A3RAR','Ocean Exploration Trust','WK8OQ','Mappatrice dei fondali'),('Augusto','Ciutti','CTTGST35L17E206D','S7M8O','Ocean Exploration Trust','WK8OQ','Biologo Marino'),('Walter','Cotta','CTTWTR74L12A008M','3K5Z7','NOAA','R67EF','Ingegnere informatico'),('Ersilia','Coveri','CVRRSL08P66B427G','HP7N2','NOAA','DEIJB','Biologa Marina'),('Geltrude','CÃ²','CXXGTR41M68D776D','LFUCJ','Ocean Exploration Trust','WK8OQ','Pilota ROV'),('Alvise','Degrossi','DGRLVS98E18D978M','H0UY9','Ocean Exploration Trust','WK8OQ','Biologo Marino'),('Nereo','Degrossi','DGRNRE54R07A979H','DD6AG','JAMSTEC','A9MFE','Pilota ROV'),('Aldo','D\'Amici','DMCLDA78P22H238H','ARC3P','NOAA','QHK1T','Pilota ROV'),('Elvira','Dorgnach','DRGLVR97D57L440D','KVBTV','JAMSTEC','6G11M','Mappatrice dei fondali'),('Giada','Flandina','FLNGDI44B54B461E','2Q37U','NOAA','R67EF','Biologa Marina'),('Romualdo','Florindi','FLRRLD91P28D553A','00VXE','NOAA','QHK1T','Mappatore dei fondali'),('Rinaldo','Frezzolino','FRZRLD34R05A825N','3JRDU','JAMSTEC','A9MFE','Pilota ROV'),('Agata','Galantini','GLNGTA91P45D470Y','SCP3V','NOAA','DEIJB','Navigatrice'),('Quirino','Gorga','GRGQRN36T31A053X','CIB9E','Ocean Exploration Trust','WK8OQ','Pilota ROV'),('Loreno','Gerevini','GRVLRN59H03A418T','JEKJ6','Ocean Exploration Trust','WK8OQ','Pilota ROV'),('Morgana','Gazzetta','GZZMGN08E60I701X','COLZW','Ocean Exploration Trust','WK8OQ','Biologa Marino'),('Pamela','Alberghini','LBRPML02H52D962S','OH6II','JAMSTEC','A9MFE','Mappatrice dei fondali'),('Floriana','Limonta','LMNFRN81P60A065I','IKWQC','JAMSTEC','4XPCU','Mappatrice dei fondali'),('Leopoldo','Longis','LNGLLD63E27H078A','N320M','JAMSTEC','6G11M','Ingegnere informatico'),('Elettra','Longhi','LNGLTR80E46A487Z','D5UY2','Ocean Exploration Trust','WK8OQ','Biologa Marina'),('Sibilla','Lino','LNISLL56S51I682L','WYM3J','NOAA','R67EF','Ingegnere informatico'),('Eleuterio','Monodutto','MDNLTR10H18D579I','GTSU0','JAMSTEC','6G11M','Pilota ROV'),('Fermo','Maderna','MDRFRM35R22G333A','3SAVX','Ocean Exploration Trust','WK8OQ','Navigatore'),('Porziano','Mango','MNGPZN78T17I585O','V99VN','JAMSTEC','6G11M','Biologo Marino'),('Marco','Maiori','MRAMRC34P28A831L','VQG2A','JAMSTEC','A9MFE','Ingegnere informatico'),('Ines','Maresca','MRSNSI86D50F870U','5BWBU','Ocean Exploration Trust','WK8OQ','Mappatrice dei fondali'),('Uberto','Mazzali','MZZBRT40E18D870G','JCS6S','JAMSTEC','6G11M','Biologo Marino'),('Spartaco','Nossardi','NSSSRT08P10F354F','2ASC2','Ocean Exploration Trust','WK8OQ','Ingegnere informatico'),('Tiziana','Nozia','NSSTZN90D48G109B','QPMUC','Ocean Exploration Trust','WK8OQ','Biologa Marina'),('Emiliana','Paoli','PLAMLN67B42E581W','W7SSD','JAMSTEC','4XPCU','Mappatrice dei fondali'),('Isidora','Palamuso','PLMSDR56L57H888Q','9YTO3','JAMSTEC','4XPCU','Ingegnere informatico'),('Milena','Pantoni','PNTMLN54L46G411L','8TK8W','JAMSTEC','A9MFE','Biologo Marino'),('Orsolina','Piperis','PPRRLN40R51D300P','QCHWS','Ocean Exploration Trust','WK8OQ','Mappatrice dei fondali'),('Albano','Pardini','PRDLBN98C08G407G','2IWX9','NOAA','QHK1T','Navigatore'),('Tosca','Poratto','PRTTSC07H57L828J','QGL52','Ocean Exploration Trust','WK8OQ','Mappatrice dei fondali'),('Camilla','Pescetto','PSCCLL54M46A701K','Z2MU0','NOAA','QHK1T','Ingegnere informatico'),('Lia','Pasqualone','PSQLIA79E65L963A','KYEVS','NOAA','DEIJB','Pilota ROV'),('Manuela','Pitter','PTTMNL51H41B430Y','AS019','JAMSTEC','4XPCU','Biologa Marina'),('Adalberto','Opezzi','PZZDBR12E07I459M','TSYB1','Ocean Exploration Trust','WK8OQ','Navigatore'),('Secondo','Pizzorno','PZZSND75A30H338Z','ZZXA2','Ocean Exploration Trust','WK8OQ','Mappatore dei fondali'),('Beatrice','Recchia','RCCBRC93H44G327I','WW843','JAMSTEC','A9MFE','Biologo Marino'),('Romolo','Scaravelli','SCRRML84M19A468J','RKR2Y','NOAA','R67EF','Mappatore dei fondali'),('Ottilia','Sciorto','SCRTTL91A55E311P','H7DTT','JAMSTEC','4XPCU','Pilota ROV'),('Volfango','Scaramelli','SCRVFN09C03G849L','CPAEG','Ocean Exploration Trust','WK8OQ','Mappatore dei fondali'),('Cirillo','Sammartano','SMMCLL81B11H955W','843M2','NOAA','R67EF','Pilota ROV'),('Lorella','Suardi','SRDLLL95C55I668D','JR8U6','NOAA','DEIJB','Pilota ROV'),('Palmira','Siro','SRIPMR35T55G289A','32SEF','Ocean Exploration Trust','WK8OQ','Navigatrice'),('NoÃ¨','Soranzo','SRNNOX70A01F453K','PXCVM','Ocean Exploration Trust','WK8OQ','Ingegnere informatico'),('Luigia','Sartorio','SRTLGU41B61D281R','FOQN5','Ocean Exploration Trust','WK8OQ','Pilota ROV'),('Gillo','Sassoni','SSSGLL73R07E061P','PZEYP','NOAA','QHK1T','Mappatore dei fondali'),('Piersilvio','Troia','TROPSL18L08F773R','8Y24K','Ocean Exploration Trust','WK8OQ','Biologo Marino'),('Angela','Torretti','TRRNGL74E42G792Y','AQA93','NOAA','R67EF','Pilota ROV'),('Iolanda','Ottolini','TTLLND93S69E632F','U5BYP','JAMSTEC','4XPCU','Pilota ROV'),('Abelardo','Vendramin','VNDBRD98B05H648Z','GGQ7Z','Ocean Exploration Trust','WK8OQ','Biologo Marino'),('Secondo','Vitari','VTRSND37C02B660V','3OP6P','Ocean Exploration Trust','WK8OQ','Biologo Marino'),('Adelchi','Zazzeri','ZZZDCH96S13L336N','O9UUH','NOAA','DEIJB','Navigatore'),('Vanessa','Zazzeroni','ZZZVSS47T51F685Q','FM6YY','JAMSTEC','6G11M','Pilota ROV');
/*!40000 ALTER TABLE `membri` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organismi`
--

DROP TABLE IF EXISTS `organismi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organismi` (
  `ID` varchar(10) NOT NULL,
  `Specie` char(50) DEFAULT NULL,
  `NomeProvvisorio` char(50) DEFAULT NULL,
  `NomeComune` char(50) DEFAULT NULL,
  `Descrizione` text NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_ORGANISMO_IND` (`ID`),
  UNIQUE KEY `SID_ORGANISMO_1_ID` (`Specie`),
  UNIQUE KEY `SID_ORGANISMO_ID` (`NomeProvvisorio`),
  UNIQUE KEY `SID_ORGANISMO_1_IND` (`Specie`),
  UNIQUE KEY `SID_ORGANISMO_IND` (`NomeProvvisorio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organismi`
--

LOCK TABLES `organismi` WRITE;
/*!40000 ALTER TABLE `organismi` DISABLE KEYS */;
INSERT INTO `organismi` VALUES ('0F5W9M2W7L','Tiburonia granrojo',NULL,'Grande medusa rossa','Il nome di questa medusa deriva dai suoi colori rossi della campana (granrojo = grande rosso in spagnolo). Presenta una campana di grandi dimensioni, mentre i tentacoli sono più corti e tozzi.'),('364FIFD9JR','Atolla wyvillei',NULL,NULL,'Questa specie di medusa presenta una campana rossa e un lungo tentacolo bianco che parte dal centro della campana e si allunga per una decina di centimetri'),('6567LBSV3P','Larvacean',NULL,NULL,'I larvacei sono tunicati che abitano diverse zone degli oceani di tutto il mondo, per nutrirsi utilizzano una \"barriera\"\" di muco che filtra le sostanze nutritive.\"'),('7F0JSTSGR0','Magnapinna atlantica',NULL,NULL,'Questi calamari sono caratterizzati, come gli altri membri del loro genere, da tentacoli molto lunghi, anche fino a 8 metri. Abitano le zone più profonde e oscure degli oceani, ancora non si sa di cosa si nutrono e le loro abitudini.'),('83SIM574N8','Hexatrygon bickelli',NULL,'Razza esabranchiata','Questa specie di razza presenta 6 paia di branchie, da cui deriva il suo nome. La testa è allungata e le dimensioni totali possono raggiungere anche 1.7m. Solitamente vivono a stretto contatto con il fondale marino.'),('A69M3QUS9A','Beroe forskalii',NULL,'Medusa pettine','Questa specie di ctenoforo di piccole dimensioni presenta un corpo completamente trasparente, fatta eccezione di filamenti \"dentati\"\" all\'interno del corpo\"'),('ACGEAS7P9A',NULL,'Pesce verticale',NULL,'Questa specie di pesce è nota per la sua abitudine nel rimanere fermo in posizione verticale, con la testa rivolta verso l\'alto, nonostante il movimento in acqua è comune a tutti gli altri pesci.'),('AI4CEQC9PM',NULL,'Medusa quadri-tentacolo',NULL,'Questa medusa di piccole dimensioni presenta 4 sottili tentacoli e una campana trasparente con un anello fluorescente. Utilizza la propulsione causata dal movimento della campana per muoversi.'),('EAU993XFSA','Deepstaria enigmatica',NULL,NULL,'Queste meduse sono solite abitare profondità elevate. Possiedono una larga ma sottile campana trasparente, che può raggiungere anche i 2 metri di larghezza. Non possiedono tentacoli e vivono in solitudine.'),('EZH5BFUT5O','Lampocteis cruentiventer',NULL,'Ctenoforo dal ventre insanguinato','Questo ctenoforo presenta un colore rosso molto intenso e dei filamenti interni seghettati che vengono talvolta attraversati da particelle bio-luminose sconosciute. Al momento sono l\'unica specie conosciuta del loro genere.'),('JANN0QNIG4','Psychrolutes phrictus',NULL,'Blob sculpin','Questa specie di sculpin abita le profondità più oscure degli oceani. Presentano diverse spine, come tutte le altre specie di sculpin, ma presentano anche una corporatura più tozza.'),('KHRIIMYK0J','Marrus orthocana',NULL,'Medusa sifonofora cintura di fuoco','Questa specie di sifonoforo presenta un colore rosso/arancio intenso, essendo i sifonofori dei raggruppamenti di organismi, può assumere diverse forme, caratterizzate solitamente da filamenti intrecciati.'),('LBPHU6GZV0','Enypniastes eximia',NULL,'Danzatore spagnolo','Questa specie di cetriolo marino nuota a profondità elevate. Presenta una colorazione accesa, solitamente rosso, rosa o arancione.'),('ORYC2H5PF4','Albatrossia pectoralis',NULL,'Coda di ratto gigante','Questo pesce è solito abitare il suolo marino. Possiede una corporatura tozza con una coda più sottile. Esemplari di questa specie possono crescere anche fino a 2 metri di lunghezza.'),('P4FPZBSA8O','Solmissus',NULL,'Medusa piatto da cena','Questa specie di medusa presenta numerosi e sottili tentacoli. La campana è quasi completamente trasparente. Sia i tentacoli che la campana sono fluorescenti e di colore bianco/azzurro.'),('UDPDW13YB8','Taonius borealis',NULL,'Calamaro cacatua','Questa specie di calamaro presenta un mantello e pinne trasparenti, che permettono la visibilità dall\'esterno degli organi interni. I tentacoli sono corti e bianchi, ma rossi sulla punta. Gli occhi sono di colore rosso mattone.'),('VKFBS2ECGG','Periphyllopsis braueri',NULL,NULL,'Queste meduse presentano una campana spessa e di colore grigio/viola. I tentacoli sono molto sottili e genericamente di colore bianco. La campana presenta inoltre delle appendici che si muovono come i petali di un fiore, chiudendosi concentricamente per spingersi in avanti.'),('VL5L84606R',NULL,'Gambero pesante',NULL,'Questa specie di gambero utilizza una dura corazza per proteggersi; questo comporta un maggiore peso, che non gli permette di nuotare come altre specie di gamberetti. Saranno necessari ulteriori studi.'),('WOCOAYY52M','Pycnogonid',NULL,'Ragno marino','Questi artropodi sono stati osservati a profondità elevate, gli esemplari possono essere di colore diverso e tutti posseggono otto zampe sottili, come i ragni comuni, e un torso piccolo.'),('WOXO3HBSWG','Hexanchus griseus',NULL,'Squalo vacca','Questo squalo presenta 6 paia di branchie e un muso schiacciato. Possono crescere fino a 6 metri di lunghezza.');
/*!40000 ALTER TABLE `organismi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paesi`
--

DROP TABLE IF EXISTS `paesi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paesi` (
  `Nome` char(30) NOT NULL,
  PRIMARY KEY (`Nome`),
  UNIQUE KEY `ID_PAESE_IND` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paesi`
--

LOCK TABLES `paesi` WRITE;
/*!40000 ALTER TABLE `paesi` DISABLE KEYS */;
INSERT INTO `paesi` VALUES ('Alaska'),('Ecuador'),('Giappone'),('Messico'),('Papua Nuova Guinea');
/*!40000 ALTER TABLE `paesi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prelievo`
--

DROP TABLE IF EXISTS `prelievo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prelievo` (
  `Codice` varchar(10) NOT NULL,
  `Numero` decimal(2,0) NOT NULL,
  `CodiceSpedizione` varchar(10) NOT NULL,
  `Profondita` decimal(5,0) DEFAULT NULL,
  `Note` text,
  `Quantita` float(4,2) NOT NULL,
  `NomeMateriale` char(30) NOT NULL,
  PRIMARY KEY (`Codice`),
  UNIQUE KEY `SID_PRELIEVO_ID` (`CodiceSpedizione`,`Numero`),
  UNIQUE KEY `ID_PRELIEVO_IND` (`Codice`),
  UNIQUE KEY `SID_PRELIEVO_IND` (`CodiceSpedizione`,`Numero`),
  KEY `EQU_PRELI_MATER_IND` (`NomeMateriale`),
  CONSTRAINT `EQU_PRELI_MATER_FK` FOREIGN KEY (`NomeMateriale`) REFERENCES `materiali` (`Nome`),
  CONSTRAINT `REF_PRELI_SPEDI` FOREIGN KEY (`CodiceSpedizione`) REFERENCES `spedizioni` (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prelievo`
--

LOCK TABLES `prelievo` WRITE;
/*!40000 ALTER TABLE `prelievo` DISABLE KEYS */;
INSERT INTO `prelievo` VALUES ('F448LXLYCN',1,'FKCHELYUK3',2300,'Le rocce sono state prelevate nelle vicinanze di un vulcano sottomarino.',1.70,'Rocce effusive');
/*!40000 ALTER TABLE `prelievo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `relitti`
--

DROP TABLE IF EXISTS `relitti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `relitti` (
  `ID` varchar(5) NOT NULL,
  `Nome` char(50) DEFAULT NULL,
  `DataAffondamento` date DEFAULT NULL,
  `Dimensioni` decimal(3,0) NOT NULL,
  `Descrizione` text NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_RELITTO_IND` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relitti`
--

LOCK TABLES `relitti` WRITE;
/*!40000 ALTER TABLE `relitti` DISABLE KEYS */;
/*!40000 ALTER TABLE `relitti` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rov`
--

DROP TABLE IF EXISTS `rov`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rov` (
  `Targa` varchar(7) NOT NULL,
  `NumeroSerie` varchar(10) NOT NULL,
  `NomeCasaProduttrice` char(30) NOT NULL,
  `DataProduzione` date NOT NULL,
  PRIMARY KEY (`Targa`),
  UNIQUE KEY `SID_ROV_ID` (`NomeCasaProduttrice`,`NumeroSerie`),
  UNIQUE KEY `ID_ROV_IND` (`Targa`),
  UNIQUE KEY `SID_ROV_IND` (`NomeCasaProduttrice`,`NumeroSerie`),
  CONSTRAINT `REF_ROV_CASA_` FOREIGN KEY (`NomeCasaProduttrice`) REFERENCES `case_produttrici` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rov`
--

LOCK TABLES `rov` WRITE;
/*!40000 ALTER TABLE `rov` DISABLE KEYS */;
INSERT INTO `rov` VALUES ('4GMW310','HO4IUJKLRY','Seatrepid International','2017-05-26'),('68F6868','76HF6YN1HT','VideoRay','2006-11-28'),('8AGD854','82FVVRU6G6','EyeROV','2000-02-17'),('8GPK420','FOEYGBHH84','Blue Robotics Inc.','2018-10-09'),('AB123CD','0000ZZ0000','Blue Robotics Inc.','2018-11-03'),('C606966','8U59P369AP','EyeROV','1996-01-10'),('C719058','RCMEXFIGYB','EyeROV','1996-08-21'),('CWP8099','F49RXV36NF','Blue Robotics Inc.','1993-02-27'),('EQE2435','16GWSA733K','Oceaneering','2016-12-03'),('HWN1325','ZU01FVTECU','VideoRay','2011-03-09'),('JFG1274','8N267FNXXW','Oceaneering','2001-12-10'),('KGS4116','G15FFEYEOM','Blue Robotics Inc.','1993-10-03'),('KVK93A4','OWZ8AYURQP','Oceaneering','2002-07-29'),('MJV3440','HOQXK3F9OB','Seatrepid International','2006-08-16'),('MQP6080','0JHBW0POMH','Blue Robotics Inc.','1990-05-27'),('PQ397LS','94LMH013FQ','EyeROV','2013-11-03'),('TOY8671','VH0HFI8FIC','Oceaneering','2000-11-06'),('VT16752','LFLRJTRGCL','Blue Robotics Inc.','2016-05-24');
/*!40000 ALTER TABLE `rov` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `spedizioni`
--

DROP TABLE IF EXISTS `spedizioni`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `spedizioni` (
  `Codice` varchar(10) NOT NULL,
  `Data` date NOT NULL,
  `NomeAssociazione` char(30) NOT NULL,
  `IDgruppo` varchar(5) NOT NULL,
  `NomeLuogo` char(30) NOT NULL,
  `TargaROV` varchar(7) NOT NULL,
  PRIMARY KEY (`Codice`),
  UNIQUE KEY `SID_SPEDIZIONE_ID` (`Data`,`NomeAssociazione`,`IDgruppo`),
  UNIQUE KEY `ID_SPEDIZIONE_IND` (`Codice`),
  UNIQUE KEY `SID_SPEDIZIONE_IND` (`Data`,`NomeAssociazione`,`IDgruppo`),
  KEY `REF_SPEDI_GRUPP_IND` (`NomeAssociazione`,`IDgruppo`),
  KEY `REF_SPEDI_LUOGO_IND` (`NomeLuogo`),
  KEY `REF_SPEDI_ROV_IND` (`TargaROV`),
  CONSTRAINT `REF_SPEDI_GRUPP_FK` FOREIGN KEY (`NomeAssociazione`, `IDgruppo`) REFERENCES `gruppi_di_esplorazione` (`NomeAssociazione`, `ID`),
  CONSTRAINT `REF_SPEDI_LUOGO_FK` FOREIGN KEY (`NomeLuogo`) REFERENCES `luoghi` (`Nome`),
  CONSTRAINT `REF_SPEDI_ROV_FK` FOREIGN KEY (`TargaROV`) REFERENCES `rov` (`Targa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spedizioni`
--

LOCK TABLES `spedizioni` WRITE;
/*!40000 ALTER TABLE `spedizioni` DISABLE KEYS */;
INSERT INTO `spedizioni` VALUES ('FKCHELYUK3','2023-07-02','Ocean Exploration Trust','WK8OQ','Fossa delle Aleutine','8GPK420'),('SSEY2O52BP','2023-07-21','Ocean Exploration Trust','WK8OQ','Fossa delle Aleutine','8GPK420'),('UI13BGB839','2022-05-15','JAMSTEC','4XPCU','Oceano Indiano','EQE2435'),('VJ4EIJACWK','2023-06-18','Ocean Exploration Trust','WK8OQ','Fossa delle Aleutine','VT16752');
/*!40000 ALTER TABLE `spedizioni` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-17 18:42:16
