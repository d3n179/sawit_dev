/*
Navicat MySQL Data Transfer

Source Server         : LOCALHOST
Source Server Version : 50516
Source Host           : localhost:3306
Source Database       : sawit_dev

Target Server Type    : MYSQL
Target Server Version : 50516
File Encoding         : 65001

Date: 2017-07-21 05:49:29
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tbt_jurnal_pembelian
-- ----------------------------
DROP TABLE IF EXISTS `tbt_jurnal_pembelian`;
CREATE TABLE `tbt_jurnal_pembelian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) DEFAULT NULL,
  `jns_transaksi` char(1) DEFAULT '0',
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT '00:00:00',
  `keterangan` varchar(80) DEFAULT NULL,
  `jumlah_saldo` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
