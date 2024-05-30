CREATE DATABASE  IF NOT EXISTS `storage` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `storage`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: storage
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `email` varchar(100) NOT NULL,
  `username` varchar(100) DEFAULT NULL,
  `pwd` varchar(64) DEFAULT NULL, -- SHA-256 produces a 64 character hexadecimal string
  `nome` varchar(100) NOT NULL,
  `cognome` varchar(100) NOT NULL,
  `data_nascita` date NOT NULL,
  `amministratore` tinyint(1) NOT NULL,
  `carta_credito` varchar(16) DEFAULT NULL,
  `indirizzo` varchar(100) DEFAULT NULL,
  `cap` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`email`),
  KEY `carta_credito` (`carta_credito`),
  KEY `indirizzo` (`indirizzo`,`cap`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`carta_credito`) REFERENCES `metodo_pagamento` (`numero_carta`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `cliente_ibfk_2` FOREIGN KEY (`indirizzo`, `cap`) REFERENCES `indirizzo_spedizione` (`indirizzo`, `cap`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
-- Using SHA2 function to hash the passwords
INSERT INTO `cliente` VALUES 
('liviovona24@gmail.com','admin',SHA2('admin', 256),'livio','vona','2000-03-22',1,'1111222233334444','Via G.Luigi X','12345'),
('marco@gmail.com','user',SHA2('user', 256),'marco','rossi','2000-02-23',0,'1111222233334444','Via G.Luigi X','12345');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `composizione`
--

DROP TABLE IF EXISTS `composizione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `composizione` (
  `id_ordine` int NOT NULL,
  `id_prodotto` int NOT NULL,
  `quantita` int NOT NULL,
  `prezzo_tot` double NOT NULL,
  `iva` varchar(100) NOT NULL,
  PRIMARY KEY (`id_ordine`,`id_prodotto`),
  KEY `id_prodotto` (`id_prodotto`),
  CONSTRAINT `composizione_ibfk_1` FOREIGN KEY (`id_ordine`) REFERENCES `ordine` (`id_ordine`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `composizione_ibfk_2` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `composizione`
--

LOCK TABLES `composizione` WRITE;
/*!40000 ALTER TABLE `composizione` DISABLE KEYS */;
INSERT INTO `composizione` VALUES (1,10,1,65.99,'3%'),(2,10,2,131.98,'3%'),(2,11,1,55.99,'3%'),(2,12,1,35.99,'3%'),(3,3,1,51,'3%'),(3,7,1,41,'3%'),(4,4,2,139.98,'3%'),(4,5,1,60,'3%'),(5,10,3,197.96999999999997,'3%'),(6,13,2,71.98,'3%'),(7,4,1,69.99,'3%'),(7,8,1,40,'3%'),(7,11,1,55.99,'3%');
/*!40000 ALTER TABLE `composizione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `indirizzo_spedizione`
--

DROP TABLE IF EXISTS `indirizzo_spedizione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `indirizzo_spedizione` (
  `indirizzo` varchar(100) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `cap` varchar(100) NOT NULL,
  `provincia` varchar(100) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cognome` varchar(100) NOT NULL,
  `citta` varchar(100) NOT NULL,
  PRIMARY KEY (`indirizzo`,`cap`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `indirizzo_spedizione`
--

LOCK TABLES `indirizzo_spedizione` WRITE;
/*!40000 ALTER TABLE `indirizzo_spedizione` DISABLE KEYS */;
INSERT INTO `indirizzo_spedizione` VALUES ('Via G.Luigi X','1234567890','12345','Napoli','Mario','Rossi','Nola');
/*!40000 ALTER TABLE `indirizzo_spedizione` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metodo_pagamento`
--

DROP TABLE IF EXISTS `metodo_pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metodo_pagamento` (
  `numero_carta` varchar(16) NOT NULL,
  `scadenza_carta` date NOT NULL,
  `titolare_carta` varchar(100) NOT NULL,
  PRIMARY KEY (`numero_carta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metodo_pagamento`
--

LOCK TABLES `metodo_pagamento` WRITE;
/*!40000 ALTER TABLE `metodo_pagamento` DISABLE KEYS */;
INSERT INTO `metodo_pagamento` VALUES ('1111222233334444','2025-05-10','Livio Vona');
/*!40000 ALTER TABLE `metodo_pagamento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ordine`
--

DROP TABLE IF EXISTS `ordine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ordine` (
  `id_ordine` int NOT NULL AUTO_INCREMENT,
  `stato` varchar(100) NOT NULL,
  `data_ordine` date NOT NULL,
  `email` varchar(100) NOT NULL,
  `importo_totale` double NOT NULL,
  `carta_credito` varchar(16) NOT NULL,
  `indirizzo` varchar(100) NOT NULL,
  `cap` varchar(100) NOT NULL,
  PRIMARY KEY (`id_ordine`),
  KEY `email` (`email`),
  KEY `carta_credito` (`carta_credito`),
  KEY `indirizzo` (`indirizzo`,`cap`),
  CONSTRAINT `ordine_ibfk_1` FOREIGN KEY (`email`) REFERENCES `cliente` (`email`) ON UPDATE CASCADE,
  CONSTRAINT `ordine_ibfk_2` FOREIGN KEY (`carta_credito`) REFERENCES `metodo_pagamento` (`numero_carta`),
  CONSTRAINT `ordine_ibfk_3` FOREIGN KEY (`indirizzo`, `cap`) REFERENCES `indirizzo_spedizione` (`indirizzo`, `cap`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ordine`
--

LOCK TABLES `ordine` WRITE;
/*!40000 ALTER TABLE `ordine` DISABLE KEYS */;
INSERT INTO `ordine` VALUES (1,'confermato','2021-06-24','liviovona24@gmail.com',65.99,'1111222233334444','Via G.Luigi X','12345'),(2,'confermato','2021-06-24','marco@gmail.com',223.96,'1111222233334444','Via G.Luigi X','12345'),(3,'confermato','2021-06-24','marco@gmail.com',92,'1111222233334444','Via G.Luigi X','12345'),(4,'confermato','2021-06-24','marco@gmail.com',199.98,'1111222233334444','Via G.Luigi X','12345'),(5,'confermato','2021-06-24','liviovona24@gmail.com',197.96999999999997,'1111222233334444','Via G.Luigi X','12345'),(6,'confermato','2021-06-25','liviovona24@gmail.com',71.98,'1111222233334444','Via G.Luigi X','12345'),(7,'confermato','2021-06-25','liviovona24@gmail.com',165.98,'1111222233334444','Via G.Luigi X','12345');
/*!40000 ALTER TABLE `ordine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodotto`
--

DROP TABLE IF EXISTS `prodotto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodotto` (
  `id_prodotto` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `descrizione` varchar(100) NOT NULL,
  `descrizione_dettagliata` text,
  `iva` varchar(100) NOT NULL,
  `in_vendita` tinyint(1) NOT NULL,
  `data_uscita` date NOT NULL,
  `prezzo` double NOT NULL,
  `quantita` int NOT NULL,
  `immagine` varchar(100) NOT NULL,
  `piattaforma` varchar(100) NOT NULL,
  `genere` varchar(100) NOT NULL,
  PRIMARY KEY (`id_prodotto`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodotto`
--

LOCK TABLES `prodotto` WRITE;
/*!40000 ALTER TABLE `prodotto` DISABLE KEYS */;
INSERT INTO `prodotto` VALUES (1,'Spider-Man Miles Morales','Marvel\'s Spider-Man Miles Morales - PlayStation 4',NULL,'3%',1,'2020-12-13',45.99,60,'images\\SpiderManMilesMoralesPS4.jpg','PlayStation 4','Avventura'),(2,'Fifa 21','Fifa 21 - PlayStation 5',NULL,'3%',1,'2020-10-13',35.99,50,'images\\fifa21PS5.jpg','PlayStation 5','Simulazione, Sportivo'),(3,'Mario Kart 8 Deluxe','Mario Kart 8 Deluxe - Switch',NULL,'3%',1,'2017-04-28',51,59,'images\\MarioKart8Deluxe.jpg','Nintendo Switch','Gioco Di Guida'),(4,'Resident Evil Village','Resident Evil Village - Standard Edition Xbox Series',NULL,'3%',1,'2021-05-06',69.99,27,'images\\ResidentEvilVillageXboxSeries.jpg','Xbox Series','Horror - Azione'),(5,'Mass Effect - LE','Mass Effect (Legendary Edition) - Xbox One',NULL,'3%',1,'2021-05-13',60,39,'images\\MassEffectLegendaryEditionXboxOne.jpg','Xbox One','Gioco di ruolo - Azione'),(6,'Fifa 21','Fifa 21 - Xbox One','null','3%',1,'2020-10-13',35.99,50,'images\\Fifa21XboxOne.jpg','Xbox One','calcio'),(7,'The Legend Of Zelda','The Legend of Zelda Breath of the Wild - Switch',NULL,'3%',1,'2017-03-03',41,29,'images\\ZeldaSwitch.jpg','Nintendo Switch','Avventura, Gioco di Ruolo, Open World'),(8,'Nba 2k21','NBA 2K21 - Xbox Series',NULL,'3%',1,'2020-10-10',40,29,'images\\Nba2k21XboxSeries.jpg','Xbox Series','Simulazione, Sportivo'),(9,'Nba 2k21 (MFE)','NBA 2K21 (MAMBA FOREVER EDITION) - Xbox Series',NULL,'3%',1,'2020-10-10',50,20,'images\\Nba2k21MEXboxSeries.jpg','Xbox Series','Simulazione, Sportivo'),(10,'Rachet & Clank','Rachet & Clank - PlayStation 5',NULL,'3%',1,'2021-06-11',65.99,44,'images\\RachetClankPS5.jpg','PlayStation 5','Avventura, Azione'),(11,'Hitman 3','Hitman 3 - XboxSeries',NULL,'3%',1,'2020-10-13',55.99,48,'images\\Hitman3XboxSeries.jpg','Xbox Series','Azione'),(12,'Devil May Cry 5','Devil May Cry 5 Special Edition - Xbox Series',NULL,'3%',1,'2020-11-10',35.99,49,'images\\DevilMayCry5SpecialEditionXboxSeries.jpg','Xbox Series','Azione'),(13,'Subnautica below 0','Subnautica Below Zero - Xbox Series',NULL,'3%',1,'2020-10-13',35.99,48,'images\\SubnauticaXboxSeries.jpg','Xbox Series','Avventura, Open World');
/*!40000 ALTER TABLE `prodotto` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `recensione`
--

DROP TABLE IF EXISTS `recensione`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recensione` (
  `id_recensione` int NOT NULL AUTO_INCREMENT,
  `voto` int DEFAULT NULL,
  `commento` varchar(1000) DEFAULT NULL,
  `data_recensione` date NOT NULL,
  `cliente` varchar(100) NOT NULL,
  `id_prodotto` int NOT NULL,
  PRIMARY KEY (`id_recensione`),
  KEY `cliente` (`cliente`),
  KEY `id_prodotto` (`id_prodotto`),
  CONSTRAINT `recensione_ibfk_1` FOREIGN KEY (`cliente`) REFERENCES `cliente` (`email`) ON UPDATE CASCADE,
  CONSTRAINT `recensione_ibfk_2` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotto` (`id_prodotto`),
  CONSTRAINT `recensione_chk_1` CHECK (((`voto` > 0) and (`voto` < 6)))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recensione`
--

LOCK TABLES `recensione` WRITE;
/*!40000 ALTER TABLE `recensione` DISABLE KEYS */;
/*!40000 ALTER TABLE `recensione` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-06-25 11:39:26
