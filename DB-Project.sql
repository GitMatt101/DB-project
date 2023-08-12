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
  `Foto` blob NOT NULL,
  `Note` text,
  `IDrelitto` varchar(10) DEFAULT NULL,
  `IDformazionegeologica` varchar(10) DEFAULT NULL,
  `IDorganismo` varchar(10) DEFAULT NULL,
  `CodiceSpedizione` varchar(10) NOT NULL,
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
INSERT INTO `avvistamento` VALUES ('KASMNK5P8H',1,700,_binary 'ÿ\Øÿ\à\0JFIF\0\0x\0x\0\0ÿ\Û\0C\0\n\n\n\r\rÿ\Û\0C		\r\rÿÀ\0^S\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñð$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rðbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0øŸoµ9VŸJ}¹ñ\×¶¥¶ºž\Æ_6\ÞW†\\ÁÁ\ê3M\ÛHV‘6Y‹1,ORz\Òmö©i@ W!\Û\íF\ßjŸmh\Ó\éF\ßj›mh\r¾\Ô\å^j]´„b\r\ÛMe\éO¥\Æh\íö§*óÒ¤\ÛK¶€/x~\Ö;R\Ýe»Ý“\ï]Î­u\Ë,{BÆ¼.\0®O˜Z\Î$\'¥h\Üj«*¬G­0¹uY\Ó5P­ZšA\'J‡m0¹\ÓF\ÓRm¤\ÛNÀ3i£i§\í£m6š]¦Ÿj\\ûS_˜\Òm©JóÒ“oµ+mjM¾\Ômö¢À7i§‰dX58V\á±K³Þƒš,E\Ì\ï\ì»|“\åòzš’;8¡9T\0ú\â­m£m;\ßj6ûT»h\ÛE†E·Ú¾\Õ0Z6Ò°\íö§*üÃŠ“oµh°«N\Û\ïF\ßz6ûÔ“q)6Ó¶û\ÑÇ­q›h\ÛO\ÛF\Ú\ä~]]M\åû\Ñ\åû\ÑaÜƒË£eO\åû\ÓJQb\îE¶´ý´m \Ê\Òmö©JÑ¶®Ä‘mö£oµK¶´X¶ûQ·Ú¥\ÛWô\èl\Ú\Þñ®„ŠŸ¹QÝ³E„e\íö£oµXòý\è1ŸZV\Êû}¨\Û\íR\ì4l4\ì2-¾Ô¡jM´m¥\Ê6Ñ¶Ÿ¶µ< 3miûh\ÛG(\Ó¶´ý´m ¡›h\ÛO\ÛF\Ú\0f\Ú6Ô»!Z\ä{h§\í¢€oµ*j~\Ú6\Õ‰·Ú‚¾\Õ&\Ú6\Ð2/.ž\Õ.\Ú6\Ð\\Q\Å;mh\Ä\Û\íF\ßj“mh(oµ#/µK¶´ƒoµ9WÚ¤\ÛK¶€#\Û\íJÚ·Þ—m\æŠ6Ó¶Ñ¶‰¶“m;mh»h\ÛN\ÛF\Ú`&\ßj6ûSöûÑ¶˜\Û\íF\ßj\\{Ñz`0¯4›MI·Þ´i£&\Ú6\Ð+¢¶´EEK¶´.\Ú6\ÐTPTúS\Õiv\ÐQ\ÓB­K¶€¾ô\n\ìoµ}ªM´m©±\"+\íI·Ú¥+I¶\Æ\íö£oµIz6û\Ð;	·Ú¾\Ô\ì{Ñzaa»}©¥y\éSm¦²\ÐQ\ßj6ûT…y£m #\Å%K¶µd‘QR\í£m\0EKRm£m\074S¶Ð«\Í\0%ý´m ›‘\ÏJJ™–“mQR\í£m\0EJ«ž\Õ&\ÚUZ\0f\ßj6ûT›h\ÛPQ\ßj6ûT›iv\Ð{}¨\Û\íSm¤+NÀ@Wž”T»h¤E\ÆÎ’žÑœš<¿z±ŠF\ÚpP¶´\ê(ÈS@\ê)Jœž(\nh\í´m¥\Ú(\Ú(0›h\ÛK´QŠ˜M´m§RP;‰¶´\êJmi\ÔPiq»h\ÛN¢€¸»i\nÓ¨ .G¶´\ê(\ÛF\Úuaq»h\ÛN¢€¸\Ê*\ÄÑ®#\Úz®N*?/\ëA:‘\ÑJF\r%¸QEÂŠ( .9Fi\Ûi‹N ¤\ÅH\ÚKˆbQ–’EG©\'\0V§Œ<+©x\\M+U¶kk‡ŒJ›†)ªÿ\0\Ã]<j_4(\ÙC\"\\¬§?\ìk\ì\ïø(‚\ì<Eð\Â^;³´H\ï\ì™-g™’­Àò®yÖŒ$¢ú0£)Á\Í\í4m4Š\ß-.k]õ9dN)»MI\ÔQA${M*­9¨Z\r.h\Úih .\'4`Ó¨«-&\Ú{RPŒRSš›A7\n(¢€¸QK‚iBœ\Ð\r†”)§Q@\r\Úh\Úi\ÔP\"6\ëIJ\ÝM%\n)vŸJw—\ï@\\jŒÓ¶šU]´´M¦´\ê*l]\Æ\í£i§P´Xw\r¦©\Å>‘ºR‘\í4S¨ \Ì\æ\'ü)6\Ò\ÑAaE&\ê7UˆZ)h ¤\ÛN¢•†%QH€ ¯ ¥®‹\Ãþ¸\×`–De#,\Ý\èU”m•R²3Á\ÜGL/5VŒe\àSz\Ô\ìµ>cE\Ú6\Ò\ÑPX›h\ÛKE\0&\Ú6\Ò\Ñ@	¶´´PE-`%´m 4d\ÑE\00õ¢”õ¤§bŠ(¢ÀQEW­;¦­=z\Ò)…ðLþ\Ñø…FV8]¾‡ŒW\Øÿ\0¼Cý¥û>jsˆHž\ÌE|\Éû.Xù\Þ$¿˜º›zWÑŸ\Â\\x>ùnQp~•òx\êòŽ%$~•aaS7#óþšGJ“Ô‘ÿ\0«\éÐ‘úÓ—“_KI\Þø:±´\Ú\rµ QŽ”m¥­leb&ZEZ{\ÔbŠmih¢ÀQE0\ZÔ”æ¤ µ%+RS%…QE„\Òx®m\"\â\×Im3‰V\ßm\Âÿ\0µŸ\ç\\\Ý*\ç\"€$¢Š)(¢Š\0‰ºšzt\éMo¼iW=1Le\Û==\ïVB›@A“¸\â«m±V-®„ºô&«\ç4]¢‚£Ò€\Ù\ç¹ö \ãSÿ\0\n6ûQb\ÆQO\Û\íF\ßj,qHqŠJ+1\ãÖŠ( €\ÛF\ÚR\Û{Ry‚™CSE­v$‘~è¥¤_º)i\áEPEUY\Ôi~)—M\Ó|„\\n\êk—§n\'‚€-\Ý\\µÔ…AM\Þ)i_z5IL=jn5¸Ý´m§QRj7mi\ÔPvÑ¶E\07m.\ÚZ)€QED\Ü)v\ÒS·PEPIKIUb.R\àúQƒœP£\å¥\Ú=)h©­€3ŠEå¸§ÕM}cZ²°‹&K‰•\çL¨\ïc\é\ÙoCòt\é\îJ•i	\ÎGµzß\íü¿\ê<ÿ\0\ËþUð_\Ã\ãJ·»´QÍ¸ô®\â5°>Ô¸ÿ\0–\rÊ¾CIût\Ùú^[5+G\çjŒ!ÿ\0xÿ\03ON\ê|ŠI\Ñ\Èýi­}=\î#ó\ìGñX\ê(¢·\å9®0‚Ni6Ó¨ .7miÔ”\Ä\Û\ïF\ßzuv1­7&¤a‘Š¥0»\nP¹Ú±j\â6ÝŒû\Zvt¢¬\Ü2\ÈÅ‚\ã=ª,JAqžY¥sO¢\\n\á\ëF\á\ëQ\ÑUan´nµX=M”Qa\Ü:\ÑEX.J¿tR\Ò/\Ýµ\"\'ÖŒ·­´8QEL\Ös­ªÜ˜È›h~\Ä\Ó¶\ÃF\ÓO¡ºT–C°\ÑRQRer&ù©»ih­,;‰¶´´SŽbŒŠmX.;\"ŒŠmX.QE2BŠ( Ÿze9[€’˜\Ô\íÔŒ\Ãmf·:(¢µQE\0QE\0QE\0¹4d\ÒQH\ÑH´µ%Q@§\'Þ¦\ÑTAa@\ÛÓšoz¾Z)\0QE€C^¥û-ø}|Qñ»H³‘C*«\É\È\Ï!k\ËM}#ÿ\0ÿ\0\Ñ\×Røµ©ß”5µ«\'ør1\Çù\ïZ\Ãk•Ï¡¼#\Zi>1\Ö\íq¹Ž\Ü\Ó~#‰.49 Œœ2‘R\\±ø•¸<š\ß\Ö4!¨Û°\É\ät§…ŒŸ5¡¥\å¥\Ësó[^µ:µ\Ä cQ\Ö|]\Ò\ßCø‰«Zº\íý\é!}«”QÞˆ\Ó\ä\Ðñ*ËšWŠ(¢\ÆBŠJu¹@m\êm &\ê7TtdÓ² y`8¦1\É\Í• ô`)”P»Ç­&ñQÒŽ´X	i\îšM\ÃÖ‚\Ãš@GEU\0QE\0QE\0S”dóM§G÷©*Š]¢‘ih6J6JZ)Œ*f¼šKT·iÀ„²\Ç\Ø\Ô\Ô4PH\Ý)i\Z³+˜J(¢¤‚\Z(¢¶\0¢Š(\0¢Š(\0¢Š\r\0&\ê\\\Óvšp Š( –’Š\0v\êUù³L§\ÇÞ¦À_¥7¥KHË¸Qp\"¢–’¨\Ú}(\Ú}*Z*n[O¥O¥KE\Z*j(¸­-:–‚\ÆQN¢QR\í”m•W Hþ\í:’–¤Š(4\0†¾\Íÿ\0‚n\è{¿\á$\ÕJœ³ù`\×\ÆS0HÙE\æ¿@¿\àºKYü)½º+ÿ\0Aüjß»\\OCñ\îŠ,ü\\gQÌ•­c\0”×Š\ÜñÖ‹ö«¥›Š­¡\Øù— 5\éÒ©d›\ìL›GÂŸ¶\'ƒIñ´Z’\ÆV9¸\'\à	Œs_}~\Û\Þ7)Zœ6+\à8\Î\áø\â°v’\æ]D¥q\íM§½2¹\ìXQE€)´\êm #\ÛF\ßzZU\ëC O/Þ/ÞŸEf4QEPòý\èòý\éô÷MHQE@QE\0QE\0QE\0 ‘Ò’Š\0™Od\Ò/\Ýµ\0!a\ÜÒ«zTm÷:?»LdÑš( R5(¤jŠ(©\Z(¢¶\0¢Š(\0¢Š(\0¢Š(\0¢Š(ñD\Ó6\Õ\ä\Ñ$M\Ã\ZXf0¾\áÖ‰¦36\ãÖ€#¢Š(\0§\ÇÞ™O½ ET\\:÷Ý§Ò¥¢Ÿ0	¸zÑ¸z\ÔTUX	wZ7ZŠŠ,\ÔT[­­+%-5zS©”´”\0´QEY³¶[†!Ž*µI†>A\Å4\×v\ënøS‘U\È\Í>INM2¨/›²{ŒW\ê_\ìS /\à^Š6mi2\ç\ß5ùku™cˆu‘\ÕG\âq_¯ÿ\0³Þš¾øK¢Z‘.\'ò¨­ü\'cH\îuþ%\Òü\è÷cµr\ÚU³[_\Ø5\èw2-õ¡ db¹\Õa¾u8<\ÖXz‘Å•R7\Îk\ã÷†S\Ä\Þ¸V‹\î\È#\í_”> \Ód\Ðu\ë\Í>E\Ù\å\È\ÛA\ã5ûA¬\éÉ«ørxÀ\Éò\ëò\ßö°ð4¾ñÛ’<C3[\n\è\ÃT\æ‡\'c…K–GŒý\áœæ’”\0¼”µ\Ð\Ñ\Óq´S¨¨hwM§R5+\Èè¢Š’E\Ý@jJU\ëJÀ2’•¾ñ¤©þgµgµ2Š\0(¢Š`QE\0QE\0QE\0QE\0J¿tR\Ò/\Ýµ\0F\ßxÓ£û´\ÖûÆÝª\è¨¢Š½)\Z“4Œ\Ø\ë@E%¬TQEhEPEPEPEPEPEPJ:ŠJZ\0“4f›Eb³Fi´S”QEjEPNU\Ýô¥úÓ©\\–’–¤°¤¥¤ ¢Š( (Q@¢\ZZ°\Ï\å\Íjø\Î\Ù\ã?øð¯×Ÿ…ú§öŸ‚t‘´H-S ô\'¿ \îhó’#\ãÂ¿]þ_[\ê_tk„e?¸A\ÇÒ‰?r\å\Äô\Ý%w\éÌ¤s\\N¢\Ïªy\Ç5\Õi7\ÃF~\é¬o\Û¾5\ÅNñ¨\Ó\ên\ì\ât>“\íŒ¤dc‘_,~Ø¿¿·¼?©¡bQ\ZdeRpqšú‹Â®c8\Ç¨üOð\êk\Z4™V0ö\ÅM:ž\Ïg³<j›\è~)\Ú1\ÃF\ÇçŠ·\Ô\Z±^ûB|<o‡Ÿn\Ìq4v7Œd—9\æ¼õX05\ì7}NºrºET3A”KHÔ€ŽŠ(¨\0¥^´”«Ö‡°=i(¢¤Š( Š( Š( Š( Š2(\Í\0QE\0;qõ£qõ¦\ÑH	m\ÝeiF\ä$z\ÓY€f\Û÷s\Æi”P·\Z7Zm\0»­\ï/Þ/Þ€¿tQMßŽ1E+\0\Ê(¢¨Š( Š( Š( Š( Šr©v\nI8À¥’6ŠBŒa\Ô\Z\0eQ@-%*ý\á@¢ŸEg`E>Š,4QEhEP\ÔT[­­M€’–’¢‘W’¢Œ\naqh¤oºj=\ÇÖ‚Ih¢Š@»©( n£óauö¯\Ðo\Ø\ß\ÆS]x3L´y\"©\\\éŠüýõõ\ì[\âq\ZKbÇ˜%ÀúWe8óF\ÆU•\Ï\Ðh\íJÊ’(\á†j¶¹lÉ±\Ï5wGº:llyâ¨Fo-ø\ê+\Æ\æ”ggÐ•T©¢\Êa™X\n\é\ç·]GNxÛÃ½s\Z|L\Ó\Ø\×Ob\Åb\0\×5}Ô–\ç4Ÿ1ò7\í…ð#þ_\ÜOiûuªù±\í\äs\ç_›v®ð\Í%´\Ãd\Ñ1GS\Ô\Å~\çkš,Z”2#®Uñ¯\ËO\ÛK\à+ü-ñ¿ü$Zt$iZƒŸ0(\á\\ó^\Æº«=\ÅJN.Çƒ©¥¨`H¹%t3\Ñ\nB)h©2¤RT÷MGR@¢Z@2Š(©\0¢Š(\0¢Š(\0¢Š(\0 \ÑE\06Š( QE\0QK@ô ¢—¥%\0QE\0I¸zÑ¸z\ÔtR°\nzš)(¦¶\Z<³O_º)jnDcŠJs}\ãM¦ES\0¢Š(\0¢Š(ð\Ì\ÐJ’/\ÞS‘N¹¸{©Œ÷EE\0QA \ÝJ§šm*ý\ê\0›põ£põ¨¨¥`%\Ü=h\Ü=j*(°QLŠ( Š( 	¨¨·Z7Z›-QH·\Ý5H\ßt\ÔuHŠ(¦\ÔQE@\r\ï^\Åû.\ë\ÃFø†m‹\íK”Àÿ\0z¼{{EÖ¦ð\æ³g¨Á!‰¢•I+\éš\ë£-lg5t~\Éx7I„õ;0k~5ùˆ\ã>•\äþ$i—\Þ\r°»–\ì\"´A™‰ö©<IñûA\Ñ\ïZ+F’öoök†¥	Î£\åG?³v=~p²n+[ø\Ú|\ÑuûQ^\Çú.„ò`õoJ\×ð\ß\íe¥\\­g%”™Án\Õ\ËW]­‹Tü¡¤*My—\Ç?„V<¤\\Ä¯#¡1¶9V\ÇZ\ë¼-\ã\Ý\Æ«6›}û¿ƒ#\"·;cŠó\ã*˜y\ë£DJŸ)øU\â?\ßx\ÅW\Ú¤öò\Æ7(<\Z†¾ýý¿¿gñ›ÿ\0	Ž\n\Å}fl¼+óö\Îa$xr7/\r\ÏC_KNJ¬\âtS|\Ú\ÑNÛŽô„{\Ðka­÷MGOo»L©\nv0¦‘z\ÐTj\ÑRyb˜z\Ò(¢Š`QE\0QE\0QE\06Š( \Üh\Ï”Pñ¥;\Ë\ÐRC\Óñ©Yi \êi6J{RR&\á©)\Í÷6˜QLŠ( 	GAKE\0F\ßx\Ói\Í÷6¨Š(¦EPEPEPEPŠ@v\Ò\Òp\Ä{\Ð\ÑWµ-B;\ï(Gk°UÁ.7Z£@Q@R\ÐQE\0QE\0QE5\Ä=iõ\05¾\é¨\êjc/zhQO\ÙF\Êw*Á\æ{P$ö£e(Z-p°½ko\Â\Þ¹ñŽ©¬@ˆU•½eZ[=\å\ÂBƒ,\Ç¾ø{¡C\á½:¿i‘s3Ž¤\æ®:Ó‡1\Ý\è\ë\'‡´}&\ÒVû<`\Ç\Õü:Ó£½\Ö\í*s\Éa\\\î“\ÜL\ÊÇŠë¬¯\ÓDˆø~Þµ¼j[s­PG³\Üø_Iû(\Ä1Ž:\â¸/x_M’\'f¶ ®Z÷\âµî–¹\Î\åšO\Æk]JA\ÌB=ü5¤k.¦\ë\nf\Û\ß]øVü\\i2YJ‡± j÷¯…?´?öœÉ¦\ë\çÊ”ü¢s\Ð×‹\ë6P_7o’\Ís\ék$w”©\àŠš´\é\â¤p\ÖÃ´¸¼m¦Zø«\Ã3Ú¶\Ù\à™¸n+ó+\Ç±³\ÇñS•µ!e¥;ù‘ÂFM}¥ðk\âu\Ä\Ñÿ\0cj-¼‘ˆÙq\ßd6þ#»9Á$c\éX\á(:.T¥ª\Ý\á\ÊÏ™G\ì»\á\Èb\Ãj·E\Ç÷[Š\à|uð:\ãÂ¶­u¦\Ü=ü\n~eo¼­{Þ¡x\Ç88¬«‰\Ìñ²I\Ê0Áº§M-\ì|–§¨<M\"»ßŠþ_\ê	woþ¢ç“\Ð\×\0\Õ\Ç-,V;qŠu3iô¥ßŽ1Y>¢o¼i\Þgµ2š\0¢Š)€QE\0QE\0QE\0\Ú)\ÔPh¢Š\0š©‹\Z­\Æ*Vn)\03qQù†‡=)´\0¤\çšJ(¦EPEPž`£\Ì¬±\É\Í%S\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0£Q@R5\0©sM¥Z\0ZV\è>””´\0\ÊU¥\ÛJ«ž†€ŠqR)´\0QE\0øû\Ó\é‘÷§Ô°\'Ý¨\êI>\í2š-QO” ¢œRn¦´¸øW§­\Ýô÷¡¼±…\È\ï^Ã¥¶Ë€¹®\à\Üj\Ú=\ã•ß€q\Íw:j¾«;h¤w\ÞŒ\É;¾:\noˆ5˜l_.À°þ\ÖÇ„b	§N\ç®9\Íx×µ;VuW8REaY\Ú:\Í¥-K>,ñŒ\×K¶\Ù\0\Åa\é\Þ »Ü­$(t5œÓ†9/\Å>[Ø’.9¯+\Ú\Êö=x\Â6=·Àþ2mJ\Ð\ÚNÉ½G\0u«Wúò\Û\\r8\ã>\Õþ(•X…\Ï5\Öx‡Pf¼e\r\ÆkÓ¥Q\Øó«\ÓGwŒD7OlvL‡ Ž+o_\×d\×\ãŠ\âf.\åF\\×‰­ûE\Î\ê\îô]au\r9-\ÔüÞµ\íQ•\â|õX¨½‚\×\Âw:¶™ƒp¬¿x#P\Ð!Y¥‰‚\äW\Ðÿ\0\nõ\Í\Ã\Ãñ[\ÝD¯:ó’*ï¼U¡jVMc-ª:Fp+)\ÊN\\¼ºw1±ñ4Ÿ\íÿ\0Ý®›n¦P{\àW\ÎyÝ‚k\ëŸX\ÚGwª[Z¦ do\ÔW\ÉwySÈ˜\Æ\Ö+Æ¸§¹œ‚¢o¼jZ‰¾ñ¬‘˜”QEPQ@Q@Q@Q@Q@Ô”­H\08R–\'­%()¯Úœ¿tSd\íR€eQTEPEPEPEPEPE!4n ¢Š(\0¢Š(\0¢Š(\0¢Š(\0¡¨¢€J´”/Z\0u;)=é´¹8\Å\0*«¹Uw;^Ž¿õ[\n.¯5·\ÊË»\0W\á}B-/\\µ¸š1,h\Ù*\Ý+\é{\ï\ÚNºðK\é\âx™†\Ü8\â€>U—>c1ƒŒS+C^ºK\íJY\ã@ˆ\ç<Vy4\0QIº@½>™Fh\ådû´\ÊuXcè¢“\"¨¡\Z’ŠrŠ@z\ïÁ\é€\Ð\îc\È\Ý\æk\Ðôø\Â\ÌWŸü\r\Ðd\ÕôýbH&Fž-¿\è\ß\Æ\Ã\ÔW¥G\Ú6\É\"h\Üqµ\Æ\rY\ÙKC¹ð\ÌÛ¬.\"\Î®x\'\Ä[y´ý^m\Ã1¯K±ñ÷ö½®¦i·z¥\Ã\äùv‰¹¾˜®o\â,‰®´¦K9l\ï*\ÑL0ÀŽ¹…k5cÔ§.]O\':¯L\æ™ý¨d\\f¢ºÒ®m\ØïŒŽx\â‹\âi¹Pzó½šGrªÎ¯\áú5Ö´$\ÎŽk§\Ô\ï\Ã]?Ížz\ÔðØ ‚+Ÿ°y\ÌKü#¹…u?ü\à\ï\ëÖøW\ÄS\ëQ4\nf36\ïŸþµ\Õ	Y\ØÊ¤œ–§=\àU85\ìÿ\0\n­,¿³¢º¹O›¨\Íx\í¾‘ö¹‹mŒ}1^ƒc¯C¦\é\ëodL®\nµ\ìÐ–‡U6\Î\ïT\Õ\çµÔ¤6s“°\Ì\ë^.½\Æ}Î«Õª¦ý¥ªj	öµ6\Ð7Vj\ìüU§\è¾\Õr¬·ka³\ß¼™Ÿ)\äwšüw\æw0A\æ¾y\× òuK\×\ç5Þ¦¶m\ìäœ\î9ÀjRy—6s“^|÷2‘B£n´ö¨\Ï\Þ5‹9ÂŠ( ¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢“u¨h¢Š\0”t¦\ÉÚ3ÚšÍº¤¢“uª€Z(¢€\n(¢€¥%¹¤\Ý\íJ\ãŠ\\w¤ AES­ÖŠ]´m ^”QE\0QE\0QE\0QE\0¢›J´\0m£m-\0QE\0INjm\0:‘©h#4\0\Úrö¤\ÛKM\0\ìŠ2)´´ÀuQ@\Ç7Jm9ºSi2‚M©!V’@ª7Úª1l—áŸ\îþø\Ê\ÓW·Ü–h\Ï!—>•÷ÿ\0ƒôþ\Ñ\Öð\Ü\é·\Ð\Ø\ê-\Ü€;½1_Ÿ\èûa“EuŸ|[ªü?Ö’÷N¸{wŽ@ûPðphœ%gcH\ÔI\Øú7\Æ^ñ¿\ìƒñ*\Ë\Äv±®©¤1Çš\É\Â\çŽk\ÇKs\â{\Ù<O­\ØNš}ðó\Í\åœª‚z\àW\Ôøõ\à\ï\ÚÀ·^\Zñ+\Ã¥$F&\0±=ó^{\àÏ‰Z¯\ì©\âð—Žô\æ\Õ|#\æ\ÛV	\"c\Æ\ï¥x•%V7º÷¿3Õ£(\Ïf|\Õ&ƒ\á\ÍZOô/-¢©{	¢ºðÇ„t[:óÄ³jNI$\×\é‹\á‚\ßaMWKƒG\ÔZ_œ›y¾Oªæº­#\ào€|:\æ\â\ßA³R>o2N@\Åy¯(\é$\ÏR0V\Üü\çøkðg\Æ_\ìnn´]*m3B›»\å(\Î\0\Ï\é^Y¥ø~\æ\×Y»‚gb\Ð\ÊP\î\Ïc_~~\Ô_µ\ç„>øz\rxf\ê\Ö÷]¹£\ÙbF\ËpF2q_\0YøºGŽI$m÷2’\ÌÞ¤õ¯K\n\ç[V¬sV©lÎŽø2ùV°ž\\\à×¶ø\áø±\Óã»†–]¹;«\Ã<+×—‰q!\ÜA\Í}\à¯-»\Çk*\æ2\0¯¥…7Ýœ”\ä¦\ìrž(³Ô®õh\íá…ƒ³mÚ¢\âÏ†:Ýƒï®š\0\å¸5ô_ÃŸ\Ø\ë\Þ*·¹,¤gp\ï[?µïŽ´_†ux\Ð@º„Ö…\"CŒ\äŒf¸*c9**Ij\Î\Ùa\×-\Ï\Ê}Jü\Ã4Ð‘†V \Ö\Òn\'Ö’mBKû©\î\\`\È\åñõ¨_76§‰Ykd#\nˆŒ1©ª6ûÔ™\Æ\Æ\ÑEQE\0QE\0dQZZmåµ½¼\É<+0!K”›E-%\0QE\06Š( QE\0QE\0\Ú)vÑ¶€Q@\âŠ\0(¢Š\0k}\ãET;\Ìö£µ6Ša\ÔQEY!EPE¸>”\0”QE\0QE\0QE\06•i(^´\0\ê(¢€\n(¢€\n(¢€\n(¢€\n(¥\Çª@%-%-\0:ŠLŠ2(h¤\Í-!‚òk\Ñ>ø4\ê>«tŸ¹PV0Ã©®[Á\Zx‚b¥­ÁÌ„zW¼k\Ûhzz\ÙÚª¤q¨P\èQ§\Ô\ÎR8]b\Ãl\Çh©4\Í/\Î\Ã½ Ø§ˆo\Z6lzš\×ñN“Ž‘¤GW\\©\èaÍ©\ç:”—º~ —:t\ïm<mñœWµx[ö¤\Õ\'\Ðbðÿ\0Št¨|CbGûPÝ¹H\é\Íy}¿—\ç•CCP]F­1x\Ô ®J˜U3hUp\Ø\íµéº•ÄšÇ‚$Ô¼,\Ìl³¹(¨Þ˜ô¯6ñg‰þ\'H£O¼øƒ«\Íf¤‘\Ý‘Œ`‘ZCX\Ômb1Áu$hF\n©\â²\Ìfg\Ë\ä¹=\Ís<M\Ö&G#k¡My’Hó\ÊNZI	f?‰®§C±i&]\çŠÑ‡O½*\Äq5\Î0=k®ŽS\èL«6v:e\ÌV0…ŒóŠÑµñG2°“\ry\Ûj\Ø\È\r‚=*\Õd\ÏEu\Ùl(Vqw>\Ñø3ñ^\Ú\Ò\ê\Þ#.Ë’6\ç=\r|\Ùûx|P¸ño\ÄKm8N\Ï1\ã5\Èh:ýÍ–©k6ö\ÂÊ¤\àŸZÁý X\êž1Šÿ\0Iù½kŠ¥_-N·Œœ—-\Ï<WÊŠF&˜«·¡æ’¼ù#Í±Û­&sIEAESQE\0QE\0QE\0QE\0QE\0\Ú(¢€E&\ê7P\ÑIº\Ô\0´QE\0QE\0QE\06Š(\ëPXQR–•\Åq”QEhHQE\0«\ÉÇ¯¿®kZ]÷†ô+K·\Ô,\ãu¼¸?vv,J‘ô\Ï\Ò\Ð(¡º\Ñ@^”P½( ·Z(n´PBõ¢…\ë@¢Š(\0È¢›J½hh¢Š\0(¢—Ò€œ>\í/—\ïK«B`3i£EP¢Š(GZs©\ïÚšµ«\á!õ\ïiöj2­(-ô¤U\Ø\Ëð¿\Ã\é\á_\nµ\ì\ê«uu\È\Ý\×‹­jutù=\ë¯ñ¶¡´V‘¢%\ÆÒ¼\à1š\ãŽI=\ë×¦¬¬Œ$tº\ÒY¡•\Æ4ýCR’ð#³ûªµ\Õ\Ò\ÚÁ\Z«6;œ¾sZó[[šQ\ÆXqJb=\éör¼ó\ÅLv·¥3\å‡Ó­\"\Â‡Õ©– _–Eô f‚C\å[ô§}›ûb\Æx\á™p’K€a\Ú\r7\ÃÚ‡övµŸõdá‡­\Ü\â\ZCŽÃ¯(ó\Õ|Pð¹ÐµŸµB»mnõúš\äƒ(\çšLgU\á{Xõ)\ng/ z\Öw\ÆsvNÀ\åF\ßjƒEÔ›L¾Žu8\ny\ÅzÅ\n§‰~n\ÑI\Ì\ÛEG-\ÑW>i1\ãñ¤\Úi¶³	£\Ü\'üªZò*-M\â\Æ\í>”m>•%\ÍrˆŠ‘Ö’¤“\î\ÔtÀ(¢Š`QE\0QE\0QE\0#RdÒµ%\0QE\0QE\0QE\0:Š( Š( yfŠ’Š›^œŸz›J­´\Ò(’ŠnñKº•™#h¢Š\ÐŠ( ·Z(n´PEP—¥/J(­ÖŠ­\0P(¢€‘E6•h6šP)h Š( ¤\î\Ôtõ`4€}5‡­5˜b’\Ü\"ŒŠm Q@^õ\éÿ\04¸ä½¿\Ô\äÿ\0–)µ	õ¯.Ý€{W¹|6´:?\Ãó)d¸,ù\ïŠ\ê£±I\Ù<Mxood$\çœV^›m¾\ã\'¢óKw&\æ\rœ\î<\Õ\Û(\ÄP3“Ö½8«Ì¡©HZc\ÏN*ž\ãR\Ý>ù	**\0»\Ë*ŽqW#¾ùFd+ô©–CÒ\ì”—Y¨~\Ñ\É9\æª¨±š.K4–\è\ãš|R*¿£f²–BÇ­X\Ï\0\Z`v>5¸þ\Üð\Ü.Í¹¢ûU‡¾ð^±\á\rb]cS¸¶\Ö6\â\ÍAÂ†\Õf—~*“\Æ+‘Ž)&¸KxQœ±\áTg4˜\ÇAn°Hc\Ü\\Çœ\×ÒŸ?ø[ðýÀó ;Tûƒ_6*›y\ÙYYnµ\íß³þ´,uæ‰Ž©N:òÆ¡¦¾‡\âMSNu*m\æd\n}4`\×yû@i#Eø¹ª•û—$J?\Z\à3^f!Y³x’\ÑQn>´õ5\ç\Ø\Ðs0#Še!jL\Ó\ÔSsFi€\ìŠ2)´P²(È¦\Ñ@È£p¦\Ô×–sX\Ì#™\n1P\Ã>†€!j(¢€\n(¢€\n)vÑ¶€Š( QE\0QE\0\ï0\ÑM¢\r¢Š)€Qš( Š( QE\0\Ö\ëE\rÖŠ\0(¢Š\0rô¢…\éE\0#RRµ%\0QE\0«IJ´\0´QE\0QE\0QE\0QE\0QEP-%/j`6EÜ¸÷¯ ¯\"\Z?…¬,\Ðò¨9÷×†\è6S\×4\ëa÷^e{W·xªm\Ì#\'²ÿ\0*\ïÃ­.e7c“™w­h\ßo¦¢ÿ\09¨lmÌ—ƒžiþ ùd\ÜW `c\Z)Xb’  §+c­GŠu\0?\Ìô¦hÁô¢‘,|\Õ<z \èjdûÂ•Æ“þ%ò}+/G\Õd\Ñu¯!ÿ\0[\Ê\ÕÙ›mƒŽø¬]¾´›gP¾}JòK‰\0#8õ5\Ûü1\ÔþÁ­@çŽƒ5\Â*ô­½CÑ•89\ÍiOp&ý©,|\ÏY\êqò&‹n\êòýKMZù\"šaol£t²Ÿ\á_ozõÿ\0Ž-ý¡\à].\ä\Ï\ÛKw\Æ+\Å\ío\Z\Ú\'U\ã\Ì?J\á\Ä|L\Ò(5x­/%Š|ø”\ád\Æ3UZž\Ô\Ó^y°\Ú)U~aZR_[bµªÛ¯\ÚK†ó±\ÈµH”QE\0QE\0QE\0=\íô\×ò¬“9vU3\è*\n(\0¢Š(\0¢Š(\ÔQE\06Š( QE\0QE\0QE\0\Ú)vÑ¶€Š( Š]´m ¢Š(­ÖŠ­\0QE\0\å\éEÒŠ\0F¤¥jJ\0uQ@#R\Ò5\0%*\ÒQ@¢›R\Ç\ê\0ecì¥½ªk\r\Z\ëT¼[[HZy\ØGZ\0£E]\Ôô[\íEK\ëY-Y³´H1œU* \n(¢€\n(¥¦ið–\Ånüa°\ÊÀ\'ò®\Û_œ\É~G£b²~	Ú¬z~»~\È2¤DŽzdŠ±4†\â\è’rwW¯‡¢s\Ô\Ü\Øð\å˜k¢Çœ\Ö¹)k\ÙûU\Õikö[I\æ<qÒ¸\ÝBO:v>¦º+QJ=(\Ú}* ©@÷¡W\í´€J¾õJx¨±\Éú\Ò­K~ó>—£\Ý\ëÚµ†dñ¤÷S¤!¥8Q¸\ã$\×}ñ\à†¯ðW\Åö\Ú^¡{okql&Ž\â\í\ÜVnJü½A#\Ï\ï$\Û\ëTÕ»þ»{\n‡i›\èÖ´l\Û\É Š¡XF\ÛZA\Ø\r¿7\Û>¾y)(5â¾•\ìž.m¿\re\Çy…x\Ú\×g©¬Ejm9©µÀ\ÍB†¢†\éPÀmQ@Q@Q@Q@Q@Q@¢“u¨(¢Š\0uQ@Q@¸4P1(£\"ŒŠ5º\ÑKŒÑ¶€Š( Šv\ÃIH7Z)x\Ü7t§M·\Ìù:S”QE\09zQBô¢€\n(¢€E;h¤\"€y’¦Ó£b­‘\Å\0Y¼¶H1ŽIª•q”È¹<û\ÕQ÷Ž)\0ø\ã\ÝW£µ\n£ ƒ\ån•¤­•\0*Œ*ö‹¬\\xwPK\Û96L¿‘ªuw \r\ïˆþ<ºø…ug=Í´v\íoOÝŒ}k‹hYzÖ…Cp>Z`R¢Šr®\ê G\ãŠ—Q\Íò\Æ\Üö¦µ`\Ïhø_¶øg5ÁM\Í\Ë>~ƒF\Ünº¶\ê\Ýðõ»\é\nô˜\åZMÏ­ci\È^\é8\ç5\î\Ñø)½N—T\"\ÓGÁ\à°\Ípòü\Í^ó\àŸ	\Ùx¹ã°»ˆJ[ž¿…cürø5ÿ\0\nõm\î-\Ç¨%XZç©ˆ9r³¾žu!\Ï QO\ØkW\Âzl\Z¦µmÜžL~výv\Î;Rhamñ+§ñ­OcšQqvfF\ÜQŠ–N\ÔÚ²\Ù}ª=µ>\Úf\ÚM\0\È\ÃyŠT\í`Àƒ\èkoV\×5-m\ã›R¼š\í£]‰\æ±lj¥cm\æ·#Þ–÷jœ\Å@¶‰5È±¶(šo/…5Q¥,sÖ¥:žjU=>µ^3V#\å\ÔU 5|bÁ~°=LÂ¼}~\è¯[ø…˜|l7\É\Ç\å^H¿tWg©´©´\æ¦\×4\n¥7J†h¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0u›¨\Ý@^´\êjÓªYHuQHd,)*IY—¥‹K@Q@¯\ÝÝ›œ¨ Ÿñ¥_º+s\Ã~¿ñW\Ú\"°S+Û§˜bPI#üŠ”<\êU°E%Mx²\Ãq$3#$‘6Â­\ÔT¥PE34£­\0:Š( Š(h\Ô”Q@\r¥ZJ(B+­¶/@K6ww@w§)Á\Í!\éH	Lu­YCu¬œÕ‹y¼¾ø \r|\ÔOüU\Þ/§\ëMkµ9\ãõ f\ÅA#î¥™²¹\\±\ëŒPiñ÷¦S£û\Ô0$¨.¿Ô¹©\êŽaqUO\â}\âû?‚|7\nŒ¢+c\êaxnÕ®\ïW¥t~:_+\Ã^P¸\Î1Ÿø\rgx%„wC#©¯¦¡,yõ7=áŽ´\Ú?\í!oõ{\Ôûšû7ö’ø[Ž>½Ýº\ËqK(\Ú;b¾5Š\Îu{eO\å_||ñ]¿¾­¬øw«}1_+BT\'\Z±\Ù[–IT¥\È\Ï\Éû‹Y´»\éc`\ÑÈ‡§¥F\Ò4¹‰$ú×³þ\Òÿ\0‚üsv‹\È\Ý\Év5\âø\æ½%Oižf2—³\Ù;S*Ri¸\ÍzHóÊ–\ÖÑ®\08õ«¶\Z\\—M’6¯©­	ü6\r¨rô\ìK*\Ý\ì-¶)ùëž¸º\ÜI\ïV¯%y˜±5™\'SS\Ô\Æbz\Óc_˜ŠZ’5\ç5“,jj{u\Ý2¯½®\Õ\Üx§Ø©’\é@\êO+7Å‰¾‡¥\Úô\Ï\ÍúW–W¤|l˜.¥¦ÙŽ±[†?y½qVø\á°Ö¤¥4•\Ê\ÙaH\Ô5%HQ@Q@Q@Q@Q@\ÝÔ»¨h¢Š\0(¢Š\0(¢Š\0Tû\Õ%FŸz¤©e!\ÔSh¤1e\ê*\Zšn\0dz\Ô5D\n´´ªqO\Ú=(:*M£Ò£Ò‹€ÌŸZ\ßðwŽ5/j\Ý\é’\æ’33\Çù&¹úm0\'¿¾›S¼š\ê\áƒM3—b95\\ô¥¢€J:Ó¶š1@P(\0¡z\Ò\í¥\Å\0QE\0&\Ú6\Ò\Ñ@Š(´ªi( d\ÊØ§+u¦R­AD‡\ægÖ¥¨Þ¨Dt´”S$]\ÇÖ›\'1·zZµ¦ÙµýýµºŒ™eUÇ¯#5­%y¤\'±ô¯Žld›\Â~‘S*-c\Ë~ƒ\á›Y#Ÿiù}«Ðµ\ÍJ\ÛOðþ•aq´²Ä©ƒ\ì*¥¼v\ë£\Ë$q¨\Ü:_UF6<ºŒMG¹\ÆÌ±\ï_Q~\Ê~&]\Ä\é—BÝŒ¨\Ï…|\ÇðûT³}E­\ä\á¹\ë^\Ïð\Òú?\Ç\Ú{´ž\\~j\àþ5\åfôZL÷²šN\Ç}ûm|7MSC^?z£lŸ…~|\Éó@\ÉSŽ+õö’\Õ#½ðÀ±F$ƒö¯\Ïo\è#G\ÕY<¯-X\äW…“ó{5\Ìz™¤lp+n\Ý\nÖ¶›¥†\Ã\È5»o¡ù\ë¸\à¯b*=QSOŒ*õ¯ªQ>Vú™º–¥\ä\Ç\åÁ„Ç¥s\ÒJòY²jk¹¼\é\rU¦\âK}F\Í÷\rg¿Þ«ò}Ú¢\ßz¹\Þ\åÁ«¦qŠ…W5£e\å\É\éY´;”yp‘Vü3lnµh¨\Ü3Tn\Û\ç\Úz\ê>Û«j’JÃˆÐµEŠ\Üó¿‹W\ßlñ\Å\ÖR8\Äb¹\Z½\âk¦¼ñ6£3î•€ü	ª5ÁSsx\ì6’–’¹™b5%+RR\0¢Š(\0¢Š(\0¢Š(\0¢šM\Ô\0\ê)»¨\Ý@	E;mhh¢Š\0(¢Š\0(¢Š\0Tû\Õ%FŸz¤©e ¢Š)[‰„\Ó3·<â¡¥jJ²«`\ÓÕ³\íPÓ… &¢š¿tR·\Ý5 EMÁô§T–òù3G!¶°lz\àÕN;Ò­X¼¸[©ž@›6\âJ®hi\Z“4P@¢Š\0u\Ú2hÔ›©2i¥\0.\êP\Õ8\Z\0}!4”PEP2ZPqPÔ‹÷EID›©šLšu ·Ú€¾\Ôú)­ÀŒ­u_tó\ãkG\É¬‡ó\Çò&¹s^‘ðŠ³­\íþ0Àb3Ž¸®\Ú+\ßFR\ØûNø+g­5;\é\ÖuÙ¸\é]=×t9´³h-\Ñ\0]”sY|huoÄ’0Ü£}«V{¦n\ã5ôŒ\Þ\ïCÉ–\ç•\ß| \Z.¤n¬·¯$\×C¢\é·	yn]:0;…z\r¦¥¸ŒýkfÕ´÷ÁT¬\ë\ÞQ³G§„©\ìe\ÌM¬Lº½¬Jò\É+l.{\×¯x/L\Õm[\í©$À`69®\ÆI¡n\0\0\nÉ¾‘w2©\â¸p\Øu	\\ôqx\ÅZ\'\Éÿ\0d›Àºca1\Û\é\\ž\ÝK\Äqy±Z\ÈT÷ô?\Ä/\é:ß’Úˆ,Q²£Þ©\évöZ]´p\Û\ÛÆ±¯@W²©Ÿ=Í©ó\Ä\Ú]\Ô+‡·‘JõÈª-.r¤WÔ¿e±¾B&´‰ƒ»Er>$øGk¨\î’\Ë?e\åK™•\â«\Éw:·\Ã^\ÂvU…¤Â³\á	\ÔÛƒnß•r¼;µG3\r¹fõ­5¬¶ö ˆ˜\ßmvþør\âE’\íHv‘]ôš\r´–&‰Jªñ\Åf\è2•DÏœq|žµ\ÚxZQ¦\è:•óq²&?¥aø’\Å,õ¹\áAò«ð*ß‰\æþ\Åøw\"\Ñ\Ú=kŽ¢\å:!©\ã-!¹‘\æn²6\ïÏšZh\Ï\Ê1€)Z¼ªS¥l!¤¢Š\Äb5%+RT€QJ´´\0\Ú(¢€\n(¢€\ZÔ”­I@Q@¢›º\Ô\0\ê(¢€\n(¢€\n(¢€>õIQ§Þ©*YH(¢ŠCMjZ»q¡\Þ\ÛZ¥Ì°4p¸Ê³¢¬‚…*\ÒS\Ôr(\é÷i[\îš:P\ßtÔQTH\Ô´„\ÐE&ih\0¢Š(\0¢Š(\0¤¥§F»\É­*Ô’G\å±\Ú\0(¢Š\0(¢@Â¤_º*:‘~\è©eO¦QH\Ò7Jm\ÐzÏ\áûƒ’CÇ˜\Ìk\É}k\Ù-\":ƒt\è˜\á¶\î\ãÞ½>÷1©±\êÿ\0<N¿½µ‘‚\áøy¯w‘|Àv¯“>©þÔ¸¸ý\Ø\'?Jöü[´º¼’\Î\î@Ž§\0±¯£§%c\ËCeec\ÛÒ¬\Ú\É\"`†\"…h®6ºH¬v«\n»xnI&Y¤Ûœœ\ÕI\äÚ­#¶\0æ¬‹˜\áV\ÜG¥y¯Åˆ\èz<°@1$‹€jTâ™£§&®yW\Å_ˆ’Kâ¤µ†M±F\ã\æÏ½z‡eT\Ó\â‘x\Ú2\Ýk\å\ÝZ\áõ\Ù\'‘‹37\\×±|ñ¼ö¢\Â\àŒ¯&·E#ŽQ³=abòZž—L­\Ôâ§‘\ãž%t`CtÁª2Gµ«¢&RE\Ãt’W\'\Ô\Ô»\ä„_Ê«nÀ÷¦ù‡Þ©™XšmŒ1°\n¡|¿e¶’R>U\\ÕœŸ½Ú¼óâ‹\Þ\Õ,­\æÄ¤\å€=«–£I\\\Ö(óMbO\í/HÀp\ÏYŸ¯\ÄP\éºbñ\å®óqŠ\Òð­»_k‘»ò,Mp¿µ·x\Â\än\Ê\Åò\nùúò=*h\å»R59±Ú™^Tž§P”QFj\0F¤¥jJ\n]Ô”PEPEPšM´\ê(»h\ÛN¢€E.\Ú\\b€Š( Š( Š( Œš( &Š( c\ë{Tñuæ©¦\Ãg3*Øª=+Š7úJ(En9 °Áæ£¢•€(¢Š`5º\Ò5+u¤j\0m>™O^\Ô\0»}9¤Áô«úm¯Ú¥aœ\03Q]¨\Þ\ÊNh	2§ b™SI˜d#Q2•8#€œŒT\äSh \É!\äõ¦QE\0QE\0QE\nUûÂ’Þ¤Pú(¢¤Š(¦€}¼bK˜ôgP:öo¥\ÚÄ¿v8À\ãúM»]j–±/\Þi~µ\ëž0m±\ÇþQú\nôðû\Ì\é>C\ä\éw\×t\í?pW,šœ\×¹3“Á÷®ûGf\Óü#´²ÿ\0:óEWó3n¯IÉ¤Ž>]OD\Ñ>.\ëZ$¼”Ì qš\Õ?´f¦\Ì.WÚ¼¦{…X\Ê¸¬\Ì35‹«-\"µ>ªð/\Äfñm»9\Üw+ƒø\Ñp\Ï\å‚p\rGð/RFómØ€{f£ø\â\Ûn¢\\þ\Å\í\'Í©ônö7<‰þñ©,®§±¸BûH\éQµ35\è\Æm?8jz§ƒ¾+\ÜYÈ°Þñ€+\Ø4ŸéºµºÈ².\æ\Æk\ä\ÅlgšH\ï\ï-˜ù7F?\Ùj\èŽ\'—s	@ûÌ†UÊ²\ÕýF\ÏNŒ¼Ó¢(\ë“_+\Ã\ã-f\Ýv\Ç} \Ç÷Žj½ç‰µMAJ\Ïx\Î5·\×#b${_Œ>-Z\Ú\Æ\ÐX°w\é¸\Zñ\íKU›U¼k‰[s5c20$“W!Œ±Zã©ˆu\rcM\ï„BYi7·®q²3‚k\Ãõ+ƒyª]Ny\Þ\ìyú×°ø¶\èxwÀ±\Æ\åx¯\îMyuÎ˜«¦)\Z’¸Ù ­IE€(¢Š–EPEPEPEPEPEPEPEPEPEPE4õ¢€$¢Š(\0¢Š(\0¢Š(\0¢Š(­Ö\Ò\Ñ@\r\Úi\ÔQ@Žg‹;[nkkE³I¡2\È71=\ë\n·ôy¼»p;RE•B\àqXZ¨Ý¹F+VIŽ\ì\æ©\Ý|\êhŠ|Ë¶CÚ™LŠ( Š( Š( ¥R\"¶\ï­-Eô§+sÉ¤Pú)¥\Çnhó=¨g\Â™|K`üõ\Ï\é^‘\â\éƒ]…ó\\Ã´ó¼Ug\ìIý+³\×\Û\Î\ÖvŽ›ñ^¦\á0™\ÚjD[ø!¤­y²·?Zôo7“\ákTÝ¯3f*¹®ùlŒFÞ¸ý*?\nF“,s\Í¾\\\×#,\íþj‹c®\"–Û¸\Ö\ï\Æ\ËÕ›WŒü\0Šóƒ\r\ÂÈ¬Q”‚\nš\è|Iq&¯\åN\ì_5*=N\È\×j<¬\çO*;\ÒS±Ž)V÷8\äõ¸Ö¦\Zsu¦·J‰F\Ê)6Š}&@\ï\n\Ø\ÑmE\Õô1‘\ÍÒ²cŠ\ìüf&\Ôü\ÖH—q ¸˜\ß/ƒMc§¡ù O˜\nó¢º\ê‡Uñ%\ã\îÜ¡\È…s¬\Øú\×%G©²\ZÔ”QX(¢—	ET€QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0\Ö\ëE.( \ÑE\0QE\0QE\0QE\0\ÚCKH\Ý(2iV›J´\0\êµ\r\ÓGPqUh \ëz\ØÁ?­*\Ü\î\'5žI¤\Üi-\Ç2f££$õ¢˜Q@Q@Q@Q@QHaEzQøP3±øZ›üL¤ÿ\0\n]>¡—\×¿\ï?­s\n\Ôÿ\0\ÂA!¢®œ¯\â(”w\ë^žcžgUñ_+C²OU\æ³6½\âD›m­!\èUEy½\Ãs]\ÓvFI‘\ÓÕ†\Ü\Zik˜\×rXþ÷l\Ý\É\å\ìÝ•éŠ¦­¶ž­»\ëLC÷Tl~juG\'š	`Æ“4\Í\ÔdT±\ÍÌŠplv¤;Å–a]Ï‡ÿ\0\âO\àý[Qc´¼e\×aše©<WGñRõt_\Øi1ü²Jw°-—y’4³I#³Æ¡nµ û¾´\Ú\âž\æ\Ãi3KIŠ\Ìš\\š(¤À(¢Š@QE\0Q@ Šu#PQE\0QE\0QE\0QE\0QE\0QE\0QE\0QIºŠ\0}Q@Q@Q@Q@\r¤=)h S––@\"©8\ãŠ{E\éÖQRm>”…H\ë@¢Š)€QE\0QE\0QE\0QE\0QE\0QJh\Û@\×\ÂDÝ«\Þ\î\Äó­ý9·ø¢ÿ\0\ÏJ\çþ5Û¯O#úšè´´ó<Y;IŸÖ½,6\È\ÆF\×\Ä\Öÿ\0Hˆ\Îy\í\Çõ\ßüNùo¢>Â¼þ\á²\ÜWuMŒQ\Zô§ŠzSÖ¹\r–\Ã\Å>?½Q¯Z’?½V}G\'z’£›¥&\"\n7R7ZJ‘\ÜvjHðz\Ô\rVm\Æ\æ\Ïj–Æµ:Ÿ\é­}¬[© 9j\æþ1j\ÃRñ„±\Æßº·\0\í^\àUþ\Ë\Òõ\rJn8\Î\Ò}q^#ªÞGTº¸\'>c“X\ÊE¤U\'\å¤\ÝCRW+(u´\Ú*\0(¢Š\0(¢ŒPEPBõ¢Š\0u\rÒ›E\0QE\0P½iÆ€EPEPEPEPEP(¢Š\0—4f›E\0;4f›E\0;4f›E\0;4Sh ŒS©Ñ\Í@\Æm>”¡H8Á­(mÕ”gš›\ì\ë·\î\ÒŒø\á|)þLŸ\Ý5}c\Çj6\çµ+‡)Ÿöy?»L’\È\Åi\ìú\ÔsEòš\ÆCzRU\É!œ\ÕyD‘\ÑE\0QE\0QE\0QE\0QE;\0Š(¢„wð—þBÚƒz[\æk§ð\Ì~o‹ý\ï\ë\\\ÏÂ³¶\ãR?\Äbõ5\Øx.=þ\'¹¯W\r±Œ\Ë?c+|§Ú¼\Úc^©ñq@™8\ç\åRú{\×]MŒzŠ½)\ëMZr\×-‡µ$z£©#û\Õ@IQMÒ§5Zc\ÍK	\ë@\ê\0\ÍKc°Òµb\Ôp¸\ä\Ôa3[\Þ\Ñ\ÛR\Õ-\áQœ°\ÏÒ³“)\Þ>½>øwoj¿,·X\'\é^$£jû× |f\ÖÆ¥\â_²\Æ\ç\ìö‹\åªg€k\Ï\ËW,™ ”QEfET€QEH#¤W¥\ã\ÑKQ\"–\\ó@QVµ‚I·M‰Ž•V˜Q@Q@Q@\0\ëN¦\Ñ@Q@Q@\Ý\Ôn QE\0QE\0\Ê)\Ûh ¢Š(\0¢Š(\0©\Þ\Æ\â;8\îž	V\ÞF*“2\áŽ Z‚¯M­\Þ\Üiúd³³\Ù[\È\Ò\Å\è¬\ÝhQ@©!ûõKoÌƒ4†h~\è©ˆÿ\08¦Æ½3RR¹C\â›RŸ»M©¸\ì\Èó\íH\Üö§)\Z‹…ˆdvj\Äx­*­uT‘T+Œ¸¤§I÷©´\Å`¢Š;\Z\ÃwR\Ói\ËÒ™\"\ÑE\0S©´\ê\0)\ê¿52¤^´\Ð§\Ã‹\Ëñÿ\0L¿­v\Þ	¼NûX®\áü„/Gý1þµ\Ûx4ù~(_v¯_±”\Í‹\ÃlˆO ¯&“\ï~5\ì?­ÿ\0s™\ê?•x\Û7\Ì}s]5z-\ÉVž´Å©r›!qSC÷…GR\ÃLù>U\ëT¤oš®\Ï÷j„MK!NZ‰jU¬[f„ñv\â½#áµ¸\ÓôýGZ•p–¨vµy\í¬^c*õ=+¾ñ\Õ\Øð\Âûk$m“\ßü\ÏëŠ™2\Ò<7R¼mBþ\â\á\É-#““õª´¿\ÃI\\²((¢Š†ER\0j\ÜKºªT\Ñ1Z@M4{j»\01Š™œµDü\ã\ÐmIS­¬\ÈZŽH^?¼1LQE\0QE\0QE\0QE\0QE\0QE\0\Ê)vÑ¶€E7u¨\ÔQE\0QE\0QE\0QJ´\0m£mH«‘š_,R-´m©<¿z<¿z\0eMj@f¡§Ç\ãµF\ÜMò¯Ò¤Ý“P\ÂÛ”qRTšGq\ç\îše\rÒ›RX­MjZe¡¹ûµ5W³VˆhÍ›\ï\Ó*Y‡ZŠ™!GcE\02œ½)´\å\éLh¢Š\0)\Ô\ÚPhjEû\ÕE=[š¤aðÌ‘«\Üú¿­w^M\Þ+Q\ïýk\Ïþ¾\ÝrU\ì\ÑZô’¾,\çœW­†2™\Òüf!tø}\Åx‡ñW´ükùl­Fzÿ\0õ«\Åÿ\0ñ®š\Û#¹2ö©–¡^\Õ<}«‘\"E^3Þ¤Ž´\ßJ*ˆapÝª“sšžVª®jdr\Ô\ËUA«1sŠÉ¢\ã¹\Óø7Km[[´·p2\ßAÉª\ßµ\å\Ô|P–[\Ù\ÆÙ®\Ë\áŒq\é:n­­NŸ,0”Œ·÷½«\Ã5½Qõb\ê\îF\Ü\Ò99ükžLØ¢h¢Š\Â\àQEH8FYv¦Ó„„)^\Ô\0‹NGJe*\Ð·ZXùuú\Ó\Z•0}\é\Ô[Â¦SŠ\ÇÖ”,ˆI¥\å®*¥õ\Ç\Ú9ô¦J(¢¤Š( Š)(h¤\ÝF\ê\0Z(¢€\n(¢€\n)»¨\Ý@	EPè¢Š\0(¢Š\0(¢Š\0)V’•hUû¢M_º)\Õ\0÷M-6O»@ÒƒƒšLÑº¬ö·D½ªþ\î+<¹\íW$¼#\éRZ.\î\ÝIU\ã¹\r\íOóG­I©&h\ÍC\çZg@–\ÅUšA\ÍG$Ù¨$“Þš+TtQTfQE0\n(¢0¢Š($(¢Š\0)\Ê\Ü\Óh^µH«\á\Û\íñ\ï!\é>\\x°}My[gˆ­Ï±\ê\Ïü%©\ÏñW«…2™³ñÉ±md>¿Ò¼gø¿\ZöoŽ\ÜCf>¿Ò¼c½uW\Ø\ç,GÚ¦J‚>‚§Z\äF—d\ëósMjU;i­\ëTK\"\Õw©dëšŠN\Õ\Z\Z½jåš™%E%ˆQz\×cð\ÓC:×Š-U—0B|\é	\éYH\Ö&\çÄ©‡‚¾\éú:¿ú]ö%ƒ’:\åšð¦®\ß\â÷‰›Äž0¸!É·¶&(×°\Åq\r\\²5Š(¬XQ@\n¢‚(ZV\é@\r¢Š(\0 \Z(ª@.\ãF\êJ(\0¢Š*@(¢Š\0))h \í¥\ÛKE\0SwQº€E7u¨(¢Š\0(¢Š\0}Q@™¢€Š( œ´Q@¯KE\0\Ù>\í:™\'Z`FÔ”7Z*€§³\îZeŠC\Öf^”\ï´7¯\ëQQAD¿hjO8\ÔtQdcšB}©¹¢ŠQE0\n(¢€\n(¢€\n)\Z›š	E\"\Ò\Ð ¡z\ÑERk\Âryzý©\Î9\ÅzÏƒñÿ\0	ˆ\ãž+\Æô6kVG·˜+\Ù<:ªž0·õg¯W	¹MŸŽÿ\05½©\Â+\Æcù±^\áñ³Kº–\ÄÌ±3\Å*+\Ä-ús]\ÕÖ‡<K\n*A\Å5ik„\Ðr±¡€\Ð\Í\Å\0A#sLcœQ#|\ÜRu¬\Ø\ì>:õ/c\Âõ½vN$–#^¼ƒ^u£\é\í©jVÖ«\ÖW\Åv_5(ôm3MðÍ«\0‰yU}x\ëXÉGŒ\Í3O,’±%¤b\Ç>ô\Ì\Ð\Ý)+šQP\É\n(¢•„*Ò·JE¥n”€mQ@R­R(§ªæ•—­IREPEPHzR\Ñ@¢—mh(¢Š\0(¢Š\0(¢Š\0}ƒ¥-\05º\ÑKE\0;¤¯Q]Mÿ\0€o\íü8š\ä0™\ìI†¹]\Ø\Ï8¯eðw‰ô~\ëZUÖ¸±_Koˆ­d^¯\íHgqÛšr\Ô0ñ¨\â¤SE\Â\Ä\êÛ©i‘ž´\ìÔ€µŸzŸšd‡\æ¦mÖŠóIšwE&ih¸ÂŠ(¢\ã\n(¢‹€QE\\Š(¢\àQE\0¢Ž=h\ãÖ‹€M¥cIš	´´\Õ4¹¢\áah¢Š ,\é¬RþÝ‡Q\"×³xtÿ\0\Åy¥ 9ós^\'n\Ûn $\ào\îþ	„Mñ\Ã\ÊFw2šõ0\Í[\á>µñ‡§\ê:¶RÛ¡-Žk\à¯igAñeýŽ\nªHvjý\Ô\ìM\Â(dOJøŸöŽ\ÑÎ‘ñ¾Í‚TŒw¯N­¥£Î¤\ß5ŽF-\"°\"—5çž…‚›!\ÂÓ³Q\Êi0±\å9E%,3\0+\Í=\áŽ²\ê\Z­À\Þ\ÉKno\\W™x\ë\Ä\r\âO_^–Ü¥Ê§\ÐWªxšûþ/†	e—\×\ë¸\àò¯\nRvòrk	!Z’œ \Í.Õ¬‹°\Î\ÔSˆ¤\"¢\ä±(¢Š. £4QH“FM#u£4rÒŠf\ïz7{\Ð˜ºšY:T+&\ÞsJ\Ò\ïN\à5º\ÑIFjah¤\Í¢\áah¤\Í¢\áah¤\Í¢\áah¦\î£u(£4f‹ˆ(£4f‹€QFh\Í\ËÒ–‘Of‹Ž\Â\ÑIš(¸XmF\Öñ³‡+óŽ†¤¢‘CZ•i\ZŠH¦—qõ¦Q@\Ç\î÷¤-\ïL\ÝF\ê\0^h§dQ‘@\ÆÓ–ŒŠ2(h¤È£\"ôŠLŠ2(\r¢“\"ŒŠAh¤È£\"€\ÐZ)sò\æ¯j\Ööö¦\ØA7œ$ˆ;ÿ\0²Çµ\0g5%;\"›LB56Š($r\Ò\Ò--´´Õ¥ÈªT\á\Ô\ã8\æ½\ßÀ·B?xn\ìðcˆ1\çÚ¼!H¯bð\ÞeÎ‘.sòb½#÷Œ*\ë\ê\ÏüZ·—R0\êUg ^Eûj\Çeu\â-\"þ\Å@Žhs¹z)-\ìRñgc7‘±wg¦k\Çþ!xš}sT\Æwš\Þ\Ôl_·­zµ#óu<øG•œ\ätSñL\\…ëš”3\\2gbMF\çŠ½\ê&jÉ²¬(®“\áþ‚|C\â[8\n\æ\Ý\\I)ö\×3»Šô\ÝDð/Ã»­a\Æ\Û\ëÑ²œ=Ea&j‘\Ãübñ@ñŠ\Z8ú-¯ÈŠ:WK$#—v,\ìrXœ’i¹\Í…\Î(É¤£5›c¸õ¤jn\ïz7{ÔˆZ)2(È ¢“\"ŒŠ\0Ž’Š( (¢ŠWTµ>Ža¢Š)(¢Š\0(¢Š\0(¢Š\0eQ@´\n(¢€\Ð(¢Š@¢Š(\r\ÝF\êJ(wQIEu©(¤\î£u%\0»¨\ÝM\ÝF\ê\07Qº’Š\0“p£\"’’‚‡dR\æ™J½h\ÔQJ½h\0\Úi1O¤<\Ðh¢Š\0(¢Š\0zŸ–†û½)¥\rÒŒn”\Úst¦\Ð!	£u\rIA#•©wSV–€\r-4R\îª\Ë\ß\é^£ð¶\ä\Ü5Š÷Y‡Ò¼º6\æ½#\àšùúš\'ý5\"»p¯\ß2©±\ê—wy7\n‡i*À×‡]H´¦V9!Žk\Ý/c\Ûw4_\í^­C\äø‚õð\Ë^I©Õ€>J†Þ¦“\åS\\¬\Ö%I:šˆô¥‘©»¸\æ²l»\Z¾\Ðgñ&½ga\0\ËJ\ã>Ã½i|vñ—Zµ\Ð\íH[m>‚ô\Ü:\×að\ê8|\àS\ÅwXó$_.\Ô6:óœW„\êÏª\ß\Ü^NKI3–$\×4¤l‘h\Í4œQº±lb\ÑIºÔ€Ö\ÃÖ˜\Ýi($“põ£p5-\ÐÞ´»¨\Æ)»©X\äSh\å4¹ö¦­-K¹ö£u%†.\ê7RQ@ºÔ”P\î¤,s]/ÃŸ\Ã\ãZ\éS\ÞÇ§À\çt“I\Ð(\ë^\Ó\âÏƒþ°±º‡D¸mF\âðe œu œ7\Z7\ZY#1H\èF\n’)´\0»¨\ÝIE\0.\ê7RQ@ºÔ”P\î£u%\0»¨\ÝIE\0.\ê)1E\0:Š(¥r¬QE\r§m¢”u¢\áaBÑ¶–Š.w­5ˆ\Í+SZ;\"…#4\ÊZ@I‘JTkK@\îdS–\Ø\ÒdSh C²(È¦\Ñ@)¡ˆ\Å5zP\Ý(1¦\äPzSh3\nLŠ~G¥1XEa\ëKšŒõ4±õ¦HúU¤¥i€þ•\èŸd\Û\âü\Ü\×¶\ì\Ê>Zô/‚øKŽ‘\îýk¶†Œ‰\ì{Ý¯€5\íz\â\âú\ËOškP\Ä2+\ç/\Ã.›\â\Ûø®£hdó>\ëŒf¿Y¾\Üiú—\Ã]-ì¼¶R¬%\ïógœ×…þ\Øß²ý·Š´i|M\á\ë5R¶Ì“\Çû\Ãk‘fjU\Ý+t\'\Ø>^s\à«5WNin8È§YE$ñL»Y\ÒPE2é±œWªÌ¢Po½Wt-%õ\ÝZ\Ú\Â5%\ç`¹†y5A²\Í]—‡õ(ü \Ý\êr·—\nb€gx\ë\\òz\"\ÏÇ[#YxKJù4ý60$+Ñ¤#\æþU\ä£m>\æò]B\êk™˜¼’1%›­G\\¬\ÐF¦Ò·ZŒ±É¨¸¢£\Üh\ÜhLQ´T{\0I´R`S7\Z7\Z\0vM.\ãM\çÒ“u$¢‘~\í-!ŽZZE¥©¸\ìQIšW†\ÑHÍ´S|\ÃLC\è¦y†0\Ð\ZC4–ó	b‘\â‘z2\rz†¾0\\xoÂ’\é\Û	n\ßwúL‡\'šóÇšJI$ždŒ\Äò\Ç\'ñ¦\äSh dQ‘M¢€‘FE6Š\0vE\Ú(\ÙdSh dQ‘M¢€%^”R/\ÝR¸\ì-Üš2jJE7&Æ€EG¸úÓ·\Z\0–Šb±¥É jfÁJ\Ä\ÓriˆFi3JÝ©´\"ô¥¦/J\\š?&Æ™“FM\0:ŠnM4€uÜš2h‡T–\è²\\F®HF8$T94ª\ÅXJ\0¹wf\Öø\Ü6ƒ÷}\ÅU«7¯u·y\à*«L4\ÖoJkRPI$6ò\Ü+´q³¬c.Àd/Ö‘T©©-î¦·YR7*’®\Ö^Æ£\Í1¥_¼)™4n>¸«Š¸o\Ã\Ù,¦ñeµ¾¦»\ìdÊº\àz:û]§\Ã+\áÿ\0Š\Ói²:²¨h\Ã€y\â¼\ãÁ:}Î¯\âkX\í£óD,$›\æjzûþ\ézM\Ôs|dK•9ŠY\Óô\Çø\×}-”_ø{ñ\Ó\Ä_üAsml~×¦	û39<â½«Xý«/<m¦¾›Œ7	²F/¸GJùŸÄ–«ý¬\ç\'5©¤þ\ä&\Ñø\×\Ôpõdª\Ê:œ\î¬×ºž‡/ñ;\Ã0øwPy£C\å\Ìw\äw&¼\Ê\î^½¹¯xø¢Tð¸½,`}kÀ\Û÷\Ò\ï\éN¼Tv\Éô\ËO:m\Ì>E\ä\ÖWŠµO\í+ˆ\âR|¨IÀ­+Û¯°\ÛmVÁ\"¹Y$ó%c\êkÈ“\Ô\éˆÍ£m7mH\ÔÃšÅ”1…7ÒŸƒIƒP2&>\ÔÚ•”\ÔeH¢\âŠ(§p\nrŒži´ªqJ\àH\ßt\ÔT\íÆ›@/\Ý´\Õ<Q“R\ÊD‹KLV÷¥\Ý\ïR0jJB\Ä\Ñ\Í\06O½M¥cšJ«’.¥>”\á\Å¢\áa”S¶\Òm¢\áa(¢Š.\n(¢‹…‚Š(¢\á`¢Š(¸X(¥\ÛF\Ú.Š(¢\ábUû¢Šq¢¤aºÔ”P1wQº™š3@®:—u34f€¸ý\Ô\ï3Ú¢\Í(4.i)-F\Ò*–>\Ô\ÆR§k\ÃwÖ¶±\Ý °uú\n\ËÔ¤I¯\ås\Å\0T\Í©( \ÝF\êJ(Â–š´¹\0´RdQ‘@E&EÀx\éHÔ›€¡˜P27\ëBõ¤c“B\Õ–Šn\á\ëF\á@´$U\Üjî—¤¶©{\r¸aó\Ë1À<\Õ\Ø\Ón+H­Du>d^´òl%\Û3\äI,gklŠ‹Â·’\é’ù¼\Üg>¸¬^jöƒ!Z\ÓÛ¸¸ÿ\0B\ßE\êd\ÏrñmÔ‰\êphiLJ\ëX\Þ\"cý¥ùV¾÷V½˜lrKqúÒ›‹¡9ù×…,&\Ö\âr\ã9×»\ê\r¸\í^¸¯ñ–û=Zx3\ÎwZ\å\Äü%\ÓG?ªN\×R’3Ò²Ê•\ê9­	1žy¬ò\Ùb	\äW…&vXv\Þ3I¶”t¢²\0\Ú)6\Ò\Ñ@µFÂ¥=*6\"‘5%8\Ò`z\Ð1(£hõ41Á4(¦óG4\'ð\Òn¤\å÷£5,b\î£u&h\Í!V¥\ÝLSJzPn£u5©(ýÔ¡©´P1üzPh§D¡¤Pz@Q[w\Öv\Öö!\îlV9Z*X­ZaqD¶­Sš\0ŠŠnh\Íq\ÔSsFh\ÝF\êJ(QE&=\è´Sh .:˜\Í\éM\Éõ¢‹ºÔ”P!wQº’Š\0]\Ô+sIE\0J\r.\êjý\ÑK@\Å\ÝF\êJ(\0¢Š(\0¢Š(\0¢Š(\Z\n)v\Ðh”QEPM©\Z’˜EM4%(¤§¨ ¶Ÿv®®j­_O›¥k\Ä\Çzšµ¥¿—©Z6>\ì\Èñ\áUý~µ%Ÿü~Aÿ\0]ù\×U=Ñ“=\ËÄ£ý:j\è\íû±YÚ¬Fx\í>X«újyqŠö\á±\Ì÷q7úK*ð\Ï^}§\ÄW¯\èûk\Ú/fòZYO“^®^­B\ê]\Ù,\ä\×-\èkOs>\â\à\í8ª¡þl÷¤f9\"™šñ:ËŠ\ÙQKºª«Sü\ÃR\Ôn¨D¼Ò™\r\0+0\äT&œÍœ\Ói€SZH\Ý*\0mQLŠ(§pÇšMÔ²}\êmH…\ÝF\êJ0}(\ëÒMO»N dy4\äRP¿xP\"Z(¢¢Š(\í3²\à±\"¡\éN¦\Ð\Ñ]˜i·†j­E\0.\ê7RQ@…\ÝF\êJ(Z)ža£\Ì4}\Ï0\Ñ\æ\Z\0BÜš)( AE.\ÚLRQE\0QE\0QE\0\å\'¹4”Qr…É£&’ŠwrhÉ¢Š.“FM”®\ÃqÖœßš4”€—9¤j•¨M4­M @O­¤aI@É “ŠJ*®EH­šŽŸ4$]µô\æ´ªVf¯Š\Õ2DÉ«JZ\â/gÎª¯_Æ¯\é5\Òöýk®ž\è\ÊG¾[¨¹³¶q\ÈòÀ«Xò\ê?BLƒŸ\á\Í[š\×.ƒÔŠ÷\â­•\îpŸu!£ø~FVý\ä\Ù\\Wƒ\îo,–=kÒ¾4j[õD´V\Ê\Ç\É\æ³\Êp:×‰‹ž§E$C‘FE6ŠòÎÛ±Þ—½2Š4ûý\éw\Ôt¡©\è2@\Ä\Ò\ä\Ó(\Í“H\Ä\âŒ\ÒThdÑ“N¦S¸“FM%\\n´”\ê)\n\Ãi\ÊxQL,z‡Àý\Ã>4×¯ô=a\Z\ÛQ¹µÛ§\Î9S)8Á´\ï\Ú+ö{\×þ\0Í ]\\Ü®¡£\ê\ÊÊ—\n»Lr’Œ>+\Éÿ\0¶5\r\ê\Úv±¥6\Û\ë)–X\É\ésÏµ}[ñ›ö´ð\ß\íðøv\çE’\Ó\Å\Ðn\"\n»”Mf\Ã\Ô¹\â¢NI®U§R\ÒV>US‘\×4£5‹ù+uÏ¶*\Í]ˆ&ŒšJZc“FM%\0d\Óri\Ô\Ê@6Š(¤HQE\0QE\0QE\0QE\0QK¶Š\Â\Ð\Ý)›\Í!\ê-Üš2h¢›“FMa\Ô\nnM\nNhQMÉ£&€\Ô}R-p¥¤ZZ	\ÒqJ\Ô\Ú#P>\í&h\Ïpj]\ÕM9I\Å\0:ŠnM4\0\ê)¹4d\Ð¨¦\î¤\ÝN\ÂŸ¨²i\Ê\Ô\Ð\Zm\Í^V¬›iŠ¶J\ÐI\rj‰&_\ëWô¦\áûUŸ?Z¹§ü³\'Öº\é\îD¢¼&Dš\\þZÚ¸a¶i\ÏD\çò®\áû}£KŒg‘Z¾8¸\Z_„o\\¶\Öl*þ9¯}¿r\ç+ZŸ-ø\ïX“Pñ5\Ë1\à9ŠÁ\Îy«:½´©¨<’œ\î9\Îsš¨O¥|\íi)3®*\ÈuÜš2kˆ\ÒÃ¨¦\äÓ·{\Ð\Z]´sJi\\,S&\ã\ëL	2(\ÍG“FMH\ä\ÒSrhÉ QL,h\Üh\rG\ÑMM4£¨¦\î÷£uP\Ç2†\àŒŠ“K˜\é:•½\Ü +F\áøýJ‡w½#7½6|Uuc{¬4úzypH¡Š\ãnÿ\0­d\Ô{(cA#\éi™4n4RM\Ôn«\×ZÅž—m#\'“ppƒ<\Ö}°\í\Ô\Ú)\Z%ŒM&MH¬:ŠnM4‡QMÉ£&€°\ê)¹4d\ÐE7&ŒšÄ”Srh 5E&EŠŠLŠ2(h¤È£\"€•z\Ór)TŠ\0Ñ¶“4f˜‡QM\Í 	–š)Ô€1šM´´P(\íEjX\Ú)v\Ò)jHQMb)¹j”U>q(SÒ·/´\È-\áPŒ\Ð9“\Ô\ÒT’©Y\"£5 ¹BŠLŠ2($‘d\ÚÀ\Õ\È\îBÇœsYùõlµq`w\Þ°²ñŸunKEy™ù¸\éô¬\ëX\Ì7JŒ0\ÊÜŠ‡\áÖª\Ú‰¡\n¡–e1¶N1žõ»¯X­®µòC¶~•\ÙHÍž\Ïð¯\æ·\0ô¨>8jB+UnZM\Äf¬|-\Çö~\ïjóÏŒ:¯\Úõ\çP~UkÖ©.ZV2\å\Ö\ç™\ß(½M\ÅpÃŠÅš-±[}8ª\×H\Z3\Åx3\Ü\èFE1&E`1iW­&E;\"‹JÔ”fŒ¢\Å#cmH¬%\ÜÑš?&Œšfh\Í¨\ê)¹£4\"\Ò\Ôaˆ¥\Þh(V¤£u&EQ\"\ÑI‘FE\0-™dPæ–›‘Fhc#2ª–b«\ÑI8S2(\Ý\ïRPúF¤\Ý\ïFh­ICž”\Ü\Ð!\ÔSsFh\ê)¹£4\0\ê)¹£4\0\ê)¹£4%\Í\æŠ\nET–QE\0QE\0«Ö’•z\ÐÖM^´\ê\0(¢Š\0rô¥É¦­-!XI¼\ÐÔ”]\Ôn¤¢˜[\Æ&b¥¶ü¤Š…ŽG4«I@¦\Óö\Óv\ÐöWF\ÞU=El^j©q\Ú8\ï\\þæŸ¸ú\Ð\×MºEúUr\Ýhf\'½6ª\â¸QE´”U¦\ç‚\Î<Meþõw>\"ÿ\0¸®O\áå°›^IJ±© ú\Z\Ü\Ö.ü\Ë\çmÛ¹\Æk²“2g²|8—\É\ÐeœS\Íx×\ïþÙ«Lû²7\ç^³\áyŸƒ%s\Þ<šðýZo´^H{?\Ì\×mIsEE?zŠ|yMŸJ°«ò\Õ÷òø¯2e¤e¿\Þ?Zm-%`PS\Å2œ)0šJ)7Ri\Z“4”€(¢Š`QE\0QE\0QE\0QEPQ@Q@QH\ÑIšZ€\Z\Z’Š\0F¦Óš’˜	ES\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢“uªŠM\Ôn ¢“u¨h¤\ÝF\ê\0x\'\ëK¸úTY4 œ\Ð+“\ÑQ«)ôr\Ò\Ó¥/ð\Ð+ŠÔ”q\éJ¸ô ¢Š(QE\0Ý§ÖšTóO\ÝAn\r‘­&M+t¦\Ð1ÁY²B³Ô…$\nnjýŽµq¦\Ù\Ü\Û\Äp—\rY\Ôvh\Í6Šzˆvh U\Ý.\Ù&¸Ä¿w«[Œ\í<;fš•ö‡o\ßL0\Æ{\Öd\Ód\ëŸz}\åñš0€\åWš§o\Ëþµ\Ù3\Ù>\×öO\03g£\ÅxÌŒ³õþu\éž(º6þµŒoZóm©\å\ß¤¥ \ì7~\Õ\Îk\'P“sT\×\rg\ÌÛ³\\“e\æŒ\Óh¬@vh\Í6Š\0vh\ÍHb\æŒ\Óh©\ìÑšm\0\ìÑšm\0\ìÑšm\0\ìÑšm\0\ìÑšm\0\ìÑšmÀvh\Í6Š š3M¢€š]\Þô\Ê*?&Œšn\ê7P=d\Òn÷¤\ÝI@‡fŒ\Óh C³Fi´P³Fi´P³Fi´P³E6Š\0(¢Š\n(¢€\n(¢€\n(¤ ¢™š3A»©ÁÏ­Ašr\ÐR\'^”¿\ÃøTj\ÄR†ùH¤$¢’26\ÕR\Ì{\nVù[ƒ\é@\Ã4fŠJ.h\Í7u©u›‡­‡­\Z5=)¹ö¡¾õ!ª	º’ô¦\æ1ôS3K\Í1\ÝZ6-´û\Öm]µ<¥Z(\Ôßžõ5¸ý\à\æ©+U»3ºE\ë¡\î<mu»Ãšl@ÿ\0	þ•ÁI!X\ë¢ñ5Ã½½œe²ª§Ê¹[\Éü¨r­\ÃóTÙ³RHÅ¹¨\rs±\ØZ)™£5$¢™š3@n£u6–¤ ¢Šiú\Ð+¢™š3@‡\ÑL\Í \ÑL\Í \ÑL\Í \ÑL\Í \ÑL\Í \ÑL\ÍªôS3I‘KQ’QL\Í¤!ôRR\Ð;8\Ä\ër¬œ\Ç¢\ÍN÷’\Én°3f59\è:)™£4}\ÌÑš\0}\ÌÑš\0}\ÌÑš\0}\Ì\Ñ@¢™E+šX}\Ê(¸X}\Ê(¸X}%6Š.\n)7Qº‚l-9i\0\È\Í( --Ò–‘V-\éwKex’º\îPzTºŒ\Ð\\\\I$chcš£Eº\Ô\ÊJ.\ê7Ss\Í.\êC\r\ÞÔ»©” \Ó\ìûR1\ã¥&\êLš\0F¦Òµ%(R¯ZU\éKTM‚­Û¶\Z©1\Æ*Å»U\ÄfŠ*þ›\Ì\ë\ÇzÍ¾QZº*‡¹\\Ö©ˆ¿\â\'ý\äIýÕ®Rñ¿yŠ\èu\é7^þ\Ísw‡\ç¤Àª6\ïO\Í6²P½)Y¹¤\ÝP+E*ò)\Ô\Â\Â/JZ(¤0¤n”7Jf\ê\0Z)7QºXZ)7Qº€°´Rn£uah¤\ÝF\êb°´Rn£u!\Ø7Qº’Š.Fi7RQ\Ì\nJ(¢\à>ŠM\Ôn ,>–£\ÝF\ê5´Rn£u°´Rn£uah¤\ÝF\ê\Â\ÑIº\Ô…¢“u©ˆZ)\Ûh ,6ŠM\Ôn¨5ŠM\Ôn ¢“u¨h¤\ÝF\ê\0CÖ’‘¨Zw ‘O¹4ƒ¥H¿tR\ÓU¸»©x4¹¨÷Qº€°\êJM\Ôn ,0““FM©¤ É£&’Š\0\\š2i( ŠMÔ›š\\šn\ê7S\rJž3UªXŽ*\â\É4ü£·¢ÿ\0®RkÕ¿¤¸š»W_›ý/9\Ç4…\ÎkGZ”µ\ÑÉ¬–84›‡\"›¸\Ò\ZJ\Î\à;h£h 7<ô­mC\Ãó\é¶1\\\Ê\é²Q•“HfP\ã¥.M%ArhÉ¦fŒ\Ð!\Ìx¦Rõ¥\"‹€\Ú(¢\ÄQE\0¢Š(¸QEÀ(¢Š.EQp“FMR\0É£&E\0QE;€QE\\Š(¢\àQE\0¢Š(¸R\ÑpŠ(¦ü\Ê)”PE\"\Ò\ÔQE\0QE\0QE\054fš\ßxÒ­$^\Ô\êbö§æŽ¥¤´\\ ¢Š(¸™£\"‹€\Ú(¢‹’RdQ‘@E&E\0\ÆûÆ“4§©¤ 4fŠ9 \çÞŸ\æ›Bý\áL\rKnksO}±–¬+Oº+f’«¸ŒMNM÷MŽ™ªMS\Ý6\é\Û\ëU\Üõ¤\"3Ö“4QR0\ÜGzžKû™$“\È\è:+6EAE qõ£qõ¤¢†h\ÍP©æ•\Ú(\0\Í¢Š\03Fh¢€Ñš( 4fŠ(\0\Í¢Š\03Fh¢€\nJZ(ƒ4fŠ(fŒ\ÑE\0£4Q@h\ÍPš3E\0fŒ\ÑE\0*Ÿzû\ÒQ@¢“uª\ÈŠ\0‹KLRirk&]‡QMÉ£&\ØuÜš2h¢›“FMa¬>cBŠ	9£&¨‘Ã­;5M46\ê7SGAE+–;u©›¨\Ý@\ÝF\êmhº\Ô\ÚM\ÔhII\Í\Ò…¢“š9 ,-œ\Ñ\Íah¦\äÑ“@Xu!\ëI“J¿zš\Z–£\å±\'\î¬\É\ïŠÉ³\çh­JM¶˜«\Î\È\ß9>ô\Æùª\Ú\Úùœ\ÔS[l¥Ž\ÄEG½\ÇRƒh÷£h÷¢ŠÁ´{Ñ´{\ÑEa´SrhÉ¦F£¨¦\äÑ“@j:ŠnM4£¨¦\äÑ“@j:ŠnM4£¨¦\äÑ“@j:ŠnM4£¨¦\äÑ“@j™£4™}-74d\Ð-GQMÉ£&€\ÔuÜš2h\rGQMÉ£&€\ÔuÜš2h\rGQH´´\ÄQE…\ÒhÉ¦\ÃQL\Üh ZZh4»«3Ah¤\ÝF\ê\0Z|’D@*0Hj=\Ôn ¢“u¨­%Šw$(¢Š.‹\ÐR\æ£\ÝKº‘B\ÑIº\Ô\0ú)™n\0¤\ÑIº\Ô\0ú)™dP\è¦\Ñ@¢›J\ÊS ¢“u¨iW\ï~”©÷¨@l\é\Ãs-;^›n\Å\éL\Ó9\"£ñÅ§D†jÀ-\î„qŠŠ\æa ô¬ý\çÖ“}@cIº›º\Ô\0\í\Ôn¦\î£u\0;u©»¨\Ý@\r¢›šUª$Z(¢•À(¢Š.EQp\n(¢‹€QE\\Š(¢\àQE´”QL\ÑE#R¸	“J\r6•z\ÓiT\Zr®jeŽ•À‡\Ë4›O¥Y\Ðc‹VŠ|‘\í¦Qp4n¤¢¨B\î£u%\0Œ\Ü\Òn¥\Åh7QK¶Š\0¥-\"ô¥¨,(¢Š\0F¤\ÍqŠn\ê=ii«N –QE\n(¢€\n(¢\Ü(¢Š\áEP0¢Š(\0¢Š(Ô´\Ý\Ôn \0ž\Ôç‘¤\Æ\ãœ\ne\0QE\0úUû\Ô\ÍÔ¡¨½£®\å\ÏaYº«î¼“\Ø\â¬\è÷<Ñž“\ÍfM!–BÇ©4\\\ZJ( AEPA \Z	 BR¥¦µ•i)h\ÔSriV€Š( Š( Š( Š( Š( Š( QOÛ»\ëS:f\\\Å\0AH\Ô\æS#š\ÔÀm*õ¤¥_½L1.j}¸\Ûe,x©[\Ó©:)\ÍMn”\Õ\rM%Bi€QJ(\Ý@	E.\êJ`QE\0QE\034¹¦Qš’‡14›­%\0\î½y¢›FhÔ¼šf\ãORh\0\æŒÓ¨¤y£4\ìS\0¹£4\Ý\Ôn¦³Fh¥\Ú)\0™£4\ZJ`.h\Í%\0ú(¢•Àm \ÒSsFi( \ÑM\ÝKº€ŠpŒe\Æ6ƒƒ\ëLj@I\Í\í§†\rFÆ“4S†h\Í%\Ãw½½\é­Ö@)£4\Ú(‹šL\ÑEŠ2)´\nÃ²(\ÍE!\â€š3L\Í~h\Í%\\ÑšJ(sFi( \Í¤¢€4f’–€Ÿ\ëºk\ß9®b¬E©M{Šc&\ÖR\à•\êk;5$“4¤–\ä\Ôt2(\Í&\Ú6\Ò\r–·&\È8\"¦i·óÞ³\ÃNó\r\0\\\ßF\àj¯˜hó\rbYqš®\Ô\âÅº\Ó\r1Š´´\Ú(¸®£4\Ý\Ôn c³Fi( B\æŠJ(ÿ\Ù','Lâ€™esemplare sembra â€œfluttuareâ€ in posizione verticale, con il mantello rivolto verso il basso.',NULL,NULL,'UDPDW13YB8','SSEY2O52BP');
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
INSERT INTO `luogo` VALUES ('Oceano Indiano',NULL),('Fossa delle Aleutine','Alaska'),('Baia Sagami','Giappone'),('Fossa del Giappone','Giappone'),('Golfo del Messico','Messico'),('Manus Basin','Papua Nuova Guinea');
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
  `Nome` char(20) NOT NULL,
  `Cognome` char(20) NOT NULL,
  `Codice_Fiscale` char(16) NOT NULL,
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
INSERT INTO `organismo` VALUES ('0F5W9M2W7L','Tiburonia granrojo',NULL,'Grande medusa rossa','Il nome di questa medusa deriva dai suoi colori rossi della campana (granrojo = grande rosso in spagnolo). Presenta una campana di grandi dimensioni, mentre i tentacoli sono piÃ¹ corti e tozzi.'),('364FIFD9JR','Atolla wyvillei',NULL,NULL,'Questa specie di medusa presenta una campana rossa e un lungo tentacolo bianco che parte dal centro della campana e si allunga per una decina di centimetri'),('6567LBSV3P','Larvacean',NULL,NULL,'I larvacei sono tunicati che abitano diverse zone degli oceani di tutto il mondo, per nutrirsi utilizzano una \"barriera\"\" di muco che filtra le sostanze nutritive.\"'),('7F0JSTSGR0','Magnapinna atlantica',NULL,NULL,'Questi calamari sono caratterizzati, come gli altri membri del loro genere, da tentacoli molto lunghi, anche fino a 8 metri. Abitano le zone piÃ¹ profonde e oscure degli oceani, ancora non si sa di cosa si nutrono e le loro abitudini.'),('83SIM574N8','Hexatrygon bickelli',NULL,'Razza esabranchiata','Questa specie di razza presenta 6 paia di branchie, da cui deriva il suo nome. La testa Ã¨ allungata e le dimensioni totali possono raggiungere anche 1.7m. Solitamente vivono a stretto contatto con il fondale marino.'),('A69M3QUS9A','Beroe forskalii',NULL,'Medusa pettine','Questa specie di ctenoforo di piccole dimensioni presenta un corpo completamente trasparente, fatta eccezione di filamenti \"dentati\"\" all\'interno del corpo\"'),('ACGEAS7P9A',NULL,'Pesce verticale',NULL,'Questa specie di pesce Ã¨ nota per la sua abitudine nel rimanere fermo in posizione verticale, con la testa rivolta verso l\'alto, nonostante il movimento in acqua Ã¨ comune a tutti gli altri pesci.'),('AI4CEQC9PM',NULL,'Medusa quadri-tentacolo',NULL,'Questa medusa di piccole dimensioni presenta 4 sottili tentacoli e una campana trasparente con un anello fluorescente. Utilizza la propulsione causata dal movimento della campana per muoversi.'),('EAU993XFSA','Deepstaria enigmatica',NULL,NULL,'Queste meduse sono solite abitare profonditÃ  elevate. Possiedono una larga ma sottile campana trasparente, che puÃ² raggiungere anche i 2 metri di larghezza. Non possiedono tentacoli e vivono in solitudine.'),('EZH5BFUT5O','Lampocteis cruentiventer',NULL,'Ctenoforo dal ventre insanguinato','Questo ctenoforo presenta un colore rosso molto intenso e dei filamenti interni seghettati che vengono talvolta attraversati da particelle bio-luminose sconosciute. Al momento sono l\'unica specie conosciuta del loro genere.'),('JANN0QNIG4','Psychrolutes phrictus',NULL,'Blob sculpin','Questa specie di sculpin abita le profonditÃ  piÃ¹ oscure degli oceani. Presentano diverse spine, come tutte le altre specie di sculpin, ma presentano anche una corporatura piÃ¹ tozza.'),('KHRIIMYK0J','Marrus orthocana',NULL,'Medusa sifonofora cintura di fuoco','Questa specie di sifonoforo presenta un colore rosso/arancio intenso, essendo i sifonofori dei raggruppamenti di organismi, puÃ² assumere diverse forme, caratterizzate solitamente da filamenti intrecciati.'),('LBPHU6GZV0','Enypniastes eximia',NULL,'Danzatore spagnolo','Questa specie di cetriolo marino nuota a profonditÃ  elevate. Presenta una colorazione accesa, solitamente rosso, rosa o arancione.'),('ORYC2H5PF4','Albatrossia pectoralis',NULL,'Coda di ratto gigante','Questo pesce Ã¨ solito abitare il suolo marino. Possiede una corporatura tozza con una coda piÃ¹ sottile. Esemplari di questa specie possono crescere anche fino a 2 metri di lunghezza.'),('P4FPZBSA8O','Solmissus',NULL,'Medusa piatto da cena','Questa specie di medusa presenta numerosi e sottili tentacoli. La campana Ã¨ quasi completamente trasparente. Sia i tentacoli che la campana sono fluorescenti e di colore bianco/azzurro.'),('UDPDW13YB8','Taonius borealis',NULL,'Calamaro cacatua','Questa specie di calamaro presenta un mantello e pinne trasparenti, che permettono la visibilitÃ  dall\'esterno degli organi interni. I tentacoli sono corti e bianchi, ma rossi sulla punta. Gli occhi sono di colore rosso mattone.'),('VKFBS2ECGG','Periphyllopsis braueri',NULL,NULL,'Queste meduse presentano una campana spessa e di colore grigio/viola. I tentacoli sono molto sottili e genericamente di colore bianco. La campana presenta inoltre delle appendici che si muovono come i petali di un fiore, chiudendosi concentricamente per spingersi in avanti.'),('VL5L84606R',NULL,'Gambero pesante',NULL,'Questa specie di gambero utilizza una dura corazza per proteggersi; questo comporta un maggiore peso, che non gli permette di nuotare come altre specie di gamberetti. Saranno necessari ulteriori studi.'),('WOCOAYY52M','Pycnogonid',NULL,'Ragno marino','Questi artropodi sono stati osservati a profonditÃ  elevate, gli esemplari possono essere di colore diverso e tutti posseggono otto zampe sottili, come i ragni comuni, e un torso piccolo.'),('WOXO3HBSWG','Hexanchus griseus',NULL,'Squalo vacca','Questo squalo presenta 6 paia di branchie e un muso schiacciato. Possono crescere fino a 6 metri di lunghezza.');
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
INSERT INTO `paese` VALUES ('Alaska'),('Giappone'),('Messico'),('Papua Nuova Guinea');
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
-- Table structure for table `prova`
--

DROP TABLE IF EXISTS `prova`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prova` (
  `foto` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prova`
--

LOCK TABLES `prova` WRITE;
/*!40000 ALTER TABLE `prova` DISABLE KEYS */;
INSERT INTO `prova` VALUES (_binary 'ÿ\Øÿ\à\0JFIF\0\0x\0x\0\0ÿ\Û\0C\0\n\n\n\r\rÿ\Û\0C		\r\rÿÀ\0^S\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñð$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rðbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0øŸoµ9VŸJ}¹ñ\×¶¥¶ºž\Æ_6\ÞW†\\ÁÁ\ê3M\ÛHV‘6Y‹1,ORz\Òmö©i@ W!\Û\íF\ßjŸmh\Ó\éF\ßj›mh\r¾\Ô\å^j]´„b\r\ÛMe\éO¥\Æh\íö§*óÒ¤\ÛK¶€/x~\Ö;R\Ýe»Ý“\ï]Î­u\Ë,{BÆ¼.\0®O˜Z\Î$\'¥h\Üj«*¬G­0¹uY\Ó5P­ZšA\'J‡m0¹\ÓF\ÓRm¤\ÛNÀ3i£i§\í£m6š]¦Ÿj\\ûS_˜\Òm©JóÒ“oµ+mjM¾\Ômö¢À7i§‰dX58V\á±K³Þƒš,E\Ì\ï\ì»|“\åòzš’;8¡9T\0ú\â­m£m;\ßj6ûT»h\ÛE†E·Ú¾\Õ0Z6Ò°\íö§*üÃŠ“oµh°«N\Û\ïF\ßz6ûÔ“q)6Ó¶û\ÑÇ­q›h\ÛO\ÛF\Ú\ä~]]M\åû\Ñ\åû\ÑaÜƒË£eO\åû\ÓJQb\îE¶´ý´m \Ê\Òmö©JÑ¶®Ä‘mö£oµK¶´X¶ûQ·Ú¥\ÛWô\èl\Ú\Þñ®„ŠŸ¹QÝ³E„e\íö£oµXòý\è1ŸZV\Êû}¨\Û\íR\ì4l4\ì2-¾Ô¡jM´m¥\Ê6Ñ¶Ÿ¶µ< 3miûh\ÛG(\Ó¶´ý´m ¡›h\ÛO\ÛF\Ú\0f\Ú6Ô»!Z\ä{h§\í¢€oµ*j~\Ú6\Õ‰·Ú‚¾\Õ&\Ú6\Ð2/.ž\Õ.\Ú6\Ð\\Q\Å;mh\Ä\Û\íF\ßj“mh(oµ#/µK¶´ƒoµ9WÚ¤\ÛK¶€#\Û\íJÚ·Þ—m\æŠ6Ó¶Ñ¶‰¶“m;mh»h\ÛN\ÛF\Ú`&\ßj6ûSöûÑ¶˜\Û\íF\ßj\\{Ñz`0¯4›MI·Þ´i£&\Ú6\Ð+¢¶´EEK¶´.\Ú6\ÐTPTúS\Õiv\ÐQ\ÓB­K¶€¾ô\n\ìoµ}ªM´m©±\"+\íI·Ú¥+I¶\Æ\íö£oµIz6û\Ð;	·Ú¾\Ô\ì{Ñzaa»}©¥y\éSm¦²\ÐQ\ßj6ûT…y£m #\Å%K¶µd‘QR\í£m\0EKRm£m\074S¶Ð«\Í\0%ý´m ›‘\ÏJJ™–“mQR\í£m\0EJ«ž\Õ&\ÚUZ\0f\ßj6ûT›h\ÛPQ\ßj6ûT›iv\Ð{}¨\Û\íSm¤+NÀ@Wž”T»h¤E\ÆÎ’žÑœš<¿z±ŠF\ÚpP¶´\ê(ÈS@\ê)Jœž(\nh\í´m¥\Ú(\Ú(0›h\ÛK´QŠ˜M´m§RP;‰¶´\êJmi\ÔPiq»h\ÛN¢€¸»i\nÓ¨ .G¶´\ê(\ÛF\Úuaq»h\ÛN¢€¸\Ê*\ÄÑ®#\Úz®N*?/\ëA:‘\ÑJF\r%¸QEÂŠ( .9Fi\Ûi‹N ¤\ÅH\ÚKˆbQ–’EG©\'\0V§Œ<+©x\\M+U¶kk‡ŒJ›†)ªÿ\0\Ã]<j_4(\ÙC\"\\¬§?\ìk\ì\ïø(‚\ì<Eð\Â^;³´H\ï\ì™-g™’­Àò®yÖŒ$¢ú0£)Á\Í\í4m4Š\ß-.k]õ9dN)»MI\ÔQA${M*­9¨Z\r.h\Úih .\'4`Ó¨«-&\Ú{RPŒRSš›A7\n(¢€¸QK‚iBœ\Ð\r†”)§Q@\r\Úh\Úi\ÔP\"6\ëIJ\ÝM%\n)vŸJw—\ï@\\jŒÓ¶šU]´´M¦´\ê*l]\Æ\í£i§P´Xw\r¦©\Å>‘ºR‘\í4S¨ \Ì\æ\'ü)6\Ò\ÑAaE&\ê7UˆZ)h ¤\ÛN¢•†%QH€ ¯ ¥®‹\Ãþ¸\×`–De#,\Ý\èU”m•R²3Á\ÜGL/5VŒe\àSz\Ô\ìµ>cE\Ú6\Ò\ÑPX›h\ÛKE\0&\Ú6\Ò\Ñ@	¶´´PE-`%´m 4d\ÑE\00õ¢”õ¤§bŠ(¢ÀQEW­;¦­=z\Ò)…ðLþ\Ñø…FV8]¾‡ŒW\Øÿ\0¼Cý¥û>jsˆHž\ÌE|\Éû.Xù\Þ$¿˜º›zWÑŸ\Â\\x>ùnQp~•òx\êòŽ%$~•aaS7#óþšGJ“Ô‘ÿ\0«\éÐ‘úÓ—“_KI\Þø:±´\Ú\rµ QŽ”m¥­leb&ZEZ{\ÔbŠmih¢ÀQE0\ZÔ”æ¤ µ%+RS%…QE„\Òx®m\"\â\×Im3‰V\ßm\Âÿ\0µŸ\ç\\\Ý*\ç\"€$¢Š)(¢Š\0‰ºšzt\éMo¼iW=1Le\Û==\ïVB›@A“¸\â«m±V-®„ºô&«\ç4]¢‚£Ò€\Ù\ç¹ö \ãSÿ\0\n6ûQb\ÆQO\Û\íF\ßj,qHqŠJ+1\ãÖŠ( €\ÛF\ÚR\Û{Ry‚™CSE­v$‘~è¥¤_º)i\áEPEUY\Ôi~)—M\Ó|„\\n\êk—§n\'‚€-\Ý\\µÔ…AM\Þ)i_z5IL=jn5¸Ý´m§QRj7mi\ÔPvÑ¶E\07m.\ÚZ)€QED\Ü)v\ÒS·PEPIKIUb.R\àúQƒœP£\å¥\Ú=)h©­€3ŠEå¸§ÕM}cZ²°‹&K‰•\çL¨\ïc\é\ÙoCòt\é\îJ•i	\ÎGµzß\íü¿\ê<ÿ\0\ËþUð_\Ã\ãJ·»´QÍ¸ô®\â5°>Ô¸ÿ\0–\rÊ¾CIût\Ùú^[5+G\çjŒ!ÿ\0xÿ\03ON\ê|ŠI\Ñ\Èýi­}=\î#ó\ìGñX\ê(¢·\å9®0‚Ni6Ó¨ .7miÔ”\Ä\Û\ïF\ßzuv1­7&¤a‘Š¥0»\nP¹Ú±j\â6ÝŒû\Zvt¢¬\Ü2\ÈÅ‚\ã=ª,JAqžY¥sO¢\\n\á\ëF\á\ëQ\ÑUan´nµX=M”Qa\Ü:\ÑEX.J¿tR\Ò/\Ýµ\"\'ÖŒ·­´8QEL\Ös­ªÜ˜È›h~\Ä\Ó¶\ÃF\ÓO¡ºT–C°\ÑRQRer&ù©»ih­,;‰¶´´SŽbŒŠmX.;\"ŒŠmX.QE2BŠ( Ÿze9[€’˜\Ô\íÔŒ\Ãmf·:(¢µQE\0QE\0QE\0¹4d\ÒQH\ÑH´µ%Q@§\'Þ¦\ÑTAa@\ÛÓšoz¾Z)\0QE€C^¥û-ø}|Qñ»H³‘C*«\É\È\Ï!k\ËM}#ÿ\0ÿ\0\Ñ\×Røµ©ß”5µ«\'ør1\Çù\ïZ\Ãk•Ï¡¼#\Zi>1\Ö\íq¹Ž\Ü\Ó~#‰.49 Œœ2‘R\\±ø•¸<š\ß\Ö4!¨Û°\É\ät§…ŒŸ5¡¥\å¥\Ësó[^µ:µ\Ä cQ\Ö|]\Ò\ßCø‰«Zº\íý\é!}«”QÞˆ\Ó\ä\Ðñ*ËšWŠ(¢\ÆBŠJu¹@m\êm &\ê7TtdÓ² y`8¦1\É\Í• ô`)”P»Ç­&ñQÒŽ´X	i\îšM\ÃÖ‚\Ãš@GEU\0QE\0QE\0S”dóM§G÷©*Š]¢‘ih6J6JZ)Œ*f¼šKT·iÀ„²\Ç\Ø\Ô\Ô4PH\Ý)i\Z³+˜J(¢¤‚\Z(¢¶\0¢Š(\0¢Š(\0¢Š\r\0&\ê\\\Óvšp Š( –’Š\0v\êUù³L§\ÇÞ¦À_¥7¥KHË¸Qp\"¢–’¨\Ú}(\Ú}*Z*n[O¥O¥KE\Z*j(¸­-:–‚\ÆQN¢QR\í”m•W Hþ\í:’–¤Š(4\0†¾\Íÿ\0‚n\è{¿\á$\ÕJœ³ù`\×\ÆS0HÙE\æ¿@¿\àºKYü)½º+ÿ\0Aüjß»\\OCñ\îŠ,ü\\gQÌ•­c\0”×Š\ÜñÖ‹ö«¥›Š­¡\Øù— 5\éÒ©d›\ìL›GÂŸ¶\'ƒIñ´Z’\ÆV9¸\'\à	Œs_}~\Û\Þ7)Zœ6+\à8\Î\áø\â°v’\æ]D¥q\íM§½2¹\ìXQE€)´\êm #\ÛF\ßzZU\ëC O/Þ/ÞŸEf4QEPòý\èòý\éô÷MHQE@QE\0QE\0QE\0 ‘Ò’Š\0™Od\Ò/\Ýµ\0!a\ÜÒ«zTm÷:?»LdÑš( R5(¤jŠ(©\Z(¢¶\0¢Š(\0¢Š(\0¢Š(\0¢Š(ñD\Ó6\Õ\ä\Ñ$M\Ã\ZXf0¾\áÖ‰¦36\ãÖ€#¢Š(\0§\ÇÞ™O½ ET\\:÷Ý§Ò¥¢Ÿ0	¸zÑ¸z\ÔTUX	wZ7ZŠŠ,\ÔT[­­+%-5zS©”´”\0´QEY³¶[†!Ž*µI†>A\Å4\×v\ënøS‘U\È\Í>INM2¨/›²{ŒW\ê_\ìS /\à^Š6mi2\ç\ß5ùku™cˆu‘\ÕG\âq_¯ÿ\0³Þš¾øK¢Z‘.\'ò¨­ü\'cH\îuþ%\Òü\è÷cµr\ÚU³[_\Ø5\èw2-õ¡ db¹\Õa¾u8<\ÖXz‘Å•R7\Îk\ã÷†S\Ä\Þ¸V‹\î\È#\í_”> \Ód\Ðu\ë\Í>E\Ù\å\È\ÛA\ã5ûA¬\éÉ«ørxÀ\Éò\ëò\ßö°ð4¾ñÛ’<C3[\n\è\ÃT\æ‡\'c…K–GŒý\áœæ’”\0¼”µ\Ð\Ñ\Óq´S¨¨hwM§R5+\Èè¢Š’E\Ý@jJU\ëJÀ2’•¾ñ¤©þgµgµ2Š\0(¢Š`QE\0QE\0QE\0QE\0J¿tR\Ò/\Ýµ\0F\ßxÓ£û´\ÖûÆÝª\è¨¢Š½)\Z“4Œ\Ø\ë@E%¬TQEhEPEPEPEPEPEPJ:ŠJZ\0“4f›Eb³Fi´S”QEjEPNU\Ýô¥úÓ©\\–’–¤°¤¥¤ ¢Š( (Q@¢\ZZ°\Ï\å\Íjø\Î\Ù\ã?øð¯×Ÿ…ú§öŸ‚t‘´H-S ô\'¿ \îhó’#\ãÂ¿]þ_[\ê_tk„e?¸A\ÇÒ‰?r\å\Äô\Ý%w\éÌ¤s\\N¢\Ïªy\Ç5\Õi7\ÃF~\é¬o\Û¾5\ÅNñ¨\Ó\ên\ì\ât>“\íŒ¤dc‘_,~Ø¿¿·¼?©¡bQ\ZdeRpqšú‹Â®c8\Ç¨üOð\êk\Z4™V0ö\ÅM:ž\Ïg³<j›\è~)\Ú1\ÃF\ÇçŠ·\Ô\Z±^ûB|<o‡Ÿn\Ìq4v7Œd—9\æ¼õX05\ì7}NºrºET3A”KHÔ€ŽŠ(¨\0¥^´”«Ö‡°=i(¢¤Š( Š( Š( Š( Š2(\Í\0QE\0;qõ£qõ¦\ÑH	m\ÝeiF\ä$z\ÓY€f\Û÷s\Æi”P·\Z7Zm\0»­\ï/Þ/Þ€¿tQMßŽ1E+\0\Ê(¢¨Š( Š( Š( Š( Šr©v\nI8À¥’6ŠBŒa\Ô\Z\0eQ@-%*ý\á@¢ŸEg`E>Š,4QEhEP\ÔT[­­M€’–’¢‘W’¢Œ\naqh¤oºj=\ÇÖ‚Ih¢Š@»©( n£óauö¯\Ðo\Ø\ß\ÆS]x3L´y\"©\\\éŠüýõõ\ì[\âq\ZKbÇ˜%ÀúWe8óF\ÆU•\Ï\Ðh\íJÊ’(\á†j¶¹lÉ±\Ï5wGº:llyâ¨Fo-ø\ê+\Æ\æ”ggÐ•T©¢\Êa™X\n\é\ç·]GNxÛÃ½s\Z|L\Ó\Ø\×Ob\Åb\0\×5}Ô–\ç4Ÿ1ò7\í…ð#þ_\ÜOiûuªù±\í\äs\ç_›v®ð\Í%´\Ãd\Ñ1GS\Ô\Å~\çkš,Z”2#®Uñ¯\ËO\ÛK\à+ü-ñ¿ü$Zt$iZƒŸ0(\á\\ó^\Æº«=\ÅJN.Çƒ©¥¨`H¹%t3\Ñ\nB)h©2¤RT÷MGR@¢Z@2Š(©\0¢Š(\0¢Š(\0¢Š(\0 \ÑE\06Š( QE\0QK@ô ¢—¥%\0QE\0I¸zÑ¸z\ÔtR°\nzš)(¦¶\Z<³O_º)jnDcŠJs}\ãM¦ES\0¢Š(\0¢Š(ð\Ì\ÐJ’/\ÞS‘N¹¸{©Œ÷EE\0QA \ÝJ§šm*ý\ê\0›põ£põ¨¨¥`%\Ü=h\Ü=j*(°QLŠ( Š( 	¨¨·Z7Z›-QH·\Ý5H\ßt\ÔuHŠ(¦\ÔQE@\r\ï^\Åû.\ë\ÃFø†m‹\íK”Àÿ\0z¼{{EÖ¦ð\æ³g¨Á!‰¢•I+\éš\ë£-lg5t~\Éx7I„õ;0k~5ùˆ\ã>•\äþ$i—\Þ\r°»–\ì\"´A™‰ö©<IñûA\Ñ\ïZ+F’öoök†¥	Î£\åG?³v=~p²n+[ø\Ú|\ÑuûQ^\Çú.„ò`õoJ\×ð\ß\íe¥\\­g%”™Án\Õ\ËW]­‹Tü¡¤*My—\Ç?„V<¤\\Ä¯#¡1¶9V\ÇZ\ë¼-\ã\Ý\Æ«6›}û¿ƒ#\"·;cŠó\ã*˜y\ë£DJŸ)øU\â?\ßx\ÅW\Ú¤öò\Æ7(<\Z†¾ýý¿¿gñ›ÿ\0	Ž\n\Å}fl¼+óö\Îa$xr7/\r\ÏC_KNJ¬\âtS|\Ú\ÑNÛŽô„{\Ðka­÷MGOo»L©\nv0¦‘z\ÐTj\ÑRyb˜z\Ò(¢Š`QE\0QE\0QE\06Š( \Üh\Ï”Pñ¥;\Ë\ÐRC\Óñ©Yi \êi6J{RR&\á©)\Í÷6˜QLŠ( 	GAKE\0F\ßx\Ói\Í÷6¨Š(¦EPEPEPEPŠ@v\Ò\Òp\Ä{\Ð\ÑWµ-B;\ï(Gk°UÁ.7Z£@Q@R\ÐQE\0QE\0QE5\Ä=iõ\05¾\é¨\êjc/zhQO\ÙF\Êw*Á\æ{P$ö£e(Z-p°½ko\Â\Þ¹ñŽ©¬@ˆU•½eZ[=\å\ÂBƒ,\Ç¾ø{¡C\á½:¿i‘s3Ž¤\æ®:Ó‡1\Ý\è\ë\'‡´}&\ÒVû<`\Ç\Õü:Ó£½\Ö\í*s\Éa\\\î“\ÜL\ÊÇŠë¬¯\ÓDˆø~Þµ¼j[s­PG³\Üø_Iû(\Ä1Ž:\â¸/x_M’\'f¶ ®Z÷\âµî–¹\Î\åšO\Æk]JA\ÌB=ü5¤k.¦\ë\nf\Û\ß]øVü\\i2YJ‡± j÷¯…?´?öœÉ¦\ë\çÊ”ü¢s\Ð×‹\ë6P_7o’\Ís\ék$w”©\àŠš´\é\â¤p\ÖÃ´¸¼m¦Zø«\Ã3Ú¶\Ù\à™¸n+ó+\Ç±³\ÇñS•µ!e¥;ù‘ÂFM}¥ðk\âu\Ä\Ñÿ\0cj-¼‘ˆÙq\ßd6þ#»9Á$c\éX\á(:.T¥ª\Ý\á\ÊÏ™G\ì»\á\Èb\Ãj·E\Ç÷[Š\à|uð:\ãÂ¶­u¦\Ü=ü\n~eo¼­{Þ¡x\Ç88¬«‰\Ìñ²I\Ê0Áº§M-\ì|–§¨<M\"»ßŠþ_\ê	woþ¢ç“\Ð\×\0\Õ\Ç-,V;qŠu3iô¥ßŽ1Y>¢o¼i\Þgµ2š\0¢Š)€QE\0QE\0QE\0\Ú)\ÔPh¢Š\0š©‹\Z­\Æ*Vn)\03qQù†‡=)´\0¤\çšJ(¦EPEPž`£\Ì¬±\É\Í%S\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0£Q@R5\0©sM¥Z\0ZV\è>””´\0\ÊU¥\ÛJ«ž†€ŠqR)´\0QE\0øû\Ó\é‘÷§Ô°\'Ý¨\êI>\í2š-QO” ¢œRn¦´¸øW§­\Ýô÷¡¼±…\È\ï^Ã¥¶Ë€¹®\à\Üj\Ú=\ã•ß€q\Íw:j¾«;h¤w\ÞŒ\É;¾:\noˆ5˜l_.À°þ\ÖÇ„b	§N\ç®9\Íx×µ;VuW8REaY\Ú:\Í¥-K>,ñŒ\×K¶\Ù\0\Åa\é\Þ »Ü­$(t5œÓ†9/\Å>[Ø’.9¯+\Ú\Êö=x\Â6=·Àþ2mJ\Ð\ÚNÉ½G\0u«Wúò\Û\\r8\ã>\Õþ(•X…\Ï5\Öx‡Pf¼e\r\ÆkÓ¥Q\Øó«\ÓGwŒD7OlvL‡ Ž+o_\×d\×\ãŠ\âf.\åF\\×‰­ûE\Î\ê\îô]au\r9-\ÔüÞµ\íQ•\â|õX¨½‚\×\Âw:¶™ƒp¬¿x#P\Ð!Y¥‰‚\äW\Ðÿ\0\nõ\Í\Ã\Ãñ[\ÝD¯:ó’*ï¼U¡jVMc-ª:Fp+)\ÊN\\¼ºw1±ñ4Ÿ\íÿ\0Ý®›n¦P{\àW\ÎyÝ‚k\ëŸX\ÚGwª[Z¦ do\ÔW\ÉwySÈ˜\Æ\Ö+Æ¸§¹œ‚¢o¼jZ‰¾ñ¬‘˜”QEPQ@Q@Q@Q@Q@Ô”­H\08R–\'­%()¯Úœ¿tSd\íR€eQTEPEPEPEPEPE!4n ¢Š(\0¢Š(\0¢Š(\0¢Š(\0¡¨¢€J´”/Z\0u;)=é´¹8\Å\0*«¹Uw;^Ž¿õ[\n.¯5·\ÊË»\0W\á}B-/\\µ¸š1,h\Ù*\Ý+\é{\ï\ÚNºðK\é\âx™†\Ü8\â€>U—>c1ƒŒS+C^ºK\íJY\ã@ˆ\ç<Vy4\0QIº@½>™Fh\ådû´\ÊuXcè¢“\"¨¡\Z’ŠrŠ@z\ïÁ\é€\Ð\îc\È\Ý\æk\Ðôø\Â\ÌWŸü\r\Ðd\ÕôýbH&Fž-¿\è\ß\Æ\Ã\ÔW¥G\Ú6\É\"h\Üqµ\Æ\rY\ÙKC¹ð\ÌÛ¬.\"\Î®x\'\Ä[y´ý^m\Ã1¯K±ñ÷ö½®¦i·z¥\Ã\äùv‰¹¾˜®o\â,‰®´¦K9l\ï*\ÑL0ÀŽ¹…k5cÔ§.]O\':¯L\æ™ý¨d\\f¢ºÒ®m\ØïŒŽx\â‹\âi¹Pzó½šGrªÎ¯\áú5Ö´$\ÎŽk§\Ô\ï\Ã]?Ížz\ÔðØ ‚+Ÿ°y\ÌKü#¹…u?ü\à\ï\ëÖøW\ÄS\ëQ4\nf36\ïŸþµ\Õ	Y\ØÊ¤œ–§=\àU85\ìÿ\0\n­,¿³¢º¹O›¨\Íx\í¾‘ö¹‹mŒ}1^ƒc¯C¦\é\ëodL®\nµ\ìÐ–‡U6\Î\ïT\Õ\çµÔ¤6s“°\Ì\ë^.½\Æ}Î«Õª¦ý¥ªj	öµ6\Ð7Vj\ìüU§\è¾\Õr¬·ka³\ß¼™Ÿ)\äwšüw\æw0A\æ¾y\× òuK\×\ç5Þ¦¶m\ìäœ\î9ÀjRy—6s“^|÷2‘B£n´ö¨\Ï\Þ5‹9ÂŠ( ¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢“u¨h¢Š\0”t¦\ÉÚ3ÚšÍº¤¢“uª€Z(¢€\n(¢€¥%¹¤\Ý\íJ\ãŠ\\w¤ AES­ÖŠ]´m ^”QE\0QE\0QE\0QE\0¢›J´\0m£m-\0QE\0INjm\0:‘©h#4\0\Úrö¤\ÛKM\0\ìŠ2)´´ÀuQ@\Ç7Jm9ºSi2‚M©!V’@ª7Úª1l—áŸ\îþø\Ê\ÓW·Ü–h\Ï!—>•÷ÿ\0ƒôþ\Ñ\Öð\Ü\é·\Ð\Ø\ê-\Ü€;½1_Ÿ\èûa“EuŸ|[ªü?Ö’÷N¸{wŽ@ûPðphœ%gcH\ÔI\Øú7\Æ^ñ¿\ìƒñ*\Ë\Äv±®©¤1Çš\É\Â\çŽk\ÇKs\â{\Ù<O­\ØNš}ðó\Í\åœª‚z\àW\Ôøõ\à\ï\ÚÀ·^\Zñ+\Ã¥$F&\0±=ó^{\àÏ‰Z¯\ì©\âð—Žô\æ\Õ|#\æ\ÛV	\"c\Æ\ï¥x•%V7º÷¿3Õ£(\Ïf|\Õ&ƒ\á\ÍZOô/-¢©{	¢ºðÇ„t[:óÄ³jNI$\×\é‹\á‚\ßaMWKƒG\ÔZ_œ›y¾Oªæº­#\ào€|:\æ\â\ßA³R>o2N@\Åy¯(\é$\ÏR0V\Üü\çøkðg\Æ_\ìnn´]*m3B›»\å(\Î\0\Ï\é^Y¥ø~\æ\×Y»‚gb\Ð\ÊP\î\Ïc_~~\Ô_µ\ç„>øz\rxf\ê\Ö÷]¹£\ÙbF\ËpF2q_\0YøºGŽI$m÷2’\ÌÞ¤õ¯K\n\ç[V¬sV©lÎŽø2ùV°ž\\\à×¶ø\áø±\Óã»†–]¹;«\Ã<+×—‰q!\ÜA\Í}\à¯-»\Çk*\æ2\0¯¥…7Ýœ”\ä¦\ìrž(³Ô®õh\íá…ƒ³mÚ¢\âÏ†:Ýƒï®š\0\å¸5ô_ÃŸ\Ø\ë\Þ*·¹,¤gp\ï[?µïŽ´_†ux\Ð@º„Ö…\"CŒ\äŒf¸*c9**Ij\Î\Ùa\×-\Ï\Ê}Jü\Ã4Ð‘†V \Ö\Òn\'Ö’mBKû©\î\\`\È\åñõ¨_76§‰Ykd#\nˆŒ1©ª6ûÔ™\Æ\Æ\ÑEQE\0QE\0dQZZmåµ½¼\É<+0!K”›E-%\0QE\06Š( QE\0QE\0\Ú)vÑ¶€Q@\âŠ\0(¢Š\0k}\ãET;\Ìö£µ6Ša\ÔQEY!EPE¸>”\0”QE\0QE\0QE\06•i(^´\0\ê(¢€\n(¢€\n(¢€\n(¢€\n(¥\Çª@%-%-\0:ŠLŠ2(h¤\Í-!‚òk\Ñ>ø4\ê>«tŸ¹PV0Ã©®[Á\Zx‚b¥­ÁÌ„zW¼k\Ûhzz\ÙÚª¤q¨P\èQ§\Ô\ÎR8]b\Ãl\Çh©4\Í/\Î\Ã½ Ø§ˆo\Z6lzš\×ñN“Ž‘¤GW\\©\èaÍ©\ç:”—º~ —:t\ïm<mñœWµx[ö¤\Õ\'\Ðbðÿ\0Št¨|CbGûPÝ¹H\é\Íy}¿—\ç•CCP]F­1x\Ô ®J˜U3hUp\Ø\íµéº•ÄšÇ‚$Ô¼,\Ìl³¹(¨Þ˜ô¯6ñg‰þ\'H£O¼øƒ«\Íf¤‘\Ý‘Œ`‘ZCX\Ômb1Áu$hF\n©\â²\Ìfg\Ë\ä¹=\Ís<M\Ö&G#k¡My’Hó\ÊNZI	f?‰®§C±i&]\çŠÑ‡O½*\Äq5\Î0=k®ŽS\èL«6v:e\ÌV0…ŒóŠÑµñG2°“\ry\Ûj\Ø\È\r‚=*\Õd\ÏEu\Ùl(Vqw>\Ñø3ñ^\Ú\Ò\ê\Þ#.Ë’6\ç=\r|\Ùûx|P¸ño\ÄKm8N\Ï1\ã5\Èh:ýÍ–©k6ö\ÂÊ¤\àŸZÁý X\êž1Šÿ\0Iù½kŠ¥_-N·Œœ—-\Ï<WÊŠF&˜«·¡æ’¼ù#Í±Û­&sIEAESQE\0QE\0QE\0QE\0QE\0\Ú(¢€E&\ê7P\ÑIº\Ô\0´QE\0QE\0QE\06Š(\ëPXQR–•\Åq”QEhHQE\0«\ÉÇ¯¿®kZ]÷†ô+K·\Ô,\ãu¼¸?vv,J‘ô\Ï\Ò\Ð(¡º\Ñ@^”P½( ·Z(n´PBõ¢…\ë@¢Š(\0È¢›J½hh¢Š\0(¢—Ò€œ>\í/—\ïK«B`3i£EP¢Š(GZs©\ïÚšµ«\á!õ\ïiöj2­(-ô¤U\Ø\Ëð¿\Ã\é\á_\nµ\ì\ê«uu\È\Ý\×‹­jutù=\ë¯ñ¶¡´V‘¢%\ÆÒ¼\à1š\ãŽI=\ë×¦¬¬Œ$tº\ÒY¡•\Æ4ýCR’ð#³ûªµ\Õ\Ò\ÚÁ\Z«6;œ¾sZó[[šQ\ÆXqJb=\éör¼ó\ÅLv·¥3\å‡Ó­\"\Â‡Õ©– _–Eô f‚C\å[ô§}›ûb\Æx\á™p’K€a\Ú\r7\ÃÚ‡övµŸõdá‡­\Ü\â\ZCŽÃ¯(ó\Õ|Pð¹ÐµŸµB»mnõúš\äƒ(\çšLgU\á{Xõ)\ng/ z\Öw\ÆsvNÀ\åF\ßjƒEÔ›L¾Žu8\ny\ÅzÅ\n§‰~n\ÑI\Ì\ÛEG-\ÑW>i1\ãñ¤\Úi¶³	£\Ü\'üªZò*-M\â\Æ\í>”m>•%\ÍrˆŠ‘Ö’¤“\î\ÔtÀ(¢Š`QE\0QE\0QE\0#RdÒµ%\0QE\0QE\0QE\0:Š( Š( yfŠ’Š›^œŸz›J­´\Ò(’ŠnñKº•™#h¢Š\ÐŠ( ·Z(n´PEP—¥/J(­ÖŠ­\0P(¢€‘E6•h6šP)h Š( ¤\î\Ôtõ`4€}5‡­5˜b’\Ü\"ŒŠm Q@^õ\éÿ\04¸ä½¿\Ô\äÿ\0–)µ	õ¯.Ý€{W¹|6´:?\Ãó)d¸,ù\ïŠ\ê£±I\Ù<Mxood$\çœV^›m¾\ã\'¢óKw&\æ\rœ\î<\Õ\Û(\ÄP3“Ö½8«Ì¡©HZc\ÏN*ž\ãR\Ý>ù	**\0»\Ë*ŽqW#¾ùFd+ô©–CÒ\ì”—Y¨~\Ñ\É9\æª¨±š.K4–\è\ãš|R*¿£f²–BÇ­X\Ï\0\Z`v>5¸þ\Üð\Ü.Í¹¢ûU‡¾ð^±\á\rb]cS¸¶\Ö6\â\ÍAÂ†\Õf—~*“\Æ+‘Ž)&¸KxQœ±\áTg4˜\ÇAn°Hc\Ü\\Çœ\×ÒŸ?ø[ðýÀó ;Tûƒ_6*›y\ÙYYnµ\íß³þ´,uæ‰Ž©N:òÆ¡¦¾‡\âMSNu*m\æd\n}4`\×yû@i#Eø¹ª•û—$J?\Z\à3^f!Y³x’\ÑQn>´õ5\ç\Ø\Ðs0#Še!jL\Ó\ÔSsFi€\ìŠ2)´P²(È¦\Ñ@È£p¦\Ô×–sX\Ì#™\n1P\Ã>†€!j(¢€\n(¢€\n)vÑ¶€Š( QE\0QE\0\ï0\ÑM¢\r¢Š)€Qš( Š( QE\0\Ö\ëE\rÖŠ\0(¢Š\0rô¢…\éE\0#RRµ%\0QE\0«IJ´\0´QE\0QE\0QE\0QE\0QEP-%/j`6EÜ¸÷¯ ¯\"\Z?…¬,\Ðò¨9÷×†\è6S\×4\ëa÷^e{W·xªm\Ì#\'²ÿ\0*\ïÃ­.e7c“™w­h\ßo¦¢ÿ\09¨lmÌ—ƒžiþ ùd\ÜW `c\Z)Xb’  §+c­GŠu\0?\Ìô¦hÁô¢‘,|\Õ<z \èjdûÂ•Æ“þ%ò}+/G\Õd\Ñu¯!ÿ\0[\Ê\ÕÙ›mƒŽø¬]¾´›gP¾}JòK‰\0#8õ5\Ûü1\ÔþÁ­@çŽƒ5\Â*ô­½CÑ•89\ÍiOp&ý©,|\ÏY\êqò&‹n\êòýKMZù\"šaol£t²Ÿ\á_ozõÿ\0Ž-ý¡\à].\ä\Ï\ÛKw\Æ+\Å\ío\Z\Ú\'U\ã\Ì?J\á\Ä|L\Ò(5x­/%Š|ø”\ád\Æ3UZž\Ô\Ó^y°\Ú)U~aZR_[bµªÛ¯\ÚK†ó±\ÈµH”QE\0QE\0QE\0=\íô\×ò¬“9vU3\è*\n(\0¢Š(\0¢Š(\ÔQE\06Š( QE\0QE\0QE\0\Ú)vÑ¶€Š( Š]´m ¢Š(­ÖŠ­\0QE\0\å\éEÒŠ\0F¤¥jJ\0uQ@#R\Ò5\0%*\ÒQ@¢›R\Ç\ê\0ecì¥½ªk\r\Z\ëT¼[[HZy\ØGZ\0£E]\Ôô[\íEK\ëY-Y³´H1œU* \n(¢€\n(¥¦ið–\Ånüa°\ÊÀ\'ò®\Û_œ\É~G£b²~	Ú¬z~»~\È2¤DŽzdŠ±4†\â\è’rwW¯‡¢s\Ô\Ü\Øð\å˜k¢Çœ\Ö¹)k\ÙûU\Õikö[I\æ<qÒ¸\ÝBO:v>¦º+QJ=(\Ú}* ©@÷¡W\í´€J¾õJx¨±\Éú\Ò­K~ó>—£\Ý\ëÚµ†dñ¤÷S¤!¥8Q¸\ã$\×}ñ\à†¯ðW\Åö\Ú^¡{okql&Ž\â\í\ÜVnJü½A#\Ï\ï$\Û\ëTÕ»þ»{\n‡i›\èÖ´l\Û\É Š¡XF\ÛZA\Ø\r¿7\Û>¾y)(5â¾•\ìž.m¿\re\Çy…x\Ú\×g©¬Ejm9©µÀ\ÍB†¢†\éPÀmQ@Q@Q@Q@Q@Q@¢“u¨(¢Š\0uQ@Q@¸4P1(£\"ŒŠ5º\ÑKŒÑ¶€Š( Šv\ÃIH7Z)x\Ü7t§M·\Ìù:S”QE\09zQBô¢€\n(¢€E;h¤\"€y’¦Ó£b­‘\Å\0Y¼¶H1ŽIª•q”È¹<û\ÕQ÷Ž)\0ø\ã\ÝW£µ\n£ ƒ\ån•¤­•\0*Œ*ö‹¬\\xwPK\Û96L¿‘ªuw \r\ïˆþ<ºø…ug=Í´v\íoOÝŒ}k‹hYzÖ…Cp>Z`R¢Šr®\ê G\ãŠ—Q\Íò\Æ\Üö¦µ`\Ïhø_¶øg5ÁM\Í\Ë>~ƒF\Ünº¶\ê\Ýðõ»\é\nô˜\åZMÏ­ci\È^\é8\ç5\î\Ñø)½N—T\"\ÓGÁ\à°\Ípòü\Í^ó\àŸ	\Ùx¹ã°»ˆJ[ž¿…cürø5ÿ\0\nõm\î-\Ç¨%XZç©ˆ9r³¾žu!\Ï QO\ØkW\Âzl\Z¦µmÜžL~výv\Î;Rhamñ+§ñ­OcšQqvfF\ÜQŠ–N\ÔÚ²\Ù}ª=µ>\Úf\ÚM\0\È\ÃyŠT\í`Àƒ\èkoV\×5-m\ã›R¼š\í£]‰\æ±lj¥cm\æ·#Þ–÷jœ\Å@¶‰5È±¶(šo/…5Q¥,sÖ¥:žjU=>µ^3V#\å\ÔU 5|bÁ~°=LÂ¼}~\è¯[ø…˜|l7\É\Ç\å^H¿tWg©´©´\æ¦\×4\n¥7J†h¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0u›¨\Ý@^´\êjÓªYHuQHd,)*IY—¥‹K@Q@¯\ÝÝ›œ¨ Ÿñ¥_º+s\Ã~¿ñW\Ú\"°S+Û§˜bPI#üŠ”<\êU°E%Mx²\Ãq$3#$‘6Â­\ÔT¥PE34£­\0:Š( Š(h\Ô”Q@\r¥ZJ(B+­¶/@K6ww@w§)Á\Í!\éH	Lu­YCu¬œÕ‹y¼¾ø \r|\ÔOüU\Þ/§\ëMkµ9\ãõ f\ÅA#î¥™²¹\\±\ëŒPiñ÷¦S£û\Ô0$¨.¿Ô¹©\êŽaqUO\â}\âû?‚|7\nŒ¢+c\êaxnÕ®\ïW¥t~:_+\Ã^P¸\Î1Ÿø\rgx%„wC#©¯¦¡,yõ7=áŽ´\Ú?\í!oõ{\Ôûšû7ö’ø[Ž>½Ýº\ËqK(\Ú;b¾5Š\Îu{eO\å_||ñ]¿¾­¬øw«}1_+BT\'\Z±\Ù[–IT¥\È\Ï\Éû‹Y´»\éc`\ÑÈ‡§¥F\Ò4¹‰$ú×³þ\Òÿ\0‚üsv‹\È\Ý\Év5\âø\æ½%Oižf2—³\Ù;S*Ri¸\ÍzHóÊ–\ÖÑ®\08õ«¶\Z\\—M’6¯©­	ü6\r¨rô\ìK*\Ý\ì-¶)ùëž¸º\ÜI\ïV¯%y˜±5™\'SS\Ô\Æbz\Óc_˜ŠZ’5\ç5“,jj{u\Ý2¯½®\Õ\Üx§Ø©’\é@\êO+7Å‰¾‡¥\Úô\Ï\ÍúW–W¤|l˜.¥¦ÙŽ±[†?y½qVø\á°Ö¤¥4•\Ê\ÙaH\Ô5%HQ@Q@Q@Q@Q@\ÝÔ»¨h¢Š\0(¢Š\0(¢Š\0Tû\Õ%FŸz¤©e!\ÔSh¤1e\ê*\Zšn\0dz\Ô5D\n´´ªqO\Ú=(:*M£Ò£Ò‹€ÌŸZ\ßðwŽ5/j\Ý\é’\æ’33\Çù&¹úm0\'¿¾›S¼š\ê\áƒM3—b95\\ô¥¢€J:Ó¶š1@P(\0¡z\Ò\í¥\Å\0QE\0&\Ú6\Ò\Ñ@Š(´ªi( d\ÊØ§+u¦R­AD‡\ægÖ¥¨Þ¨Dt´”S$]\ÇÖ›\'1·zZµ¦ÙµýýµºŒ™eUÇ¯#5­%y¤\'±ô¯Žld›\Â~‘S*-c\Ë~ƒ\á›Y#Ÿiù}«Ðµ\ÍJ\ÛOðþ•aq´²Ä©ƒ\ì*¥¼v\ë£\Ë$q¨\Ü:_UF6<ºŒMG¹\ÆÌ±\ï_Q~\Ê~&]\Ä\é—BÝŒ¨\Ï…|\ÇðûT³}E­\ä\á¹\ë^\Ïð\Òú?\Ç\Ú{´ž\\~j\àþ5\åfôZL÷²šN\Ç}ûm|7MSC^?z£lŸ…~|\Éó@\ÉSŽ+õö’\Õ#½ðÀ±F$ƒö¯\Ïo\è#G\ÕY<¯-X\äW…“ó{5\Ìz™¤lp+n\Ý\nÖ¶›¥†\Ã\È5»o¡ù\ë¸\à¯b*=QSOŒ*õ¯ªQ>Vú™º–¥\ä\Ç\åÁ„Ç¥s\ÒJòY²jk¹¼\é\rU¦\âK}F\Í÷\rg¿Þ«ò}Ú¢\ßz¹\Þ\åÁ«¦qŠ…W5£e\å\É\éY´;”yp‘Vü3lnµh¨\Ü3Tn\Û\ç\Úz\ê>Û«j’JÃˆÐµEŠ\Üó¿‹W\ßlñ\Å\ÖR8\Äb¹\Z½\âk¦¼ñ6£3î•€ü	ª5ÁSsx\ì6’–’¹™b5%+RR\0¢Š(\0¢Š(\0¢Š(\0¢šM\Ô\0\ê)»¨\Ý@	E;mhh¢Š\0(¢Š\0(¢Š\0Tû\Õ%FŸz¤©e ¢Š)[‰„\Ó3·<â¡¥jJ²«`\ÓÕ³\íPÓ… &¢š¿tR·\Ý5 EMÁô§T–òù3G!¶°lz\àÕN;Ò­X¼¸[©ž@›6\âJ®hi\Z“4P@¢Š\0u\Ú2hÔ›©2i¥\0.\êP\Õ8\Z\0}!4”PEP2ZPqPÔ‹÷EID›©šLšu ·Ú€¾\Ôú)­ÀŒ­u_tó\ãkG\É¬‡ó\Çò&¹s^‘ðŠ³­\íþ0Àb3Ž¸®\Ú+\ßFR\ØûNø+g­5;\é\ÖuÙ¸\é]=×t9´³h-\Ñ\0]”sY|huoÄ’0Ü£}«V{¦n\ã5ôŒ\Þ\ïCÉ–\ç•\ß| \Z.¤n¬·¯$\×C¢\é·	yn]:0;…z\r¦¥¸ŒýkfÕ´÷ÁT¬\ë\ÞQ³G§„©\ìe\ÌM¬Lº½¬Jò\É+l.{\×¯x/L\Õm[\í©$À`69®\ÆI¡n\0\0\nÉ¾‘w2©\â¸p\Øu	\\ôqx\ÅZ\'\Éÿ\0d›Àºca1\Û\é\\ž\ÝK\Äqy±Z\ÈT÷ô?\Ä/\é:ß’Úˆ,Q²£Þ©\évöZ]´p\Û\ÛÆ±¯@W²©Ÿ=Í©ó\Ä\Ú]\Ô+‡·‘JõÈª-.r¤WÔ¿e±¾B&´‰ƒ»Er>$øGk¨\î’\Ë?e\åK™•\â«\Éw:·\Ã^\ÂvU…¤Â³\á	\ÔÛƒnß•r¼;µG3\r¹fõ­5¬¶ö ˆ˜\ßmvþør\âE’\íHv‘]ôš\r´–&‰Jªñ\Åf\è2•DÏœq|žµ\ÚxZQ¦\è:•óq²&?¥aø’\Å,õ¹\áAò«ð*ß‰\æþ\Åøw\"\Ñ\Ú=kŽ¢\å:!©\ã-!¹‘\æn²6\ïÏšZh\Ï\Ê1€)Z¼ªS¥l!¤¢Š\Äb5%+RT€QJ´´\0\Ú(¢€\n(¢€\ZÔ”­I@Q@¢›º\Ô\0\ê(¢€\n(¢€\n(¢€>õIQ§Þ©*YH(¢ŠCMjZ»q¡\Þ\ÛZ¥Ì°4p¸Ê³¢¬‚…*\ÒS\Ôr(\é÷i[\îš:P\ßtÔQTH\Ô´„\ÐE&ih\0¢Š(\0¢Š(\0¤¥§F»\É­*Ô’G\å±\Ú\0(¢Š\0(¢@Â¤_º*:‘~\è©eO¦QH\Ò7Jm\ÐzÏ\áûƒ’CÇ˜\Ìk\É}k\Ù-\":ƒt\è˜\á¶\î\ãÞ½>÷1©±\êÿ\0<N¿½µ‘‚\áøy¯w‘|Àv¯“>©þÔ¸¸ý\Ø\'?Jöü[´º¼’\Î\î@Ž§\0±¯£§%c\ËCeec\ÛÒ¬\Ú\É\"`†\"…h®6ºH¬v«\n»xnI&Y¤Ûœœ\ÕI\äÚ­#¶\0æ¬‹˜\áV\ÜG¥y¯Åˆ\èz<°@1$‹€jTâ™£§&®yW\Å_ˆ’Kâ¤µ†M±F\ã\æÏ½z‡eT\Ó\â‘x\Ú2\Ýk\å\ÝZ\áõ\Ù\'‘‹37\\×±|ñ¼ö¢\Â\àŒ¯&·E#ŽQ³=abòZž—L­\Ôâ§‘\ãž%t`CtÁª2Gµ«¢&RE\Ãt’W\'\Ô\Ô»\ä„_Ê«nÀ÷¦ù‡Þ©™XšmŒ1°\n¡|¿e¶’R>U\\ÕœŸ½Ú¼óâ‹\Þ\Õ,­\æÄ¤\å€=«–£I\\\Ö(óMbO\í/HÀp\ÏYŸ¯\ÄP\éºbñ\å®óqŠ\Òð­»_k‘»ò,Mp¿µ·x\Â\än\Ê\Åò\nùúò=*h\å»R59±Ú™^Tž§P”QFj\0F¤¥jJ\n]Ô”PEPEPšM´\ê(»h\ÛN¢€E.\Ú\\b€Š( Š( Š( Œš( &Š( c\ë{Tñuæ©¦\Ãg3*Øª=+Š7úJ(En9 °Áæ£¢•€(¢Š`5º\Ò5+u¤j\0m>™O^\Ô\0»}9¤Áô«úm¯Ú¥aœ\03Q]¨\Þ\ÊNh	2§ b™SI˜d#Q2•8#€œŒT\äSh \É!\äõ¦QE\0QE\0QE\nUûÂ’Þ¤Pú(¢¤Š(¦€}¼bK˜ôgP:öo¥\ÚÄ¿v8À\ãúM»]j–±/\Þi~µ\ëž0m±\ÇþQú\nôðû\Ì\é>C\ä\éw\×t\í?pW,šœ\×¹3“Á÷®ûGf\Óü#´²ÿ\0:óEWó3n¯IÉ¤Ž>]OD\Ñ>.\ëZ$¼”Ì qš\Õ?´f¦\Ì.WÚ¼¦{…X\Ê¸¬\Ì35‹«-\"µ>ªð/\Äfñm»9\Üw+ƒø\Ñp\Ï\å‚p\rGð/RFómØ€{f£ø\â\Ûn¢\\þ\Å\í\'Í©ônö7<‰þñ©,®§±¸BûH\éQµ35\è\Æm?8jz§ƒ¾+\ÜYÈ°Þñ€+\Ø4ŸéºµºÈ².\æ\Æk\ä\ÅlgšH\ï\ï-˜ù7F?\Ùj\èŽ\'—s	@ûÌ†UÊ²\ÕýF\ÏNŒ¼Ó¢(\ë“_+\Ã\ã-f\Ýv\Ç} \Ç÷Žj½ç‰µMAJ\Ïx\Î5·\×#b${_Œ>-Z\Ú\Æ\ÐX°w\é¸\Zñ\íKU›U¼k‰[s5c20$“W!Œ±Zã©ˆu\rcM\ï„BYi7·®q²3‚k\Ãõ+ƒyª]Ny\Þ\ìyú×°ø¶\èxwÀ±\Æ\åx¯\îMyuÎ˜«¦)\Z’¸Ù ­IE€(¢Š–EPEPEPEPEPEPEPEPEPEPE4õ¢€$¢Š(\0¢Š(\0¢Š(\0¢Š(­Ö\Ò\Ñ@\r\Úi\ÔQ@Žg‹;[nkkE³I¡2\È71=\ë\n·ôy¼»p;RE•B\àqXZ¨Ý¹F+VIŽ\ì\æ©\Ý|\êhŠ|Ë¶CÚ™LŠ( Š( Š( ¥R\"¶\ï­-Eô§+sÉ¤Pú)¥\Çnhó=¨g\Â™|K`üõ\Ï\é^‘\â\éƒ]…ó\\Ã´ó¼Ug\ìIý+³\×\Û\Î\ÖvŽ›ñ^¦\á0™\ÚjD[ø!¤­y²·?Zôo7“\ákTÝ¯3f*¹®ùlŒFÞ¸ý*?\nF“,s\Í¾\\\×#,\íþj‹c®\"–Û¸\Ö\ï\Æ\ËÕ›WŒü\0Šóƒ\r\ÂÈ¬Q”‚\nš\è|Iq&¯\åN\ì_5*=N\È\×j<¬\çO*;\ÒS±Ž)V÷8\äõ¸Ö¦\Zsu¦·J‰F\Ê)6Š}&@\ï\n\Ø\ÑmE\Õô1‘\ÍÒ²cŠ\ìüf&\Ôü\ÖH—q ¸˜\ß/ƒMc§¡ù O˜\nó¢º\ê‡Uñ%\ã\îÜ¡\È…s¬\Øú\×%G©²\ZÔ”QX(¢—	ET€QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0\Ö\ëE.( \ÑE\0QE\0QE\0QE\0\ÚCKH\Ý(2iV›J´\0\êµ\r\ÓGPqUh \ëz\ØÁ?­*\Ü\î\'5žI¤\Üi-\Ç2f££$õ¢˜Q@Q@Q@Q@QHaEzQøP3±øZ›üL¤ÿ\0\n]>¡—\×¿\ï?­s\n\Ôÿ\0\ÂA!¢®œ¯\â(”w\ë^žcžgUñ_+C²OU\æ³6½\âD›m­!\èUEy½\Ãs]\ÓvFI‘\ÓÕ†\Ü\Zik˜\×rXþ÷l\Ý\É\å\ìÝ•éŠ¦­¶ž­»\ëLC÷Tl~juG\'š	`Æ“4\Í\ÔdT±\ÍÌŠplv¤;Å–a]Ï‡ÿ\0\âO\àý[Qc´¼e\×aše©<WGñRõt_\Øi1ü²Jw°-—y’4³I#³Æ¡nµ û¾´\Ú\âž\æ\Ãi3KIŠ\Ìš\\š(¤À(¢Š@QE\0Q@ Šu#PQE\0QE\0QE\0QE\0QE\0QE\0QE\0QIºŠ\0}Q@Q@Q@Q@\r¤=)h S––@\"©8\ãŠ{E\éÖQRm>”…H\ë@¢Š)€QE\0QE\0QE\0QE\0QE\0QJh\Û@\×\ÂDÝ«\Þ\î\Äó­ý9·ø¢ÿ\0\ÏJ\çþ5Û¯O#úšè´´ó<Y;IŸÖ½,6\È\ÆF\×\Ä\Öÿ\0Hˆ\Îy\í\Çõ\ßüNùo¢>Â¼þ\á²\ÜWuMŒQ\Zô§ŠzSÖ¹\r–\Ã\Å>?½Q¯Z’?½V}G\'z’£›¥&\"\n7R7ZJ‘\ÜvjHðz\Ô\rVm\Æ\æ\Ïj–Æµ:Ÿ\é­}¬[© 9j\æþ1j\ÃRñ„±\Æßº·\0\í^\àUþ\Ë\Òõ\rJn8\Î\Ò}q^#ªÞGTº¸\'>c“X\ÊE¤U\'\å¤\ÝCRW+(u´\Ú*\0(¢Š\0(¢ŒPEPBõ¢Š\0u\rÒ›E\0QE\0P½iÆ€EPEPEPEPEP(¢Š\0—4f›E\0;4f›E\0;4f›E\0;4Sh ŒS©Ñ\Í@\Æm>”¡H8Á­(mÕ”gš›\ì\ë·\î\ÒŒø\á|)þLŸ\Ý5}c\Çj6\çµ+‡)Ÿöy?»L’\È\Åi\ìú\ÔsEòš\ÆCzRU\É!œ\ÕyD‘\ÑE\0QE\0QE\0QE\0QE;\0Š(¢„wð—þBÚƒz[\æk§ð\Ì~o‹ý\ï\ë\\\ÏÂ³¶\ãR?\Äbõ5\Øx.=þ\'¹¯W\r±Œ\Ë?c+|§Ú¼\Úc^©ñq@™8\ç\åRú{\×]MŒzŠ½)\ëMZr\×-‡µ$z£©#û\Õ@IQMÒ§5Zc\ÍK	\ë@\ê\0\ÍKc°Òµb\Ôp¸\ä\Ôa3[\Þ\Ñ\ÛR\Õ-\áQœ°\ÏÒ³“)\Þ>½>øwoj¿,·X\'\é^$£jû× |f\ÖÆ¥\â_²\Æ\ç\ìö‹\åªg€k\Ï\ËW,™ ”QEfET€QEH#¤W¥\ã\ÑKQ\"–\\ó@QVµ‚I·M‰Ž•V˜Q@Q@Q@\0\ëN¦\Ñ@Q@Q@\Ý\Ôn QE\0QE\0\Ê)\Ûh ¢Š(\0¢Š(\0©\Þ\Æ\â;8\îž	V\ÞF*“2\áŽ Z‚¯M­\Þ\Üiúd³³\Ù[\È\Ò\Å\è¬\ÝhQ@©!ûõKoÌƒ4†h~\è©ˆÿ\08¦Æ½3RR¹C\â›RŸ»M©¸\ì\Èó\íH\Üö§)\Z‹…ˆdvj\Äx­*­uT‘T+Œ¸¤§I÷©´\Å`¢Š;\Z\ÃwR\Ói\ËÒ™\"\ÑE\0S©´\ê\0)\ê¿52¤^´\Ð§\Ã‹\Ëñÿ\0L¿­v\Þ	¼NûX®\áü„/Gý1þµ\Ûx4ù~(_v¯_±”\Í‹\ÃlˆO ¯&“\ï~5\ì?­ÿ\0s™\ê?•x\Û7\Ì}s]5z-\ÉVž´Å©r›!qSC÷…GR\ÃLù>U\ëT¤oš®\Ï÷j„MK!NZ‰jU¬[f„ñv\â½#áµ¸\ÓôýGZ•p–¨vµy\í¬^c*õ=+¾ñ\Õ\Øð\Âûk$m“\ßü\ÏëŠ™2\Ò<7R¼mBþ\â\á\É-#““õª´¿\ÃI\\²((¢Š†ER\0j\ÜKºªT\Ñ1Z@M4{j»\01Š™œµDü\ã\ÐmIS­¬\ÈZŽH^?¼1LQE\0QE\0QE\0QE\0QE\0QE\0\Ê)vÑ¶€E7u¨\ÔQE\0QE\0QE\0QJ´\0m£mH«‘š_,R-´m©<¿z<¿z\0eMj@f¡§Ç\ãµF\ÜMò¯Ò¤Ý“P\ÂÛ”qRTšGq\ç\îše\rÒ›RX­MjZe¡¹ûµ5W³VˆhÍ›\ï\Ó*Y‡ZŠ™!GcE\02œ½)´\å\éLh¢Š\0)\Ô\ÚPhjEû\ÕE=[š¤aðÌ‘«\Üú¿­w^M\Þ+Q\ïýk\Ïþ¾\ÝrU\ì\ÑZô’¾,\çœW­†2™\Òüf!tø}\Åx‡ñW´ükùl­Fzÿ\0õ«\Åÿ\0ñ®š\Û#¹2ö©–¡^\Õ<}«‘\"E^3Þ¤Ž´\ßJ*ˆapÝª“sšžVª®jdr\Ô\ËUA«1sŠÉ¢\ã¹\Óø7Km[[´·p2\ßAÉª\ßµ\å\Ô|P–[\Ù\ÆÙ®\Ë\áŒq\é:n­­NŸ,0”Œ·÷½«\Ã5½Qõb\ê\îF\Ü\Ò99ükžLØ¢h¢Š\Â\àQEH8FYv¦Ó„„)^\Ô\0‹NGJe*\Ð·ZXùuú\Ó\Z•0}\é\Ô[Â¦SŠ\ÇÖ”,ˆI¥\å®*¥õ\Ç\Ú9ô¦J(¢¤Š( Š)(h¤\ÝF\ê\0Z(¢€\n(¢€\n)»¨\Ý@	EPè¢Š\0(¢Š\0(¢Š\0)V’•hUû¢M_º)\Õ\0÷M-6O»@ÒƒƒšLÑº¬ö·D½ªþ\î+<¹\íW$¼#\éRZ.\î\ÝIU\ã¹\r\íOóG­I©&h\ÍC\çZg@–\ÅUšA\ÍG$Ù¨$“Þš+TtQTfQE0\n(¢0¢Š($(¢Š\0)\Ê\Ü\Óh^µH«\á\Û\íñ\ï!\é>\\x°}My[gˆ­Ï±\ê\Ïü%©\ÏñW«…2™³ñÉ±md>¿Ò¼gø¿\ZöoŽ\ÜCf>¿Ò¼c½uW\Ø\ç,GÚ¦J‚>‚§Z\äF—d\ëósMjU;i­\ëTK\"\Õw©dëšŠN\Õ\Z\Z½jåš™%E%ˆQz\×cð\ÓC:×Š-U—0B|\é	\éYH\Ö&\çÄ©‡‚¾\éú:¿ú]ö%ƒ’:\åšð¦®\ß\â÷‰›Äž0¸!É·¶&(×°\Åq\r\\²5Š(¬XQ@\n¢‚(ZV\é@\r¢Š(\0 \Z(ª@.\ãF\êJ(\0¢Š*@(¢Š\0))h \í¥\ÛKE\0SwQº€E7u¨(¢Š\0(¢Š\0}Q@™¢€Š( œ´Q@¯KE\0\Ù>\í:™\'Z`FÔ”7Z*€§³\îZeŠC\Öf^”\ï´7¯\ëQQAD¿hjO8\ÔtQdcšB}©¹¢ŠQE0\n(¢€\n(¢€\n)\Z›š	E\"\Ò\Ð ¡z\ÑERk\Âryzý©\Î9\ÅzÏƒñÿ\0	ˆ\ãž+\Æô6kVG·˜+\Ù<:ªž0·õg¯W	¹MŸŽÿ\05½©\Â+\Æcù±^\áñ³Kº–\ÄÌ±3\Å*+\Ä-ús]\ÕÖ‡<K\n*A\Å5ik„\Ðr±¡€\Ð\Í\Å\0A#sLcœQ#|\ÜRu¬\Ø\ì>:õ/c\Âõ½vN$–#^¼ƒ^u£\é\í©jVÖ«\ÖW\Åv_5(ôm3MðÍ«\0‰yU}x\ëXÉGŒ\Í3O,’±%¤b\Ç>ô\Ì\Ð\Ý)+šQP\É\n(¢•„*Ò·JE¥n”€mQ@R­R(§ªæ•—­IREPEPHzR\Ñ@¢—mh(¢Š\0(¢Š\0(¢Š\0}ƒ¥-\05º\ÑKE\0;¤¯Q]Mÿ\0€o\íü8š\ä0™\ìI†¹]\Ø\Ï8¯eðw‰ô~\ëZUÖ¸±_Koˆ­d^¯\íHgqÛšr\Ô0ñ¨\â¤SE\Â\Ä\êÛ©i‘ž´\ìÔ€µŸzŸšd‡\æ¦mÖŠóIšwE&ih¸ÂŠ(¢\ã\n(¢‹€QE\\Š(¢\àQE\0¢Ž=h\ãÖ‹€M¥cIš	´´\Õ4¹¢\áah¢Š ,\é¬RþÝ‡Q\"×³xtÿ\0\Åy¥ 9ós^\'n\Ûn $\ào\îþ	„Mñ\Ã\ÊFw2šõ0\Í[\á>µñ‡§\ê:¶RÛ¡-Žk\à¯igAñeýŽ\nªHvjý\Ô\ìM\Â(dOJøŸöŽ\ÑÎ‘ñ¾Í‚TŒw¯N­¥£Î¤\ß5ŽF-\"°\"—5çž…‚›!\ÂÓ³Q\Êi0±\å9E%,3\0+\Í=\áŽ²\ê\Z­À\Þ\ÉKno\\W™x\ë\Ä\r\âO_^–Ü¥Ê§\ÐWªxšûþ/†	e—\×\ë¸\àò¯\nRvòrk	!Z’œ \Í.Õ¬‹°\Î\ÔSˆ¤\"¢\ä±(¢Š. £4QH“FM#u£4rÒŠf\ïz7{\Ð˜ºšY:T+&\ÞsJ\Ò\ïN\à5º\ÑIFjah¤\Í¢\áah¤\Í¢\áah¤\Í¢\áah¦\î£u(£4f‹ˆ(£4f‹€QFh\Í\ËÒ–‘Of‹Ž\Â\ÑIš(¸XmF\Öñ³‡+óŽ†¤¢‘CZ•i\ZŠH¦—qõ¦Q@\Ç\î÷¤-\ïL\ÝF\ê\0^h§dQ‘@\ÆÓ–ŒŠ2(h¤È£\"ôŠLŠ2(\r¢“\"ŒŠAh¤È£\"€\ÐZ)sò\æ¯j\Ööö¦\ØA7œ$ˆ;ÿ\0²Çµ\0g5%;\"›LB56Š($r\Ò\Ò--´´Õ¥ÈªT\á\Ô\ã8\æ½\ßÀ·B?xn\ìðcˆ1\çÚ¼!H¯bð\ÞeÎ‘.sòb½#÷Œ*\ë\ê\ÏüZ·—R0\êUg ^Eûj\Çeu\â-\"þ\Å@Žhs¹z)-\ìRñgc7‘±wg¦k\Çþ!xš}sT\Æwš\Þ\Ôl_·­zµ#óu<øG•œ\ätSñL\\…ëš”3\\2gbMF\çŠ½\ê&jÉ²¬(®“\áþ‚|C\â[8\n\æ\Ý\\I)ö\×3»Šô\ÝDð/Ã»­a\Æ\Û\ëÑ²œ=Ea&j‘\Ãübñ@ñŠ\Z8ú-¯ÈŠ:WK$#—v,\ìrXœ’i¹\Í…\Î(É¤£5›c¸õ¤jn\ïz7{ÔˆZ)2(È ¢“\"ŒŠ\0Ž’Š( (¢ŠWTµ>Ža¢Š)(¢Š\0(¢Š\0(¢Š\0eQ@´\n(¢€\Ð(¢Š@¢Š(\r\ÝF\êJ(wQIEu©(¤\î£u%\0»¨\ÝM\ÝF\ê\07Qº’Š\0“p£\"’’‚‡dR\æ™J½h\ÔQJ½h\0\Úi1O¤<\Ðh¢Š\0(¢Š\0zŸ–†û½)¥\rÒŒn”\Úst¦\Ð!	£u\rIA#•©wSV–€\r-4R\îª\Ë\ß\é^£ð¶\ä\Ü5Š÷Y‡Ò¼º6\æ½#\àšùúš\'ý5\"»p¯\ß2©±\ê—wy7\n‡i*À×‡]H´¦V9!Žk\Ý/c\Ûw4_\í^­C\äø‚õð\Ë^I©Õ€>J†Þ¦“\åS\\¬\Ö%I:šˆô¥‘©»¸\æ²l»\Z¾\Ðgñ&½ga\0\ËJ\ã>Ã½i|vñ—Zµ\Ð\íH[m>‚ô\Ü:\×að\ê8|\àS\ÅwXó$_.\Ô6:óœW„\êÏª\ß\Ü^NKI3–$\×4¤l‘h\Í4œQº±lb\ÑIºÔ€Ö\ÃÖ˜\Ýi($“põ£p5-\ÐÞ´»¨\Æ)»©X\äSh\å4¹ö¦­-K¹ö£u%†.\ê7RQ@ºÔ”P\î¤,s]/ÃŸ\Ã\ãZ\éS\ÞÇ§À\çt“I\Ð(\ë^\Ó\âÏƒþ°±º‡D¸mF\âðe œu œ7\Z7\ZY#1H\èF\n’)´\0»¨\ÝIE\0.\ê7RQ@ºÔ”P\î£u%\0»¨\ÝIE\0.\ê)1E\0:Š(¥r¬QE\r§m¢”u¢\áaBÑ¶–Š.w­5ˆ\Í+SZ;\"…#4\ÊZ@I‘JTkK@\îdS–\Ø\ÒdSh C²(È¦\Ñ@)¡ˆ\Å5zP\Ý(1¦\äPzSh3\nLŠ~G¥1XEa\ëKšŒõ4±õ¦HúU¤¥i€þ•\èŸd\Û\âü\Ü\×¶\ì\Ê>Zô/‚øKŽ‘\îýk¶†Œ‰\ì{Ý¯€5\íz\â\âú\ËOškP\Ä2+\ç/\Ã.›\â\Ûø®£hdó>\ëŒf¿Y¾\Üiú—\Ã]-ì¼¶R¬%\ïógœ×…þ\Øß²ý·Š´i|M\á\ë5R¶Ì“\Çû\Ãk‘fjU\Ý+t\'\Ø>^s\à«5WNin8È§YE$ñL»Y\ÒPE2é±œWªÌ¢Po½Wt-%õ\ÝZ\Ú\Â5%\ç`¹†y5A²\Í]—‡õ(ü \Ý\êr·—\nb€gx\ë\\òz\"\ÏÇ[#YxKJù4ý60$+Ñ¤#\æþU\ä£m>\æò]B\êk™˜¼’1%›­G\\¬\ÐF¦Ò·ZŒ±É¨¸¢£\Üh\ÜhLQ´T{\0I´R`S7\Z7\Z\0vM.\ãM\çÒ“u$¢‘~\í-!ŽZZE¥©¸\ìQIšW†\ÑHÍ´S|\ÃLC\è¦y†0\Ð\ZC4–ó	b‘\â‘z2\rz†¾0\\xoÂ’\é\Û	n\ßwúL‡\'šóÇšJI$ždŒ\Äò\Ç\'ñ¦\äSh dQ‘M¢€‘FE6Š\0vE\Ú(\ÙdSh dQ‘M¢€%^”R/\ÝR¸\ì-Üš2jJE7&Æ€EG¸úÓ·\Z\0–Šb±¥É jfÁJ\Ä\ÓriˆFi3JÝ©´\"ô¥¦/J\\š?&Æ™“FM\0:ŠnM4€uÜš2h‡T–\è²\\F®HF8$T94ª\ÅXJ\0¹wf\Öø\Ü6ƒ÷}\ÅU«7¯u·y\à*«L4\ÖoJkRPI$6ò\Ü+´q³¬c.Àd/Ö‘T©©-î¦·YR7*’®\Ö^Æ£\Í1¥_¼)™4n>¸«Š¸o\Ã\Ù,¦ñeµ¾¦»\ìdÊº\àz:û]§\Ã+\áÿ\0Š\Ói²:²¨h\Ã€y\â¼\ãÁ:}Î¯\âkX\í£óD,$›\æjzûþ\ézM\Ôs|dK•9ŠY\Óô\Çø\×}-”_ø{ñ\Ó\Ä_üAsml~×¦	û39<â½«Xý«/<m¦¾›Œ7	²F/¸GJùŸÄ–«ý¬\ç\'5©¤þ\ä&\Ñø\×\Ôpõdª\Ê:œ\î¬×ºž‡/ñ;\Ã0øwPy£C\å\Ìw\äw&¼\Ê\î^½¹¯xø¢Tð¸½,`}kÀ\Û÷\Ò\ï\éN¼Tv\Éô\ËO:m\Ì>E\ä\ÖWŠµO\í+ˆ\âR|¨IÀ­+Û¯°\ÛmVÁ\"¹Y$ó%c\êkÈ“\Ô\éˆÍ£m7mH\ÔÃšÅ”1…7ÒŸƒIƒP2&>\ÔÚ•”\ÔeH¢\âŠ(§p\nrŒži´ªqJ\àH\ßt\ÔT\íÆ›@/\Ý´\Õ<Q“R\ÊD‹KLV÷¥\Ý\ïR0jJB\Ä\Ñ\Í\06O½M¥cšJ«’.¥>”\á\Å¢\áa”S¶\Òm¢\áa(¢Š.\n(¢‹…‚Š(¢\á`¢Š(¸X(¥\ÛF\Ú.Š(¢\ábUû¢Šq¢¤aºÔ”P1wQº™š3@®:—u34f€¸ý\Ô\ï3Ú¢\Í(4.i)-F\Ò*–>\Ô\ÆR§k\ÃwÖ¶±\Ý °uú\n\ËÔ¤I¯\ås\Å\0T\Í©( \ÝF\êJ(Â–š´¹\0´RdQ‘@E&EÀx\éHÔ›€¡˜P27\ëBõ¤c“B\Õ–Šn\á\ëF\á@´$U\Üjî—¤¶©{\r¸aó\Ë1À<\Õ\Ø\Ón+H­Du>d^´òl%\Û3\äI,gklŠ‹Â·’\é’ù¼\Üg>¸¬^jöƒ!Z\ÓÛ¸¸ÿ\0B\ßE\êd\ÏrñmÔ‰\êphiLJ\ëX\Þ\"cý¥ùV¾÷V½˜lrKqúÒ›‹¡9ù×…,&\Ö\âr\ã9×»\ê\r¸\í^¸¯ñ–û=Zx3\ÎwZ\å\Äü%\ÓG?ªN\×R’3Ò²Ê•\ê9­	1žy¬ò\Ùb	\äW…&vXv\Þ3I¶”t¢²\0\Ú)6\Ò\Ñ@µFÂ¥=*6\"‘5%8\Ò`z\Ð1(£hõ41Á4(¦óG4\'ð\Òn¤\å÷£5,b\î£u&h\Í!V¥\ÝLSJzPn£u5©(ýÔ¡©´P1üzPh§D¡¤Pz@Q[w\Öv\Öö!\îlV9Z*X­ZaqD¶­Sš\0ŠŠnh\Íq\ÔSsFh\ÝF\êJ(QE&=\è´Sh .:˜\Í\éM\Éõ¢‹ºÔ”P!wQº’Š\0]\Ô+sIE\0J\r.\êjý\ÑK@\Å\ÝF\êJ(\0¢Š(\0¢Š(\0¢Š(\Z\n)v\Ðh”QEPM©\Z’˜EM4%(¤§¨ ¶Ÿv®®j­_O›¥k\Ä\Çzšµ¥¿—©Z6>\ì\Èñ\áUý~µ%Ÿü~Aÿ\0]ù\×U=Ñ“=\ËÄ£ý:j\è\íû±YÚ¬Fx\í>X«újyqŠö\á±\Ì÷q7úK*ð\Ï^}§\ÄW¯\èûk\Ú/fòZYO“^®^­B\ê]\Ù,\ä\×-\èkOs>\â\à\í8ª¡þl÷¤f9\"™šñ:ËŠ\ÙQKºª«Sü\ÃR\Ôn¨D¼Ò™\r\0+0\äT&œÍœ\Ói€SZH\Ý*\0mQLŠ(§pÇšMÔ²}\êmH…\ÝF\êJ0}(\ëÒMO»N dy4\äRP¿xP\"Z(¢¢Š(\í3²\à±\"¡\éN¦\Ð\Ñ]˜i·†j­E\0.\ê7RQ@…\ÝF\êJ(Z)ža£\Ì4}\Ï0\Ñ\æ\Z\0BÜš)( AE.\ÚLRQE\0QE\0QE\0\å\'¹4”Qr…É£&’ŠwrhÉ¢Š.“FM”®\ÃqÖœßš4”€—9¤j•¨M4­M @O­¤aI@É “ŠJ*®EH­šŽŸ4$]µô\æ´ªVf¯Š\Õ2DÉ«JZ\â/gÎª¯_Æ¯\é5\Òöýk®ž\è\ÊG¾[¨¹³¶q\ÈòÀ«Xò\ê?BLƒŸ\á\Í[š\×.ƒÔŠ÷\â­•\îpŸu!£ø~FVý\ä\Ù\\Wƒ\îo,–=kÒ¾4j[õD´V\Ê\Ç\É\æ³\Êp:×‰‹ž§E$C‘FE6ŠòÎÛ±Þ—½2Š4ûý\éw\Ôt¡©\è2@\Ä\Ò\ä\Ó(\Í“H\Ä\âŒ\ÒThdÑ“N¦S¸“FM%\\n´”\ê)\n\Ãi\ÊxQL,z‡Àý\Ã>4×¯ô=a\Z\ÛQ¹µÛ§\Î9S)8Á´\ï\Ú+ö{\×þ\0Í ]\\Ü®¡£\ê\ÊÊ—\n»Lr’Œ>+\Éÿ\0¶5\r\ê\Úv±¥6\Û\ë)–X\É\ésÏµ}[ñ›ö´ð\ß\íðøv\çE’\Ó\Å\Ðn\"\n»”Mf\Ã\Ô¹\â¢NI®U§R\ÒV>US‘\×4£5‹ù+uÏ¶*\Í]ˆ&ŒšJZc“FM%\0d\Óri\Ô\Ê@6Š(¤HQE\0QE\0QE\0QE\0QK¶Š\Â\Ð\Ý)›\Í!\ê-Üš2h¢›“FMa\Ô\nnM\nNhQMÉ£&€\Ô}R-p¥¤ZZ	\ÒqJ\Ô\Ú#P>\í&h\Ïpj]\ÕM9I\Å\0:ŠnM4\0\ê)¹4d\Ð¨¦\î¤\ÝN\ÂŸ¨²i\Ê\Ô\Ð\Zm\Í^V¬›iŠ¶J\ÐI\rj‰&_\ëWô¦\áûUŸ?Z¹§ü³\'Öº\é\îD¢¼&Dš\\þZÚ¸a¶i\ÏD\çò®\áû}£KŒg‘Z¾8¸\Z_„o\\¶\Öl*þ9¯}¿r\ç+ZŸ-ø\ïX“Pñ5\Ë1\à9ŠÁ\Îy«:½´©¨<’œ\î9\Îsš¨O¥|\íi)3®*\ÈuÜš2kˆ\ÒÃ¨¦\äÓ·{\Ð\Z]´sJi\\,S&\ã\ëL	2(\ÍG“FMH\ä\ÒSrhÉ QL,h\Üh\rG\ÑMM4£¨¦\î÷£uP\Ç2†\àŒŠ“K˜\é:•½\Ü +F\áøýJ‡w½#7½6|Uuc{¬4úzypH¡Š\ãnÿ\0­d\Ô{(cA#\éi™4n4RM\Ôn«\×ZÅž—m#\'“ppƒ<\Ö}°\í\Ô\Ú)\Z%ŒM&MH¬:ŠnM4‡QMÉ£&€°\ê)¹4d\ÐE7&ŒšÄ”Srh 5E&EŠŠLŠ2(h¤È£\"€•z\Ór)TŠ\0Ñ¶“4f˜‡QM\Í 	–š)Ô€1šM´´P(\íEjX\Ú)v\Ò)jHQMb)¹j”U>q(SÒ·/´\È-\áPŒ\Ð9“\Ô\ÒT’©Y\"£5 ¹BŠLŠ2($‘d\ÚÀ\Õ\È\îBÇœsYùõlµq`w\Þ°²ñŸunKEy™ù¸\éô¬\ëX\Ì7JŒ0\ÊÜŠ‡\áÖª\Ú‰¡\n¡–e1¶N1žõ»¯X­®µòC¶~•\ÙHÍž\Ïð¯\æ·\0ô¨>8jB+UnZM\Äf¬|-\Çö~\ïjóÏŒ:¯\Úõ\çP~UkÖ©.ZV2\å\Ö\ç™\ß(½M\ÅpÃŠÅš-±[}8ª\×H\Z3\Åx3\Ü\èFE1&E`1iW­&E;\"‹JÔ”fŒ¢\Å#cmH¬%\ÜÑš?&Œšfh\Í¨\ê)¹£4\"\Ò\Ôaˆ¥\Þh(V¤£u&EQ\"\ÑI‘FE\0-™dPæ–›‘Fhc#2ª–b«\ÑI8S2(\Ý\ïRPúF¤\Ý\ïFh­ICž”\Ü\Ð!\ÔSsFh\ê)¹£4\0\ê)¹£4\0\ê)¹£4%\Í\æŠ\nET–QE\0QE\0«Ö’•z\ÐÖM^´\ê\0(¢Š\0rô¥É¦­-!XI¼\ÐÔ”]\Ôn¤¢˜[\Æ&b¥¶ü¤Š…ŽG4«I@¦\Óö\Óv\ÐöWF\ÞU=El^j©q\Ú8\ï\\þæŸ¸ú\Ð\×MºEúUr\Ýhf\'½6ª\â¸QE´”U¦\ç‚\Î<Meþõw>\"ÿ\0¸®O\áå°›^IJ±© ú\Z\Ü\Ö.ü\Ë\çmÛ¹\Æk²“2g²|8—\É\ÐeœS\Íx×\ïþÙ«Lû²7\ç^³\áyŸƒ%s\Þ<šðýZo´^H{?\Ì\×mIsEE?zŠ|yMŸJ°«ò\Õ÷òø¯2e¤e¿\Þ?Zm-%`PS\Å2œ)0šJ)7Ri\Z“4”€(¢Š`QE\0QE\0QE\0QEPQ@Q@QH\ÑIšZ€\Z\Z’Š\0F¦Óš’˜	ES\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢“uªŠM\Ôn ¢“u¨h¤\ÝF\ê\0x\'\ëK¸úTY4 œ\Ð+“\ÑQ«)ôr\Ò\Ó¥/ð\Ð+ŠÔ”q\éJ¸ô ¢Š(QE\0Ý§ÖšTóO\ÝAn\r‘­&M+t¦\Ð1ÁY²B³Ô…$\nnjýŽµq¦\Ù\Ü\Û\Äp—\rY\Ôvh\Í6Šzˆvh U\Ý.\Ù&¸Ä¿w«[Œ\í<;fš•ö‡o\ßL0\Æ{\Öd\Ód\ëŸz}\åñš0€\åWš§o\Ëþµ\Ù3\Ù>\×öO\03g£\ÅxÌŒ³õþu\éž(º6þµŒoZóm©\å\ß¤¥ \ì7~\Õ\Îk\'P“sT\×\rg\ÌÛ³\\“e\æŒ\Óh¬@vh\Í6Š\0vh\ÍHb\æŒ\Óh©\ìÑšm\0\ìÑšm\0\ìÑšm\0\ìÑšm\0\ìÑšm\0\ìÑšmÀvh\Í6Š š3M¢€š]\Þô\Ê*?&Œšn\ê7P=d\Òn÷¤\ÝI@‡fŒ\Óh C³Fi´P³Fi´P³Fi´P³E6Š\0(¢Š\n(¢€\n(¢€\n(¤ ¢™š3A»©ÁÏ­Ašr\ÐR\'^”¿\ÃøTj\ÄR†ùH¤$¢’26\ÕR\Ì{\nVù[ƒ\é@\Ã4fŠJ.h\Í7u©u›‡­‡­\Z5=)¹ö¡¾õ!ª	º’ô¦\æ1ôS3K\Í1\ÝZ6-´û\Öm]µ<¥Z(\Ôßžõ5¸ý\à\æ©+U»3ºE\ë¡\î<mu»Ãšl@ÿ\0	þ•ÁI!X\ë¢ñ5Ã½½œe²ª§Ê¹[\Éü¨r­\ÃóTÙ³RHÅ¹¨\rs±\ØZ)™£5$¢™š3@n£u6–¤ ¢Šiú\Ð+¢™š3@‡\ÑL\Í \ÑL\Í \ÑL\Í \ÑL\Í \ÑL\Í \ÑL\ÍªôS3I‘KQ’QL\Í¤!ôRR\Ð;8\Ä\ër¬œ\Ç¢\ÍN÷’\Én°3f59\è:)™£4}\ÌÑš\0}\ÌÑš\0}\ÌÑš\0}\Ì\Ñ@¢™E+šX}\Ê(¸X}\Ê(¸X}%6Š.\n)7Qº‚l-9i\0\È\Í( --Ò–‘V-\éwKex’º\îPzTºŒ\Ð\\\\I$chcš£Eº\Ô\ÊJ.\ê7Ss\Í.\êC\r\ÞÔ»©” \Ó\ìûR1\ã¥&\êLš\0F¦Òµ%(R¯ZU\éKTM‚­Û¶\Z©1\Æ*Å»U\ÄfŠ*þ›\Ì\ë\ÇzÍ¾QZº*‡¹\\Ö©ˆ¿\â\'ý\äIýÕ®Rñ¿yŠ\èu\é7^þ\Ísw‡\ç¤Àª6\ïO\Í6²P½)Y¹¤\ÝP+E*ò)\Ô\Â\Â/JZ(¤0¤n”7Jf\ê\0Z)7QºXZ)7Qº€°´Rn£uah¤\ÝF\êb°´Rn£u!\Ø7Qº’Š.Fi7RQ\Ì\nJ(¢\à>ŠM\Ôn ,>–£\ÝF\ê5´Rn£u°´Rn£uah¤\ÝF\ê\Â\ÑIº\Ô…¢“u©ˆZ)\Ûh ,6ŠM\Ôn¨5ŠM\Ôn ¢“u¨h¤\ÝF\ê\0CÖ’‘¨Zw ‘O¹4ƒ¥H¿tR\ÓU¸»©x4¹¨÷Qº€°\êJM\Ôn ,0““FM©¤ É£&’Š\0\\š2i( ŠMÔ›š\\šn\ê7S\rJž3UªXŽ*\â\É4ü£·¢ÿ\0®RkÕ¿¤¸š»W_›ý/9\Ç4…\ÎkGZ”µ\ÑÉ¬–84›‡\"›¸\Ò\ZJ\Î\à;h£h 7<ô­mC\Ãó\é¶1\\\Ê\é²Q•“HfP\ã¥.M%ArhÉ¦fŒ\Ð!\Ìx¦Rõ¥\"‹€\Ú(¢\ÄQE\0¢Š(¸QEÀ(¢Š.EQp“FMR\0É£&E\0QE;€QE\\Š(¢\àQE\0¢Š(¸R\ÑpŠ(¦ü\Ê)”PE\"\Ò\ÔQE\0QE\0QE\054fš\ßxÒ­$^\Ô\êbö§æŽ¥¤´\\ ¢Š(¸™£\"‹€\Ú(¢‹’RdQ‘@E&E\0\ÆûÆ“4§©¤ 4fŠ9 \çÞŸ\æ›Bý\áL\rKnksO}±–¬+Oº+f’«¸ŒMNM÷MŽ™ªMS\Ý6\é\Û\ëU\Üõ¤\"3Ö“4QR0\ÜGzžKû™$“\È\è:+6EAE qõ£qõ¤¢†h\ÍP©æ•\Ú(\0\Í¢Š\03Fh¢€Ñš( 4fŠ(\0\Í¢Š\03Fh¢€\nJZ(ƒ4fŠ(fŒ\ÑE\0£4Q@h\ÍPš3E\0fŒ\ÑE\0*Ÿzû\ÒQ@¢“uª\ÈŠ\0‹KLRirk&]‡QMÉ£&\ØuÜš2h¢›“FMa¬>cBŠ	9£&¨‘Ã­;5M46\ê7SGAE+–;u©›¨\Ý@\ÝF\êmhº\Ô\ÚM\ÔhII\Í\Ò…¢“š9 ,-œ\Ñ\Íah¦\äÑ“@Xu!\ëI“J¿zš\Z–£\å±\'\î¬\É\ïŠÉ³\çh­JM¶˜«\Î\È\ß9>ô\Æùª\Ú\Úùœ\ÔS[l¥Ž\ÄEG½\ÇRƒh÷£h÷¢ŠÁ´{Ñ´{\ÑEa´SrhÉ¦F£¨¦\äÑ“@j:ŠnM4£¨¦\äÑ“@j:ŠnM4£¨¦\äÑ“@j:ŠnM4£¨¦\äÑ“@j™£4™}-74d\Ð-GQMÉ£&€\ÔuÜš2h\rGQMÉ£&€\ÔuÜš2h\rGQH´´\ÄQE…\ÒhÉ¦\ÃQL\Üh ZZh4»«3Ah¤\ÝF\ê\0Z|’D@*0Hj=\Ôn ¢“u¨­%Šw$(¢Š.‹\ÐR\æ£\ÝKº‘B\ÑIº\Ô\0ú)™n\0¤\ÑIº\Ô\0ú)™dP\è¦\Ñ@¢›J\ÊS ¢“u¨iW\ï~”©÷¨@l\é\Ãs-;^›n\Å\éL\Ó9\"£ñÅ§D†jÀ-\î„qŠŠ\æa ô¬ý\çÖ“}@cIº›º\Ô\0\í\Ôn¦\î£u\0;u©»¨\Ý@\r¢›šUª$Z(¢•À(¢Š.EQp\n(¢‹€QE\\Š(¢\àQE´”QL\ÑE#R¸	“J\r6•z\ÓiT\Zr®jeŽ•À‡\Ë4›O¥Y\Ðc‹VŠ|‘\í¦Qp4n¤¢¨B\î£u%\0Œ\Ü\Òn¥\Åh7QK¶Š\0¥-\"ô¥¨,(¢Š\0F¤\ÍqŠn\ê=ii«N –QE\n(¢€\n(¢\Ü(¢Š\áEP0¢Š(\0¢Š(Ô´\Ý\Ôn \0ž\Ôç‘¤\Æ\ãœ\ne\0QE\0úUû\Ô\ÍÔ¡¨½£®\å\ÏaYº«î¼“\Ø\â¬\è÷<Ñž“\ÍfM!–BÇ©4\\\ZJ( AEPA \Z	 BR¥¦µ•i)h\ÔSriV€Š( Š( Š( Š( Š( Š( QOÛ»\ëS:f\\\Å\0AH\Ô\æS#š\ÔÀm*õ¤¥_½L1.j}¸\Ûe,x©[\Ó©:)\ÍMn”\Õ\rM%Bi€QJ(\Ý@	E.\êJ`QE\0QE\034¹¦Qš’‡14›­%\0\î½y¢›FhÔ¼šf\ãORh\0\æŒÓ¨¤y£4\ìS\0¹£4\Ý\Ôn¦³Fh¥\Ú)\0™£4\ZJ`.h\Í%\0ú(¢•Àm \ÒSsFi( \ÑM\ÝKº€ŠpŒe\Æ6ƒƒ\ëLj@I\Í\í§†\rFÆ“4S†h\Í%\Ãw½½\é­Ö@)£4\Ú(‹šL\ÑEŠ2)´\nÃ²(\ÍE!\â€š3L\Í~h\Í%\\ÑšJ(sFi( \Í¤¢€4f’–€Ÿ\ëºk\ß9®b¬E©M{Šc&\ÖR\à•\êk;5$“4¤–\ä\Ôt2(\Í&\Ú6\Ò\r–·&\È8\"¦i·óÞ³\ÃNó\r\0\\\ßF\àj¯˜hó\rbYqš®\Ô\âÅº\Ó\r1Š´´\Ú(¸®£4\Ý\Ôn c³Fi( B\æŠJ(ÿ\Ù'),(_binary 'ÿ\Øÿ\à\0JFIF\0\0x\0x\0\0ÿ\Û\0C\0\n\n\n\r\rÿ\Û\0C		\r\rÿÀ\0^S\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñð$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rðbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0øŸoµ9VŸJ}¹ñ\×¶¥¶ºž\Æ_6\ÞW†\\ÁÁ\ê3M\ÛHV‘6Y‹1,ORz\Òmö©i@ W!\Û\íF\ßjŸmh\Ó\éF\ßj›mh\r¾\Ô\å^j]´„b\r\ÛMe\éO¥\Æh\íö§*óÒ¤\ÛK¶€/x~\Ö;R\Ýe»Ý“\ï]Î­u\Ë,{BÆ¼.\0®O˜Z\Î$\'¥h\Üj«*¬G­0¹uY\Ó5P­ZšA\'J‡m0¹\ÓF\ÓRm¤\ÛNÀ3i£i§\í£m6š]¦Ÿj\\ûS_˜\Òm©JóÒ“oµ+mjM¾\Ômö¢À7i§‰dX58V\á±K³Þƒš,E\Ì\ï\ì»|“\åòzš’;8¡9T\0ú\â­m£m;\ßj6ûT»h\ÛE†E·Ú¾\Õ0Z6Ò°\íö§*üÃŠ“oµh°«N\Û\ïF\ßz6ûÔ“q)6Ó¶û\ÑÇ­q›h\ÛO\ÛF\Ú\ä~]]M\åû\Ñ\åû\ÑaÜƒË£eO\åû\ÓJQb\îE¶´ý´m \Ê\Òmö©JÑ¶®Ä‘mö£oµK¶´X¶ûQ·Ú¥\ÛWô\èl\Ú\Þñ®„ŠŸ¹QÝ³E„e\íö£oµXòý\è1ŸZV\Êû}¨\Û\íR\ì4l4\ì2-¾Ô¡jM´m¥\Ê6Ñ¶Ÿ¶µ< 3miûh\ÛG(\Ó¶´ý´m ¡›h\ÛO\ÛF\Ú\0f\Ú6Ô»!Z\ä{h§\í¢€oµ*j~\Ú6\Õ‰·Ú‚¾\Õ&\Ú6\Ð2/.ž\Õ.\Ú6\Ð\\Q\Å;mh\Ä\Û\íF\ßj“mh(oµ#/µK¶´ƒoµ9WÚ¤\ÛK¶€#\Û\íJÚ·Þ—m\æŠ6Ó¶Ñ¶‰¶“m;mh»h\ÛN\ÛF\Ú`&\ßj6ûSöûÑ¶˜\Û\íF\ßj\\{Ñz`0¯4›MI·Þ´i£&\Ú6\Ð+¢¶´EEK¶´.\Ú6\ÐTPTúS\Õiv\ÐQ\ÓB­K¶€¾ô\n\ìoµ}ªM´m©±\"+\íI·Ú¥+I¶\Æ\íö£oµIz6û\Ð;	·Ú¾\Ô\ì{Ñzaa»}©¥y\éSm¦²\ÐQ\ßj6ûT…y£m #\Å%K¶µd‘QR\í£m\0EKRm£m\074S¶Ð«\Í\0%ý´m ›‘\ÏJJ™–“mQR\í£m\0EJ«ž\Õ&\ÚUZ\0f\ßj6ûT›h\ÛPQ\ßj6ûT›iv\Ð{}¨\Û\íSm¤+NÀ@Wž”T»h¤E\ÆÎ’žÑœš<¿z±ŠF\ÚpP¶´\ê(ÈS@\ê)Jœž(\nh\í´m¥\Ú(\Ú(0›h\ÛK´QŠ˜M´m§RP;‰¶´\êJmi\ÔPiq»h\ÛN¢€¸»i\nÓ¨ .G¶´\ê(\ÛF\Úuaq»h\ÛN¢€¸\Ê*\ÄÑ®#\Úz®N*?/\ëA:‘\ÑJF\r%¸QEÂŠ( .9Fi\Ûi‹N ¤\ÅH\ÚKˆbQ–’EG©\'\0V§Œ<+©x\\M+U¶kk‡ŒJ›†)ªÿ\0\Ã]<j_4(\ÙC\"\\¬§?\ìk\ì\ïø(‚\ì<Eð\Â^;³´H\ï\ì™-g™’­Àò®yÖŒ$¢ú0£)Á\Í\í4m4Š\ß-.k]õ9dN)»MI\ÔQA${M*­9¨Z\r.h\Úih .\'4`Ó¨«-&\Ú{RPŒRSš›A7\n(¢€¸QK‚iBœ\Ð\r†”)§Q@\r\Úh\Úi\ÔP\"6\ëIJ\ÝM%\n)vŸJw—\ï@\\jŒÓ¶šU]´´M¦´\ê*l]\Æ\í£i§P´Xw\r¦©\Å>‘ºR‘\í4S¨ \Ì\æ\'ü)6\Ò\ÑAaE&\ê7UˆZ)h ¤\ÛN¢•†%QH€ ¯ ¥®‹\Ãþ¸\×`–De#,\Ý\èU”m•R²3Á\ÜGL/5VŒe\àSz\Ô\ìµ>cE\Ú6\Ò\ÑPX›h\ÛKE\0&\Ú6\Ò\Ñ@	¶´´PE-`%´m 4d\ÑE\00õ¢”õ¤§bŠ(¢ÀQEW­;¦­=z\Ò)…ðLþ\Ñø…FV8]¾‡ŒW\Øÿ\0¼Cý¥û>jsˆHž\ÌE|\Éû.Xù\Þ$¿˜º›zWÑŸ\Â\\x>ùnQp~•òx\êòŽ%$~•aaS7#óþšGJ“Ô‘ÿ\0«\éÐ‘úÓ—“_KI\Þø:±´\Ú\rµ QŽ”m¥­leb&ZEZ{\ÔbŠmih¢ÀQE0\ZÔ”æ¤ µ%+RS%…QE„\Òx®m\"\â\×Im3‰V\ßm\Âÿ\0µŸ\ç\\\Ý*\ç\"€$¢Š)(¢Š\0‰ºšzt\éMo¼iW=1Le\Û==\ïVB›@A“¸\â«m±V-®„ºô&«\ç4]¢‚£Ò€\Ù\ç¹ö \ãSÿ\0\n6ûQb\ÆQO\Û\íF\ßj,qHqŠJ+1\ãÖŠ( €\ÛF\ÚR\Û{Ry‚™CSE­v$‘~è¥¤_º)i\áEPEUY\Ôi~)—M\Ó|„\\n\êk—§n\'‚€-\Ý\\µÔ…AM\Þ)i_z5IL=jn5¸Ý´m§QRj7mi\ÔPvÑ¶E\07m.\ÚZ)€QED\Ü)v\ÒS·PEPIKIUb.R\àúQƒœP£\å¥\Ú=)h©­€3ŠEå¸§ÕM}cZ²°‹&K‰•\çL¨\ïc\é\ÙoCòt\é\îJ•i	\ÎGµzß\íü¿\ê<ÿ\0\ËþUð_\Ã\ãJ·»´QÍ¸ô®\â5°>Ô¸ÿ\0–\rÊ¾CIût\Ùú^[5+G\çjŒ!ÿ\0xÿ\03ON\ê|ŠI\Ñ\Èýi­}=\î#ó\ìGñX\ê(¢·\å9®0‚Ni6Ó¨ .7miÔ”\Ä\Û\ïF\ßzuv1­7&¤a‘Š¥0»\nP¹Ú±j\â6ÝŒû\Zvt¢¬\Ü2\ÈÅ‚\ã=ª,JAqžY¥sO¢\\n\á\ëF\á\ëQ\ÑUan´nµX=M”Qa\Ü:\ÑEX.J¿tR\Ò/\Ýµ\"\'ÖŒ·­´8QEL\Ös­ªÜ˜È›h~\Ä\Ó¶\ÃF\ÓO¡ºT–C°\ÑRQRer&ù©»ih­,;‰¶´´SŽbŒŠmX.;\"ŒŠmX.QE2BŠ( Ÿze9[€’˜\Ô\íÔŒ\Ãmf·:(¢µQE\0QE\0QE\0¹4d\ÒQH\ÑH´µ%Q@§\'Þ¦\ÑTAa@\ÛÓšoz¾Z)\0QE€C^¥û-ø}|Qñ»H³‘C*«\É\È\Ï!k\ËM}#ÿ\0ÿ\0\Ñ\×Røµ©ß”5µ«\'ør1\Çù\ïZ\Ãk•Ï¡¼#\Zi>1\Ö\íq¹Ž\Ü\Ó~#‰.49 Œœ2‘R\\±ø•¸<š\ß\Ö4!¨Û°\É\ät§…ŒŸ5¡¥\å¥\Ësó[^µ:µ\Ä cQ\Ö|]\Ò\ßCø‰«Zº\íý\é!}«”QÞˆ\Ó\ä\Ðñ*ËšWŠ(¢\ÆBŠJu¹@m\êm &\ê7TtdÓ² y`8¦1\É\Í• ô`)”P»Ç­&ñQÒŽ´X	i\îšM\ÃÖ‚\Ãš@GEU\0QE\0QE\0S”dóM§G÷©*Š]¢‘ih6J6JZ)Œ*f¼šKT·iÀ„²\Ç\Ø\Ô\Ô4PH\Ý)i\Z³+˜J(¢¤‚\Z(¢¶\0¢Š(\0¢Š(\0¢Š\r\0&\ê\\\Óvšp Š( –’Š\0v\êUù³L§\ÇÞ¦À_¥7¥KHË¸Qp\"¢–’¨\Ú}(\Ú}*Z*n[O¥O¥KE\Z*j(¸­-:–‚\ÆQN¢QR\í”m•W Hþ\í:’–¤Š(4\0†¾\Íÿ\0‚n\è{¿\á$\ÕJœ³ù`\×\ÆS0HÙE\æ¿@¿\àºKYü)½º+ÿ\0Aüjß»\\OCñ\îŠ,ü\\gQÌ•­c\0”×Š\ÜñÖ‹ö«¥›Š­¡\Øù— 5\éÒ©d›\ìL›GÂŸ¶\'ƒIñ´Z’\ÆV9¸\'\à	Œs_}~\Û\Þ7)Zœ6+\à8\Î\áø\â°v’\æ]D¥q\íM§½2¹\ìXQE€)´\êm #\ÛF\ßzZU\ëC O/Þ/ÞŸEf4QEPòý\èòý\éô÷MHQE@QE\0QE\0QE\0 ‘Ò’Š\0™Od\Ò/\Ýµ\0!a\ÜÒ«zTm÷:?»LdÑš( R5(¤jŠ(©\Z(¢¶\0¢Š(\0¢Š(\0¢Š(\0¢Š(ñD\Ó6\Õ\ä\Ñ$M\Ã\ZXf0¾\áÖ‰¦36\ãÖ€#¢Š(\0§\ÇÞ™O½ ET\\:÷Ý§Ò¥¢Ÿ0	¸zÑ¸z\ÔTUX	wZ7ZŠŠ,\ÔT[­­+%-5zS©”´”\0´QEY³¶[†!Ž*µI†>A\Å4\×v\ënøS‘U\È\Í>INM2¨/›²{ŒW\ê_\ìS /\à^Š6mi2\ç\ß5ùku™cˆu‘\ÕG\âq_¯ÿ\0³Þš¾øK¢Z‘.\'ò¨­ü\'cH\îuþ%\Òü\è÷cµr\ÚU³[_\Ø5\èw2-õ¡ db¹\Õa¾u8<\ÖXz‘Å•R7\Îk\ã÷†S\Ä\Þ¸V‹\î\È#\í_”> \Ód\Ðu\ë\Í>E\Ù\å\È\ÛA\ã5ûA¬\éÉ«ørxÀ\Éò\ëò\ßö°ð4¾ñÛ’<C3[\n\è\ÃT\æ‡\'c…K–GŒý\áœæ’”\0¼”µ\Ð\Ñ\Óq´S¨¨hwM§R5+\Èè¢Š’E\Ý@jJU\ëJÀ2’•¾ñ¤©þgµgµ2Š\0(¢Š`QE\0QE\0QE\0QE\0J¿tR\Ò/\Ýµ\0F\ßxÓ£û´\ÖûÆÝª\è¨¢Š½)\Z“4Œ\Ø\ë@E%¬TQEhEPEPEPEPEPEPJ:ŠJZ\0“4f›Eb³Fi´S”QEjEPNU\Ýô¥úÓ©\\–’–¤°¤¥¤ ¢Š( (Q@¢\ZZ°\Ï\å\Íjø\Î\Ù\ã?øð¯×Ÿ…ú§öŸ‚t‘´H-S ô\'¿ \îhó’#\ãÂ¿]þ_[\ê_tk„e?¸A\ÇÒ‰?r\å\Äô\Ý%w\éÌ¤s\\N¢\Ïªy\Ç5\Õi7\ÃF~\é¬o\Û¾5\ÅNñ¨\Ó\ên\ì\ât>“\íŒ¤dc‘_,~Ø¿¿·¼?©¡bQ\ZdeRpqšú‹Â®c8\Ç¨üOð\êk\Z4™V0ö\ÅM:ž\Ïg³<j›\è~)\Ú1\ÃF\ÇçŠ·\Ô\Z±^ûB|<o‡Ÿn\Ìq4v7Œd—9\æ¼õX05\ì7}NºrºET3A”KHÔ€ŽŠ(¨\0¥^´”«Ö‡°=i(¢¤Š( Š( Š( Š( Š2(\Í\0QE\0;qõ£qõ¦\ÑH	m\ÝeiF\ä$z\ÓY€f\Û÷s\Æi”P·\Z7Zm\0»­\ï/Þ/Þ€¿tQMßŽ1E+\0\Ê(¢¨Š( Š( Š( Š( Šr©v\nI8À¥’6ŠBŒa\Ô\Z\0eQ@-%*ý\á@¢ŸEg`E>Š,4QEhEP\ÔT[­­M€’–’¢‘W’¢Œ\naqh¤oºj=\ÇÖ‚Ih¢Š@»©( n£óauö¯\Ðo\Ø\ß\ÆS]x3L´y\"©\\\éŠüýõõ\ì[\âq\ZKbÇ˜%ÀúWe8óF\ÆU•\Ï\Ðh\íJÊ’(\á†j¶¹lÉ±\Ï5wGº:llyâ¨Fo-ø\ê+\Æ\æ”ggÐ•T©¢\Êa™X\n\é\ç·]GNxÛÃ½s\Z|L\Ó\Ø\×Ob\Åb\0\×5}Ô–\ç4Ÿ1ò7\í…ð#þ_\ÜOiûuªù±\í\äs\ç_›v®ð\Í%´\Ãd\Ñ1GS\Ô\Å~\çkš,Z”2#®Uñ¯\ËO\ÛK\à+ü-ñ¿ü$Zt$iZƒŸ0(\á\\ó^\Æº«=\ÅJN.Çƒ©¥¨`H¹%t3\Ñ\nB)h©2¤RT÷MGR@¢Z@2Š(©\0¢Š(\0¢Š(\0¢Š(\0 \ÑE\06Š( QE\0QK@ô ¢—¥%\0QE\0I¸zÑ¸z\ÔtR°\nzš)(¦¶\Z<³O_º)jnDcŠJs}\ãM¦ES\0¢Š(\0¢Š(ð\Ì\ÐJ’/\ÞS‘N¹¸{©Œ÷EE\0QA \ÝJ§šm*ý\ê\0›põ£põ¨¨¥`%\Ü=h\Ü=j*(°QLŠ( Š( 	¨¨·Z7Z›-QH·\Ý5H\ßt\ÔuHŠ(¦\ÔQE@\r\ï^\Åû.\ë\ÃFø†m‹\íK”Àÿ\0z¼{{EÖ¦ð\æ³g¨Á!‰¢•I+\éš\ë£-lg5t~\Éx7I„õ;0k~5ùˆ\ã>•\äþ$i—\Þ\r°»–\ì\"´A™‰ö©<IñûA\Ñ\ïZ+F’öoök†¥	Î£\åG?³v=~p²n+[ø\Ú|\ÑuûQ^\Çú.„ò`õoJ\×ð\ß\íe¥\\­g%”™Án\Õ\ËW]­‹Tü¡¤*My—\Ç?„V<¤\\Ä¯#¡1¶9V\ÇZ\ë¼-\ã\Ý\Æ«6›}û¿ƒ#\"·;cŠó\ã*˜y\ë£DJŸ)øU\â?\ßx\ÅW\Ú¤öò\Æ7(<\Z†¾ýý¿¿gñ›ÿ\0	Ž\n\Å}fl¼+óö\Îa$xr7/\r\ÏC_KNJ¬\âtS|\Ú\ÑNÛŽô„{\Ðka­÷MGOo»L©\nv0¦‘z\ÐTj\ÑRyb˜z\Ò(¢Š`QE\0QE\0QE\06Š( \Üh\Ï”Pñ¥;\Ë\ÐRC\Óñ©Yi \êi6J{RR&\á©)\Í÷6˜QLŠ( 	GAKE\0F\ßx\Ói\Í÷6¨Š(¦EPEPEPEPŠ@v\Ò\Òp\Ä{\Ð\ÑWµ-B;\ï(Gk°UÁ.7Z£@Q@R\ÐQE\0QE\0QE5\Ä=iõ\05¾\é¨\êjc/zhQO\ÙF\Êw*Á\æ{P$ö£e(Z-p°½ko\Â\Þ¹ñŽ©¬@ˆU•½eZ[=\å\ÂBƒ,\Ç¾ø{¡C\á½:¿i‘s3Ž¤\æ®:Ó‡1\Ý\è\ë\'‡´}&\ÒVû<`\Ç\Õü:Ó£½\Ö\í*s\Éa\\\î“\ÜL\ÊÇŠë¬¯\ÓDˆø~Þµ¼j[s­PG³\Üø_Iû(\Ä1Ž:\â¸/x_M’\'f¶ ®Z÷\âµî–¹\Î\åšO\Æk]JA\ÌB=ü5¤k.¦\ë\nf\Û\ß]øVü\\i2YJ‡± j÷¯…?´?öœÉ¦\ë\çÊ”ü¢s\Ð×‹\ë6P_7o’\Ís\ék$w”©\àŠš´\é\â¤p\ÖÃ´¸¼m¦Zø«\Ã3Ú¶\Ù\à™¸n+ó+\Ç±³\ÇñS•µ!e¥;ù‘ÂFM}¥ðk\âu\Ä\Ñÿ\0cj-¼‘ˆÙq\ßd6þ#»9Á$c\éX\á(:.T¥ª\Ý\á\ÊÏ™G\ì»\á\Èb\Ãj·E\Ç÷[Š\à|uð:\ãÂ¶­u¦\Ü=ü\n~eo¼­{Þ¡x\Ç88¬«‰\Ìñ²I\Ê0Áº§M-\ì|–§¨<M\"»ßŠþ_\ê	woþ¢ç“\Ð\×\0\Õ\Ç-,V;qŠu3iô¥ßŽ1Y>¢o¼i\Þgµ2š\0¢Š)€QE\0QE\0QE\0\Ú)\ÔPh¢Š\0š©‹\Z­\Æ*Vn)\03qQù†‡=)´\0¤\çšJ(¦EPEPž`£\Ì¬±\É\Í%S\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0£Q@R5\0©sM¥Z\0ZV\è>””´\0\ÊU¥\ÛJ«ž†€ŠqR)´\0QE\0øû\Ó\é‘÷§Ô°\'Ý¨\êI>\í2š-QO” ¢œRn¦´¸øW§­\Ýô÷¡¼±…\È\ï^Ã¥¶Ë€¹®\à\Üj\Ú=\ã•ß€q\Íw:j¾«;h¤w\ÞŒ\É;¾:\noˆ5˜l_.À°þ\ÖÇ„b	§N\ç®9\Íx×µ;VuW8REaY\Ú:\Í¥-K>,ñŒ\×K¶\Ù\0\Åa\é\Þ »Ü­$(t5œÓ†9/\Å>[Ø’.9¯+\Ú\Êö=x\Â6=·Àþ2mJ\Ð\ÚNÉ½G\0u«Wúò\Û\\r8\ã>\Õþ(•X…\Ï5\Öx‡Pf¼e\r\ÆkÓ¥Q\Øó«\ÓGwŒD7OlvL‡ Ž+o_\×d\×\ãŠ\âf.\åF\\×‰­ûE\Î\ê\îô]au\r9-\ÔüÞµ\íQ•\â|õX¨½‚\×\Âw:¶™ƒp¬¿x#P\Ð!Y¥‰‚\äW\Ðÿ\0\nõ\Í\Ã\Ãñ[\ÝD¯:ó’*ï¼U¡jVMc-ª:Fp+)\ÊN\\¼ºw1±ñ4Ÿ\íÿ\0Ý®›n¦P{\àW\ÎyÝ‚k\ëŸX\ÚGwª[Z¦ do\ÔW\ÉwySÈ˜\Æ\Ö+Æ¸§¹œ‚¢o¼jZ‰¾ñ¬‘˜”QEPQ@Q@Q@Q@Q@Ô”­H\08R–\'­%()¯Úœ¿tSd\íR€eQTEPEPEPEPEPE!4n ¢Š(\0¢Š(\0¢Š(\0¢Š(\0¡¨¢€J´”/Z\0u;)=é´¹8\Å\0*«¹Uw;^Ž¿õ[\n.¯5·\ÊË»\0W\á}B-/\\µ¸š1,h\Ù*\Ý+\é{\ï\ÚNºðK\é\âx™†\Ü8\â€>U—>c1ƒŒS+C^ºK\íJY\ã@ˆ\ç<Vy4\0QIº@½>™Fh\ådû´\ÊuXcè¢“\"¨¡\Z’ŠrŠ@z\ïÁ\é€\Ð\îc\È\Ý\æk\Ðôø\Â\ÌWŸü\r\Ðd\ÕôýbH&Fž-¿\è\ß\Æ\Ã\ÔW¥G\Ú6\É\"h\Üqµ\Æ\rY\ÙKC¹ð\ÌÛ¬.\"\Î®x\'\Ä[y´ý^m\Ã1¯K±ñ÷ö½®¦i·z¥\Ã\äùv‰¹¾˜®o\â,‰®´¦K9l\ï*\ÑL0ÀŽ¹…k5cÔ§.]O\':¯L\æ™ý¨d\\f¢ºÒ®m\ØïŒŽx\â‹\âi¹Pzó½šGrªÎ¯\áú5Ö´$\ÎŽk§\Ô\ï\Ã]?Ížz\ÔðØ ‚+Ÿ°y\ÌKü#¹…u?ü\à\ï\ëÖøW\ÄS\ëQ4\nf36\ïŸþµ\Õ	Y\ØÊ¤œ–§=\àU85\ìÿ\0\n­,¿³¢º¹O›¨\Íx\í¾‘ö¹‹mŒ}1^ƒc¯C¦\é\ëodL®\nµ\ìÐ–‡U6\Î\ïT\Õ\çµÔ¤6s“°\Ì\ë^.½\Æ}Î«Õª¦ý¥ªj	öµ6\Ð7Vj\ìüU§\è¾\Õr¬·ka³\ß¼™Ÿ)\äwšüw\æw0A\æ¾y\× òuK\×\ç5Þ¦¶m\ìäœ\î9ÀjRy—6s“^|÷2‘B£n´ö¨\Ï\Þ5‹9ÂŠ( ¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢“u¨h¢Š\0”t¦\ÉÚ3ÚšÍº¤¢“uª€Z(¢€\n(¢€¥%¹¤\Ý\íJ\ãŠ\\w¤ AES­ÖŠ]´m ^”QE\0QE\0QE\0QE\0¢›J´\0m£m-\0QE\0INjm\0:‘©h#4\0\Úrö¤\ÛKM\0\ìŠ2)´´ÀuQ@\Ç7Jm9ºSi2‚M©!V’@ª7Úª1l—áŸ\îþø\Ê\ÓW·Ü–h\Ï!—>•÷ÿ\0ƒôþ\Ñ\Öð\Ü\é·\Ð\Ø\ê-\Ü€;½1_Ÿ\èûa“EuŸ|[ªü?Ö’÷N¸{wŽ@ûPðphœ%gcH\ÔI\Øú7\Æ^ñ¿\ìƒñ*\Ë\Äv±®©¤1Çš\É\Â\çŽk\ÇKs\â{\Ù<O­\ØNš}ðó\Í\åœª‚z\àW\Ôøõ\à\ï\ÚÀ·^\Zñ+\Ã¥$F&\0±=ó^{\àÏ‰Z¯\ì©\âð—Žô\æ\Õ|#\æ\ÛV	\"c\Æ\ï¥x•%V7º÷¿3Õ£(\Ïf|\Õ&ƒ\á\ÍZOô/-¢©{	¢ºðÇ„t[:óÄ³jNI$\×\é‹\á‚\ßaMWKƒG\ÔZ_œ›y¾Oªæº­#\ào€|:\æ\â\ßA³R>o2N@\Åy¯(\é$\ÏR0V\Üü\çøkðg\Æ_\ìnn´]*m3B›»\å(\Î\0\Ï\é^Y¥ø~\æ\×Y»‚gb\Ð\ÊP\î\Ïc_~~\Ô_µ\ç„>øz\rxf\ê\Ö÷]¹£\ÙbF\ËpF2q_\0YøºGŽI$m÷2’\ÌÞ¤õ¯K\n\ç[V¬sV©lÎŽø2ùV°ž\\\à×¶ø\áø±\Óã»†–]¹;«\Ã<+×—‰q!\ÜA\Í}\à¯-»\Çk*\æ2\0¯¥…7Ýœ”\ä¦\ìrž(³Ô®õh\íá…ƒ³mÚ¢\âÏ†:Ýƒï®š\0\å¸5ô_ÃŸ\Ø\ë\Þ*·¹,¤gp\ï[?µïŽ´_†ux\Ð@º„Ö…\"CŒ\äŒf¸*c9**Ij\Î\Ùa\×-\Ï\Ê}Jü\Ã4Ð‘†V \Ö\Òn\'Ö’mBKû©\î\\`\È\åñõ¨_76§‰Ykd#\nˆŒ1©ª6ûÔ™\Æ\Æ\ÑEQE\0QE\0dQZZmåµ½¼\É<+0!K”›E-%\0QE\06Š( QE\0QE\0\Ú)vÑ¶€Q@\âŠ\0(¢Š\0k}\ãET;\Ìö£µ6Ša\ÔQEY!EPE¸>”\0”QE\0QE\0QE\06•i(^´\0\ê(¢€\n(¢€\n(¢€\n(¢€\n(¥\Çª@%-%-\0:ŠLŠ2(h¤\Í-!‚òk\Ñ>ø4\ê>«tŸ¹PV0Ã©®[Á\Zx‚b¥­ÁÌ„zW¼k\Ûhzz\ÙÚª¤q¨P\èQ§\Ô\ÎR8]b\Ãl\Çh©4\Í/\Î\Ã½ Ø§ˆo\Z6lzš\×ñN“Ž‘¤GW\\©\èaÍ©\ç:”—º~ —:t\ïm<mñœWµx[ö¤\Õ\'\Ðbðÿ\0Št¨|CbGûPÝ¹H\é\Íy}¿—\ç•CCP]F­1x\Ô ®J˜U3hUp\Ø\íµéº•ÄšÇ‚$Ô¼,\Ìl³¹(¨Þ˜ô¯6ñg‰þ\'H£O¼øƒ«\Íf¤‘\Ý‘Œ`‘ZCX\Ômb1Áu$hF\n©\â²\Ìfg\Ë\ä¹=\Ís<M\Ö&G#k¡My’Hó\ÊNZI	f?‰®§C±i&]\çŠÑ‡O½*\Äq5\Î0=k®ŽS\èL«6v:e\ÌV0…ŒóŠÑµñG2°“\ry\Ûj\Ø\È\r‚=*\Õd\ÏEu\Ùl(Vqw>\Ñø3ñ^\Ú\Ò\ê\Þ#.Ë’6\ç=\r|\Ùûx|P¸ño\ÄKm8N\Ï1\ã5\Èh:ýÍ–©k6ö\ÂÊ¤\àŸZÁý X\êž1Šÿ\0Iù½kŠ¥_-N·Œœ—-\Ï<WÊŠF&˜«·¡æ’¼ù#Í±Û­&sIEAESQE\0QE\0QE\0QE\0QE\0\Ú(¢€E&\ê7P\ÑIº\Ô\0´QE\0QE\0QE\06Š(\ëPXQR–•\Åq”QEhHQE\0«\ÉÇ¯¿®kZ]÷†ô+K·\Ô,\ãu¼¸?vv,J‘ô\Ï\Ò\Ð(¡º\Ñ@^”P½( ·Z(n´PBõ¢…\ë@¢Š(\0È¢›J½hh¢Š\0(¢—Ò€œ>\í/—\ïK«B`3i£EP¢Š(GZs©\ïÚšµ«\á!õ\ïiöj2­(-ô¤U\Ø\Ëð¿\Ã\é\á_\nµ\ì\ê«uu\È\Ý\×‹­jutù=\ë¯ñ¶¡´V‘¢%\ÆÒ¼\à1š\ãŽI=\ë×¦¬¬Œ$tº\ÒY¡•\Æ4ýCR’ð#³ûªµ\Õ\Ò\ÚÁ\Z«6;œ¾sZó[[šQ\ÆXqJb=\éör¼ó\ÅLv·¥3\å‡Ó­\"\Â‡Õ©– _–Eô f‚C\å[ô§}›ûb\Æx\á™p’K€a\Ú\r7\ÃÚ‡övµŸõdá‡­\Ü\â\ZCŽÃ¯(ó\Õ|Pð¹ÐµŸµB»mnõúš\äƒ(\çšLgU\á{Xõ)\ng/ z\Öw\ÆsvNÀ\åF\ßjƒEÔ›L¾Žu8\ny\ÅzÅ\n§‰~n\ÑI\Ì\ÛEG-\ÑW>i1\ãñ¤\Úi¶³	£\Ü\'üªZò*-M\â\Æ\í>”m>•%\ÍrˆŠ‘Ö’¤“\î\ÔtÀ(¢Š`QE\0QE\0QE\0#RdÒµ%\0QE\0QE\0QE\0:Š( Š( yfŠ’Š›^œŸz›J­´\Ò(’ŠnñKº•™#h¢Š\ÐŠ( ·Z(n´PEP—¥/J(­ÖŠ­\0P(¢€‘E6•h6šP)h Š( ¤\î\Ôtõ`4€}5‡­5˜b’\Ü\"ŒŠm Q@^õ\éÿ\04¸ä½¿\Ô\äÿ\0–)µ	õ¯.Ý€{W¹|6´:?\Ãó)d¸,ù\ïŠ\ê£±I\Ù<Mxood$\çœV^›m¾\ã\'¢óKw&\æ\rœ\î<\Õ\Û(\ÄP3“Ö½8«Ì¡©HZc\ÏN*ž\ãR\Ý>ù	**\0»\Ë*ŽqW#¾ùFd+ô©–CÒ\ì”—Y¨~\Ñ\É9\æª¨±š.K4–\è\ãš|R*¿£f²–BÇ­X\Ï\0\Z`v>5¸þ\Üð\Ü.Í¹¢ûU‡¾ð^±\á\rb]cS¸¶\Ö6\â\ÍAÂ†\Õf—~*“\Æ+‘Ž)&¸KxQœ±\áTg4˜\ÇAn°Hc\Ü\\Çœ\×ÒŸ?ø[ðýÀó ;Tûƒ_6*›y\ÙYYnµ\íß³þ´,uæ‰Ž©N:òÆ¡¦¾‡\âMSNu*m\æd\n}4`\×yû@i#Eø¹ª•û—$J?\Z\à3^f!Y³x’\ÑQn>´õ5\ç\Ø\Ðs0#Še!jL\Ó\ÔSsFi€\ìŠ2)´P²(È¦\Ñ@È£p¦\Ô×–sX\Ì#™\n1P\Ã>†€!j(¢€\n(¢€\n)vÑ¶€Š( QE\0QE\0\ï0\ÑM¢\r¢Š)€Qš( Š( QE\0\Ö\ëE\rÖŠ\0(¢Š\0rô¢…\éE\0#RRµ%\0QE\0«IJ´\0´QE\0QE\0QE\0QE\0QEP-%/j`6EÜ¸÷¯ ¯\"\Z?…¬,\Ðò¨9÷×†\è6S\×4\ëa÷^e{W·xªm\Ì#\'²ÿ\0*\ïÃ­.e7c“™w­h\ßo¦¢ÿ\09¨lmÌ—ƒžiþ ùd\ÜW `c\Z)Xb’  §+c­GŠu\0?\Ìô¦hÁô¢‘,|\Õ<z \èjdûÂ•Æ“þ%ò}+/G\Õd\Ñu¯!ÿ\0[\Ê\ÕÙ›mƒŽø¬]¾´›gP¾}JòK‰\0#8õ5\Ûü1\ÔþÁ­@çŽƒ5\Â*ô­½CÑ•89\ÍiOp&ý©,|\ÏY\êqò&‹n\êòýKMZù\"šaol£t²Ÿ\á_ozõÿ\0Ž-ý¡\à].\ä\Ï\ÛKw\Æ+\Å\ío\Z\Ú\'U\ã\Ì?J\á\Ä|L\Ò(5x­/%Š|ø”\ád\Æ3UZž\Ô\Ó^y°\Ú)U~aZR_[bµªÛ¯\ÚK†ó±\ÈµH”QE\0QE\0QE\0=\íô\×ò¬“9vU3\è*\n(\0¢Š(\0¢Š(\ÔQE\06Š( QE\0QE\0QE\0\Ú)vÑ¶€Š( Š]´m ¢Š(­ÖŠ­\0QE\0\å\éEÒŠ\0F¤¥jJ\0uQ@#R\Ò5\0%*\ÒQ@¢›R\Ç\ê\0ecì¥½ªk\r\Z\ëT¼[[HZy\ØGZ\0£E]\Ôô[\íEK\ëY-Y³´H1œU* \n(¢€\n(¥¦ið–\Ånüa°\ÊÀ\'ò®\Û_œ\É~G£b²~	Ú¬z~»~\È2¤DŽzdŠ±4†\â\è’rwW¯‡¢s\Ô\Ü\Øð\å˜k¢Çœ\Ö¹)k\ÙûU\Õikö[I\æ<qÒ¸\ÝBO:v>¦º+QJ=(\Ú}* ©@÷¡W\í´€J¾õJx¨±\Éú\Ò­K~ó>—£\Ý\ëÚµ†dñ¤÷S¤!¥8Q¸\ã$\×}ñ\à†¯ðW\Åö\Ú^¡{okql&Ž\â\í\ÜVnJü½A#\Ï\ï$\Û\ëTÕ»þ»{\n‡i›\èÖ´l\Û\É Š¡XF\ÛZA\Ø\r¿7\Û>¾y)(5â¾•\ìž.m¿\re\Çy…x\Ú\×g©¬Ejm9©µÀ\ÍB†¢†\éPÀmQ@Q@Q@Q@Q@Q@¢“u¨(¢Š\0uQ@Q@¸4P1(£\"ŒŠ5º\ÑKŒÑ¶€Š( Šv\ÃIH7Z)x\Ü7t§M·\Ìù:S”QE\09zQBô¢€\n(¢€E;h¤\"€y’¦Ó£b­‘\Å\0Y¼¶H1ŽIª•q”È¹<û\ÕQ÷Ž)\0ø\ã\ÝW£µ\n£ ƒ\ån•¤­•\0*Œ*ö‹¬\\xwPK\Û96L¿‘ªuw \r\ïˆþ<ºø…ug=Í´v\íoOÝŒ}k‹hYzÖ…Cp>Z`R¢Šr®\ê G\ãŠ—Q\Íò\Æ\Üö¦µ`\Ïhø_¶øg5ÁM\Í\Ë>~ƒF\Ünº¶\ê\Ýðõ»\é\nô˜\åZMÏ­ci\È^\é8\ç5\î\Ñø)½N—T\"\ÓGÁ\à°\Ípòü\Í^ó\àŸ	\Ùx¹ã°»ˆJ[ž¿…cürø5ÿ\0\nõm\î-\Ç¨%XZç©ˆ9r³¾žu!\Ï QO\ØkW\Âzl\Z¦µmÜžL~výv\Î;Rhamñ+§ñ­OcšQqvfF\ÜQŠ–N\ÔÚ²\Ù}ª=µ>\Úf\ÚM\0\È\ÃyŠT\í`Àƒ\èkoV\×5-m\ã›R¼š\í£]‰\æ±lj¥cm\æ·#Þ–÷jœ\Å@¶‰5È±¶(šo/…5Q¥,sÖ¥:žjU=>µ^3V#\å\ÔU 5|bÁ~°=LÂ¼}~\è¯[ø…˜|l7\É\Ç\å^H¿tWg©´©´\æ¦\×4\n¥7J†h¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0u›¨\Ý@^´\êjÓªYHuQHd,)*IY—¥‹K@Q@¯\ÝÝ›œ¨ Ÿñ¥_º+s\Ã~¿ñW\Ú\"°S+Û§˜bPI#üŠ”<\êU°E%Mx²\Ãq$3#$‘6Â­\ÔT¥PE34£­\0:Š( Š(h\Ô”Q@\r¥ZJ(B+­¶/@K6ww@w§)Á\Í!\éH	Lu­YCu¬œÕ‹y¼¾ø \r|\ÔOüU\Þ/§\ëMkµ9\ãõ f\ÅA#î¥™²¹\\±\ëŒPiñ÷¦S£û\Ô0$¨.¿Ô¹©\êŽaqUO\â}\âû?‚|7\nŒ¢+c\êaxnÕ®\ïW¥t~:_+\Ã^P¸\Î1Ÿø\rgx%„wC#©¯¦¡,yõ7=áŽ´\Ú?\í!oõ{\Ôûšû7ö’ø[Ž>½Ýº\ËqK(\Ú;b¾5Š\Îu{eO\å_||ñ]¿¾­¬øw«}1_+BT\'\Z±\Ù[–IT¥\È\Ï\Éû‹Y´»\éc`\ÑÈ‡§¥F\Ò4¹‰$ú×³þ\Òÿ\0‚üsv‹\È\Ý\Év5\âø\æ½%Oižf2—³\Ù;S*Ri¸\ÍzHóÊ–\ÖÑ®\08õ«¶\Z\\—M’6¯©­	ü6\r¨rô\ìK*\Ý\ì-¶)ùëž¸º\ÜI\ïV¯%y˜±5™\'SS\Ô\Æbz\Óc_˜ŠZ’5\ç5“,jj{u\Ý2¯½®\Õ\Üx§Ø©’\é@\êO+7Å‰¾‡¥\Úô\Ï\ÍúW–W¤|l˜.¥¦ÙŽ±[†?y½qVø\á°Ö¤¥4•\Ê\ÙaH\Ô5%HQ@Q@Q@Q@Q@\ÝÔ»¨h¢Š\0(¢Š\0(¢Š\0Tû\Õ%FŸz¤©e!\ÔSh¤1e\ê*\Zšn\0dz\Ô5D\n´´ªqO\Ú=(:*M£Ò£Ò‹€ÌŸZ\ßðwŽ5/j\Ý\é’\æ’33\Çù&¹úm0\'¿¾›S¼š\ê\áƒM3—b95\\ô¥¢€J:Ó¶š1@P(\0¡z\Ò\í¥\Å\0QE\0&\Ú6\Ò\Ñ@Š(´ªi( d\ÊØ§+u¦R­AD‡\ægÖ¥¨Þ¨Dt´”S$]\ÇÖ›\'1·zZµ¦ÙµýýµºŒ™eUÇ¯#5­%y¤\'±ô¯Žld›\Â~‘S*-c\Ë~ƒ\á›Y#Ÿiù}«Ðµ\ÍJ\ÛOðþ•aq´²Ä©ƒ\ì*¥¼v\ë£\Ë$q¨\Ü:_UF6<ºŒMG¹\ÆÌ±\ï_Q~\Ê~&]\Ä\é—BÝŒ¨\Ï…|\ÇðûT³}E­\ä\á¹\ë^\Ïð\Òú?\Ç\Ú{´ž\\~j\àþ5\åfôZL÷²šN\Ç}ûm|7MSC^?z£lŸ…~|\Éó@\ÉSŽ+õö’\Õ#½ðÀ±F$ƒö¯\Ïo\è#G\ÕY<¯-X\äW…“ó{5\Ìz™¤lp+n\Ý\nÖ¶›¥†\Ã\È5»o¡ù\ë¸\à¯b*=QSOŒ*õ¯ªQ>Vú™º–¥\ä\Ç\åÁ„Ç¥s\ÒJòY²jk¹¼\é\rU¦\âK}F\Í÷\rg¿Þ«ò}Ú¢\ßz¹\Þ\åÁ«¦qŠ…W5£e\å\É\éY´;”yp‘Vü3lnµh¨\Ü3Tn\Û\ç\Úz\ê>Û«j’JÃˆÐµEŠ\Üó¿‹W\ßlñ\Å\ÖR8\Äb¹\Z½\âk¦¼ñ6£3î•€ü	ª5ÁSsx\ì6’–’¹™b5%+RR\0¢Š(\0¢Š(\0¢Š(\0¢šM\Ô\0\ê)»¨\Ý@	E;mhh¢Š\0(¢Š\0(¢Š\0Tû\Õ%FŸz¤©e ¢Š)[‰„\Ó3·<â¡¥jJ²«`\ÓÕ³\íPÓ… &¢š¿tR·\Ý5 EMÁô§T–òù3G!¶°lz\àÕN;Ò­X¼¸[©ž@›6\âJ®hi\Z“4P@¢Š\0u\Ú2hÔ›©2i¥\0.\êP\Õ8\Z\0}!4”PEP2ZPqPÔ‹÷EID›©šLšu ·Ú€¾\Ôú)­ÀŒ­u_tó\ãkG\É¬‡ó\Çò&¹s^‘ðŠ³­\íþ0Àb3Ž¸®\Ú+\ßFR\ØûNø+g­5;\é\ÖuÙ¸\é]=×t9´³h-\Ñ\0]”sY|huoÄ’0Ü£}«V{¦n\ã5ôŒ\Þ\ïCÉ–\ç•\ß| \Z.¤n¬·¯$\×C¢\é·	yn]:0;…z\r¦¥¸ŒýkfÕ´÷ÁT¬\ë\ÞQ³G§„©\ìe\ÌM¬Lº½¬Jò\É+l.{\×¯x/L\Õm[\í©$À`69®\ÆI¡n\0\0\nÉ¾‘w2©\â¸p\Øu	\\ôqx\ÅZ\'\Éÿ\0d›Àºca1\Û\é\\ž\ÝK\Äqy±Z\ÈT÷ô?\Ä/\é:ß’Úˆ,Q²£Þ©\évöZ]´p\Û\ÛÆ±¯@W²©Ÿ=Í©ó\Ä\Ú]\Ô+‡·‘JõÈª-.r¤WÔ¿e±¾B&´‰ƒ»Er>$øGk¨\î’\Ë?e\åK™•\â«\Éw:·\Ã^\ÂvU…¤Â³\á	\ÔÛƒnß•r¼;µG3\r¹fõ­5¬¶ö ˆ˜\ßmvþør\âE’\íHv‘]ôš\r´–&‰Jªñ\Åf\è2•DÏœq|žµ\ÚxZQ¦\è:•óq²&?¥aø’\Å,õ¹\áAò«ð*ß‰\æþ\Åøw\"\Ñ\Ú=kŽ¢\å:!©\ã-!¹‘\æn²6\ïÏšZh\Ï\Ê1€)Z¼ªS¥l!¤¢Š\Äb5%+RT€QJ´´\0\Ú(¢€\n(¢€\ZÔ”­I@Q@¢›º\Ô\0\ê(¢€\n(¢€\n(¢€>õIQ§Þ©*YH(¢ŠCMjZ»q¡\Þ\ÛZ¥Ì°4p¸Ê³¢¬‚…*\ÒS\Ôr(\é÷i[\îš:P\ßtÔQTH\Ô´„\ÐE&ih\0¢Š(\0¢Š(\0¤¥§F»\É­*Ô’G\å±\Ú\0(¢Š\0(¢@Â¤_º*:‘~\è©eO¦QH\Ò7Jm\ÐzÏ\áûƒ’CÇ˜\Ìk\É}k\Ù-\":ƒt\è˜\á¶\î\ãÞ½>÷1©±\êÿ\0<N¿½µ‘‚\áøy¯w‘|Àv¯“>©þÔ¸¸ý\Ø\'?Jöü[´º¼’\Î\î@Ž§\0±¯£§%c\ËCeec\ÛÒ¬\Ú\É\"`†\"…h®6ºH¬v«\n»xnI&Y¤Ûœœ\ÕI\äÚ­#¶\0æ¬‹˜\áV\ÜG¥y¯Åˆ\èz<°@1$‹€jTâ™£§&®yW\Å_ˆ’Kâ¤µ†M±F\ã\æÏ½z‡eT\Ó\â‘x\Ú2\Ýk\å\ÝZ\áõ\Ù\'‘‹37\\×±|ñ¼ö¢\Â\àŒ¯&·E#ŽQ³=abòZž—L­\Ôâ§‘\ãž%t`CtÁª2Gµ«¢&RE\Ãt’W\'\Ô\Ô»\ä„_Ê«nÀ÷¦ù‡Þ©™XšmŒ1°\n¡|¿e¶’R>U\\ÕœŸ½Ú¼óâ‹\Þ\Õ,­\æÄ¤\å€=«–£I\\\Ö(óMbO\í/HÀp\ÏYŸ¯\ÄP\éºbñ\å®óqŠ\Òð­»_k‘»ò,Mp¿µ·x\Â\än\Ê\Åò\nùúò=*h\å»R59±Ú™^Tž§P”QFj\0F¤¥jJ\n]Ô”PEPEPšM´\ê(»h\ÛN¢€E.\Ú\\b€Š( Š( Š( Œš( &Š( c\ë{Tñuæ©¦\Ãg3*Øª=+Š7úJ(En9 °Áæ£¢•€(¢Š`5º\Ò5+u¤j\0m>™O^\Ô\0»}9¤Áô«úm¯Ú¥aœ\03Q]¨\Þ\ÊNh	2§ b™SI˜d#Q2•8#€œŒT\äSh \É!\äõ¦QE\0QE\0QE\nUûÂ’Þ¤Pú(¢¤Š(¦€}¼bK˜ôgP:öo¥\ÚÄ¿v8À\ãúM»]j–±/\Þi~µ\ëž0m±\ÇþQú\nôðû\Ì\é>C\ä\éw\×t\í?pW,šœ\×¹3“Á÷®ûGf\Óü#´²ÿ\0:óEWó3n¯IÉ¤Ž>]OD\Ñ>.\ëZ$¼”Ì qš\Õ?´f¦\Ì.WÚ¼¦{…X\Ê¸¬\Ì35‹«-\"µ>ªð/\Äfñm»9\Üw+ƒø\Ñp\Ï\å‚p\rGð/RFómØ€{f£ø\â\Ûn¢\\þ\Å\í\'Í©ônö7<‰þñ©,®§±¸BûH\éQµ35\è\Æm?8jz§ƒ¾+\ÜYÈ°Þñ€+\Ø4ŸéºµºÈ².\æ\Æk\ä\ÅlgšH\ï\ï-˜ù7F?\Ùj\èŽ\'—s	@ûÌ†UÊ²\ÕýF\ÏNŒ¼Ó¢(\ë“_+\Ã\ã-f\Ýv\Ç} \Ç÷Žj½ç‰µMAJ\Ïx\Î5·\×#b${_Œ>-Z\Ú\Æ\ÐX°w\é¸\Zñ\íKU›U¼k‰[s5c20$“W!Œ±Zã©ˆu\rcM\ï„BYi7·®q²3‚k\Ãõ+ƒyª]Ny\Þ\ìyú×°ø¶\èxwÀ±\Æ\åx¯\îMyuÎ˜«¦)\Z’¸Ù ­IE€(¢Š–EPEPEPEPEPEPEPEPEPEPE4õ¢€$¢Š(\0¢Š(\0¢Š(\0¢Š(­Ö\Ò\Ñ@\r\Úi\ÔQ@Žg‹;[nkkE³I¡2\È71=\ë\n·ôy¼»p;RE•B\àqXZ¨Ý¹F+VIŽ\ì\æ©\Ý|\êhŠ|Ë¶CÚ™LŠ( Š( Š( ¥R\"¶\ï­-Eô§+sÉ¤Pú)¥\Çnhó=¨g\Â™|K`üõ\Ï\é^‘\â\éƒ]…ó\\Ã´ó¼Ug\ìIý+³\×\Û\Î\ÖvŽ›ñ^¦\á0™\ÚjD[ø!¤­y²·?Zôo7“\ákTÝ¯3f*¹®ùlŒFÞ¸ý*?\nF“,s\Í¾\\\×#,\íþj‹c®\"–Û¸\Ö\ï\Æ\ËÕ›WŒü\0Šóƒ\r\ÂÈ¬Q”‚\nš\è|Iq&¯\åN\ì_5*=N\È\×j<¬\çO*;\ÒS±Ž)V÷8\äõ¸Ö¦\Zsu¦·J‰F\Ê)6Š}&@\ï\n\Ø\ÑmE\Õô1‘\ÍÒ²cŠ\ìüf&\Ôü\ÖH—q ¸˜\ß/ƒMc§¡ù O˜\nó¢º\ê‡Uñ%\ã\îÜ¡\È…s¬\Øú\×%G©²\ZÔ”QX(¢—	ET€QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0\Ö\ëE.( \ÑE\0QE\0QE\0QE\0\ÚCKH\Ý(2iV›J´\0\êµ\r\ÓGPqUh \ëz\ØÁ?­*\Ü\î\'5žI¤\Üi-\Ç2f££$õ¢˜Q@Q@Q@Q@QHaEzQøP3±øZ›üL¤ÿ\0\n]>¡—\×¿\ï?­s\n\Ôÿ\0\ÂA!¢®œ¯\â(”w\ë^žcžgUñ_+C²OU\æ³6½\âD›m­!\èUEy½\Ãs]\ÓvFI‘\ÓÕ†\Ü\Zik˜\×rXþ÷l\Ý\É\å\ìÝ•éŠ¦­¶ž­»\ëLC÷Tl~juG\'š	`Æ“4\Í\ÔdT±\ÍÌŠplv¤;Å–a]Ï‡ÿ\0\âO\àý[Qc´¼e\×aše©<WGñRõt_\Øi1ü²Jw°-—y’4³I#³Æ¡nµ û¾´\Ú\âž\æ\Ãi3KIŠ\Ìš\\š(¤À(¢Š@QE\0Q@ Šu#PQE\0QE\0QE\0QE\0QE\0QE\0QE\0QIºŠ\0}Q@Q@Q@Q@\r¤=)h S––@\"©8\ãŠ{E\éÖQRm>”…H\ë@¢Š)€QE\0QE\0QE\0QE\0QE\0QJh\Û@\×\ÂDÝ«\Þ\î\Äó­ý9·ø¢ÿ\0\ÏJ\çþ5Û¯O#úšè´´ó<Y;IŸÖ½,6\È\ÆF\×\Ä\Öÿ\0Hˆ\Îy\í\Çõ\ßüNùo¢>Â¼þ\á²\ÜWuMŒQ\Zô§ŠzSÖ¹\r–\Ã\Å>?½Q¯Z’?½V}G\'z’£›¥&\"\n7R7ZJ‘\ÜvjHðz\Ô\rVm\Æ\æ\Ïj–Æµ:Ÿ\é­}¬[© 9j\æþ1j\ÃRñ„±\Æßº·\0\í^\àUþ\Ë\Òõ\rJn8\Î\Ò}q^#ªÞGTº¸\'>c“X\ÊE¤U\'\å¤\ÝCRW+(u´\Ú*\0(¢Š\0(¢ŒPEPBõ¢Š\0u\rÒ›E\0QE\0P½iÆ€EPEPEPEPEP(¢Š\0—4f›E\0;4f›E\0;4f›E\0;4Sh ŒS©Ñ\Í@\Æm>”¡H8Á­(mÕ”gš›\ì\ë·\î\ÒŒø\á|)þLŸ\Ý5}c\Çj6\çµ+‡)Ÿöy?»L’\È\Åi\ìú\ÔsEòš\ÆCzRU\É!œ\ÕyD‘\ÑE\0QE\0QE\0QE\0QE;\0Š(¢„wð—þBÚƒz[\æk§ð\Ì~o‹ý\ï\ë\\\ÏÂ³¶\ãR?\Äbõ5\Øx.=þ\'¹¯W\r±Œ\Ë?c+|§Ú¼\Úc^©ñq@™8\ç\åRú{\×]MŒzŠ½)\ëMZr\×-‡µ$z£©#û\Õ@IQMÒ§5Zc\ÍK	\ë@\ê\0\ÍKc°Òµb\Ôp¸\ä\Ôa3[\Þ\Ñ\ÛR\Õ-\áQœ°\ÏÒ³“)\Þ>½>øwoj¿,·X\'\é^$£jû× |f\ÖÆ¥\â_²\Æ\ç\ìö‹\åªg€k\Ï\ËW,™ ”QEfET€QEH#¤W¥\ã\ÑKQ\"–\\ó@QVµ‚I·M‰Ž•V˜Q@Q@Q@\0\ëN¦\Ñ@Q@Q@\Ý\Ôn QE\0QE\0\Ê)\Ûh ¢Š(\0¢Š(\0©\Þ\Æ\â;8\îž	V\ÞF*“2\áŽ Z‚¯M­\Þ\Üiúd³³\Ù[\È\Ò\Å\è¬\ÝhQ@©!ûõKoÌƒ4†h~\è©ˆÿ\08¦Æ½3RR¹C\â›RŸ»M©¸\ì\Èó\íH\Üö§)\Z‹…ˆdvj\Äx­*­uT‘T+Œ¸¤§I÷©´\Å`¢Š;\Z\ÃwR\Ói\ËÒ™\"\ÑE\0S©´\ê\0)\ê¿52¤^´\Ð§\Ã‹\Ëñÿ\0L¿­v\Þ	¼NûX®\áü„/Gý1þµ\Ûx4ù~(_v¯_±”\Í‹\ÃlˆO ¯&“\ï~5\ì?­ÿ\0s™\ê?•x\Û7\Ì}s]5z-\ÉVž´Å©r›!qSC÷…GR\ÃLù>U\ëT¤oš®\Ï÷j„MK!NZ‰jU¬[f„ñv\â½#áµ¸\ÓôýGZ•p–¨vµy\í¬^c*õ=+¾ñ\Õ\Øð\Âûk$m“\ßü\ÏëŠ™2\Ò<7R¼mBþ\â\á\É-#““õª´¿\ÃI\\²((¢Š†ER\0j\ÜKºªT\Ñ1Z@M4{j»\01Š™œµDü\ã\ÐmIS­¬\ÈZŽH^?¼1LQE\0QE\0QE\0QE\0QE\0QE\0\Ê)vÑ¶€E7u¨\ÔQE\0QE\0QE\0QJ´\0m£mH«‘š_,R-´m©<¿z<¿z\0eMj@f¡§Ç\ãµF\ÜMò¯Ò¤Ý“P\ÂÛ”qRTšGq\ç\îše\rÒ›RX­MjZe¡¹ûµ5W³VˆhÍ›\ï\Ó*Y‡ZŠ™!GcE\02œ½)´\å\éLh¢Š\0)\Ô\ÚPhjEû\ÕE=[š¤aðÌ‘«\Üú¿­w^M\Þ+Q\ïýk\Ïþ¾\ÝrU\ì\ÑZô’¾,\çœW­†2™\Òüf!tø}\Åx‡ñW´ükùl­Fzÿ\0õ«\Åÿ\0ñ®š\Û#¹2ö©–¡^\Õ<}«‘\"E^3Þ¤Ž´\ßJ*ˆapÝª“sšžVª®jdr\Ô\ËUA«1sŠÉ¢\ã¹\Óø7Km[[´·p2\ßAÉª\ßµ\å\Ô|P–[\Ù\ÆÙ®\Ë\áŒq\é:n­­NŸ,0”Œ·÷½«\Ã5½Qõb\ê\îF\Ü\Ò99ükžLØ¢h¢Š\Â\àQEH8FYv¦Ó„„)^\Ô\0‹NGJe*\Ð·ZXùuú\Ó\Z•0}\é\Ô[Â¦SŠ\ÇÖ”,ˆI¥\å®*¥õ\Ç\Ú9ô¦J(¢¤Š( Š)(h¤\ÝF\ê\0Z(¢€\n(¢€\n)»¨\Ý@	EPè¢Š\0(¢Š\0(¢Š\0)V’•hUû¢M_º)\Õ\0÷M-6O»@ÒƒƒšLÑº¬ö·D½ªþ\î+<¹\íW$¼#\éRZ.\î\ÝIU\ã¹\r\íOóG­I©&h\ÍC\çZg@–\ÅUšA\ÍG$Ù¨$“Þš+TtQTfQE0\n(¢0¢Š($(¢Š\0)\Ê\Ü\Óh^µH«\á\Û\íñ\ï!\é>\\x°}My[gˆ­Ï±\ê\Ïü%©\ÏñW«…2™³ñÉ±md>¿Ò¼gø¿\ZöoŽ\ÜCf>¿Ò¼c½uW\Ø\ç,GÚ¦J‚>‚§Z\äF—d\ëósMjU;i­\ëTK\"\Õw©dëšŠN\Õ\Z\Z½jåš™%E%ˆQz\×cð\ÓC:×Š-U—0B|\é	\éYH\Ö&\çÄ©‡‚¾\éú:¿ú]ö%ƒ’:\åšð¦®\ß\â÷‰›Äž0¸!É·¶&(×°\Åq\r\\²5Š(¬XQ@\n¢‚(ZV\é@\r¢Š(\0 \Z(ª@.\ãF\êJ(\0¢Š*@(¢Š\0))h \í¥\ÛKE\0SwQº€E7u¨(¢Š\0(¢Š\0}Q@™¢€Š( œ´Q@¯KE\0\Ù>\í:™\'Z`FÔ”7Z*€§³\îZeŠC\Öf^”\ï´7¯\ëQQAD¿hjO8\ÔtQdcšB}©¹¢ŠQE0\n(¢€\n(¢€\n)\Z›š	E\"\Ò\Ð ¡z\ÑERk\Âryzý©\Î9\ÅzÏƒñÿ\0	ˆ\ãž+\Æô6kVG·˜+\Ù<:ªž0·õg¯W	¹MŸŽÿ\05½©\Â+\Æcù±^\áñ³Kº–\ÄÌ±3\Å*+\Ä-ús]\ÕÖ‡<K\n*A\Å5ik„\Ðr±¡€\Ð\Í\Å\0A#sLcœQ#|\ÜRu¬\Ø\ì>:õ/c\Âõ½vN$–#^¼ƒ^u£\é\í©jVÖ«\ÖW\Åv_5(ôm3MðÍ«\0‰yU}x\ëXÉGŒ\Í3O,’±%¤b\Ç>ô\Ì\Ð\Ý)+šQP\É\n(¢•„*Ò·JE¥n”€mQ@R­R(§ªæ•—­IREPEPHzR\Ñ@¢—mh(¢Š\0(¢Š\0(¢Š\0}ƒ¥-\05º\ÑKE\0;¤¯Q]Mÿ\0€o\íü8š\ä0™\ìI†¹]\Ø\Ï8¯eðw‰ô~\ëZUÖ¸±_Koˆ­d^¯\íHgqÛšr\Ô0ñ¨\â¤SE\Â\Ä\êÛ©i‘ž´\ìÔ€µŸzŸšd‡\æ¦mÖŠóIšwE&ih¸ÂŠ(¢\ã\n(¢‹€QE\\Š(¢\àQE\0¢Ž=h\ãÖ‹€M¥cIš	´´\Õ4¹¢\áah¢Š ,\é¬RþÝ‡Q\"×³xtÿ\0\Åy¥ 9ós^\'n\Ûn $\ào\îþ	„Mñ\Ã\ÊFw2šõ0\Í[\á>µñ‡§\ê:¶RÛ¡-Žk\à¯igAñeýŽ\nªHvjý\Ô\ìM\Â(dOJøŸöŽ\ÑÎ‘ñ¾Í‚TŒw¯N­¥£Î¤\ß5ŽF-\"°\"—5çž…‚›!\ÂÓ³Q\Êi0±\å9E%,3\0+\Í=\áŽ²\ê\Z­À\Þ\ÉKno\\W™x\ë\Ä\r\âO_^–Ü¥Ê§\ÐWªxšûþ/†	e—\×\ë¸\àò¯\nRvòrk	!Z’œ \Í.Õ¬‹°\Î\ÔSˆ¤\"¢\ä±(¢Š. £4QH“FM#u£4rÒŠf\ïz7{\Ð˜ºšY:T+&\ÞsJ\Ò\ïN\à5º\ÑIFjah¤\Í¢\áah¤\Í¢\áah¤\Í¢\áah¦\î£u(£4f‹ˆ(£4f‹€QFh\Í\ËÒ–‘Of‹Ž\Â\ÑIš(¸XmF\Öñ³‡+óŽ†¤¢‘CZ•i\ZŠH¦—qõ¦Q@\Ç\î÷¤-\ïL\ÝF\ê\0^h§dQ‘@\ÆÓ–ŒŠ2(h¤È£\"ôŠLŠ2(\r¢“\"ŒŠAh¤È£\"€\ÐZ)sò\æ¯j\Ööö¦\ØA7œ$ˆ;ÿ\0²Çµ\0g5%;\"›LB56Š($r\Ò\Ò--´´Õ¥ÈªT\á\Ô\ã8\æ½\ßÀ·B?xn\ìðcˆ1\çÚ¼!H¯bð\ÞeÎ‘.sòb½#÷Œ*\ë\ê\ÏüZ·—R0\êUg ^Eûj\Çeu\â-\"þ\Å@Žhs¹z)-\ìRñgc7‘±wg¦k\Çþ!xš}sT\Æwš\Þ\Ôl_·­zµ#óu<øG•œ\ätSñL\\…ëš”3\\2gbMF\çŠ½\ê&jÉ²¬(®“\áþ‚|C\â[8\n\æ\Ý\\I)ö\×3»Šô\ÝDð/Ã»­a\Æ\Û\ëÑ²œ=Ea&j‘\Ãübñ@ñŠ\Z8ú-¯ÈŠ:WK$#—v,\ìrXœ’i¹\Í…\Î(É¤£5›c¸õ¤jn\ïz7{ÔˆZ)2(È ¢“\"ŒŠ\0Ž’Š( (¢ŠWTµ>Ža¢Š)(¢Š\0(¢Š\0(¢Š\0eQ@´\n(¢€\Ð(¢Š@¢Š(\r\ÝF\êJ(wQIEu©(¤\î£u%\0»¨\ÝM\ÝF\ê\07Qº’Š\0“p£\"’’‚‡dR\æ™J½h\ÔQJ½h\0\Úi1O¤<\Ðh¢Š\0(¢Š\0zŸ–†û½)¥\rÒŒn”\Úst¦\Ð!	£u\rIA#•©wSV–€\r-4R\îª\Ë\ß\é^£ð¶\ä\Ü5Š÷Y‡Ò¼º6\æ½#\àšùúš\'ý5\"»p¯\ß2©±\ê—wy7\n‡i*À×‡]H´¦V9!Žk\Ý/c\Ûw4_\í^­C\äø‚õð\Ë^I©Õ€>J†Þ¦“\åS\\¬\Ö%I:šˆô¥‘©»¸\æ²l»\Z¾\Ðgñ&½ga\0\ËJ\ã>Ã½i|vñ—Zµ\Ð\íH[m>‚ô\Ü:\×að\ê8|\àS\ÅwXó$_.\Ô6:óœW„\êÏª\ß\Ü^NKI3–$\×4¤l‘h\Í4œQº±lb\ÑIºÔ€Ö\ÃÖ˜\Ýi($“põ£p5-\ÐÞ´»¨\Æ)»©X\äSh\å4¹ö¦­-K¹ö£u%†.\ê7RQ@ºÔ”P\î¤,s]/ÃŸ\Ã\ãZ\éS\ÞÇ§À\çt“I\Ð(\ë^\Ó\âÏƒþ°±º‡D¸mF\âðe œu œ7\Z7\ZY#1H\èF\n’)´\0»¨\ÝIE\0.\ê7RQ@ºÔ”P\î£u%\0»¨\ÝIE\0.\ê)1E\0:Š(¥r¬QE\r§m¢”u¢\áaBÑ¶–Š.w­5ˆ\Í+SZ;\"…#4\ÊZ@I‘JTkK@\îdS–\Ø\ÒdSh C²(È¦\Ñ@)¡ˆ\Å5zP\Ý(1¦\äPzSh3\nLŠ~G¥1XEa\ëKšŒõ4±õ¦HúU¤¥i€þ•\èŸd\Û\âü\Ü\×¶\ì\Ê>Zô/‚øKŽ‘\îýk¶†Œ‰\ì{Ý¯€5\íz\â\âú\ËOškP\Ä2+\ç/\Ã.›\â\Ûø®£hdó>\ëŒf¿Y¾\Üiú—\Ã]-ì¼¶R¬%\ïógœ×…þ\Øß²ý·Š´i|M\á\ë5R¶Ì“\Çû\Ãk‘fjU\Ý+t\'\Ø>^s\à«5WNin8È§YE$ñL»Y\ÒPE2é±œWªÌ¢Po½Wt-%õ\ÝZ\Ú\Â5%\ç`¹†y5A²\Í]—‡õ(ü \Ý\êr·—\nb€gx\ë\\òz\"\ÏÇ[#YxKJù4ý60$+Ñ¤#\æþU\ä£m>\æò]B\êk™˜¼’1%›­G\\¬\ÐF¦Ò·ZŒ±É¨¸¢£\Üh\ÜhLQ´T{\0I´R`S7\Z7\Z\0vM.\ãM\çÒ“u$¢‘~\í-!ŽZZE¥©¸\ìQIšW†\ÑHÍ´S|\ÃLC\è¦y†0\Ð\ZC4–ó	b‘\â‘z2\rz†¾0\\xoÂ’\é\Û	n\ßwúL‡\'šóÇšJI$ždŒ\Äò\Ç\'ñ¦\äSh dQ‘M¢€‘FE6Š\0vE\Ú(\ÙdSh dQ‘M¢€%^”R/\ÝR¸\ì-Üš2jJE7&Æ€EG¸úÓ·\Z\0–Šb±¥É jfÁJ\Ä\ÓriˆFi3JÝ©´\"ô¥¦/J\\š?&Æ™“FM\0:ŠnM4€uÜš2h‡T–\è²\\F®HF8$T94ª\ÅXJ\0¹wf\Öø\Ü6ƒ÷}\ÅU«7¯u·y\à*«L4\ÖoJkRPI$6ò\Ü+´q³¬c.Àd/Ö‘T©©-î¦·YR7*’®\Ö^Æ£\Í1¥_¼)™4n>¸«Š¸o\Ã\Ù,¦ñeµ¾¦»\ìdÊº\àz:û]§\Ã+\áÿ\0Š\Ói²:²¨h\Ã€y\â¼\ãÁ:}Î¯\âkX\í£óD,$›\æjzûþ\ézM\Ôs|dK•9ŠY\Óô\Çø\×}-”_ø{ñ\Ó\Ä_üAsml~×¦	û39<â½«Xý«/<m¦¾›Œ7	²F/¸GJùŸÄ–«ý¬\ç\'5©¤þ\ä&\Ñø\×\Ôpõdª\Ê:œ\î¬×ºž‡/ñ;\Ã0øwPy£C\å\Ìw\äw&¼\Ê\î^½¹¯xø¢Tð¸½,`}kÀ\Û÷\Ò\ï\éN¼Tv\Éô\ËO:m\Ì>E\ä\ÖWŠµO\í+ˆ\âR|¨IÀ­+Û¯°\ÛmVÁ\"¹Y$ó%c\êkÈ“\Ô\éˆÍ£m7mH\ÔÃšÅ”1…7ÒŸƒIƒP2&>\ÔÚ•”\ÔeH¢\âŠ(§p\nrŒži´ªqJ\àH\ßt\ÔT\íÆ›@/\Ý´\Õ<Q“R\ÊD‹KLV÷¥\Ý\ïR0jJB\Ä\Ñ\Í\06O½M¥cšJ«’.¥>”\á\Å¢\áa”S¶\Òm¢\áa(¢Š.\n(¢‹…‚Š(¢\á`¢Š(¸X(¥\ÛF\Ú.Š(¢\ábUû¢Šq¢¤aºÔ”P1wQº™š3@®:—u34f€¸ý\Ô\ï3Ú¢\Í(4.i)-F\Ò*–>\Ô\ÆR§k\ÃwÖ¶±\Ý °uú\n\ËÔ¤I¯\ås\Å\0T\Í©( \ÝF\êJ(Â–š´¹\0´RdQ‘@E&EÀx\éHÔ›€¡˜P27\ëBõ¤c“B\Õ–Šn\á\ëF\á@´$U\Üjî—¤¶©{\r¸aó\Ë1À<\Õ\Ø\Ón+H­Du>d^´òl%\Û3\äI,gklŠ‹Â·’\é’ù¼\Üg>¸¬^jöƒ!Z\ÓÛ¸¸ÿ\0B\ßE\êd\ÏrñmÔ‰\êphiLJ\ëX\Þ\"cý¥ùV¾÷V½˜lrKqúÒ›‹¡9ù×…,&\Ö\âr\ã9×»\ê\r¸\í^¸¯ñ–û=Zx3\ÎwZ\å\Äü%\ÓG?ªN\×R’3Ò²Ê•\ê9­	1žy¬ò\Ùb	\äW…&vXv\Þ3I¶”t¢²\0\Ú)6\Ò\Ñ@µFÂ¥=*6\"‘5%8\Ò`z\Ð1(£hõ41Á4(¦óG4\'ð\Òn¤\å÷£5,b\î£u&h\Í!V¥\ÝLSJzPn£u5©(ýÔ¡©´P1üzPh§D¡¤Pz@Q[w\Öv\Öö!\îlV9Z*X­ZaqD¶­Sš\0ŠŠnh\Íq\ÔSsFh\ÝF\êJ(QE&=\è´Sh .:˜\Í\éM\Éõ¢‹ºÔ”P!wQº’Š\0]\Ô+sIE\0J\r.\êjý\ÑK@\Å\ÝF\êJ(\0¢Š(\0¢Š(\0¢Š(\Z\n)v\Ðh”QEPM©\Z’˜EM4%(¤§¨ ¶Ÿv®®j­_O›¥k\Ä\Çzšµ¥¿—©Z6>\ì\Èñ\áUý~µ%Ÿü~Aÿ\0]ù\×U=Ñ“=\ËÄ£ý:j\è\íû±YÚ¬Fx\í>X«újyqŠö\á±\Ì÷q7úK*ð\Ï^}§\ÄW¯\èûk\Ú/fòZYO“^®^­B\ê]\Ù,\ä\×-\èkOs>\â\à\í8ª¡þl÷¤f9\"™šñ:ËŠ\ÙQKºª«Sü\ÃR\Ôn¨D¼Ò™\r\0+0\äT&œÍœ\Ói€SZH\Ý*\0mQLŠ(§pÇšMÔ²}\êmH…\ÝF\êJ0}(\ëÒMO»N dy4\äRP¿xP\"Z(¢¢Š(\í3²\à±\"¡\éN¦\Ð\Ñ]˜i·†j­E\0.\ê7RQ@…\ÝF\êJ(Z)ža£\Ì4}\Ï0\Ñ\æ\Z\0BÜš)( AE.\ÚLRQE\0QE\0QE\0\å\'¹4”Qr…É£&’ŠwrhÉ¢Š.“FM”®\ÃqÖœßš4”€—9¤j•¨M4­M @O­¤aI@É “ŠJ*®EH­šŽŸ4$]µô\æ´ªVf¯Š\Õ2DÉ«JZ\â/gÎª¯_Æ¯\é5\Òöýk®ž\è\ÊG¾[¨¹³¶q\ÈòÀ«Xò\ê?BLƒŸ\á\Í[š\×.ƒÔŠ÷\â­•\îpŸu!£ø~FVý\ä\Ù\\Wƒ\îo,–=kÒ¾4j[õD´V\Ê\Ç\É\æ³\Êp:×‰‹ž§E$C‘FE6ŠòÎÛ±Þ—½2Š4ûý\éw\Ôt¡©\è2@\Ä\Ò\ä\Ó(\Í“H\Ä\âŒ\ÒThdÑ“N¦S¸“FM%\\n´”\ê)\n\Ãi\ÊxQL,z‡Àý\Ã>4×¯ô=a\Z\ÛQ¹µÛ§\Î9S)8Á´\ï\Ú+ö{\×þ\0Í ]\\Ü®¡£\ê\ÊÊ—\n»Lr’Œ>+\Éÿ\0¶5\r\ê\Úv±¥6\Û\ë)–X\É\ésÏµ}[ñ›ö´ð\ß\íðøv\çE’\Ó\Å\Ðn\"\n»”Mf\Ã\Ô¹\â¢NI®U§R\ÒV>US‘\×4£5‹ù+uÏ¶*\Í]ˆ&ŒšJZc“FM%\0d\Óri\Ô\Ê@6Š(¤HQE\0QE\0QE\0QE\0QK¶Š\Â\Ð\Ý)›\Í!\ê-Üš2h¢›“FMa\Ô\nnM\nNhQMÉ£&€\Ô}R-p¥¤ZZ	\ÒqJ\Ô\Ú#P>\í&h\Ïpj]\ÕM9I\Å\0:ŠnM4\0\ê)¹4d\Ð¨¦\î¤\ÝN\ÂŸ¨²i\Ê\Ô\Ð\Zm\Í^V¬›iŠ¶J\ÐI\rj‰&_\ëWô¦\áûUŸ?Z¹§ü³\'Öº\é\îD¢¼&Dš\\þZÚ¸a¶i\ÏD\çò®\áû}£KŒg‘Z¾8¸\Z_„o\\¶\Öl*þ9¯}¿r\ç+ZŸ-ø\ïX“Pñ5\Ë1\à9ŠÁ\Îy«:½´©¨<’œ\î9\Îsš¨O¥|\íi)3®*\ÈuÜš2kˆ\ÒÃ¨¦\äÓ·{\Ð\Z]´sJi\\,S&\ã\ëL	2(\ÍG“FMH\ä\ÒSrhÉ QL,h\Üh\rG\ÑMM4£¨¦\î÷£uP\Ç2†\àŒŠ“K˜\é:•½\Ü +F\áøýJ‡w½#7½6|Uuc{¬4úzypH¡Š\ãnÿ\0­d\Ô{(cA#\éi™4n4RM\Ôn«\×ZÅž—m#\'“ppƒ<\Ö}°\í\Ô\Ú)\Z%ŒM&MH¬:ŠnM4‡QMÉ£&€°\ê)¹4d\ÐE7&ŒšÄ”Srh 5E&EŠŠLŠ2(h¤È£\"€•z\Ór)TŠ\0Ñ¶“4f˜‡QM\Í 	–š)Ô€1šM´´P(\íEjX\Ú)v\Ò)jHQMb)¹j”U>q(SÒ·/´\È-\áPŒ\Ð9“\Ô\ÒT’©Y\"£5 ¹BŠLŠ2($‘d\ÚÀ\Õ\È\îBÇœsYùõlµq`w\Þ°²ñŸunKEy™ù¸\éô¬\ëX\Ì7JŒ0\ÊÜŠ‡\áÖª\Ú‰¡\n¡–e1¶N1žõ»¯X­®µòC¶~•\ÙHÍž\Ïð¯\æ·\0ô¨>8jB+UnZM\Äf¬|-\Çö~\ïjóÏŒ:¯\Úõ\çP~UkÖ©.ZV2\å\Ö\ç™\ß(½M\ÅpÃŠÅš-±[}8ª\×H\Z3\Åx3\Ü\èFE1&E`1iW­&E;\"‹JÔ”fŒ¢\Å#cmH¬%\ÜÑš?&Œšfh\Í¨\ê)¹£4\"\Ò\Ôaˆ¥\Þh(V¤£u&EQ\"\ÑI‘FE\0-™dPæ–›‘Fhc#2ª–b«\ÑI8S2(\Ý\ïRPúF¤\Ý\ïFh­ICž”\Ü\Ð!\ÔSsFh\ê)¹£4\0\ê)¹£4\0\ê)¹£4%\Í\æŠ\nET–QE\0QE\0«Ö’•z\ÐÖM^´\ê\0(¢Š\0rô¥É¦­-!XI¼\ÐÔ”]\Ôn¤¢˜[\Æ&b¥¶ü¤Š…ŽG4«I@¦\Óö\Óv\ÐöWF\ÞU=El^j©q\Ú8\ï\\þæŸ¸ú\Ð\×MºEúUr\Ýhf\'½6ª\â¸QE´”U¦\ç‚\Î<Meþõw>\"ÿ\0¸®O\áå°›^IJ±© ú\Z\Ü\Ö.ü\Ë\çmÛ¹\Æk²“2g²|8—\É\ÐeœS\Íx×\ïþÙ«Lû²7\ç^³\áyŸƒ%s\Þ<šðýZo´^H{?\Ì\×mIsEE?zŠ|yMŸJ°«ò\Õ÷òø¯2e¤e¿\Þ?Zm-%`PS\Å2œ)0šJ)7Ri\Z“4”€(¢Š`QE\0QE\0QE\0QEPQ@Q@QH\ÑIšZ€\Z\Z’Š\0F¦Óš’˜	ES\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢“uªŠM\Ôn ¢“u¨h¤\ÝF\ê\0x\'\ëK¸úTY4 œ\Ð+“\ÑQ«)ôr\Ò\Ó¥/ð\Ð+ŠÔ”q\éJ¸ô ¢Š(QE\0Ý§ÖšTóO\ÝAn\r‘­&M+t¦\Ð1ÁY²B³Ô…$\nnjýŽµq¦\Ù\Ü\Û\Äp—\rY\Ôvh\Í6Šzˆvh U\Ý.\Ù&¸Ä¿w«[Œ\í<;fš•ö‡o\ßL0\Æ{\Öd\Ód\ëŸz}\åñš0€\åWš§o\Ëþµ\Ù3\Ù>\×öO\03g£\ÅxÌŒ³õþu\éž(º6þµŒoZóm©\å\ß¤¥ \ì7~\Õ\Îk\'P“sT\×\rg\ÌÛ³\\“e\æŒ\Óh¬@vh\Í6Š\0vh\ÍHb\æŒ\Óh©\ìÑšm\0\ìÑšm\0\ìÑšm\0\ìÑšm\0\ìÑšm\0\ìÑšmÀvh\Í6Š š3M¢€š]\Þô\Ê*?&Œšn\ê7P=d\Òn÷¤\ÝI@‡fŒ\Óh C³Fi´P³Fi´P³Fi´P³E6Š\0(¢Š\n(¢€\n(¢€\n(¤ ¢™š3A»©ÁÏ­Ašr\ÐR\'^”¿\ÃøTj\ÄR†ùH¤$¢’26\ÕR\Ì{\nVù[ƒ\é@\Ã4fŠJ.h\Í7u©u›‡­‡­\Z5=)¹ö¡¾õ!ª	º’ô¦\æ1ôS3K\Í1\ÝZ6-´û\Öm]µ<¥Z(\Ôßžõ5¸ý\à\æ©+U»3ºE\ë¡\î<mu»Ãšl@ÿ\0	þ•ÁI!X\ë¢ñ5Ã½½œe²ª§Ê¹[\Éü¨r­\ÃóTÙ³RHÅ¹¨\rs±\ØZ)™£5$¢™š3@n£u6–¤ ¢Šiú\Ð+¢™š3@‡\ÑL\Í \ÑL\Í \ÑL\Í \ÑL\Í \ÑL\Í \ÑL\ÍªôS3I‘KQ’QL\Í¤!ôRR\Ð;8\Ä\ër¬œ\Ç¢\ÍN÷’\Én°3f59\è:)™£4}\ÌÑš\0}\ÌÑš\0}\ÌÑš\0}\Ì\Ñ@¢™E+šX}\Ê(¸X}\Ê(¸X}%6Š.\n)7Qº‚l-9i\0\È\Í( --Ò–‘V-\éwKex’º\îPzTºŒ\Ð\\\\I$chcš£Eº\Ô\ÊJ.\ê7Ss\Í.\êC\r\ÞÔ»©” \Ó\ìûR1\ã¥&\êLš\0F¦Òµ%(R¯ZU\éKTM‚­Û¶\Z©1\Æ*Å»U\ÄfŠ*þ›\Ì\ë\ÇzÍ¾QZº*‡¹\\Ö©ˆ¿\â\'ý\äIýÕ®Rñ¿yŠ\èu\é7^þ\Ísw‡\ç¤Àª6\ïO\Í6²P½)Y¹¤\ÝP+E*ò)\Ô\Â\Â/JZ(¤0¤n”7Jf\ê\0Z)7QºXZ)7Qº€°´Rn£uah¤\ÝF\êb°´Rn£u!\Ø7Qº’Š.Fi7RQ\Ì\nJ(¢\à>ŠM\Ôn ,>–£\ÝF\ê5´Rn£u°´Rn£uah¤\ÝF\ê\Â\ÑIº\Ô…¢“u©ˆZ)\Ûh ,6ŠM\Ôn¨5ŠM\Ôn ¢“u¨h¤\ÝF\ê\0CÖ’‘¨Zw ‘O¹4ƒ¥H¿tR\ÓU¸»©x4¹¨÷Qº€°\êJM\Ôn ,0““FM©¤ É£&’Š\0\\š2i( ŠMÔ›š\\šn\ê7S\rJž3UªXŽ*\â\É4ü£·¢ÿ\0®RkÕ¿¤¸š»W_›ý/9\Ç4…\ÎkGZ”µ\ÑÉ¬–84›‡\"›¸\Ò\ZJ\Î\à;h£h 7<ô­mC\Ãó\é¶1\\\Ê\é²Q•“HfP\ã¥.M%ArhÉ¦fŒ\Ð!\Ìx¦Rõ¥\"‹€\Ú(¢\ÄQE\0¢Š(¸QEÀ(¢Š.EQp“FMR\0É£&E\0QE;€QE\\Š(¢\àQE\0¢Š(¸R\ÑpŠ(¦ü\Ê)”PE\"\Ò\ÔQE\0QE\0QE\054fš\ßxÒ­$^\Ô\êbö§æŽ¥¤´\\ ¢Š(¸™£\"‹€\Ú(¢‹’RdQ‘@E&E\0\ÆûÆ“4§©¤ 4fŠ9 \çÞŸ\æ›Bý\áL\rKnksO}±–¬+Oº+f’«¸ŒMNM÷MŽ™ªMS\Ý6\é\Û\ëU\Üõ¤\"3Ö“4QR0\ÜGzžKû™$“\È\è:+6EAE qõ£qõ¤¢†h\ÍP©æ•\Ú(\0\Í¢Š\03Fh¢€Ñš( 4fŠ(\0\Í¢Š\03Fh¢€\nJZ(ƒ4fŠ(fŒ\ÑE\0£4Q@h\ÍPš3E\0fŒ\ÑE\0*Ÿzû\ÒQ@¢“uª\ÈŠ\0‹KLRirk&]‡QMÉ£&\ØuÜš2h¢›“FMa¬>cBŠ	9£&¨‘Ã­;5M46\ê7SGAE+–;u©›¨\Ý@\ÝF\êmhº\Ô\ÚM\ÔhII\Í\Ò…¢“š9 ,-œ\Ñ\Íah¦\äÑ“@Xu!\ëI“J¿zš\Z–£\å±\'\î¬\É\ïŠÉ³\çh­JM¶˜«\Î\È\ß9>ô\Æùª\Ú\Úùœ\ÔS[l¥Ž\ÄEG½\ÇRƒh÷£h÷¢ŠÁ´{Ñ´{\ÑEa´SrhÉ¦F£¨¦\äÑ“@j:ŠnM4£¨¦\äÑ“@j:ŠnM4£¨¦\äÑ“@j:ŠnM4£¨¦\äÑ“@j™£4™}-74d\Ð-GQMÉ£&€\ÔuÜš2h\rGQMÉ£&€\ÔuÜš2h\rGQH´´\ÄQE…\ÒhÉ¦\ÃQL\Üh ZZh4»«3Ah¤\ÝF\ê\0Z|’D@*0Hj=\Ôn ¢“u¨­%Šw$(¢Š.‹\ÐR\æ£\ÝKº‘B\ÑIº\Ô\0ú)™n\0¤\ÑIº\Ô\0ú)™dP\è¦\Ñ@¢›J\ÊS ¢“u¨iW\ï~”©÷¨@l\é\Ãs-;^›n\Å\éL\Ó9\"£ñÅ§D†jÀ-\î„qŠŠ\æa ô¬ý\çÖ“}@cIº›º\Ô\0\í\Ôn¦\î£u\0;u©»¨\Ý@\r¢›šUª$Z(¢•À(¢Š.EQp\n(¢‹€QE\\Š(¢\àQE´”QL\ÑE#R¸	“J\r6•z\ÓiT\Zr®jeŽ•À‡\Ë4›O¥Y\Ðc‹VŠ|‘\í¦Qp4n¤¢¨B\î£u%\0Œ\Ü\Òn¥\Åh7QK¶Š\0¥-\"ô¥¨,(¢Š\0F¤\ÍqŠn\ê=ii«N –QE\n(¢€\n(¢\Ü(¢Š\áEP0¢Š(\0¢Š(Ô´\Ý\Ôn \0ž\Ôç‘¤\Æ\ãœ\ne\0QE\0úUû\Ô\ÍÔ¡¨½£®\å\ÏaYº«î¼“\Ø\â¬\è÷<Ñž“\ÍfM!–BÇ©4\\\ZJ( AEPA \Z	 BR¥¦µ•i)h\ÔSriV€Š( Š( Š( Š( Š( Š( QOÛ»\ëS:f\\\Å\0AH\Ô\æS#š\ÔÀm*õ¤¥_½L1.j}¸\Ûe,x©[\Ó©:)\ÍMn”\Õ\rM%Bi€QJ(\Ý@	E.\êJ`QE\0QE\034¹¦Qš’‡14›­%\0\î½y¢›FhÔ¼šf\ãORh\0\æŒÓ¨¤y£4\ìS\0¹£4\Ý\Ôn¦³Fh¥\Ú)\0™£4\ZJ`.h\Í%\0ú(¢•Àm \ÒSsFi( \ÑM\ÝKº€ŠpŒe\Æ6ƒƒ\ëLj@I\Í\í§†\rFÆ“4S†h\Í%\Ãw½½\é­Ö@)£4\Ú(‹šL\ÑEŠ2)´\nÃ²(\ÍE!\â€š3L\Í~h\Í%\\ÑšJ(sFi( \Í¤¢€4f’–€Ÿ\ëºk\ß9®b¬E©M{Šc&\ÖR\à•\êk;5$“4¤–\ä\Ôt2(\Í&\Ú6\Ò\r–·&\È8\"¦i·óÞ³\ÃNó\r\0\\\ßF\àj¯˜hó\rbYqš®\Ô\âÅº\Ó\r1Š´´\Ú(¸®£4\Ý\Ôn c³Fi( B\æŠJ(ÿ\Ù'),(_binary 'ÿ\Øÿ\à\0JFIF\0\0x\0x\0\0ÿ\Û\0C\0\n\n\n\r\rÿ\Û\0C		\r\rÿÀ\0ú7\"\0ÿ\Ä\0\0\0\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0\0}\0!1AQa\"q2‘¡#B±ÁR\Ñð$3br‚	\n\Z%&\'()*456789:CDEFGHIJSTUVWXYZcdefghijstuvwxyzƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\á\â\ã\ä\å\æ\ç\è\é\êñòóôõö÷øùúÿ\Ä\0\0\0\0\0\0\0\0	\nÿ\Ä\0µ\0\0w\0!1AQaq\"2B‘¡±Á	#3Rðbr\Ñ\n$4\á%ñ\Z&\'()*56789:CDEFGHIJSTUVWXYZcdefghijstuvwxyz‚ƒ„…†‡ˆ‰Š’“”•–—˜™š¢£¤¥¦§¨©ª²³´µ¶·¸¹º\Â\Ã\Ä\Å\Æ\Ç\È\É\Ê\Ò\Ó\Ô\Õ\Ö\×\Ø\Ù\Ú\â\ã\ä\å\æ\ç\è\é\êòóôõö÷øùúÿ\Ú\0\0\0?\0ø›mjO..¿B±ñª)v\nx\\Q¶•‚\äl¢“mJV“Ë¢Ár=´m©<º<ºv‘\í£mI\å\Òl¢Áq›h\ÛO\ÛK²‹\Æl¾X§\í£m+\Æm»i\Ûh\ÛE‚\ãvÑ¶¶´X.7mi\Ûh\ÛE‚\ãvÑ¶¶´X.7mi\Ûh\ÛE‚\ãvÑ¶¶´X.7mi\Ûh\ÛE‚\ãvÑ¶ŸŠ*’Æª\Ò\í§š]´\ì[h\ÛO¢‹\Æm£mIE=´m©)(°\\f\Ú6\Ó\è¢Áq›h\ÛO¢‹\Æm£m>Š,¶´ú(°\\f\Ú6\Ó\é6\Ô\Ø.7mi\Ûiv\Ña\Ü`QK\åŠxZ]´X.3\Ëø­\Ì\ÎzšU5M›XÁX.Ky¢\Íc\n\Ì\ì`|§}ê—–*\ì\×/0ÁbG¦j¢Â¹\\­7mL\ËL+\Í+\äl´Ýµ)ZO.‹\ÈöÑ¶¤ò\èò\é\Ø.1Wšv\ÚP”»iX.4/4\í¢”/4\ìZ,\×\rh\Åp¡FMQV©…r\Ü\×{—€Õ™\"\îbOZ¶zj6X.U)I¶¦h\é›iXw#\Ú(ò\ÅI².‹È¶\í¢¤+I\å\Ñ`¸\Ê)þ]];ÆŠ]´¡ivÒ°\\n\Ú6Ó¶Ñ¶‹\È\Ùi6Ô…3K\å\Ñ`¹\Ú6Ôž]];\ÈqIS2Sv\Ð+‘\ÑRm£m¹=¨\Û\íRm£mr=¾\Ômö©6Ñ¶€¹jM¾\Õ3-7mKÈŠ\çµ7oµO¶š\ËJÀE·Ú¾\Õ&\Ú6\Ñ`#\Û\íF\Ïj“mh°2{QR2\ÑE€»E-± ´\êE¥ .›ih .4Š)Z’€¸’eT2q^‘\'\ì·ñ~\ëÀº7‹t\rE¬\éz„-9Ž\ÎMòÆ \à3Þ¼\ÞXÌˆW‘‘ŒŽ\Õ\Û|;øùñ\à\ëZÇ¡\ë÷o¦A\"¹³’C±€=\rL“û%\'fy\å\Í\ÝÆ“zlµ}>\ëI»Vdhn\â(w£š½‰—r|\ÃÚ¾\É\Õþ.|0ýµ|\'m¡|@\Ô\âð‰­®<å¼¶„=8\Â#§\\×|Zý…\àðO„µ?|4ø‡o\ã\r>/>\ëMb¦X\â\0|\ÃŸ~+i­¤¬ÿ\0®¦\Ê1–¨ùûn8<Pj–™|·\Ñ\çG,˜¼¶\Üj\æ\Ó\Ínbî‚Š(¦MÂŠ( .QEp¢Š(…Q@\\(¢Š\áEP\n)E:šˆ£Ú—oµ*\Ò\Ó‘•¤©\Z’€¸Š=©vûR­-q»}¨\Û\íN¢‹\Æmö£m>Š\äei*F¤ .2Š}\Â\ã(§\Ñ@\\eú(ˆ´úR¯J}q›\r.\ßju\0Ý¾\Ôm4\ê(»h\ÛN¢€\"?JeH\Ô\Æ\ëJÁq­IN¢‹\Â5-ÀŸ¥+)^)\Ð\Êab@\ÎF(f,Ù©Œ\Å¼\ÒP\nLŠ\Z’€¹$}x©•OT0\çwJ´\r\0&\ßjB¾\ÔüÑšB\Ê}*6\\v«\rÞ¢“µ«º\åûR\ÇÒŸ“\é@Ú£©XTx .%´PF\ê( q£&Š(\ËóUˆ\á\Î8¨#ûÕ¡ð\ÐiqÊ “\ÍJt4\Çjhpµr;„\ïJ\Â9­F\ÈÚ¶1\ëT¶\Z\è¼A¶Kx\Êõ\Ýý+i¦;h\ÛSm4›}¨-´m§‘\íI@\r\ÛA§PE\0GF\Úv\Ú]µq›i6\ç½I¶´\Èü¿z<¿z“mh°\\‹\Ë÷¤\ÛR•\à\Ôt¬;+E9ºQE€·E:Š\ÐCiwR\Ñ@\04´«K@jmH\Ô\Ú\0Un¼Qõô-:€ ’\Ö)[h§+Ž0}E{\'\ìƒñŸEø/ñSS>.…¯|5¯\é\çL»—\nBTõsõ¯\"ÇµP\Ö,V\ê\Ùò:\Ô\Ê*I¦i4\Ïvý·¾xo\à¿\Ä\ÍRðƒIg øš\Éo\â¶N6\'¿ìœƒŠñU\áx9öwÂ–ð\×\í\çðV\Ï\á\æµ<Z7\Ä[\Óo14*08\'\'¶k\ã\Ïx/\Å_\nüq?…|g¥M§=´\Íºx\ÈY\Ð<\Å=0q\\ô\ê[Ü–\è\Þpr\\È«Em\ëVZU¼\Ú}\Ã\ÎÅ†w:°\Æ<¥cWQ\Ê6Šu\Ä6Šu@6Šu\0\Ú)\ÔT€\Ú)\ÔR´S¨ \ÑN¢©\0\Ü\Òî¥¢˜\r\Í\ê(–•i\Ô\0\Ê)ôP*\î\Í;\Ë¨:Ó¶\Õ/8¦T\Ì>cQÔ€\Ú)\Ô\å\\ö è©¼¿¥/—ô§` ¢¥e\íL †\Ø/J•z\nbô©09¡\r	E;Z8õ¦P\Ú)\Üz\Òe}h­òŽ”\Ý\ÞÂž\Ø\Ç\Ú@F\Õ\ëS7Ze E:Š@6Šu€m§QH\ÑN¢€I«\n\ß-@½)ôÀ—uª:3LVMFÍ¸\Ò\ÑHNµ%0.\î\0\Éö¸+Á š£©š™Hc(§Q@\r¢E\06Šu\0±}\êÒ·Š£\n\îa[š“6­´*ÅŸ¦Pˆ›€p3Un.^5ù}k\Þ<5ðd¨\ßBÛ˜d¶8®\ã\Ã|<W©’\Ö\àö\çm<\ÚIžo¾\Ù\ÚrÓ©EEH\Ô\Ú@EL©Hö¦\Õ!1”T±\Ä\ÓH¨ŠY\Ø\à(h’†FI£©ÁVŠb\"\Å#\n’‘‡µ@\ÑNÇµm\ê(”Ú—\Ê@1ºQOn”R\Í\ê+P¸\ÑK¶œ´\ê\ã1Š)ôPI¶¤¢€¸\ÌQO¢€¸Õ¥\Úm#ƒNZZ\å¯ø»[øG\ã\Í#\ÅþUK\í>a! •{«s\È>•ö¶‡ûZ|6ý±-O€þ+\è6ú-õ\Ùò\ì¯þ\áŠLpCƒ‘Ï½|:rF3Yú–ž\ÓFd€˜\îS\æGQ\È#ž+	Ñ„\Ý\Ú\Ô\èG±\èŸ¾	jŸ³¿\Å9ü\'{¨WN–º\Óo1þ²\'o=\È\Åq&¾¥ý¡5+OŒ¿²\Âß‰¨Ÿñ7\Ò.°/\ä\îv£uü@ü\ë\å¤\åA\ëE9]Y“Qj.)h¢ºL„\ÅE-\n\âm`S–¶ôµ\ÒÆ™pn²n\Û\"?A\Ç\Ì-¢´ö\ëM¢Áq6Ñ¶–Š,‚\âm£m-Y\Ä\ÛF\ÑKEp\n\r.ÁBÓ¨\Ø(\Ø)\ÔPhm´Ph£h¥¢€¸˜qCSh‹MÀ¥¢€¸mõQL©€¸ý´£>\ÔLDl¢™´S\Ø\Ó)¼RQ@…\âŽ)( \âŽ)( ¤±Ò“\Ì4´R*\ãwf“ŸE ¸\ÌQO¢€¹RTM .6Šu\Æ\ÑNÇµ}¨‚ô§\Ò\ÇJ\Æ\ÑN¢€¸\Ú)\ÔP$³¼“O¹I\âÿ\0X)—Ou;\Í\'.\ç&šØ¤ .16¤jmq´S¨ .6Šu\Æ\ÑN¢€¸FpÞ•\é\ßüEý†\ÑÎ±£H‡?0\Íy¤xV\Íh[j\ß\î6(õ¹ñn\ÞóIY ŒCw­´ñõ\Åx\×\Ä/\Z]kVnò³+u\æ¸\ÆñÌ»L‡N\âñ®-š\0¢´´\ìJ(\Æ\Òm§\Ñ@\\‰…F\Õ;w¨Ú€¹%…\äº}\Ü7P0Y¢m\ÊHg\èiú†¡6©{5\Ý\ÃožV\Ü\ì\0?AP/JZ\0aZM¦¤¢bŠ{u¤ 56¤jJ@5{\ÒTŠ:\Ó6\Ò¤QJ\Ý(¤­´m«63jW)º4’1\áTWIªø\ãI€<²e±ÊŽ\Õ`rx¥©\î-»`\Ô\0QE\0QE\0QE\0R\ä\ÒQ@*ŸnÔ”P4}Cû\'Z\é_>øÿ\0\àmö¤ºv­5\ÃkZ \ã2J%F~+\åˆ\í\îtÛ«½>ðb\ê\ÎV‚PF>e8?Ê»o€^$¸ðo\íðóSµwŽF\Õb¶}ŸÄ’Œ·9ü+¤ý¬ü;m\á\Ú;Æ–Ö‹²‹¦º\Ú8¤b\Ä\éÖ°»7\æt=Q\åcš(¢ºŒQE\à\Ø\èH¦\Ñ@\ni(¢‚BŠ( .QEp¢Š(‹š7RQ@\ÇKMZu\Òn¥jm\0.\ê7RQ@šJ( Z]¢‘i\Ô\0›ih¢‚X»©3MjJ)4”Q@Q@Q@Q@ÂŠ(©ap¢•jWA¶\\†Š( b56œ\Ô\ÚQK@Ó©–€\nLŠ\Z›@f\ÔÕ¥ \ÝF\êJ(3I“IE\0-%PEPEPEPÑ“IE\09M-5i\Ô\0»¨É¤¦\ç\ßõ \î4n¦¯^µ\'’\Ø\Î(65aœfº\ßø\ï\ÆZ ¶H¤1Ÿ¼\Ê:â¾µ\Ñ?b\ÛCÂ¨\Ó\é““Ve\ëž\Ä\×<«\Â”¢\ÙðöiwWMñÀ·ž\0ñ5Þ™t¬nBn\ëŠ\æ+h\ÉI]	«\ni\áI¦\Ç\Ëb¯.Ížô¢\ÔÚ’o¼j:`#Si\ÍM¦­%*\ÒP7J(n”P°|#±¶°\î\Ù7Í€›øs]‹\Úˆ\Ý8\'=k‚ðÞ¾ºl,\r\ïI©x M¹CgŸZ\0\æu¥ÿ\0Ha\èk*´µ	„¹ \æ³h\0¢Š(\0¢Š) \n(¢¨Š(©`QE 4<#¨C¡üDðf«;l†\ÇZµšF\Î\0A ÝŸlW½ÿ\0ÁG<ªøg\ãE—‹­­\Ö\ã\Âþ$‚6¶¾Œ‚\ä‚G†¯šõ+\íF‹$£¾\Êø3\âyj/\ÙÅŸ5\Ãö\ßøF\í\r\"c€\í\Zg?\î’+š¥\ã%$uS÷•™ñ\änA\r:ªØ‡HDr.\Ù#%OfEZ®”c$QEY˜QEQE\n«Ö€))\ÍÒ›@Q@\n)v\Ò-:€\î\Òn¥jm4”Q@\niv\Ò-:€\ZE%>“ð e»ý.}-£Y\ÕA’5•v¶~S\Óñªµ©¬J\'†\Õü\Ó#ˆ•NOLt¬º”´”&i(¢€\n(¢€\n(¢€\n(¢€\n(¥\ÛRQKŠJ@ý\Ù\ïL¢©\0QE€(¢ŠC\n(¢Q@\Ô\ÚsSh)š7V¶“á‹½b–m\Õ\Ûl.\ZW¦\nZAK@	¶›O¦PEPEPEPE9T·JzÀ\Í@PFjÀ³BjXôöo\á4\Å»i\Ã=\0\É>•r]=×œV\ï€\í”xŠ\ßÍ‰dP3‡E!ò›¾kþ>¸O³\ÛK¹\ë!C_Cè¿³-®bú\Â+©\0\Îù\é^\åû8ø‚\Âk¬fX``pq^±ñKµ·³&6V>ò\×,ªkce|\ã?ƒºcÃ²\ßMH$S»tco\á^Kw\àB\ÆøÄº\\\Í·\ß\Æk\ì_Y<\íçžµ“¤Yý²g“v;b¹\åRFŠ\Ãýô\Ë[i\í\ÂZ+:‡\È÷¯\Ñ\Í\Ò\Ð`R•ò‡\ÏjøW\Ã&]_*¿\Ì:W\Ù?üX/txQ°J¯­y8…);£x\Å-\ÏÎŸ\Û\ã\Â?\Ù>$þ\Ø[fXdo™¶\àW\ÈÎ—¡\Í~\Ó|ZðŸ†¾$Z½Ž»¦ÁueJž¦¿4?i\ï‚\ZW\Â\íz9ô@ °•ˆò}+¿RQŠ‹9\êG[ž\Z8§o>´\Ú+\ØZœ‚\ÓZ–‘ª€mih \éM¥cI@Q@|\Æõ¤\ÜOzJJ\0\\\Ó\r;4\Ú\0(¢Š\0(¢ŠhŠ(ª\0¢Š)\0QE\0«\é^\Ýûø\Â/þÔ¾Š\áü»z)´™Á?+\ì\Ï\ãŠñû\Ô\Øu{\Ï\ëšN¿a(ŠóL»Š\éœckƒý+*R‹F´\åfv?|7\Ã?Ž4ðÜ¤”¶\Ô$x[\Ìlr¿¡®>¾¥ÿ\0‚ƒiöú\çˆ>|G±ý\Å\Z2¦Œ|2“Ÿ\\*ùk\"•9sE6]EfQEns…\êZ	¶—m-M´b–Š\0F\éM§7Jm\n(¢€i\ÔÕ§P!(\ÛKE\04ŠJsShVMZu\0QE\0QE\0QE\0%´PR\ÑE\0#Si\ÍM Š( Zu5i\Õ mÀQNgÜŠ½… F)hª@2Š(¤À(¢Š@QE\0QE\0#RRµ6£CO\Ö\'\Ó\×j;ôV\ÅG}x\×\Óyœ\ã\Õ:~h((\Í#ShÛ©´Q@Q@Q@*©jJ±j¹j\0·go»¤¶±¯ðŒ\Ô6\é´\n¹R\Í\Ñ¯N)\ÜzQE@\ÄhÕºŒ\Ôö7‡K¹Y£Ub?¼*\Z‰±Þ‚\Ñ\ì¾ø™q¥\É\é0‰—œ/ÿ\0^½3Pý¤5MJ,\í#’ölàª®•|“o|\étª®Bæ¾“ø\â-;\Âz¤7²\Ú\Ås  \æQžâ±’\Ð\é‰\ÓC\â\íR\êe7š5\Ì{\Ç\È~µ\ëžð/ö…œz„a\ã|e”Šú3\Â>6ðÏ‹ô5¸–\Î\Õ\ÐYvJ\åüA\âio<6…!\rü+À®\ÉÉ´\âÑ§*<sÄž[?ôø\ÎH\Ý\Ít¾\r\Ô5M©ok;¢t<â¼¯\Ç\ß\rž²m\á¹\ß\ì\í\Íw¿	|c­}{B‚GÍšÓ\ç\Æ\Þ\Öe\Ð\Þh.9UwnRsÖ¾;ø\Å\àýc\Ç÷é·“\Ü\ä¶yú\×\èô\Ú\Û4VÚžfG§\â\ZÇ‡¬\î5\ç‚X#G\Î8\0W<ZoBeó#\â?\Ã[ß‡·¬»åµ›\î\Ì\Ã?Ý®/\'Ö¾\Ýý­4û\'ð}\ìF52B\ã`96?•|A\Ò1\Îx\Íz\Ô\ÛkS†bƒ\Å&\êjô¥­Ì…É¤¢Š\0(¢Š\0(¢Š\0·L§f›@®QE¸QE\ì0¢Š)Š\áESQE\0QE\0«Q\Þ\Ç\çZJ\Ùp*E¥#p\Å\"£¹õ\Â\Ýþ\Òß±±\á[«·¸ñW\ÃÛ—¼\Ó6¹­\È\'\ËlŽW–\é\ÏšùN¸kˆ>q¶E%]}\ê+\Ûÿ\0b¿‹üøû`·ò•Ðµ\ïø—\Þ\ÆÜ¡ò©?BEf~\Ö	Ÿ\àŸ\Ç\íwJŽ=š6¦\ß\Ú\Zs¯\Ýh\Ü\äô5\Érn/\×üÿ\0¯3²^ônyu*\ÑJµ\Örµah¢Šb\n(¢‚XQEF\éH)[¥\"\Ð\í£m-\0˜¥¢Š\0(¢Š\0J6\Ò\Ñ@	ŒR\ÑE\0QE\0QE\0QE\n(¢Š´´‹KM#RRµ%&H\Ý)i¥\06Œ\ÑE\0/4\êjÓ¨\0¢Š(¸¤§56QREPEPI¶–Š\0i”\æ¦\ÐPQE(¢ŠRŽh\Û@\î%»\ZJÕ»\ÍT\"¬\Ùü´†mC\Ðb§*œ.jÚ·&ˆu›³OŠ’œúUi²\Ê@«x\ÝP\\.\Å&‚Œ¹ae ùõ\â»ø\Ði±¨s¸Š\ànØ³gÞ’&;}*¹n>kBiÿ\0´¶¥ X½µ‹c$’sÚ‡\í	¯^3H\×\ßÑ³Šòz\æš\Õš\èW¶:»Ïˆ\Z¶±©‰e\ns\Î\Ò@þuôÁŸˆCMh\î\ZR\î…rªk\å%}¬+¬ð‹Np\áÛ‚8\0\ÖN6Œ\Ó\Üýyøkñ»AÖ´\èm¥&R c\Ô×‹~\Ðþ>¶ð\î­%ÅƒòÍÙ¯‘´?Œ¤”˜N\èS\æj\â~&|c¾ñuÁG(\Þ-š\äŽ1›’\êm9$‹_¾*]x¢\Î{77˜ùm¹g5\ã5b\â\á¦ffbNj½zPVG™7v”m´V†b`QKE\0%R\ÒPµÓžK?´F7(84Tp\êÁnÐ©ù\çPQEV (¢Š\0(¢Š`QE\0QE\0QE\0QE\0*Ó©«N ¤S\Ô-Yš)bvŠX\Ø::œGC_i\ëÑÛ³ö^¶\ÖmR8¾\'ø6‰\ã_¿s \É#©\Ü3øŠøÝ¾e\Åu_þ2k?³\ï\Å\éò“§<‚=FÓªO	\áŽk–¤n¹–\è\é§.‡\r¦\ß¥h\æ_*\æ6),g‚¬:ƒW\ë\é?Û§\àß‡¼?\'†þ-øGü#,[˜\áû‘N\Ã=ºg‘õó\\2	¢V*©MM]\n¤GQE\Ð`QEQ@	F)h Š( Š( Š( Š( Š( Š( Š( Š( °¢Š(TSü³\éImnj\ÃH¥)Tj)[­% \nF\éKH\Ý(´QE\0*Ó©«N Š( jm9©´\0QE€(¥ZZ\0m­I@QLŠ( ›ih©`&\Ú6Ó‡4m¤qKK¶´\0”Ö§‘Škv -Mo\Â\Ô+RÇ…\\\Z‹\Ñ\ÉV\ã“ug«r*x\äëŠ“K—Õª]\Ãýz¢³*O7Þ¦\Å&Zó=ÿ\0Z§u8\äw¥2\í\ïT.³74\Òei›t„ö¨þœT¬¹\æ£e\"©\Ütlphe=E7ø\Z7Zb#Ö£W\'¡©\ÄRÜ¶È£y_²Æ¥\ä*²©V*À‚8 ŽEK/\'÷\ÛZab(¦µ »\ÑEHQELª1Ò˜ˆi¹5e\âÀª\ì»M\06Š( Š( QEYEPEPEPEP@¢•z\Ð\Ò\ÑE\0QE\nŽ\êšVÈ©)zðjZ.,ú\ãöD\Õ,?h€>4ýŸu\Ù\ãT³ˆ\Þ\è7˜1\ä\0O£ƒ±5ò‰ü?®|#ñ…çƒ¼ac&›ªÙ±Pò)(\ï/¨4iž Ö¼\â[xv\âKMN\Í÷¤‘’3\ÇN;W\Ü~ñ\Ç\Ãø(w„\Ó\Ã>8‚\ß\Ã­m‚\Ûj¡v˜?R8¯>JT$\åÑ±´Õ™ñ\0eu‡p<ƒEküaø+\ãÙ\Ä\Ói,\Óf—H‹mZ%&	<a»v5‡ip—‰#!”ó\ÅvÂ¤f´9ªSp%¢§ÒŠ\Ô\È4¤P´5°”QE…(”\å\éM\0„RRµ% \n(¢€\n(¢€\n(¢€\n(¢€\n(¢‚‚Š( aEPHQš( AEPEPEPEPEPIKE\0%´PR\ÑE\0”´PQKE\0%´Pb´´T°÷h\ÝJ\Ô\Ú@8\ZZjÓ¨:ñHE/ñR\ÐA¥W4\Úh 	Ä§uH“Uu\ëOZr\Ï\Ú\r;\Îj®\r?u;\É…º\ÓwSwQº€¸¼Trw§Q½q™¦æ•º\ÒRC\×.|=¨¥\í¦\Ï=Q¼9=\ë:iš\âi%¿#8õ\'4´\Ê¢Š(\0¢Š(\0©Uª*b€,ù™\\Uy)w{\ÓX\Ð(¢Š\0(¢Š\0±EUQE\0QE\0QE\0\n)W­\0RSš›@–š´\ê\0F¤¥jm\0>Š( \ë\ÍUh\îtû\Èu\r2\âKB\ÝÐœ2ŸQV¨¨i3E&}qð/öÃ°ø¹£¯ÂŸvú–‹u‘k¬Ê¿½I8U,ÄžpO5\âÿ\0´ÿ\0\ìw\âoÙZmw\Ã\Ï/‰>\Þö÷Ð“!‰H\Ç\ãÏ¦+ÈµM9urŸu³\ÊpAö5ô—\ì\Óûk\ê\ß\rcƒÁ_ Oxxþ\Î\ëržcB¼\0\Ù>\Õ\Ã*r¦ù©ý\Çd*)+Hù·L\Õ\à\Õ-\ÖHÛ¯OP}+Cha_Züiý€ô‰:e\Ç\Ä?\Ùó]ƒPI®f\ÑD™Lv§£{\Zø\Òò÷Tð~±&‰\â\Í.\çAÕ¡;Z¸\Ê\ï\ÍkO§ NXš»qE\ÖE¤2žAWj8„\ÛK´QNZb¶°SÂƒuYhÀQÒ‘&k\nmX¸À\éU\è\0¢Š)\0QE Š( Š( aEPPQE\0QJ£4\ï,úP@\ÊU]\Ç¾]:8þj`YMiqƒQ\ÝX½¨%ª\ì7FqP\ß]›…Á9\æ€3è¢Š@#Rn¥jm\0>ŠAÒ–€\n(¢€\n(¢€\n(¥\Ý@	E.E€Š( Š( Š( 4›©Z›RÀ\\\ÒQE Qº’“\"€w\ÍKº›üT´\0„\ÒPh ¯Zz\Ó­9h\â—u3uª€~\ê7S7Qº‹€\r1›5¥¢\ØÇ©^e‘b]…·;­P»„[\ÌÑƒ¸) H·Rn¤¢\Zm+RPPQE(¢Š\0)\r-#Pn£4”PEPEPŠ(¢¬€¢Š(\0§-6@ih \ÛF)h ¤\"H\Ý(´»©( š)@Q@Q@\Ú;TW±\Ü\ÆRA\Ü\Z––‘Iš¿\r¾\'x\ç\àOˆZðV³qo°|ön\Å\ã‘s÷J÷¯³<9ñƒ\à\ß\í\é£\Çá¯ŠzTñ\æÀj–\ê#b\Ø\ãz}\é_#`\ÖuöŽ“H“\Û\Èö\×Q¶ø\æˆ\á”ú\×\\:ž«FvS­Ë£=Oö€ý‘¾#~Ìº¤me7Œ< ùh5+8™\Ù¨ß·¡\Åy>‘\â+-a•2¬\Z6\àƒ\éŠúg\àgü7\Æ	t¸|5\ã‹¼c\á\ÐDBk¥\Ý$q\àŽ½øõ¯Y\Ô>\nþ\Ìß¶„?mðN¬¾ñB\r\ÒJÀdÿ\0	‚3\é\ÍbªÔ¥¤Ö‡O³§S^§Ä›A£nu¿fß‰_²Î \É\â>Mk\ÃÒ’`\Ö-’=¹\à»òœz\×§\êöš¤$+gª÷\×N²šº9*Qq.+\íÏ¨§}©Z©µÑ£9¬+¶\êa´@¬%QH’ö˜±\Ï*‡\\ciþt—\ÞN\àb]¾µYXª\àt¤\Í1‰I¶E1\r#ŠJst¦Ô”‚Š( aEP\ÔdŠ²ª1\ÍUNµn?º>”Àv\ÏjcajSœTw¤I\ÊzT{+u¤¦ ¢Š)\0QE\0QE\0R¨É¤§\ÂÁ[š\0F]½©µjg]¾õV€\nn\êu2€u.\êm\0fŒ\ÑE\0£4Q@h\ÍPEP\ZMÔ­M¤æ’Š(W­:š´\ê\0n))\ÍM¢À;u(4\Ê*@µ&i”PóFi”PŠ\ÛzR3n$“še\0´”Q@Ô”\æ\éM ¤QE\n(¢€\n(¢€\nJZ(¦ÓJm\0QE\0X¢Š*\È\n(¢€\nu6@EP\ZMÔ­M \ÝF\êJ(E.\ÚE§Pb–Š(\0¢Š(\0¢Š(Ô´”µ@%-%6H\ÒA‡Ua\Ó\æ¬\é4U·ž;½:GÓ¯\"mñ\Ën\ÛpÃ¾i\Ò\ÒqL¨\É\Çc\é‚ðPMg\Ã:_ü!Ÿt\Åñ‡„®\0·–\â\á’$^‡\'ž+±øûü<ý 4{~\Ï>%Š\ÇR¸Äƒ\Ã\ÓJ¢\ê»@,‡ñ\Å|u41\ÜDc‘©\ê¤qSx7\Å^-øC­\roÀú\ÕÆ“x§&\ä\"6õ\ã\é^}L5Ÿ57fwS®ž’*x£Oñ7Â¯K\áÿ\0\èwZ¡²	\'ˆ¬R`\ã*OQS[\ÜEux¤Yô*s_mxö½øUûSx~üwðý®›­”Á¬¼j©¼Œoó*søW”|tÿ\0‚tø³á•½ÇŠ~\ê_ðœxE#óZ”M0\è8n=+8b7\ËQ\ZJŒjkÀ6\Ò¬[_/›N\Õ\í\'\Ñõ$û\Ð^!‰¿&\æ¶Õ„‹‘\Èõ¯F3RZ§(\î0ŒRS™iµFC¨¢Š ©3JÔ• QE\0QE\0QE\0*œT\ë7^Š\0±\çS·d\ÔY¢È¤jJ(¹!EPEPEPEP\0Nh¢Š\0)”úe\0QE\0QE\0QE\0QE\0QE\0›ih \ÛF\ÚZ(1Jh¤n”\0™¤¢Š\0(¢ŠV\0¢Š(°QREPEPEP””§¥%Rf‹E&h ¢Š(\0¦\í§Q@¢Š(\ÝQV@QE\0QE\0QE\0”m¥¢€mih \Å-PEPEPEPƒKH´µH¢’Š\0Z))h”»KE)\Þ\évúŒ{f@Þ‡¸¯Jø+ûQüLýœ/\"]Q“Zð\îð\Ò\éWN]03À\ÏJ\àhúŽ+)ÓEfaQÁŸs·Œ?g_\ÛóK‹Kñ%¤>\0ø‰+ôø£H¤3Àõ®§Zù\ï\â÷\ìñ“\àŒwÚŸ‡\ã‡\Æþ…‹Á%›nš,ðJ\×•\á÷\ZL39–-\Ö\×8ùfˆ\íe=r\rz\×Áÿ\0\Ú÷\â\×À\Ûø\rzoh1°Ý§\ê2´€ þ\çŠó\Þ¥\'zoN\ß\×ü¾5\ã5i#\ÆmüDRõ¬5[Iô}I\Z\Öñn=>S\È\â¶\\ƒ‘\í_|Ì¿\0\à¡\Ú[-ø‹ÁŸ^0\Ò]&\Ø\å\Ü0 n?{ \ã­|yñ\ÃöQø£û0\ÞK&©`úï…fUµ@±ƒ\Õÿ\0ºpEU<N¼“VdÎŠ’¼N(ŒRUM/Wµ\Ö-\Ö[i7«\r\Ø\î*\î\ßJôc$\Õ\Î	E\ÅÙ¦\Óù¤Çµ2F\Ò\í¥¢‹\0QEÀmQREP@QE\0QE\0QE\0QE\0QE\0QE\0QE\0QE\0RR\Ñ@\rjJsSh\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(†“u+ShQ@X(¢Š\0(¢ŠLŠF`«’p)±\Í¹\ØÁ¿\Z‘¢Š(\0¢Š($)ža§\ÔT ù—š6ûšHþ\í:€#aƒIN“\ïSh\0¢Š(\0\Í.M%\0\áKH´´4Š)ZŠY¢Š*\È\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€ii–š\0¢Š)€P\Ý( ô Ð½h¥j@Z(¢¨¤ \ÔR\Ð4R{9­oûN¸’\Âú2&…ŠœŽ+\ë\Ï\Ù\ßþ\n¨iQü`|C\áÛµ\æö\äoeC´\çªý}+\å\nŠ\æ\Õ.¢(\àF+ž¥TVh\è§VQg\Õß´\Ç\ì;c\â7Ào²k>º…§º\Ò\àr\ÍCˆ\Ôž\Ýx¯Ž\áñ–7\í¦\ëvshºœgk[\Þ!³ô<×°üýª>!þ\ÎwÁt{Ÿ\íM¤W—Kœ\å\0Fzu¯¬¤Ô¾ÿ\0ÁC´g¶\Ö-¡ðG\ÄQ\è›»c\Ãs\\«‡zê¿­ÿ\0\àö…U©ðF\î2\"›]?\Ç\Ù\çÇ¿²®·ö?[6¡\áÉ–\ÏX„F\\ü»›±\ÅrV—q_[¬\Ð8’6\è\Ë\ÈúW}:Šj\è\ã\'}´”\æ¦\×A\ÌQE\06Š(©\0¢Š( (¢”+7E\'ð ¢\å¸*@úSh\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¤¥¢€\ZÔ”\æ¦\ÐEPEPEPEP0¤\ÛKE¸›i6Ó¨ \í¤§\Ó(QE€\ßð>—g«øŠ\Þ\Þÿ\0þ=/ƒÚ½\ãã·†þ[ü\Òn¼!pø†·$)\ëŒs\í\Î_6\Û\\5¬\ÂD$0ô8«·šõ\Í\å»@\Ì|¶\ê3Rh¢Š(\nMâ–£o¼h$w˜)”Q@\îÓ©±ý\Úu\07S|±N¢€Ë´Siò}\Úe\0QE\09ii–‚„j(j(aii–¬€¢Š(\0¢§‚\Æ\â\ëýT,ÿ\0AD\Ú}Å¿ú\ÈY(\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€ii–š\0¢Š)€QE\0QE\0QE\0QE\0´RQ@÷¸5&žö·‰a<–—±6ô’#ƒ‘Ò´{\Ñ\ÅCÍ£\'\ì\ßÙ§ö\Ï\Ðü{£\Ãð\Çã…¶¥§\Ü\'“m}y‘Ct\É\Î8\Ï5\åßµ7\ì=¬ü¸Ÿ\Ç\Ïü$^¹c+\Ãf\Û\Ú\Øs€O\Ëô¯ž/´˜uüŽ§!—¨5ô\ì\Ëûbø‡\àž¡‡¼K\æx‡Á—gÉž\Þ\ã\"CÕ…pNŒ©¾zq\Û\nªJ\Ìù\çIÖ Õ—÷m‡y†QZ%k\í\Ú+ö ð÷ÅŸ¿\Å?7‰,ò\'u¢\ÂWw;@\è\ÃÒ¾µ\Ô.mn\çÓµkv\Óõ;fòæ¶˜mua\ìkZ5\ÔÑJ6wF¼7\"’»N6¬&\Ú6\Ò\Ñ@F))þ””¬@E–@£©8¯pðŸ„¼-§\é¶\ïvZ\â\å\Ôð¹\âp·•20\ìk¿²ñE·’Šó\"\à‚ÀR-[©\ÐxûÁúj\é\Ò\Ý\é\Î0¹\Û^5^•\âO[O¢›8#k^jij7`¢Š)QE\n(¢€\n(¢€\nMÔ´\Ê\0]\Ôn¤¢€u&h¢‚ƒ4fŠ(QE\0QEQE\0QE\0QE\0QE\0QE\0›ih ¡”QE\n(¢‚Š(¤À)6JZ)M£Ò£©j*4»­%\0ñF}©)h(?\nJZ(”R\Ñ@	Iº•ºShsE%iii–¬€¥_¼¾™¤¤ ù\î#³µ†8~Q°@\ëT®®<\èH\Î\ã\ïYCX\Ê@NJ¨^MP;iB\áJ\Ì\Üb£§K\'˜å©´\0QEÀ(¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0U¥¤ZZhŠ(¦EPEPEPEPE.\r/–}\å@	IRy\\Q\å\Z\n\ée·K„!†i0WÚ¥©c;‚?´w‹f\ßC{¥\\\Ëu£H\ã\í6IF\\ó_\\ü^ø\àO\Û\Ó\á¸ñ÷\ÃCm§üA·ˆK=º·–\Ò9F¹\èk\à¹\ã!\r]Á¿Œ\"ýž|qi\â_\Ì\Ï¶Û›F$¤¨NH#>\Õ\ÅZƒ—¿\r\ÝJ·I,kªøW^»ðß‰lfÒµ‹6(ñ\\‚	Á\ÆFkS¯\"¿E~&|2ðüC\áHñ?…\æ·\Ñþ#YBy{|\Æp>\ä€rW¯=¸¯Í‹‹]_Á(¾ð¯‰­$\Óõ›\"D‘L0O=F{Z(W\æ÷e£EV¥z& †\äsI]çŸ°´”´”#RdÒµ%K\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¤\ÛKE\07m%>™@QAH(¢ŠQE\0QEQ@Q@QJ\àQE+€QEÀ)\ë·E4\ÕûÂ·4øQ\Ôf™f.Þ¼Sjö­†\èÒ¨\ÐK\nUR\Ç­­\ÙÅ¾@}\èÈ¬d“¢\Õ\å\Ð\äÙ¸ƒÒº$TV\ÅjÂ¨\Ãi\0\nžsqnÐ¹b¡®³ÄšbF¦E®M¨(£4PK\'Þ¦Ó¤û\Ô\Ú:–’–‚‚Š( aEP7Jm9ºSh\0¢Š(\ÊÓ©«N« (¢Š\0(¢Š\0(¢Š\0(¢Š\0(¢Š\0U¥¤ZZh›ih¦m£m-\0›h\ÛKE\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(CI½]>q+[EsÁe\ï\Å$’	dg\Úq\Î\Ñ\Ð{U \Ôñ- \'*)¥¥\"\È?\Zv\ê@3m¬\Ã\Ý\ÃÖ€úS6‚¤A§³8¦SÎƒ\á\'\Å\Ï|ñÅ·ˆ4‰cTa\æÀ™)\"÷}+îŸŽ	ü/û~|µñ·‚#¶·øƒb‹$\ë	#\áîœ|c5ù\ç\"‡\à\×}ð?\ã÷ˆ?gOE¬\è\Óî±‘\Â\Ý\Ú>JI~\ë\\\è\ßß‡ÄŽú~\Ë<¿n¡\áR\ç\Ãþ\"´›N\Ö\ì\äò¦¶¸RMið\Ã#‘_¢ÿ\0þ\nøþ\nð\Â/ø2htÿ\0Ál\ØX\ÙD’H0|¹G\çƒ_›R\ézÇ‚5û¯x–\Î}7X´c\Ãr…ãŒŒõ¨=\é\á\ëóû¯F:\Ôm\ï\"õQ]\ç\0Ö¤§56¤¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¢Š(\0¤\ÛKE	¶ŠZ(”R\ÒPh¢ŠQE\ÝF\ê)(ôQE \n(¢¤Š( Š(ª@*ý\áZºt\Ä2Œ\ÖH«v“yrO\Ë,\ë–ì¬²x¬­µ©ª^	\áE\á³ú\ZÌ –\nµrÅ¶\É\ÏJ¨µ$rmj\0\ë-.]¤ô«jÞ¹H\ïŠw©¤}Z‚}jôInWÛƒ\\‰«·W†e\ÇJ£@˜QEQE\0›ih ±¤¥jJ\0(¢Š\0J6\Ò\Ñ@\r\"ŠV¢€,ŠZ(« (¢Š\0(¢Š\0(¢Š\0(¢Š\0U¥¤ZZhŠ(¦EPEPEPEPJH”´\0\ébh[\rÖ™SG—³¢ ÌŒBŠŸW\Ñ\î´;\Ãkv‹ÀB¶\áÏ½\0R¢Š(\0¢Š(\0¢Š(\0¢Š(sOW5\0ò\Ù\êi7Sh n¤É¤¢€™$i*\á\ÆG¥:Šs¬ø3ñ‹_ýžü_o¯xz\å\Ä;óqd\Ì|©¿ÛÆ¾\âø\Ùð‡\Â·\ï\Âx¾ x6T°ø…§[‚ð\Ä@óH_¸\ã¯\Ð\çµ~w\É‘a‘]ÿ\0À\Ú\ç\ìù\ã\ÛMgNœË§¼Š.\í’¯|Þ¼\ÜE\r}¤4hô(VÓ–G™\ÂÚŽ‹«]hz\å»Y\ê¶ncš) \â´O5÷\íyð7@ý¤>\Ú|køcn\Ò\ë¨ö•®	t\Ü\ÅG;ð^—ö¨\Ê8):|²#oCZP­Î¬÷&µ.]Q£IG¥\ÜpQ@Ô”­IRÀ(¢Š\0(¢Š\0(¢Š\0(¢Š\0P)vŠ\î\ÑL¤4\ÑCu¢ÂŠ( \Ú(À¥¤ LmQA!EPXQE,Š(¤EPM\Í:™T€\\Ó·S(¦·Rn¤¢‚X\í\Ôn¦\Ñ@‡\î¦\ä\ÒQRPü¨¦¶qÒœ>\è¤&\ã\ëRTT]\ÇÖ\ÇÖ’Š\0x&—u6–‚ƒ4QE\Ô7Jm\0;u©´P“E%nŠ(« (¢Š\0(¢Š\0(¢Š\0(¢Š\0(\ÍPš3E\0QE\0 \Ò\äSh QH´µ@QE\0QE\0>)Z\Ð\á”\ä\Zžÿ\0QŸS¸3\ÝJ\ÓJF7&ª\Ñ@IE\0QE\0QE\0QE\0QE\0QE\0QE-0–E;q§ŠŽHVe\Ãt©Z’¥•c\ßc_\ÚR÷\à?\Ät\íBA7„5?\Ü]B\Üùdžs\\ýk¡ÿ\0‚€~\ÍP|?\Ö-~,x\Z5¹ð~»\"›¸\íùŽ\ÞF†þƒ_-\Ü\Ç\æDGZûoö\'øý¤ø\Ó\Â÷Ÿ>$\ï4›ø\ÌrÜp#o>‡>õ\äW¦\éO\Ú\Ã\æz´j*‘\ä‘ñ•ò^B®„Fx«U\ÛþÒŸ³Î¯û/üVŸGx\Þ\ãÂ·Œe\Óu\Èd\'\î“\ê:W®¬ ©È®ú5E¡\ËV›ƒ’–’ºA\Z’•©*XQ@=Ž(¢Š\0(­Ÿ\n\ê–z>©ö‹\ë_µÁ°¯–}Oz\Î\Ô%Škû‰aM‘;–Uô”ŠE|\Z1H[\íP\Évª\Ýj%.]Y´i¹;\"Ò”QŠ†;¡\"ƒ\ÐÔž`¨ö‘¦\×A(£­¢l\Ä(¢Šw`Üšu(Œú\Ô\ÊqSHS•Gdˆ\è©\n\Ô\ÒeGz\çxªk©\Ûil†QCHƒ¿oVŠ®C£5þÍ®U_¶|\Ø\Æ9ô«I—P@\Ï\ÐU\Ç	=\ÎY\á*Aj‚Šv\Ó\éI´\Ö\êI\ìs8J;‰EU›E-\0\ÓIJ\Ýi*À(¢Š‘Q@QHŠ( ¨ªZŠ€\n(¢€i\ÔÕ§PR\n(¤ c7Ñº›EU‰¸\íÔ´\Ê}!…QHeº(¢¬€¢Š(\0¢Š(\0¢Š(\0 QJ´\0»h¢Š \n(¢€\n(¢€\Z\Ýh¡º\ÑR\0)Ô˜4´\Ð»O¥>”ÀJ(¢€\n(¢€\n)\ËCPh¢Š\0rŒ\ç\éš\ï?\á\ÒN“\ç­ü\Æ\ç\ËW \ã8\é\\\Z6Ö­4ñ\äq”Y\Ò6Ÿ¥\0fÈ¡X\Î)”\æm\Ù=óM Š( Š( –’–˜¢Š*ˆŒÑŒR\Ò7JC\Z\ßt\Ô0\Íq¦\Ý\Å}g3\Û\Þ@Á\â–3ÊjzF\\Ž•”£Ì¬m	r»Ÿ¡?üi\á\ï\Û\Ó\à•\×\Ãˆ\ìü[§Á‹;\ä]œÏ¶}«\à/x[ø/\ã\íWÁ^%…¡¾±•–9`M~W_PF9kÀ>:\Õ~ø\ËNñ.;\Ãqg(rªxu¡¯¼¿hï‡º_\í¿ðNø‹àµƒþ­\Z\0\×0CÌ®¡rñ0=yJò-,5O\î¿\Ïþ	\ê«V‡™ù\î¼ô¥¬\Í.úV-ky[\Þ\Â\æ9apU•‡}\ëO©5\ëFJHó\'­INjmQˆQE\0QE\0R­%Ö‚\ÄaÔ“ŠÃ˜„\Ý\ëGR¸ò£ u®y\åf<šóq³±\êa¡Ì®i­\Î\ÜU˜\ï\Îks\àv©\ãc\ÅyÒ­cÓm\Í\è\îÕºÔ†t\ÇZÈ‰½\é\æ_SK\ë³Z\Ç,§7vhý©)¦ñ+?\íÖ—w½G\×*>§bÊ¨.†‡Ú‘º\nO9C\ÅTŒMž\èD‡\ÍsÊ¬¥»:á†¥Od:\ê\è\ÇÕ¿Z Ú¡\ÏZÎ½¼y˜óUU\É\Îk&™·2[-“=ô\Ë\ZX\×Wg¥Ám\n–œõÉ®gÁ 5\äŽO*µ\Ö4˜c\Ï5›v4Œ\\‰¿\Ñ\ã@>\Í\0‰i&\Ô@U‚%\ËU\Úb:\Ôåš’¨\Ñk\î‰dº1\'\åPm‡\ÜÁ¥¦1\Ï\ëh\âgtÊ–[FH^› qQ4e{T\Îv\Ô~`\ï\Ç\ã]\Ð\Ç\Ëfyr*røt#\ÚE3w5+2ú\Ó½*X¸\ÏFxŒ¦­uªIKI]\ê\\Ú£Ä”\\]˜QE\È$Ž?3¾)¬»[i3I@Q@‚Š)GZ	Tr}\áRµ:\×u¹A\äP\ØX=ô\ÞZŽz\Ö\Ä~¸“¦*úS\Âz…üG\àK-FW·†ò3°*\ìGb°FO\ÐzU\ë\Ù\ÝF¬°ª\äzVr•\ã\Ñò\Ü\Þ¼‹$FH\ëX÷6m!G\r}U¬x%!f\0WüJð\Ê\éÐ™\Ô~•*W\æ9 \ã4¹4\ÃQZ£!¦’—md	O¦\Ó\Â\ÒcBQN\ÛE\"‹4QEYEPEPEPEPš3E\0\áÒŠ¥@QE\0QE\0XµŒ7ZÔŽ\Ö=£\"³¬¾ðú\Ö\Â\ãh¤g\\p1U.!Ò¯\Ô\rÂ\Ò.Ö¦T\×\ë\rCTEP\ÑIE\0«IJ´\0\ê)G4mªD±6\î£\Ë÷§ŠZ\0aOzM´ö¦\Ð\åû\Ñ\åûÓ·Qº€¸\ß/Þ/ÞŸE\04Œ\nfMH\ßt\ÔT˜Ð»©( §Si\ÔÐ˜\Éc# ×±þÉ¿´F¡û<üG†gc6~\Â\Ûv$®\Ò~ð¢¼€Š‚hÄŠA¬*\ÓU\"\âÎš5Ï¬\à¡_³Î•co§|jø{\\hº±¨\Ão‚‘±\ç\Ì\0tµòV›}¡h“D\Ù+\ío\ØGã–›®\éZÁŸ”»ÑµEaf\×;I\0l\Éü\ë\æ\Ú3\à>¡û7|X\Ôô!\n\åüý:y:4m\ÎÒ¼\Ú2t¥\ì\äzUbªG™N)§.\Z0sEziže†Rm§RV„	¶´\áK¶€E5›j“\è)\íÒ¡¸Ï’øô©`a\ê†i\ÅR\Ç\Ì	©dOª9\ÜzWƒˆ“\æg\ÑaRI \\‘š…®•OÉ…\ÅS\Ä×˜\Ï]I#D_Qö\àk0R\æ¦\Æñ«mKyü\É\0Š\ÓX\ÊÇ–¬­a˜—\ì*Ö¥©ò§4¬tF¨ë‹‘\àóY7\'\ÍG4\ÆNõt&„b\ÏzUõ¦®:š~WµY\Ï}N‡\Âò˜.:œ·Õ´\Þõ\Âi7%n¢ô\Ív¹®iž\Î<È‘¥4\ÝÆ™»Úž¨Z¹›=XBÁ¸\ÒTžA¥û9©¹¿+\"\\µ*\Û\Æý©­^´\Åf^”\\¯fH\Úzö¨¤\Ó\ÙFEX[œ(õ©V\ä7¬j4\Ì*PRVh\Çe+×ƒM\ïW\ï£2þ5D\×\Ô`k{Hj~gœ\á]\nÍ­„¢Š+\Õ>l(¢Š	aEP ¢Š(\0©­œ,ƒ=3P\Ò\ÐQ\ê¾\Õ„)n\Û\ÚO¯kðßŠ\ËBª\Ì\Å|µ£\ëF\×hv\é\Ð\×g¦ø\Ý-\Øo—z\ÖrW:!cÞµ­j&BC(\ãÖ¼w\âv©Ö‹pªA`8ü\ë6ó\ÇðÈû\â\ÞÙ®+\\\×ÿ\0´#eV\àû\ÒQ±rh\ç½6ž\Ýé•©\ÆÂŠPqA9\í@„¥\Üi( /&Š#û\ÔPR\'j2hjJ²G--\"\Ò\ÐEPE% ‘F\0:Š@Àô9¥ Š( Š( Š( M§S@Z³û\Ã\ëZ\ÛÀ^µ‡›\Z­}£\å\ÆZ\0\Ðó…Cq õª¾w½2IsÞMËše­@QE\02Š( œ´”«@Zu5ij‘\"\Ó2iÙ¦\ÓQE\0QE\0«Kšm\0­÷MGO¦T±…QHwM§U!1¦Sš’“*$š}\ä\ÚF¥o¨Z\Ê\Ð\ÜÛ¸‘$C‚¤µú®X\Øþ\Ýÿ\0²ŸÚ¡ˆ^\Z€•\Ï\ß}«\Èõù€~y‘šö_\Ù\ã¥\ÇÀ‹Z}\ä\Ò1\Ñu[K\È\Éùv±\07\á^~&“’\ç†\èôpõm\î\Èð\Ý6i\ã’{ÈŒ7¶®c–6*ÃƒúÖŠŒ\×\Ó\ßðQ/_ü_¦üOð\Ìdøk\Ä\ì¢o/#ƒ9<t\nùz„Ñ‡R\n·\"®…ER7&µ7MŽe\Ò)ÿ\0zš\Ý+­ch\Í#Rb‹€¹¦È¹R€\êqJ\\m\'5Œ§¡¤ \äö0.£\Ú\íõªssVõ\Ý!\ÇJÍ‘Ž\îµ\àT•\Ùô”cd2SPžh‘\ÎMG¸ú\×;:n8õ¤¤µ˜\Ð,\Ý8 \È[©\æ“i£aô \è‹÷\Ír)\É;b¥òö®iQWEG\Í354\ÜT»PK]Kºkmº„ÿ\0¶?wÁ·qÞ¼\ëM‘¤¾\0\ê\ãù×¥¥¿›r@FrUv>‡-¦\ê6G«1©\'š•-\ÕX(­›]>%‹q\ë\\|\Ç\Ñ:<«C+¢¥ò\êüÐ¢šƒÖŽc>I¤ˆ¶p*¤°\í[!Wñ§y1·Z9ƒ‘œ\ãoPOj€\Ýmlgš\é¦\Ó\ã‘qŠÀÔ´·‹¯J.D¢Ð¶÷I\ÈcÇ½jjž¸\Ó<?e¬’kk¹\Z0«\Õ\É\çð®M¤1““Š\Û]z{½;lÄ\æcŒW³—Ï–v>C=¦¥AË©JŠ(¯¬?0\n(¢‚XQE(¢Š\0(¢Š\09 \ä÷¢Š\0LZZ( \ÚZk)ô\É>õ\06Š( Š( ^´P´PR,â¢–Š²Fž)3JÔ”\0å¥¤ZZ\0\îþx?Iñ\çÄ­\'CÖ§kk·\Ø\Ò+m9\í\Í}GûQ~Åžøy\àó«xr}’Gf\ÜÛ™ˆž=k\â8n.l\î\"¸´\í®\"p\é\"Evž!ø\Ù\ãh\é¥\êZ¤³Zª\ì žX{\Ô4ù“OAô8h£X\Ô`v\Å>‘Wj\è)j\ÄQE\0QE\0QE\0\êm:š\0¢Š)€¹£&’Š\0\\šU¦ÒŠ\0zòÔ¬0x§*Ml¶Oj@6Šr\ÆM/–i€\Ê)H\Å%\0*\ÒS”\ZmR%…QLAE*ý)h´S¨ \ÑJE%\0\Ê}6€–—m-+\0›ih¢˜¢Š2›2‰# õ\ì})ôVm_CTúŸ|~Ê¾$\Ó?j€º\ßÁ¯\Z\\	õ%2\é\Ò\È~m a\'¸$þðw‰¼!¨ü-ñ¶¯\à\íj	­µ2s	ôp¼t#\Ð|/ø•¨ü!ñö‘\â2VŽ[IAu;©•ö\Ï\í\Íð:\Ïö†øO¤üjð8ª\ÙÚ¬·\Û\àùÐŽ[?\í-x\ÒW«\äÿ\0?ø\'±\ß\ÓóGÀ úPÇŠ\Ë\Ò5d\Ô-ƒgdƒ†B9S\éZ;Á^µ\êF\\\Ê\èóefRú\èÛ§“Vµgjyf_¥cV§,Mh\Óæ•Š\ï{$\Ýx¦ý¡ðrx¦}\ÑUå—·õ¯U$÷g\ÐÆŒR\ØI\ßp&©HjW“ð¨O5“w5Q±M2¥e\ïLÛƒšB\nQIJ*K&Ž=\Õ?”*ºÉ¶¬$€\Ô\Z\Äo•·šC\ÜT¬\ã\ëD05ÄŠˆ2\Ì@’Š»=*4\Ü\ß,Jn\Ò6\Õ’q[:gn¯q$¿¹‹ß­wš€\Ò\Ê\Í.n€óH\ÎÚž\â9§a*O`xõ±œ®\Èûì¿‡ý´Tª#\Òüo±\É(Aæ»›\Í%a·ósÓŠ½}\áµð®ƒk¨Ý©ó\îÆøýkšú\ïVžKf\0\Êø\Ü\ÝqF³¨\î\Ïwû:ž\rrÁÙ¦\Ö\'­Zyˆ\ã85’\Öj\È\Ì\Æjm\Ç=\ët\ÎyS¹+1cÉ¨›™4m-ÚŸ1>\Äb“\Í\ÛÞœ#>”†#\éJ\å¬9f\Þ\à2\àœTW*²®\ß^*…B\Óml\rRf5i(«ö«§˜eb¼Š­c9ß°šß¹1\Ì6·Z\æ§\Þù@f½|­$ÏÍ¨\'FF¥gw4W\Ù\Å\Ý\\ü^z;QT@QE\0QE\0QE\0QE\0QE\0\Ï0\Ò3n¤¢€\n(¢€\n(¢€\âŠF¢š\ÖM4”U\0\áEÒ–€\n(¢€\n(¢€\n(¢€\n(¢€½(¡zQTEPEPEPEPE´\0\à\Þôõù±MU\ËT\Ñ\ÇI$q\î©\'Ò§·‡8\â­}Ÿ=¨(\Û\çµO ­?³Œt ÛŒt ¯$\Ó\Z=µ\Ôø\ÃRx‚öKhŽ\ÖXÌ™?P?­S×¼?&“t`”‚Þ¢¨G?EK4_|\ÔX¦ ¢Š)ˆ(¢Š\0N´m¥¢€m&\Úu\0Ý´”\êm\0QE\0QE\0\êm:¢ˆ÷®\r}»ÿ\0\àøøšN©¨ü1ñÊ¾¨D^\Ç\í¢»aL|ö#<W\Ä\Ï÷ª\ï‡|As\á/\éºÍ£l¸²&S\ÏU`\ßÒ¼\ì]%R\rž§$\ì{g\í1ðÁ¿þ/k\Â\â\î\æ\Æ\Êþ\íåµ´‹”’w>\ïó\çv\Ú/\Ã\é¸—¯ÿ\0mqý+\ëŸø(†™kñS\à7ÃŸ‹š\\-$«²ÆA£OD‚¾·\Ø\èŒ;Šð\èª\Õ6§•L54¹©¦zSøÃ—\Ö\ä\éÚ¬±°\è%eaü«–\Ö~\ßG¼\ÖÞ‚3Ö²\á-ŒW\èq[šgˆn,xósZNâµ•Ë£,I«\Ó\å~G\ê\ÐO¥\Í\å\Ü\Å$-þÒš\Èk¯1ˆcÖ½‚\ë\Æ:môŸfÔ I›QÀ¬û¿øcÄŸ\êZK\ë\ÅyÒ«(»I»ÁFk÷lòðþô\í\Ãk½—\à_™Ížªpzõ¬É¾ø™X¬¼}›–\æÙµ›´Q\Éw\ëV­ô¹\îÁh“x®’?\Ùÿ\0\Å[Ð›\Ø@\ÎMzÏ€þc\ÂR•.ŸÚ¢±–2)hoC(¯9ZkCç».þ…²–Bð®sP\Ëkkn%¹°¸FtÀ¯¯\rž‹\áµ\Þ\É\î\íÁ\Î+Žñ¦±k\â\ä‹O6‹ ðTš\äúû½ \rsG™3\çl\ã5*±ZöOøwDðüV\Ð%¤nYr\ÌG5\Æ\ê\Z6q\ÌC\ÊoA]Q\ÅFG%n©JÉœŒlY€\ë^ðÿ\0\Âip\ßlº\ÏÉ‚‹Óœ\ç5‹\áË­\ëP\Ú\Â7ò	Ç¦k\Ý° ðÕªE1U9\Ç\çc1]\"{yS(?iU’C.¥yœC2¹Â^ƒ¥ü(}\å¼U\È7\0\Ýj¦¨é–’\Ã<*Îœ‡®¶û\ÇÍ«*­\Ã\ï\Â\à7Jù\éM\É\ê~£FÐ…‘Á|jÐ¤¾øWowlK¡\Þñ¯ñD\Ê2~ ŠðKCÎ–	Svß¼6œÎ¾®\Ñu+yî¦´¹nln†\Écn\â¼K\â\Ï\Ãý/ÁºóI£Hÿ\0a•ò!va98•\×A\êy\Ø\Ïz79A3¹±?Z³\'©ªPr¢¯\ÇÒ½+ž&Ú– *>}*X\Å¢\Ô1«u«‘\Ú\Æ\Ø\â©\ÇV\âlw©¹\Õ\nm–V\Â_š³um&1r\â´¡W9ªo|ªOÍžhR&µ\ËsˆÔ·\Ø\îiþLw¬F”\\\ÜG\'ð³`6xúW ^>Ÿ¨\ï†ò5m\ÊW=\0¯Dø… ü/\Óg®Š|Sl\ÆK\Ù3íŸ”\nõp²\\\Ê\ç\Åf”\ä\éI#\ÄñÀ¤§7\ÝSØŒ\Ók\î©ü(ü&²\å›L(¢Š\Ð\Ä(¢Š\0(¢Š\0(¢Š\0(¢Š\0BÀSYò8¤o¼i(\0¢Š(\0¢Š(\0¤4´@	š)(«\í´PEPEPEPEMM\0QŠ(V–‘ijQ@´øˆ3W/$¶\Â98\ï@h¢Š\0(¢Š\0)0)h \Ç÷ª\Üc\0Uxp«žõb6\â—P/[\È«‘·\Ô\ÖúÍ¡H«ù&A\í§nH\'¯\áU\Õ1Œ\ÌP\ã‚´S#\Î9©)-\ä\Út\ÆKvòÙ—i#Óðª·\×Ý¹iœ»zšy?6*	ª¢K3.×¥Re­Š¥-1QE&j€Z))h\0¢Š(\r&\êSM \ÝIE\0QE\0QE\0QE\0\ÓM‘IŒ¬W\Ô\nq\ïZ\Z~ °\Û\Én\èX–\ÉÕœµZ›E\ÛS\î\ØwÅ–ÿ\0¾\rø¿à¦¼\Ñ\ÉZ\Êö,\ß|n9\î{1¥~øƒA\Õ>\Zx\ïZð~¸¯£¥]<\r\ænPN\Ö†+\Ó?g?Š_	>1\èZüRx£º\Ü(8Oµ}ÿ\0Iø#mª[\èŸ</\0š\Ú\êŠý¢?qø\ïŽ9ô¯—­\'B«¶\Ìú\Ü*Ž\"šg\Æ\'REwSLŸS_\' s\ë\\Õ\ãMg\æœùy\Æ\â8\é\ëRM{º>:zÔª\Î]Nß«\Æ=_\\´\×³\íQE¨\\Ûœ\Ç3!ö5I¸\ä\ÓsQ$¥¸Ô¥\r™·k\ãV\×h[¦ z[¶\ßµ+u\0©o|\×K\\ò£t;)\ã«\Ãi‚¿µü­U¹ø¹­L¬#“\Ë¸\ë\\V\Ñ\éH\Ã\Îðð\ìv\Ç3Ä­;/\r\ê\×ú\Õ\é–\æ\æY1ý\ã]­\Â\Û\ê6®\ÄÝ“š\äüo¶\Å\æ\êOJ½\â£´l§\Zñ*\ÒJg\è™v\"Wç™­\ãEmBdŸ9@œb¼\î\ÒGR\×\"\Ó\ì`k‰]±€;z\×g°oô\á	ûÀ`]÷\Ã?\ÛÍ¯\\F\ZLl#¹®iM\ÇCÐˆI½Ž‹\áïƒ¡ðDb\êôªÞ˜ðw`\í&®kÖ¶Z\Â\0×ƒ\'\Ðóš\Æi¯üK«D“3Eo+:ô«\àý+MFyµ%y\Æ\à\rrIó¼\" ’G=7‚\îX~\â÷§N9­/Ã—‹\Z,³}Þ¹{M\Ó\ÍÅŸ›c(¸Qþ\ÖMIq\áŸ\ê2ÿ\0fi\æ\è\ã†V\Æ+Š¤¹§µB\Ò:—:°¸h ”<£‚k‹ø4²Z§œw3¶yíŠ¿eà¯ˆ\Z.£%Æ¡\á\Ù\î#\å‹\Çó`{þU‡\ãr\ßVh!Dh®#R$»s\é]˜j°ž\ÌòñTg\ßc—¶\ÉÀ­H—\å\Í\Z}‰e\Î\Üó[pi{”\0+\×G‚÷2\ÂÔˆ•±ýƒ&Ü…§/‡\ç=šMšCVeª\â¤_®*{>[_¼µNI‚ðx¬\\n…;¢\Î.	¬«\Èñž\Õg\í\0w¬ýBl¡\"”Y®\"Ÿ,L›…\ÜyÉ¦O¾\æ»y_\Ý\íMy<ži¦eR9ù‰¯_ñ#óœ\Îv„®=£‡J\Ë\ëVŒy\éMhöšý\ÝGóõ\â\ËÔ©¶›Ÿ˜Õ†CÚ¢eÇ½Q€\Ú)i(\0¢Š(\0¢Š(¶Šo˜idû´\Ê\0(¢Š\0(¢Š\0(¢Š\0)¤Ò·Jm4EUzŠ( ZZE¥¦€(¢Š`#RRµ%. :Š3E0©)Z’¥’*\Ò\Ò--44Râ¦˜\Å^”´\n(\0¢Š3@f•pXz\0JU]\Õ\Ùø‡ÁºN“ð÷@\×-ut¹\Ô\ï\åt¸\Ó÷\r\Ðœc¾;ú\×z\0rŒT±µEN°\Ø\ïROg\â‹\ä\ÐWI.­e\æy»H9\Ï>þô\ØZ7n¹\Ï‰\Æ\Ñ\ÍZI·\Í\0je{P\Äª6;Ô†\ãŒPž`¨&—­F\ÓUie\ÍRÜ†$\ÒfªH\Ô\é$ªû·UkIº†¤¦×­uð½¦µló\Ý\Ü\Éj\Ø>X\á\\²\ç5\Òø^Š\ÂÉ­¤;}Û¨o\Å\Óô»s§\ÞIpï¬˜\È\ç\ØW \Õ\Õkž µ¸\Ó\å‚\Þd\é\î\rr­@Ä¢Š(QE\0QE\0QE\0QE\0\ÓÖŠ­ˆ¯uo˜u\ê+ôsöIñ…¿\íû9x“\á~¸\â{\Û[WKmÍ–\é”#\èkó¨ËŠõÿ\0\Ù\â|ÿ\0\nþ5\é>“ey*Á0-€CW˜Ñ¼y‘ô9M^Yò>§Ž\Í\"|9ÿ\0„§Áú¾‘\ß,\æf‘\èÀ8$sŒð9Ç­qR|ª\0>\Õõ7üo\á‹xO\â\Ì~#´ƒn—« ž)”p\Ù\É&¾Z\Ü$\\ŒW‰BW\ÐúºÑ²¹\í´žgµ¦›^+¿¡\æõ%VÈ£q¦©¥\ÍHG†\êqSy!¸ü*¦Oj±n\Ì\Ò(>µŒŽ\ê*\íƒ¡D-t\ÄA\Üf¨jÛ¯&Kd\Ég!TzŸJÐ±Sö4\É\ã\è_ü¥k\Þ4µ»Ö§òl\àlü\Ý+\çªß™Ÿ¬PPú¼QwÁ_“O\Ñ\Ò÷V•³Ÿ)\àzTú“K¬]Gcaú4|\ì^Wwñ¿Åž\Ñõu\Òôû´xwn·jó_ø\â\×B\Ñb‹Mö›…É˜N+–4%QÝš¬di+##_ñ¥\î’\Æ\Â\Ü,\rŒ\×	¨]\\\ê4\Ó\\H\åº\å6\âöK¹šY\\¼ŒrX\Ô-/ËŠ\ë†u8\êfR¾…ý/\ÄWúüz\ÝI\é€x¯B\Ñ>>x«E³\Ú\Ü&qüK^N_&¬ÀN	\ëYVÀÓ©¹¶7©M\è}µð·\ãÖ¡\áS?ˆ ´7;~VVÁo¨\Íx_\ÆÉ´{_}b\Â\ío$\ÛC6•\îzu¯-Ó®/\ät†–‚3\Ç¥t_\ÙG\ÍI\'¾k·_ \ä\Ç.•9ó\'¡ô_Ú¸z”Þš±l\ã)Œcð­\Ý.7‘\Ô\ÇÒ©Û¢+dô­ý:\ê\Ú6Pq^ªº<nu7¡w\È1Ã’£5zˆŒ‘¶´dž)a!Xf¹«\Ç1¹\ÅKgE5©­uö¦a·µrw\Ð2’k ‘‹±ª7v\åÖ¹\äÏ¡Ã£i5Nòs´‚+uô\Â{U;½!ödšQ\Ü\Ó¤R\êl7¥Cc—÷\é\n)o\â;zñV5\í²2qPx?\ÄI\Õgvˆ4¬†1»øs\Ô\×\Ð\à•\æÇ³É¸\ÆV7H\Ã\ïH\àpH¦«\É÷§7 W\Þ\Çd~SY6BV¢e«h†F£“V|A\á\Û\ï\r\Ü\Ã\rôK\Í•6¶\ì©\èjŒŒ}´”¹æ’\rb@â™¸úÓ¤û´\Ê\0vóG˜i´P³¤¢Š\0(¢Š\0(¢Š\0(¢Š\0n\êJ(ª\0¢Š)su©(\"Ô•½ðó\Âx\ë\Å\Ö\Z4/³\Ï±œ(þªöŸ\Zþ\É:¯…ü8Úª¾\è•\È\'<cµ0>v=i»ª\Íý£\Ø\Ü4R}\å8ª´\0QE€­:š)\Ù\Ð&\ÚZ)ŠÁŠ(¢ŽZZE¥ U\ÝK\åšõ§\î´€Š™RSvŠ«\n\ãh§m´X./˜YB“=iW\"‘i\Ô\ì+†\ãKº’“u@H\Z¤Y\n÷ªÁ°sNó*lŸ4ú\Ò4\ÌZ„IH\Í\Å+17\rLi\Ø\ÔtU\Ø,[­%S\0\Æh¢Š\03KšJ(\0¢Š(\0¢Š(\0¢Š(E.\ÚE§PH¤§56€\n(¢€\Z\Ýh¡º\ÑP\Ë@§¡º¸k-®\ãr’A2\È\nœŠš¨\ë68\îMyø\ï\á3\Ô\Ë\ï\í\ãcï¯‰Vöÿ\0µ\ì{gw&\×<;\Z\ç.P.1ü\ëóN\Þ9,\î\'³›‡ˆÁú\×\é_\ì\á{\í?Á\Z¬šŒ›ô\Ûôò¼–?\ÂG\\W‹~\Ô±4þ¿»ñ_‡¥‘ô\Å-qv­\ÆÜžƒÚ¾\"\ä‘ú£Á\Îtî‘\Ö\Õ$FF\Æ+¬µð¸rçš—û lŽk¹U<\ï¨Ëª9\å\Ð÷`Ž)­¢\ê\Õ\ÒI–¼V|±³7µk\ÌgõO#\r¬vp9÷©m¬\ÊÌ­Ž+A¡M9WmC‘¥:2¹yuŽ0 \Ñýµw)\Þ1\×\å8ªtÖ¬\ìûz–µ\Ç\\^Ou)’ižWþóœ\Ò5Ô¬\Ã{³\0»F{“\Ç\çQQBIóË¹af-\ÔÒ³w¨Ô«U¡jLz\Í\ëZ±†š¼8\ÅlX¦\å„¬wÑ‹4\ì\Æ\Õ\ëW–g\ìqU!L-ZŠ2\Í\\²=%{X»o3³[6ö’H»‡Z¥¥\éþl\Ë\Ï\ß\éšDkõ\Åyõ¥\Ê\Ïw‡uNQ¤ž\Õy\Î*”·&f\É5\Õ\ëúz,-Ž\ÕÅ¸*Çµc\Ít{O\È\Ë1®þjuµó:Uky‚â´­\Ü{W5IX÷0\Ø~mH\ãÓ‹rEf\ê\Ò%º\í\0­ù¯\Þ\ÚYE¯;\Õ5u4‡89\â\ä\ÎlÎ¤)F\Ìm­ÀmQ#ls´ƒÒ¹\Ïi\Ñ\éþ-#\n« \Ýò\Ó\æ\Ô<©ƒ†\Ãg\"›®,³jºuÔªA`Þ¾«~t~-\Ä³“E\Ø\éXô¨¼Í´0¯ºŽ\ÈüN_·\'½E[\×<Iy\â³}°©6ñùHTs·Þ²ËƒÚšjŒÀ\ÒQJ:\Ð\"å®ž.YFüg­3S³[;Ç…[z/Fõ¨ã™£û§“J\Ó·&€ e\0qL©dS6ŸJ\0J)vŸJ6ŸJ\0J(Áô¢€\n(¤j\0Z)«N ‘INjmR\0¢Š)nŠ( Aø\ã(<	ñ\ÏU¹Í…P£/Ôð¯§>8þ\Ô\Ö2ð\ÜZv™\ÙbU\Ã#¾%Š©Á«\ry$€biZú.­pn®¤”œ\î$\Õ*s6\êm0\n(£€T·Jw–A\éRY°Y	n˜©\ä¸Ew4ÀªË·¦n­OkP\ë“Y4If ‡\Ë`Ÿ\Æ}MeQp\ZZE¥¦€zž)wSV—5dŽ\ÝFE74f\ni)\Òf€¸\ê)¹£4\n\ãÖ—u1ihfŠ( Š)@\'¥\0%8¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€\n(¢€i\ÔÕ§P56œ\Ô\Ú\0(¢Š\0ku¢†\ëKP\Í‡µB¨·—ö°\n4Š\çIup#Œú\Ö}­\ÃAwÀà£†\ãcj{®\'\Ôex}Tg\è¿\Â_\ÛxcN\Óô\ä\\Š>C€KûG|fWø{}¢Á²W¾_&N3…>žõ\å	u\ÍTðº\ê\ZÎ !UO<ƒS|Kø\à\Í\'À7\íg,w·\r±<œ¶}«\â%~cö\Ê’£Ÿ5j0µ i#­a\\jÑ¯1[°x©uxxˆ€ô¬\ÝR\Ê\ÞhÙ“nMvSZ\\ókr¦\ìe¾ ²wª­p¬\Ýj¬\ÖR¯\Ý<z\Õf‚X\ÉÉ®£È”–Æ—˜­M\Íg,Ž§§}¡‡Z¹‘u˜SwU/¶Ž\æ“\í\é\ëE…Ì»—hª?\ÚI\ëŠC©.\ÍN\Äó¢ù`;\Òy\Þø¬·¿3\Å]˜\æ¦Z#Jr»±\Ðiñ›†\äVý¼~ZY\Ú\\>Z)#žµª+Žl÷\è\ÃB\Ôr<WH\ÇJ¦\Ôð\Æzâ¸§#Ù¡AÍ£O¿hXm\ë]%§ˆ\'T+Çµq0¬\"¤Q¼²vXÁ$ýY‡P>¾\ÕÁ?xúœ<=’\Ð\ì®u¼B…a\ÝZ\î\'™§ß™%\nOÒ´\äU \æ¡Nm½LA\Æi\æi#Z¸ê»Žj¥ô‹sÚ°œ9[\rŠ8\êf\Þ\ë\Ã\ì\ÓBO,1\\U\Ã~´\ÝWQÿ\0Lu\rŽj„——\ïW~šG\Ä\ç8©T›\"™L×‘ þõvþ-\Ót\r2uO–Pnúö®]\îA\ÕNEt“x\Þ\ãW\Ñc\Ò5Ø²¬¾h\êq\Û\é_Wƒ§\ï&~E›\Õsƒ¹MŸ“M\ÝCu4•õ‘\Øü\Ê{…Qž•FAEP­+Sh £i¡i\Ô\0Ý¦¦E\01—Ö“hô§µ6€hô¦ºŒt§\Ódû´\0\ÌQE\0S$YBÂ›\åc…_SO¥X¥šH\Ò\ÊÎª¬OBH\0\Ð®h¿±¯\Æ}{Áñx’\Û@±M>P¬žu\ÈV*\ØÁ\Æ}\Åú3ð7Â·qü\Òt¿ø“O¸\Óå·…\ÒDº\nPŒ¤ç±¢¸þ±¶¥ø&o\Ë\ä~H\ÑE\Þs¡E.\êm}Q@\n´´‹KM\0Ræ’Š`#u¤¥jJii–¨Š(«3{…Q@‚Š( Š( £u%\0»¨\ÝIE\0<WE Ú£i7³²©e^2+œ\×xv\Æ\âo\ê3\Ç4)\Ã8\è(É·\Þ4Æ§°\ÃLj Qº’Š85-5zÓ¨)¢—m\06Šv\Ú6\Ð\n]´b–€¶’M Š( Zu5i\Ô\0Ö¤¥jJ\0(¢Š\0B)?„Ó©Ž\Ûc\'Ú³žÆ´õ’FE\ì\Å\äÇ¥Dœ\Òs$ŒMI\Z\×\Ëb\'\Í#ô)«\Z–:\ÅÝ•±·I\Ü@\Ç-x5OVŽ{\å\n&f‹¨Bx\ÓQG9G\ëšò\åMn¦\Ã\ã%\Èö)y\ÓY|¸ S¿¶_¹­–+µ…Sº\ÐÄŠLGð¡hu\ÍûE\î²¬³w\ÍDÚ–î¦©\Éc4U”\Ôoo$k¹”Z&2¥9—~\Ð	\ëO2+Žk%®6O[\ØÁ\æ­Xã“”M¨{\Ó\Z\ÝX}\êª\'\Ï þ´} ÷­2se\ìð\ß\ÇO\ZX?òÒ«-\ÖSV¢¹\éM¡s»‘M§²\ãÖ‡‡ô³½¥”sžj[y’\0+j\ÕW\0W-Gd{XHó4Ù¡®G\Ê\ÖZ\î§g\"•ù«Ì”°¡\è_·Œ¾8««	QU\í¤E\èjçœ¸\ä\×\Ùõ8h%šþñ$¾ñ¶­K4n\Â09\ïõ¬k™\×JF\Ó#3©\Í\r\"m\Ç\\\Ò4á•\ãŠ\çg „ŽCn¯Á«yŽ·5‰4œj‘¸hdÊžERFs;]Û†sYš£~\é«2\ßZm¸cKq©$Ð²\îùª¹L$\ÒZö\Þ\Ó5É˜Ks%¼ÇÁ€NEU\Öþjöq™l\\^[¨\Ë6yðª·E£“r¶±®£\Âÿ\0¯´[I\ì\Þ$¸ŠD)–\ê+²’qg\Íc-(¶\Ïi¥†FŽ@C©Á«zm\ÖÛ„=\Í^ñf›ö{Áq\ÐNK\íük\Ï?n€\ïW\Ôa7G\åYŸ\ÂÎµº\ÒS›­6¾¢;œK\âaG½„Œ\Z²Cpõ£põ¨\è¨ ”ô¢›Ý§P­:š´\êv\0¢Š(°4õ§\í¤\Å M“\îÔ˜\Ç\äq@\Ò\ZZi4À7R:	Wi$j)i=Æ¡©]iñ\ØK¬j-gÜ€\Ü6ÁøQP†¢¤weš(¢¬vÑ¶E¸QE(¢Š	¿zŸ·\éM_¼*J`FÃšm:O½M¦\Õx¥\Ûô¢?»N¤¤\Ú)\ÍÖ’­kRSš›L¢Š(\0¢Š(\0¢Š(\0¢Š(\0­[?_Yis\éð\ÌR\Úc—QÞ²©\Ë@,X\äõ¦5:Š\nE.)($Z7RQ@V\æŸQ/Z~\ê\nE7u¨\ÔSwR\æ€\nm;4\Ü\ÐE£4\0«N¦­.h\Z’•©(\0¢Š(§­Gp\ÛacRwªÚƒ‡¦¹«;E¸XóTŠ3cS\×Ö¥_—ŠQ÷E%|G\Ìõ?F§X¤‡\Z¬W9©Y¸¦Áót¬MùHö•©¡¾hø©$¶ð9ªmcq\'EÀ¨Ü¸\Êtö-ýº\'û\à\Zz\Ém8Ç–|k&K°\Õ\ß|øww\ãO\Ã\ZÀ\Ïl­ûÃŽ1\\µ\ä©\Æ\èõ0.¥zŠ2WEM[ð\rœ\ÛøƒEš\ä88’9\n¸n\Ø\Çj\áOOk¢\×Ãš|›9Ê³\ï\ÆOÒ¿D4\ß\Øÿ\0\Ã\Þ \Ó\Ñ\ïtøl™€ù°ýkPøgð²g½\Ó`Š\år\09¯-cZ>¢¦]N§º|\â/j\Þ¹HuK\'¶óQ˜pßfù™ö¯¿|\ám;Rð¡w©X\Å;\Ål^\"\Ë÷[i\é_\0\Ëò\Èq\Ó\'ù×¥„\Åûgc\å³,µ\á—Fªxf\Ú9\ä\æ«\Íi\èºLšµ\ÊÆƒ\å\îk\ÓoCÀŒnô6t\ß9®’À¥µ\Ñ\ãÓ£TN½\ê\ÂÛ‘^}Ij}N<±C\Ò`8j;t\Ú8\ÆT\n³\Ý\é^|Ï©\Ã|HkD¡ýj-»[­XoqP¶qŸIJZ\ÆÞ¦§_›ŽõŸ\ç¦ó ô\æ¥\Ä\ë‹\'›*\ÄY÷Móf´—P¶¼_œùgÖ«\Éaœ¬£qZ˜\Öf\å\ï\Ùýs\íU\îf¼·²†ñ\ãu·‘¶«\ãƒZºœqÛ¶\Ì;ãŠ¹®|V’óÀÖ¾}\Zkx\Ìip«\É\Ïs\ï]ô\ás\æ1X·N\èæ¿´„\Ñ\äþ5µ¢\é\æ\è+ž•\ÂA#GŒ\ä\n\êt?‹9­`‘TB\Ì\ß^…*JúŸ!Œ\ÇI¦‹­~Å¤\éò\à÷_\ÔW+\á\Û.fY\ÜU\äWQñK\\ƒV’\Ê\Î\Ñü\È-\×.ÀðÆªi¬\Z\Å6Œ\0;W\Ña ®|aZN,»\Ó)X\ÓwW¶¶>=\î%%-5þ\é\í\Å2Dœ´¬¥x#\ï?gÿ\0…ž*ø3\âox\ß\ÆShÚ¬fE±·Žp\\Œ\'|œW\Ï\ÖB\Ö\àAp\×qB\ÊýH\Íg{»\nÅ¸þ\í:‘zt\Å-1\n½i\Ô\Õ\ëN«\Ûh\Í-*Žô\0ŠJ~3M\"¦À1©ÖžÆ¡gü\é\0\Æ\ïõ¦SóM¦€J(¢¨Š( „RSš›A,]Ô \ÓiV¢Š(\0¢Š(\ËK¸ú\ÓV–¨	‘\Ï4»G¥$vRR\ÑE\05º\ÒR·ZJ\Ñl56œ\Ô\Úd±\Z“&•©(V–‘ih\0¢Š(\0¢Š(\0¥ZJU QE\Úu;m\0GIS<.ˆ®\ÊB7\Ýb:\Ô4*õ§SV@\ÐQECM§560¢Š(R¯ZJ’\ÞA\Ê\Ì2 ó@1•\ëM#¥«\ßZ\ÝùfR›G9¬\Â}h((¦“\Í(4\0´¨5f\Î\Ô\ÜHœ\ä¡³¢7Vj¨\Ë{In*¡&·­|ý¨«ö™\Ú\×\å\Åh[\É“o€«¸kVø†ñHR\Ü|Â¾K©Q¸\Ó?CÁd´pö©[s¥_„ú[*„¼œ¿~GøU-K\á:@¤\Û\\¼œtb?Â¹xþ\"jÑ·NkWIøŸsØ»”šñ\\ª_S\ê\áJƒZ#™Õ´­)\ØK\08G›n\Û\çŠô{Æºf­¦´!7\Ê\Ý\ÙpEy\ÕÍ¹\ÜYy´&ú˜Ô¡²Z[\È×©¤mQzf±š9b¬A£K6	l\n\Ø\æQ¶\å¸\ä[™†\ÉcŠú¿\à<\ÓøGÂ¾l1\Å\æ\È\Ã\ç\ÛÈ¯•´ý\rà¼ˆ™3ƒšú\ã\ám»\Í\á\Ø\"ò\ËdŠñ±\Òv±õ\Ù=¯#½¾ñ¦¹r†G¼—°<\n\æ5¯j—Ê\É;È¦º=KKºŠy{|†³mt\Ï&9f’<8S€Â¼u±\ë\Éû÷1¼U\â\Ä\×<1y¦\É×’›³\ÇJø3S\Óä°¼ž\ÚE!\ãr¼ýk\ê?\ê÷\Zm\ãy@¸\'Ò¼\Ç\nn5ig\à\È„w®\Ìös<\ì\Ò?Y¥cžÒ´™u+\ZòkÐ´]&0#\É~\äš\Ïð¶ž\Öv¹qó¹\ÜO\á]·c^äªŸ7G/¶¬Œõæœ¨)\êJ\çr=(\Ðq\Øo–OCN\Ú@õ§£|Ø«Q\Ã\æ/5\Ï6{xDï©Ÿ#aj¤“{Ö­Í‘U\Î+\âF\"¹\Ú=ø§b˜MVy3št˜LQP3T\Ø\ÝHcHGJŠ[‡^‡õ§3\n«3VÐ‰…z–D3\ßJ¿\Æj”·\Ï\Ìy¢fù½*¤\Íz4‘ñ\és\\d\ìdt¨”ü\Ü\Ð\Õ\ã^Œ¨øšò÷‰\Ù\ÆÞµ\Ò\è¿ñ\à3\\\æŸh÷—˜ùsÉ®½#Xa8Šú,\ç\É\æÐ‰©)\ÍM¯Tù°¤``ô¥¢Mn.-¾\Î\ì\ÆÛ¼½\Üg\éN·µŽ\Ý6Æ §­:‚D<\nLÒµ%\08S\é”ú\0u=i›©\Ê\Ô\Ð¨¦\È0¹£}1Þ¥¶¡,iòš¢¤€ZJ(ª\0¢Š(\0¢Š(\ëSi\ÍM –*\Ò\Ò-:Q@Q@¢Š\0r“\ëK¸ú\ÓV–¨	¥:˜¬\0\æ—põ¤[\ïRdÒ±É¦Õ­„M7&•©)ˆ(¢Š\0U¥¤ZZ\0(¢Š\0(¢Š\0ë´½\Â7Ô¯¯u+¸|S\à[Y¨T‘\ã’O­r”\ßJuAEP0§R+\Ôb’€7uoKC°\Óþ\Ïf\Û\ÌQó7\ÖT6«\'Z‚1¹±Z–°\í^iŒ\é¨#9ªÿ\0d¦µ\ê6q@ŒvMµ[™z\ÕJe\Ô\ÚsSh%…Q@Q@E%\0RŠJ(\ÝkcM_³§˜k&/¼>µ¯+!@=«\ÆÌª8Ó²>Ï‡pÊµwR]\núµ\ãO˜\'¥qö–&gg|ž}k¦¸û¦³\×§\áûZw>š¥w[%Ø…£U]¼UyTpµ,¹Wv5\Ë\ÊzºS(\rÒ´UŒÐ°\n6­dªù­[6\Ûo8#!—”—)\ÝJWVf{V\'<S¶[n\ì\n\Ò\Ðü3?‰\ï>\ÍùC8,{Wa\âOƒºV£\î7òMu°Tp[Ò¡\ÔQp²¨\îŽgÁ0\É\â/Z\Ù\ÆY·8\àu\"¾\ÒðL\Ã\Ã&;Q|•0¯—?f?	<Y5õ\Ð\Äƒw¨¯¥®¼A7òH\ì6žœcŠñ1Sç•°À\Óú½-w=)|}8P³$nŸNk\Æz\í´\Ú_Ÿ\nª³d£Ú¹\ïYC\ÌTÿ\0À…yï‹¾#¬á¡²ŒgŠ\æŒn:’\Ô\ãum^[ë›“rŠ‚7 *÷®CR–; \Ê\ÐF9û¼þu¯u3Í¾G9v\ä\Ö\Ç\Þ\æ»iÇ”æœ¹•ˆcŒ\"\à\nx¤§-ov:p$V\ÅòM7ŒTLÆ¦\ìô=ŒYc\ÌÛ‚+B\Î\ì(\æ±\Zm¾ô\åº÷\ÅDŽŠT\ÔN‚K¤‘qüª	)\×`\Ö3^\í¦. wž3Rvß±nóAfù\äV%Õœ’\n\â·\ã\Öcæ¨¯¯¢šÀÉªH‰K”\å$\Êõª\îwU»\Æ\É8\éšÏ’_/œf·ŒO/ˆV	4\Ù&]È¹ªec!B0kwG\ÖbŽ@²WSý“e®Gû€«)\çŠ\Ú\î\'\Í\â%\Z‰\Øó+\ÛSn š\ÏbGÖ»\è3é±†o¸?Æ¹ƒ\"zõ°ï™ŸŽ^\Í6v\Ú}´vöq•_‡<SÝ³M“?\Â\Ýk\ëh«Düú½G)1IJ\Ô\Ú\Ü\åŠJ(å¥¦­:‚DjJV¤ \ÝKšm\0ý\Ôn¦Q@n¦´ŸF\Ä\ÒT°Ži´\â3IŠh¢Š)€QE\0QEnŠ( –¹4”P!VMZu\0QE\0QE\0fŠ*\ÖÄŠ\ZÔ”U\0»©2h¢€\ÑE\0QE\0«KH´´\0QE\0QE\0QE\0\å4´Õ§PR\ÑE&\ê\0’ófµ`o–²cl\ZÒ†UÉ¤\"\Þ\êk7˜;\Zd“R\ÔEiª‹7&­M(ª†˜i(¢˜Q@Q@t¦Ó›¥6€ii´»\0IÞ­0´b³ˆj°·«Á\Ì\Óiy\ÃŒg(·¸²Œ©¬¦n£Þ¶–<$¯8\ëXŽ¥d#\Ô\×¦¥I#Ú	\Ó\ÄI\Én>5²zU+”;*ä…­˜\ãò¬¦“ux¬‹<É’{ó^sv=ˆ\Æ\äj¸«»ŒV¸\î\Õ\'\ØLª6rÛ±Š’ú\Õ\í\Ö%q‚+–¤KG™š^\Ôƒ“®\ë[úk\Þxúù žSŒ±Ê¸…‘\äù`kÚ¼\áØ´)1û÷]\Î\Õ\çÔ¼¡£N0V&\Ðt£\áµ[');
/*!40000 ALTER TABLE `prova` ENABLE KEYS */;
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
INSERT INTO `rov` VALUES ('4GMW310','HO4IUJKLRY','Seatrepid International','2017-05-26'),('68F6868','76HF6YN1HT','VideoRay','2006-11-28'),('8AGD854','82FVVRU6G6','EyeROV','2000-02-17'),('8GPK420','FOEYGBHH84','Blue Robotics Inc.','2018-10-09'),('C606966','8U59P369AP','EyeROV','1996-01-10'),('C719058','RCMEXFIGYB','EyeROV','1996-08-21'),('CWP8099','F49RXV36NF','Blue Robotics Inc.','1993-02-27'),('EQE2435','16GWSA733K','Oceaneering','2016-12-03'),('HWN1325','ZU01FVTECU','VideoRay','2011-03-09'),('JFG1274','8N267FNXXW','Oceaneering','2001-12-10'),('KGS4116','G15FFEYEOM','Blue Robotics Inc.','1993-10-03'),('KVK93A4','OWZ8AYURQP','Oceaneering','2002-07-29'),('MJV3440','HOQXK3F9OB','Seatrepid International','2006-08-16'),('MQP6080','0JHBW0POMH','Blue Robotics Inc.','1990-05-27'),('TOY8671','VH0HFI8FIC','Oceaneering','2000-11-06'),('VT16752','LFLRJTRGCL','Blue Robotics Inc.','2016-05-24');
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
INSERT INTO `spedizione` VALUES ('SSEY2O52BP','2023-07-21','Fossa delle Aleutine','8GPK420','Ocean Exploration Trust','WK8OQ');
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

-- Dump completed on 2023-08-13  0:05:28
