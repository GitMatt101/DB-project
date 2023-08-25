-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: esplorazioni
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

CREATE DATABASE IF NOT EXISTS `esplorazioni`;
USE `esplorazioni`;

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
  CONSTRAINT `SID_ANALI_PRELI_FK` FOREIGN KEY (`CodicePrelievo`) REFERENCES `prelievi` (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `analisi`
--

LOCK TABLES `analisi` WRITE;
/*!40000 ALTER TABLE `analisi` DISABLE KEYS */;
INSERT INTO `analisi` VALUES ('AXVEPGD5IO','KFUIGY39MI','Le rocce sono molto porose e contengono microbatteri che si cibano di microalghe.','ULWBH49TK3'),('P8S1O8LXMB','PVCF1OI69J','L\'acqua presenta un ph molto acido.','5QI2OBZ68Y'),('PJKXG2O711','ACFEIA1HJ0','Diversi micro organismi sono stati trovati nella fanghiglia.','ULWBH49TK3'),('PT60GDKMGJ','OB630R72NT','Le rocce sono molto resistenti e sembrano risalire a 200 anni fa.','9V8C6OD190'),('QAMAWGUL6P','E3VK5J2IRZ','Le alghe presentano una fitta rete di strie.','9V8C6OD190'),('SVYPJZV2QW','GNHD1HINCD','Ci sono tracce di ferro e piombo nella sabbia.','5QI2OBZ68Y'),('UXJCPAOFR7','BXW0O22NCI','Le rocce sono molto fragili e contengono tracce di nichel.','1HCEBWYJZO'),('VE25GP6AMJ','JVTUYZK0YS','Nessuna particolarità riscontrata nella sabbia','K000CMF3UJ');
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
  UNIQUE KEY `ID_ASSOCIAZIONI_IND` (`Nome`)
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
  UNIQUE KEY `SID_AVVISTAMENTI_ID` (`CodiceSpedizione`,`Numero`),
  UNIQUE KEY `ID_AVVISTAMENTI_IND` (`Codice`),
  UNIQUE KEY `SID_AVVISTAMENTI_IND` (`CodiceSpedizione`,`Numero`),
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
INSERT INTO `avvistamenti` VALUES ('23MW6DPXGT',3,'NRBWSLDM1X',4100,NULL,NULL,NULL,'WU2QH'),('3NKJPQ1L5L',6,'612V1DWEUB',1400,'Il relitto risulta infestato da granchi.',NULL,'E25HM',NULL),('3RMLRBTZS9',1,'UI13BGB839',3300,NULL,NULL,NULL,'UQI12'),('401OZSZ04A',1,'L58ZW1K7SR',1219,'L\'esmplare non ha eseguito movimenti per tutta la durata dell\'avvistamento, con i tentacoli ad angolo retto verso il basso','7F0JSTSGR0',NULL,NULL),('4WHB04IKXV',3,'612V1DWEUB',3000,NULL,NULL,NULL,'XCJ9Y'),('7876I2RYN3',2,'VJ4EIJACWK',NULL,'Il pesce mantiene una posizione verticale, con la testa rivolta verso l\'alto.','ACGEAS7P9A',NULL,NULL),('7P8890DFLN',1,'EIO8UZ1VVO',1103,NULL,'UDPDW13YB8',NULL,NULL),('8RRJGLX6NQ',3,'FKCHELYUK3',NULL,'La medusa presenta un tentacolo centrale relativamente lungo rispetto degli altri esemplari, facendo pensare che quelli visti finora potrebbero non essere completamente formati.','364FIFD9JR',NULL,NULL),('9HB0ILTDOL',5,'Q6XUWM8AXS',NULL,NULL,NULL,'AIX4V',NULL),('9KCBSNB37Q',1,'SSEY2O52BP',NULL,NULL,'P4FPZBSA8O',NULL,NULL),('9T3MWRVPM5',1,'FKCHELYUK3',NULL,NULL,'364FIFD9JR',NULL,NULL),('AZQ7W1DHDV',3,'VJ4EIJACWK',700,'Il sifonoforo non ha eseguito alcun movimento per tutta la durata dell\'osservazione. Attorno all\'organismo sono presenti degli altri di piccole dimensioni, non si sa se fanno parte del sifonoforo.','KHRIIMYK0J',NULL,NULL),('CPL43Y2Y71',6,'Q6XUWM8AXS',NULL,NULL,NULL,'028HM',NULL),('EODISH5X48',3,'SSEY2O52BP',NULL,NULL,'AI4CEQC9PM',NULL,NULL),('FGSUWEMP9J',3,'UI13BGB839',3800,NULL,NULL,NULL,'FOQ3N'),('FKIVZU9S2H',3,'L58ZW1K7SR',2300,NULL,NULL,NULL,'C7RIN'),('FRG2FXY0E5',2,'SSEY2O52BP',NULL,NULL,'P4FPZBSA8O',NULL,NULL),('GBE6TTTT6M',2,'612V1DWEUB',NULL,NULL,NULL,'CWEGZ',NULL),('GI55FHQUSB',2,'FKBECBJLP3',NULL,'La barca viene utilizzata come dimora per diversi organismi, soprattutto granchi.',NULL,'L8UNN',NULL),('IDBGFS04M1',4,'NRBWSLDM1X',NULL,NULL,'7F0JSTSGR0',NULL,NULL),('IK63O6VH5M',1,'Q6XUWM8AXS',NULL,NULL,NULL,'4OXAY',NULL),('IZND8WXHHJ',1,'FKBECBJLP3',NULL,'Questo esemplare risulta essere in grado di nuotare.','WOCOAYY52M',NULL,NULL),('JTXMQ1M1JV',4,'VJ4EIJACWK',NULL,'L\'esemplare sembra muoversi all\'interno della sua casa di muco che utilizza per filtrare i nutrimenti. La massa di muco risulta essere completamente trasparente e sembra catturare diverse particelle fluttuanti presenti nell\'acqua.','6567LBSV3P',NULL,NULL),('JW0XFJ7KUC',2,'L58ZW1K7SR',3400,NULL,NULL,NULL,'BQGI4'),('K1BEQ6GABA',2,'NRBWSLDM1X',3500,NULL,NULL,NULL,'VX2AQ'),('K6M87M31KP',5,'612V1DWEUB',NULL,NULL,NULL,'FQ7W1',NULL),('K9OOGNXC57',1,'612V1DWEUB',NULL,NULL,NULL,'1PR3Q',NULL),('KASMNK5P8H',1,'VJ4EIJACWK',NULL,'L\'esemplare sembra fluttuare in posizione verticale, con il mantello rivolto verso il basso.','UDPDW13YB8',NULL,NULL),('LVMJ75YV5I',2,'UI13BGB839',2700,NULL,NULL,NULL,'DXS44'),('M12N6V4KLL',5,'NRBWSLDM1X',NULL,NULL,NULL,'4CQUV',NULL),('M6123P1H5L',8,'Q6XUWM8AXS',2100,'I danni osservati allo scafo fanno pensare ad un attacco tramite siluri che ha causato l\'affondamento.',NULL,'DWEUB',NULL),('MM75QS2G99',2,'Q6XUWM8AXS',NULL,NULL,NULL,'149YY',NULL),('OFNLGETKUL',4,'Q6XUWM8AXS',NULL,NULL,NULL,'Y8ELP',NULL),('OMKG42N62Z',7,'Q6XUWM8AXS',2200,NULL,NULL,'BXSCZ',NULL),('QIE3ZMHGK5',3,'Q6XUWM8AXS',NULL,NULL,NULL,'8O19Y',NULL),('RMFW7HUQUB',1,'YJZX5W42AW',283,NULL,'B7V6YL5IBY',NULL,NULL),('VJAQWNI163',4,'612V1DWEUB',1300,NULL,NULL,'Q0XIS',NULL),('W7UXUWRWBN',2,'FKCHELYUK3',NULL,'I filamenti seghettati all\'interno del corpo della medusa sembrano essere bioluminescenti.','A69M3QUS9A',NULL,NULL),('WLP2515SQX',1,'NRBWSLDM1X',2800,NULL,NULL,NULL,'V4EP8'),('X98MJF28RS',4,'FKCHELYUK3',900,NULL,'0F5W9M2W7L',NULL,NULL),('ZH305PH7FV',4,'SSEY2O52BP',3400,NULL,NULL,NULL,'AI3YA'),('ZTKKQKMUAL',2,'EIO8UZ1VVO',1132,NULL,'5Y29POQFGS',NULL,NULL);
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
  UNIQUE KEY `ID_CASE_PRODUTTRICI_IND` (`Nome`)
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
  `Dimensioni` decimal(6,0) NOT NULL,
  `GradoPericolo` decimal(1,0) NOT NULL,
  `Descrizione` text NOT NULL,
  `Tipologia` char(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_FORMAZIONI_GEOLOGICHE_IND` (`ID`),
  KEY `REF_FORMA_TIPOL_IND` (`Tipologia`),
  CONSTRAINT `REF_FORMA_TIPOL_FK` FOREIGN KEY (`Tipologia`) REFERENCES `tipologie` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formazioni_geologiche`
--

LOCK TABLES `formazioni_geologiche` WRITE;
/*!40000 ALTER TABLE `formazioni_geologiche` DISABLE KEYS */;
INSERT INTO `formazioni_geologiche` VALUES ('AI3YA',1500,3,'La fessura emette lava in continuazione senza però effettuare violente eruzioni, dovrà essere monitorato costantemente','Vulcano sottomarino'),('BQGI4',800,4,'Il vulcano si è verificato essere attivo, grandi quantità di lava vengono rilasciate periodicamente senza però eventi violenti. Le città marittime più vicine sono state informate del possibile pericolo di una eruzione violenta ed è stato designato un piano di evacuazione.','Vulcano sottomarino'),('C1AE0',1000,2,'Il vulcano sembra inattivo, ma emana calore elevato, facendo presagire che possa attivarsi in un futuro prossimo, bisognerà monitorare l\'attività.','Vulcano sottomarino'),('C7RIN',100,2,'La grotta è caratterizzata da stretti tunnel che rendono difficile l\'esplorazione. Le pareti e il soffitto della grotta sono composti da rocce porose caratterizzate da buchi con un diametro fino a 10 cm.','Grotta sottomarina'),('DXS44',1000,2,'Il vulcano sembra essere parzialmente attivo, le emissioni di lava sono incostanti e scarse.','Vulcano sottomarino'),('FOQ3N',2800,4,'Chiamato anche Imperatore della Cina, il vulcano non erutta dal 1927 ed è stato molto attivo in tempi lontani, è necessario monitorarlo costantemente, in quanto un\'eruzione potrebbe causare violenti tsunami.','Vulcano sottomarino'),('M8L2Z',10,0,'La fumarola è attiva ed emette fumo costantemente ma non rappresenta un pericolo per l\'habitat circostante.','Fumarola nera'),('UQI12',5,0,'La fumarola emette fumo da 3 diversi punti ma è stata dichiarata innocua.','Fumarola nera'),('V4EP8',300,1,'Il vulcano è stato confermato essere inattivo, probabilmente ha esaurito il magma nella camera magmatica. Sarà comunque necessario monitorarlo per controllare eventuali crolli della camera magmatica causati dalla pressione.','Vulcano sottomarino'),('VX2AQ',300,0,'La grotta, accessibile dalla superficie, presenta numerose stalattiti sul soffitto. E\' caratterizzata da ampie camere rocciose, in alcune di esse le stalattiti e stalagmiti si congiungono creando delle colonne.','Grotta sottomarina'),('WU2QH',3,1,'La fumarola emette violentemente grandi quantità di fumo.','Fumarola nera'),('XCJ9Y',500,0,'La grotta è caratterizzata da numerosi e larghi tunnel che permettono di navigarla con sicurezza. Alcuni tunnel sono piastrellati da rocce trasportate da forti correnti o movimenti geologici.','Grotta sottomarina');
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
  `Nome` char(30) NOT NULL,
  PRIMARY KEY (`NomeAssociazione`,`Nome`),
  UNIQUE KEY `ID_GRUPPI_DI_ESPLORAZIONE_IND` (`NomeAssociazione`,`Nome`),
  CONSTRAINT `EQU_GRUPP_ASSOC` FOREIGN KEY (`NomeAssociazione`) REFERENCES `associazioni` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gruppi_di_esplorazione`
--

LOCK TABLES `gruppi_di_esplorazione` WRITE;
/*!40000 ALTER TABLE `gruppi_di_esplorazione` DISABLE KEYS */;
INSERT INTO `gruppi_di_esplorazione` VALUES ('JAMSTEC','Mirai'),('JAMSTEC','Shinsei Maru'),('JAMSTEC','Yokosuka'),('NOAA','Atlantis'),('NOAA','Falkor'),('NOAA','Pisces'),('Ocean Exploration Trust','Nautilus'),('OceanX AG','OceanXplorer'),('Odyssey Marine Exploration','Odyssey DNA');
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
  UNIQUE KEY `ID_LABORATORI_IND` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratori`
--

LOCK TABLES `laboratori` WRITE;
/*!40000 ALTER TABLE `laboratori` DISABLE KEYS */;
INSERT INTO `laboratori` VALUES ('Guglielmo Marconi','1HCEBWYJZO','Via della Costituzione, 220, 52037 Sansepolcro AR, Italia'),('Nikola Tesla','5QI2OBZ68Y','567 NW 2nd St, Prineville, OR 97754, Stati Uniti'),('Isaac Newton','9V8C6OD190','Via G. Fucà, 144, 41122 Modena MO, Italia'),('Aldo Moro','K000CMF3UJ','Viale Adriatico, 1, 61032 Fano PU, Italia'),('Guglielmo Marconi','ULWBH49TK3','10411 Heinz Way, Henderson, CO 80640, Stati Uniti');
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
  UNIQUE KEY `ID_LUOGHI_IND` (`Nome`),
  KEY `EQU_LUOGHI_PAESI_IND` (`NomePaese`),
  CONSTRAINT `EQU_LUOGHI_PAESI_FK` FOREIGN KEY (`NomePaese`) REFERENCES `paesi` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `luoghi`
--

LOCK TABLES `luoghi` WRITE;
/*!40000 ALTER TABLE `luoghi` DISABLE KEYS */;
INSERT INTO `luoghi` VALUES ('Mar Baltico',NULL),('Mar dei Caraibi',NULL),('Mare del Nord',NULL),('Oceano Atlantico',NULL),('Oceano Indiano',NULL),('Fossa delle Aleutine','Alaska'),('Isole Galapagos','Ecuador'),('Baia Sagami','Giappone'),('Costa di Sanriku','Giappone'),('Fossa del Giappone','Giappone'),('Golfo del Messico','Messico'),('Manus Basin','Papua Nuova Guinea');
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
  UNIQUE KEY `ID_MATERIALI_IND` (`Nome`)
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
  `NomeGruppo` char(30) NOT NULL,
  `Ruolo` char(50) NOT NULL,
  PRIMARY KEY (`CodiceFiscale`),
  UNIQUE KEY `SID_MEMBRI_ID` (`NomeAssociazione`,`NomeGruppo`,`ID`),
  UNIQUE KEY `ID_MEMBRI_IND` (`CodiceFiscale`),
  UNIQUE KEY `SID_MEMBRI_IND` (`NomeAssociazione`,`NomeGruppo`,`ID`),
  KEY `REF_MEMBR_RUOLI_IND` (`Ruolo`),
  CONSTRAINT `EQU_MEMBR_GRUPP` FOREIGN KEY (`NomeAssociazione`, `NomeGruppo`) REFERENCES `gruppi_di_esplorazione` (`NomeAssociazione`, `Nome`),
  CONSTRAINT `REF_MEMBR_RUOLI_FK` FOREIGN KEY (`Ruolo`) REFERENCES `ruoli` (`Tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `membri`
--

LOCK TABLES `membri` WRITE;
/*!40000 ALTER TABLE `membri` DISABLE KEYS */;
INSERT INTO `membri` VALUES ('Cleopatra','Badolato','BDLCPT05T58D958T','2U93A','Ocean Exploration Trust','Nautilus','Pilota ROV'),('Libero','Barbaresco','BRBLBR77A13F102K','QYA2L','NOAA','Atlantis','Navigatore'),('Brandolisi','Gemma','BRNGMM55E51C488N','7JZ3N','JAMSTEC','Shinsei Maru','Biologa Marina'),('Licia','Beradino','BRRLCI00A60A579V','SV05U','JAMSTEC','Shinsei Maru','Ingegnere'),('Consolata','Bratus','BRTCSL99H56D005K','L4IAK','Ocean Exploration Trust','Nautilus','Mappatrice dei fondali'),('Lodovico','Bertucci','BRTLVC61S11I243D','27QUX','NOAA','Pisces','Mappatore dei fondali'),('Monica','Biti','BTIMNC13H69D261D','FZ7CG','JAMSTEC','Mirai','Mappatrice dei fondali'),('Fabio','Bottega','BTTFBA40B11A945I','0J4Q3','NOAA','Pisces','Mappatore dei fondali'),('Nazario','Bozzi','BZZNZR05P10H850O','ASIEA','Ocean Exploration Trust','Nautilus','Ingegnere'),('Arrigo','Acca','CCARRG05B27B829D','INNJ6','Ocean Exploration Trust','Nautilus','Ingegnere'),('Beatrice','Ceccadrini','CCCBRC71R71B748T','7CT2Y','Ocean Exploration Trust','Nautilus','Pilota ROV'),('Romina','Cecio','CCERMN71D44B778Q','JALWM','Ocean Exploration Trust','Nautilus','Biologa Marina'),('Casimiro','Clun','CLNCMR30S02I565H','6Q9ER','NOAA','Atlantis','Biologo Marino'),('Elisabetta','Celentani','CLNLBT70R66C904O','LVXPW','NOAA','Falkor','Biologa Marina'),('Ezechiele','Clerico','CLRZHL62M16A736H','6RBB6','Ocean Exploration Trust','Nautilus','Navigatore'),('Raffaella','Iacopo','CPIRFL51S45L019B','231RK','JAMSTEC','Yokosuka','Ingegnere'),('Moreno','Cipollini','CPLMRN81T24B559M','E5W7D','JAMSTEC','Shinsei Maru','Biologo Marino'),('Igino','Coppola','CPPGNI04S11E390S','8DBPE','NOAA','Atlantis','Mappatore dei fondali'),('Alfonso','Acerbis','CRBLNS06A07B719G','0HQIG','NOAA','Pisces','Ingegnere'),('Giuda','Cornaro','CRNGDI74B05G978U','Y61FC','JAMSTEC','Mirai','Ingegnere'),('Gaia','Corti','CRTGAI87H57H439A','4TWU0','NOAA','Falkor','Biologo Marino'),('Camillo','Ciussani','CSSCLL36C19B368V','84CAM','JAMSTEC','Yokosuka','Mappatrice dei fondali'),('Susanna','Castagna','CSTSNN43P54G955G','0PQ1K','JAMSTEC','Shinsei Maru','Biologa Marina'),('Fiorella','Catania','CTNFLL41E70C409T','A3RAR','Ocean Exploration Trust','Nautilus','Mappatrice dei fondali'),('Augusto','Ciutti','CTTGST35L17E206D','S7M8O','Ocean Exploration Trust','Nautilus','Biologo Marino'),('Walter','Cotta','CTTWTR74L12A008M','3K5Z7','NOAA','Falkor','Ingegnere'),('Ersilia','Coveri','CVRRSL08P66B427G','HP7N2','NOAA','Atlantis','Biologa Marina'),('Alvise','Degrossi','DGRLVS98E18D978M','H0UY9','Ocean Exploration Trust','Nautilus','Biologo Marino'),('Nereo','Degrossi','DGRNRE54R07A979H','DD6AG','JAMSTEC','Yokosuka','Pilota ROV'),('Aldo','D\'Amici','DMCLDA78P22H238H','ARC3P','NOAA','Pisces','Pilota ROV'),('Elvira','Dorgnach','DRGLVR97D57L440D','KVBTV','JAMSTEC','Mirai','Mappatrice dei fondali'),('Giada','Flandina','FLNGDI44B54B461E','2Q37U','NOAA','Falkor','Biologa Marina'),('Romualdo','Florindi','FLRRLD91P28D553A','00VXE','NOAA','Pisces','Mappatore dei fondali'),('Rinaldo','Frezzolino','FRZRLD34R05A825N','3JRDU','JAMSTEC','Yokosuka','Pilota ROV'),('Agata','Galantini','GLNGTA91P45D470Y','SCP3V','NOAA','Atlantis','Navigatrice'),('Quirino','Gorga','GRGQRN36T31A053X','CIB9E','Ocean Exploration Trust','Nautilus','Pilota ROV'),('Loreno','Gerevini','GRVLRN59H03A418T','JEKJ6','Ocean Exploration Trust','Nautilus','Pilota ROV'),('Morgana','Gazzetta','GZZMGN08E60I701X','COLZW','Ocean Exploration Trust','Nautilus','Biologa Marina'),('Pamela','Alberghini','LBRPML02H52D962S','OH6II','JAMSTEC','Yokosuka','Mappatrice dei fondali'),('Floriana','Limonta','LMNFRN81P60A065I','IKWQC','JAMSTEC','Shinsei Maru','Mappatrice dei fondali'),('Leopoldo','Longis','LNGLLD63E27H078A','N320M','JAMSTEC','Mirai','Ingegnere'),('Elettra','Longhi','LNGLTR80E46A487Z','D5UY2','Ocean Exploration Trust','Nautilus','Biologa Marina'),('Sibilla','Lino','LNISLL56S51I682L','WYM3J','NOAA','Falkor','Ingegnere'),('Eleuterio','Monodutto','MDNLTR10H18D579I','GTSU0','JAMSTEC','Mirai','Pilota ROV'),('Fermo','Maderna','MDRFRM35R22G333A','3SAVX','Ocean Exploration Trust','Nautilus','Navigatore'),('Ennio','Molignano','MLGNNE65B17G213I','YBRZE','OceanX AG','OceanXplorer','Mappatore dei fondali'),('Porziano','Mango','MNGPZN78T17I585O','V99VN','JAMSTEC','Mirai','Biologo Marino'),('Glauco','Monassi','MNSGLC39M15E962J','MKSMV','OceanX AG','OceanXplorer','Navigatore'),('Marco','Maiori','MRAMRC34P28A831L','VQG2A','JAMSTEC','Yokosuka','Ingegnere'),('Fulvio','Mirabilio','MRBFLV49H03G223X','XFGOL','OceanX AG','OceanXplorer','Biologo marino'),('Franco','Mardegan','MRDFNC07H20H433T','4O3YJ','OceanX AG','OceanXplorer','Pilota ROV'),('Ines','Maresca','MRSNSI86D50F870U','5BWBU','Ocean Exploration Trust','Nautilus','Mappatrice dei fondali'),('Uberto','Mazzali','MZZBRT40E18D870G','JCS6S','JAMSTEC','Mirai','Biologo Marino'),('Spartaco','Nossardi','NSSSRT08P10F354F','2ASC2','Ocean Exploration Trust','Nautilus','Ingegnere'),('Tiziana','Nozia','NSSTZN90D48G109B','QPMUC','Ocean Exploration Trust','Nautilus','Biologa Marina'),('Agostino','Neiviller','NVLGTN80S02I570N','KK6ZF','OceanX AG','OceanXplorer','Pilota ROV'),('Emiliana','Paoli','PLAMLN67B42E581W','W7SSD','JAMSTEC','Shinsei Maru','Mappatrice dei fondali'),('Isidora','Palamuso','PLMSDR56L57H888Q','9YTO3','JAMSTEC','Shinsei Maru','Ingegnere'),('Milena','Pantoni','PNTMLN54L46G411L','8TK8W','JAMSTEC','Yokosuka','Biologo Marino'),('Orsolina','Piperis','PPRRLN40R51D300P','QCHWS','Ocean Exploration Trust','Nautilus','Mappatrice dei fondali'),('Albano','Pardini','PRDLBN98C08G407G','2IWX9','NOAA','Pisces','Navigatore'),('Tosca','Poratto','PRTTSC07H57L828J','QGL52','Ocean Exploration Trust','Nautilus','Mappatrice dei fondali'),('Camilla','Pescetto','PSCCLL54M46A701K','Z2MU0','NOAA','Pisces','Ingegnere'),('Lia','Pasqualone','PSQLIA79E65L963A','KYEVS','NOAA','Atlantis','Pilota ROV'),('Adalberto','Opezzi','PZZDBR12E07I459M','TSYB1','Ocean Exploration Trust','Nautilus','Navigatore'),('Secondo','Pizzorno','PZZSND75A30H338Z','ZZXA2','Ocean Exploration Trust','Nautilus','Mappatore dei fondali'),('Beatrice','Recchia','RCCBRC93H44G327I','WW843','JAMSTEC','Yokosuka','Biologo Marino'),('Silvia','Rovasio','RVSSLV10A70H123F','PRKTH','OceanX AG','OceanXplorer','Mappatrice dei fondali'),('Baldassarre','Sbaraglio','SBRBDS12A12C457L','OIU1N','OceanX AG','OceanXplorer','Biologo marino'),('Livio','Sacchino','SCCLVI96P17A357V','BJP6U','OceanX AG','OceanXplorer','Ingegnere'),('Romolo','Scaravelli','SCRRML84M19A468J','RKR2Y','NOAA','Falkor','Mappatore dei fondali'),('Ottilia','Sciorto','SCRTTL91A55E311P','H7DTT','JAMSTEC','Shinsei Maru','Pilota ROV'),('Volfango','Scaramelli','SCRVFN09C03G849L','CPAEG','Ocean Exploration Trust','Nautilus','Mappatore dei fondali'),('Annunziata','Scioscia','SCSNNZ78M67H505B','JYOUL','OceanX AG','OceanXplorer','Ingegnere'),('Cirillo','Sammartano','SMMCLL81B11H955W','843M2','NOAA','Falkor','Pilota ROV'),('Lorella','Suardi','SRDLLL95C55I668D','JR8U6','NOAA','Atlantis','Pilota ROV'),('Palmira','Siro','SRIPMR35T55G289A','32SEF','Ocean Exploration Trust','Nautilus','Navigatrice'),('Luigia','Sartorio','SRTLGU41B61D281R','FOQN5','Ocean Exploration Trust','Nautilus','Pilota ROV'),('Gillo','Sassoni','SSSGLL73R07E061P','PZEYP','NOAA','Pisces','Mappatore dei fondali'),('Piersilvio','Troia','TROPSL18L08F773R','8Y24K','Ocean Exploration Trust','Nautilus','Biologo Marino'),('Angela','Torretti','TRRNGL74E42G792Y','AQA93','NOAA','Falkor','Pilota ROV'),('Iolanda','Ottolini','TTLLND93S69E632F','U5BYP','JAMSTEC','Shinsei Maru','Pilota ROV'),('Abelardo','Vendramin','VNDBRD98B05H648Z','GGQ7Z','Ocean Exploration Trust','Nautilus','Biologo Marino'),('Secondo','Vitari','VTRSND37C02B660V','3OP6P','Ocean Exploration Trust','Nautilus','Biologo Marino'),('Adelchi','Zazzeri','ZZZDCH96S13L336N','O9UUH','NOAA','Atlantis','Navigatore'),('Vanessa','Zazzeroni','ZZZVSS47T51F685Q','FM6YY','JAMSTEC','Mirai','Pilota ROV');
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
  `AnnoScoperta` smallint NOT NULL,
  `Descrizione` text NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_ORGANISMI_IND` (`ID`),
  UNIQUE KEY `SID_ORGANISMI_1_ID` (`Specie`),
  UNIQUE KEY `SID_ORGANISMI_ID` (`NomeProvvisorio`),
  UNIQUE KEY `SID_ORGANISMI_1_IND` (`Specie`),
  UNIQUE KEY `SID_ORGANISMI_IND` (`NomeProvvisorio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organismi`
--

LOCK TABLES `organismi` WRITE;
/*!40000 ALTER TABLE `organismi` DISABLE KEYS */;
INSERT INTO `organismi` VALUES ('0F5W9M2W7L','Tiburonia granrojo',NULL,'Grande medusa rossa',2003,'Il nome di questa medusa deriva dai suoi colori rossi della campana (granrojo = grande rosso in spagnolo). Presenta una campana di grandi dimensioni, mentre i tentacoli sono più corti e tozzi.'),('0X4IF7S4JJ','Aurelia cebimarensis',NULL,NULL,2021,'Medusa trasparente con tentacoli corti e sottili.'),('2FQKVRDU4A','Ophiojura exbodi',NULL,'Stella marina naso suino',2021,'Stella marina di colore arancione con 8 braccia e una bocca simile al naso di un maiale.'),('2M2QHTF7V3','Bythaelurus naylori',NULL,'Squalo gatto',2003,'Squalo di piccole dimensioni con muso schiacciato.'),('364FIFD9JR','Atolla wyvillei',NULL,NULL,1880,'Questa specie di medusa presenta una campana rossa e un lungo tentacolo bianco che parte dal centro della campana e si allunga per una decina di centimetri'),('3SOHQKK57S','Cirrhilabrus finifenmaa',NULL,'Pesce arcobaleno',2022,'Pesce di piccole dimensioni con colori sgargianti.'),('5Y29POQFGS',NULL,'Calamaro stella',NULL,1992,'Questo calamaro mantiene i tantacoli sempre distesi a stella.'),('6567LBSV3P','Larvacean',NULL,NULL,1821,'I larvacei sono tunicati che abitano diverse zone degli oceani di tutto il mondo, per nutrirsi utilizzano una \"barriera\"\"\"\"\"\"\"\" di muco che filtra le sostanze nutritive.\"\"\"\"\"\"\"'),('7F0JSTSGR0','Magnapinna atlantica',NULL,NULL,2006,'Questi calamari sono caratterizzati, come gli altri membri del loro genere, da tentacoli molto lunghi, anche fino a 8 metri. Abitano le zone più profonde e oscure degli oceani, ancora non si sa di cosa si nutrono e le loro abitudini.'),('83SIM574N8','Hexatrygon bickelli',NULL,'Razza esabranchiata',1980,'Questa specie di razza presenta 6 paia di branchie, da cui deriva il suo nome. La testa è allungata e le dimensioni totali possono raggiungere anche 1.7m. Solitamente vivono a stretto contatto con il fondale marino.'),('89ITJ2O47U','Hippocampus haema',NULL,'Cavalluccio marino nano',2017,'Cavalluccio marino di piccole dimensioni.'),('9IV2TSJ59V','Periclimenaeus karantina',NULL,NULL,2021,'Gamberetto che vive nelle spugne marine.'),('A69M3QUS9A','Beroe forskalii',NULL,'Medusa pettine',2004,'Questa specie di ctenoforo di piccole dimensioni presenta un corpo completamente trasparente, fatta eccezione di filamenti \"dentati\"\"\"\"\"\"\"\" all\'interno del corpo\"\"\"\"\"\"\"'),('ACGEAS7P9A',NULL,'Pesce verticale',NULL,2023,'Questa specie di pesce è nota per la sua abitudine nel rimanere fermo in posizione verticale, con la testa rivolta verso l\'alto, nonostante il movimento in acqua è comune a tutti gli altri pesci.'),('AI4CEQC9PM',NULL,'Medusa quadri-tentacolo',NULL,2023,'Questa medusa di piccole dimensioni presenta 4 sottili tentacoli e una campana trasparente con un anello fluorescente. Utilizza la propulsione causata dal movimento della campana per muoversi.'),('AW5KPFJ8LD','Periphylla periphylla',NULL,'Medusa elmetto',1810,'Questa specie di medusa possiede una campana simile ad un elmo utilizzato nel periodo medievale.'),('B7V6YL5IBY',' Thymopsis nilenta',NULL,NULL,1974,'Questa specie di crostacei è solita abitare dei buchi scavati nella sabbia e mostra un comportamento aggressivo se ci si avvicina'),('BP179KUPRQ','Stylobates calcifer',NULL,NULL,2022,'Questa anemone è solita attaccarsi ai gusci dei granchi eremiti.'),('C0EK6TITBY','Astrolirus patricki',NULL,'Stella marina Patrick',2020,'Stella marina color rosa-rossa con 5 braccia, il nome deriva dall\'omonimo personaggio d\'animazione.'),('D62SHGYXVT','Mola tecta',NULL,'Pesce sole',1990,'Pesce a forma di disco molto lento nei movimenti.'),('DNYUN4MN6Q','Chimaera carophila',NULL,'Squalo fantasma',2015,'Squalo di piccole dimensioni con una lunga coda. Si può trovare a profondità elevate.'),('EAU993XFSA','Deepstaria enigmatica',NULL,NULL,1967,'Queste meduse sono solite abitare profondità elevate. Possiedono una larga ma sottile campana trasparente, che può raggiungere anche i 2 metri di larghezza. Non possiedono tentacoli e vivono in solitudine.'),('EZH5BFUT5O','Lampocteis cruentiventer',NULL,'Ctenoforo dal ventre insanguinato',2001,'Questo ctenoforo presenta un colore rosso molto intenso e dei filamenti interni seghettati che vengono talvolta attraversati da particelle bio-luminose sconosciute. Al momento sono l\'unica specie conosciuta del loro genere.'),('GYX1AWE2LH','Navigobius kaguya',NULL,'Pesce dardo',2017,'Pesce che ricorda un dardo avvelenato usato da alcune tribù indigene.'),('JANN0QNIG4','Psychrolutes phrictus',NULL,'Blob sculpin',1978,'Questa specie di sculpin abita le profondità più oscure degli oceani. Presentano diverse spine, come tutte le altre specie di sculpin, ma presentano anche una corporatura più tozza.'),('KHRIIMYK0J','Marrus orthocanna',NULL,'Medusa sifonofora cintura di fuoco',1942,'Questa specie di sifonoforo presenta un colore rosso/arancio intenso, essendo i sifonofori dei raggruppamenti di organismi, può assumere diverse forme, caratterizzate solitamente da filamenti intrecciati.'),('L4MKXYGJ6R','Grimpoteuthis bathynectes',NULL,'Polpo dumbo',1990,'Questa specie di polpo possiede delle pinne nella parte superiore del mantello che ricordano le orecchie del personaggio di animazione dumbo.'),('LBPHU6GZV0','Enypniastes eximia',NULL,'Danzatore spagnolo',1882,'Questa specie di cetriolo marino nuota a profondità elevate. Presenta una colorazione accesa, solitamente rosso, rosa o arancione.'),('ORYC2H5PF4','Albatrossia pectoralis',NULL,'Coda di ratto gigante',1892,'Questo pesce è solito abitare il suolo marino. Possiede una corporatura tozza con una coda più sottile. Esemplari di questa specie possono crescere anche fino a 2 metri di lunghezza.'),('OUI9CX2AL4',NULL,'Gambero cremisi',NULL,2022,'Questa specie di gambero è capace di nuotare e possiede un intenso colore rosso che lo rende quasi impossibile da vedere per le altre creature che abitano le profondità.'),('P418NID9VB',NULL,'Medusa ombrello',NULL,2023,'La medusa presenta una campana di colore viola esternamente e arancione internamente, con tentacoli sottili e marroni simli a dei capelli.'),('P4FPZBSA8O','Solmissus marshalli',NULL,'Medusa piatto da cena',1902,'Questa specie di medusa presenta numerosi e sottili tentacoli. La campana è quasi completamente trasparente. Sia i tentacoli che la campana sono fluorescenti e di colore bianco/azzurro.'),('TJC1LW83MD',NULL,'Ctenoforo cangiante',NULL,2013,'Questo ctenoforo è capace di assumere due forme: quella classica degli ctenofori e una dove si arrotola su se stesso. E\' di colore nero pece.'),('U7MYM2MHJ0','Narcetes shonanmaruae',NULL,NULL,2021,'Pesce aggressivo, predatore delle zone più profonde.'),('UDPDW13YB8','Taonius borealis',NULL,'Calamaro cacatua',1972,'Questa specie di calamaro presenta un mantello e pinne trasparenti, che permettono la visibilità dall\'esterno degli organi interni. I tentacoli sono corti e bianchi, ma rossi sulla punta. Gli occhi sono di colore rosso mattone.'),('VGAEFB7Z9G','Grimpoteuthis imperator',NULL,'Polpo dumbo',2021,'Polpo di colore rosa con tentacoli più scuri.'),('VKFBS2ECGG','Periphyllopsis braueri',NULL,NULL,1902,'Queste meduse presentano una campana spessa e di colore grigio/viola. I tentacoli sono molto sottili e genericamente di colore bianco. La campana presenta inoltre delle appendici che si muovono come i petali di un fiore, chiudendosi concentricamente per spingersi in avanti.'),('VL5L84606R',NULL,'Gambero pesante',NULL,2023,'Questa specie di gambero utilizza una dura corazza per proteggersi; questo comporta un maggiore peso, che non gli permette di nuotare come altre specie di gamberetti. Saranno necessari ulteriori studi.'),('WOCOAYY52M','Pycnogonid',NULL,'Ragno marino',1810,'Questi artropodi sono stati osservati a profondità elevate, gli esemplari possono essere di colore diverso e tutti posseggono otto zampe sottili, come i ragni comuni, e un torso piccolo.'),('WOXO3HBSWG','Hexanchus griseus',NULL,'Squalo vacca',1786,'Questo squalo presenta 6 paia di branchie e un muso schiacciato. Possono crescere fino a 6 metri di lunghezza.'),('Y1ELMU1JCH','Heteromysis hornimani',NULL,'Gambero di vetro',2021,'Questa specie di gambero presenta un corpo trasparente.'),('YGH89ZB5QB','Dendronotus yrjargul',NULL,NULL,2020,'Lumaca di mare di colore giallo.');
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
  UNIQUE KEY `ID_PAESI_IND` (`Nome`)
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
-- Table structure for table `prelievi`
--

DROP TABLE IF EXISTS `prelievi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prelievi` (
  `Codice` varchar(10) NOT NULL,
  `Numero` decimal(2,0) NOT NULL,
  `CodiceSpedizione` varchar(10) NOT NULL,
  `Profondita` decimal(5,0) DEFAULT NULL,
  `Note` text,
  `Quantita` float(4,2) NOT NULL,
  `NomeMateriale` char(30) NOT NULL,
  PRIMARY KEY (`Codice`),
  UNIQUE KEY `SID_PRELIEVI_ID` (`CodiceSpedizione`,`Numero`),
  UNIQUE KEY `ID_PRELIEVI_IND` (`Codice`),
  UNIQUE KEY `SID_PRELIEVI_IND` (`CodiceSpedizione`,`Numero`),
  KEY `EQU_PRELI_MATER_IND` (`NomeMateriale`),
  CONSTRAINT `EQU_PRELI_MATER_FK` FOREIGN KEY (`NomeMateriale`) REFERENCES `materiali` (`Nome`),
  CONSTRAINT `REF_PRELI_SPEDI` FOREIGN KEY (`CodiceSpedizione`) REFERENCES `spedizioni` (`Codice`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prelievi`
--

LOCK TABLES `prelievi` WRITE;
/*!40000 ALTER TABLE `prelievi` DISABLE KEYS */;
INSERT INTO `prelievi` VALUES ('ACFEIA1HJ0',1,'VJ4EIJACWK',NULL,NULL,1.40,'Fanghiglia'),('BXW0O22NCI',1,'L58ZW1K7SR',1300,NULL,0.10,'Rocce effusive'),('E3VK5J2IRZ',3,'VJ4EIJACWK',NULL,NULL,1.20,'Alghe'),('GNHD1HINCD',3,'FKBECBJLP3',1800,'Sabbia prelevata dal cratere di una fumarola nera',1.20,'Sabbia'),('JVTUYZK0YS',2,'VJ4EIJACWK',1200,NULL,1.10,'Sabbia'),('KFUIGY39MI',1,'FKBECBJLP3',1800,NULL,1.10,'Rocce effusive'),('OB630R72NT',2,'L58ZW1K7SR',1430,'Rocce prelevate dalla bocca di un vulcano inattivo',0.70,'Rocce effusive'),('OLWKA106M5',2,'YJZX5W42AW',NULL,NULL,0.50,'Fanghiglia'),('PVCF1OI69J',2,'FKBECBJLP3',NULL,NULL,1.30,'Acqua');
/*!40000 ALTER TABLE `prelievi` ENABLE KEYS */;
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
  `AnnoAffondamento` smallint DEFAULT NULL,
  `Dimensioni` decimal(4,1) NOT NULL,
  `Descrizione` text NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_RELITTI_IND` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `relitti`
--

LOCK TABLES `relitti` WRITE;
/*!40000 ALTER TABLE `relitti` DISABLE KEYS */;
INSERT INTO `relitti` VALUES ('028HM','Messerschmitt Bf 110',1943,33.0,'Aereo da guerra della Germania nazista.'),('149YY','SMS Friedrich Carl',1914,44.0,'Nave da guerra dell\'impero tedesco.'),('1PR3Q','Messerschmitt Bf 110',1943,33.0,'Aereo da guerra della Germania nazista.'),('4CQUV','MV Goya',1945,33.0,'Nave da guerra della Germania nazista.'),('4OXAY','HMS Gentian',1919,37.0,'Nave da guerra britannica.'),('8O19Y','Messerschmitt Bf 110',1945,33.0,'Aereo da guerra della Germania nazista.'),('AIX4V','Messerschmitt Bf 110',1944,33.0,'Aereo da guerra della Germania nazista.'),('BXSCZ','SS Cap Arcona',1945,55.0,'Nave da guerra della Germania nazista.'),('CWEGZ','Messerschmitt Bf 110',1944,33.0,'Aereo da guerra della Germania nazista.'),('DWEUB','SMS Bremen',1915,40.0,'Nave da guerra dell\'impero tedesco.'),('E25HM','HMS Cassandra',1918,62.0,'Nave da guerra britannica.'),('FQ7W1','Messerschmitt Bf 110',1945,33.0,'Aereo da guerra della Germania nazista.'),('L8UNN',NULL,1950,38.0,'La barca risulta gravemente danneggiata, con diversi buchi su un fianco, possibile risultato di uno scontro in guerra'),('Q0XIS','Aura II',1940,30.0,'Nave da guerra finlandese.'),('Y8ELP','Messerschmitt Bf 110',1944,33.0,'Aereo da guerra della Germania nazista.');
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
INSERT INTO `rov` VALUES ('4GMW310','HO4IUJKLRY','Seatrepid International','2017-05-26'),('68F6868','76HF6YN1HT','VideoRay','2006-11-28'),('8AGD854','82FVVRU6G6','EyeROV','2000-02-17'),('8GPK420','FOEYGBHH84','Blue Robotics Inc.','2018-10-09'),('C606966','8U59P369AP','EyeROV','1996-01-10'),('C719058','RCMEXFIGYB','EyeROV','1996-08-21'),('CWP8099','F49RXV36NF','Blue Robotics Inc.','1993-02-27'),('EQE2435','16GWSA733K','Oceaneering','2016-12-03'),('FP056LO','BFU102OJNL','Seatrepid International','2006-08-03'),('HWN1325','ZU01FVTECU','VideoRay','2011-03-09'),('JFG1274','8N267FNXXW','Oceaneering','2001-12-10'),('KGS4116','G15FFEYEOM','Blue Robotics Inc.','1993-10-03'),('KVK93A4','OWZ8AYURQP','Oceaneering','2002-07-29'),('MJV3440','HOQXK3F9OB','Seatrepid International','2006-08-16'),('MQP6080','0JHBW0POMH','Blue Robotics Inc.','1990-05-27'),('PQ397LS','94LMH013FQ','EyeROV','2013-11-03'),('TOY8671','VH0HFI8FIC','Oceaneering','2000-11-06'),('VT16752','LFLRJTRGCL','Blue Robotics Inc.','2016-05-24');
/*!40000 ALTER TABLE `rov` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ruoli`
--

DROP TABLE IF EXISTS `ruoli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ruoli` (
  `Tipo` char(50) NOT NULL,
  `Descrizione` text NOT NULL,
  PRIMARY KEY (`Tipo`),
  UNIQUE KEY `ID_RUOLI_IND` (`Tipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ruoli`
--

LOCK TABLES `ruoli` WRITE;
/*!40000 ALTER TABLE `ruoli` DISABLE KEYS */;
INSERT INTO `ruoli` VALUES ('Biologa marina','Scienziata esperta nel campo della biologia e zoologia di organismi marini'),('Biologo marino','Scienziato esperto nel campo della biologia e zoologia di organismi marini'),('Ingegnere','Persona incaricata della manutenzione e monitoraggio delle varie apparecchiature utilizzate in una spedizione'),('Mappatore dei fondali','Geologo incaricato di  mappare i fondali marini'),('Mappatrice dei fondali','Geologa incaricato di  mappare i fondali marini'),('Navigatore','Esperto di geografia e navigazione'),('Navigatrice','Esperta di geografia e navigazione'),('Pilota ROV','Ingegnere autorizzato alla guida dei ROV');
/*!40000 ALTER TABLE `ruoli` ENABLE KEYS */;
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
  `NomeGruppo` char(30) NOT NULL,
  `NomeLuogo` char(30) NOT NULL,
  `TargaROV` varchar(7) NOT NULL,
  PRIMARY KEY (`Codice`),
  UNIQUE KEY `SID_SPEDIZIONI_ID` (`Data`,`NomeAssociazione`,`NomeGruppo`),
  UNIQUE KEY `ID_SPEDIZIONI_IND` (`Codice`),
  UNIQUE KEY `SID_SPEDIZIONI_IND` (`Data`,`NomeAssociazione`,`NomeGruppo`),
  KEY `REF_SPEDI_GRUPP_IND` (`NomeAssociazione`,`NomeGruppo`),
  KEY `REF_SPEDI_LUOGHI_IND` (`NomeLuogo`),
  KEY `REF_SPEDI_ROV_IND` (`TargaROV`),
  CONSTRAINT `REF_SPEDI_GRUPP_FK` FOREIGN KEY (`NomeAssociazione`, `NomeGruppo`) REFERENCES `gruppi_di_esplorazione` (`NomeAssociazione`, `Nome`),
  CONSTRAINT `REF_SPEDI_LUOGHI_FK` FOREIGN KEY (`NomeLuogo`) REFERENCES `luoghi` (`Nome`),
  CONSTRAINT `REF_SPEDI_ROV_FK` FOREIGN KEY (`TargaROV`) REFERENCES `rov` (`Targa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `spedizioni`
--

LOCK TABLES `spedizioni` WRITE;
/*!40000 ALTER TABLE `spedizioni` DISABLE KEYS */;
INSERT INTO `spedizioni` VALUES ('612V1DWEUB','2012-10-11','OceanX AG','OceanXplorer','Mar Baltico','CWP8099'),('EIO8UZ1VVO','2002-04-26','JAMSTEC','Yokosuka','Costa di Sanriku','C606966'),('FKBECBJLP3','2019-03-19','NOAA','Atlantis','Golfo del Messico','EQE2435'),('FKCHELYUK3','2023-07-02','Ocean Exploration Trust','Nautilus','Fossa delle Aleutine','8GPK420'),('L58ZW1K7SR','2007-11-11','NOAA','Falkor','Golfo del Messico','CWP8099'),('NRBWSLDM1X','2022-08-03','NOAA','Falkor','Oceano Atlantico','PQ397LS'),('Q6XUWM8AXS','2008-03-14','OceanX AG','OceanXplorer','Mare del Nord','FP056LO'),('SSEY2O52BP','2023-07-21','Ocean Exploration Trust','Nautilus','Fossa delle Aleutine','8GPK420'),('UI13BGB839','2022-05-15','JAMSTEC','Shinsei Maru','Oceano Indiano','EQE2435'),('VJ4EIJACWK','2023-06-18','Ocean Exploration Trust','Nautilus','Fossa delle Aleutine','VT16752'),('YJZX5W42AW','2006-03-14','JAMSTEC','Mirai','Baia Sagami','C606966');
/*!40000 ALTER TABLE `spedizioni` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tipologie`
--

DROP TABLE IF EXISTS `tipologie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tipologie` (
  `Nome` char(50) NOT NULL,
  `Descrizione` text NOT NULL,
  PRIMARY KEY (`Nome`),
  UNIQUE KEY `ID_TIPOLOGIE_IND` (`Nome`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tipologie`
--

LOCK TABLES `tipologie` WRITE;
/*!40000 ALTER TABLE `tipologie` DISABLE KEYS */;
INSERT INTO `tipologie` VALUES ('Fumarola nera','Fessura nel fondale marino che genera fumo continuamente'),('Grotta sottomarina','Insieme di tunnel scavati nella roccia delle pareti e pavimento marino'),('Vulcano sottomarino','Spaccatura nel terreno in fondo al mare dal quale escono gas, magma e altri materiali');
/*!40000 ALTER TABLE `tipologie` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-08-25 20:57:26
