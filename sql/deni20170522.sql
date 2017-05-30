ALTER TABLE `tbm_jabatan`
ADD COLUMN `tunjangan_komunikasi`  float(11,0) NULL AFTER `tunjangan_jabatan`;


-- MySQL dump 10.13  Distrib 5.5.55, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: sawit
-- ------------------------------------------------------
-- Server version	5.5.55-0ubuntu0.14.04.1

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
-- Table structure for table `tbm_golongan_karyawan`
--

DROP TABLE IF EXISTS `tbm_golongan_karyawan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbm_golongan_karyawan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(60) DEFAULT NULL,
  `gaji_pokok` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbm_golongan_karyawan`
--

LOCK TABLES `tbm_golongan_karyawan` WRITE;
/*!40000 ALTER TABLE `tbm_golongan_karyawan` DISABLE KEYS */;
INSERT INTO `tbm_golongan_karyawan` VALUES (1,'F-1',2500000.00,'0'),(2,'F-2',2350000.00,'0'),(3,'F-3',2450000.00,'1'),(4,'F-3',2450000.00,'0'),(5,'G-1',3000000.00,'0');
/*!40000 ALTER TABLE `tbm_golongan_karyawan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbt_lembur_karyawan`
--

DROP TABLE IF EXISTS `tbt_lembur_karyawan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tbt_lembur_karyawan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_karyawan` int(11) DEFAULT NULL,
  `tgl` date DEFAULT NULL,
  `lama_lembur` int(11) DEFAULT NULL,
  `jns_lembur` char(1) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbt_lembur_karyawan`
--

LOCK TABLES `tbt_lembur_karyawan` WRITE;
/*!40000 ALTER TABLE `tbt_lembur_karyawan` DISABLE KEYS */;
INSERT INTO `tbt_lembur_karyawan` VALUES (1,1,'2017-05-21',5,'1','0'),(2,1,'2017-05-20',4,'3','0');
/*!40000 ALTER TABLE `tbt_lembur_karyawan` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-05-22 21:17:54
