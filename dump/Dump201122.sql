CREATE DATABASE  IF NOT EXISTS `bdd_garage` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `bdd_garage`;
-- MySQL dump 10.13  Distrib 5.7.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: bdd_garage
-- ------------------------------------------------------
-- Server version	5.7.16-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `appartient`
--

DROP TABLE IF EXISTS `appartient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appartient` (
  `IDclient` int(11) NOT NULL,
  `immatriculation` varchar(15) NOT NULL,
  PRIMARY KEY (`IDclient`,`immatriculation`),
  KEY `FK_appartient_immatriculation_idx` (`immatriculation`),
  CONSTRAINT `FK_appartient_IDclient` FOREIGN KEY (`IDclient`) REFERENCES `clients` (`IDclient`),
  CONSTRAINT `FK_appartient_immatriculation` FOREIGN KEY (`immatriculation`) REFERENCES `vehicules` (`immatriculation`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appartient`
--

LOCK TABLES `appartient` WRITE;
/*!40000 ALTER TABLE `appartient` DISABLE KEYS */;
/*!40000 ALTER TABLE `appartient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clients` (
  `IDclient` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `prenom` varchar(45) NOT NULL,
  `nomCommune` varchar(45) NOT NULL,
  `IDreferent` int(11) NOT NULL,
  PRIMARY KEY (`IDclient`),
  KEY `FK_clients_IDreferent_idx` (`IDreferent`),
  CONSTRAINT `FK_clients_IDreferent` FOREIGN KEY (`IDreferent`) REFERENCES `referents` (`IDreferent`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='	';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,'Greengrass','Paul','Lyon',1),(2,'Hamilton','Charles','Ecully',1),(3,'Hudson','Lucas','Lyon',1),(4,'Mitchell','Karen','Lyon',1),(5,'McDonald','Rachel','Lyon',1),(6,'Douglas','Lauren','Lyon',2),(7,'Douglas','Mike','Lyon',2),(8,'Thiel','Peter','Vaise',1);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commentaires`
--

DROP TABLE IF EXISTS `commentaires`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `commentaires` (
  `IDcommentaires` int(11) NOT NULL AUTO_INCREMENT,
  `IDintervention` int(11) NOT NULL,
  `IDtechnicien` int(11) NOT NULL,
  `commentaire` longtext NOT NULL,
  `dateHeureCommentaire` datetime NOT NULL,
  PRIMARY KEY (`IDcommentaires`),
  KEY `FK_commentaires_IDtechnicien_idx` (`IDtechnicien`),
  KEY `FK_commentaires_IDintervention_idx` (`IDintervention`),
  CONSTRAINT `FK_commentaires_IDintervention` FOREIGN KEY (`IDintervention`) REFERENCES `interventions` (`IDintervention`),
  CONSTRAINT `FK_commentaires_IDtechnicien` FOREIGN KEY (`IDtechnicien`) REFERENCES `techniciens` (`IDtechnicien`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commentaires`
--

LOCK TABLES `commentaires` WRITE;
/*!40000 ALTER TABLE `commentaires` DISABLE KEYS */;
/*!40000 ALTER TABLE `commentaires` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `forfaits`
--

DROP TABLE IF EXISTS `forfaits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `forfaits` (
  `typeIntervention` varchar(45) NOT NULL,
  `prixForfait` double(13,2) NOT NULL,
  PRIMARY KEY (`typeIntervention`),
  KEY `index_prixForfait` (`prixForfait`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `forfaits`
--

LOCK TABLES `forfaits` WRITE;
/*!40000 ALTER TABLE `forfaits` DISABLE KEYS */;
/*!40000 ALTER TABLE `forfaits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interventions`
--

DROP TABLE IF EXISTS `interventions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `interventions` (
  `IDintervention` int(11) NOT NULL AUTO_INCREMENT,
  `typeIntervention` varchar(45) NOT NULL,
  `prixForfait` double(13,2) NOT NULL,
  `prixPiece` double(13,2) NOT NULL,
  `prixMainOeuvre` double(13,2) NOT NULL,
  `kilometrage` int(20) NOT NULL,
  `dateArrivee` date NOT NULL,
  `immatriculation` varchar(15) NOT NULL,
  PRIMARY KEY (`IDintervention`),
  KEY `FK_interventions_immatriculation_idx` (`immatriculation`),
  KEY `FK_interventions_typeIntervention_idx` (`typeIntervention`),
  KEY `FK_interventions_prixForfait_idx` (`prixForfait`),
  CONSTRAINT `FK_interventions_immatriculation` FOREIGN KEY (`immatriculation`) REFERENCES `vehicules` (`immatriculation`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_interventions_prixForfait` FOREIGN KEY (`prixForfait`) REFERENCES `forfaits` (`prixForfait`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_interventions_typeIntervention` FOREIGN KEY (`typeIntervention`) REFERENCES `forfaits` (`typeIntervention`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interventions`
--

LOCK TABLES `interventions` WRITE;
/*!40000 ALTER TABLE `interventions` DISABLE KEYS */;
/*!40000 ALTER TABLE `interventions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `referents`
--

DROP TABLE IF EXISTS `referents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `referents` (
  `IDreferent` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `prenom` varchar(45) NOT NULL,
  PRIMARY KEY (`IDreferent`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `referents`
--

LOCK TABLES `referents` WRITE;
/*!40000 ALTER TABLE `referents` DISABLE KEYS */;
INSERT INTO `referents` VALUES (1,'Neymar','Jean'),(2,'Liguili','Guy');
/*!40000 ALTER TABLE `referents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repare`
--

DROP TABLE IF EXISTS `repare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repare` (
  `IDtechnicien` int(11) NOT NULL,
  `IDintervention` int(11) NOT NULL,
  PRIMARY KEY (`IDtechnicien`,`IDintervention`),
  KEY `FK_repare_IDintervention_idx` (`IDintervention`),
  CONSTRAINT `FK_repare_IDintervention` FOREIGN KEY (`IDintervention`) REFERENCES `interventions` (`IDintervention`),
  CONSTRAINT `FK_repare_IDtechnicien` FOREIGN KEY (`IDtechnicien`) REFERENCES `techniciens` (`IDtechnicien`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repare`
--

LOCK TABLES `repare` WRITE;
/*!40000 ALTER TABLE `repare` DISABLE KEYS */;
/*!40000 ALTER TABLE `repare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `techniciens`
--

DROP TABLE IF EXISTS `techniciens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `techniciens` (
  `IDtechnicien` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(45) NOT NULL,
  `prenom` varchar(45) NOT NULL,
  PRIMARY KEY (`IDtechnicien`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `techniciens`
--

LOCK TABLES `techniciens` WRITE;
/*!40000 ALTER TABLE `techniciens` DISABLE KEYS */;
/*!40000 ALTER TABLE `techniciens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicules`
--

DROP TABLE IF EXISTS `vehicules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vehicules` (
  `immatriculation` varchar(15) NOT NULL,
  `typeVehicule` varchar(45) NOT NULL,
  `marque` varchar(45) NOT NULL,
  `annee` year(4) NOT NULL,
  PRIMARY KEY (`immatriculation`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicules`
--

LOCK TABLES `vehicules` WRITE;
/*!40000 ALTER TABLE `vehicules` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicules` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-12-26  9:54:44
