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
  `CodiceSpedizione` varchar(10) NOT NULL,
  `Numero` tinyint NOT NULL,
  `Profondita` smallint DEFAULT NULL,
  `Note` text,
  `IDrelitto` varchar(10) DEFAULT NULL,
  `IDformazionegeologica` varchar(10) DEFAULT NULL,
  `IDorganismo` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Codice`),
  UNIQUE KEY `ID_AVVISTAMENTO_IND` (`Codice`),
  KEY `EQU_AVVIS_RELIT_IND` (`IDrelitto`),
  KEY `EQU_AVVIS_FORMA_IND` (`IDformazionegeologica`),
  KEY `EQU_AVVIS_ORGAN_IND` (`IDorganismo`),
  KEY `REF_AVVIS_SPEDI_IND` (`CodiceSpedizione`),
  CONSTRAINT `EQU_AVVIS_FORMA_FK` FOREIGN KEY (`IDformazionegeologica`) REFERENCES `formazione_geologica` (`ID`),
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
INSERT INTO `avvistamento` VALUES ('7876I2RYN3','VJ4EIJACWK',2,NULL,'Il pesce mantiene una posizione verticale, con la testa rivolta verso l\'alto. Dopo essersi accorto della presenza del ROV è fuggito.',NULL,NULL,'ACGEAS7P9A'),('8RRJGLX6NQ','FKCHELYUK3',3,NULL,'La medusa presenta un tentacolo centrale più lungo degli altri esemplari, facendo pensare che quelli visti finora potrebbero non essere completamente formati.',NULL,NULL,'364FIFD9JR'),('9KCBSNB37Q','SSEY2O52BP',1,NULL,NULL,NULL,NULL,'P4FPZBSA8O'),('9T3MWRVPM5','FKCHELYUK3',1,NULL,NULL,NULL,NULL,'364FIFD9JR'),('AZQ7W1DHDV','VJ4EIJACWK',3,700,'Il sifonoforo non ha eseguito alcun movimento per tutta la durata dell\'osservazione. Attorno all\'organismo sono presenti degli altri più piccoli, non si sa se fanno parte del sifonoforo.',NULL,NULL,'KHRIIMYK0J'),('EODISH5X48','SSEY2O52BP',3,NULL,NULL,NULL,NULL,'AI4CEQC9PM'),('FRG2FXY0E5','SSEY2O52BP',2,NULL,NULL,NULL,NULL,'P4FPZBSA8O'),('JTXMQ1M1JV','VJ4EIJACWK',4,NULL,'L\'esemplare sembra muoversi all\'interno della sua casa di muco che utilizza per filtrare i nutrimenti. La massa di muco è completamente trasparente e sembra catturare diverse particelle fluttuanti presenti nell\'acqua.',NULL,NULL,'6567LBSV3P'),('KASMNK5P8H','VJ4EIJACWK',1,NULL,'L\'esemplare sembra fluttuare in posizione verticale, con il mantello rivolto verso il basso.',NULL,NULL,'UDPDW13YB8'),('W7UXUWRWBN','FKCHELYUK3',2,NULL,'Utilizzando lo zoom per vedere meglio l\'esemplare, il team si è accorto che i filamenti seghettati della medusa si muovono, probabilmente significando che trasportano le sostanze nutritive al resto del corpo.',NULL,NULL,'A69M3QUS9A'),('X98MJF28RS','FKCHELYUK3',4,900,NULL,NULL,NULL,'0F5W9M2W7L');
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
  `ID` varchar(10) NOT NULL,
  `Tipologia` char(30) NOT NULL,
  `Dimensioni` decimal(5,0) NOT NULL,
  `Grado_di_pericolo` decimal(1,0) NOT NULL,
  `Descrizione` text NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_FORMAZIONE_GEOLOGICA_IND` (`ID`)
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
INSERT INTO `gruppo_di_esplorazione` VALUES ('JAMSTEC','4XPCU','Mirai'),('JAMSTEC','6G11M','Shinsei Maru'),('JAMSTEC','A9MFE','Yokosuka'),('NOAA','DEIJB','Falkor'),('NOAA','QHK1T','Atlantis'),('NOAA','R67EF','Pisces'),('Ocean Exploration Trust','WK8OQ','Nautilus'),('OceanX AG','ABB37','OceanXplorer'),('Odyssey Marine Exploration','R6ZLS','Odyssey DNA');
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
INSERT INTO `luogo` VALUES ('Oceano Indiano',NULL),('Fossa delle Aleutine','Alaska'),('Isole Galapagos','Ecuador'),('Baia Sagami','Giappone'),('Fossa del Giappone','Giappone'),('Golfo del Messico','Messico'),('Manus Basin','Papua Nuova Guinea');
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
INSERT INTO `materiale` VALUES ('Acqua'),('Alghe'),('Fanghiglia'),('Rocce effusive'),('Sabbia');
/*!40000 ALTER TABLE `materiale` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `membro`
--

DROP TABLE IF EXISTS `membro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `membro` (
  `Nome` char(20) NOT NULL,
  `Cognome` char(20) NOT NULL,
  `Codice_Fiscale` char(16) NOT NULL,
  `NomeAssociazione` char(30) NOT NULL,
  `IDgruppo` varchar(5) NOT NULL,
  `ID` varchar(5) NOT NULL,
  `Ruolo` char(50) NOT NULL,
  PRIMARY KEY (`Codice_Fiscale`),
  UNIQUE KEY `SID_OPERATORE_ID` (`NomeAssociazione`,`IDgruppo`,`ID`),
  UNIQUE KEY `ID_OPERATORE_IND` (`Codice_Fiscale`),
  UNIQUE KEY `SID_OPERATORE_IND` (`NomeAssociazione`,`IDgruppo`,`ID`),
  CONSTRAINT `EQU_OPERA_GRUPP` FOREIGN KEY (`NomeAssociazione`, `IDgruppo`) REFERENCES `gruppo_di_esplorazione` (`NomeAssociazione`, `ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membro`
--

LOCK TABLES `membro` WRITE;
/*!40000 ALTER TABLE `membro` DISABLE KEYS */;
INSERT INTO `membro` VALUES ('Cleopatra','Badolato','BDLCPT05T58D958T','Ocean Exploration Trust','WK8OQ','2U93A','Pilota ROV'),('Libero','Barbaresco','BRBLBR77A13F102K','NOAA','DEIJB','QYA2L','Navigatore'),('Brandolisi','Gemma','BRNGMM55E51C488N','JAMSTEC','4XPCU','7JZ3N','Biologa Marina'),('Licia','Beradino','BRRLCI00A60A579V','JAMSTEC','4XPCU','SV05U','Ingegnere informatico'),('Consolata','Bratus','BRTCSL99H56D005K','Ocean Exploration Trust','WK8OQ','L4IAK','Mappatrice dei fondali'),('Lodovico','Bertucci','BRTLVC61S11I243D','NOAA','QHK1T','27QUX','Mappatore dei fondali'),('Monica','Biti','BTIMNC13H69D261D','JAMSTEC','6G11M','FZ7CG','Mappatrice dei fondali'),('Fabio','Bottega','BTTFBA40B11A945I','NOAA','QHK1T','0J4Q3','Mappatore dei fondali'),('Nazario','Bozzi','BZZNZR05P10H850O','Ocean Exploration Trust','WK8OQ','ASIEA','Ingegnere informatico'),('Arrigo','Acca','CCARRG05B27B829D','Ocean Exploration Trust','WK8OQ','INNJ6','Ingegnere informatico'),('Beatrice','Ceccadrini','CCCBRC71R71B748T','Ocean Exploration Trust','WK8OQ','7CT2Y','Pilota ROV'),('Romina','Cecio','CCERMN71D44B778Q','Ocean Exploration Trust','WK8OQ','JALWM','Biologa Marina'),('Casimiro','Clun','CLNCMR30S02I565H','NOAA','DEIJB','6Q9ER','Biologo Marino'),('Elisabetta','Celentani','CLNLBT70R66C904O','NOAA','R67EF','LVXPW','Biologa Marina'),('Ezechiele','Clerico','CLRZHL62M16A736H','Ocean Exploration Trust','WK8OQ','6RBB6','Navigatore'),('Raffaella','Iacopo','CPIRFL51S45L019B','JAMSTEC','A9MFE','231RK','Ingegnere informatico'),('Moreno','Cipollini','CPLMRN81T24B559M','JAMSTEC','4XPCU','E5W7D','Biologo Marino'),('Igino','Coppola','CPPGNI04S11E390S','NOAA','DEIJB','8DBPE','Mappatore dei fondali'),('Alfonso','Acerbis','CRBLNS06A07B719G','NOAA','QHK1T','0HQIG','Ingegnere informatico'),('Giuda','Cornaro','CRNGDI74B05G978U','JAMSTEC','6G11M','Y61FC','Ingegnere informatico'),('Gaia','Corti','CRTGAI87H57H439A','NOAA','R67EF','4TWU0','Biologo Marino'),('Camillo','Ciussani','CSSCLL36C19B368V','JAMSTEC','A9MFE','84CAM','Mappatrice dei fondali'),('Susanna','Castagna','CSTSNN43P54G955G','JAMSTEC','4XPCU','0PQ1K','Biologa Marina'),('Fiorella','Catania','CTNFLL41E70C409T','Ocean Exploration Trust','WK8OQ','A3RAR','Mappatrice dei fondali'),('Augusto','Ciutti','CTTGST35L17E206D','Ocean Exploration Trust','WK8OQ','S7M8O','Biologo Marino'),('Walter','Cotta','CTTWTR74L12A008M','NOAA','R67EF','3K5Z7','Ingegnere informatico'),('Ersilia','Coveri','CVRRSL08P66B427G','NOAA','DEIJB','HP7N2','Biologa Marina'),('Geltrude','Cò','CXXGTR41M68D776D','Ocean Exploration Trust','WK8OQ','LFUCJ','Pilota ROV'),('Alvise','Degrossi','DGRLVS98E18D978M','Ocean Exploration Trust','WK8OQ','H0UY9','Biologo Marino'),('Nereo','Degrossi','DGRNRE54R07A979H','JAMSTEC','A9MFE','DD6AG','Pilota ROV'),('Aldo','D\'Amici','DMCLDA78P22H238H','NOAA','QHK1T','ARC3P','Pilota ROV'),('Elvira','Dorgnach','DRGLVR97D57L440D','JAMSTEC','6G11M','KVBTV','Mappatrice dei fondali'),('Giada','Flandina','FLNGDI44B54B461E','NOAA','R67EF','2Q37U','Biologa Marina'),('Romualdo','Florindi','FLRRLD91P28D553A','NOAA','QHK1T','00VXE','Mappatore dei fondali'),('Rinaldo','Frezzolino','FRZRLD34R05A825N','JAMSTEC','A9MFE','3JRDU','Pilota ROV'),('Agata','Galantini','GLNGTA91P45D470Y','NOAA','DEIJB','SCP3V','Navigatrice'),('Quirino','Gorga','GRGQRN36T31A053X','Ocean Exploration Trust','WK8OQ','CIB9E','Pilota ROV'),('Loreno','Gerevini','GRVLRN59H03A418T','Ocean Exploration Trust','WK8OQ','JEKJ6','Pilota ROV'),('Morgana','Gazzetta','GZZMGN08E60I701X','Ocean Exploration Trust','WK8OQ','COLZW','Biologa Marino'),('Pamela','Alberghini','LBRPML02H52D962S','JAMSTEC','A9MFE','OH6II','Mappatrice dei fondali'),('Floriana','Limonta','LMNFRN81P60A065I','JAMSTEC','4XPCU','IKWQC','Mappatrice dei fondali'),('Leopoldo','Longis','LNGLLD63E27H078A','JAMSTEC','6G11M','N320M','Ingegnere informatico'),('Elettra','Longhi','LNGLTR80E46A487Z','Ocean Exploration Trust','WK8OQ','D5UY2','Biologa Marina'),('Sibilla','Lino','LNISLL56S51I682L','NOAA','R67EF','WYM3J','Ingegnere informatico'),('Eleuterio','Monodutto','MDNLTR10H18D579I','JAMSTEC','6G11M','GTSU0','Pilota ROV'),('Fermo','Maderna','MDRFRM35R22G333A','Ocean Exploration Trust','WK8OQ','3SAVX','Navigatore'),('Porziano','Mango','MNGPZN78T17I585O','JAMSTEC','6G11M','V99VN','Biologo Marino'),('Marco','Maiori','MRAMRC34P28A831L','JAMSTEC','A9MFE','VQG2A','Ingegnere informatico'),('Ines','Maresca','MRSNSI86D50F870U','Ocean Exploration Trust','WK8OQ','5BWBU','Mappatrice dei fondali'),('Uberto','Mazzali','MZZBRT40E18D870G','JAMSTEC','6G11M','JCS6S','Biologo Marino'),('Nossardi','Spartaco','NSSSRT08P10F354F','Ocean Exploration Trust','WK8OQ','2ASC2','Ingegnere informatico'),('Tiziana','Nozia','NSSTZN90D48G109B','Ocean Exploration Trust','WK8OQ','QPMUC','Biologa Marina'),('Emiliana','Paoli','PLAMLN67B42E581W','JAMSTEC','4XPCU','W7SSD','Mappatrice dei fondali'),('Isidora','Palamuso','PLMSDR56L57H888Q','JAMSTEC','4XPCU','9YTO3','Ingegnere informatico'),('Milena','Pantoni','PNTMLN54L46G411L','JAMSTEC','A9MFE','8TK8W','Biologo Marino'),('Orsolina','Piperis','PPRRLN40R51D300P','Ocean Exploration Trust','WK8OQ','QCHWS','Mappatrice dei fondali'),('Albano','Pardini','PRDLBN98C08G407G','NOAA','QHK1T','2IWX9','Navigatore'),('Tosca','Poratto','PRTTSC07H57L828J','Ocean Exploration Trust','WK8OQ','QGL52','Mappatrice dei fondali'),('Camilla','Pescetto','PSCCLL54M46A701K','NOAA','QHK1T','Z2MU0','Ingegnere informatico'),('Lia','Pasqualone','PSQLIA79E65L963A','NOAA','DEIJB','KYEVS','Pilota ROV'),('Adalberto','Opezzi','PZZDBR12E07I459M','Ocean Exploration Trust','WK8OQ','TSYB1','Navigatore'),('Secondo','Pizzorno','PZZSND75A30H338Z','Ocean Exploration Trust','WK8OQ','ZZXA2','Mappatore dei fondali'),('Beatrice','Recchia','RCCBRC93H44G327I','JAMSTEC','A9MFE','WW843','Biologo Marino'),('Romolo','Scaravelli','SCRRML84M19A468J','NOAA','R67EF','RKR2Y','Mappatore dei fondali'),('Ottilia','Sciorto','SCRTTL91A55E311P','JAMSTEC','4XPCU','H7DTT','Pilota ROV'),('Volfango','Scaramelli','SCRVFN09C03G849L','Ocean Exploration Trust','WK8OQ','CPAEG','Mappatore dei fondali'),('Cirillo','Sammartano','SMMCLL81B11H955W','NOAA','R67EF','843M2','Pilota ROV'),('Lorella','Suardi','SRDLLL95C55I668D','NOAA','DEIJB','JR8U6','Pilota ROV'),('Palmira','Siro','SRIPMR35T55G289A','Ocean Exploration Trust','WK8OQ','32SEF','Navigatrice'),('Noè','Soranzo','SRNNOX70A01F453K','Ocean Exploration Trust','WK8OQ','PXCVM','Ingegnere informatico'),('Luigia','Sartorio','SRTLGU41B61D281R','Ocean Exploration Trust','WK8OQ','FOQN5','Pilota ROV'),('Gillo','Sassoni','SSSGLL73R07E061P','NOAA','QHK1T','PZEYP','Mappatore dei fondali'),('Piersilvio','Troìa','TROPSL18L08F773R','Ocean Exploration Trust','WK8OQ','8Y24K','Biologo Marino'),('Angela','Torretti','TRRNGL74E42G792Y','NOAA','R67EF','AQA93','Pilota ROV'),('Iolanda','Ottolini','TTLLND93S69E632F','JAMSTEC','4XPCU','U5BYP','Pilota ROV'),('Abelardo','Vendramin','VNDBRD98B05H648Z','Ocean Exploration Trust','WK8OQ','GGQ7Z','Biologo Marino'),('Secondo','Vitari','VTRSND37C02B660V','Ocean Exploration Trust','WK8OQ','3OP6P','Biologo Marino'),('Adelchi','Zazzeri','ZZZDCH96S13L336N','NOAA','DEIJB','O9UUH','Navigatore'),('Vanessa','Zazzeroni','ZZZVSS47T51F685Q','JAMSTEC','6G11M','FM6YY','Pilota ROV');
/*!40000 ALTER TABLE `membro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organismo`
--

DROP TABLE IF EXISTS `organismo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `organismo` (
  `ID` varchar(10) NOT NULL,
  `Specie` char(50) DEFAULT NULL,
  `Nome_provvisorio` char(50) DEFAULT NULL,
  `Nome_comune` char(50) DEFAULT NULL,
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
INSERT INTO `organismo` VALUES ('0F5W9M2W7L','Tiburonia granrojo',NULL,'Grande medusa rossa','Il nome di questa medusa deriva dai suoi colori rossi della campana (granrojo = grande rosso in spagnolo). Presenta una campana di grandi dimensioni, mentre i tentacoli sono più corti e tozzi.'),('364FIFD9JR','Atolla wyvillei',NULL,NULL,'Questa specie di medusa presenta una campana rossa e un lungo tentacolo bianco che parte dal centro della campana e si allunga per una decina di centimetri'),('6567LBSV3P','Larvacean',NULL,NULL,'I larvacei sono tunicati che abitano diverse zone degli oceani di tutto il mondo, per nutrirsi utilizzano una \"barriera\"\" di muco che filtra le sostanze nutritive.\"'),('7F0JSTSGR0','Magnapinna atlantica',NULL,NULL,'Questi calamari sono caratterizzati, come gli altri membri del loro genere, da tentacoli molto lunghi, anche fino a 8 metri. Abitano le zone più profonde e oscure degli oceani, ancora non si sa di cosa si nutrono e le loro abitudini.'),('83SIM574N8','Hexatrygon bickelli',NULL,'Razza esabranchiata','Questa specie di razza presenta 6 paia di branchie, da cui deriva il suo nome. La testa è allungata e le dimensioni totali possono raggiungere anche 1.7m. Solitamente vivono a stretto contatto con il fondale marino.'),('A69M3QUS9A','Beroe forskalii',NULL,'Medusa pettine','Questa specie di ctenoforo di piccole dimensioni presenta un corpo completamente trasparente, fatta eccezione di filamenti \"dentati\"\" all\'interno del corpo\"'),('ACGEAS7P9A',NULL,'Pesce verticale',NULL,'Questa specie di pesce è nota per la sua abitudine nel rimanere fermo in posizione verticale, con la testa rivolta verso l\'alto, nonostante il movimento in acqua è comune a tutti gli altri pesci.'),('AI4CEQC9PM',NULL,'Medusa quadri-tentacolo',NULL,'Questa medusa di piccole dimensioni presenta 4 sottili tentacoli e una campana trasparente con un anello fluorescente. Utilizza la propulsione causata dal movimento della campana per muoversi.'),('EAU993XFSA','Deepstaria enigmatica',NULL,NULL,'Queste meduse sono solite abitare profondità elevate. Possiedono una larga ma sottile campana trasparente, che può raggiungere anche i 2 metri di larghezza. Non possiedono tentacoli e vivono in solitudine.'),('EZH5BFUT5O','Lampocteis cruentiventer',NULL,'Ctenoforo dal ventre insanguinato','Questo ctenoforo presenta un colore rosso molto intenso e dei filamenti interni seghettati che vengono talvolta attraversati da particelle bio-luminose sconosciute. Al momento sono l\'unica specie conosciuta del loro genere.'),('JANN0QNIG4','Psychrolutes phrictus',NULL,'Blob sculpin','Questa specie di sculpin abita le profondità più oscure degli oceani. Presentano diverse spine, come tutte le altre specie di sculpin, ma presentano anche una corporatura più tozza.'),('KHRIIMYK0J','Marrus orthocana',NULL,'Medusa sifonofora cintura di fuoco','Questa specie di sifonoforo presenta un colore rosso/arancio intenso, essendo i sifonofori dei raggruppamenti di organismi, può assumere diverse forme, caratterizzate solitamente da filamenti intrecciati.'),('LBPHU6GZV0','Enypniastes eximia',NULL,'Danzatore spagnolo','Questa specie di cetriolo marino nuota a profondità elevate. Presenta una colorazione accesa, solitamente rosso, rosa o arancione.'),('ORYC2H5PF4','Albatrossia pectoralis',NULL,'Coda di ratto gigante','Questo pesce è solito abitare il suolo marino. Possiede una corporatura tozza con una coda più sottile. Esemplari di questa specie possono crescere anche fino a 2 metri di lunghezza.'),('P4FPZBSA8O','Solmissus',NULL,'Medusa piatto da cena','Questa specie di medusa presenta numerosi e sottili tentacoli. La campana è quasi completamente trasparente. Sia i tentacoli che la campana sono fluorescenti e di colore bianco/azzurro.'),('UDPDW13YB8','Taonius borealis',NULL,'Calamaro cacatua','Questa specie di calamaro presenta un mantello e pinne trasparenti, che permettono la visibilità dall\'esterno degli organi interni. I tentacoli sono corti e bianchi, ma rossi sulla punta. Gli occhi sono di colore rosso mattone.'),('VKFBS2ECGG','Periphyllopsis braueri',NULL,NULL,'Queste meduse presentano una campana spessa e di colore grigio/viola. I tentacoli sono molto sottili e genericamente di colore bianco. La campana presenta inoltre delle appendici che si muovono come i petali di un fiore, chiudendosi concentricamente per spingersi in avanti.'),('VL5L84606R',NULL,'Gambero pesante',NULL,'Questa specie di gambero utilizza una dura corazza per proteggersi; questo comporta un maggiore peso, che non gli permette di nuotare come altre specie di gamberetti. Saranno necessari ulteriori studi.'),('WOCOAYY52M','Pycnogonid',NULL,'Ragno marino','Questi artropodi sono stati osservati a profondità elevate, gli esemplari possono essere di colore diverso e tutti posseggono otto zampe sottili, come i ragni comuni, e un torso piccolo.'),('WOXO3HBSWG','Hexanchus griseus',NULL,'Squalo vacca','Questo squalo presenta 6 paia di branchie e un muso schiacciato. Possono crescere fino a 6 metri di lunghezza.');
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
INSERT INTO `paese` VALUES ('Alaska'),('Ecuador'),('Giappone'),('Messico'),('Papua Nuova Guinea');
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
INSERT INTO `prelievo` VALUES ('F448LXLYCN',1,2300,1.7,'Le rocce sono state prelevate nelle vicinanze di un vulcano sottomarino.','FKCHELYUK3','Rocce effusive');
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
INSERT INTO `rov` VALUES ('4GMW310','HO4IUJKLRY','Seatrepid International','2017-05-26'),('68F6868','76HF6YN1HT','VideoRay','2006-11-28'),('8AGD854','82FVVRU6G6','EyeROV','2000-02-17'),('8GPK420','FOEYGBHH84','Blue Robotics Inc.','2018-10-09'),('AB123CD','0000ZZ0000','Blue Robotics Inc.','2018-11-03'),('C606966','8U59P369AP','EyeROV','1996-01-10'),('C719058','RCMEXFIGYB','EyeROV','1996-08-21'),('CWP8099','F49RXV36NF','Blue Robotics Inc.','1993-02-27'),('EQE2435','16GWSA733K','Oceaneering','2016-12-03'),('HWN1325','ZU01FVTECU','VideoRay','2011-03-09'),('JFG1274','8N267FNXXW','Oceaneering','2001-12-10'),('KGS4116','G15FFEYEOM','Blue Robotics Inc.','1993-10-03'),('KVK93A4','OWZ8AYURQP','Oceaneering','2002-07-29'),('MJV3440','HOQXK3F9OB','Seatrepid International','2006-08-16'),('MQP6080','0JHBW0POMH','Blue Robotics Inc.','1990-05-27'),('TOY8671','VH0HFI8FIC','Oceaneering','2000-11-06'),('VT16752','LFLRJTRGCL','Blue Robotics Inc.','2016-05-24');
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
INSERT INTO `spedizione` VALUES ('FKCHELYUK3','2023-07-02','Fossa delle Aleutine','8GPK420','Ocean Exploration Trust','WK8OQ'),('SSEY2O52BP','2023-07-21','Fossa delle Aleutine','8GPK420','Ocean Exploration Trust','WK8OQ'),('VJ4EIJACWK','2023-06-18','Fossa delle Aleutine','VT16752','Ocean Exploration Trust','WK8OQ');
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

-- Dump completed on 2023-08-17 10:06:59
