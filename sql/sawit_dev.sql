/*
Navicat MySQL Data Transfer

Source Server         : LOCALHOST
Source Server Version : 50555
Source Host           : localhost:3306
Source Database       : sawit_dev

Target Server Type    : MYSQL
Target Server Version : 50555
File Encoding         : 65001

Date: 2017-06-10 02:03:47
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tbd_pemasok_barang
-- ----------------------------
DROP TABLE IF EXISTS `tbd_pemasok_barang`;
CREATE TABLE `tbd_pemasok_barang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_barang` int(11) DEFAULT NULL,
  `id_pemasok` int(11) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbd_pemasok_barang
-- ----------------------------

-- ----------------------------
-- Table structure for tbd_perusahaan
-- ----------------------------
DROP TABLE IF EXISTS `tbd_perusahaan`;
CREATE TABLE `tbd_perusahaan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) DEFAULT NULL,
  `username_pemilik` varchar(255) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `telepon` varchar(255) DEFAULT '',
  `email` varchar(255) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbd_perusahaan
-- ----------------------------
INSERT INTO `tbd_perusahaan` VALUES ('1', 'PT. SINAR HALOMOAN', 'admin', 'JL. LINTAS SIBUHUAN - RIAU KM. 15\nKAB. PADANG LAWAS - SUMATERA UTARA', '081375765977', '', '0');

-- ----------------------------
-- Table structure for tbd_stok_barang
-- ----------------------------
DROP TABLE IF EXISTS `tbd_stok_barang`;
CREATE TABLE `tbd_stok_barang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_barang` int(11) DEFAULT NULL,
  `stok` float(11,2) DEFAULT NULL,
  `expired_date` date DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbd_stok_barang
-- ----------------------------
INSERT INTO `tbd_stok_barang` VALUES ('1', '6', '10000000.00', '0000-00-00', '0');
INSERT INTO `tbd_stok_barang` VALUES ('2', '7', '500000.00', '0000-00-00', '0');
INSERT INTO `tbd_stok_barang` VALUES ('3', '9', '3374000.00', '0000-00-00', '0');
INSERT INTO `tbd_stok_barang` VALUES ('4', '10', '189422.88', '0000-00-00', '0');
INSERT INTO `tbd_stok_barang` VALUES ('5', '11', '24966.63', '0000-00-00', '0');
INSERT INTO `tbd_stok_barang` VALUES ('6', '1021', '764938560.00', '0000-00-00', '0');
INSERT INTO `tbd_stok_barang` VALUES ('7', '13', '360.00', '0000-00-00', '0');
INSERT INTO `tbd_stok_barang` VALUES ('8', '14', '200.00', '0000-00-00', '0');
INSERT INTO `tbd_stok_barang` VALUES ('9', '12', '4000.00', '0000-00-00', '0');
INSERT INTO `tbd_stok_barang` VALUES ('10', '1020', '25580000.00', '0000-00-00', '0');
INSERT INTO `tbd_stok_barang` VALUES ('11', '785', '400.00', '0000-00-00', '0');

-- ----------------------------
-- Table structure for tbd_user
-- ----------------------------
DROP TABLE IF EXISTS `tbd_user`;
CREATE TABLE `tbd_user` (
  `username` varchar(15) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `group` int(11) DEFAULT NULL,
  `status` char(1) NOT NULL,
  `tgl_create` date NOT NULL,
  `wkt_create` char(8) NOT NULL,
  `tgl_log` date NOT NULL,
  `wkt_log` char(8) NOT NULL,
  `st_log` char(1) DEFAULT '0',
  `ssid` varchar(150) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`username`),
  KEY `nip` (`tgl_log`,`wkt_log`,`st_log`,`ssid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='User login manajemen!';

-- ----------------------------
-- Records of tbd_user
-- ----------------------------
INSERT INTO `tbd_user` VALUES ('admin', '5e0f71d35f82960d72d60a8299c2a626', 'putra mahkota alam hsb', '1', '1', '2011-10-03', '14:16:08', '2017-06-01', '6:58:22', '0', '', '0');
INSERT INTO `tbd_user` VALUES ('bamz', 'a9d3b5ad5cade993e537dc01f2ac6030', 'bamz', '1', '1', '2016-01-21', '14:39:27', '2016-02-05', '12:34:34', '0', '', '1');
INSERT INTO `tbd_user` VALUES ('daulay', '57644532717f4075c0ab94ce5d8a0e68', 'Adil Habib Daulay', '77', '1', '2017-04-28', '10:58:39', '2017-05-31', '10:21:23', '1', '', '0');
INSERT INTO `tbd_user` VALUES ('duha', 'e10adc3949ba59abbe56e057f20f883e', 'Duha Sukrina Harahap', '78', '1', '2017-05-23', '12:24:00', '2017-05-26', '11:39:21', '1', '', '0');
INSERT INTO `tbd_user` VALUES ('febi', '827ccb0eea8a706c4c34a16891f84e7b', 'febi', '2', '1', '2016-01-21', '14:36:54', '2016-02-03', '18:15:03', '0', '', '1');
INSERT INTO `tbd_user` VALUES ('Futri', 'e10adc3949ba59abbe56e057f20f883e', 'Futri Sasmeita Hasibuan', '75', '1', '2017-05-10', '4:45:58', '2017-06-02', '9:25:06', '1', '', '0');
INSERT INTO `tbd_user` VALUES ('gita', '827ccb0eea8a706c4c34a16891f84e7b', 'Gita Kharisma Oktavia Hrp', '74', '1', '2017-05-27', '4:10:32', '2017-05-31', '4:40:54', '0', '', '0');
INSERT INTO `tbd_user` VALUES ('gustami', 'e10adc3949ba59abbe56e057f20f883e', 'Gustami', '76', '1', '2017-05-24', '10:56:52', '2017-05-29', '10:53:12', '0', '', '0');
INSERT INTO `tbd_user` VALUES ('hadisya', 'e10adc3949ba59abbe56e057f20f883e', 'Hadisya Sally Oktavia Nasution', '80', '1', '2017-05-23', '12:24:58', '2017-05-29', '2:45:38', '0', '', '0');
INSERT INTO `tbd_user` VALUES ('huda', '46d8bee3d4f2615b00099f264c22f1e3', 'huda', '74', '1', '2016-01-26', '19:35:53', '2016-02-03', '10:33:27', '0', '', '1');
INSERT INTO `tbd_user` VALUES ('ida', 'e10adc3949ba59abbe56e057f20f883e', 'Ida Yanti Hasibuan', '3', '1', '2017-05-09', '9:05:20', '2017-06-02', '2:43:37', '1', '', '0');
INSERT INTO `tbd_user` VALUES ('nurmuliana', 'e10adc3949ba59abbe56e057f20f883e', 'Nurmuliana Daulay', '79', '1', '2017-05-24', '7:23:08', '2017-05-24', '9:29:17', '0', '', '0');
INSERT INTO `tbd_user` VALUES ('operator', 'd8578edf8458ce06fbc5bb76a58c5ca4', 'Deni Andriansah', '73', '1', '2015-12-25', '4:04:37', '2015-12-25', '5:46:25', '0', '', '0');
INSERT INTO `tbd_user` VALUES ('pinta', 'bf5e9c42dce63bc7467cb5a6e1959f1e', 'pinta riski mala hasibuan', '3', '1', '2017-05-22', '6:26:41', '2017-06-02', '8:51:40', '1', '', '0');
INSERT INTO `tbd_user` VALUES ('test', 'd8578edf8458ce06fbc5bb76a58c5ca4', 'Test', '2', '1', '2015-12-24', '23:08:14', '2017-04-25', '11:18:59', '0', '', '1');
INSERT INTO `tbd_user` VALUES ('xadmin', 'd8578edf8458ce06fbc5bb76a58c5ca4', 'xadmin', '1', '1', '2011-10-03', '14:16:08', '2017-06-09', '15:54:34', '1', '', '0');

-- ----------------------------
-- Table structure for tbm_agama
-- ----------------------------
DROP TABLE IF EXISTS `tbm_agama`;
CREATE TABLE `tbm_agama` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(200) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_agama
-- ----------------------------
INSERT INTO `tbm_agama` VALUES ('1', 'Islam', '0');
INSERT INTO `tbm_agama` VALUES ('2', 'Kristen Katholik', '0');
INSERT INTO `tbm_agama` VALUES ('3', 'Kristen Protestan', '0');
INSERT INTO `tbm_agama` VALUES ('4', 'Budha', '0');
INSERT INTO `tbm_agama` VALUES ('5', 'Hindu', '0');
INSERT INTO `tbm_agama` VALUES ('6', 'Lainnya', '0');

-- ----------------------------
-- Table structure for tbm_bank
-- ----------------------------
DROP TABLE IF EXISTS `tbm_bank`;
CREATE TABLE `tbm_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(200) DEFAULT NULL,
  `no_rek` varchar(60) DEFAULT NULL,
  `nama_pemilik` varchar(100) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_bank
-- ----------------------------
INSERT INTO `tbm_bank` VALUES ('1', 'BANK PANIN', null, null, '1');
INSERT INTO `tbm_bank` VALUES ('2', 'BANK BCA', '54656755', 'Udeng BUdeng', '1');
INSERT INTO `tbm_bank` VALUES ('3', 'BANK ASIA', '98022341', 'Deni Andriansah', '1');
INSERT INTO `tbm_bank` VALUES ('4', 'BANK BNI', '5476565645', 'Deni Andriansah', '1');
INSERT INTO `tbm_bank` VALUES ('5', 'BANK JB', '958384738', 'Ani', '1');
INSERT INTO `tbm_bank` VALUES ('6', 'BI', null, null, '1');
INSERT INTO `tbm_bank` VALUES ('7', 'BIAYA 1', null, null, '1');
INSERT INTO `tbm_bank` VALUES ('8', 'PETTY CASH', null, null, '');
INSERT INTO `tbm_bank` VALUES ('9', 'ANZ INDONESIA', '4113220100001', 'PT. Sibuah Raya', '0');
INSERT INTO `tbm_bank` VALUES ('10', 'BRI', '36701001119303', 'PT. Mujur Usaha Mandiri', '0');
INSERT INTO `tbm_bank` VALUES ('11', 'BNI', '600760141', 'Pt. Sinar Halomoan', '0');
INSERT INTO `tbm_bank` VALUES ('12', 'BNI', '2021956558', 'Mandurana Tbs', '0');
INSERT INTO `tbm_bank` VALUES ('13', 'BNI', '436696841', 'Ud. Zio', '0');
INSERT INTO `tbm_bank` VALUES ('14', 'BNI', '1980061005', 'Shs', '0');
INSERT INTO `tbm_bank` VALUES ('15', 'BNI', '534531025', 'Ud.rizki', '0');
INSERT INTO `tbm_bank` VALUES ('16', 'BNI', '377354972', 'Ud. Mitra Pribadi', '0');
INSERT INTO `tbm_bank` VALUES ('17', 'BNI', '458054499', 'Ud. Pinarik Jaya', '0');

-- ----------------------------
-- Table structure for tbm_barang
-- ----------------------------
DROP TABLE IF EXISTS `tbm_barang`;
CREATE TABLE `tbm_barang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode_barang` varchar(50) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `kategori_id` int(11) DEFAULT NULL,
  `kelompok_id` char(1) DEFAULT '0',
  `min_stock` float(11,2) DEFAULT NULL,
  `max_stock` float(11,2) DEFAULT NULL,
  `max_beli_bulanan` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1026 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tbm_barang
-- ----------------------------
INSERT INTO `tbm_barang` VALUES ('10', null, 'CPO', '5', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('11', null, 'PK', '5', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('12', 'B00GB400', 'GREASE BURGARI 400 EP', '10', '0', '1.00', '3.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('13', 'B00GP001', 'GREASE PICOLIK', '10', '0', '1.00', '3.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('14', 'B00GN215', 'GREASE NEUTRONLUB -215', '10', '0', '1.00', '3.00', '2000.00', '0');
INSERT INTO `tbm_barang` VALUES ('15', 'B00GU001', 'GREASE MERK COMPOIL', '10', '0', '1.00', '3.00', '5000.00', '0');
INSERT INTO `tbm_barang` VALUES ('16', 'B00MB001', 'MINYAK BENSIN', '10', '0', '10.00', '20.00', '1000.00', '0');
INSERT INTO `tbm_barang` VALUES ('17', 'B00MS001', 'MINYAK SOLAR SPBU', '10', '0', '50.00', '800.00', '1000.00', '0');
INSERT INTO `tbm_barang` VALUES ('18', 'B00NAL01', 'NEUTRON ANTI LEAK - IGB', '10', '0', '1.00', '3.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('19', 'B00NO001', 'NEUTRON OIL - 10.000 RPRN', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('20', 'B00NO011', 'NEUTRON 011 HT', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('21', 'B00NO051', 'NEUTRON 051 EM ', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('22', 'B00NO057', 'NEUTRON  057 HT', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('23', 'B00OLI10', 'OLI MEDITRAN SAE -10', '10', '0', '80.00', '209.00', '5000.00', '0');
INSERT INTO `tbm_barang` VALUES ('24', 'B00OLI30', 'OLI MEDITRAN SAE-30', '10', '0', '80.00', '209.00', '5000.00', '0');
INSERT INTO `tbm_barang` VALUES ('25', 'B00OM040', 'OLI MEDITRAN SX-40 (Ltr)', '10', '0', '100.00', '209.00', '5000.00', '0');
INSERT INTO `tbm_barang` VALUES ('26', 'B00OM320', 'OLI MASRI -RVG 320', '10', '0', '100.00', '209.00', '5000.00', '0');
INSERT INTO `tbm_barang` VALUES ('27', 'B00OM460', 'OLI MASRI -RVG 460', '10', '0', '100.00', '209.00', '5000.00', '0');
INSERT INTO `tbm_barang` VALUES ('28', 'B00OMS15', 'OLI MEDITRAN SX-15 W-40 (Drum)', '10', '0', '100.00', '209.00', '5000.00', '0');
INSERT INTO `tbm_barang` VALUES ('29', 'B00OTS68', 'OLI TURBO SHELL T68', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('30', 'B00OTS02', 'OLI TRAVO/OLI SHELL DIALA -BS2', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('31', 'B00OLI90', 'OLI 90', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('32', 'B00OT046', 'OLI TURALIT 48 ISO VG 46', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('33', 'B00SWD40', 'SYSCHEM WD-40', '10', '0', '2.00', '5.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('34', 'B00SY867', 'SYSCHEM S-867 CONTACT', '10', '0', '2.00', '5.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('35', 'B00SY866', 'SYSCHEM S-866 (BELT DRESSING SPRAY)', '10', '0', '2.00', '5.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('36', 'B00SIV01', 'SYSCHEM INSULETING RED VARNISH', '10', '0', '2.00', '5.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('37', 'B00BMI01', 'BBM INDUSTRI', '10', '0', '500.00', '12000.00', '36000.00', '0');
INSERT INTO `tbm_barang` VALUES ('38', 'B00BMI02', 'BBM SPBU', '10', '0', '10.00', '100.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('39', 'B00ATF02', 'OLI ATF DEXTRON 2', '10', '0', '10.00', '40.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('40', 'C00ADK01', 'AMPLOP DINAS KECIL', '11', '0', '2.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('41', 'C00ADB01', 'AMPLOP DINAS BESAR', '11', '0', '2.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('42', 'C00ADS01', 'AMPLOP DINAS SEDANG', '11', '0', '2.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('43', 'C00AH003', 'ANAK HEKTER NO.3', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('44', 'C00AH010', 'ANAK HEKTER NO.10', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('45', 'C00APK01', 'AMPLOP PUTIH KECIL', '11', '0', '2.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('46', 'C00BA001', 'BUKU AGENDA', '11', '0', '2.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('47', 'C00BC107', 'BINDER CLIP NO.107', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('48', 'C00BC155', 'BINDER CLIP NO.155', '11', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('49', 'C00BC200', 'BINDER CLIP N0.200', '11', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('50', 'C00BST01', 'BANTALAN STEMPEL', '11', '0', '2.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('51', 'C00BTB30', 'BUKU TULIS BIASA @ 30 LEMBAR', '11', '0', '3.00', '12.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('52', 'C00BTB50', 'BUKU TULIS BIASA @ 50 LEMBAR', '11', '0', '3.00', '12.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('53', 'C00BTBB1', 'BUKU TULIS BIG BOSS  @50 LBR', '11', '0', '3.00', '12.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('54', 'C00BTF01', 'BUKU TULIS FOLIO', '11', '0', '3.00', '12.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('55', 'C00BTK01', 'BUKU TULIS KWARTO', '11', '0', '2.00', '12.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('56', 'C00BXF01', 'BOX FILE', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('57', 'C00CCK01', 'CARBON CAP KAPAL', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('58', 'C00CF001', 'CLIP FILE', '11', '0', '3.00', '12.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('59', 'C00CTK10', 'CATRIK 810', '11', '0', '2.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('60', 'C00CTK11', 'CATRIK 811', '11', '0', '2.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('61', 'C00CTK45', 'CATRIDGE PRINTER PG 745 (BLACK)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('62', 'C00CTK46', 'CATRIDGE PRINTER PG 746 (COLOR)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('63', 'C00FBK01', 'FAKTUR BON KECIL', '11', '0', '3.00', '12.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('64', 'C00HEK10', 'HEKTER NO.10 BAGUS', '11', '0', '2.00', '12.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('65', 'C00KC154', 'KERTAS CONTINIOUS FORM UK. 9,5 x 11\" (UK. 1/2) 4 FLY', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('66', 'C00KCF52', 'KERTAS CONTINIOUS FORM UK. 9,5 x 11\" (UK. 1/2) 2 FLY', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('67', 'C00KCF95', 'KERTAS COUNTINIOUS FORM 9,5\"X11\" (4PLY)', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('68', 'C00KHA04', 'KERTAS HVS A4', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('69', 'C00KHF04', 'KERTAS HVS F4', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('70', 'C00KJH01', 'KERTAS JERUK', '11', '0', '5.00', '24.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('71', 'C00LB001 ', 'LAKBAN BENING', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('72', 'C00LH001', 'LAKBAN HITAM', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('73', 'C00LK001', 'LAKBAN KUNING', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('74', 'C00LKP01', 'LEM KERTAS POVINAL', '11', '0', '3.00', '12.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('75', 'C00MB001', 'MAP BIASA', '11', '0', '3.00', '24.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('76', 'C00MP401', 'MAP PAKAR 401', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('77', 'C00MP402', 'MAP PAKAR 402', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('78', 'C00NA403', 'NOTES A-403', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('79', 'C00NA501', 'NOTES A-501', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('80', 'C00PF001', 'PAPER FASTENER', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('81', 'C00PK001', 'PLASTIK KACA UK. FOLIO', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('82', 'C00PKT01', 'PELOBANG KERTAS', '11', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('83', 'C00PPE01', 'PITA PRINTER EPSON LX-310', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('84', 'C00PST01', 'PULPEN STANDART', '11', '0', '20.00', '120.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('85', 'C00PT001', 'PAPAN TULIS ', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('86', 'C00REM01', 'REMOVER ( PENCABUT ANAK HEKTER )', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('87', 'C00ROL30', 'ROLL BESI 30 CM', '11', '0', '3.00', '12.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('88', 'C00SF001', 'SPRING FILE', '11', '0', '10.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('89', 'C00SNP01', 'SPIDOL NON PERMANET', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('90', 'C00SP001', 'CETAK SURAT PENGANTAR TBS (SP TBS)', '11', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('91', 'C00SPE01', 'SPIDOL PERMANENT', '11', '0', '3.00', '12.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('92', 'C00STB01', 'STABILLOW', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('93', 'C00TPB01', 'TINTA PRINTER W/BIRU', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('94', 'C00TPH01', 'TINTA PRINTER W/HITAM', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('95', 'C00TPK01', 'TINTA PRINTER W/KUNING', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('96', 'C00TPM01', 'TINTA PRINTER W/MERAH', '11', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('97', 'C00TSB01', 'TINTA STEMPEL WARNA BIRU', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('98', 'C00TSC01', 'TINTA SOFRUM CANON', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('99', 'C00TYP01', 'TYPE-X', '11', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('100', 'E00AS001', 'ALARM SIRENE', '9', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('101', 'E00AM005', 'AMPERE METER (0-4000) 2000/5A', '9', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('102', 'E00AM050', 'AMPERE METER 0-100 50/5A', '9', '0', '2.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('103', 'E00AS001', 'AUXILARY SCHENNEIDER', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('104', 'E00AVR01', 'AVR RILAY 8888 WM WEGA', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('105', 'E00AVR50', 'AVR R450', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('106', 'E00AVR02', 'AVR VS420-7A-S1A2 BESTRON', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('107', 'E00BAR20', 'BREAKER 20A', '9', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('108', 'E00BAR50', 'BREAKER 50A', '9', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('109', 'E00BAR80', 'BREAKER 80A', '9', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('110', 'E00BS500', 'BOLA LAMPU SOROT 500 WATT', '9', '0', '3.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('111', 'E00BL500', 'BOLA LAMPU 500 WATT', '9', '0', '3.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('112', 'E00BLH04', 'BOLA LAMPU HPI-T 400 WATT', '9', '0', '3.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('113', 'E00BLH14', 'BOLA LAMPU HANNOCHS 14 WATT', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('114', 'E00BLH18', 'BOLA LAMPU HANNOCHS 18 WATT', '9', '0', '2.00', '3.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('115', 'E00BLH45', 'BOLA LAMPU HANNOCHS 45 WATT', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('116', 'E00BLH85', 'BOLA LAMPU HANNOCHS 85 WATT', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('117', 'E00BLS50', 'BOX LAMPU SON MERCURY 250 WATT', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('118', 'E00BLT18', 'BOLA LAMPU TL 18 WATT', '9', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('119', 'E00BLT18', 'BOX LAMPU TL 18 WATT DOUBLE LAMP', '9', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('120', 'E00BTL18', 'BOX LAMPU TL 18 WATT', '9', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('121', 'E00BLT36', 'BOX LAMPU TL 36 WATT', '9', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('122', 'E00BLT36', 'BOLA LAMPU TL 36 WATT', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('123', 'E00BM075', 'BREAKER METASOL 75 A', '9', '0', '1.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('124', 'E00BM100', 'BREAKER METASOL 100 A', '9', '0', '1.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('125', 'E00BM150', 'BREAKER METASOL 150 A', '9', '0', '1.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('126', 'E00BM200', 'BREAKER METASOL 200 A', '9', '0', '1.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('127', 'E00BM250', 'BOLA LAMPU MERCURY  HPL-N 250 WATT MERK PHILIPS', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('128', 'E00LM250', 'BOLA LAMPU MERCURY 250 WATT M-L', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('129', 'E00BP001', 'BOX PANEL KOSONG', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('130', 'E00BR015', 'BREAKER 3P 15A', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('131', 'E00BR030', 'BREAKER 3P 30A', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('132', 'E00BR040', 'BREAKER 3P 40A', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('133', 'E00BR075', 'BREAKER 3P 75A', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('134', 'E00BR150', 'BREAKER 3P 150A', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('135', 'E00BX500', 'BOX LAMPU SOROT 500 WATT', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('136', 'E00CT005', 'CURRENT TRANSFORMER (CT) 2000/5A TYPE:ICX-I', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('137', 'E00CB003', 'COK BETINA 3 LOBANG', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('138', 'E00CCU28', 'CAPASITOR CP20 CU 28', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('139', 'E00CJ001', 'COK JANTAN', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('140', 'E00CON05', 'CONNECTOR 5MM', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('141', 'E00CM130', 'CONTECTOR MC 130A MITSUBISHI', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('142', 'E00CM030', 'CONTECTOR MC 130A MERK METASOL MAGNETIC', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('143', 'E00CON30', 'CONTECTOR UA30-10-10', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('144', 'E00CON75', 'CONTECTOR UA75-30-11', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('145', 'E00CPB01', 'CLEAM PAKU BETON 1\"', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('146', 'E00CPB10', 'CLEAM PAKU BETON 10MM', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('147', 'E00CSV24', 'COIL AIRTACT DC 24-26DC', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('148', 'E00CT004', 'COUNTER TALLY 4 DIGIT', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('149', 'E00EC350', 'ELCO 350µF 450 V', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('150', 'E00ED001', 'EMAIL DRAT 0.90MM', '9', '0', '10.00', '30.00', '1000.00', '0');
INSERT INTO `tbm_barang` VALUES ('151', 'E00ED060', 'EMAIL DRAT 0.60MM', '9', '0', '10.00', '30.00', '1000.00', '0');
INSERT INTO `tbm_barang` VALUES ('152', 'E00ES001', 'EMERGENCY SWITCH CR-253 5A 250 VAC', '9', '0', '3.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('153', 'E00FKC12', 'FLEXIBLE KABEL COUNDIT Ø 1/2\" @ 50M', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('154', 'E00FKC34', 'FLEXIBLE KABEL COUNDIT Ø 3/4\" @ 50M', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('155', 'E00FL465', 'FITTING 4-65 WATT', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('156', 'E00FM250', 'FITTING MERCURY + KAP LAMPU', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('157', 'E00FS001', 'FOTOSEL', '9', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('158', 'E00FS120', 'FITTING LAMPU SOROT 120 WATT', '9', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('159', 'E00HM220', 'HZ METER CIC 220V', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('160', 'E00HM050', 'HOURS METERS MERK CAMSCO 220-240V 50HZ', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('161', 'E00KAF01', 'KABEL NYAF 1 X 1 MM@ 100M', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('162', 'E00KAF02', 'KABEL NYAF 1 X 8,8 MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('163', 'E00KHY02', 'KABEL NYYHY 2 X 2,5 MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('164', 'E00KHY02', 'KABEL NYHY 2 X 2,5mm @50m', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('165', 'E00KHY04', 'KABEL NYYHY 4 X 2,5mm', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('166', 'E00KL001', 'KABEL LAS', '9', '0', '10.00', '50.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('167', 'E00KLT02', 'KABEL LISTRIK TUWISTIK 2 X 10 MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('168', 'E00KLW27', 'KAP LAMPU WD E27 + FITTING KERAMIK', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('169', 'E00KLW40', 'KAP LAMPU WD E40 + FITTING KERAMIK', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('170', 'E00KMH04', 'KABEL NYMHY 4 X 2,5MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('171', 'E00KT025', 'KABEL TIE 2,5 X 100 MM', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('172', 'E00KT036', 'KABEL TIE 3,6 X 250MM', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('173', 'E00KYA01', 'KABEL NYA 1 X 2,5 SQMM', '9', '0', '1.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('174', 'E00KYA02', 'KABEL NYA 2 X 2,5 MM @ 50M', '9', '0', '1.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('175', 'E00KYH02', 'KABEL NYH 2 X 4MM (@50M', '9', '0', '1.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('176', 'E00KYH04', 'KABEL NYH 4 X 2,5 MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('177', 'E00KYH44', 'KABEL NYH 4 X 4 MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('178', 'E00KYM10', 'KABEL NYM 1 X 10MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('179', 'E00KYM02', 'KABEL NYM 2 X 2,5MM @50 M', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('180', 'E00KYM04', 'KABEL NYM 4 X 2,5MM @ 50M', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('181', 'E00KYY04', 'KABEL NYY 4 X 4MM @ 50 M', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('182', 'E00KYY24', 'KABEL NYY 2 X 4MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('183', 'E00KYY25', 'KABEL NYY 4 X 2,5MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('184', 'E00KWM10', 'KW METER 1000/5A 400V', '9', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('185', 'E00KWM05', 'KW METER 500/5A 400V', '9', '0', '2.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('186', 'E00KWM20', 'KW METER 2000/5A 400V', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('187', 'E00LCB40', 'LCB 2P 40A', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('188', 'E00LH026', 'LAMPU HANNOCS 26 WATT', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('189', 'E00LHK01', 'LAMPU INDIKATOR HIJAU KECIL', '9', '0', '3.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('190', 'E00LKK01', 'LAMPU INDIKATOR KUNING KECIL', '9', '0', '3.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('191', 'E00LMK01', 'LAMPU INDIKATOR MERAH KECIL', '9', '0', '3.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('192', 'E00LIH01', 'LAMPU INDIKATOR HIJAU', '9', '0', '3.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('193', 'E00LIK01', 'LAMPU INDIKATOR KUNING', '9', '0', '3.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('194', 'E00LIM01', 'LAMPU INDIKATOR MERAH', '9', '0', '3.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('195', 'E00LS120', 'LAMPU SOROT 120 WATT', '9', '0', '3.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('196', 'E00LS400', 'LAMPU SOROT HPI-T 400 WATT', '9', '0', '2.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('197', 'E00LT040', 'LAMPU TL 40 WATT', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('198', 'E00LT018', 'LAMPU TL 18 WATT PHILIPS', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('199', 'E00MCB06', 'MCB 1P 6A', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('200', 'E00MCB10', 'MCB 1P 10A', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('201', 'E00MCB20', 'MCB 1P 20A', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('202', 'E00MCB32', 'MCB 1P 32A', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('203', 'E00MCB32', 'MCB 3P 32A', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('204', 'E00MCB40', 'MCB 1P 40A', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('205', 'E00MCB50', 'MCB 1P 50A', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('206', 'E00MCC10', 'MCCB C-10A', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('207', 'E00MCC20', 'MCCB C-20A', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('208', 'E00MCC40', 'MCCB C-40A', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('209', 'E00MTS01', 'MULTI TESTER MERK SANWA (DIGITAL)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('210', 'E00MCL06', 'M. CONTECTOR SCHENNEIDER TYPE: LC1E 06-10M5', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('211', 'E00MCL08', 'M. CONTECTOR SCHENNEIDER TYPE: LC1E 08-10M5', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('212', 'E00MCL09', 'M. CONTECTOR SCHENNEIDER TYPE: LC1E 09-10M5', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('213', 'E00MCL18', 'M. CONTECTOR SCHENNEIDER TYPE: LC1E 18-10M5', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('214', 'E00MCL25', 'M. CONTECTOR SCHENNEIDER TYPE:LC1E 25-10M5', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('215', 'E00MCL30', 'M. CONTECTOR METASOL TYPE:MC1 30A', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('216', 'E00MCL32', 'M. CONTECTOR SCHENNEIDER TYPE: LC1E 32-10M5', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('217', 'E00TOL36', 'T. OVER LOOD LRE36', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('218', 'E00TML01', 'TACO METER TYPE LASER', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('219', 'E00MCL65', 'M. CONTECTOR SCHENNEIDER TYPE: LCIE 65-10M5', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('220', 'E00MM001', 'MICRO METER 0-25MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('221', 'E00MM025', 'MICRO MILLI 0-25MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('222', 'E00PBF01', 'PUSH BOTTOM OFF', '9', '0', '3.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('223', 'E00PBN01', 'PUSH BOTTOM ON', '9', '0', '3.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('224', 'E00PLG01', 'PLERING (TUBING CUTTER)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('225', 'E00PON05', 'POTENSIO 5K', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('226', 'E00RL230', 'RILAY OMRON 240 VAC 5A', '9', '0', '3.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('227', 'E00RP001', 'REL PANEL', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('228', 'E00RT001', 'RUBBER TAPE', '9', '0', '3.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('229', 'E00SK001', 'STOP KONTAK', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('230', 'E00ST001', 'SAKLAR TUNGGAL', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('231', 'E00SK003', 'SELONGSONG KABEL 3MM', '9', '0', '3.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('232', 'E00SC050', 'SKUN CONNECTOR 50MM', '9', '0', '5.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('233', 'E00SC025', 'SKUN CONNECTOR 25MM', '9', '0', '3.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('234', 'E00SK004', 'SKUN KABEL @ 4MM', '9', '0', '5.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('235', 'E00SK004', 'SELONGSONG KABEL 4MM', '9', '0', '5.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('236', 'E00SK005', 'SELONGSONG KABEL 5MM', '9', '0', '5.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('237', 'E00SK006', 'SELONGSONG KABEL 6MM', '9', '0', '5.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('238', 'E00SK008', 'SELONGSONG KABEL 8MM', '9', '0', '5.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('239', 'E00SK010', 'SKUN KABEL @ 10MM + SARUNG', '9', '0', '3.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('240', 'E00SK010', 'SELONGSONG KABEL 10MM', '9', '0', '5.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('241', 'E00SK016', 'SKUN KABEL @ 16MM+ SARUNG', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('242', 'E00SK025', 'SKUN KABEL @ 25MM+ SARUNG', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('243', 'E00SK035', 'SKUN KABEL @ 35MM+ SARUNG', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('244', 'E00SK035', 'SKUN KABEL 35-10', '9', '0', '5.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('245', 'E00SK038', 'SKUN KABEL 35', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('246', 'E00SK050', 'SKUN KABEL 50-10', '9', '0', '5.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('247', 'E00SKG01', 'SKUN KABEL GARPU Ø 1,25 MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('248', 'E00SKG01', 'SKUN KABEL GARPU Ø 1MM / 16-14', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('249', 'E00SLR01', 'SOLDER 300 WATT', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('250', 'E00SLT36', 'SARANG LAMPU TL 36 WATT', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('251', 'E00SS001', 'SELEKTOR SWITCH CR-257R 5A 250 VAC ON/OFF', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('252', 'E00SK070', 'SKUN KABEL 70-10', '9', '0', '5.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('253', 'E00STR01', 'STATER', '9', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('254', 'E00TAK01', 'TANG AMPERE KYORITSU (DIGITAL)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('255', 'E00TB210', 'TRAVO ( BALANCE) 210 WATT', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('256', 'E00TBI20', 'TERMINAL BLOCK T IN 20 C', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('257', 'E00TT001', 'TERMINAL TIMER', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('258', 'E00TBT60', 'TERMINAL BLOCK T IN 60 C', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('259', 'E00TL018', 'TRAVO (BALANCE) LAMPU 18 WATT', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('260', 'E00TM250', 'TRAVO BALANCE MERCURY 250 WATT', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('261', 'E00TMH01', 'TIMAH', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('262', 'E00TOL05', 'T.OVER LOAD LRE05', '9', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('263', 'E00TOL06', 'T.OVER LOAD LRE06', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('264', 'E00TOL08', 'T.OVER LOAD LRE08', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('265', 'E00TOL09', 'T.OVER LOAD LRE09', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('266', 'E00TOL10', 'T.OVER LOAD LRE10', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('267', 'E00TOL14', 'T.OVER LOAD LRE14', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('268', 'E00TOL16', 'T.OVER LOAD LRE16', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('269', 'E00TOL21', 'T.OVER LOAD LRE21', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('270', 'E00TOL22', 'T.OVER LOAD LRE22', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('271', 'E00TOL32', 'T.OVER LOAD LRE32', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('272', 'E00TOL40', 'T.OVER LOAD LRE40', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('273', 'E00TOL61', 'T.OVER LOAD LRE 361', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('274', 'E00TOL65', 'T.OVER LOAD LRE 365', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('275', 'E00TSO01', 'TIMER SWITCH OMRON H3CR (0-30S)', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('276', 'E00TS250', 'TIMER SWITCH OMRON 250 VAC/20 VDC 10A', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('277', 'E00KAF10', 'KABEL NYAF 10MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('278', 'E00ED012', 'EMAIL DRAT 1,2MM', '9', '0', '8.00', '35.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('279', 'E00ED001', 'EMAIL DRAT 1,00MM', '9', '0', '8.00', '35.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('280', 'E00ED075', 'EMAIL DRAT 0,75MM', '9', '0', '8.00', '35.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('281', 'E00YAF70', 'KABEL NYAF 1 X 0.70MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('282', 'E00YAF25', 'KABEL NYAF 1 X 2.5MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('283', 'E00YAF04', 'KABEL NYAF 1 X 4MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('284', 'E00YAF06', 'KABEL NYAF 1 X 6MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('285', 'E00SKN16', 'SKUN 16MM', '9', '0', '5.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('286', 'E00SKN10', 'SKUN 10MM', '9', '0', '5.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('287', 'E00SKN25', 'SKUN 25-8', '9', '0', '5.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('288', 'E00SKN06', 'SKUN 6MM', '9', '0', '5.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('289', '', 'AMPERE METER UK (9 X 9 CM) 0-600 A(CT 300/5A)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('290', 'E00IVR01', 'INSULATING VARNISH RED (SISTEM SEMPROT)', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('291', 'E00CTR50', 'CONNECTOR 50MM', '9', '0', '2.00', '25.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('292', 'E00CT510', 'CT 5/100', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('293', 'E00VM500', 'VOLT METER UK. 9 X 9CM 0-500 CIC', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('294', 'E00KT050', 'KABEL TWISTED 4 X 50MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('295', 'E00YAF50', 'KABEL NYAF 50MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('296', 'E00NYY35', 'KABEL NYY 4 X 35MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('297', 'E00MHY15', 'KABEL NYMHY 4 X 1,5MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('298', 'E00FTL50', 'FITTING + TOPI + BOLA LAMPU ML 220V/250W', '9', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('299', 'E00NYY10', 'KABEL NYY 4 X 10MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('300', 'E00CK001', 'CONNECTOR KABEL', '9', '0', '5.00', '50.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('301', 'E00BTA36', 'BALAST PHILIPS BTA 36 W / 220 V', '9', '0', '2.00', '15.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('302', 'F00AB209', 'ADAFTER BEARING H 209', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('303', 'F00AB211', 'ADAFTER BEARING H 211', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('304', 'F00AFB01', 'AS FAN BOILER', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('305', 'F00AC100', 'AS CONVEYOR Ø 100MM, P:1700MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('306', 'F00BPB01', 'BUSHING POMPA BESAR (SLUDGE TANK PUMP)', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('307', 'F00BPK01', 'BUSHING POMPA KECIL(SLUDGE TANK PUMP)', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('308', 'F00AR309', 'ADAFTER HE 309 ASB', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('309', 'F00AR322', 'ADAFTER HE 322 ASB', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('310', 'F00ACP15', 'ADJUSTING CONE CB P15', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('311', 'F00AS010', 'AS Ø 75MM X 1010 MM DI BUBUT', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('312', 'F00AS124', 'ADAFTER SLEVEE AHX 3124', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('313', 'F00AS210', 'AS Ø 75MM X 1210 MM DI BUBUT', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('314', 'F00AS315', 'ADAFTER SLEVEE H 315', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('315', 'F00AR313', 'ADAFTER H313 WIKA', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('316', 'F00AS316', 'ADAFTER SLEEVE H316', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('317', 'F00AS320', 'ADAFTER SLEEVE H 320', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('318', 'F00ABC04', 'ANGKER BOS COMPLATE GRENDA 4\"', '8', '0', '1.00', '5.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('319', 'F00ASL15', 'AS INTERMEDIT (SHAF LONG CB P15)', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('320', 'F00ASP01', 'ARM STRING PENDEK SEBELAH KANAN', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('321', 'F00ASP01', 'AS POMPA KECIL ', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('322', 'F00ASP02', 'ARM STRING PANJANG', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('323', 'F00ASS15', 'AS INTERMEDIT (SHAF SHORT CB P15)', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('324', 'F00AC001', 'AS CLAYBATH', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('325', 'F00AVC01', 'AS VIBRATING CONDENSATE SEPERTI GAMBAR', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('326', 'F00BID01', 'BALANCING ID FAN', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('327', 'F00BR608', 'BEARING 608Z', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('328', 'F00BF005', 'BEARING FAG 6305 2ZR', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('329', 'F00BF208', 'BEARING UCF 208', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('330', 'F00BF209', 'BEARING FAG 6209 2ZR. C3', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('331', 'F00BF206', 'BEARING FAG 6206 2ZR', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('332', 'F00BF210', 'BEARING UCF 210', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('333', 'F00BF213', 'BEARING UCF 213', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('334', 'F00BF215', 'BEARING FAG 22215', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('335', 'F00BF215', 'BEARING UCF 215', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('336', 'F00BF216', 'BEARING FAG 22216', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('337', 'F00BF222', 'BEARING FAG 22220-E1-C3', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('338', 'F00BF220', 'BEARING FAG 22220-E1-K-C3', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('339', 'F00BF222', 'BEARING FAG 22222-E1-K-C3', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('340', 'F00BF224', 'BEARING FAG 22224 E1-K-C3', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('341', 'F00BRG24', 'BEARING FAG 22224 E1/C3', '8', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('342', 'F00BM017', 'BAUT + MUR 1\" X 7\"', '8', '0', '20.00', '130.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('343', 'F00BM121', 'BAUT + MUR 1/2\" X 1\"', '8', '0', '20.00', '150.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('344', 'F00BM122', 'BAUT + MUR 1/2 X 2\"', '8', '0', '20.00', '130.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('345', 'F00BM123', 'BAUT + MUR 1/2\" X 3\"', '8', '0', '20.00', '150.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('346', 'F00BM125', 'BAUT + MUR 1/2\" X 1½\"', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('347', 'F00BM212', 'BAUT + MUR 1/2\" X 2 ½\"', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('348', 'F00BM255', 'BAUT + MUR 1¼\" X 5\"', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('349', 'F00BM325', 'BAUT + MUR 3/8 X 2½\"', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('350', 'F00BM343', 'BAUT + MUR 3/8\" X 3\"', '8', '0', '20.00', '150.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('351', 'F00BM344', 'BAUT + MUR 3/8\" X 4\"', '8', '0', '20.00', '200.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('352', 'F00BM345', 'BAUT + MUR 3/8\" X 2½\"', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('353', 'F00BM346', 'BAUT + MUR 3/4\" X 6\"', '8', '0', '20.00', '150.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('354', 'F00BM347', 'BAUT + MUR 3/4\" X 7\"', '8', '0', '20.00', '200.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('355', 'F00BM381', 'BAUT + MUR 3/8\" X 1\"', '8', '0', '20.00', '200.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('356', 'F00BM382', 'BAUT + MUR 3/8\" X 2\"', '8', '0', '20.00', '200.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('357', 'F00BM515', 'BAUT + MUR 5/8\" X 1½\"', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('358', 'F00BM525', 'BAUT + MUR 5/8 X 2½\"', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('359', 'F00BM582', 'BAUT + MUR 5/8\" X 2\"', '8', '0', '20.00', '200.00', '1000.00', '0');
INSERT INTO `tbm_barang` VALUES ('360', 'F00BM784', 'BAUT + MUR 7/8 X 4\"', '8', '0', '20.00', '200.00', '1000.00', '0');
INSERT INTO `tbm_barang` VALUES ('361', 'F00BM583', 'BAUT + MUR 5/8\" X 3\"', '8', '0', '20.00', '200.00', '1000.00', '0');
INSERT INTO `tbm_barang` VALUES ('362', 'F00BMB03', 'BAUT + MUR BINAMON F3', '8', '0', '20.00', '200.00', '1000.00', '0');
INSERT INTO `tbm_barang` VALUES ('363', 'F00BMB04', 'BAUT + MUR BINAMON F4', '8', '0', '20.00', '200.00', '1000.00', '0');
INSERT INTO `tbm_barang` VALUES ('364', 'F00BMB05', 'BAUT + MUR BiNAMON F5', '8', '0', '20.00', '200.00', '1000.00', '0');
INSERT INTO `tbm_barang` VALUES ('365', 'F00BMB07', 'BAUT + MUR BINAMON F7', '8', '0', '20.00', '200.00', '1000.00', '0');
INSERT INTO `tbm_barang` VALUES ('366', 'F00BSC01', 'BAUT + MUR SPACER COUPLING', '8', '0', '20.00', '200.00', '1000.00', '0');
INSERT INTO `tbm_barang` VALUES ('367', 'F00BS002', 'BAUT SENG 2\"', '8', '0', '10.00', '50.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('368', 'F00BK206', 'BEARING KOYO 7206', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('369', 'F00BK305', 'BEARING KOYO NU305', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('370', 'F00BN312', 'BEARING NU 312 ECPM', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('371', 'F00BN307', 'BEARING NU 307 ECP MERK SKF', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('372', 'F00BT320', 'BEARING THRUST 29320-E1', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('373', 'F00BRG13', 'BEARING NTN 6013 ZZC3/5K', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('374', 'F00BP001', 'BUSHING POMPA Ø D:24MM, Ø L:28MM & P:69MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('375', 'F00BP516', 'BEARING PILLOW BLOCK SN516', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('376', 'F00BPL70', 'BEALTING POMPA KOLAM LIMBAH A-70 MIDSUBASHI', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('377', 'F00BRG02', 'BEARING 6202', '8', '0', '2.00', '200.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('378', 'F00BR205', 'BEARING 6205 NTN', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('379', 'F00BR209', 'BEARING 1209K C3', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('380', 'F00BR211', 'BEARING 1211 K C3', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('381', 'F00BRG09', 'BEARING 22209 E1-K-C3 FAG', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('382', 'F00BRG17', 'BEARING 22217 KM C3 NIB', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('383', 'F00BS050', 'BESI SIKU 50MM', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('384', 'F00BS075', 'BESI SIKU 75 MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('385', 'F00BSL08', 'BAUT STUD L8 X 25', '8', '0', '5.00', '50.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('386', 'F00BSL10', 'BAUT STUD L10 X 25', '8', '0', '5.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('387', 'F00BSL16', 'BAUT STUD L16 X 25', '8', '0', '5.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('388', 'F00BSL25', 'BAUT STUD L14 X 25', '8', '0', '5.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('389', 'F00BT215', 'BEARING UCT 215', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('390', 'F00BTL05', 'BAUT L5', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('391', 'F00BTL06', 'BAUT L6', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('392', 'F00BTL07', 'BAUT L7', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('393', 'F00BTL08', 'BAUT L8', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('394', 'F00BTL10', 'BAUT L10', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('395', 'F00BU125', 'BESI UNP 125', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('396', 'F00BB012', 'BESI BEHEL 12MM', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('397', 'F00BH009', 'BESI BEHEL 9MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('398', 'F00BH025', 'BESI HOLO 25 X 25', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('399', 'F00BU150', 'BESI UNP 150', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('400', 'F00BU207', 'BEARING UCP 207 J', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('401', 'F00BU210', 'BEARING UCP 210 J', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('402', 'F00BU212', 'BEARING UCF 212 J', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('403', 'F00BU214', 'TAKE UP BEARING UCT 214 FYH', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('404', 'F00BV001', 'BALL VALVE 1\" SS 304/316', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('405', 'F00BV002', 'BALL VALVE 2\"', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('406', 'F00BV003', 'BALL VALVE 3\'\'', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('407', 'F00BV004', 'BALL VALVE 4\'\'', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('408', 'F00BV012', 'BALL VALVE 1/2\"', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('409', 'F00BV015', 'BALL VALVE 1,5\" PN 40 MODEL STV 203 Y', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('410', 'F00BVE02', 'BALL VALVE MERK EVO 2\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('411', 'F00BW420', 'BEARING WIKA 29420 E1', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('412', 'F00BW207', 'BEARING WIKA 6207', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('413', 'F00BW208', 'BEARING WIKA 6208 2ZR', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('414', 'F00BW209', 'BEARING WIKA 6209 2ZR', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('415', 'F00BW210', 'BEARING WIKA 6210 2ZR', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('416', 'F00BW211', 'BEARING WIKA 6211 2ZR', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('417', 'F00BW212', 'BEARING WIKA 6212 2ZR', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('418', 'F00BW213', 'BEARING WIKA 6213 2ZR', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('419', 'F00BW306', 'BEARING WIKA 6306 2ZR', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('420', 'F00BW307', 'BEARING WIKA 6307 2ZR', '8', '0', '1.00', '2.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('421', 'F00BW308', 'BEARING WIKA 6308 ZZ C3', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('422', 'F00BW309', 'BEARING WIKA 6309 2ZR', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('423', 'F00BW310', 'BEARING WIKA 6310', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('424', 'F00BW311', 'BEARING WIKA 6311', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('425', 'F00BW312', 'BEARING WIKA 6312 2ZR', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('426', 'F00BW313', 'BEARING WIKA 6313 2ZR', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('427', 'F00BW314', 'BEARING WIKA 22314', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('428', 'F00BW213', 'BEARING WIKA 22213EK', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('429', 'F00BW319', 'BEARING WIKA 6319', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('430', 'F00BR212', 'BEARING SKF TVH 2212', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('431', 'F00BSS01', 'BUSH SLEEVE STAINLESS NSC 8000', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('432', 'F00CRS10', 'CB 6T ROTOR SHAFT PN-10', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('433', 'F00CS013', 'CB 6T C/I SPACER PN-13', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('434', 'F00CMK01', 'CB 6T MAIN KEY PN-01', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('435', 'F00CRT14', 'CB 6T ROTOR TIE ROD PN-14', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('436', 'F00CRW19', 'CB 6T ROTOR WEARING PLATE PN-19B', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('437', 'F00CE006', 'CHAIN 6\" EXTENDED 6 LINK', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('438', 'F00CPD16', 'COUPLING POMPA DB 50/16', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('439', 'F00CRV02', 'CHECK RETURN VALVE 2\"', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('440', 'F00CRV03', 'CHECK RETURN VALVE 3\"', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('441', 'F00CS004', 'CHAIN SPROCKET 6\" 4 LINK', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('442', 'F00CS012', 'CLAMP SLING (u/BOLT) 1/2\"', '8', '0', '2.00', '30.00', '300.00', '0');
INSERT INTO `tbm_barang` VALUES ('443', 'F00CS058', 'CLAMP SLING (u/BOLT) 5/8\"', '8', '0', '2.00', '30.00', '300.00', '0');
INSERT INTO `tbm_barang` VALUES ('444', 'F00CP001', 'CLEAMPING PLATE', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('445', 'F00CT120', 'CHAIN TRANSMISI RS 120 X 2R', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('446', 'F00CV034', 'CHECK VALVE 3/4\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('447', 'F00COV01', 'CONNECTOR OIL DRAIN VALVE S/C 0801', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('448', 'F00CBV01', 'CONNECTOR BREAKER VALVE', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('449', 'F00DRM06', 'DISK RIPLE MILL CAP 6T/JAM 1SET=4PCS                                                                                                                                                                                                                    ', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('450', 'F00DP015', 'DISMENTING PLAT CB P15 L/R (RING PRESS)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('451', 'F00DNK32', 'DONGKRAK 32 TON (HYDRAULIC JACK)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('452', 'F00DPB01', 'DOM PIPA BOILER', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('453', 'F00EAA17', 'EXPELLER ARM AP 17', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('454', 'F00EL014', 'ELBOW 1/4\" STEAM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('455', 'F00ELS02', 'ELBOW STAINLESS 2\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('456', 'F00ES001', 'ELBOW SCH40 1\"', '8', '0', '3.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('457', 'F00ES002', 'ELBOW SCH40 2\"', '8', '0', '3.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('458', 'F00ES003', 'ELBOW SCH40 3\"', '8', '0', '1.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('459', 'F00ES004', 'ELBOW SCH40 4\"', '8', '0', '3.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('460', 'F00ES006', 'ELBOW SCH40 6\'\'', '8', '0', '3.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('461', 'F00ES015', 'ELBOW SCH40 1,5\"', '8', '0', '3.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('462', 'F00EFC01', 'ELCON FLUID COUPLING', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('463', 'F00EFR01', 'ELCON FLUID COUPLING RECONDISI', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('464', 'F00FB053', 'FAN BELT BANDO B- 53', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('465', 'F00FB062', 'FAN BELT BANDO B- 62', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('466', 'F00FB065', 'FAN BELT BANDO B-65', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('467', 'F00FB074', 'FAN BELT BANDO B- 74', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('468', 'F00FBB85', 'FAN BELT BANDO B-85', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('469', 'F00FB114', 'FAN BELT BANDO B114', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('470', 'F00FB290', 'FAN BELT BANDO SPC 2900 LW', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('471', 'F00FB300', 'FAN BELT BANDO SPC 5300 LW', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('472', 'F00FB350', 'FAN BELT BANDO SPB 3350', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('473', 'F00FB600', 'FAN BELT BANDO SPC 3600 LW', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('474', 'F00FB700', 'FAN BELT MITSUBOSHI SPB 1700', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('475', 'F00FB900', 'FAN BELT BANDO SPB 2900 LW', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('476', 'F00FB950', 'FAN BELT SPB 1950', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('477', 'F00FB975', 'FAN BELT BANDO SPB 2975 LW', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('478', 'F00FBA08', 'FLANGE BEARING ASB 208', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('479', 'F00FBM63', 'FAN BELT MITSUBOSHI B-63', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('480', 'F00FBM65', 'FAN BELT MITSUBOSHI B-65', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('481', 'F00FBU08', 'FLANGE BEARING UCF 208 J', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('482', 'F00FC180', 'FLEXIBLE COUPLING FCL-180', '8', '0', '1.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('483', 'F00FC224', 'FLEXIBLE COUPLING FCL-224', '8', '0', '1.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('484', 'F00FC250', 'FLEXIBLE COUPLING FCL-250', '8', '0', '1.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('485', 'F00FF004', 'FLEXIBLE FLANGE 4\"', '8', '0', '1.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('486', 'F00FLG01', 'FLANGE 1\"', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('487', 'F00FLG02', 'FLANGE 2\"', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('488', 'F00FLG15', 'FLANGE 1½\"', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('489', 'F00FLG03', 'FLANGE 3\" @ 12MM', '8', '0', '1.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('490', 'F00FLG06', 'FLANGE 6\"', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('491', 'F00FLG04', 'FLANGE 4\"', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('492', 'F00FT001', 'FLARING TOOLS', '8', '0', '5.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('493', 'F00FM114', 'FAN BELT MITSUBOSHI B-114', '8', '0', '1.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('494', 'F00FV003', 'FOOT VALVE 3\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('495', 'F00FV004', 'FOOT VALVE 4\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('496', 'F00GP009', 'GLASS PENDUGA (B9 TRANSPARAN GLASS) P:34CM, L:3,5CM, T:17MM', '8', '0', '1.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('497', 'F00GP012', 'GLAND PACKING 1/2\"', '8', '0', '20.00', '150.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('498', 'F00GPK38', 'GLAND PACKING 3/8\" (KAIN)', '8', '0', '20.00', '150.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('499', 'F00GP038', 'GLAND PAKING 3/8\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('500', 'F00GPA12', 'GLAND PACKING ASBESTOS 1/2\"', '8', '0', '20.00', '150.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('501', 'F00GV040', 'GLOVE VALVE 2½\" PN40 DN65 VALMATIC', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('502', 'F00GV002', 'GLOBE VALVE 2\" PN 40', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('503', 'F00GV015', 'GLOBE VALVE 1,5\" FIG 8S2 VALMATIC', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('504', 'F00GV003', 'GLOBE VALVE 3\" PN 40-DN80, P:12\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('505', 'F00HBN15', 'HT BOLT & NUT 1\" X 15\" (DOUBLE NUT)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('506', 'F00HT007', 'HAND TAPE 4 X 0,7', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('507', 'F00HT011', 'HAND TAPE 5/8 X 11', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('508', 'F00IP250', 'IMPELLER PUMP TYPE: KPD 40/26 QF CA 15/250 STAINLESS STEEL', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('509', 'F00IP001', 'IMPELLER PUMP SESUAI CONTOH STAINLESS STEEL', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('510', 'F00IPS01', 'IMPELLER PUMP STAINLESS STEEL', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('511', 'F00IPC08', 'INLET PIPE CW PLANGE NSC 8000', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('512', 'F00KP030', 'KEW PUMP 3-2 KAPASITAS 30M3/HOURS', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('513', 'F00KA200', 'KARET ABU PLUMER BLOCK SNV-200 F-L', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('514', 'F00KP050', 'KEW PUMP TYPE KS-SE3, MODEL SEK 50, IMPELLER SIZE 254MM, FLANGE INLET 3\", FLANGE OUTLET 2\", ELECTRO MOTOR TYPE Y2-160M-4 MERK REXTON KW=11, R/MIN=1460', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('515', 'F00LSC15', 'LITHENING SHAFT CB P15 L/R', '8', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('516', 'F00MBB02', 'MATA BOR BOFA Ø 2MM- 13MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('517', 'F00MS350', 'MATA SNEPER 17 X 350MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('518', 'F00MG004', 'MESIN GRENDA HITACHI 4\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('519', 'F00MS112', 'MECHANICAL SEAL MERK KEW PUMP SEN 100 1½\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('520', 'F00MS050', 'MECHANICAL SEAL TYPE: KPD 50/32 QF', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('521', 'F00MS032', 'MECHANICAL SEAL KPD 50/32 KARBON KRAMIK  1½\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('522', 'F00NK001', 'NIPPLE KECIL', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('523', 'F00NS001', 'NIPPLE SEDANG', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('524', 'F00NB001', 'NIPPLE BESAR', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('525', 'F00NH001', 'NOZLE HOLDER', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('526', 'F00NHN01', 'NOZLE HOLDER NUT (FEMALE)', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('527', 'F00NSC17', 'NOZLE SLUDGE CENTRIFUGE 1,7MM', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('528', 'F00NLA01', 'NUT ADAFTER AHX 3124 & LOCK WASHER', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('529', 'F00ORD50', 'ORING RUBBER Ø OD 50MM, ID 44MM, T 3MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('530', 'F00OS001', 'ORING SET (INCI & MILLI)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('531', 'F00OS002', 'OIL SEAL 100 X 130 X 12', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('532', 'F00OS012', 'OIL SEAL 100 X 120 X 12', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('533', 'F00OSP01', 'OIL SEAL PHYTON 100 X 130 X 13', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('534', 'F00OS013', 'OIL SEAL 100 X 130 X 13', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('535', 'F00OSP03', 'OIL SEAL PHYTON 130 X 150 X 13', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('536', 'F00OS353', 'OIL SEAL 130 X 150 X 13', '8', '0', '0.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('537', 'F00OS100', 'OIL SEAL 60 X 100 X 10', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('538', 'F00OS103', 'OIL SEAL TC 65  X 100 X 13', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('539', 'F00OS200', 'OIL SEAL TC 130 X 200 X 12', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('540', 'F00OS803', 'OIL SEAL TC 80 X 110 X 13', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('541', 'F00OS503', 'OIL SEAL TC 75 X 110 X 13', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('542', 'F00OS110', 'OIL SEAL TC 60 x 110 x 12', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('543', 'F00OS120', 'OIL SEAL 100 X 120 X  13', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('544', 'F00OSP13', 'OIL SEAL PHYTON 130 X 160 X 13', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('545', 'F00OS130', 'OIL SEAL 130 X 160 X 13', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('546', 'F00OS064', 'OIL SEAL TC 130 X 160 X 14', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('547', 'F00OS150', 'OIL SEAL 120 x 150 x 14 TTO', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('548', 'F00OS160', 'OIL SEAL 100 X 160 X 13', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('549', 'F00OS180', 'OIL SEAL 150 x 180 x 14 TTO', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('550', 'F00OS072', 'OIL SEAL TC 72 X 90 X 10', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('551', 'F00OS030', 'OIL SEAL TC 30 X 50 X 10', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('552', 'F00OS552', 'OIL SEAL TC 45 X 65 X 12', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('553', 'F00OS522', 'OIL SEAL TC 45 X 62 X 12', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('554', 'F00OS007', 'OIL SEAL TC 32 X 45 X 7', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('555', 'F00OSG30', 'OIL SEAL GEARBOX 30-44-07', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('556', 'F00OSG62', 'OIL SEAL GEARBOX 62-120-12', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('557', 'F00OS515', 'OIL SEAL SPA 1515', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('558', 'F00OS519', 'OIL SEAL SPA 1519', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('559', 'F00OS528', 'OIL SEAL SPA 1528', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('560', 'F00OSA28', 'OIL SEAL SPA 1528-a', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('561', 'F00PSJ05', 'PER SPRING JACK 5MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('562', 'F00PB180', 'PLUMER BLOCK  SNV 180 F-L', '8', '0', '1.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('563', 'F00PB316', 'PLUMER BLOCK SNL 516-613 FAG, BEARING FAG 22216E1-K-C3 & ADAFTER AHX H316', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('564', 'F00PB313', 'PLUMER BLOCK SNL 513-611 FAG, BEARING FAG 22213E1-K-C3 & ADAFTER SLEEVE H313', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('565', 'F00PCC15', 'PRESS CAKE CB P15', '8', '0', '1.00', '10.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('566', 'F00PG001', 'PIPA GALVANIS 1\"', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('567', 'F00PG002', 'PIPA GALVANIS MEDIUM 2\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('568', 'F00PS002', 'PIPA SCH40 2\" P=15 CM (PAKAI DRAT)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('569', 'F00PG006', 'PIPA GALVANIS 6\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('570', 'F00PK001', 'PACKING KARET 1M X 2M X 3M', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('571', 'F00PK005', 'PACKING KARET 5MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('572', 'F00PK006', 'PACKING KARET 6MM', '8', '0', '1.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('573', 'F00PK004', 'PACKING KARET 4MM', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('574', 'F00PK008', 'PACKING KARET 8MM', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('575', 'F00PKL03', 'PACKING KLINGERIT 9000 @ 5MM', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('576', 'F00PB240', 'PLAT BUNGA 120 X 240 X 5MM', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('577', 'F00PLT04', 'PLAT 120 X 240 X 4MM', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('578', 'F00PS008', 'PLAT STRIP 120 X 240 X 8MM', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('579', 'F00PS050', 'PLAT STRIP 50 X 8MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('580', 'F00PS056', 'PLAT STRIP 50MM X 5MM X 6M', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('581', 'F00PS080', 'PLAT STRIP 80 X 10MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('582', 'F00PRN12', 'PACKING PINTU REBUSAN NBR DIA.1200MM', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('583', 'F00PRW01', 'PACKING PINTU REBUSAN WANG YUEN', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('584', 'F00PT001', 'PACKING TOMBO 1MM X 1200 X 1200', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('585', 'F00PS001', 'PACKING STEAM 1MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('586', 'F00PS003', 'PACKING STEAM 3MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('587', 'F00PS005', 'PACKING STEAM 5MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('588', 'F00PS001', 'PIPA SCH40 1\"', '8', '0', '1.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('589', 'F00PS112', 'PIPA SCH40 1½\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('590', 'F00PS343', 'PIPA SCH40 3/4 X 3MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('591', 'F00PS003', 'PIPA SCRIMMER 3\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('592', 'F00PS034', 'PIPA SCH40 3/4\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('593', 'F00PS003', 'PIPA STAINLESS 3\" T:5MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('594', 'F00PS002', 'PIPA STAINLESS 2\"', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('595', 'F00PS015', 'PIPA STEAM 1,5\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('596', 'F00PS050', 'PLAT STRIP 50 MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('597', 'F00PT003', 'PACKING TOMBO 3MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('598', 'F00PTV01', 'PER TEKAN VIBRATING', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('599', 'F00PTV02', 'PER TARIK VIBRATING', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('600', 'F00PTB05', 'PACKING TBA 0,5MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('601', 'F00PTL08', 'PULLY TUPPER LOCK B3 8\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('602', 'F00PLY06', 'PULLY 6\" Ø AS = Ø ELEKTRO MOTOR YANG DI ORDER ', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('603', 'F00PUL10', 'PULLY 10\" C5 (TUPPER LOCK)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('604', 'F00PTL11', 'PULLY JENIS SPC 11\" B6 MODEL TUPPER LOCK', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('605', 'F00PUL14', 'PULLY 14\" C5 (TUPPER LOCK)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('606', 'F00PUH04', 'PU HOUSE 6 X 4MM', '8', '0', '20.00', '300.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('607', 'F00PVS01', 'PACKING VIBRATING SCREEN', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('608', 'F00RBR30', 'ROTOR BAR RIPLE MILL 19MM X 430 MM', '8', '0', '15.00', '100.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('609', 'F00RBR95', 'ROTOR BAR RIPLE MILL 19MM X 390 MM', '8', '0', '15.00', '100.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('610', 'F00RGS01', 'ROTOR DAN GULUNGAN JENIS SNEPER', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('611', 'F00RCC04', 'REXTON CONVEYOR CHAIN 4\" (1 ROLL=3,048 MTR)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('612', 'F00RC100', 'RUBBER COUPLING L/SW 100-302', '8', '0', '3.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('613', 'F00RC110', 'RUBBER COUPLING L/SW 110-404', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('614', 'F00RCB01', 'RUBBER COUPLING BINTANG L/SW 110-404', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('615', 'F00RCF03', 'RUBBER COUPLING F3', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('616', 'F00RCF04', 'RUBBER COUPLING F4', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('617', 'F00RCF05', 'RUBBER COUPLING F5', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('618', 'F00RCF06', 'RUBBER COUPLING F6', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('619', 'F00RCF07', 'RUBBER COUPLING F7', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('620', 'F00RCW01', 'RUBBER COUPLING POMPA WADUK', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('621', 'F00RED01', 'REDUCER 1\" - 3/4\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('622', 'F00RN012', 'RING (NOZLE) 020/12 X 1,5', '8', '0', '15.00', '100.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('623', 'F00RN016', 'RING (NOZLE) 016/10 X 1,5', '8', '0', '15.00', '100.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('624', 'F00LDB25', 'ROOSTER (LANTAI DAPUR BOILER) P:85CM, L:15CM, T:150MM MERK MACKENZIE CAP 25.000 KG/HOUR', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('625', 'F00SAA17', 'SHORT ARM AP 17 ', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('626', 'F00SB001', 'SQUARE BAR 1\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('627', 'F00SB019', 'SHOCKET BOR Ø 19 MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('628', 'F00SBD18', 'SOCKET BOR 18\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('629', 'F00SBM01', 'SOCKET BOR MAGNET', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('630', 'F00SC001', 'SPACER COUPLING L/SW 110-404', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('631', 'F00SC100', 'SPACER COUPLING RSS -100/140', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('632', 'F00SC140', 'SPACER COUPLING RSS -100/140 (PENDEK)', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('633', 'F00SC100', 'SPACER COUPLING L/SW 100-302 (PENDEK)', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('634', 'F00SC404', 'SPACER COUPLING L/SW 110-404 (PENDEK)', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('635', 'F00SH001', 'SOCKET HYD', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('636', 'F00SKT04', 'SPROKET 4\" 8T BUBUT SCRAB', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('637', 'F00SN001', 'SOCKET NIPPLE', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('638', 'F00SOC14', 'SOCKET 1/4\" STEAM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('639', 'F00SPR04', 'SPROCKET 4\" X 10T REXTON', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('640', 'F00SPR19', 'SPROCKET 80 -2 X 19 T', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('641', 'F00SPR35', 'SPROCKET 80 -2 X 35 T', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('642', 'F00SSR01', 'SPRINGE (SETELAN RANTAI + Socket Drat + Per)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('643', 'F00STD80', 'SEAL TELPON Ø OD 80MM, ID 66MM, T 1MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('644', 'F00TB210', 'TAKE UP BEARING UCF 210', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('645', 'F00TB210', 'TAKE UP BEARING UCT 210 MZD', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('646', 'F00TBC14', 'TAKE UP BEARING UC 214 ASAHI', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('647', 'F00TRN01', 'TIE ROD NUT L/R', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('648', 'F00TL400', 'TRAVO LAS WELTECH 400A', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('649', 'F00TL200', 'TRAVO LAS INVERTER MERK REDBO TIG-S 200', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('650', 'F00VB003', 'VALVE BUTTERFLY 3\"', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('651', 'F00VB004', 'VALVE BUTTERFLAY 4\"', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('652', 'F00VB008', 'VALVE BUTTERFLAY 8\"', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('653', 'F00VB006', 'VALVE BUTTERFLAY 6\"', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('654', 'F00VBA01', 'V.BLOCK ARM DIGESTER', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('655', 'F00VO006', 'VALVE OTOMATIS 6\" (MODEL BUTTERFLY)', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('656', 'F00VO008', 'VALVE OTOMATIS 8\" (MODEL BUTTERFLY)', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('657', 'F00WLS01', 'WORM LITHENING SHAFT (PROTECTION NUT)', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('658', 'F00WM005', 'W.MESH M-5 2MM STAINLESS STEEL 4\' X 8\'', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('659', 'F00WM020', 'WIRE MESH 20', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('660', 'F00WM030', 'WIRE MESH 30', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('661', 'F00WM040', 'WIRE MESH 40', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('662', 'F00WSC15', 'WORM SCREEW CB P15 L/R', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('663', 'F00SCV03', 'SWING CHECK VALVE 3\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('664', 'F00PLI07', 'POLI 7\" + BUBUT  DAN SCRAB', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('665', 'F00PLI14', 'POLI 14\" + BUBUT  DAN SCRAB', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('666', 'F00FBB43', 'FAN BELT BANDO B-43', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('667', 'F00FB400', 'FAN BELT SPB 2400', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('668', 'F00APR01', 'AS POMPA RECLAIMED', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('669', 'F00BPR01', 'BUSHING POMPA RECLAIMED', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('670', 'F00FBB80', 'FAN BELT BANDO B-80', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('671', 'F00BWR04', 'BLOWER 4\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('672', 'F00OS075', 'OIL SEAL TC 60 x 75 x 10mm', '8', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('673', 'F00BF018', 'BEARING FAG 6013 2ZR. C3', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('674', 'F00FFB01', 'AS PSPROCKET FFB SCRAPPER (SESUAI GAMBAR)', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('675', 'F00PG003', 'PIPA GALVANIS 3\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('676', 'F00NSC80', 'INLET PN02 NSC 8000L', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('677', 'F00BS056', 'BESI SIKU : 30 X 50 X 5 X 6M', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('678', 'F00SC403', 'PIPA SCH40 3\"         ', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('679', 'F00BS566', 'BESI SIKU : 75 X 75 X 6 X 6M', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('680', 'F00SNI56', 'BESI SIKU (SNI) : 50 X 50 X 5 X 6M', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('681', 'F00SC201', 'PIPA SCH20 1\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('682', 'F00SSS34', 'PIPA SCH20 STAINLESS STEEL 3/4\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('683', 'F00SSS01', 'PIPA SCH20 STAINLESS STEEL 1\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('684', 'F00SSS02', 'PIPA SCH20 STAINLESS STEEL 2\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('685', 'F00BP048', 'BESI PLAT 12MM X 4M X 8M', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('686', 'F00PS006', 'PACKING STEAM 6MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('687', 'F00PS004', 'PACKING STEAM 4MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('688', 'F00KPG01', 'KLEM PIPA GALVANIS', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('689', 'F00BS256', 'BESI SIKU 2,5 X 2,5 X 6M', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('690', 'F00TBA03', 'PACKING TBA 3MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('691', 'F00CVS40', 'CHECK VALVE STEAM 2\" PN 40', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('692', 'F00GVS40', 'GLOBE VALVE STEAM 2\" PN 40', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('693', 'F00BRG29', 'BEARING 629 ZR', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('694', 'F00PS001', 'PIPA STEAM 1\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('695', 'F00PG065', 'PIPA GALVANIS 6 X 5MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('696', 'F00PG045', 'PIPA GALVANIS 4\" X 5MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('697', 'F00PS253', 'PLAT STRIP 25 X 3MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('698', 'F00PLT06', 'PLAT 120 X 240 X 6MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('699', 'F00PB004', 'PLAT BUNGA 120 X 240 X 4MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('700', 'F00PS002', 'PIPA STEAM 2\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('701', 'F00BS050', 'BELT SPB 3050 \"MITSUBOSHI\"', '8', '0', '2.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('702', 'F00MS045', 'MECHANICAL SEAL DIA 45MM', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('703', 'F00OS447', 'OIL SEAL TC 30 X 44 X 7', '8', '0', '2.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('704', 'F00GSS01', 'GALAXI SIVTEK SPRING', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('705', 'F00BV008', 'BUTTERFLY VALVE 8\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('706', 'F00BV006', 'BUTTERFLY VALVE 6\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('707', 'F00FAG62', 'BEARING FAG 6211 2ZR', '8', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('708', 'F00FAG63', 'BEARING FAG 6311', '8', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('709', 'F00SM880', 'SHAFT MTR, 7225, DIA 65 X L 880 SPROCKET CS 4\" X 10 T', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('710', 'F00SM740', 'SHAFT MTR, 7225, DIA 65 X L 740 SPROCKET CS 4\" X 10 T', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('711', 'F00SM150', 'SHAFT MTR, 7225, DIA 80 X L1, 150 SPROCKET CS 4\" X 10 T', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('712', 'F00SM050', 'SHAFT MTR, 7225, DIA 80 X L1, 050 SPROCKET CS 4\" X 10 T', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('713', 'G00BB001', 'BENANG NYLON BANGUNAN', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('714', 'G00EJ001', 'ENGSEL JENDELA', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('715', 'G00ELB02', 'ELBOW 2\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('716', 'G00ELB03', 'ELBOW PVC 3\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('717', 'G00ELB04', 'ELBOW PVC 4\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('718', 'G00ELB06', 'ELBOW PVC 6\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('719', 'G00ELB08', 'ELBOW PVC 8\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('720', 'G00ELB15', 'ELBOW PVC 1,5\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('721', 'G00ELT02', 'ELBOW T PVC 2\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('722', 'G00ELT03', 'ELBOW T PVC 3\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('723', 'G00ELT04', 'ELBOW T PVC 4\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('724', 'G00ELT06', 'ELBOW T PVC 6\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('725', 'G00ELY04', 'ELBOW Y PVC 4\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('726', 'G00ELY06', 'ELBOW Y PVC 6\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('727', 'G00ELY08', 'ELBOW Y PVC 8\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('728', 'G00EP001', 'ENGSEL PINTU', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('729', 'G00EP034', 'ELBOW PARALON 3/4\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('730', 'G00FPP04', 'FLANGE PIPA PVC 4\"', '12', '0', '2.00', '30.00', '300.00', '0');
INSERT INTO `tbm_barang` VALUES ('731', 'G00FPP08', 'FLANGE PIPA PVC 8\"', '12', '0', '2.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('732', '', 'FLANGE PIPA PVC 8\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('733', 'G00GPU01', 'GRENDEL PINTU', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('734', 'G00KC001', 'KUAS CAT 1\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('735', 'G00KC002', 'KUAS CAT 2\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('736', 'G00KC003', 'KUAS CAT 3\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('737', 'G00KC004', 'KUAS CAT 4\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('738', 'G00KC015', 'KUAS CAT 1,5\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('739', 'G00KR009', 'KUAS ROLL BESAR', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('740', 'G00PBE01', 'PAKU BETON 3\"', '12', '0', '1.00', '50.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('741', 'G00PBE02', 'PAKU BETON 2\"', '12', '0', '1.00', '50.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('742', 'G00PBE04', 'PAKU BETON 4\"', '12', '0', '1.00', '50.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('743', 'G00PBE15', 'PAKU BETON 1,5\"', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('744', 'G00PKU01', 'PAKU 1\"', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('745', 'G00PKU02', 'PAKU 2\"', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('746', 'G00PKU25', 'PAKU 2,5\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('747', 'G00PKU03', 'PAKU 3\"', '12', '0', '1.00', '30.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('748', 'G00PKU04', 'PAKU 4\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('749', 'G00PKU05', 'PAKU 5\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('750', 'G00PKU15', 'PAKU 1,5\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('751', 'G00PP004', 'PIPA PVC 4\" AW MERK WAVIN', '12', '0', '5.00', '50.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('752', 'G00PP006', 'PIPA PARALON 6\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('753', 'G00PP008', 'PIPA PVC 8\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('754', 'G00PP034', 'PIPA PARALON 3/4\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('755', 'G00PPC02', 'PIPA PVC 2\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('756', 'G00PPC03', 'PIPA PVC 3\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('757', 'G00PPW04', 'PIPA PARALON WAVIN 4\" X 6M', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('758', 'G00PS001', 'PAKU SENG', '12', '0', '1.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('759', 'G00PTR01', 'PAKU TRIPLEK', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('760', 'G00PW004', 'PIPA WAVIN 4\"', '12', '0', '3.00', '50.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('761', 'G00RED04', 'SAMBUNGAN 4\" X 3\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('762', 'G00SAM42', 'SAMBUNGAN 4\" x 2\"', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('763', 'G00RKK01', 'REFIL KUAS ROLL KECIL', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('764', 'G00SAM02', 'SAMBUNGAN 2\"', '12', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('765', 'G00SAM03', 'SAMBUNGAN 3\"', '12', '0', '2.00', '30.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('766', 'G00SR004', 'SAMBUNGAN PVC MERK RUCIKA 4\"', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('767', 'G00SAM04', 'SAMBUNGAN 4\"', '12', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('768', 'G00SAM06', 'SAMBUNGAN 6\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('769', 'G00SAM08', 'SAMBUNGAN 8\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('770', 'G00SAM34', 'SOCKET PARALON 3/4\"', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('771', 'G00SM001', 'SEMEN MICRO', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('772', 'G00SP001', 'SEMEN PADANG', '12', '0', '5.00', '50.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('773', 'G00SS001', 'SEMEN SIKA', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('774', 'G00TA001', 'TOLANG ANGIN JENDELA', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('775', 'G00TNR05', 'THINNER 5 LTR', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('776', 'G00TRD15', '\"T\" REDUSER 1,5 X 1 X 1,5 PVC', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('777', 'G00TRD20', '\"T\" REDUSER 2 X 1 X 2 PVC', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('778', 'G00TTP04', 'TUTUP 4\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('779', 'G00ELB04', 'ELBOW 45° PVC 4\"', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('780', 'G00PVC06', 'FLANGE PIPA PVC 6\"', '12', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('781', 'TOTAL ', '', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('782', 'K00AL098', 'ALKOHOL 98% IPAL @ 35LTR', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('783', 'K00ARS01', 'ACID REAGENT FOR HR SILICA \"HACH\" CAT.1454599PK/100', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('784', 'K00CA001', 'CITRIC ACID \"HACH\" CAT.1454999PK/100', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('785', 'K00CC001', 'CALSIUM CARBONATE', '13', '0', '100.00', '450.00', '1000.00', '0');
INSERT INTO `tbm_barang` VALUES ('786', 'K00FIR01', 'FEROVER IRON REAGENT \"HACH\" CAT.927-99PK/100', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('787', 'K00FLO01', 'FLOCKGULANT @ 20KG', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('788', 'K00GR001', 'GARAM @ 50 KGS', '13', '0', '4.00', '35.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('789', 'K00KT001', 'KAPUR TOHOR', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('790', 'K00LPH01', 'LOCIS PLASTIK W/HIJAU', '13', '0', '1000.00', '5000.00', '10000.00', '0');
INSERT INTO `tbm_barang` VALUES ('791', 'K00MRS01', 'MOLYBDATE REAGENT FOR SILICA \"HACH\" CAT.1454699PK/100', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('792', 'K00NH001', 'N-HEXANE', '13', '0', '20.00', '100.00', '1000.00', '0');
INSERT INTO `tbm_barang` VALUES ('793', 'K00NHC03', 'NaHCO3', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('794', 'K00NHC04', 'NH4CI', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('795', 'K00PEL05', 'PLASTIK ES LILIN UK.5 X 20CM', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('796', 'K00PG002', 'PLASTIK GULA 2KG UK.18 X 25CM', '13', '0', '1.00', '30.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('797', 'K00PPR03', 'PHOSVER 3 PHOSPHATE REAGENT \"HACH\" CAT.2209-99PK/100', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('798', 'K00SA001', 'SODA ASH LIGH 98 % @ 40 KG', '13', '0', '5.00', '50.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('799', 'K00SEB02', 'SYSCHEM ENZIM BIO AM 02 @ 30 LTR', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('800', 'K00SR003', 'SILICA 3 REAGENT \"HACH\" CAT.27169', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('801', 'K00SSA02', 'SSA-2 @ 50ML', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('802', 'K00SSO01', 'SSO - 1', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('803', 'K00SSO02', 'SSO -2', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('804', 'K00SSO03', 'SSO - 3', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('805', 'K00STH02', 'STH - 2', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('806', 'K00STH03', 'STH - 3', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('807', 'K00SY001', 'BESTCHEM 8001 @ 30 KG (ALKALI BOOSTER)', '13', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('808', 'K00SY101', 'BESTCHEM 8101 @30KG (OXIGENT SCAVANGER)', '13', '0', '3.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('809', 'K00SY201', 'BESTCHEM 8201 @ 30 KG (ANTI SCALANT)', '13', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('810', 'K00SY210', 'BESTCHEM 8800 @ 30KG (POLYMER)', '13', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('811', 'K00SY003', 'BESTCHEM 8303 @ 25KG (PAC)', '13', '0', '6.00', '35.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('812', 'K00TW001', 'TAWAS @ 50 KG', '13', '0', '5.00', '30.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('813', 'K00UI014', 'UNIVERSAL INDIKATOR PH 0-14 (KERTAS LAKMUS)', '13', '0', '1.00', '30.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('814', 'K00NHO03', 'NH3OH 25% @ 2,5 L', '13', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('815', 'N00BDA01', 'BAN DALAM ANGKONG', '14', '0', '1.00', '30.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('816', 'N00BLA01', 'BAN LUAR ANGKONG', '14', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('817', 'N00BMA01', 'BAN MATI ANGKONG', '14', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('818', 'FILTER 32/925915', 'FILTER 32/925915', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('819', 'FILTER D4K 299-8229 / FILTER SOLAR', 'FILTER D4K 299-8229 / FILTER SOLAR', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('820', 'FILTER 320-04133', 'FILTER 320-04133', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('821', 'FILTER 326-1643', 'FILTER 326-1643', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('822', 'FILTER 326-1644', 'FILTER 326-1644', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('823', 'FILTER P 177047', 'FILTER P 177047', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('824', 'FILTER 1R 0751', 'FILTER 1R 0751', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('825', 'OIL FILTER 1R 0739', 'OIL FILTER 1R 0739', '7', '0', '1.00', '20.00', '2000.00', '0');
INSERT INTO `tbm_barang` VALUES ('826', 'FILTER A 51-8670', 'FILTER A 51-8670', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('827', 'FILTER HIDROLIK 093-7521', 'FILTER HIDROLIK 093-7521', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('828', 'FILTER CH 10930', 'FILTER CH 10930', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('829', 'FILTER CH 10931', 'FILTER CH 10931', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('830', 'FILTER 308-7298', 'FILTER 308-7298', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('831', 'FILTER PERKINS 10929', 'FILTER PERKINS 10929', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('832', 'FILTER SOLAR 40330-60470', 'FILTER SOLAR 40330-60470', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('833', 'FILTER SOLAR ATAS', 'FILTER SOLAR ATAS', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('834', 'FILTER SOLAR BAWAH', 'FILTER SOLAR BAWAH', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('835', 'FILTER OLI 320/04133', 'FILTER OLI 320/04133', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('836', 'FILTER SOLAR 320/07394', 'FILTER SOLAR 320/07394', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('837', 'FILTER OLI TURBIN SFC 5725 E25 MICRON', 'FILTER OLI TURBIN SFC 5725 E25 MICRON', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('838', 'FILTER BUANGAN OLI POWER PACK', 'FILTER BUANGAN OLI POWER PACK', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('839', 'FILTER FLANGE STRAINER DN80 P:135MM, Ø L:80MM, Ø D', 'FILTER FLANGE STRAINER DN80 P:135MM, Ø L:80MM, Ø D:77MM, TEBAL:3MM, MESH Ø LUBANG 40', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('840', 'OIL FILTER FL 4495', 'OIL FILTER FL 4495', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('841', 'KIT SEAL', 'KIT SEAL', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('842', 'FUEL FILTER', 'FUEL FILTER', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('843', 'FUEL FILTER J86-20080', 'FUEL FILTER J86-20080', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('844', 'FUEL FILTER', 'FUEL FILTER', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('845', 'FUEL FILTER FK 6080', 'FUEL FILTER FK 6080', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('846', 'FILTER OLI U/DYNA 130 HT', 'FILTER OLI U/DYNA 130 HT', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('847', 'OIL FILTER', 'OIL FILTER', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('848', 'FILTER HIDROLIK DONALSON P 164378', 'FILTER HIDROLIK DONALSON P 164378', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('849', 'FILTER UDARA BESAR (293-4053)', 'FILTER UDARA BESAR (293-4053)', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('850', 'FILTER UDARA KECIL (227-7449)', 'FILTER UDARA KECIL (227-7449)', '7', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('851', 'U00BG004', 'BATU GERINDA 4\" (ASAH)', '15', '0', '5.00', '30.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('852', 'U00AKG01', 'ANGKONG', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('853', 'U00BG007', 'BATU GERINDA 7\" x 6 MM / ASAH', '15', '0', '5.00', '30.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('854', 'U00BGB01', 'BATU GERENDA BOTOL', '15', '0', '3.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('855', 'U00BGP04', 'BATU GERINDA POTONG 4\"', '15', '0', '5.00', '30.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('856', 'U00BGP07', 'BATU GERINDA POTONG 7\"', '15', '0', '5.00', '30.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('857', 'U00BGP14', 'BATU GERINDA POTONG 14\"', '15', '0', '5.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('858', 'U00BHK05', 'KANVAS (TALI MESIN PADI)', '15', '0', '5.00', '30.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('859', 'U00BK001', 'BRUS KAWAT', '15', '0', '1.00', '30.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('860', 'U00BS001', 'BATTERAY SENTER', '15', '0', '2.00', '30.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('861', 'U00BR200', 'BATTERAY MERK ROCKET 19H52/N200 12V-200AH', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('862', 'U00CB001', 'CARBON BRUSH', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('863', 'U00CS002', 'CLEAM SLANG 2\"', '15', '0', '2.00', '30.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('864', 'U00CSB34', 'CLEAM SLANG BLENDER 3/4\"', '15', '0', '2.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('865', 'U00CSP05', 'CINCIN SELANG HIGHT PREASURE SPRAY 5MM', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('866', 'U00DRK01', 'DEREK', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('867', 'U00EL001', 'EPRON LAS (SAFETY U/PENGELASAN)', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('868', 'U00EPLU1', 'EAR PLUG (PENUTUP TELINGA)', '15', '0', '2.00', '50.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('869', 'U00GEM30', 'GEMBOK BAGUS 30MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('870', 'U00GEM60', 'GEMBOK BAGUS 60MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('871', 'U00GKS01', 'GUNTING KERTAS UK. SEDANG', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('872', 'U00GYG01', 'GAYUNG', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('873', 'U00HSD25', 'HOLE SOW DIAMETER 25 MM', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('874', 'U00IH001', 'ISOLASI HITAM', '15', '0', '3.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('875', 'U00IK001', 'ISOLASI KERTAS', '15', '0', '3.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('876', 'U00KAK01', 'KUNCI ANGIN MERK KODAI', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('877', 'U00KB001', 'KIKIR BULAT', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('878', 'U00KB025', 'KARBON BRUSH ALTERNATOR UK.P=25MM, L=12MM & T=10MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('879', 'U00KGP01', 'KACAMATA GERENDA (KACAMATA PUTIH)', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('880', 'U00KI015', 'KUNCI INGGRIS KECIL 5/8 P:8\"', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('881', 'U00KL010', 'KUNCI L 10', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('882', 'U00KL012', 'KUNCI L 12', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('883', 'U00KL014', 'KUNCI L 14', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('884', 'U00KL017', 'KUNCI L 17', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('885', 'U00KLB04', 'KAWAT LAS LB 52 @ 4MM', '15', '0', '5.00', '50.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('886', 'U00KLB32', 'KAWAT LAS LB 52 @ 3,2 MM', '15', '0', '5.00', '50.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('887', 'U00KLH01', 'KACA LAS HITAM', '15', '0', '2.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('888', 'U00KLI01', 'KUNCI L INCI', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('889', 'U00KLM01', 'KAIN LAP MAJUN', '15', '0', '5.00', '100.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('890', 'U00KLM01', 'KUNCI L MILI', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('891', 'U00KLP01', 'KACA LAS PUTIH', '15', '0', '2.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('892', 'U00KLR32', 'KAWAT LAS RB26 @ 3,2 MM', '15', '0', '20.00', '200.00', '800.00', '0');
INSERT INTO `tbm_barang` VALUES ('893', 'U00KLR26', 'KAWAT LAS RB26 @ 2,6MM', '15', '0', '5.00', '100.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('894', 'U00KLR04', 'KAWAT LAS RB26 @ 4MM', '15', '0', '5.00', '50.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('895', 'U00KLS08', 'KAWAT LAS STAINLESS 308 @3,2MM', '15', '0', '5.00', '50.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('896', 'U00KLS09', 'KAWAT LAS STAINLESS 309 @ 3,2MM', '15', '0', '5.00', '50.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('897', 'U00KLS11', 'KAWAT LAS SUPERTECH SUPER 1100 @ 4MM', '15', '0', '5.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('898', 'U00KLS31', 'KAWAT LAS SUPERTECH 312 @ 3,2MM', '15', '0', '5.00', '50.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('899', 'U00KLS35', 'KAWAT LAS SUPERTECH SUPER 350 @ 4MM', '15', '0', '5.00', '50.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('900', 'U00KSC32', 'KAWAT LAS SUPERTECH SUPER CAST 32 Ø 3,2MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('901', 'U00KP001', 'KAWAT PENGIKAT', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('902', 'U00KTK02', 'KOTREK 2 TON', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('903', 'U00KRP13', 'KUNCI RING PAS 13', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('904', 'U00KRP17', 'KUNCI RING PAS 17', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('905', 'U00KRP01', 'KUNCI RING/KUNCI PAS', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('906', 'U00KST01', 'KIKIR SEGITIGA KECIL', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('907', 'U00KSB01', 'KIKIR SETENGAH BULAT', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('908', 'U00KSE01', 'KIKIR SEGI EMPAT BESAR', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('909', 'U00KRP38', 'KUNCI RING PAS 38 (TEKIRO)', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('910', 'U00KST01', 'KUNCI SOK TEKIRO', '15', '0', '1.00', '10.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('911', 'U00KT008', 'KUNCI T 8', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('912', 'U00KT010', 'KUNCI T 10', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('913', 'U00KT012', 'KUNCI T 12', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('914', 'U00KT014', 'KUNCI T 14', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('915', 'U00KT017', 'KUNCI T 17', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('916', 'U00KTB01', 'KAPUR TULIS BESI', '15', '0', '5.00', '50.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('917', 'U00LA001', 'LAHAR ANGKONG', '15', '0', '2.00', '30.00', '300.00', '0');
INSERT INTO `tbm_barang` VALUES ('918', 'U00LBD01', 'LEM BESI DEXTON', '15', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('919', 'U00LPG03', 'LPG 3 KG', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('920', 'U00LPG12', 'LPG 12 KG', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('921', 'U00LPG50', 'LPG 50 KG', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('922', 'U00LPP01', 'LEM PIPA PVC', '15', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('923', 'U00LTR05', 'LITERAN 5 L', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('924', 'U00MB022', 'MATA BOR Ø 22 MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('925', 'U00MB024', 'MATA BOR Ø 24MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('926', 'U00MB028', 'MATA BOR Ø 28 MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('927', 'U00MBD05', 'MATA BOR Ø 5MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('928', 'U00MBD06', 'MATA BOR Ø 6 MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('929', 'U00MBD07', 'MATA BOR Ø 7MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('930', 'U00MBD08', 'MATA BOR Ø 8 MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('931', 'U00MBD12', 'MATA BOR Ø 12MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('932', 'U00MBD14', 'MATA BOR Ø 14 MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('933', 'U00MBD17', 'MATA BOR Ø 17 MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('934', 'U00MB175', 'MATA BOR Ø 17,5 MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('935', 'U00MBD18', 'MATA BOR Ø 18 MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('936', 'U00MBD19', 'MATA BOR Ø 19 MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('937', 'U00MBD35', 'MATA BOR Ø 3,5 MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('938', 'U00MBT08', 'MATA BOR TEMBOK Ø 8MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('939', 'U00MBT10', 'MATA BOR TEMBOK Ø 10MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('940', 'U00MGB01', 'MATA GERGAJI BESI', '15', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('941', 'U00MH001', 'MANTEL HUJAN', '15', '0', '1.00', '30.00', '300.00', '0');
INSERT INTO `tbm_barang` VALUES ('942', 'U00MKH01', 'MASKER KAIN WARNA HITAM', '15', '0', '2.00', '30.00', '300.00', '0');
INSERT INTO `tbm_barang` VALUES ('943', 'U00MRT01', 'MARTIL BESAR', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('944', 'U00MTD10', 'MATA BOR Ø 10 MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('945', 'U00MTR05', 'METERAN (UK. 5 M)', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('946', 'U00NBN02', 'NOZEL BLENDER NO.8', '15', '0', '2.00', '30.00', '300.00', '0');
INSERT INTO `tbm_barang` VALUES ('947', 'U00OBG01', 'OBENG +', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('948', 'U00OBG02', 'OBENG -', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('949', 'U00OX001', 'OXIGEN', '15', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('950', 'U00PB001', 'PAHAT  BETON', '15', '0', '2.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('951', 'U00PBP01', 'PITA BAN PUTIH', '15', '0', '2.00', '35.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('952', 'U00PC001', 'PISAU CUTTER', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('953', 'U00PP015', 'PLASTIK PRESPAN 0,15MM', '15', '0', '2.00', '30.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('954', 'U00PP025', 'PLASTIK PRESPAN 0,25MM', '15', '0', '2.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('955', 'U00PP020', 'PLASTIK PRESPAN 0,20MM', '15', '0', '2.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('956', 'U00PG007', 'PRESSURE GAUGE 7 BAR 6\" CONNECTION 3/8\"', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('957', 'U00PG004', 'PRESSURE GAUGE 4\" 7 BAR/100 PSI MERK VALMATIC', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('958', 'U00RA003', 'RACUN API @ 3KG', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('959', 'U00RA006', 'RACUN API @ 6KG', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('960', 'U00RA009', 'RACUN API @ 9KG', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('961', 'U00RA012', 'RACUN API @ 12KG', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('962', 'U00RG001', 'RED GASKET', '15', '0', '2.00', '35.00', '300.00', '0');
INSERT INTO `tbm_barang` VALUES ('963', 'U00RIN01', 'RINSO', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('964', 'U00RKM01', 'RASKAM', '15', '0', '2.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('965', 'U00ROX01', 'REGULATOR OXIGEN', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('966', 'U00RPG12', 'REGULATOR LPG U/TABUNG LPG 12 KG', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('967', 'U00SAP77', 'SERLAK AP 77', '15', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('968', 'U00SBB01', 'SAFETY BELT BIASA', '15', '0', '1.00', '30.00', '300.00', '0');
INSERT INTO `tbm_barang` VALUES ('969', 'U00SBH01', 'SAFETY BELT (BODY HARNES)', '15', '0', '1.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('970', 'U00SHP05', 'SELANG  HIGHT PREASURE SPRAY HOSE 5MM', '15', '0', '5.00', '50.00', '300.00', '0');
INSERT INTO `tbm_barang` VALUES ('971', 'U00SK001', 'SENTER KEPALA', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('972', 'U00SK012', 'SIKU KERJA 12\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('973', 'U00SKP01', 'SEKOP', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('974', 'U00SL002', 'SAPU LANTAI', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('975', 'U00SL005', 'SELANG 1/2\"', '15', '0', '5.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('976', 'U00SL034', 'SELANG 3/4\"', '15', '0', '5.00', '50.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('977', 'U00SNT01', 'SELANG NYLON TRANSPARAN 1\"', '15', '0', '5.00', '50.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('978', 'U00SP001', 'SELANG PISPOT', '15', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('979', 'U00SP001', 'STANG PISPOT', '15', '0', '1.00', '30.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('980', 'U00SBS08', 'STANG BLENDER STRONG NO.8', '15', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('981', 'U00SS002', 'SELANG SPIRAL 2\"', '15', '0', '5.00', '50.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('982', 'U00SKB01', 'SELANG KARET BLENDER, SELANG LPG Ø D:8MM, Ø L:16MM, SELANG OXIGEN Ø D:6MM, Ø L:14MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('983', 'U00ST001', 'SEAL TAPE \"ONDA\"', '15', '0', '2.00', '30.00', '300.00', '0');
INSERT INTO `tbm_barang` VALUES ('984', '', 'SEAL TAPE \"ONDA\"', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('985', 'U00SUS02', 'SIKU UKUR SUDUT 600 X 200 X 2MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('986', 'U00STK01', 'SARUNG TANGAN KOVET', '15', '0', '3.00', '50.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('987', 'U00STK02', 'SARUNG TANGAN KAIN', '15', '0', '3.00', '50.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('988', 'U00STK03', 'SARUNG TANGAN KARET', '15', '0', '3.00', '50.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('989', 'U00STL08', 'STANG LAS 800 A', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('990', 'U00STR06', 'SENTER 6 BATERAY', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('991', 'U00TB001', 'TANG BUAYA', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('992', 'U00TB002', 'TANG BIASA', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('993', 'U00TJK01', 'TOJOK', '15', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('994', 'U00TKB01', 'TANG KOMBINASI', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('995', 'U00TKD01', 'TANG KEP BUKA DALAM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('996', 'U00TKL01', 'TANG KEP BUKA LUAR', '15', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('997', 'U00TMT04', 'THERMOMETER 4\" 0-160', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('998', 'U00TP001', 'TANG POTONG', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('999', 'U00TP001', 'TANG PRES/BASIS', '15', '0', '1.00', '20.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('1000', 'U00TPL01', 'TOPENG LAS', '15', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1001', 'U00TRV06', 'THERMOMETER REKET MERK VALMATIC 6\"', '15', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1002', 'U00TRW04', 'THERMOMETER REKET MERK WIEBROK 4\"', '15', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1003', 'U00TSN01', 'TESPEN', '15', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1004', 'U00VA001', 'VELG ANGKONG', '15', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1005', 'U00WIB03', 'WIEBROK 3\" EN-837-1 KG LAN 150', '15', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1006', 'U00SH002', 'SELANG HISAP 2\"', '15', '0', '2.00', '30.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1007', 'U00TN010', 'TALI NILON 10MM', '7', '0', '0.00', '0.00', '0.00', '0');
INSERT INTO `tbm_barang` VALUES ('1008', 'U00CGK01', 'CANGKUL CAP BUAYA', '15', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1009', 'U00KST01', 'KUNCI SHICH MERK TEKIRO', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('1010', 'U00KB312', 'KUKU BAKET 312 D', '15', '0', '5.00', '35.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1011', '', 'ADAFTER 312 D', '15', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1012', 'U00KB320', 'KUKU BAKET 320 D', '15', '0', '5.00', '35.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1013', 'U00BKK01', 'BAUT KUKU', '15', '0', '5.00', '35.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1014', 'U00KF001', 'KUNCI FILTER', '15', '0', '1.00', '20.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1015', 'U00KA012', 'KACA ACRILIC 12MM', '7', '0', '0.00', '0.00', '0.00', '1');
INSERT INTO `tbm_barang` VALUES ('1016', 'U00KLB32', 'KAWAT LAS LB52U @ 3,2MM', '15', '0', '5.00', '35.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1017', 'U00KLB04', 'KAWAT LAS LB52U @ 4MM', '15', '0', '5.00', '35.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1018', '', 'KAWAT LAS METALIUM MH 350 @ 4MM', '15', '0', '5.00', '35.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1019', null, '', '7', '0', '10.00', '1000.00', '100000.00', '1');
INSERT INTO `tbm_barang` VALUES ('1020', null, 'Buah Kebun', '1', '0', '10.00', '1000000.00', '1000000000.00', '0');
INSERT INTO `tbm_barang` VALUES ('1021', null, 'Buah Luar', '1', '0', '10.00', '1000000.00', '1000000000.00', '0');
INSERT INTO `tbm_barang` VALUES ('1022', null, 'reducer pvc 4\" x 1,5\"', '12', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1023', null, 'reducer pvc 4\" x 2\"', '12', '0', '2.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1024', null, 'babat', '15', '0', '1.00', '10.00', '500.00', '0');
INSERT INTO `tbm_barang` VALUES ('1025', null, 'bAUT + MUR 5/8\" X 2.5\"', '8', '0', '20.00', '150.00', '500.00', '0');

-- ----------------------------
-- Table structure for tbm_barang_banner
-- ----------------------------
DROP TABLE IF EXISTS `tbm_barang_banner`;
CREATE TABLE `tbm_barang_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_parent_barang` int(11) DEFAULT NULL,
  `id_barang` int(11) DEFAULT NULL,
  `jml` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_barang_banner
-- ----------------------------

-- ----------------------------
-- Table structure for tbm_barang_harga
-- ----------------------------
DROP TABLE IF EXISTS `tbm_barang_harga`;
CREATE TABLE `tbm_barang_harga` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_barang` int(11) DEFAULT NULL,
  `tgl` date DEFAULT NULL,
  `harga` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_barang_harga
-- ----------------------------
INSERT INTO `tbm_barang_harga` VALUES ('1', '6', '2017-05-01', '3750000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('2', '7', '2017-05-01', '1750.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('3', '9', '2017-05-01', '4000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('4', '6', '2017-05-08', '3850000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('5', '7', '2017-05-08', '1800.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('6', '9', '2017-05-08', '800.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('7', '10', '2017-05-08', '4500.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('8', '6', '2017-05-09', '3900000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('9', '7', '2017-05-09', '2000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('10', '7', '2017-05-09', '3000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('11', '9', '2017-05-09', '3000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('12', '11', '2017-05-09', '14500.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('13', '1021', '2017-05-23', '1550.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('14', '1021', '2017-05-23', '1550.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('15', '1021', '2017-05-23', '1550.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('16', '1021', '2017-05-23', '1450.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('17', '13', '2017-05-23', '200000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('18', '14', '2017-05-23', '150000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('19', '1021', '2017-05-23', '1550.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('20', '1021', '2017-05-23', '1550.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('21', '11', '2017-05-24', '6180.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('22', '11', '2017-05-24', '6180.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('23', '12', '2017-05-24', '1340000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('24', '13', '2017-05-24', '200000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('25', '1021', '2017-05-26', '1805.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('26', '1021', '2017-05-26', '1805.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('27', '1021', '2017-05-26', '1805.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('28', '1021', '2017-05-26', '1795.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('29', '1021', '2017-05-26', '1805.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('30', '1021', '2017-05-26', '1805.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('31', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('32', '1021', '2017-05-26', '1720.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('33', '1021', '2017-05-26', '1720.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('34', '1021', '2017-05-26', '1720.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('35', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('36', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('37', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('38', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('39', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('40', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('41', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('42', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('43', '1021', '2017-05-26', '1720.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('44', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('45', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('46', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('47', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('48', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('49', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('50', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('51', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('52', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('53', '1021', '2017-05-26', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('54', '1021', '2017-05-27', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('55', '1021', '2017-05-27', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('56', '1020', '2017-05-27', '1400.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('57', '1021', '2017-05-27', '1720.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('58', '1021', '2017-05-27', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('59', '1021', '2017-05-27', '1730.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('60', '1020', '2017-05-27', null, '0');
INSERT INTO `tbm_barang_harga` VALUES ('61', '785', '2017-06-02', '43000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('62', '1021', '2017-06-04', '2500.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('63', '1021', '2017-06-04', '2500.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('64', '1021', '2017-06-04', '2500.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('65', '1021', '2017-06-04', '2500.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('66', '1021', '2017-06-04', '2500.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('67', '1021', '2017-06-04', '2500.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('68', '1020', '2017-06-04', '4500.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('69', '1020', '2017-06-04', '5000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('70', '1021', '2017-06-04', '3000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('71', '1021', '2017-06-04', '3000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('72', '1021', '2017-06-04', '3000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('73', '1021', '2017-06-04', '3000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('74', '1021', '2017-06-04', '3000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('75', '1021', '2017-06-04', '2500.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('76', '1021', '2017-06-04', '3000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('77', '1021', '2017-06-04', '3000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('78', '11', '2017-06-06', '6180.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('79', '10', '2017-06-09', '3000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('80', '10', '2017-06-09', '3000.00', '0');

-- ----------------------------
-- Table structure for tbm_barang_harga_potongan
-- ----------------------------
DROP TABLE IF EXISTS `tbm_barang_harga_potongan`;
CREATE TABLE `tbm_barang_harga_potongan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_barang` int(11) DEFAULT NULL,
  `ukuran` varchar(60) DEFAULT NULL,
  `harga` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_barang_harga_potongan
-- ----------------------------

-- ----------------------------
-- Table structure for tbm_cabang
-- ----------------------------
DROP TABLE IF EXISTS `tbm_cabang`;
CREATE TABLE `tbm_cabang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(150) DEFAULT NULL,
  `alamat` varchar(200) DEFAULT NULL,
  `id_kota` int(11) DEFAULT NULL,
  `telp` varchar(15) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `nama_kontak` varchar(200) DEFAULT NULL,
  `pendapatan` decimal(36,2) DEFAULT NULL,
  `umk` decimal(36,2) DEFAULT NULL,
  `ump` decimal(36,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_cabang
-- ----------------------------
INSERT INTO `tbm_cabang` VALUES ('1', 'KANDIR', 'Jl. Lintas Sibuhuan -  Riau KM. 15 Kec. Sosa Kab. Padang Lawas -  Sumatera Utara', '67', '081375765977', 'sinar.halomoan.sh@gmail.com', '', '1983250.00', '1983250.00', '1983250.00', '0');
INSERT INTO `tbm_cabang` VALUES ('2', 'PKS', 'Jl. Lintas Sibuhuan - Riau KM. 15 Kec. Sosa Kab. Padang Lawas - Sumatera Utara', '67', '081375765977', '', '', '1983250.00', '1983250.00', '1983250.00', '0');

-- ----------------------------
-- Table structure for tbm_cetakan
-- ----------------------------
DROP TABLE IF EXISTS `tbm_cetakan`;
CREATE TABLE `tbm_cetakan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_cetakan` varchar(60) DEFAULT '0',
  `kategori_cetakan` int(11) DEFAULT NULL,
  `jns_tinta` char(1) DEFAULT '0',
  `hrg_tinta` float(11,2) DEFAULT NULL,
  `jns_laminasi` char(1) DEFAULT '0',
  `hrg_laminasi` float(11,2) DEFAULT NULL,
  `total_bahan` float(11,2) DEFAULT NULL,
  `total_param` float(11,2) DEFAULT NULL,
  `total_modal` float(11,2) DEFAULT NULL,
  `total_persen` float(11,2) DEFAULT NULL,
  `subtotal` float(11,2) DEFAULT '0.00',
  `total_harga_jual` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_cetakan
-- ----------------------------

-- ----------------------------
-- Table structure for tbm_cetakan_detail_bahan
-- ----------------------------
DROP TABLE IF EXISTS `tbm_cetakan_detail_bahan`;
CREATE TABLE `tbm_cetakan_detail_bahan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cetakan` int(11) DEFAULT '0',
  `id_barang` int(11) DEFAULT NULL,
  `ukuran` int(11) DEFAULT NULL,
  `harga` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_cetakan_detail_bahan
-- ----------------------------

-- ----------------------------
-- Table structure for tbm_cetakan_detail_param
-- ----------------------------
DROP TABLE IF EXISTS `tbm_cetakan_detail_param`;
CREATE TABLE `tbm_cetakan_detail_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cetakan` int(11) DEFAULT '0',
  `parameter` varchar(100) DEFAULT NULL,
  `harga` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_cetakan_detail_param
-- ----------------------------

-- ----------------------------
-- Table structure for tbm_coa
-- ----------------------------
DROP TABLE IF EXISTS `tbm_coa`;
CREATE TABLE `tbm_coa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_group_coa` int(11) DEFAULT NULL,
  `kode_coa` varchar(60) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=943 DEFAULT CHARSET=latin1 AVG_ROW_LENGTH=90;

-- ----------------------------
-- Records of tbm_coa
-- ----------------------------
INSERT INTO `tbm_coa` VALUES ('1', '1', '100.00.000', 'Aktiva Lancar', '0');
INSERT INTO `tbm_coa` VALUES ('2', '7', '101.00.000', 'Kas-Bank', '0');
INSERT INTO `tbm_coa` VALUES ('3', null, '101.01.000', 'Kas', '0');
INSERT INTO `tbm_coa` VALUES ('4', null, '101.01.100', 'Kas Dalam Perusahaan Rupiah', '0');
INSERT INTO `tbm_coa` VALUES ('5', null, '101.01.200', 'Kas Dalam Perusahaan Valas', '0');
INSERT INTO `tbm_coa` VALUES ('6', null, '101.01.300', 'Kas Kecil', '0');
INSERT INTO `tbm_coa` VALUES ('7', null, '101.02.000', 'BNI 46', '0');
INSERT INTO `tbm_coa` VALUES ('8', null, '101.02.100', 'BNI 46 Rupiah', '0');
INSERT INTO `tbm_coa` VALUES ('9', null, '101.02.200', 'BNI 46 Valas', '0');
INSERT INTO `tbm_coa` VALUES ('10', null, '101.03.000', 'Bank Cimb Niaga', '0');
INSERT INTO `tbm_coa` VALUES ('11', null, '101.03.100', 'Bank Cimb Niaga Rupiah', '0');
INSERT INTO `tbm_coa` VALUES ('12', null, '101.03.200', 'Bank Cimb Niaga Valas', '0');
INSERT INTO `tbm_coa` VALUES ('13', null, '101.04.000', 'Bank Syariah Mandiri', '0');
INSERT INTO `tbm_coa` VALUES ('14', null, '101.04.100', 'Bank Syariah Mandiri Rupiah', '0');
INSERT INTO `tbm_coa` VALUES ('15', null, '101.04.200', 'Bank Syariah Mandiri Valas', '0');
INSERT INTO `tbm_coa` VALUES ('16', null, '101.05.000', 'BCA', '0');
INSERT INTO `tbm_coa` VALUES ('17', null, '101.05.100', 'BCA Rupiah', '0');
INSERT INTO `tbm_coa` VALUES ('18', null, '101.05.200', 'BCA Valas', '0');
INSERT INTO `tbm_coa` VALUES ('19', null, '101.06.000', 'BRI', '0');
INSERT INTO `tbm_coa` VALUES ('20', null, '101.06.100', 'BRI Rupiah', '0');
INSERT INTO `tbm_coa` VALUES ('21', null, '101.06.200', 'BRI Valas', '0');
INSERT INTO `tbm_coa` VALUES ('22', null, '101.07.000', 'Bukopin', '0');
INSERT INTO `tbm_coa` VALUES ('23', null, '101.07.100', 'Bukopin Rupiah', '0');
INSERT INTO `tbm_coa` VALUES ('24', null, '101.07.200', 'Bukopin Valas', '0');
INSERT INTO `tbm_coa` VALUES ('25', null, '101.08.000', 'Mandiri', '0');
INSERT INTO `tbm_coa` VALUES ('26', null, '101.08.100', 'Mandiri Rupiah', '0');
INSERT INTO `tbm_coa` VALUES ('27', null, '101.08.200', 'Mandiri Valas', '0');
INSERT INTO `tbm_coa` VALUES ('28', null, '101.09.000', 'BNI Syariah', '0');
INSERT INTO `tbm_coa` VALUES ('29', null, '101.09.100', 'BNI Syariah Rupiah', '0');
INSERT INTO `tbm_coa` VALUES ('30', null, '101.09.200', 'BNI Syariah Valas', '0');
INSERT INTO `tbm_coa` VALUES ('31', null, '101.90.000', 'Bank Daerah', '0');
INSERT INTO `tbm_coa` VALUES ('32', null, '101.90.100', 'Bank Jabar', '0');
INSERT INTO `tbm_coa` VALUES ('33', null, '101.90.101', 'Bank Jabar Rupiah', '0');
INSERT INTO `tbm_coa` VALUES ('34', null, '101.90.200', 'Bank Sumsel', '0');
INSERT INTO `tbm_coa` VALUES ('35', null, '101.90.201', 'Bank Sumsel Rupiah', '0');
INSERT INTO `tbm_coa` VALUES ('36', null, '101.90.300', 'Bank DKI', '0');
INSERT INTO `tbm_coa` VALUES ('37', null, '101.90.301', 'Bank DKI Rupiah', '0');
INSERT INTO `tbm_coa` VALUES ('38', null, '102.00.000', 'Deposito & Kertas Berharga', '0');
INSERT INTO `tbm_coa` VALUES ('39', null, '102.01.000', 'Deposito', '0');
INSERT INTO `tbm_coa` VALUES ('40', null, '102.01.100', 'Deposito Rupiah', '0');
INSERT INTO `tbm_coa` VALUES ('41', null, '102.01.200', 'Deposito Valas', '0');
INSERT INTO `tbm_coa` VALUES ('42', null, '102.02.000', 'Kertas Berharga', '0');
INSERT INTO `tbm_coa` VALUES ('43', null, '102.02.100', 'Kertas Berharga Rupiah', '0');
INSERT INTO `tbm_coa` VALUES ('44', null, '102.02.101', 'Kertas Berharga BNI 46', '0');
INSERT INTO `tbm_coa` VALUES ('45', null, '102.02.102', 'Kertas Berharga Cimb Niaga', '0');
INSERT INTO `tbm_coa` VALUES ('46', null, '102.02.103', 'Kertas Berharga Syariah Mandiri', '0');
INSERT INTO `tbm_coa` VALUES ('47', null, '102.02.104', 'Kertas Berharga BCA', '0');
INSERT INTO `tbm_coa` VALUES ('48', null, '102.02.105', 'Kertas Berharga BRI', '0');
INSERT INTO `tbm_coa` VALUES ('49', null, '102.02.106', 'Kertas Berharga Bukopin', '0');
INSERT INTO `tbm_coa` VALUES ('50', null, '102.02.107', 'Kertas Berharga Mandiri', '0');
INSERT INTO `tbm_coa` VALUES ('51', null, '102.02.108', 'Kertas Berharga BNI Syariah', '0');
INSERT INTO `tbm_coa` VALUES ('52', null, '102.02.109', 'Kertas Berharga Bank Jabar', '0');
INSERT INTO `tbm_coa` VALUES ('53', null, '102.02.110', 'Kertas Berharga Bank Sumsel', '0');
INSERT INTO `tbm_coa` VALUES ('54', null, '102.02.111', 'Kertas Berharga Bank DKI', '0');
INSERT INTO `tbm_coa` VALUES ('55', null, '102.02.200', 'Kertas Berharga Valas', '0');
INSERT INTO `tbm_coa` VALUES ('56', null, '103.00.000', 'Piutang Usaha', '0');
INSERT INTO `tbm_coa` VALUES ('57', null, '103.01.000', 'Piutang Instansi Pemerintah', '0');
INSERT INTO `tbm_coa` VALUES ('58', null, '103.01.101', 'Piutang Rawat Jalan (Pemerintah)', '0');
INSERT INTO `tbm_coa` VALUES ('59', null, '103.01.102', 'Piutang Rawat Inap', '0');
INSERT INTO `tbm_coa` VALUES ('60', null, '103.01.103', 'Piutang Farmasi', '0');
INSERT INTO `tbm_coa` VALUES ('61', null, '103.01.104', 'Piutang Penunjang Medik', '0');
INSERT INTO `tbm_coa` VALUES ('62', null, '103.02.000', 'Piutang BUMN', '0');
INSERT INTO `tbm_coa` VALUES ('63', null, '103.02.101', 'Piutang Rawat Jalan (BUMN)', '0');
INSERT INTO `tbm_coa` VALUES ('64', null, '103.02.102', 'Piutang Rawat Inap', '0');
INSERT INTO `tbm_coa` VALUES ('65', null, '103.02.103', 'Piutang Farmasi', '0');
INSERT INTO `tbm_coa` VALUES ('66', null, '103.02.104', 'Piutang Penunjang Medik', '0');
INSERT INTO `tbm_coa` VALUES ('67', null, '103.03.000', 'Piutang Swasta', '0');
INSERT INTO `tbm_coa` VALUES ('68', null, '103.03.101', 'Piutang Rawat Jalan (Swasta)', '0');
INSERT INTO `tbm_coa` VALUES ('69', null, '103.03.102', 'Piutang Rawat Inap', '0');
INSERT INTO `tbm_coa` VALUES ('70', null, '103.03.103', 'Piutang Farmasi', '0');
INSERT INTO `tbm_coa` VALUES ('71', null, '103.03.104', 'Piutang Penunjang Medik', '0');
INSERT INTO `tbm_coa` VALUES ('72', null, '103.04.000', 'Piutang Perorangan', '0');
INSERT INTO `tbm_coa` VALUES ('73', null, '103.04.100', 'Piutang Perorangan', '0');
INSERT INTO `tbm_coa` VALUES ('74', null, '104.00.000', 'Piutang Pegawai', '0');
INSERT INTO `tbm_coa` VALUES ('75', null, '104.01.000', 'Pegawai Aktif', '0');
INSERT INTO `tbm_coa` VALUES ('76', null, '104.02.000', 'Pensiunan', '0');
INSERT INTO `tbm_coa` VALUES ('77', null, '105.00.000', 'Piutang Konsul', '0');
INSERT INTO `tbm_coa` VALUES ('78', null, '105.01.000', 'Piutang Konsul', '0');
INSERT INTO `tbm_coa` VALUES ('79', null, '106.00.000', 'Piutang Lain-Lain', '0');
INSERT INTO `tbm_coa` VALUES ('80', null, '106.01.000', 'Piutang Lain-Lain', '0');
INSERT INTO `tbm_coa` VALUES ('81', null, '107.00.000', 'Uang Muka', '0');
INSERT INTO `tbm_coa` VALUES ('82', null, '107.01.000', 'Uang Muka Operasional', '0');
INSERT INTO `tbm_coa` VALUES ('83', null, '107.01.100', 'Uang Muka Pembelian', '0');
INSERT INTO `tbm_coa` VALUES ('84', null, '107.01.200', 'Uang Muka Perjalanan Dinas', '0');
INSERT INTO `tbm_coa` VALUES ('85', null, '107.01.300', 'Uang Muka Diklat', '0');
INSERT INTO `tbm_coa` VALUES ('86', null, '107.01.400', 'Uang Muka Foto Copy', '0');
INSERT INTO `tbm_coa` VALUES ('87', null, '107.01.500', 'Um Bonus', '0');
INSERT INTO `tbm_coa` VALUES ('88', null, '107.01.600', 'Um Gaji XIII', '0');
INSERT INTO `tbm_coa` VALUES ('89', null, '107.01.700', 'Um Survey,Study, Dan Pengembangan', '0');
INSERT INTO `tbm_coa` VALUES ('90', null, '107.02.000', 'Uang Muka Operasional Medik', '0');
INSERT INTO `tbm_coa` VALUES ('91', null, '107.02.100', 'Uang Muka Konsul', '0');
INSERT INTO `tbm_coa` VALUES ('92', null, '107.02.200', 'Uang Muka Pembelian Obat Dan Bahan Medis', '0');
INSERT INTO `tbm_coa` VALUES ('93', null, '107.90.000', 'Uang Muka Lain-Lain', '0');
INSERT INTO `tbm_coa` VALUES ('94', null, '107.90.100', 'Uang Muka Lain-Lain', '0');
INSERT INTO `tbm_coa` VALUES ('95', null, '108.00.000', 'Persediaan', '0');
INSERT INTO `tbm_coa` VALUES ('96', null, '108.01.000', 'Persediaan Obat', '0');
INSERT INTO `tbm_coa` VALUES ('97', null, '108.02.000', 'Persediaan Alat Medis Habis Pakai/Disposible', '0');
INSERT INTO `tbm_coa` VALUES ('98', null, '108.03.000', 'Persediaan Bahan Kimia/Reagentia', '0');
INSERT INTO `tbm_coa` VALUES ('99', null, '108.04.000', 'Persediaan X-Ray', '0');
INSERT INTO `tbm_coa` VALUES ('100', null, '108.05.000', 'Persediaan Gas Medis/Oksigen', '0');
INSERT INTO `tbm_coa` VALUES ('101', null, '108.06.000', 'Persediaan Pengolahan Labu Darah', '0');
INSERT INTO `tbm_coa` VALUES ('102', null, '108.07.000', 'Persediaan Obat Askes', '0');
INSERT INTO `tbm_coa` VALUES ('103', null, '108.09.000', 'Persediaan Alat Medis Inventaris', '0');
INSERT INTO `tbm_coa` VALUES ('104', null, '109.00.000', 'Perlengkapan', '0');
INSERT INTO `tbm_coa` VALUES ('105', null, '109.01.000', 'Komaliwan/Pecah Belah', '0');
INSERT INTO `tbm_coa` VALUES ('106', null, '109.02.000', 'Linen Good/Barang Tenun', '0');
INSERT INTO `tbm_coa` VALUES ('107', null, '109.03.000', 'Bahan Cucian', '0');
INSERT INTO `tbm_coa` VALUES ('108', null, '109.04.000', 'Pembungkus / Embalase', '0');
INSERT INTO `tbm_coa` VALUES ('109', null, '109.05.000', 'Bahan Bakar', '0');
INSERT INTO `tbm_coa` VALUES ('110', null, '109.06.000', 'Bahan Pelumas', '0');
INSERT INTO `tbm_coa` VALUES ('111', null, '109.07.000', 'Alat Listrik', '0');
INSERT INTO `tbm_coa` VALUES ('112', null, '109.08.000', 'Pulsa Telepon', '0');
INSERT INTO `tbm_coa` VALUES ('113', null, '109.09.000', 'Alat Tulis', '0');
INSERT INTO `tbm_coa` VALUES ('114', null, '109.10.000', 'Barang Cetakan', '0');
INSERT INTO `tbm_coa` VALUES ('115', null, '109.11.000', 'Materai', '0');
INSERT INTO `tbm_coa` VALUES ('116', null, '109.12.000', 'Bahan Makanan', '0');
INSERT INTO `tbm_coa` VALUES ('117', null, '109.13.000', 'Instrumen Medis', '0');
INSERT INTO `tbm_coa` VALUES ('118', null, '109.14.000', 'Batu Baterai/Senter', '0');
INSERT INTO `tbm_coa` VALUES ('119', null, '109.15.000', 'Pengharum Ruangan', '0');
INSERT INTO `tbm_coa` VALUES ('120', null, '109.16.000', 'Pembasmi Hama/Nyamuk', '0');
INSERT INTO `tbm_coa` VALUES ('121', null, '109.17.000', 'Perlengkapan Bayi', '0');
INSERT INTO `tbm_coa` VALUES ('122', null, '109.18.000', 'Tissue', '0');
INSERT INTO `tbm_coa` VALUES ('123', null, '109.19.000', 'Perlengkapan Apotik', '0');
INSERT INTO `tbm_coa` VALUES ('124', null, '109.20.000', 'Detergen', '0');
INSERT INTO `tbm_coa` VALUES ('125', null, '109.21.000', 'Perlengkapan Rumah Tangga', '0');
INSERT INTO `tbm_coa` VALUES ('126', null, '109.22.000', 'Perlengkapan Bahan Bangunan', '0');
INSERT INTO `tbm_coa` VALUES ('127', null, '109.23.000', 'Perlengkapan Gimmic', '0');
INSERT INTO `tbm_coa` VALUES ('128', null, '110.00.000', 'Pajak Dibayar Dimuka', '0');
INSERT INTO `tbm_coa` VALUES ('129', null, '110.01.000', 'Pph.23', '0');
INSERT INTO `tbm_coa` VALUES ('130', null, '110.02.000', 'Pph.25', '0');
INSERT INTO `tbm_coa` VALUES ('131', null, '111.00.000', 'Ppn Masukan', '0');
INSERT INTO `tbm_coa` VALUES ('132', null, '111.01.000', 'Ppn Masukan Dapat Dikreditkan', '0');
INSERT INTO `tbm_coa` VALUES ('133', null, '112.00.000', 'Beban Dibayar Dimuka', '0');
INSERT INTO `tbm_coa` VALUES ('134', null, '112.01.000', 'Beban Pegawai Dibayar Dimuka', '0');
INSERT INTO `tbm_coa` VALUES ('135', null, '112.02.000', 'Beban Asuransi Dibayar Dimuka', '0');
INSERT INTO `tbm_coa` VALUES ('136', null, '112.03.000', 'Beban Sewa Dibayar Dimuka', '0');
INSERT INTO `tbm_coa` VALUES ('137', null, '112.04.000', 'Beban Provisi Pinjaman Bank Dibayar Dimuka', '0');
INSERT INTO `tbm_coa` VALUES ('138', null, '113.00.000', 'Pendapatan Masih Akan Diterima', '0');
INSERT INTO `tbm_coa` VALUES ('139', null, '113.01.000', 'Pendapatan Masih Akan Diterima', '0');
INSERT INTO `tbm_coa` VALUES ('140', null, '190.00.000', 'Rekening Transfer Kas Bank', '0');
INSERT INTO `tbm_coa` VALUES ('141', null, '190.01.000', 'Rekening Transfer Kas Bank', '0');
INSERT INTO `tbm_coa` VALUES ('142', null, '191.00.000', 'Penyisihan Piutang Usaha', '0');
INSERT INTO `tbm_coa` VALUES ('143', null, '191.01.000', 'Penyisihan Piutang Usaha', '0');
INSERT INTO `tbm_coa` VALUES ('144', null, '192.00.000', 'Penyisihan Piutang Pegawai', '0');
INSERT INTO `tbm_coa` VALUES ('145', null, '192.01.000', 'Penyisihan Piutang Pegawai', '0');
INSERT INTO `tbm_coa` VALUES ('146', null, '194.00.000', 'Penyisihan Piutang Lain-Lain', '0');
INSERT INTO `tbm_coa` VALUES ('147', null, '194.01.000', 'Penyisihan Piutang Lain-Lain', '0');
INSERT INTO `tbm_coa` VALUES ('148', null, '200.00.000', 'Aktiva Tetap', '0');
INSERT INTO `tbm_coa` VALUES ('149', null, '201.00.000', 'Tanah', '0');
INSERT INTO `tbm_coa` VALUES ('150', null, '201.01.000', 'Tanah', '0');
INSERT INTO `tbm_coa` VALUES ('151', null, '202.00.000', 'Bangunan', '0');
INSERT INTO `tbm_coa` VALUES ('152', null, '202.01.000', 'Bangunan Gedung', '0');
INSERT INTO `tbm_coa` VALUES ('153', null, '202.03.000', 'Bengkel & Garasi', '0');
INSERT INTO `tbm_coa` VALUES ('154', null, '202.04.000', 'Gedung Pertemuan/ Sarana Orkes', '0');
INSERT INTO `tbm_coa` VALUES ('155', null, '202.05.000', 'Pos Jaga', '0');
INSERT INTO `tbm_coa` VALUES ('156', null, '202.06.000', 'Sarana IBadah', '0');
INSERT INTO `tbm_coa` VALUES ('157', null, '202.07.000', 'Kantin', '0');
INSERT INTO `tbm_coa` VALUES ('158', null, '202.08.000', 'Bangunan Lain-Lain', '0');
INSERT INTO `tbm_coa` VALUES ('159', null, '203.00.000', 'Peralatan & Instalasi Fasilitasi RS', '0');
INSERT INTO `tbm_coa` VALUES ('160', null, '203.01.000', 'Peralatan Medis', '0');
INSERT INTO `tbm_coa` VALUES ('161', null, '203.01.101', 'Electro Medis', '0');
INSERT INTO `tbm_coa` VALUES ('162', null, '203.01.102', 'Mekanis Medis', '0');
INSERT INTO `tbm_coa` VALUES ('163', null, '203.02.000', 'Peralatan Non Medis', '0');
INSERT INTO `tbm_coa` VALUES ('164', null, '203.02.101', 'Peralatan', '0');
INSERT INTO `tbm_coa` VALUES ('165', null, '203.02.102', 'Meubelair', '0');
INSERT INTO `tbm_coa` VALUES ('166', null, '203.02.103', 'Komputer Dan Peralatannya', '0');
INSERT INTO `tbm_coa` VALUES ('167', null, '203.03.000', 'Instalasi Fasilitas RS', '0');
INSERT INTO `tbm_coa` VALUES ('168', null, '203.03.101', 'Instalasi Air & Peralatan', '0');
INSERT INTO `tbm_coa` VALUES ('169', null, '203.03.102', 'Instalasi Listrik & Peralatan', '0');
INSERT INTO `tbm_coa` VALUES ('170', null, '203.03.103', 'Telekomunikasi & Peralatan', '0');
INSERT INTO `tbm_coa` VALUES ('171', null, '203.03.104', 'Instalasi Gas Medis', '0');
INSERT INTO `tbm_coa` VALUES ('172', null, '204.00.000', 'Kendaraan', '0');
INSERT INTO `tbm_coa` VALUES ('173', null, '204.01.000', 'Mobil Ambulance / Mobil Jenazah', '0');
INSERT INTO `tbm_coa` VALUES ('174', null, '204.02.000', 'Mobil Operasional', '0');
INSERT INTO `tbm_coa` VALUES ('175', null, '204.03.000', 'Sepeda Motor', '0');
INSERT INTO `tbm_coa` VALUES ('176', null, '204.04.000', 'Kendaraan Lain-Lain', '0');
INSERT INTO `tbm_coa` VALUES ('177', null, '205.00.000', 'Emplasemen', '0');
INSERT INTO `tbm_coa` VALUES ('178', null, '205.01.000', 'Riol & Selokan', '0');
INSERT INTO `tbm_coa` VALUES ('179', null, '205.02.000', 'Taman', '0');
INSERT INTO `tbm_coa` VALUES ('180', null, '205.03.000', 'Pagar', '0');
INSERT INTO `tbm_coa` VALUES ('181', null, '205.04.000', 'Lapangan Parkir', '0');
INSERT INTO `tbm_coa` VALUES ('182', null, '206.00.000', 'Aktiva Tak Berwujud', '0');
INSERT INTO `tbm_coa` VALUES ('183', null, '206.01.000', 'Pengurusan Hak Atas Tanah', '0');
INSERT INTO `tbm_coa` VALUES ('184', null, '206.02.000', 'Perizinan Dan Sejenisnya', '0');
INSERT INTO `tbm_coa` VALUES ('185', null, '206.03.000', 'Perangkat Lunak Komputer', '0');
INSERT INTO `tbm_coa` VALUES ('186', null, '206.04.000', 'Lisensi', '0');
INSERT INTO `tbm_coa` VALUES ('187', null, '260.00.000', 'Akumulasi Penyusutan Aktiva Tetap', '0');
INSERT INTO `tbm_coa` VALUES ('188', null, '261.00.000', 'Akum. Peny. Bangunan', '0');
INSERT INTO `tbm_coa` VALUES ('189', null, '261.01.000', 'Bangunan Gedung', '0');
INSERT INTO `tbm_coa` VALUES ('190', null, '261.02.000', 'Bengkel & Garasi', '0');
INSERT INTO `tbm_coa` VALUES ('191', null, '261.03.000', 'Gedung Pertemuan/ Sarana Orkes', '0');
INSERT INTO `tbm_coa` VALUES ('192', null, '261.04.000', 'Pos Jaga', '0');
INSERT INTO `tbm_coa` VALUES ('193', null, '261.05.000', 'Sarana IBadah', '0');
INSERT INTO `tbm_coa` VALUES ('194', null, '261.06.000', 'Kantin', '0');
INSERT INTO `tbm_coa` VALUES ('195', null, '261.07.000', 'Bangunan Lain-Lain', '0');
INSERT INTO `tbm_coa` VALUES ('196', null, '262.00.000', 'Akum. Peny. Peralatan & Inst. Fas. RS', '0');
INSERT INTO `tbm_coa` VALUES ('197', null, '262.01.000', 'Akum. Peny. Peralatan', '0');
INSERT INTO `tbm_coa` VALUES ('198', null, '262.01.101', 'Electro Medis', '0');
INSERT INTO `tbm_coa` VALUES ('199', null, '262.01.102', 'Mekanis Medis', '0');
INSERT INTO `tbm_coa` VALUES ('200', null, '262.02.000', 'Akum. Peny. Peralatan Non Medis', '0');
INSERT INTO `tbm_coa` VALUES ('201', null, '262.02.101', 'Peralatan', '0');
INSERT INTO `tbm_coa` VALUES ('202', null, '262.02.102', 'Meubelair', '0');
INSERT INTO `tbm_coa` VALUES ('203', null, '262.02.103', 'Komputer Dan Peralatannya', '0');
INSERT INTO `tbm_coa` VALUES ('204', null, '262.03.000', 'Akum. Peny. Instalasi Fasilitas Rumah Sakit', '0');
INSERT INTO `tbm_coa` VALUES ('205', null, '262.03.101', 'Instalasi Air & Peralatan', '0');
INSERT INTO `tbm_coa` VALUES ('206', null, '262.03.102', 'Instalasi Listrik & Peralatan', '0');
INSERT INTO `tbm_coa` VALUES ('207', null, '262.03.103', 'Telekomunikasi & Peralatan', '0');
INSERT INTO `tbm_coa` VALUES ('208', null, '262.03.104', 'Instalasi Gas Medis', '0');
INSERT INTO `tbm_coa` VALUES ('209', null, '263.00.000', 'Akum. Peny. Kendaraan', '0');
INSERT INTO `tbm_coa` VALUES ('210', null, '263.01.000', 'Akum.Peny. Ambulance/Kereta Jenazah', '0');
INSERT INTO `tbm_coa` VALUES ('211', null, '263.02.000', 'Akum.Peny. Mobil Operasional', '0');
INSERT INTO `tbm_coa` VALUES ('212', null, '263.03.000', 'Akum.Peny. Sepeda Motor', '0');
INSERT INTO `tbm_coa` VALUES ('213', null, '263.04.000', 'Akum.Peny. Kendaraan Lain-Lain', '0');
INSERT INTO `tbm_coa` VALUES ('214', null, '264.00.000', 'Akum. Peny. Emplasemen', '0');
INSERT INTO `tbm_coa` VALUES ('215', null, '264.01.000', 'Akum. Peny. Riol & Selokan', '0');
INSERT INTO `tbm_coa` VALUES ('216', null, '264.02.000', 'Akum. Peny. Taman', '0');
INSERT INTO `tbm_coa` VALUES ('217', null, '264.03.000', 'Akum. Peny. Pagar', '0');
INSERT INTO `tbm_coa` VALUES ('218', null, '264.04.000', 'Akum. Peny. Lapangan Parkir', '0');
INSERT INTO `tbm_coa` VALUES ('219', null, '300.00.000', 'Aktiva Lain - Lain', '0');
INSERT INTO `tbm_coa` VALUES ('220', null, '301.00.000', 'Aktiva Tetap Dalam Konstruksi / Proses', '0');
INSERT INTO `tbm_coa` VALUES ('221', null, '301.01.000', 'Bangunan', '0');
INSERT INTO `tbm_coa` VALUES ('222', null, '301.02.000', 'Peralatan & Fas.Jaringan Rumah Sakit', '0');
INSERT INTO `tbm_coa` VALUES ('223', null, '301.03.000', 'Emplasmen', '0');
INSERT INTO `tbm_coa` VALUES ('224', null, '301.04.000', 'Aktiva Tetap Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('225', null, '301.05.000', 'Renovasi', '0');
INSERT INTO `tbm_coa` VALUES ('226', null, '302.00.000', 'Beban Yang Ditangguhkan', '0');
INSERT INTO `tbm_coa` VALUES ('227', null, '302.01.000', 'Beban Survey Yang Ditangguhkan', '0');
INSERT INTO `tbm_coa` VALUES ('228', null, '302.02.000', 'Beban Konsultan Yang Ditangguhkan', '0');
INSERT INTO `tbm_coa` VALUES ('229', null, '302.03.000', 'Beban Pendidikan Yang Ditangguhkan', '0');
INSERT INTO `tbm_coa` VALUES ('230', null, '302.04.000', 'Beban Yang Ditangguhkan Bangunan', '0');
INSERT INTO `tbm_coa` VALUES ('231', null, '302.05.000', 'Beban Ditangguhkan Perolehan Hak Atas Tanah & Bgn', '0');
INSERT INTO `tbm_coa` VALUES ('232', null, '302.06.000', 'Beban Ditangguhkan Atas Akreditasi RS', '0');
INSERT INTO `tbm_coa` VALUES ('233', null, '303.00.000', 'Aktiva Tetap Tak Berfungsi', '0');
INSERT INTO `tbm_coa` VALUES ('234', null, '303.01.000', 'Bangunan', '0');
INSERT INTO `tbm_coa` VALUES ('235', null, '303.02.000', 'Peralatan & Fas.Jaringan Rumah Sakit', '0');
INSERT INTO `tbm_coa` VALUES ('236', null, '303.03.000', 'Kendaraan', '0');
INSERT INTO `tbm_coa` VALUES ('237', null, '303.04.000', 'Emplasemen', '0');
INSERT INTO `tbm_coa` VALUES ('238', null, '330.00.000', 'Amortisasi Aktiva Tak Berwujud', '0');
INSERT INTO `tbm_coa` VALUES ('239', null, '330.01.000', 'Amortisasi Beban Perizinan Hak Atas Tanah', '0');
INSERT INTO `tbm_coa` VALUES ('240', null, '330.02.000', 'Amortisasi Beban Pendirian & Sejenisnya', '0');
INSERT INTO `tbm_coa` VALUES ('241', null, '330.03.000', 'Amortisasi Lisensi', '0');
INSERT INTO `tbm_coa` VALUES ('242', null, '330.04.000', 'Amortisasi Aktiva Tak Berwujud Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('243', null, '350.00.000', 'Amortisasi Beban Yang Ditangguhkan', '0');
INSERT INTO `tbm_coa` VALUES ('244', null, '350.01.000', 'Amortisasi Survey', '0');
INSERT INTO `tbm_coa` VALUES ('245', null, '350.02.000', 'Amortisasi Konsultan', '0');
INSERT INTO `tbm_coa` VALUES ('246', null, '350.03.000', 'Amortisasi Pendidikan', '0');
INSERT INTO `tbm_coa` VALUES ('247', null, '350.04.000', 'Amortisasi Bangunan', '0');
INSERT INTO `tbm_coa` VALUES ('248', null, '350.05.000', 'Amortisasi Perolehan Hak Atas Tanah & Bgn', '0');
INSERT INTO `tbm_coa` VALUES ('249', null, '350.06.000', 'Amortisasi Akreditasi', '0');
INSERT INTO `tbm_coa` VALUES ('250', null, '400.00.000', 'Kewajiban Lancar', '0');
INSERT INTO `tbm_coa` VALUES ('251', null, '401.00.000', 'Hutang Usaha', '0');
INSERT INTO `tbm_coa` VALUES ('252', null, '401.01.000', 'Hutang Usaha Obat', '0');
INSERT INTO `tbm_coa` VALUES ('253', null, '401.02.000', 'Hutang Usaha Non Obat', '0');
INSERT INTO `tbm_coa` VALUES ('254', null, '401.03.000', 'Hutang Usaha Perlengkapan', '0');
INSERT INTO `tbm_coa` VALUES ('255', null, '401.04.000', 'Hutang Usaha Pelayanan Kesehatan', '0');
INSERT INTO `tbm_coa` VALUES ('256', null, '401.05.000', 'Hutang Usaha Investasi', '0');
INSERT INTO `tbm_coa` VALUES ('257', null, '401.99.000', 'Hutang Usaha Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('258', null, '402.00.000', 'Uper Pasien / Uang Panjar', '0');
INSERT INTO `tbm_coa` VALUES ('259', null, '402.01.000', 'Kelas VVIP', '0');
INSERT INTO `tbm_coa` VALUES ('260', null, '402.01.100', 'Kelas VVIP', '0');
INSERT INTO `tbm_coa` VALUES ('261', null, '402.01.200', 'Kelas VIP Utama', '0');
INSERT INTO `tbm_coa` VALUES ('262', null, '402.01.300', 'Kelas Super VIP', '0');
INSERT INTO `tbm_coa` VALUES ('263', null, '402.02.000', 'Kelas VIP', '0');
INSERT INTO `tbm_coa` VALUES ('264', null, '402.02.100', 'Kelas VIP', '0');
INSERT INTO `tbm_coa` VALUES ('265', null, '402.02.200', 'Kelas VIP A', '0');
INSERT INTO `tbm_coa` VALUES ('266', null, '402.02.300', 'Kelas VIP B', '0');
INSERT INTO `tbm_coa` VALUES ('267', null, '402.02.400', 'Kelas VIP C', '0');
INSERT INTO `tbm_coa` VALUES ('268', null, '402.03.000', 'Kelas I', '0');
INSERT INTO `tbm_coa` VALUES ('269', null, '402.03.100', 'Kelas I', '0');
INSERT INTO `tbm_coa` VALUES ('270', null, '402.03.200', 'Kelas IA', '0');
INSERT INTO `tbm_coa` VALUES ('271', null, '402.03.300', 'Kelas IB', '0');
INSERT INTO `tbm_coa` VALUES ('272', null, '402.04.000', 'Kelas II', '0');
INSERT INTO `tbm_coa` VALUES ('273', null, '402.04.100', 'Kelas II', '0');
INSERT INTO `tbm_coa` VALUES ('274', null, '402.04.200', 'Kelas IIA', '0');
INSERT INTO `tbm_coa` VALUES ('275', null, '402.04.300', 'Kelas IIA', '0');
INSERT INTO `tbm_coa` VALUES ('276', null, '402.05.000', 'Kelas III', '0');
INSERT INTO `tbm_coa` VALUES ('277', null, '402.05.100', 'Kelas III', '0');
INSERT INTO `tbm_coa` VALUES ('278', null, '402.05.200', 'Kelas IIIA', '0');
INSERT INTO `tbm_coa` VALUES ('279', null, '402.05.300', 'Kelas IIIB', '0');
INSERT INTO `tbm_coa` VALUES ('280', null, '402.06.000', 'Kamar Bersalin', '0');
INSERT INTO `tbm_coa` VALUES ('281', null, '402.06.100', 'Kamar Bersalin', '0');
INSERT INTO `tbm_coa` VALUES ('282', null, '402.07.000', 'Ruang Perinatologi', '0');
INSERT INTO `tbm_coa` VALUES ('283', null, '402.07.100', 'Ruang Perinatologi', '0');
INSERT INTO `tbm_coa` VALUES ('284', null, '402.08.000', 'Ruang Isolasi', '0');
INSERT INTO `tbm_coa` VALUES ('285', null, '402.08.100', 'Ruang Isolasi', '0');
INSERT INTO `tbm_coa` VALUES ('286', null, '402.09.000', 'Ruang Anak', '0');
INSERT INTO `tbm_coa` VALUES ('287', null, '402.09.100', 'Ruang Anak', '0');
INSERT INTO `tbm_coa` VALUES ('288', null, '402.10.000', 'Kamar Operasi', '0');
INSERT INTO `tbm_coa` VALUES ('289', null, '402.10.100', 'Kamar Operasi', '0');
INSERT INTO `tbm_coa` VALUES ('290', null, '402.11.000', 'HCU', '0');
INSERT INTO `tbm_coa` VALUES ('291', null, '402.11.100', 'ICU', '0');
INSERT INTO `tbm_coa` VALUES ('292', null, '403.00.000', 'Uang Titipan', '0');
INSERT INTO `tbm_coa` VALUES ('293', null, '403.01.000', 'Utip Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('294', null, '403.02.000', 'Utip Potongan Anak Asuh', '0');
INSERT INTO `tbm_coa` VALUES ('295', null, '403.03.000', 'Utip PrimkokaRS', '0');
INSERT INTO `tbm_coa` VALUES ('296', null, '403.04.000', 'Utip Kopegmar', '0');
INSERT INTO `tbm_coa` VALUES ('297', null, '403.05.000', 'Utip Zakat,Infaq & Sodaqoh (ZIS)', '0');
INSERT INTO `tbm_coa` VALUES ('298', null, '403.06.000', 'Utip Serikat Pekerja', '0');
INSERT INTO `tbm_coa` VALUES ('299', null, '403.07.000', 'Utip Premi Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('300', null, '403.08.000', 'Utip Iuran Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('301', null, '403.09.000', 'Utip Premi Taspen', '0');
INSERT INTO `tbm_coa` VALUES ('302', null, '403.10.000', 'Utip Nilai Tebus Jht', '0');
INSERT INTO `tbm_coa` VALUES ('303', null, '403.11.000', 'Utip Asuransi', '0');
INSERT INTO `tbm_coa` VALUES ('304', null, '403.99.000', 'Utip Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('305', null, '404.00.000', 'Hutang Jk. Panjang Yang Jatuh Tempo', '0');
INSERT INTO `tbm_coa` VALUES ('306', null, '404.01.000', 'Hutang Jangka Panjang Jatuh Tempo', '0');
INSERT INTO `tbm_coa` VALUES ('307', null, '405.00.000', 'Hutang Bonus', '0');
INSERT INTO `tbm_coa` VALUES ('308', null, '405.01.000', 'Hutang Bonus', '0');
INSERT INTO `tbm_coa` VALUES ('309', null, '406.00.000', 'Hutang Pajak', '0');
INSERT INTO `tbm_coa` VALUES ('310', null, '406.01.000', 'Pph 21', '0');
INSERT INTO `tbm_coa` VALUES ('311', null, '406.01.100', 'Pph 21 Organik', '0');
INSERT INTO `tbm_coa` VALUES ('312', null, '406.01.200', 'Pph 21 Pkwt', '0');
INSERT INTO `tbm_coa` VALUES ('313', null, '406.01.300', 'Pph 21 Tenaga Ahli', '0');
INSERT INTO `tbm_coa` VALUES ('314', null, '406.01.400', 'Pph 21 Penerima Honor', '0');
INSERT INTO `tbm_coa` VALUES ('315', null, '406.02.000', 'Pph 23', '0');
INSERT INTO `tbm_coa` VALUES ('316', null, '406.03.000', 'Ppn Keluaran', '0');
INSERT INTO `tbm_coa` VALUES ('317', null, '406.04.000', 'Bea Perolehan Hak Atas Tanah Dan Bangunan (BPHTB)', '0');
INSERT INTO `tbm_coa` VALUES ('318', null, '406.05.000', 'Pph Psl 4 (2)', '0');
INSERT INTO `tbm_coa` VALUES ('319', null, '406.06.000', 'Hutang Pajak Bumi Dan Bangunan (PBB)', '0');
INSERT INTO `tbm_coa` VALUES ('320', null, '406.90.000', 'Pph Badan', '0');
INSERT INTO `tbm_coa` VALUES ('321', null, '409.00.000', 'Hutang Iuran Dana Pensiun', '0');
INSERT INTO `tbm_coa` VALUES ('322', null, '409.01.000', 'Iuran Peserta', '0');
INSERT INTO `tbm_coa` VALUES ('323', null, '409.02.000', 'Tunjangan Perusahaan', '0');
INSERT INTO `tbm_coa` VALUES ('324', null, '410.00.000', 'Beban Yang Masih Harus Dibayar', '0');
INSERT INTO `tbm_coa` VALUES ('325', null, '410.01.000', 'Beban Gaji Yang Masih Harus Dibayar', '0');
INSERT INTO `tbm_coa` VALUES ('326', null, '410.02.000', 'Beban Jasa Medik Yang Masih Harus Dibayar', '0');
INSERT INTO `tbm_coa` VALUES ('327', null, '410.03.000', 'Beban Jasa Penunjang Medik Ymh Dibayar', '0');
INSERT INTO `tbm_coa` VALUES ('328', null, '410.04.000', 'Beban Air Yang Masih Harus Dibayar', '0');
INSERT INTO `tbm_coa` VALUES ('329', null, '410.05.000', 'Beban Listrik Yang Masih Harus Dibayar', '0');
INSERT INTO `tbm_coa` VALUES ('330', null, '410.06.000', 'Beban Telpon Yang Masih Harus Dibayar', '0');
INSERT INTO `tbm_coa` VALUES ('331', null, '410.07.000', 'Beban Gas Yang Masih Harus Dibayar', '0');
INSERT INTO `tbm_coa` VALUES ('332', null, '410.08.000', 'Beban Sewa Yang Masih Harus Dibayar', '0');
INSERT INTO `tbm_coa` VALUES ('333', null, '410.09.000', 'Beban Insentif Yang Masih Harus Dibayar', '0');
INSERT INTO `tbm_coa` VALUES ('334', null, '410.10.000', 'Beban Pbb Yang Masih Harus Dibayar', '0');
INSERT INTO `tbm_coa` VALUES ('335', null, '410.11.000', 'Beban Premi Kesehatan Yang Masih Harus Dibayar', '0');
INSERT INTO `tbm_coa` VALUES ('336', null, '410.90.000', 'Beban Lainnya Yang Masih Harus Dibayar', '0');
INSERT INTO `tbm_coa` VALUES ('337', null, '411.00.000', 'Pendapatan Diterima Dimuka', '0');
INSERT INTO `tbm_coa` VALUES ('338', null, '411.01.000', 'Pendapatan Yang Diterima Dimuka', '0');
INSERT INTO `tbm_coa` VALUES ('339', null, '418.00.000', 'Hutang Dividen', '0');
INSERT INTO `tbm_coa` VALUES ('340', null, '418.01.000', 'Hutang Dividen', '0');
INSERT INTO `tbm_coa` VALUES ('341', null, '419.00.000', 'Hutang Tantiem', '0');
INSERT INTO `tbm_coa` VALUES ('342', null, '419.01.000', 'Hutang Tantiem', '0');
INSERT INTO `tbm_coa` VALUES ('343', null, '429.00.000', 'Cadangan Klaim', '0');
INSERT INTO `tbm_coa` VALUES ('344', null, '429.01.000', 'Cadangan Klaim', '0');
INSERT INTO `tbm_coa` VALUES ('345', null, '499.00.000', 'Hutang Lancar', '0');
INSERT INTO `tbm_coa` VALUES ('346', null, '499.01.000', 'Hutang Konsul Medik', '0');
INSERT INTO `tbm_coa` VALUES ('347', null, '499.90.000', 'Hutang Lancar Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('348', null, '500.00.000', 'Kewajiban Jangka Panjang', '0');
INSERT INTO `tbm_coa` VALUES ('349', null, '510.00.000', 'Pinjaman Bank', '0');
INSERT INTO `tbm_coa` VALUES ('350', null, '510.01.000', 'Pinjaman Bank', '0');
INSERT INTO `tbm_coa` VALUES ('351', null, '520.00.000', 'Hutang Jaminan', '0');
INSERT INTO `tbm_coa` VALUES ('352', null, '520.01.000', 'Hutang Jaminan', '0');
INSERT INTO `tbm_coa` VALUES ('353', null, '530.00.000', 'Kewajiban Imbalan Pasca Kerja', '0');
INSERT INTO `tbm_coa` VALUES ('354', null, '530.01.000', 'Kewajiban Imbalan Pasca Kerja', '0');
INSERT INTO `tbm_coa` VALUES ('355', null, '540.00.000', 'Kewajiban Pajak Tangguhan', '0');
INSERT INTO `tbm_coa` VALUES ('356', null, '540.01.000', 'Kewajiban Pajak Tangguhan', '0');
INSERT INTO `tbm_coa` VALUES ('357', null, '599.00.000', 'Kewajiban Jangka Panjang Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('358', null, '599.01.000', 'Pinjaman Bank', '0');
INSERT INTO `tbm_coa` VALUES ('359', null, '599.02.000', 'Kewajiban Jangka Panjang Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('360', null, '600.00.000', 'Ekuitas', '0');
INSERT INTO `tbm_coa` VALUES ('361', null, '601.00.000', 'Modal Saham', '0');
INSERT INTO `tbm_coa` VALUES ('362', null, '601.01.000', 'Modal Saham', '0');
INSERT INTO `tbm_coa` VALUES ('363', null, '601.01.100', 'PT. (PeRSero) Pelabuhan Indonesia II', '0');
INSERT INTO `tbm_coa` VALUES ('364', null, '601.01.200', 'Kopegmar', '0');
INSERT INTO `tbm_coa` VALUES ('365', null, '602.00.000', 'Modal Saham Belum Ditempatkan', '0');
INSERT INTO `tbm_coa` VALUES ('366', null, '602.01.000', 'Modal Saham Belum Ditempatkan', '0');
INSERT INTO `tbm_coa` VALUES ('367', null, '604.00.000', 'Modal Saham Disetor', '0');
INSERT INTO `tbm_coa` VALUES ('368', null, '604.01.000', 'PT. (PeRSero) Pelabuhan Indonesia II', '0');
INSERT INTO `tbm_coa` VALUES ('369', null, '604.02.000', 'Kopegmar', '0');
INSERT INTO `tbm_coa` VALUES ('370', null, '605.00.000', 'Modal Donasi', '0');
INSERT INTO `tbm_coa` VALUES ('371', null, '605.01.000', 'Bantuan Pemerintah', '0');
INSERT INTO `tbm_coa` VALUES ('372', null, '605.02.000', 'Bantuan Swasta', '0');
INSERT INTO `tbm_coa` VALUES ('373', null, '605.99.000', 'Bantuan Pihak Lain', '0');
INSERT INTO `tbm_coa` VALUES ('374', null, '606.00.000', 'Selisih Penilaian Kembali Aktiva Tetap', '0');
INSERT INTO `tbm_coa` VALUES ('375', null, '606.01.000', 'Selisih Penilaian Kembali Aktiva Tetap Tanah', '0');
INSERT INTO `tbm_coa` VALUES ('376', null, '606.02.000', 'Selisih Penilaian Kembali Aktiva Tetap Bangunan', '0');
INSERT INTO `tbm_coa` VALUES ('377', null, '606.03.000', 'Selisih Penilaian Kembali Aktiva Tetap Peralatan', '0');
INSERT INTO `tbm_coa` VALUES ('378', null, '606.04.000', 'Selisih Penilaian Kembali Aktiva Tetap Kendaraan', '0');
INSERT INTO `tbm_coa` VALUES ('379', null, '606.06.000', 'Selisih Penilaian Kembali Aktiva Tetap Emplasemen', '0');
INSERT INTO `tbm_coa` VALUES ('380', null, '607.00.000', 'Cadangan Umum', '0');
INSERT INTO `tbm_coa` VALUES ('381', null, '607.01.000', 'Cadangan Umum', '0');
INSERT INTO `tbm_coa` VALUES ('382', null, '630.00.000', 'Laba (Rugi) Periode Lalu', '0');
INSERT INTO `tbm_coa` VALUES ('383', null, '630.01.000', 'Laba (Rugi) Periode Lalu', '0');
INSERT INTO `tbm_coa` VALUES ('384', null, '631.00.000', 'Laba (Rugi) Periode Berjalan', '0');
INSERT INTO `tbm_coa` VALUES ('385', null, '631.01.000', 'Laba (Rugi) Periode Berjalan', '0');
INSERT INTO `tbm_coa` VALUES ('386', null, '700.00.000', 'Pendapatan', '0');
INSERT INTO `tbm_coa` VALUES ('387', null, '701.00.000', 'Pendapatan Pelayanan Medik Dan Keperawatan', '0');
INSERT INTO `tbm_coa` VALUES ('388', null, '701.01.000', 'Instalasi Rawat Jalan', '0');
INSERT INTO `tbm_coa` VALUES ('389', null, '701.01.100', 'Klinik Umum', '0');
INSERT INTO `tbm_coa` VALUES ('390', null, '701.01.101', 'Klinik Umum', '0');
INSERT INTO `tbm_coa` VALUES ('391', null, '701.01.102', 'Klinik Gigi & Mulut', '0');
INSERT INTO `tbm_coa` VALUES ('392', null, '701.01.103', 'KIA', '0');
INSERT INTO `tbm_coa` VALUES ('393', null, '701.01.104', 'MCU', '0');
INSERT INTO `tbm_coa` VALUES ('394', null, '701.01.200', 'Klinik Spesialis', '0');
INSERT INTO `tbm_coa` VALUES ('395', null, '701.01.201', 'Klinik Psycologi', '0');
INSERT INTO `tbm_coa` VALUES ('396', null, '701.01.202', 'Klinik Spesialis Dalam', '0');
INSERT INTO `tbm_coa` VALUES ('397', null, '701.01.203', 'Klinik Spesialis Jantung', '0');
INSERT INTO `tbm_coa` VALUES ('398', null, '701.01.204', 'Klinik Spesialis Anak', '0');
INSERT INTO `tbm_coa` VALUES ('399', null, '701.01.205', 'Klinik Spesialis Bedah Umum', '0');
INSERT INTO `tbm_coa` VALUES ('400', null, '701.01.206', 'Klinik Spesialis Bedah Tulang', '0');
INSERT INTO `tbm_coa` VALUES ('401', null, '701.01.207', 'Klinik Spesialis Bedah Urolog', '0');
INSERT INTO `tbm_coa` VALUES ('402', null, '701.01.208', 'Klinik Spesialis Bedah Syaraf', '0');
INSERT INTO `tbm_coa` VALUES ('403', null, '701.01.209', 'Klinik Spesialis Bedah Plastik', '0');
INSERT INTO `tbm_coa` VALUES ('404', null, '701.01.210', 'Klinik Spesialis Kebidanan/ Kandungan', '0');
INSERT INTO `tbm_coa` VALUES ('405', null, '701.01.211', 'Klinik Spesialis Tht', '0');
INSERT INTO `tbm_coa` VALUES ('406', null, '701.01.212', 'Klinik Spesialis Mata', '0');
INSERT INTO `tbm_coa` VALUES ('407', null, '701.01.213', 'Klinik Spesialis Paru-Paru', '0');
INSERT INTO `tbm_coa` VALUES ('408', null, '701.01.214', 'Klinik Spesialis Kulit/ Kelamin', '0');
INSERT INTO `tbm_coa` VALUES ('409', null, '701.01.215', 'Klinik Spesialis Syaraf', '0');
INSERT INTO `tbm_coa` VALUES ('410', null, '701.01.216', 'Klinik Spesialis Jiwa', '0');
INSERT INTO `tbm_coa` VALUES ('411', null, '701.01.217', 'Klinik Spesialis Bedah Mulut', '0');
INSERT INTO `tbm_coa` VALUES ('412', null, '701.01.218', 'Klinik Orthodentie', '0');
INSERT INTO `tbm_coa` VALUES ('413', null, '701.01.219', 'Klinik Diabetes', '0');
INSERT INTO `tbm_coa` VALUES ('414', null, '701.01.220', 'Klinik Eksekutif', '0');
INSERT INTO `tbm_coa` VALUES ('415', null, '701.01.221', 'Klinik Kecantikan', '0');
INSERT INTO `tbm_coa` VALUES ('416', null, '701.01.500', 'Klinik Luar RSP Jakarta', '0');
INSERT INTO `tbm_coa` VALUES ('417', null, '701.01.501', 'Klinik Umum JICT', '0');
INSERT INTO `tbm_coa` VALUES ('418', null, '701.01.502', 'Klinik Gigi JICT', '0');
INSERT INTO `tbm_coa` VALUES ('419', null, '701.01.503', 'Klinik Tkbm Kramat Jaya', '0');
INSERT INTO `tbm_coa` VALUES ('420', null, '701.01.504', 'Klinik Tkbm Cilincing', '0');
INSERT INTO `tbm_coa` VALUES ('421', null, '701.01.505', 'Klinik Bekasi', '0');
INSERT INTO `tbm_coa` VALUES ('422', null, '701.01.600', 'Klinik Luar RSP Cirebon', '0');
INSERT INTO `tbm_coa` VALUES ('423', null, '701.01.700', 'Klinik Luar RSP Palembang', '0');
INSERT INTO `tbm_coa` VALUES ('424', null, '701.01.800', 'Klinik Luar RS PMC', '0');
INSERT INTO `tbm_coa` VALUES ('425', null, '701.02.000', 'Instalasi Rawat Inap', '0');
INSERT INTO `tbm_coa` VALUES ('426', null, '701.02.100', 'Kelas VVIP', '0');
INSERT INTO `tbm_coa` VALUES ('427', null, '701.02.101', 'Kelas VVIP', '0');
INSERT INTO `tbm_coa` VALUES ('428', null, '701.02.102', 'Kelas VIP Utama', '0');
INSERT INTO `tbm_coa` VALUES ('429', null, '701.02.103', 'Kelas Super VIP', '0');
INSERT INTO `tbm_coa` VALUES ('430', null, '701.02.200', 'Kelas VIP', '0');
INSERT INTO `tbm_coa` VALUES ('431', null, '701.02.201', 'Kelas VIP', '0');
INSERT INTO `tbm_coa` VALUES ('432', null, '701.02.202', 'Kelas VIP A', '0');
INSERT INTO `tbm_coa` VALUES ('433', null, '701.02.203', 'Kelas VIP B', '0');
INSERT INTO `tbm_coa` VALUES ('434', null, '701.02.204', 'Kelas VIP C', '0');
INSERT INTO `tbm_coa` VALUES ('435', null, '701.02.300', 'Kelas I', '0');
INSERT INTO `tbm_coa` VALUES ('436', null, '701.02.301', 'Kelas I', '0');
INSERT INTO `tbm_coa` VALUES ('437', null, '701.02.302', 'Kelas IA', '0');
INSERT INTO `tbm_coa` VALUES ('438', null, '701.02.303', 'Kelas IB', '0');
INSERT INTO `tbm_coa` VALUES ('439', null, '701.02.400', 'Kelas II', '0');
INSERT INTO `tbm_coa` VALUES ('440', null, '701.02.401', 'Kelas II', '0');
INSERT INTO `tbm_coa` VALUES ('441', null, '701.02.402', 'Kelas IIA', '0');
INSERT INTO `tbm_coa` VALUES ('442', null, '701.02.403', 'Kelas IIB', '0');
INSERT INTO `tbm_coa` VALUES ('443', null, '701.02.500', 'Kelas III', '0');
INSERT INTO `tbm_coa` VALUES ('444', null, '701.02.501', 'Kelas III', '0');
INSERT INTO `tbm_coa` VALUES ('445', null, '701.02.502', 'Kelas IIIA', '0');
INSERT INTO `tbm_coa` VALUES ('446', null, '701.02.503', 'Kelas IIIB', '0');
INSERT INTO `tbm_coa` VALUES ('447', null, '701.02.600', 'Kamar Bersalin', '0');
INSERT INTO `tbm_coa` VALUES ('448', null, '701.02.601', 'Kamar Bersalin', '0');
INSERT INTO `tbm_coa` VALUES ('449', null, '701.02.700', 'Ruang Perinatologi', '0');
INSERT INTO `tbm_coa` VALUES ('450', null, '701.02.701', 'Ruang Perinatologi', '0');
INSERT INTO `tbm_coa` VALUES ('451', null, '701.02.800', 'Ruang Isolasi', '0');
INSERT INTO `tbm_coa` VALUES ('452', null, '701.02.801', 'Ruang Isolasi', '0');
INSERT INTO `tbm_coa` VALUES ('453', null, '701.02.900', 'Ruang Anak', '0');
INSERT INTO `tbm_coa` VALUES ('454', null, '701.02.901', 'Ruang Anak', '0');
INSERT INTO `tbm_coa` VALUES ('455', null, '701.03.000', 'Kamar Operasi', '0');
INSERT INTO `tbm_coa` VALUES ('456', null, '701.03.100', 'Kamar Operasi', '0');
INSERT INTO `tbm_coa` VALUES ('457', null, '701.03.200', 'Sewa Alat Operasi', '0');
INSERT INTO `tbm_coa` VALUES ('458', null, '701.03.201', 'Laparascopy', '0');
INSERT INTO `tbm_coa` VALUES ('459', null, '701.03.202', 'Eswl', '0');
INSERT INTO `tbm_coa` VALUES ('460', null, '701.04.000', 'ICU', '0');
INSERT INTO `tbm_coa` VALUES ('461', null, '701.04.100', 'Instalasi ICU', '0');
INSERT INTO `tbm_coa` VALUES ('462', null, '701.04.200', 'Instalasi HCU', '0');
INSERT INTO `tbm_coa` VALUES ('463', null, '701.04.300', 'Recovery Room', '0');
INSERT INTO `tbm_coa` VALUES ('464', null, '701.05.000', 'Instalasi Gawat Darurat', '0');
INSERT INTO `tbm_coa` VALUES ('465', null, '701.05.100', 'IGD', '0');
INSERT INTO `tbm_coa` VALUES ('466', null, '701.05.200', 'Ruang Observasi', '0');
INSERT INTO `tbm_coa` VALUES ('467', null, '701.05.300', 'Kamar Operasi IGD', '0');
INSERT INTO `tbm_coa` VALUES ('468', null, '701.05.400', 'Ambulance Service / K. Jenazah', '0');
INSERT INTO `tbm_coa` VALUES ('469', null, '701.06.000', 'Haemodialisa', '0');
INSERT INTO `tbm_coa` VALUES ('470', null, '701.06.100', 'Haemodialisa', '0');
INSERT INTO `tbm_coa` VALUES ('471', null, '701.07.000', 'Unit Stroke Center', '0');
INSERT INTO `tbm_coa` VALUES ('472', null, '701.07.100', 'Pendapatan Stroke Center', '0');
INSERT INTO `tbm_coa` VALUES ('473', null, '702.00.000', 'Penunjang Medik', '0');
INSERT INTO `tbm_coa` VALUES ('474', null, '702.01.000', 'Instalasi Farmasi', '0');
INSERT INTO `tbm_coa` VALUES ('475', null, '702.01.101', 'Farmasi', '0');
INSERT INTO `tbm_coa` VALUES ('476', null, '702.01.102', 'Farmasi IGD', '0');
INSERT INTO `tbm_coa` VALUES ('477', null, '702.01.103', 'Farmasi Rawat Jalan', '0');
INSERT INTO `tbm_coa` VALUES ('478', null, '702.01.104', 'Farmasi Rawat Inap', '0');
INSERT INTO `tbm_coa` VALUES ('479', null, '702.01.199', 'Farmasi Klinik Luar', '0');
INSERT INTO `tbm_coa` VALUES ('480', null, '702.02.000', 'Instalasi Radiologi', '0');
INSERT INTO `tbm_coa` VALUES ('481', null, '702.02.100', 'Radiologi', '0');
INSERT INTO `tbm_coa` VALUES ('482', null, '702.02.200', 'CT Scan', '0');
INSERT INTO `tbm_coa` VALUES ('483', null, '702.02.300', 'MRI', '0');
INSERT INTO `tbm_coa` VALUES ('484', null, '702.02.400', 'Radiotheraphy', '0');
INSERT INTO `tbm_coa` VALUES ('485', null, '702.03.000', 'Instalasi Laboratorium', '0');
INSERT INTO `tbm_coa` VALUES ('486', null, '702.03.100', 'Laboratorium', '0');
INSERT INTO `tbm_coa` VALUES ('487', null, '702.03.200', 'Patalogi Anatomi', '0');
INSERT INTO `tbm_coa` VALUES ('488', null, '702.04.000', 'Klinik Fisioterapi', '0');
INSERT INTO `tbm_coa` VALUES ('489', null, '702.04.100', 'Klinik Fisioterapi', '0');
INSERT INTO `tbm_coa` VALUES ('490', null, '702.05.000', 'Instalasi Gizi', '0');
INSERT INTO `tbm_coa` VALUES ('491', null, '702.05.100', 'Klinik Gizi', '0');
INSERT INTO `tbm_coa` VALUES ('492', null, '702.05.200', 'Dapur/Permakanan/Restorasi', '0');
INSERT INTO `tbm_coa` VALUES ('493', null, '702.50.000', 'Pusat Diagnostik', '0');
INSERT INTO `tbm_coa` VALUES ('494', null, '702.50.101', 'Usg', '0');
INSERT INTO `tbm_coa` VALUES ('495', null, '702.50.102', 'Emg', '0');
INSERT INTO `tbm_coa` VALUES ('496', null, '702.50.103', 'Endoscopy', '0');
INSERT INTO `tbm_coa` VALUES ('497', null, '702.50.104', 'Treadmil', '0');
INSERT INTO `tbm_coa` VALUES ('498', null, '702.50.105', 'ECG', '0');
INSERT INTO `tbm_coa` VALUES ('499', null, '702.50.106', 'EEG', '0');
INSERT INTO `tbm_coa` VALUES ('500', null, '702.50.107', 'Spirometri', '0');
INSERT INTO `tbm_coa` VALUES ('501', null, '702.50.108', 'Audiometri', '0');
INSERT INTO `tbm_coa` VALUES ('502', null, '702.50.109', 'Nebulizer', '0');
INSERT INTO `tbm_coa` VALUES ('503', null, '703.00.000', 'Pendapatan Kapitasi', '0');
INSERT INTO `tbm_coa` VALUES ('504', null, '703.01.000', 'Pendapatan Kapitasi', '0');
INSERT INTO `tbm_coa` VALUES ('505', null, '705.00.000', 'Pend. Jaminan Pemeliharaan Kesehatan Peserta', '0');
INSERT INTO `tbm_coa` VALUES ('506', null, '705.01.000', 'Pendapatan JPK Peserta JPKM', '0');
INSERT INTO `tbm_coa` VALUES ('507', null, '709.00.000', 'Rupa-Rupa Usaha', '0');
INSERT INTO `tbm_coa` VALUES ('508', null, '709.01.000', 'Administrasi Pasien', '0');
INSERT INTO `tbm_coa` VALUES ('509', null, '709.02.000', 'Karcis Pendaftaran', '0');
INSERT INTO `tbm_coa` VALUES ('510', null, '709.03.000', 'Selisih Klaim Askes / Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('511', null, '709.04.000', 'Asrama', '0');
INSERT INTO `tbm_coa` VALUES ('512', null, '709.05.000', 'KSO', '0');
INSERT INTO `tbm_coa` VALUES ('513', null, '709.06.000', 'Pendapatan Karcis Parkir', '0');
INSERT INTO `tbm_coa` VALUES ('514', null, '709.07.000', 'Pendapatan Kamar Jenazah', '0');
INSERT INTO `tbm_coa` VALUES ('515', null, '709.08.000', 'Pendapatan Discount Variabel', '0');
INSERT INTO `tbm_coa` VALUES ('516', null, '709.09.000', 'Pendapatan Kantin', '0');
INSERT INTO `tbm_coa` VALUES ('517', null, '709.10.000', 'Pendapatan Kepaniteraan', '0');
INSERT INTO `tbm_coa` VALUES ('518', null, '709.11.000', 'Sewa Lahan', '0');
INSERT INTO `tbm_coa` VALUES ('519', null, '709.12.000', 'Sewa Bangunan', '0');
INSERT INTO `tbm_coa` VALUES ('520', null, '709.99.000', 'Pendapatan Rupa - Rupa Usaha Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('521', null, '720.00.000', 'Reduksi Pendapatan', '0');
INSERT INTO `tbm_coa` VALUES ('522', null, '721.00.000', 'Pendapatan Pelayanan Medik Dan Keperawatan', '0');
INSERT INTO `tbm_coa` VALUES ('523', null, '721.01.000', 'Instalasi Rawat Jalan', '0');
INSERT INTO `tbm_coa` VALUES ('524', null, '721.01.100', 'Klinik Umum', '0');
INSERT INTO `tbm_coa` VALUES ('525', null, '721.01.101', 'Klinik Umum', '0');
INSERT INTO `tbm_coa` VALUES ('526', null, '721.01.102', 'Klinik Gigi & Mulut', '0');
INSERT INTO `tbm_coa` VALUES ('527', null, '721.01.103', 'KIA', '0');
INSERT INTO `tbm_coa` VALUES ('528', null, '721.01.104', 'MCU', '0');
INSERT INTO `tbm_coa` VALUES ('529', null, '721.01.200', 'Klinik Spesialis', '0');
INSERT INTO `tbm_coa` VALUES ('530', null, '721.01.201', 'Klinik Psycologi', '0');
INSERT INTO `tbm_coa` VALUES ('531', null, '721.01.202', 'Klinik Spesialis Dalam', '0');
INSERT INTO `tbm_coa` VALUES ('532', null, '721.01.203', 'Klinik Spesialis Jantung', '0');
INSERT INTO `tbm_coa` VALUES ('533', null, '721.01.204', 'Klinik Spesialis Anak', '0');
INSERT INTO `tbm_coa` VALUES ('534', null, '721.01.205', 'Klinik Spesialis Bedah Umum', '0');
INSERT INTO `tbm_coa` VALUES ('535', null, '721.01.206', 'Klinik Spesialis Bedah Tulang', '0');
INSERT INTO `tbm_coa` VALUES ('536', null, '721.01.207', 'Klinik Spesialis Bedah Urolog', '0');
INSERT INTO `tbm_coa` VALUES ('537', null, '721.01.208', 'Klinik Spesialis Bedah Syaraf', '0');
INSERT INTO `tbm_coa` VALUES ('538', null, '721.01.209', 'Klinik Spesialis Bedah Plastik', '0');
INSERT INTO `tbm_coa` VALUES ('539', null, '721.01.210', 'Klinik Spesialis Kebidanan/ Kandungan', '0');
INSERT INTO `tbm_coa` VALUES ('540', null, '721.01.211', 'Klinik Spesialis Tht', '0');
INSERT INTO `tbm_coa` VALUES ('541', null, '721.01.212', 'Klinik Spesialis Mata', '0');
INSERT INTO `tbm_coa` VALUES ('542', null, '721.01.213', 'Klinik Spesialis Paru-Paru', '0');
INSERT INTO `tbm_coa` VALUES ('543', null, '721.01.214', 'Klinik Spesialis Kulit/ Kelamin', '0');
INSERT INTO `tbm_coa` VALUES ('544', null, '721.01.215', 'Klinik Spesialis Syaraf', '0');
INSERT INTO `tbm_coa` VALUES ('545', null, '721.01.216', 'Klinik Spesialis Jiwa', '0');
INSERT INTO `tbm_coa` VALUES ('546', null, '721.01.217', 'Klinik Spesialis Bedah Mulut', '0');
INSERT INTO `tbm_coa` VALUES ('547', null, '721.01.218', 'Klinik Orthodentie', '0');
INSERT INTO `tbm_coa` VALUES ('548', null, '721.01.219', 'Klinik Diabetes', '0');
INSERT INTO `tbm_coa` VALUES ('549', null, '721.01.220', 'Klinik Eksekutif', '0');
INSERT INTO `tbm_coa` VALUES ('550', null, '721.01.221', 'Klinik Kecantikan', '0');
INSERT INTO `tbm_coa` VALUES ('551', null, '721.01.500', 'Klinik Luar RSP Jakarta', '0');
INSERT INTO `tbm_coa` VALUES ('552', null, '721.01.501', 'Klinik Umum JICT', '0');
INSERT INTO `tbm_coa` VALUES ('553', null, '721.01.502', 'Klinik Gigi JICT', '0');
INSERT INTO `tbm_coa` VALUES ('554', null, '721.01.503', 'Klinik Tkbm Kramat Jaya', '0');
INSERT INTO `tbm_coa` VALUES ('555', null, '721.01.504', 'Klinik Tkbm Cilincing', '0');
INSERT INTO `tbm_coa` VALUES ('556', null, '721.01.505', 'Klinik Bekasi', '0');
INSERT INTO `tbm_coa` VALUES ('557', null, '721.01.600', 'Klinik Luar RSP Cirebon', '0');
INSERT INTO `tbm_coa` VALUES ('558', null, '721.01.700', 'Klinik Luar RSP Palembang', '0');
INSERT INTO `tbm_coa` VALUES ('559', null, '721.01.800', 'Klinik Luar RS PMC', '0');
INSERT INTO `tbm_coa` VALUES ('560', null, '721.02.000', 'Instalasi Rawat Inap', '0');
INSERT INTO `tbm_coa` VALUES ('561', null, '721.02.100', 'Kelas VVIP', '0');
INSERT INTO `tbm_coa` VALUES ('562', null, '721.02.101', 'Kelas VVIP', '0');
INSERT INTO `tbm_coa` VALUES ('563', null, '721.02.102', 'Kelas VIP Utama', '0');
INSERT INTO `tbm_coa` VALUES ('564', null, '721.02.103', 'Kelas Super VIP', '0');
INSERT INTO `tbm_coa` VALUES ('565', null, '721.02.200', 'Kelas VIP', '0');
INSERT INTO `tbm_coa` VALUES ('566', null, '721.02.201', 'Kelas VIP', '0');
INSERT INTO `tbm_coa` VALUES ('567', null, '721.02.202', 'Kelas VIP A', '0');
INSERT INTO `tbm_coa` VALUES ('568', null, '721.02.203', 'Kelas VIP B', '0');
INSERT INTO `tbm_coa` VALUES ('569', null, '721.02.204', 'Kelas VIP C', '0');
INSERT INTO `tbm_coa` VALUES ('570', null, '721.02.300', 'Kelas I', '0');
INSERT INTO `tbm_coa` VALUES ('571', null, '721.02.301', 'Kelas I', '0');
INSERT INTO `tbm_coa` VALUES ('572', null, '721.02.302', 'Kelas IA', '0');
INSERT INTO `tbm_coa` VALUES ('573', null, '721.02.303', 'Kelas IB', '0');
INSERT INTO `tbm_coa` VALUES ('574', null, '721.02.400', 'Kelas II', '0');
INSERT INTO `tbm_coa` VALUES ('575', null, '721.02.401', 'Kelas II', '0');
INSERT INTO `tbm_coa` VALUES ('576', null, '721.02.402', 'Kelas IIA', '0');
INSERT INTO `tbm_coa` VALUES ('577', null, '721.02.403', 'Kelas IIB', '0');
INSERT INTO `tbm_coa` VALUES ('578', null, '721.02.500', 'Kelas III', '0');
INSERT INTO `tbm_coa` VALUES ('579', null, '721.02.501', 'Kelas III', '0');
INSERT INTO `tbm_coa` VALUES ('580', null, '721.02.502', 'Kelas IIIA', '0');
INSERT INTO `tbm_coa` VALUES ('581', null, '721.02.503', 'Kelas IIIB', '0');
INSERT INTO `tbm_coa` VALUES ('582', null, '721.02.600', 'Kamar Bersalin', '0');
INSERT INTO `tbm_coa` VALUES ('583', null, '721.02.601', 'Kamar Bersalin', '0');
INSERT INTO `tbm_coa` VALUES ('584', null, '721.02.700', 'Ruang Perinatologi', '0');
INSERT INTO `tbm_coa` VALUES ('585', null, '721.02.701', 'Ruang Perinatologi', '0');
INSERT INTO `tbm_coa` VALUES ('586', null, '721.02.800', 'Ruang Isolasi', '0');
INSERT INTO `tbm_coa` VALUES ('587', null, '721.02.801', 'Ruang Isolasi', '0');
INSERT INTO `tbm_coa` VALUES ('588', null, '721.02.900', 'Ruang Anak', '0');
INSERT INTO `tbm_coa` VALUES ('589', null, '721.02.901', 'Ruang Anak', '0');
INSERT INTO `tbm_coa` VALUES ('590', null, '721.03.000', 'Kamar Operasi', '0');
INSERT INTO `tbm_coa` VALUES ('591', null, '721.03.100', 'Kamar Operasi', '0');
INSERT INTO `tbm_coa` VALUES ('592', null, '721.03.200', 'Sewa Alat Operasi', '0');
INSERT INTO `tbm_coa` VALUES ('593', null, '721.03.201', 'Laparascopy', '0');
INSERT INTO `tbm_coa` VALUES ('594', null, '721.03.202', 'Eswl', '0');
INSERT INTO `tbm_coa` VALUES ('595', null, '721.04.000', 'ICU', '0');
INSERT INTO `tbm_coa` VALUES ('596', null, '721.04.100', 'Instalasi ICU', '0');
INSERT INTO `tbm_coa` VALUES ('597', null, '721.04.200', 'Instalasi HCU', '0');
INSERT INTO `tbm_coa` VALUES ('598', null, '721.04.300', 'Recovery Room', '0');
INSERT INTO `tbm_coa` VALUES ('599', null, '721.05.000', 'Instalasi Gawat Darurat', '0');
INSERT INTO `tbm_coa` VALUES ('600', null, '721.05.100', 'Klinik IGD / P3K', '0');
INSERT INTO `tbm_coa` VALUES ('601', null, '721.05.200', 'Ruang Observasi', '0');
INSERT INTO `tbm_coa` VALUES ('602', null, '721.05.300', 'Kamar Operasi IGD', '0');
INSERT INTO `tbm_coa` VALUES ('603', null, '721.05.400', 'Ambulance Service / K. Jenazah', '0');
INSERT INTO `tbm_coa` VALUES ('604', null, '721.06.000', 'Haemodialisa', '0');
INSERT INTO `tbm_coa` VALUES ('605', null, '721.06.100', 'Haemodialisa', '0');
INSERT INTO `tbm_coa` VALUES ('606', null, '722.00.000', 'Penunjang Medik', '0');
INSERT INTO `tbm_coa` VALUES ('607', null, '722.01.000', 'Instalasi Farmasi', '0');
INSERT INTO `tbm_coa` VALUES ('608', null, '722.01.101', 'Farmasi', '0');
INSERT INTO `tbm_coa` VALUES ('609', null, '722.01.102', 'Farmasi IGD', '0');
INSERT INTO `tbm_coa` VALUES ('610', null, '722.01.103', 'Farmasi Rawat Jalan', '0');
INSERT INTO `tbm_coa` VALUES ('611', null, '722.01.104', 'Farmasi Rawat Inap', '0');
INSERT INTO `tbm_coa` VALUES ('612', null, '722.01.199', 'Farmasi Klinik Luar', '0');
INSERT INTO `tbm_coa` VALUES ('613', null, '722.02.000', 'Instalasi Radiologi', '0');
INSERT INTO `tbm_coa` VALUES ('614', null, '722.02.100', 'Radiologi', '0');
INSERT INTO `tbm_coa` VALUES ('615', null, '722.02.200', 'CT Scan', '0');
INSERT INTO `tbm_coa` VALUES ('616', null, '722.02.300', 'MRI', '0');
INSERT INTO `tbm_coa` VALUES ('617', null, '722.02.400', 'Radiotheraphy', '0');
INSERT INTO `tbm_coa` VALUES ('618', null, '722.03.000', 'Instalasi Laboratorium', '0');
INSERT INTO `tbm_coa` VALUES ('619', null, '722.03.100', 'Laboratorium', '0');
INSERT INTO `tbm_coa` VALUES ('620', null, '722.03.200', 'Patalogi Anatomi', '0');
INSERT INTO `tbm_coa` VALUES ('621', null, '722.04.000', 'Klinik Fisioterapi', '0');
INSERT INTO `tbm_coa` VALUES ('622', null, '722.04.100', 'Klinik Fisioterapi', '0');
INSERT INTO `tbm_coa` VALUES ('623', null, '722.05.000', 'Instalasi Gizi', '0');
INSERT INTO `tbm_coa` VALUES ('624', null, '722.05.100', 'Klinik Gizi', '0');
INSERT INTO `tbm_coa` VALUES ('625', null, '722.05.200', 'Dapur/Permakanan/Restorasi', '0');
INSERT INTO `tbm_coa` VALUES ('626', null, '722.90.000', 'Pusat Diagnostik', '0');
INSERT INTO `tbm_coa` VALUES ('627', null, '722.90.101', 'Usg', '0');
INSERT INTO `tbm_coa` VALUES ('628', null, '722.90.102', 'Emg', '0');
INSERT INTO `tbm_coa` VALUES ('629', null, '722.90.103', 'Endoscopy', '0');
INSERT INTO `tbm_coa` VALUES ('630', null, '722.90.104', 'Treadmil', '0');
INSERT INTO `tbm_coa` VALUES ('631', null, '722.90.105', 'ECG', '0');
INSERT INTO `tbm_coa` VALUES ('632', null, '722.90.106', 'EEG', '0');
INSERT INTO `tbm_coa` VALUES ('633', null, '722.90.107', 'Spirometri', '0');
INSERT INTO `tbm_coa` VALUES ('634', null, '722.90.108', 'Audiometri', '0');
INSERT INTO `tbm_coa` VALUES ('635', null, '723.00.000', 'Pendapatan Kapitasi', '0');
INSERT INTO `tbm_coa` VALUES ('636', null, '723.01.000', 'Pendapatan Kapitasi', '0');
INSERT INTO `tbm_coa` VALUES ('637', null, '725.00.000', 'Pendapatan Jaminan Pemeliharaan Kesehatan (JPK)', '0');
INSERT INTO `tbm_coa` VALUES ('638', null, '725.01.000', 'Pendapatan Premi', '0');
INSERT INTO `tbm_coa` VALUES ('639', null, '729.00.000', 'Rupa-Rupa Usaha', '0');
INSERT INTO `tbm_coa` VALUES ('640', null, '729.01.000', 'Administrasi Pasien', '0');
INSERT INTO `tbm_coa` VALUES ('641', null, '729.02.000', 'Karcis Pendaftaran', '0');
INSERT INTO `tbm_coa` VALUES ('642', null, '729.03.000', 'Selisih Klaim Askes / Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('643', null, '729.04.000', 'Asrama', '0');
INSERT INTO `tbm_coa` VALUES ('644', null, '729.05.000', 'KSO', '0');
INSERT INTO `tbm_coa` VALUES ('645', null, '729.06.000', 'Pendapatan Karcis Parkir', '0');
INSERT INTO `tbm_coa` VALUES ('646', null, '729.07.000', 'Pendapatan Kamar Jenazah', '0');
INSERT INTO `tbm_coa` VALUES ('647', null, '729.08.000', 'Pendapatan Discount Variabel', '0');
INSERT INTO `tbm_coa` VALUES ('648', null, '729.09.000', 'Pendapatan Kantin', '0');
INSERT INTO `tbm_coa` VALUES ('649', null, '729.10.000', 'Pendapatan Kepaniteraan', '0');
INSERT INTO `tbm_coa` VALUES ('650', null, '729.11.000', 'Sewa Lahan', '0');
INSERT INTO `tbm_coa` VALUES ('651', null, '729.12.000', 'Sewa Bangunan', '0');
INSERT INTO `tbm_coa` VALUES ('652', null, '729.99.000', 'Pendapatan Rupa - Rupa Usaha Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('653', null, '791.00.000', 'Pendapatan Diluar Usaha', '0');
INSERT INTO `tbm_coa` VALUES ('654', null, '791.01.000', 'Pendapatan Jasa Giro', '0');
INSERT INTO `tbm_coa` VALUES ('655', null, '791.02.000', 'Pendapatan Selisih Persediaan', '0');
INSERT INTO `tbm_coa` VALUES ('656', null, '791.03.000', 'Pendapatan Selisih Penjualan Aset', '0');
INSERT INTO `tbm_coa` VALUES ('657', null, '791.90.000', 'Pendapatan Diluar Usaha Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('658', null, '800.00.000', 'Beban', '0');
INSERT INTO `tbm_coa` VALUES ('659', null, '801.00.000', 'Pelayanan Medik & Keperawatan', '0');
INSERT INTO `tbm_coa` VALUES ('660', null, '801.01.000', 'Instalasi Rawat Jalan', '0');
INSERT INTO `tbm_coa` VALUES ('661', null, '801.01.100', 'Klinik Umum', '0');
INSERT INTO `tbm_coa` VALUES ('662', null, '801.01.101', 'Klinik Umum', '0');
INSERT INTO `tbm_coa` VALUES ('663', null, '801.01.102', 'Klinik Gigi & Mulut', '0');
INSERT INTO `tbm_coa` VALUES ('664', null, '801.01.103', 'KIA', '0');
INSERT INTO `tbm_coa` VALUES ('665', null, '801.01.104', 'MCU', '0');
INSERT INTO `tbm_coa` VALUES ('666', null, '801.01.200', 'Klinik Spesialis', '0');
INSERT INTO `tbm_coa` VALUES ('667', null, '801.01.201', 'Klinik Psycologi', '0');
INSERT INTO `tbm_coa` VALUES ('668', null, '801.01.202', 'Klinik Spesialis Dalam', '0');
INSERT INTO `tbm_coa` VALUES ('669', null, '801.01.203', 'Klinik Spesialis Jantung', '0');
INSERT INTO `tbm_coa` VALUES ('670', null, '801.01.204', 'Klinik Spesialis Anak', '0');
INSERT INTO `tbm_coa` VALUES ('671', null, '801.01.205', 'Klinik Spesialis Bedah Umum', '0');
INSERT INTO `tbm_coa` VALUES ('672', null, '801.01.206', 'Klinik Spesialis Bedah Tulang', '0');
INSERT INTO `tbm_coa` VALUES ('673', null, '801.01.207', 'Klinik Spesialis Bedah Urolog', '0');
INSERT INTO `tbm_coa` VALUES ('674', null, '801.01.208', 'Klinik Spesialis Bedah Syaraf', '0');
INSERT INTO `tbm_coa` VALUES ('675', null, '801.01.209', 'Klinik Spesialis Bedah Plastik', '0');
INSERT INTO `tbm_coa` VALUES ('676', null, '801.01.210', 'Klinik Spesialis Kebidanan/ Kandungan', '0');
INSERT INTO `tbm_coa` VALUES ('677', null, '801.01.211', 'Klinik Spesialis Tht', '0');
INSERT INTO `tbm_coa` VALUES ('678', null, '801.01.212', 'Klinik Spesialis Mata', '0');
INSERT INTO `tbm_coa` VALUES ('679', null, '801.01.213', 'Klinik Spesialis Paru-Paru', '0');
INSERT INTO `tbm_coa` VALUES ('680', null, '801.01.214', 'Klinik Spesialis Kulit/ Kelamin', '0');
INSERT INTO `tbm_coa` VALUES ('681', null, '801.01.215', 'Klinik Spesialis Syaraf', '0');
INSERT INTO `tbm_coa` VALUES ('682', null, '801.01.216', 'Klinik Spesialis Jiwa', '0');
INSERT INTO `tbm_coa` VALUES ('683', null, '801.01.217', 'Klinik Spesialis Bedah Mulut', '0');
INSERT INTO `tbm_coa` VALUES ('684', null, '801.01.218', 'Klinik Orthodentie', '0');
INSERT INTO `tbm_coa` VALUES ('685', null, '801.01.219', 'Klinik Diabetes', '0');
INSERT INTO `tbm_coa` VALUES ('686', null, '801.01.220', 'Klinik Eksekutif', '0');
INSERT INTO `tbm_coa` VALUES ('687', null, '801.01.221', 'Klinik Kecantikan', '0');
INSERT INTO `tbm_coa` VALUES ('688', null, '801.01.500', 'Klinik Luar RSP Jakarta', '0');
INSERT INTO `tbm_coa` VALUES ('689', null, '801.01.501', 'Klinik Umum JICT', '0');
INSERT INTO `tbm_coa` VALUES ('690', null, '801.01.502', 'Klinik Gigi JICT', '0');
INSERT INTO `tbm_coa` VALUES ('691', null, '801.01.503', 'Klinik Tkbm Kramat Jaya', '0');
INSERT INTO `tbm_coa` VALUES ('692', null, '801.01.504', 'Klinik Tkbm Cilincing', '0');
INSERT INTO `tbm_coa` VALUES ('693', null, '801.01.505', 'Kinik Bekasi', '0');
INSERT INTO `tbm_coa` VALUES ('694', null, '801.01.600', 'Klinik Luar RSP Cirebon', '0');
INSERT INTO `tbm_coa` VALUES ('695', null, '801.01.700', 'Klinik Luar RSP Palembang', '0');
INSERT INTO `tbm_coa` VALUES ('696', null, '801.01.800', 'Klinik Luar RS PMC', '0');
INSERT INTO `tbm_coa` VALUES ('697', null, '801.02.000', 'Instalasi Rawat Inap', '0');
INSERT INTO `tbm_coa` VALUES ('698', null, '801.02.100', 'Kelas VVIP', '0');
INSERT INTO `tbm_coa` VALUES ('699', null, '801.02.101', 'Kelas VVIP', '0');
INSERT INTO `tbm_coa` VALUES ('700', null, '801.02.102', 'Kelas VIP Utama', '0');
INSERT INTO `tbm_coa` VALUES ('701', null, '801.02.103', 'Kelas Super VIP', '0');
INSERT INTO `tbm_coa` VALUES ('702', null, '801.02.200', 'Kelas VIP', '0');
INSERT INTO `tbm_coa` VALUES ('703', null, '801.02.201', 'Kelas VIP', '0');
INSERT INTO `tbm_coa` VALUES ('704', null, '801.02.202', 'Kelas VIP A', '0');
INSERT INTO `tbm_coa` VALUES ('705', null, '801.02.203', 'Kelas VIP B', '0');
INSERT INTO `tbm_coa` VALUES ('706', null, '801.02.204', 'Kelas VIP C', '0');
INSERT INTO `tbm_coa` VALUES ('707', null, '801.02.300', 'Kelas I', '0');
INSERT INTO `tbm_coa` VALUES ('708', null, '801.02.301', 'Kelas I', '0');
INSERT INTO `tbm_coa` VALUES ('709', null, '801.02.302', 'Kelas IA', '0');
INSERT INTO `tbm_coa` VALUES ('710', null, '801.02.303', 'Kelas IB', '0');
INSERT INTO `tbm_coa` VALUES ('711', null, '801.02.400', 'Kelas II', '0');
INSERT INTO `tbm_coa` VALUES ('712', null, '801.02.401', 'Kelas II', '0');
INSERT INTO `tbm_coa` VALUES ('713', null, '801.02.402', 'Kelas IIA', '0');
INSERT INTO `tbm_coa` VALUES ('714', null, '801.02.403', 'Kelas IIB', '0');
INSERT INTO `tbm_coa` VALUES ('715', null, '801.02.500', 'Kelas III', '0');
INSERT INTO `tbm_coa` VALUES ('716', null, '801.02.501', 'Kelas III', '0');
INSERT INTO `tbm_coa` VALUES ('717', null, '801.02.502', 'Kelas IIIA', '0');
INSERT INTO `tbm_coa` VALUES ('718', null, '801.02.503', 'Kelas IIIB', '0');
INSERT INTO `tbm_coa` VALUES ('719', null, '801.02.600', 'Kamar Bersalin', '0');
INSERT INTO `tbm_coa` VALUES ('720', null, '801.02.601', 'Kamar Bersalin', '0');
INSERT INTO `tbm_coa` VALUES ('721', null, '801.02.700', 'Ruang Perinatologi', '0');
INSERT INTO `tbm_coa` VALUES ('722', null, '801.02.701', 'Ruang Perinatologi', '0');
INSERT INTO `tbm_coa` VALUES ('723', null, '801.02.800', 'Ruang Isolasi', '0');
INSERT INTO `tbm_coa` VALUES ('724', null, '801.02.801', 'Ruang Isolasi', '0');
INSERT INTO `tbm_coa` VALUES ('725', null, '801.02.900', 'Ruang Anak', '0');
INSERT INTO `tbm_coa` VALUES ('726', null, '801.02.901', 'Ruang Anak', '0');
INSERT INTO `tbm_coa` VALUES ('727', null, '801.03.000', 'Kamar Operasi', '0');
INSERT INTO `tbm_coa` VALUES ('728', null, '801.03.100', 'Kamar Operasi', '0');
INSERT INTO `tbm_coa` VALUES ('729', null, '801.04.000', 'ICU', '0');
INSERT INTO `tbm_coa` VALUES ('730', null, '801.04.100', 'Instalasi ICU', '0');
INSERT INTO `tbm_coa` VALUES ('731', null, '801.05.000', 'IGD', '0');
INSERT INTO `tbm_coa` VALUES ('732', null, '801.05.100', 'IGD', '0');
INSERT INTO `tbm_coa` VALUES ('733', null, '801.05.200', 'Ruang Observasi', '0');
INSERT INTO `tbm_coa` VALUES ('734', null, '801.05.300', 'Kamar OpeRSi IGD', '0');
INSERT INTO `tbm_coa` VALUES ('735', null, '801.05.400', 'Ambulance Service/ Mobil Jenazah', '0');
INSERT INTO `tbm_coa` VALUES ('736', null, '801.06.000', 'Haemodialisa', '0');
INSERT INTO `tbm_coa` VALUES ('737', null, '801.06.100', 'Haemodialisa', '0');
INSERT INTO `tbm_coa` VALUES ('738', null, '801.07.000', 'Unit Stroke', '0');
INSERT INTO `tbm_coa` VALUES ('739', null, '801.07.100', 'Unit Stroke Center', '0');
INSERT INTO `tbm_coa` VALUES ('740', null, '801.90.000', 'Bersama Pelayanan Medik & Keperawatan', '0');
INSERT INTO `tbm_coa` VALUES ('741', null, '801.90.100', 'Bersama Instalasi Rawat Jalan', '0');
INSERT INTO `tbm_coa` VALUES ('742', null, '801.90.101', 'Bersama Instalasi Rawat Inap Dan HCU', '0');
INSERT INTO `tbm_coa` VALUES ('743', null, '801.90.102', 'Bersama Ok Dan IGD', '0');
INSERT INTO `tbm_coa` VALUES ('744', null, '801.90.103', 'Bersama Ok Dan HCU', '0');
INSERT INTO `tbm_coa` VALUES ('745', null, '801.90.104', 'Bersama Bidang Adm.Pelayanan Medik', '0');
INSERT INTO `tbm_coa` VALUES ('746', null, '801.90.105', 'Bersama Bidang Keperawatan', '0');
INSERT INTO `tbm_coa` VALUES ('747', null, '801.90.106', 'Bersama Seksi Askep & Mutu', '0');
INSERT INTO `tbm_coa` VALUES ('748', null, '801.90.107', 'Bersama Seksi Ketenagaan & Perlengkapan', '0');
INSERT INTO `tbm_coa` VALUES ('749', null, '801.90.108', 'Bersama Central Opname', '0');
INSERT INTO `tbm_coa` VALUES ('750', null, '801.90.900', 'Bersama Wakil Kepala Medik & Keperawatan', '0');
INSERT INTO `tbm_coa` VALUES ('751', null, '802.00.000', 'Penunjang Medik', '0');
INSERT INTO `tbm_coa` VALUES ('752', null, '802.01.000', 'Instalasi Farmasi', '0');
INSERT INTO `tbm_coa` VALUES ('753', null, '802.01.101', 'Farmasi', '0');
INSERT INTO `tbm_coa` VALUES ('754', null, '802.01.102', 'Farmasi IGD', '0');
INSERT INTO `tbm_coa` VALUES ('755', null, '802.01.103', 'Farmasi Rawat Jalan', '0');
INSERT INTO `tbm_coa` VALUES ('756', null, '802.01.104', 'Farmasi Rawat Inap', '0');
INSERT INTO `tbm_coa` VALUES ('757', null, '802.01.199', 'Farmasi Klinik Luar', '0');
INSERT INTO `tbm_coa` VALUES ('758', null, '802.01.201', 'Administrasi Dan Perbekalan Farmasi', '0');
INSERT INTO `tbm_coa` VALUES ('759', null, '802.01.900', 'Bersama Instalasi Farmasi', '0');
INSERT INTO `tbm_coa` VALUES ('760', null, '802.02.000', 'Instalasi Radiologi', '0');
INSERT INTO `tbm_coa` VALUES ('761', null, '802.02.100', 'Radiologi', '0');
INSERT INTO `tbm_coa` VALUES ('762', null, '802.02.200', 'CT Scan', '0');
INSERT INTO `tbm_coa` VALUES ('763', null, '802.02.300', 'MRI', '0');
INSERT INTO `tbm_coa` VALUES ('764', null, '802.02.400', 'Radiotheraphy', '0');
INSERT INTO `tbm_coa` VALUES ('765', null, '802.03.000', 'Instalasi Laboratorium', '0');
INSERT INTO `tbm_coa` VALUES ('766', null, '802.03.100', 'Laboratorium', '0');
INSERT INTO `tbm_coa` VALUES ('767', null, '802.03.200', 'Patalogi Anatomi', '0');
INSERT INTO `tbm_coa` VALUES ('768', null, '802.04.000', 'Fisioteraphy', '0');
INSERT INTO `tbm_coa` VALUES ('769', null, '802.04.100', 'Klinik Fisioterapi', '0');
INSERT INTO `tbm_coa` VALUES ('770', null, '802.05.000', 'Instalasi Gizi', '0');
INSERT INTO `tbm_coa` VALUES ('771', null, '802.05.100', 'Klinik Gizi', '0');
INSERT INTO `tbm_coa` VALUES ('772', null, '802.05.200', 'Dapur/Permakanan/Restorasi', '0');
INSERT INTO `tbm_coa` VALUES ('773', null, '802.05.900', 'Bersama Instalasi Gizi', '0');
INSERT INTO `tbm_coa` VALUES ('774', null, '802.50.000', 'Pusat Diagnostik', '0');
INSERT INTO `tbm_coa` VALUES ('775', null, '802.50.101', 'Usg', '0');
INSERT INTO `tbm_coa` VALUES ('776', null, '802.50.102', 'Emg', '0');
INSERT INTO `tbm_coa` VALUES ('777', null, '802.50.103', 'Endoscopy', '0');
INSERT INTO `tbm_coa` VALUES ('778', null, '802.50.104', 'Treadmil', '0');
INSERT INTO `tbm_coa` VALUES ('779', null, '802.50.105', 'EKG/ ECG', '0');
INSERT INTO `tbm_coa` VALUES ('780', null, '802.50.106', 'EEG', '0');
INSERT INTO `tbm_coa` VALUES ('781', null, '802.50.107', 'Spirometri', '0');
INSERT INTO `tbm_coa` VALUES ('782', null, '802.50.108', 'Audiometri', '0');
INSERT INTO `tbm_coa` VALUES ('783', null, '802.50.109', 'Nebulizer', '0');
INSERT INTO `tbm_coa` VALUES ('784', null, '802.50.900', 'Bersama Pusat Diagnostik', '0');
INSERT INTO `tbm_coa` VALUES ('785', null, '802.60.000', 'Bagian Rekam Medik', '0');
INSERT INTO `tbm_coa` VALUES ('786', null, '802.60.100', 'Adm Medis', '0');
INSERT INTO `tbm_coa` VALUES ('787', null, '802.60.200', 'Data & Laporan', '0');
INSERT INTO `tbm_coa` VALUES ('788', null, '802.60.300', 'Central Opname', '0');
INSERT INTO `tbm_coa` VALUES ('789', null, '802.60.900', 'Bersama Bagian Rekam Medik', '0');
INSERT INTO `tbm_coa` VALUES ('790', null, '802.90.000', 'Bersama Penunjang Medik', '0');
INSERT INTO `tbm_coa` VALUES ('791', null, '802.90.500', 'Bersama Kabid Penunjang Medik', '0');
INSERT INTO `tbm_coa` VALUES ('792', null, '802.90.600', 'Bersama Kabid Adm.Penunjang Medik', '0');
INSERT INTO `tbm_coa` VALUES ('793', null, '802.90.900', 'Bersama Wakil Kepala Penunjang Medik', '0');
INSERT INTO `tbm_coa` VALUES ('794', null, '803.00.000', 'Operasional Medik', '0');
INSERT INTO `tbm_coa` VALUES ('795', null, '803.01.000', 'Operasional Medik', '0');
INSERT INTO `tbm_coa` VALUES ('796', null, '803.01.900', 'Bersama Wakil Kepala Medik', '0');
INSERT INTO `tbm_coa` VALUES ('797', null, '805.00.000', 'Kapitasi', '0');
INSERT INTO `tbm_coa` VALUES ('798', null, '805.01.000', 'Kapitasi', '0');
INSERT INTO `tbm_coa` VALUES ('799', null, '809.00.000', 'Rupa-Rupa Usaha', '0');
INSERT INTO `tbm_coa` VALUES ('800', null, '809.01.000', 'Ambulance Service/ Mobil Jenazah', '0');
INSERT INTO `tbm_coa` VALUES ('801', null, '809.02.000', 'Biaya Kepaniteraan', '0');
INSERT INTO `tbm_coa` VALUES ('802', null, '809.99.000', 'Biaya Rupa-Rupa Usaha Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('803', null, '810.00.000', 'Komite Medik', '0');
INSERT INTO `tbm_coa` VALUES ('804', null, '810.01.000', 'Komite Medik', '0');
INSERT INTO `tbm_coa` VALUES ('805', null, '811.00.000', 'Komite Mutu', '0');
INSERT INTO `tbm_coa` VALUES ('806', null, '811.01.000', 'Komite Mutu', '0');
INSERT INTO `tbm_coa` VALUES ('807', null, '812.00.000', 'Personalia & Umum', '0');
INSERT INTO `tbm_coa` VALUES ('808', null, '812.01.000', 'Bagian Personalia & Tata Usaha', '0');
INSERT INTO `tbm_coa` VALUES ('809', null, '812.01.100', 'Personalia', '0');
INSERT INTO `tbm_coa` VALUES ('810', null, '812.01.200', 'Tata Usaha', '0');
INSERT INTO `tbm_coa` VALUES ('811', null, '812.01.300', 'Diklat', '0');
INSERT INTO `tbm_coa` VALUES ('812', null, '812.01.400', 'Sekretaris Kepala', '0');
INSERT INTO `tbm_coa` VALUES ('813', null, '812.01.900', 'Bersama Bagian Personalia & Tata Usaha', '0');
INSERT INTO `tbm_coa` VALUES ('814', null, '812.02.000', 'Bagian Rumah Tangga', '0');
INSERT INTO `tbm_coa` VALUES ('815', null, '812.02.100', 'Administrasi Rumah Tangga & Inventaris', '0');
INSERT INTO `tbm_coa` VALUES ('816', null, '812.02.200', 'Pengadaan & Ambulance', '0');
INSERT INTO `tbm_coa` VALUES ('817', null, '812.02.300', 'Laundry', '0');
INSERT INTO `tbm_coa` VALUES ('818', null, '812.02.900', 'Bersama Bagian Rumah Tangga', '0');
INSERT INTO `tbm_coa` VALUES ('819', null, '812.03.000', 'Bagian Instalasi Pemeliharaan Sarana', '0');
INSERT INTO `tbm_coa` VALUES ('820', null, '812.03.100', 'Teknik Sipil', '0');
INSERT INTO `tbm_coa` VALUES ('821', null, '812.03.200', 'Teknik Mesin Dan Listrik', '0');
INSERT INTO `tbm_coa` VALUES ('822', null, '812.03.300', 'Elektro Medik & Sterilisasi Sentral', '0');
INSERT INTO `tbm_coa` VALUES ('823', null, '812.03.900', 'Bersama Unit Pemeliharaan Sarana', '0');
INSERT INTO `tbm_coa` VALUES ('824', null, '812.04.000', 'Bagian Keamanan & Kebersihan', '0');
INSERT INTO `tbm_coa` VALUES ('825', null, '812.04.100', 'Keamanan', '0');
INSERT INTO `tbm_coa` VALUES ('826', null, '812.04.200', 'Kebersihan', '0');
INSERT INTO `tbm_coa` VALUES ('827', null, '812.04.900', 'Bersama Keamanan Dan Kebersihan', '0');
INSERT INTO `tbm_coa` VALUES ('828', null, '812.09.000', 'Bersama Personalia & Umum', '0');
INSERT INTO `tbm_coa` VALUES ('829', null, '812.09.900', 'Bersama Wakil Kepala Personalia Dan Umum', '0');
INSERT INTO `tbm_coa` VALUES ('830', null, '813.00.000', 'Keuangan', '0');
INSERT INTO `tbm_coa` VALUES ('831', null, '813.01.000', 'Bagian Tu Keuangan & Perbendaharaan', '0');
INSERT INTO `tbm_coa` VALUES ('832', null, '813.01.100', 'Tuk & Perbendaharaan', '0');
INSERT INTO `tbm_coa` VALUES ('833', null, '813.01.200', 'Piutang', '0');
INSERT INTO `tbm_coa` VALUES ('834', null, '813.01.300', 'Guper', '0');
INSERT INTO `tbm_coa` VALUES ('835', null, '813.01.400', 'Gaji/ Upah', '0');
INSERT INTO `tbm_coa` VALUES ('836', null, '813.01.500', 'Kasir', '0');
INSERT INTO `tbm_coa` VALUES ('837', null, '813.01.900', 'Bersama Bagian Tuk & Perbendaharaan', '0');
INSERT INTO `tbm_coa` VALUES ('838', null, '813.02.000', 'Bagian Akuntansi & Anggaran', '0');
INSERT INTO `tbm_coa` VALUES ('839', null, '813.02.100', 'Akuntansi', '0');
INSERT INTO `tbm_coa` VALUES ('840', null, '813.02.200', 'Anggaran', '0');
INSERT INTO `tbm_coa` VALUES ('841', null, '813.02.900', 'Bersama Bagian Akuntansi & Anggaran', '0');
INSERT INTO `tbm_coa` VALUES ('842', null, '813.09.000', 'Bersama Keuangan', '0');
INSERT INTO `tbm_coa` VALUES ('843', null, '813.09.900', 'Bersama Wakil Kepala Keuangan', '0');
INSERT INTO `tbm_coa` VALUES ('844', null, '814.00.000', 'Administrasi', '0');
INSERT INTO `tbm_coa` VALUES ('845', null, '814.01.000', 'Administrasi', '0');
INSERT INTO `tbm_coa` VALUES ('846', null, '814.01.900', 'Bersama Wakil Kepala Administrasi', '0');
INSERT INTO `tbm_coa` VALUES ('847', null, '820.00.000', 'Kepala Rumah Sakit', '0');
INSERT INTO `tbm_coa` VALUES ('848', null, '820.01.000', 'Bagian Teknologi Sistem Informasi', '0');
INSERT INTO `tbm_coa` VALUES ('849', null, '820.01.100', 'Perangkat Keras', '0');
INSERT INTO `tbm_coa` VALUES ('850', null, '820.01.200', 'Perangkat Lunak', '0');
INSERT INTO `tbm_coa` VALUES ('851', null, '820.01.900', 'Bersama Bagian Teknologi Sistem Informasi', '0');
INSERT INTO `tbm_coa` VALUES ('852', null, '820.02.000', 'Bagian Pelayanan Pelanggan & Pemasaran', '0');
INSERT INTO `tbm_coa` VALUES ('853', null, '820.02.100', 'Pelayanan Pelanggan Dan Pemasaran', '0');
INSERT INTO `tbm_coa` VALUES ('854', null, '820.02.900', 'Bersama Bagian Pelayanan Pelanggan & Pemasaran', '0');
INSERT INTO `tbm_coa` VALUES ('855', null, '820.03.000', 'Kepala Rumah Sakit', '0');
INSERT INTO `tbm_coa` VALUES ('856', null, '820.03.100', 'Kepala Rumah Sakit', '0');
INSERT INTO `tbm_coa` VALUES ('857', null, '829.00.000', 'Pelayanan Kesehatan', '0');
INSERT INTO `tbm_coa` VALUES ('858', null, '829.01.000', 'Beban Pelayanan Kesehatan Bapel', '0');
INSERT INTO `tbm_coa` VALUES ('859', null, '829.02.000', 'Beban Pelayanan Kesehatan Tkbm', '0');
INSERT INTO `tbm_coa` VALUES ('860', null, '829.03.000', 'Beban Pelayanan Kesehatan RSP', '0');
INSERT INTO `tbm_coa` VALUES ('861', null, '860.00.000', 'Bapel JPKM', '0');
INSERT INTO `tbm_coa` VALUES ('862', null, '861.00.000', 'Asisten Manager Administrasi', '0');
INSERT INTO `tbm_coa` VALUES ('863', null, '861.01.000', 'Supervisor Keuangan', '0');
INSERT INTO `tbm_coa` VALUES ('864', null, '861.02.000', 'Supervisor Personalia & Umum', '0');
INSERT INTO `tbm_coa` VALUES ('865', null, '861.99.000', 'Bersama Asisten Manager Administrasi', '0');
INSERT INTO `tbm_coa` VALUES ('866', null, '862.00.000', 'Asisten Manager Pemeliharaan Kesehatan', '0');
INSERT INTO `tbm_coa` VALUES ('867', null, '862.01.000', 'Supervisor Quality Asurance & Utilisasi Review', '0');
INSERT INTO `tbm_coa` VALUES ('868', null, '862.02.000', 'Supervisor Provider Servive & Pemasaran', '0');
INSERT INTO `tbm_coa` VALUES ('869', null, '862.99.000', 'Bersama Asisten Manager Pemeliharaan Kesehatan', '0');
INSERT INTO `tbm_coa` VALUES ('870', null, '863.00.000', 'Bersama Manager Bapel JPKM', '0');
INSERT INTO `tbm_coa` VALUES ('871', null, '863.99.000', 'Bersama Manager Bapel JPKM', '0');
INSERT INTO `tbm_coa` VALUES ('872', null, '870.00.000', 'Kantor Pusat PT.RSP', '0');
INSERT INTO `tbm_coa` VALUES ('873', null, '871.00.000', 'Direktur Utama', '0');
INSERT INTO `tbm_coa` VALUES ('874', null, '871.01.100', 'Beban Direktur Utama', '0');
INSERT INTO `tbm_coa` VALUES ('875', null, '872.00.000', 'Direktur Administrasi', '0');
INSERT INTO `tbm_coa` VALUES ('876', null, '872.01.000', 'Asdir. Bidang Keuangan', '0');
INSERT INTO `tbm_coa` VALUES ('877', null, '872.01.100', 'Kabid. Tuk & Perbendaharaan', '0');
INSERT INTO `tbm_coa` VALUES ('878', null, '872.01.200', 'Kabid. Akuntansi & Anggaran', '0');
INSERT INTO `tbm_coa` VALUES ('879', null, '872.01.900', 'Bersama Asdir. Bidang Keuangan', '0');
INSERT INTO `tbm_coa` VALUES ('880', null, '872.02.000', 'Asdir.Bidang Personalia & Umum', '0');
INSERT INTO `tbm_coa` VALUES ('881', null, '872.02.100', 'Kabid. Personalia, Hukum & Umum', '0');
INSERT INTO `tbm_coa` VALUES ('882', null, '872.02.200', 'Kabid. Datin', '0');
INSERT INTO `tbm_coa` VALUES ('883', null, '872.02.900', 'Bersama Asdir. Bidang Personalia & Umum', '0');
INSERT INTO `tbm_coa` VALUES ('884', null, '872.90.000', 'Bersama Direktur Administrasi', '0');
INSERT INTO `tbm_coa` VALUES ('885', null, '872.90.100', 'Bersama Direktur Administrasi', '0');
INSERT INTO `tbm_coa` VALUES ('886', null, '873.00.000', 'Direktur Medik', '0');
INSERT INTO `tbm_coa` VALUES ('887', null, '873.01.000', 'Asdir.Bidang Perencanaan & Pemasaran', '0');
INSERT INTO `tbm_coa` VALUES ('888', null, '873.01.100', 'Kabid. Perencanaan', '0');
INSERT INTO `tbm_coa` VALUES ('889', null, '873.01.200', 'Kabid. Pemasaran', '0');
INSERT INTO `tbm_coa` VALUES ('890', null, '873.01.900', 'Bersama Asdir.Bidang Perencanaan & Pemasaran', '0');
INSERT INTO `tbm_coa` VALUES ('891', null, '873.90.000', 'Bersama Direktur Medik', '0');
INSERT INTO `tbm_coa` VALUES ('892', null, '873.90.100', 'Bersama Direktur Medik', '0');
INSERT INTO `tbm_coa` VALUES ('893', null, '874.00.000', 'Bersama Direksi', '0');
INSERT INTO `tbm_coa` VALUES ('894', null, '874.90.100', 'Bersama Direksi', '0');
INSERT INTO `tbm_coa` VALUES ('895', null, '875.00.000', 'Bersama Dewan Komisaris', '0');
INSERT INTO `tbm_coa` VALUES ('896', null, '875.90.100', 'Bersama Dewan Komisaris', '0');
INSERT INTO `tbm_coa` VALUES ('897', null, '890.00.000', 'Beban Diluar Usaha', '0');
INSERT INTO `tbm_coa` VALUES ('898', null, '890.01.000', 'Beban Selisih Persediaan', '0');
INSERT INTO `tbm_coa` VALUES ('899', null, '890.02.000', 'Beban Selisih Rugi Penjualan Aset', '0');
INSERT INTO `tbm_coa` VALUES ('900', null, '890.90.000', 'Beban Diluar Usaha Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('901', null, '900.00.000', 'Rekening Koran', '0');
INSERT INTO `tbm_coa` VALUES ('902', null, '910.00.000', 'R/K Lancar', '0');
INSERT INTO `tbm_coa` VALUES ('903', null, '910.01.000', 'R/K Lancar RSP Jakarta', '0');
INSERT INTO `tbm_coa` VALUES ('904', null, '910.01.100', 'Setoran Kas RSP Jakarta', '0');
INSERT INTO `tbm_coa` VALUES ('905', null, '910.01.200', 'Pemindahbukuan RSP Jakarta', '0');
INSERT INTO `tbm_coa` VALUES ('906', null, '910.02.000', 'R/K Lancar RSP Cirebon', '0');
INSERT INTO `tbm_coa` VALUES ('907', null, '910.02.100', 'Setoran Kas RSP Cirebon', '0');
INSERT INTO `tbm_coa` VALUES ('908', null, '910.02.200', 'Pemindahbukuan RSP Cirebon', '0');
INSERT INTO `tbm_coa` VALUES ('909', null, '910.03.000', 'R/K Lancar RSP Palembang', '0');
INSERT INTO `tbm_coa` VALUES ('910', null, '910.03.100', 'Setoran Kas RSP Palembang', '0');
INSERT INTO `tbm_coa` VALUES ('911', null, '910.03.200', 'Pemindahbukuan RSP Palembang', '0');
INSERT INTO `tbm_coa` VALUES ('912', null, '910.04.000', 'R/K Lancar RS Port Medical Center', '0');
INSERT INTO `tbm_coa` VALUES ('913', null, '910.04.100', 'Setoran Kas PMC', '0');
INSERT INTO `tbm_coa` VALUES ('914', null, '910.04.200', 'Pemindahbukuan PMC', '0');
INSERT INTO `tbm_coa` VALUES ('915', null, '910.05.000', 'R/K Lancar Bapel JPKM', '0');
INSERT INTO `tbm_coa` VALUES ('916', null, '910.05.100', 'Setoran Kas Bapel JPKM', '0');
INSERT INTO `tbm_coa` VALUES ('917', null, '910.05.200', 'Pemindahbukuan Bapel JPKM', '0');
INSERT INTO `tbm_coa` VALUES ('918', null, '910.06.000', 'R/K Lancar Kantor Pusat PT.RSP', '0');
INSERT INTO `tbm_coa` VALUES ('919', null, '910.06.100', 'Setoran Kas Kantor Pusat PT.RSP', '0');
INSERT INTO `tbm_coa` VALUES ('920', null, '910.06.200', 'Pemindahbukuan Kantor Pusat PT.RSP', '0');
INSERT INTO `tbm_coa` VALUES ('921', null, '920.00.000', 'R/K Permanen', '0');
INSERT INTO `tbm_coa` VALUES ('922', null, '920.01.000', 'R/K Permanen RSP Jakarta', '0');
INSERT INTO `tbm_coa` VALUES ('923', null, '920.01.100', 'Setoran Kas (Investasi RSP Jakarta)', '0');
INSERT INTO `tbm_coa` VALUES ('924', null, '920.01.200', 'Pemindahbukuan Laba/ Rugi RSP Jakarta', '0');
INSERT INTO `tbm_coa` VALUES ('925', null, '920.02.000', 'R/K Permanen RSP Cirebon', '0');
INSERT INTO `tbm_coa` VALUES ('926', null, '920.02.100', 'Setoran Kas (Investasi Cirebon)', '0');
INSERT INTO `tbm_coa` VALUES ('927', null, '920.02.200', 'Pemindahbukuan Laba/ Rugi Cirebon', '0');
INSERT INTO `tbm_coa` VALUES ('928', null, '920.03.000', 'R/K Permanen RSP Palembang', '0');
INSERT INTO `tbm_coa` VALUES ('929', null, '920.03.100', 'Setoran Kas (Investasi Palembang)', '0');
INSERT INTO `tbm_coa` VALUES ('930', null, '920.03.200', 'Pemindahbukuan Laba/ Rugi Palembang', '0');
INSERT INTO `tbm_coa` VALUES ('931', null, '920.04.000', 'R/K Permanen RS Port Medical Center', '0');
INSERT INTO `tbm_coa` VALUES ('932', null, '920.04.100', 'Setoran Kas (Investasi PMC)', '0');
INSERT INTO `tbm_coa` VALUES ('933', null, '920.04.200', 'Pemindahbukuan Laba/ Rugi PMC', '0');
INSERT INTO `tbm_coa` VALUES ('934', null, '920.05.000', 'R/K Permanen Bapel JPKM', '0');
INSERT INTO `tbm_coa` VALUES ('935', null, '920.05.100', 'Setoran Kas (Investasi Bapel JPKM)', '0');
INSERT INTO `tbm_coa` VALUES ('936', null, '920.05.200', 'Pemindahbukuan Laba/ Rugi Bapel JPKM', '0');
INSERT INTO `tbm_coa` VALUES ('937', null, '920.06.000', 'R/K Permanen Kantor Pusat PT.RSP', '0');
INSERT INTO `tbm_coa` VALUES ('938', null, '920.06.100', 'Setoran Kas (Investasi Kantor Pusat PT.RSP)', '0');
INSERT INTO `tbm_coa` VALUES ('939', null, '920.06.200', 'Pemindahbukuan Laba/ Rugi Kantor Pusat PT.RSP', '0');
INSERT INTO `tbm_coa` VALUES ('940', null, '929.01.100', 'Setoran Kas (Investasi RSP Jakarta)', '0');
INSERT INTO `tbm_coa` VALUES ('941', null, '501.01.000', 'Beban Biaya Obat', '0');
INSERT INTO `tbm_coa` VALUES ('942', null, '101.09.300', 'Tunai Rupiah', '0');

-- ----------------------------
-- Table structure for tbm_coa_kodrek_group
-- ----------------------------
DROP TABLE IF EXISTS `tbm_coa_kodrek_group`;
CREATE TABLE `tbm_coa_kodrek_group` (
  `id` varchar(20) NOT NULL,
  `kode_group` varchar(60) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbm_coa_kodrek_group
-- ----------------------------
INSERT INTO `tbm_coa_kodrek_group` VALUES ('1', '100', 'AKTIVA LANCAR', '0');
INSERT INTO `tbm_coa_kodrek_group` VALUES ('2', '101', 'AKTIVA TETAP', '0');
INSERT INTO `tbm_coa_kodrek_group` VALUES ('3', '102', 'AKTIVA TETAP LAIN_LAIN', '0');
INSERT INTO `tbm_coa_kodrek_group` VALUES ('4', '103', 'KEWAJIBAN LANCAR', '0');
INSERT INTO `tbm_coa_kodrek_group` VALUES ('5', '104', 'KEWAJIBAN TETAP', '0');
INSERT INTO `tbm_coa_kodrek_group` VALUES ('6', '105', 'EKUITAS', '0');
INSERT INTO `tbm_coa_kodrek_group` VALUES ('7', '106', 'PENDAPATAN', '0');
INSERT INTO `tbm_coa_kodrek_group` VALUES ('8', '107', 'BIAYA', '0');
INSERT INTO `tbm_coa_kodrek_group` VALUES ('9', '108', 'REKENING KORAN', '0');

-- ----------------------------
-- Table structure for tbm_department
-- ----------------------------
DROP TABLE IF EXISTS `tbm_department`;
CREATE TABLE `tbm_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_parent` int(11) DEFAULT '0',
  `nama` varchar(200) DEFAULT NULL,
  `kode` varchar(60) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_department
-- ----------------------------
INSERT INTO `tbm_department` VALUES ('1', '0', 'Operational', '2', '1');
INSERT INTO `tbm_department` VALUES ('2', '0', 'Manager', '1', '1');
INSERT INTO `tbm_department` VALUES ('3', '0', 'Assisten', '2', '1');
INSERT INTO `tbm_department` VALUES ('4', '0', 'Transport & Alat Berat', '3', '1');
INSERT INTO `tbm_department` VALUES ('5', '0', 'Finance', '6', '1');
INSERT INTO `tbm_department` VALUES ('6', '5', 'Sub Finance', '6456', '1');
INSERT INTO `tbm_department` VALUES ('7', '5', 'Sub FInance 2', '667', '1');
INSERT INTO `tbm_department` VALUES ('8', '0', 'Keuangan & Akuntansi', '2', '0');
INSERT INTO `tbm_department` VALUES ('9', '8', 'IT Jaringan', '901', '1');
INSERT INTO `tbm_department` VALUES ('10', '8', 'IT Software', '902', '1');
INSERT INTO `tbm_department` VALUES ('11', '2', '001', '1', '1');
INSERT INTO `tbm_department` VALUES ('12', '3', '002', '2', '1');
INSERT INTO `tbm_department` VALUES ('13', '4', '003', '3', '1');
INSERT INTO `tbm_department` VALUES ('14', '8', '004', '4', '1');
INSERT INTO `tbm_department` VALUES ('15', '0', 'Pengadaan  & Logistik, Gudang', '3', '0');
INSERT INTO `tbm_department` VALUES ('16', '15', '003', '3', '0');
INSERT INTO `tbm_department` VALUES ('17', '0', 'Keamanan', '4', '0');
INSERT INTO `tbm_department` VALUES ('18', '17', '004', '4', '0');
INSERT INTO `tbm_department` VALUES ('19', '0', 'Kantor PKS', '5', '0');
INSERT INTO `tbm_department` VALUES ('20', '19', '005', '5', '0');
INSERT INTO `tbm_department` VALUES ('21', '0', '', '', '1');
INSERT INTO `tbm_department` VALUES ('22', '21', '007', '7', '1');
INSERT INTO `tbm_department` VALUES ('23', '0', 'Timbangan', '6', '0');
INSERT INTO `tbm_department` VALUES ('24', '23', '006', '6', '0');
INSERT INTO `tbm_department` VALUES ('25', '0', 'Proses Shift I', '7', '0');
INSERT INTO `tbm_department` VALUES ('26', '25', '007', '7', '0');
INSERT INTO `tbm_department` VALUES ('27', '0', 'Proses Shift II', '8', '0');
INSERT INTO `tbm_department` VALUES ('28', '27', '008', '8', '0');
INSERT INTO `tbm_department` VALUES ('29', '0', 'Workshop', '9', '0');
INSERT INTO `tbm_department` VALUES ('30', '29', '009', '9', '0');
INSERT INTO `tbm_department` VALUES ('31', '0', 'Transport & Alat Berat', '1', '0');
INSERT INTO `tbm_department` VALUES ('32', '31', '001', '1', '0');
INSERT INTO `tbm_department` VALUES ('33', '8', '002', '2', '0');
INSERT INTO `tbm_department` VALUES ('34', '0', 'Laboratorium', '10', '0');
INSERT INTO `tbm_department` VALUES ('35', '34', '010', '10', '0');
INSERT INTO `tbm_department` VALUES ('36', '0', '', '', '1');
INSERT INTO `tbm_department` VALUES ('37', '36', '010', '10', '1');
INSERT INTO `tbm_department` VALUES ('38', '0', '', '', '1');
INSERT INTO `tbm_department` VALUES ('39', '38', '010', '10', '1');
INSERT INTO `tbm_department` VALUES ('40', '0', 'Sortase', '11', '0');
INSERT INTO `tbm_department` VALUES ('41', '40', '011', '11', '0');
INSERT INTO `tbm_department` VALUES ('42', '0', '', '', '1');
INSERT INTO `tbm_department` VALUES ('43', '42', '011', '11', '1');
INSERT INTO `tbm_department` VALUES ('44', '0', 'BHL Kandir', '12', '0');
INSERT INTO `tbm_department` VALUES ('45', '44', '012', '12', '0');
INSERT INTO `tbm_department` VALUES ('46', '0', 'BHL PKS', '13', '0');
INSERT INTO `tbm_department` VALUES ('47', '46', '013', '13', '0');

-- ----------------------------
-- Table structure for tbm_distribusi
-- ----------------------------
DROP TABLE IF EXISTS `tbm_distribusi`;
CREATE TABLE `tbm_distribusi` (
  `iddistribusi` int(11) NOT NULL AUTO_INCREMENT,
  `idsubpayroll` int(11) DEFAULT NULL,
  `distribusi` varchar(200) DEFAULT NULL,
  `keterangan` text,
  PRIMARY KEY (`iddistribusi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_distribusi
-- ----------------------------

-- ----------------------------
-- Table structure for tbm_expense
-- ----------------------------
DROP TABLE IF EXISTS `tbm_expense`;
CREATE TABLE `tbm_expense` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `expense_category_id` int(11) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbm_expense
-- ----------------------------
INSERT INTO `tbm_expense` VALUES ('1', '1', 'PEMBIBITAN', '0');
INSERT INTO `tbm_expense` VALUES ('2', '1', 'PEMUPUKAN', '0');
INSERT INTO `tbm_expense` VALUES ('3', '1', 'PEMBIBITAN', '1');

-- ----------------------------
-- Table structure for tbm_expense_category
-- ----------------------------
DROP TABLE IF EXISTS `tbm_expense_category`;
CREATE TABLE `tbm_expense_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbm_expense_category
-- ----------------------------
INSERT INTO `tbm_expense_category` VALUES ('1', 'BIAYA KEBUN', '0');
INSERT INTO `tbm_expense_category` VALUES ('2', 'BIAYA 2', '0');

-- ----------------------------
-- Table structure for tbm_golongan_karyawan
-- ----------------------------
DROP TABLE IF EXISTS `tbm_golongan_karyawan`;
CREATE TABLE `tbm_golongan_karyawan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(60) DEFAULT NULL,
  `gaji_pokok` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_golongan_karyawan
-- ----------------------------
INSERT INTO `tbm_golongan_karyawan` VALUES ('1', 'F-1', '2500000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('2', 'F-2', '2350000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('3', 'F-3', '2450000.00', '1');
INSERT INTO `tbm_golongan_karyawan` VALUES ('4', 'F-3', '2450000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('5', 'A-1', '2513250.00', '0');

-- ----------------------------
-- Table structure for tbm_jabatan
-- ----------------------------
DROP TABLE IF EXISTS `tbm_jabatan`;
CREATE TABLE `tbm_jabatan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_department` int(11) DEFAULT NULL,
  `id_subdepartment` int(11) DEFAULT NULL,
  `nama` varchar(200) DEFAULT NULL,
  `kode` varchar(60) DEFAULT NULL,
  `kuota` int(11) DEFAULT NULL,
  `id_level_distribusi` int(11) DEFAULT NULL,
  `jatah_cuti` int(11) DEFAULT '0',
  `tunjangan_jabatan` float(11,0) DEFAULT NULL,
  `tunjangan_komunikasi` float(11,0) DEFAULT NULL,
  `premi_karyawan` float(11,0) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_jabatan
-- ----------------------------
INSERT INTO `tbm_jabatan` VALUES ('1', '8', '10', 'Seniort Programmer', '1010101', '3', '1', '12', null, null, '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('2', '31', '32', 'Pb. Operator Wel Loader', '2', '2', '1', '12', null, null, '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('3', '31', '32', 'Operator Wel Loader', '1', '2', '1', '12', null, null, '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('4', '8', '33', 'Staff Accounting & Budget', '1', '3', '1', '12', null, null, '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('5', '8', '33', 'Staff Accounting & Pajak', '2', '3', '1', '12', null, null, '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('6', '8', '33', 'Staff Keuangan & Kasir', '3', '3', '1', '12', null, null, '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('7', '15', '16', 'Pengadaan & Logistik', '1', '3', '1', '12', null, null, '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('8', '15', '16', 'Kr. Gudang', '2', '3', '1', '12', null, null, '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('9', '15', '16', 'Pb. Kr. Gudang', '3', '3', '1', '12', null, null, '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('10', '17', '18', 'Satpam', '1', '12', '1', '12', null, null, '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('11', '19', '20', 'Kr. Produksi', '1', '1', '0', '12', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for tbm_jadwal
-- ----------------------------
DROP TABLE IF EXISTS `tbm_jadwal`;
CREATE TABLE `tbm_jadwal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idcab` int(11) DEFAULT NULL,
  `idkaryawan` int(11) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `shif` varchar(3) DEFAULT NULL,
  `istirahat` time DEFAULT NULL,
  `awal` time DEFAULT NULL,
  `ahir` time DEFAULT NULL,
  `lama` int(2) DEFAULT NULL,
  `tglbuat` date DEFAULT NULL,
  `jambuat` time DEFAULT NULL,
  `operator` varchar(200) DEFAULT NULL,
  `opabsen` varchar(200) DEFAULT NULL,
  `tglupdate` date DEFAULT NULL,
  `jamupdate` time DEFAULT NULL,
  `datang` time DEFAULT NULL,
  `pulang` time DEFAULT NULL,
  `kodetelat` int(5) DEFAULT NULL,
  `kodepulangawal` int(6) DEFAULT NULL,
  `kodelembur` time DEFAULT NULL,
  `alpa` int(2) DEFAULT '0' COMMENT '0=tidak 1=ya',
  `ijin` int(2) DEFAULT '0' COMMENT '0=tidak 1=ya',
  `cuti` int(2) DEFAULT '0' COMMENT '0=tidak 1=ya 2=cuti istimewa',
  `statuslembur` int(2) DEFAULT '0' COMMENT '0=tidak disetujui 1=disetujui',
  `kodecuti` int(5) DEFAULT NULL,
  `aktif` int(2) DEFAULT '2' COMMENT '1=tidak 0=aktif',
  `libur` int(2) DEFAULT '0' COMMENT '0=libur 1=tidak',
  `dinas` int(2) DEFAULT '0' COMMENT '0=tidak 1=ya',
  `st_hadir` int(11) DEFAULT NULL,
  `st` char(1) DEFAULT '0',
  `st_telat` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_jadwal
-- ----------------------------
INSERT INTO `tbm_jadwal` VALUES ('1', '0', '1', '2017-04-03', '2', '12:00:00', '06:00:00', '18:00:00', '12', '2017-04-03', '03:02:59', 'ADMIN', null, null, null, '06:30:00', '17:30:00', null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '0', '2', '0');
INSERT INTO `tbm_jadwal` VALUES ('2', '0', '1', '2017-04-04', '3', '11:00:00', '07:00:00', '15:00:00', '8', '2017-04-03', '03:02:59', 'ADMIN', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', null, '0', '0');
INSERT INTO `tbm_jadwal` VALUES ('3', '0', '2', '2017-04-03', '2', '12:00:00', '06:00:00', '18:00:00', '12', '2017-04-03', '03:02:59', 'ADMIN', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '25', '2', '0');
INSERT INTO `tbm_jadwal` VALUES ('4', '0', '2', '2017-04-04', '5', '12:00:00', '07:00:00', '17:00:00', '10', '2017-04-03', '03:02:59', 'ADMIN', null, null, null, '09:30:00', null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '0', '1', '0');
INSERT INTO `tbm_jadwal` VALUES ('5', '0', '1', '2017-05-03', '1', '10:00:00', '06:00:00', '14:00:00', '8', '2017-05-03', '15:31:54', 'ADMIN', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '24', '2', '0');
INSERT INTO `tbm_jadwal` VALUES ('6', '0', '2', '2017-05-03', '15', '18:00:00', '14:00:00', '22:00:00', '8', '2017-05-03', '15:31:54', 'ADMIN', null, null, null, '14:30:00', '22:30:00', null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '0', '2', '0');

-- ----------------------------
-- Table structure for tbm_jadwal_penalty
-- ----------------------------
DROP TABLE IF EXISTS `tbm_jadwal_penalty`;
CREATE TABLE `tbm_jadwal_penalty` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idjadwal` int(11) DEFAULT NULL,
  `payroll_id` int(11) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_jadwal_penalty
-- ----------------------------
INSERT INTO `tbm_jadwal_penalty` VALUES ('1', '3', '25', '0');
INSERT INTO `tbm_jadwal_penalty` VALUES ('2', '3', '25', '0');
INSERT INTO `tbm_jadwal_penalty` VALUES ('3', '1', '36', '0');
INSERT INTO `tbm_jadwal_penalty` VALUES ('4', '3', '25', '0');
INSERT INTO `tbm_jadwal_penalty` VALUES ('5', '6', '36', '0');
INSERT INTO `tbm_jadwal_penalty` VALUES ('6', '6', '28', '0');
INSERT INTO `tbm_jadwal_penalty` VALUES ('7', '5', '24', '0');

-- ----------------------------
-- Table structure for tbm_jenis_kendaraan
-- ----------------------------
DROP TABLE IF EXISTS `tbm_jenis_kendaraan`;
CREATE TABLE `tbm_jenis_kendaraan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jenis_kendaraan` varchar(30) DEFAULT NULL,
  `jumlah_bongkar` float(11,2) DEFAULT NULL,
  `jenis_bongkar` char(1) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_jenis_kendaraan
-- ----------------------------
INSERT INTO `tbm_jenis_kendaraan` VALUES ('1', 'COLT DIESEL', '12.00', '0', '0');
INSERT INTO `tbm_jenis_kendaraan` VALUES ('2', 'DUM TRUCK', '15000.00', '1', '0');
INSERT INTO `tbm_jenis_kendaraan` VALUES ('3', 'PICKUP', '12.00', '0', '0');
INSERT INTO `tbm_jenis_kendaraan` VALUES ('4', 'FUSO ENGKEL', '12.00', '0', '0');
INSERT INTO `tbm_jenis_kendaraan` VALUES ('5', 'HILINE', '12.00', '0', '0');
INSERT INTO `tbm_jenis_kendaraan` VALUES ('6', 'FUSO TRONTON', '12.00', '0', '0');

-- ----------------------------
-- Table structure for tbm_karyawan
-- ----------------------------
DROP TABLE IF EXISTS `tbm_karyawan`;
CREATE TABLE `tbm_karyawan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cabang` int(11) DEFAULT NULL,
  `id_jabatan` int(11) DEFAULT NULL,
  `id_golongan` int(11) DEFAULT NULL,
  `id_ptkp` char(1) DEFAULT '0',
  `nik` varchar(30) DEFAULT NULL,
  `ktp` varchar(30) DEFAULT NULL,
  `nama` varchar(200) DEFAULT NULL,
  `jkel` char(1) DEFAULT NULL,
  `tmplahir` varchar(200) DEFAULT NULL,
  `tgllahir` date DEFAULT NULL,
  `alamat` varchar(200) DEFAULT NULL,
  `id_kota` int(11) DEFAULT NULL,
  `status_kawin` char(1) DEFAULT NULL,
  `id_agama` int(11) DEFAULT NULL,
  `umur` int(3) DEFAULT NULL,
  `id_pendidikan` int(11) DEFAULT NULL,
  `telp` varchar(15) DEFAULT NULL,
  `tglawalkerja` date DEFAULT NULL,
  `aktif` int(2) DEFAULT '0' COMMENT '0=aktif 1=tidak aktif',
  `status_karyawan` int(11) DEFAULT NULL,
  `id_bank` int(11) DEFAULT NULL,
  `norek` varchar(45) DEFAULT NULL,
  `masakerja` int(11) DEFAULT NULL,
  `harimasakerja` varchar(200) DEFAULT NULL,
  `loyalty` int(11) DEFAULT NULL,
  `posisi_dinas` int(11) DEFAULT NULL,
  `tunjangan_natura` float(11,0) DEFAULT NULL,
  `st_bpjs_kesehatan` char(1) DEFAULT '0',
  `st_bpjs_ketenagakerjaan` char(1) DEFAULT '0',
  `tambahan_keluarga` int(11) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_karyawan
-- ----------------------------
INSERT INTO `tbm_karyawan` VALUES ('1', '1', '1', null, '0', '10810Den2400001', '10507624', 'Deni Andriansah', '0', 'Bandung', '1989-04-02', 'Sastra 36', '43', '0', '1', null, '3', '85722984816', '2010-08-20', '0', '1', '1', '1234534556344', null, null, null, '1', null, '0', '0', null, '1');
INSERT INTO `tbm_karyawan` VALUES ('2', '1', '1', null, '0', '10117Ude7600001', '0978976t786576', 'Udeng Budeng', '1', 'Surabaya', '1991-11-20', 'fghfghdrfgh', '35', '1', '1', null, '4', '4566756', '2017-01-18', '0', '3', '1', '4364564645', null, null, null, '1', null, '0', '0', null, '1');
INSERT INTO `tbm_karyawan` VALUES ('3', '1', '3', '1', '2', '11013Arj8700002', '787', 'Arjun', '0', 'Papaso', '1986-02-05', 'Kom. Perumahan PT. Sinar Halomoan', '50', '1', '1', null, '7', '78787', '2013-10-17', '0', '3', '0', '', null, null, null, '1', '160000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('4', '1', '2', '1', '0', '10915Angre00002', 'ewrewre', 'Anggi Pranata', '0', 'Tamora', '1995-04-09', 'Komp. Perumahan PT. Sinar Halomoan', '50', '0', '1', null, '7', '34434', '2015-09-12', '0', '3', '0', '', null, null, null, '1', '10000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('5', '1', '4', '1', '0', '10414Duhew00002', 'wew', 'Duha Sukrina Harahap', '1', 'medan', '1992-09-09', 'Mompang', '50', '0', '1', null, '3', '45454', '2014-04-09', '0', '3', '0', '', null, null, null, '1', '10000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('6', '1', '5', '1', '0', '10215Nur4500002', '4545', 'Nurmuliana Daulay', '1', 'Siolip', '1986-08-05', 'Latong', '50', '0', '1', null, '3', '454', '2015-02-10', '0', '3', '0', '', null, null, null, '1', '10000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('7', '1', '6', '1', '0', '10215Git4500002', '454545', 'Gita Kharisma Octavia Hrp', '1', 'Sipangko', '1988-10-05', 'Komp. Peruman PT. Sinar Halomoan', '50', '1', '1', null, '4', '232323', '2015-02-02', '0', '3', '0', '', null, null, null, '1', '10000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('8', '1', '7', '1', '0', '11212Ahm3400002', '3434343434', 'Ahmad Gustami Nasution', '0', 'Paringgonan', '1990-08-30', 'Komp. Perumahan PT. Sinar Halomoan', '50', '1', '1', null, '3', '232424', '2012-12-12', '0', '3', '0', '', null, null, null, '1', '10000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('9', '1', '10', '1', '3', '10514Pim7600001', '67676', 'Pimpin Haholongan Hasibuan', '0', 'Pasir Jae', '1982-04-12', 'Komp. Perumahan PT. Sinar Halomoan', '67', '1', '1', null, '7', '676767', '2014-05-02', '0', '3', '0', '', null, null, null, '1', '190000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('10', '1', '10', '1', '4', '10514Hit4400001', '344', 'Hitcat Haluhutan', '0', 'Kota Bangun', '1983-03-27', 'Komp. Perumahan PT. Sinar Halomoan', '67', '1', '1', null, '7', '232323', '2014-05-01', '0', '3', '0', '', null, null, null, '1', '220000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('11', '1', '10', '1', '1', '10514Bon1200001', '1212', 'Bona Hasibuan', '0', 'Hurung Jilok', '1989-07-27', 'Kom. Perumahan PT. Sinar Halomoan', '67', '1', '1', null, '7', '23323', '2014-05-01', '0', '3', '0', '', null, null, null, '1', '130000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('12', '1', '10', '1', '3', '10514Dar1200001', '121212', 'Darmendra Hasibuan', '0', 'HurungJilok', '1988-01-01', 'Komp. Perumahan PT. Sinar Halomoan', '67', '1', '1', null, '7', '2323', '2014-05-01', '0', '3', '0', '', null, null, null, '1', '190000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('13', '1', '10', '1', '0', '10514Rin1200001', '1212', 'Rinto Suriadi', '0', 'Bunga Setangkai', '1988-09-16', 'Sibuhuan', '67', '0', '1', null, '7', '1212', '2014-05-12', '0', '3', '0', '', null, null, null, '1', '100000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('14', '1', '10', '1', '3', '10615Irw2100001', '12121', 'Irwadi', '0', ' 	 BatangKuis', '1974-10-15', 'Komp. Perumahan PT. Sinar Halomoan', '67', '1', '1', null, '7', '2132', '2015-06-08', '0', '3', '0', '', null, null, null, '1', '190000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('15', '1', '10', '1', '2', '10815Muh2100001', '12121', 'Muhammad Basri Nasution', '0', 'Tangga Bosi', '1993-06-25', 'Kom. Perumahan PT. Sinar Halomoan', '67', '1', '1', null, '7', '1212', '2015-08-01', '0', '3', '0', '', null, null, null, '1', '160000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('16', '1', '10', '1', '4', '11015Sah3300001', '233', 'Sahman Lubis', '0', 'Tobing Tinggi', '1983-09-23', 'Kom. Perumahan PT. Sinar Halomoan', '67', '1', '1', null, '7', '2323', '2015-10-01', '0', '3', '0', '', null, null, null, '1', '220000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('17', '1', '10', '1', '0', '11015Dor2300001', '23223', 'Dormariski Ananda Sikumbang', '0', 'Padang Sidimpuan', '1995-09-05', 'Komp. Perumahan PT. Sinar Halomoan', '67', '0', '1', null, '7', '2323', '2015-10-16', '0', '3', '0', '', null, null, null, '1', '100000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('18', '1', '10', '1', '0', '10316Muh2300001', '2323', 'Muhammad Arif Batubara', '0', 'Desa Naga Jaya', '1992-03-22', 'Komp. Perumahan PT. Sinar Halomoan', '67', '0', '1', null, '7', '34434', '2016-03-08', '0', '2', '0', '', null, null, null, '1', '100000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('19', '1', '10', '1', '0', '10916Sai3400001', '343434', 'Saiful Bahri', '0', ' 	 Lhoksukon', '1985-04-19', 'Sibuhuan', '67', '1', '1', null, '7', '3434', '2016-09-14', '0', '1', '0', '', null, null, null, '1', '100000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('20', '2', '11', '2', '0', '20115Pin6700001', '86767', 'Pinta Riski Mala Hasibuan', '1', 'Sibuhuan', '1990-01-28', 'Kom. Perumahan PT. Sinar Halomoan', '67', '1', '1', null, '3', '2131323', '2015-01-12', '0', '3', '0', '', null, null, null, '2', '100000', '1', '1', '0', '0');

-- ----------------------------
-- Table structure for tbm_kategori_barang
-- ----------------------------
DROP TABLE IF EXISTS `tbm_kategori_barang`;
CREATE TABLE `tbm_kategori_barang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipe_kategori` char(1) DEFAULT '0',
  `nama` varchar(255) DEFAULT NULL,
  `id_coa` int(11) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_kategori_barang
-- ----------------------------
INSERT INTO `tbm_kategori_barang` VALUES ('1', '1', 'Buah Kebun', null, '0');
INSERT INTO `tbm_kategori_barang` VALUES ('3', '0', 'SAWIT 2', null, '1');
INSERT INTO `tbm_kategori_barang` VALUES ('4', '0', 'Dapur', null, '1');
INSERT INTO `tbm_kategori_barang` VALUES ('5', '2', 'BARANG PRODUKSI', null, '0');
INSERT INTO `tbm_kategori_barang` VALUES ('6', '0', 'Perlengkapan Mesin', null, '0');
INSERT INTO `tbm_kategori_barang` VALUES ('7', '0', 'Sparepart Kenderaan & Alat Berat', null, '0');
INSERT INTO `tbm_kategori_barang` VALUES ('8', '0', 'Sparepart Pabrik', null, '0');
INSERT INTO `tbm_kategori_barang` VALUES ('9', '0', 'Elektrik', null, '0');
INSERT INTO `tbm_kategori_barang` VALUES ('10', '0', 'BBM Dan Pelumas', null, '0');
INSERT INTO `tbm_kategori_barang` VALUES ('11', '0', 'ATK Dan Cetakan', null, '0');
INSERT INTO `tbm_kategori_barang` VALUES ('12', '0', 'Bangunan', null, '0');
INSERT INTO `tbm_kategori_barang` VALUES ('13', '0', 'Barang Kimia', null, '0');
INSERT INTO `tbm_kategori_barang` VALUES ('14', '0', 'Ban Kenderaan', null, '0');
INSERT INTO `tbm_kategori_barang` VALUES ('15', '0', 'Umum', null, '0');

-- ----------------------------
-- Table structure for tbm_kategori_cetakan
-- ----------------------------
DROP TABLE IF EXISTS `tbm_kategori_cetakan`;
CREATE TABLE `tbm_kategori_cetakan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_kategori_cetakan
-- ----------------------------
INSERT INTO `tbm_kategori_cetakan` VALUES ('1', 'Print Only & Finishing', '0');
INSERT INTO `tbm_kategori_cetakan` VALUES ('2', 'Print All', '0');
INSERT INTO `tbm_kategori_cetakan` VALUES ('3', 'Roland', '0');
INSERT INTO `tbm_kategori_cetakan` VALUES ('4', 'Finishing', '0');
INSERT INTO `tbm_kategori_cetakan` VALUES ('5', 'NCR', '0');

-- ----------------------------
-- Table structure for tbm_kategori_harga
-- ----------------------------
DROP TABLE IF EXISTS `tbm_kategori_harga`;
CREATE TABLE `tbm_kategori_harga` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_kategori_harga
-- ----------------------------
INSERT INTO `tbm_kategori_harga` VALUES ('1', 'HARGA 1', '0');
INSERT INTO `tbm_kategori_harga` VALUES ('2', 'HARGA 2', '0');
INSERT INTO `tbm_kategori_harga` VALUES ('3', 'HARGA 3', '0');

-- ----------------------------
-- Table structure for tbm_kategori_payroll
-- ----------------------------
DROP TABLE IF EXISTS `tbm_kategori_payroll`;
CREATE TABLE `tbm_kategori_payroll` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_kategori_payroll
-- ----------------------------
INSERT INTO `tbm_kategori_payroll` VALUES ('1', 'Core Salary');
INSERT INTO `tbm_kategori_payroll` VALUES ('2', 'Jaminan Kerja');
INSERT INTO `tbm_kategori_payroll` VALUES ('3', 'Santunan');
INSERT INTO `tbm_kategori_payroll` VALUES ('4', 'Attendance');
INSERT INTO `tbm_kategori_payroll` VALUES ('5', 'Kewajiban Karyawan');
INSERT INTO `tbm_kategori_payroll` VALUES ('6', 'Pinjaman');
INSERT INTO `tbm_kategori_payroll` VALUES ('7', 'Sanksi');

-- ----------------------------
-- Table structure for tbm_kategori_pelanggan
-- ----------------------------
DROP TABLE IF EXISTS `tbm_kategori_pelanggan`;
CREATE TABLE `tbm_kategori_pelanggan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_kategori_pelanggan
-- ----------------------------
INSERT INTO `tbm_kategori_pelanggan` VALUES ('1', 'CHANNEL', '1');
INSERT INTO `tbm_kategori_pelanggan` VALUES ('2', 'Pelanggan 1', '1');
INSERT INTO `tbm_kategori_pelanggan` VALUES ('3', 'SPAREPART PABRIK', '0');
INSERT INTO `tbm_kategori_pelanggan` VALUES ('4', 'LABORATORIUM', '0');
INSERT INTO `tbm_kategori_pelanggan` VALUES ('5', 'UMUM', '0');
INSERT INTO `tbm_kategori_pelanggan` VALUES ('6', 'ATK & CETAKAN', '0');
INSERT INTO `tbm_kategori_pelanggan` VALUES ('7', 'BBM & PELUMAS', '0');
INSERT INTO `tbm_kategori_pelanggan` VALUES ('8', 'OLI & PELUMAS', '0');
INSERT INTO `tbm_kategori_pelanggan` VALUES ('9', 'SPAREPART KENDERAAN', '0');
INSERT INTO `tbm_kategori_pelanggan` VALUES ('10', 'BANGUNAN', '0');
INSERT INTO `tbm_kategori_pelanggan` VALUES ('11', 'ELEKTRIK', '0');
INSERT INTO `tbm_kategori_pelanggan` VALUES ('12', 'KIMIA', '1');
INSERT INTO `tbm_kategori_pelanggan` VALUES ('13', 'SPAREPART ALAT BERAT', '0');

-- ----------------------------
-- Table structure for tbm_kategori_pemasok
-- ----------------------------
DROP TABLE IF EXISTS `tbm_kategori_pemasok`;
CREATE TABLE `tbm_kategori_pemasok` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jenis_kategori` char(1) DEFAULT '0',
  `nama` varchar(255) DEFAULT NULL,
  `ppn` float(11,2) DEFAULT NULL,
  `pph` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_kategori_pemasok
-- ----------------------------
INSERT INTO `tbm_kategori_pemasok` VALUES ('1', '0', 'SP 1', '10.00', '25.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('2', '0', 'SP 2', '10.00', '25.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('3', '0', 'SP 3', '10.00', '25.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('4', '0', '4', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('5', '0', '5', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('6', '0', '6', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('7', '0', '7', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('8', '0', '8', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('9', '0', '9', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('10', '0', '10', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('11', '0', '11', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('12', '0', 'SP 4', '1.00', '1.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('13', '0', 'SP 5', '2.00', '2.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('14', '0', 'SP 6', '1.00', '1.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('15', '0', 'SP 7', '2.00', '2.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('16', '0', 'SP 8', '1.00', '1.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('17', '0', 'SP 9', '1.00', '1.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('18', '0', 'SP 10', '1.00', '1.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('19', '0', 'SP 11', '1.00', '1.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('20', '0', 'SP 12', '1.00', '1.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('21', '0', 'SP 13', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('22', '0', 'SP 14', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('23', '0', 'SP 15', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('24', '0', 'SP 16', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('25', '0', 'SP 17', '1.00', '1.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('26', '1', 'SPAREPART PABRIK', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('27', '1', 'LABORATORIUM', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('28', '1', 'UMUM', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('29', '1', 'ATK & CETAKAN', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('30', '1', 'BBM & PELUMAS', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('31', '1', 'OLI & PELUMAS', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('32', '1', 'SPAREPART KENDERAAN', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('33', '1', 'BANGUNAN', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('34', '1', 'ELEKTRIK', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('35', '1', 'SPAREPART ALAT BERAT', '0.00', '0.00', '0');

-- ----------------------------
-- Table structure for tbm_kendaraan_pemasok
-- ----------------------------
DROP TABLE IF EXISTS `tbm_kendaraan_pemasok`;
CREATE TABLE `tbm_kendaraan_pemasok` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pemasok` int(11) DEFAULT NULL,
  `id_jenis_kendaraan` int(11) DEFAULT NULL,
  `no_polisi` varchar(60) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_kendaraan_pemasok
-- ----------------------------
INSERT INTO `tbm_kendaraan_pemasok` VALUES ('1', '1', '1', 'B 2134 DW', '0');
INSERT INTO `tbm_kendaraan_pemasok` VALUES ('2', '1', '2', 'BS 5567 TS', '0');

-- ----------------------------
-- Table structure for tbm_kota
-- ----------------------------
DROP TABLE IF EXISTS `tbm_kota`;
CREATE TABLE `tbm_kota` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) NOT NULL DEFAULT '',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=101 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of tbm_kota
-- ----------------------------
INSERT INTO `tbm_kota` VALUES ('26', 'Aceh', '0');
INSERT INTO `tbm_kota` VALUES ('27', 'Jambi', '0');
INSERT INTO `tbm_kota` VALUES ('28', 'Pangkal Pinang', '0');
INSERT INTO `tbm_kota` VALUES ('29', 'Bekasi', '0');
INSERT INTO `tbm_kota` VALUES ('30', 'Bogor', '0');
INSERT INTO `tbm_kota` VALUES ('31', 'Binjai', '0');
INSERT INTO `tbm_kota` VALUES ('32', 'Tanjung Morawa', '0');
INSERT INTO `tbm_kota` VALUES ('33', 'Suka Bumi', '0');
INSERT INTO `tbm_kota` VALUES ('34', 'Depok', '0');
INSERT INTO `tbm_kota` VALUES ('35', 'Padang', '0');
INSERT INTO `tbm_kota` VALUES ('36', 'Sumedang', '0');
INSERT INTO `tbm_kota` VALUES ('37', 'Garut', '0');
INSERT INTO `tbm_kota` VALUES ('38', 'Purwakarta', '0');
INSERT INTO `tbm_kota` VALUES ('39', 'Tasik Malaya', '0');
INSERT INTO `tbm_kota` VALUES ('40', 'Surabaya', '0');
INSERT INTO `tbm_kota` VALUES ('41', 'Semarang', '0');
INSERT INTO `tbm_kota` VALUES ('42', 'solo', '0');
INSERT INTO `tbm_kota` VALUES ('43', 'Bandung', '0');
INSERT INTO `tbm_kota` VALUES ('44', 'Cilegon', '0');
INSERT INTO `tbm_kota` VALUES ('45', 'Belawan', '0');
INSERT INTO `tbm_kota` VALUES ('46', 'DKI Jakarta', '0');
INSERT INTO `tbm_kota` VALUES ('47', 'Pontianak', '0');
INSERT INTO `tbm_kota` VALUES ('48', 'palembang', '0');
INSERT INTO `tbm_kota` VALUES ('49', 'pekanbaru', '0');
INSERT INTO `tbm_kota` VALUES ('50', 'medan', '0');
INSERT INTO `tbm_kota` VALUES ('51', 'Cirebon', '0');
INSERT INTO `tbm_kota` VALUES ('52', 'Kuta', '0');
INSERT INTO `tbm_kota` VALUES ('53', 'Denpasar', '0');
INSERT INTO `tbm_kota` VALUES ('54', 'Sanur', '0');
INSERT INTO `tbm_kota` VALUES ('55', 'Belitar', '0');
INSERT INTO `tbm_kota` VALUES ('56', 'Kediri', '0');
INSERT INTO `tbm_kota` VALUES ('57', 'Madiun', '0');
INSERT INTO `tbm_kota` VALUES ('58', 'Malang', '0');
INSERT INTO `tbm_kota` VALUES ('59', 'Mojokerto', '0');
INSERT INTO `tbm_kota` VALUES ('60', 'Pasuruan', '0');
INSERT INTO `tbm_kota` VALUES ('61', 'Probolinggo', '0');
INSERT INTO `tbm_kota` VALUES ('62', 'Magelang', '0');
INSERT INTO `tbm_kota` VALUES ('63', 'Pekalongan', '0');
INSERT INTO `tbm_kota` VALUES ('64', 'Sala Tiga', '0');
INSERT INTO `tbm_kota` VALUES ('65', 'Tegal', '0');
INSERT INTO `tbm_kota` VALUES ('67', 'Padang Lawas', '0');

-- ----------------------------
-- Table structure for tbm_lembur
-- ----------------------------
DROP TABLE IF EXISTS `tbm_lembur`;
CREATE TABLE `tbm_lembur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_karyawan` int(11) DEFAULT NULL,
  `id_jadwal` int(11) DEFAULT NULL,
  `lama_lembur` int(11) DEFAULT NULL,
  `tgl_lembur` date DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_lembur
-- ----------------------------
INSERT INTO `tbm_lembur` VALUES ('1', '2', '6', '8', '2017-05-03', '0');

-- ----------------------------
-- Table structure for tbm_level_distribusi
-- ----------------------------
DROP TABLE IF EXISTS `tbm_level_distribusi`;
CREATE TABLE `tbm_level_distribusi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode` varchar(50) DEFAULT NULL,
  `nilai` decimal(11,2) DEFAULT NULL,
  `bpjs_distribusi` decimal(11,2) DEFAULT '0.00',
  `dinas_distribusi` decimal(11,2) DEFAULT '0.00',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_level_distribusi
-- ----------------------------
INSERT INTO `tbm_level_distribusi` VALUES ('1', '01', '70.00', '0.00', '0.00', '0');
INSERT INTO `tbm_level_distribusi` VALUES ('2', '02', '72.00', '0.00', '0.00', '0');
INSERT INTO `tbm_level_distribusi` VALUES ('3', '03', '78.00', '0.00', '0.00', '0');
INSERT INTO `tbm_level_distribusi` VALUES ('4', '04', '85.00', '0.00', '0.00', '0');
INSERT INTO `tbm_level_distribusi` VALUES ('5', '05', '90.00', '0.00', '0.00', '0');
INSERT INTO `tbm_level_distribusi` VALUES ('6', '06', '100.00', '0.00', '0.00', '0');
INSERT INTO `tbm_level_distribusi` VALUES ('7', '07', '115.00', '0.00', '0.00', '0');
INSERT INTO `tbm_level_distribusi` VALUES ('8', '08', '155.00', '0.00', '0.00', '0');
INSERT INTO `tbm_level_distribusi` VALUES ('9', '09', '190.00', '0.00', '0.00', '0');
INSERT INTO `tbm_level_distribusi` VALUES ('10', '10', '300.00', '0.00', '0.00', '0');
INSERT INTO `tbm_level_distribusi` VALUES ('11', '11', '520.00', '1000000.00', '110000.00', '0');
INSERT INTO `tbm_level_distribusi` VALUES ('12', '12', '450.00', '20.00', '20.00', '1');

-- ----------------------------
-- Table structure for tbm_menu
-- ----------------------------
DROP TABLE IF EXISTS `tbm_menu`;
CREATE TABLE `tbm_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0',
  `nama` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `aktif` char(1) DEFAULT '1',
  `urutan` int(11) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_menu
-- ----------------------------
INSERT INTO `tbm_menu` VALUES ('1', '0', 'Master Data', null, 'entypo-cog', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('2', '69', 'Master Product', 'Master.MasterBarang', '', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('3', '69', 'Master Unit', 'Master.MasterSatuan', '', '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('5', '71', 'Master Pemasok Tbs', 'Master.MasterPemasokTbs', '', '1', '6', '0');
INSERT INTO `tbm_menu` VALUES ('6', '71', 'Master Pemasok Barang', 'Master.MasterPemasok', '', '1', '7', '0');
INSERT INTO `tbm_menu` VALUES ('7', '0', 'Transaksi', '', 'entypo-basket', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('8', '7', 'Sales Order', 'Transaksi.Penjualan', null, '0', '1', '1');
INSERT INTO `tbm_menu` VALUES ('9', '7', 'Pembelian Barang', 'Transaksi.PurchaseOrder', '', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('10', '0', 'Laporan', '', 'entypo-doc-text', '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('11', '10', 'Sales Report', 'Laporan.LaporanPenjualan', null, '0', '1', '1');
INSERT INTO `tbm_menu` VALUES ('12', '10', 'Laporan Timbangan', 'Laporan.LaporanTimbangan', null, '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('13', '0', 'Admin', null, 'entypo-user', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('14', '13', 'User Group', 'Admin.UserGroup', null, '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('15', '13', 'User Admin', 'Admin.UserAdmin', null, '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('16', '17', 'Kartu Stok Barang', 'Inventory.KartuStok', '', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('17', '0', 'Inventory', null, 'entypo-folder', '1', '6', '0');
INSERT INTO `tbm_menu` VALUES ('18', '17', 'Pengeluaran Barang', 'Inventory.MutasiBarangRusak', null, '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('19', '7', 'Transaksi Percetakan', 'Transaksi.Percetakan', '', '0', null, '1');
INSERT INTO `tbm_menu` VALUES ('20', '1', 'Master Cetakan', 'Master.MasterCetakan', null, '0', null, '1');
INSERT INTO `tbm_menu` VALUES ('21', '7', 'Transaksi Luar', 'Transaksi.TransaksiLainLain', null, '0', null, '1');
INSERT INTO `tbm_menu` VALUES ('22', '10', 'Laporan Percetakan', 'Laporan.LaporanPercetakan', null, '0', '3', '1');
INSERT INTO `tbm_menu` VALUES ('23', '10', 'Laporan Buku Kas', 'Laporan.LaporanBukuKas', null, '0', '4', '1');
INSERT INTO `tbm_menu` VALUES ('24', '1', 'Master Kategori Cetakan', 'Master.MasterKategoriCetakan', null, '0', null, '1');
INSERT INTO `tbm_menu` VALUES ('25', '13', 'Profil Perusahaan', 'Admin.ProfilPerusahaan', null, '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('26', '10', 'Laporan Transaksi Luar', 'Laporan.LaporanTransaksiLuar', null, '0', '5', '1');
INSERT INTO `tbm_menu` VALUES ('27', '69', 'Master Kategori Barang', 'Master.MasterKategoriBarang', '', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('28', '71', 'Master Kategori Pemasok', 'Master.MasterKategoriPemasok', '', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('29', '71', 'Master Kategori Pelanggan', 'Master.MasterKategoriPelanggan', '', '0', '3', '0');
INSERT INTO `tbm_menu` VALUES ('30', '7', 'Permintaan Barang', 'Transaksi.RequestOrder', '', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('31', '0', 'Finance', null, 'entypo-chart-line', '1', '7', '0');
INSERT INTO `tbm_menu` VALUES ('32', '69', 'Setting Komidel', 'Setting.SettingKomidel', '', '1', '8', '0');
INSERT INTO `tbm_menu` VALUES ('33', '69', 'Setting Kendaraan', 'Setting.JenisKendaraan', '', '1', '9', '0');
INSERT INTO `tbm_menu` VALUES ('34', '31', 'Admin Request Order', 'Transaksi.AdminRequestOrder', null, '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('35', '31', 'Pembayaran TBS', 'Keuangan.BayarTbsOrder', null, '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('36', '7', 'Transaksi TBS', 'Transaksi.TbsOrder', '', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('37', '17', 'Penerimaan Barang', 'Inventory.ReceivingOrder', '', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('38', '31', 'Setting Harga Transaksi', 'Keuangan.SettingHargaTbsOrder', null, '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('39', '7', 'Kontrak Penjualan', 'Transaksi.ContractSales', null, '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('40', '17', 'LHP', 'Inventory.ProcessingTbs', '', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('41', '31', 'Pembayaran PO', 'Keuangan.BayarPo', null, '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('42', '49', 'Master Data HRD', '', 'entypo-users', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('43', '42', 'Master Cabang', 'Master.MasterKantorCabang', null, '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('44', '42', 'Master Department', 'Master.MasterDepartment', null, '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('45', '42', 'Master Karyawan', 'Master.MasterKaryawan', null, '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('46', '42', 'Master Jabatan', 'Master.MasterJabatan', null, '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('47', '42', 'Master Level Distribusi', 'Master.MasterLevelDistribusi', null, '1', '5', '1');
INSERT INTO `tbm_menu` VALUES ('48', '42', 'Rekap Gaji Karyawan', 'Hrd.LaporanRekapGajiKaryawan', null, '1', '6', '0');
INSERT INTO `tbm_menu` VALUES ('49', '0', 'HRD', null, 'entypo-suitcase', '1', '8', '0');
INSERT INTO `tbm_menu` VALUES ('50', '72', 'Pengaturan Shift', 'Hrd.ShiftSetting', '', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('51', '72', 'Jadwal Karyawan', 'Hrd.JadwalShiftKaryawan', '', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('52', '73', 'Incentive Karyawan', 'Hrd.IncentiveTransaction', '', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('53', '73', 'Biaya Karyawan', 'Hrd.ExpenseKaryawan', '', '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('54', '73', 'Absensi Karyawan', 'Hrd.AbsensiKaryawan', '', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('55', '31', 'Penerimaan Penjualan', 'Keuangan.PenerimaanJual', null, '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('56', '70', 'Master Group Coa', 'Master.MasterGroupCoa', '', '1', '10', '0');
INSERT INTO `tbm_menu` VALUES ('57', '70', 'Master Coa', 'Master.MasterCoa', '', '1', '11', '0');
INSERT INTO `tbm_menu` VALUES ('58', '10', 'Laporan Pembelian Barang', 'Laporan.LaporanPurchaseOrder', '', '1', '6', '0');
INSERT INTO `tbm_menu` VALUES ('59', '10', 'Laporan Permintaan Barang', 'Laporan.LaporanRequestOrder', '', '1', '7', '0');
INSERT INTO `tbm_menu` VALUES ('60', '70', 'Master Bank', 'Master.MasterBank', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('61', '70', 'Kategori Pengeluaran', 'Master.MasterExpenseCategory', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('62', '70', 'Master Pengeluaran', 'Master.MasterExpense', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('63', '70', 'Kategori Pendapatan', 'Master.MasterRevenueCategory', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('64', '70', 'Master Pendapatan', 'Master.MasterRevenue', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('65', '7', 'Transaksi Pengeluaran', 'Keuangan.ExpenseTransaction', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('66', '7', 'Transaksi Pendapatan', 'Keuangan.RevenueTransaction', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('67', '31', 'Buku Kas', 'Keuangan.BukuKas', null, '1', '6', '0');
INSERT INTO `tbm_menu` VALUES ('68', '17', 'Production Product', 'Inventory.ProductionProduct', null, '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('69', '17', 'Master Data Barang', '', 'entypo-archive', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('70', '31', 'Master Data Transaksi', '', 'entypo-switch', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('71', '31', 'Master Data Pemasok', '', 'entypo-briefcase', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('72', '49', 'Setting Absensi', '', 'entypo-layout', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('73', '49', 'Kegiatan Karyawan', '', 'entypo-github', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('74', '13', 'Admin Menu', 'Admin.MenuAdmin', null, '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('75', '31', 'Laporan Umur Hutang PO', 'Keuangan.LaporanHutangPO', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('76', '17', 'Laporan Pemakaian', 'Inventory.LaporanPemakaian', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('77', '17', 'Stok Opname', 'Inventory.StockOpname', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('78', '73', 'Lembur Karyawan', 'Hrd.LemburKaryawan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('79', '73', 'Jadwal Per Karyawan', 'Hrd.JadwalPerKaryawan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('80', '73', 'Resign Karyawan', 'Hrd.ResignForm', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('81', '31', 'Laporan Laba Rugi', 'Keuangan.LaporanLabaRugi', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('82', '31', 'Laporan Jurnal Umum', 'Keuangan.LaporanJurnalUmum', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('83', '42', 'Master Golongan Karyawan', 'Master.MasterGolongan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('84', '17', 'Kartu Stok Tbs', 'Inventory.KartuStokTbs', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('85', '17', 'Laporan Barang Rusak', 'Inventory.LaporanBarangRusak', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('86', '49', 'Reporting', '', 'entypo-doc-text', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('87', '86', 'Laporan Absensi Karyawan', 'Hrd.LaporanAbsensiKaryawan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('88', '86', 'Laporan Lembur Karyawan', 'Hrd.LaporanLemburKaryawan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('89', '86', 'Laporan Incentive Karyawan', 'Hrd.LaporanIncentiveKaryawan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('90', '86', 'Laporan Resign Karyawan', 'Hrd.LaporanResignKaryawan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('91', '10', 'Laporan Pembayaran PO', 'Laporan.LaporanPembayaranPurchaseOrder', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('92', '10', 'Laporan Pembayaran TBS', 'Laporan.LaporanPembayaranTbs', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('93', '31', 'Laporan Umur Hutang TBS', 'Keuangan.LaporanHutangTbs', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('94', '7', 'Transaksi Commodity', 'Transaksi.CommodityTransaction', '', '1', null, '0');

-- ----------------------------
-- Table structure for tbm_payrol
-- ----------------------------
DROP TABLE IF EXISTS `tbm_payrol`;
CREATE TABLE `tbm_payrol` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kategori` varchar(100) DEFAULT NULL COMMENT '1=pendapatan 2=potongan',
  `subkategori` varchar(200) DEFAULT NULL,
  `attendance_id` int(11) DEFAULT NULL,
  `time1` int(11) DEFAULT NULL,
  `time2` int(11) DEFAULT NULL,
  `globaldistribusi` varchar(200) DEFAULT NULL,
  `distribusi` varchar(8) DEFAULT NULL,
  `ket` text,
  `urut` int(11) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_payrol
-- ----------------------------
INSERT INTO `tbm_payrol` VALUES ('1', '1', '1', '0', '0', '0', 'Gaji Pokok', '20', '*UMK*Level Distribution* Gaji Pokok', null, '0');
INSERT INTO `tbm_payrol` VALUES ('2', '1', '1', '0', '0', '0', 'Nominal Loyalty', '2', '*UMK*Level Distribution* Nominal Loyalty', null, '0');
INSERT INTO `tbm_payrol` VALUES ('3', '1', '1', null, null, null, 'Service', '0.05', '*Level Distribution*Kehadiran / Hari Kerja*Hotel Revenue', null, '0');
INSERT INTO `tbm_payrol` VALUES ('4', '1', '1', null, null, null, 'Tunjangan Tetap', '36', '*UMK*Level Distribution* Tunjangan Tetap', null, '0');
INSERT INTO `tbm_payrol` VALUES ('5', '1', '1', null, null, null, 'Tunjangan Tidak Tetap', '40', '*UMK*Level Distribution* Tunjangan Tidak Tetap', null, '0');
INSERT INTO `tbm_payrol` VALUES ('6', '1', '2', null, null, null, 'Bonus Tahunan', '100', '*UMK*Level Distribution* Bonus Tahunan', null, '0');
INSERT INTO `tbm_payrol` VALUES ('7', '1', '2', null, null, null, 'Dinas', '0.8', '*UMK*Level Distribution* Dinas', null, '0');
INSERT INTO `tbm_payrol` VALUES ('8', '1', '2', null, null, null, 'Lembur', '0.58', '*UMK*Level Distribution *Jumlah Total Jam Lembur*Lembur', null, '0');
INSERT INTO `tbm_payrol` VALUES ('9', '1', '2', null, null, null, 'Meal', '0.5', '*UMK*Meal*Hari Kerja', null, '0');
INSERT INTO `tbm_payrol` VALUES ('10', '1', '2', null, null, null, 'Pengembalian Jaminan Kontrak', '4', '*UMK*Level Distribution* Pengembalian Jaminan Kontrak', null, '0');
INSERT INTO `tbm_payrol` VALUES ('11', '1', '2', null, null, null, 'Pesangon', '100', '*Gaji Pokok* Pesangon*Loyalty', null, '0');
INSERT INTO `tbm_payrol` VALUES ('12', '1', '2', null, null, null, 'THR', '100', '*UMK*Level Distribution* THR', null, '0');
INSERT INTO `tbm_payrol` VALUES ('13', '1', '3', null, null, null, 'Dinas di Hari Raya', '2', '*UMK*Level Distribution* Dinas di Hari RayaJumlah Hari kerja di Hari Raya', '1', '0');
INSERT INTO `tbm_payrol` VALUES ('14', '1', '3', null, null, null, 'Karyawan Meninggal Dunia', '100', '*UMK*Level Distribution* Karyawan Meninggal Dunia', '2', '0');
INSERT INTO `tbm_payrol` VALUES ('15', '1', '3', null, null, null, 'Karyawan Terbaik', '20', '*UMK*Level Distribution* Karyawan Terbaik', '3', '0');
INSERT INTO `tbm_payrol` VALUES ('16', '1', '3', null, null, null, 'Karyawati / Istri Melahirkan', '15', '*UMK*Level Distribution* Karyawati / Istri Melahirkan', '4', '0');
INSERT INTO `tbm_payrol` VALUES ('17', '1', '3', null, null, null, 'Klaim Medis', '5', '*UMK*Level Distribution* Klaim Medis', '5', '0');
INSERT INTO `tbm_payrol` VALUES ('18', '1', '3', null, null, null, 'Orang Tua Meninggal Dunia', '15', '*UMK*Level Distribution* Orang Tua Meninggal Dunia', '6', '0');
INSERT INTO `tbm_payrol` VALUES ('19', '1', '3', null, null, null, 'Pasangan / Anak Meninggal Dunia', '15', '*UMK*Level Distribution* Pasangan / Anak Meninggal Dunia', '7', '0');
INSERT INTO `tbm_payrol` VALUES ('20', '1', '3', null, null, null, 'Pernikahan', '20', '*UMK*Level Distribution* Pernikahan', '8', '0');
INSERT INTO `tbm_payrol` VALUES ('21', '1', '3', null, null, null, 'Retur Sisa Cuti', '2', '*UMK*Level Distribution* Retur Sisa CutiJumlah Sisa Cuti', '9', '0');
INSERT INTO `tbm_payrol` VALUES ('22', '1', '3', null, null, null, 'Ucapan Terimakasih', '100', '*UMK*Level Distribution*Ucapan Terimakasih 4,8,12 = 1,2,3 Bulan Gaji)', '10', '0');
INSERT INTO `tbm_payrol` VALUES ('23', '1', '3', null, null, null, 'Ulang Tahun Karyawan', '1', '*UMK*Level Distribution* Ulang Tahun Karyawan', '11', '0');
INSERT INTO `tbm_payrol` VALUES ('24', '2', '4', '1', '0', '0', 'Alfa', '2', '*UMK*Level Distribution* Alfa', '1', '0');
INSERT INTO `tbm_payrol` VALUES ('25', '2', '4', '3', '0', '0', 'Izin Sakit', '1', '*UMK*Level Distribution* Izin', '10', '0');
INSERT INTO `tbm_payrol` VALUES ('26', '2', '4', '5', '1', '10', 'Pulang Lebih Awal 1 - 10', '0.20', '*UMK*Level Distribution* Pulang Lebih Awal 1-10', '4', '0');
INSERT INTO `tbm_payrol` VALUES ('27', '2', '4', '5', '11', '20', 'Pulang Lebih Awal 11 - 20', '0.28', '*UMK*Level Distribution* Pulang Lebih Awal 11-20', '5', '0');
INSERT INTO `tbm_payrol` VALUES ('28', '2', '4', '5', '21', '30', 'Pulang Lebih Awal 21 - 30', '0.36', '*UMK*Level Distribution* Pulang Lebih Awal 21-30', '6', '0');
INSERT INTO `tbm_payrol` VALUES ('29', '2', '4', '5', '31', '40', 'Pulang Lebih Awal 31 - 40', '0.44', '*UMK*Level Distribution* Pulang Lebih Awal 31-40', '7', '0');
INSERT INTO `tbm_payrol` VALUES ('30', '2', '4', '5', '41', '50', 'Pulang Lebih Awal 41 - 50', '0.52', '*UMK*Level Distribution* Pulang Lebih Awal 41-50', '8', '0');
INSERT INTO `tbm_payrol` VALUES ('31', '2', '4', '5', '51', '60', 'Pulang Lebih Awal 51 - 60', '0.60', '*UMK*Level Distribution* Pulang Lebih Awal 51-60', '9', '0');
INSERT INTO `tbm_payrol` VALUES ('32', '2', '4', '4', '6', '10', 'Terlambat 6 - 10', '0.20', '*UMK*Level Distribution* Terlambat 06-10', '11', '0');
INSERT INTO `tbm_payrol` VALUES ('33', '2', '4', '4', '11', '15', 'Terlambat 11 - 15', '0.28', '*UMK*Level Distribution* Terlambat 11-15', '12', '0');
INSERT INTO `tbm_payrol` VALUES ('34', '2', '4', '4', '16', '20', 'Terlambat 16 - 20', '0.36', '*UMK*Level Distribution* Terlambat 16-20', '13', '0');
INSERT INTO `tbm_payrol` VALUES ('35', '2', '4', '4', '21', '25', 'Terlambat 21 - 25', '0.44', '*UMK*Level Distribution* Terlambat 21-25', '14', '0');
INSERT INTO `tbm_payrol` VALUES ('36', '2', '4', '4', '26', '30', 'Terlambat 26 - 30', '0.52', '*UMK*Level Distribution* Terlambat 26-30', '15', '0');
INSERT INTO `tbm_payrol` VALUES ('37', '2', '4', '4', '31', '45', 'Terlambat 31 - 45', '0.60', '*UMK*Level Distribution* Terlambat 31-45', '16', '0');
INSERT INTO `tbm_payrol` VALUES ('38', '2', '5', null, null, null, 'ADM non Rekening', '5', '*UMK*Level Distribution* ADM non Rekening', null, '0');
INSERT INTO `tbm_payrol` VALUES ('39', '2', '5', null, null, null, 'BPJS Kesehatan', '1', '*IF Total Salary < UMK Terbaru, Maka, Persentase * UMK Terbaru  OR Total Salary > UMK, Maka', null, '0');
INSERT INTO `tbm_payrol` VALUES ('40', '2', '5', null, null, null, 'BPJS Ketenagakerjaan', '3', '*IF Total Salary < UMK Terbaru, Maka, Persentase * UMK Terbaru OR Total Salary > UMK, Maka', null, '0');
INSERT INTO `tbm_payrol` VALUES ('41', '2', '5', null, null, null, 'BPJS Pensiun', '3', '*IF Total Salary < UMK Terbaru, Maka, Persentase * UMK Terbaru OR Total Salary > UMK, Maka', null, '0');
INSERT INTO `tbm_payrol` VALUES ('42', '2', '5', null, null, null, 'Potongan Jaminan Kontrak', '4', '*UMK*Level Distribution* Potongan Jaminan Kontrak', null, '0');
INSERT INTO `tbm_payrol` VALUES ('43', '2', '5', null, null, null, 'Potongan Meal', '0.5', '*UMK*Level Distribution* Potongan Meal', null, '0');
INSERT INTO `tbm_payrol` VALUES ('44', '2', '7', null, null, null, 'Salah Seragam', '0.1', '*UMK*Level Distribution* Salah Seragam', '4', '0');
INSERT INTO `tbm_payrol` VALUES ('45', '2', '7', '0', '0', '0', 'Tanpa Tanda Pengenal', '0.1', '*UMK*Level Distribution* Tanpa Tanda Pengenal', '5', '0');
INSERT INTO `tbm_payrol` VALUES ('46', '2', '7', null, null, null, 'Denda Sanksi 1', '1', '*UMK*Level Distribution* Denda Sanksi 1', '1', '0');
INSERT INTO `tbm_payrol` VALUES ('47', '2', '7', null, null, null, 'Denda Sanksi 2', '1.2', '*UMK*Level Distribution* Denda Sanksi 2', '2', '0');
INSERT INTO `tbm_payrol` VALUES ('48', '2', '7', null, null, null, 'Denda Sanksi 3', '1.4', '*UMK*Level Distribution* Denda Sanksi 3', '3', '0');
INSERT INTO `tbm_payrol` VALUES ('49', '1', '2', '0', '0', '0', 'THR 2', '50', '', null, '0');
INSERT INTO `tbm_payrol` VALUES ('50', '1', '4', '2', '0', '0', 'Cuti Cuti Cuti Keluarga', '1', '', '2', '0');
INSERT INTO `tbm_payrol` VALUES ('56', '1', '1', '0', '0', '0', 'test 6', '7', '', null, '0');
INSERT INTO `tbm_payrol` VALUES ('57', '1', '1', '0', '0', '0', 'test 9', '15', '', null, '0');
INSERT INTO `tbm_payrol` VALUES ('58', '1', '4', '6', '0', '0', 'Lembur', '5', '', '3', '0');
INSERT INTO `tbm_payrol` VALUES ('59', '1', '4', '1', '0', '0', 'Alfa', '20', '', null, '0');

-- ----------------------------
-- Table structure for tbm_payroll_formula
-- ----------------------------
DROP TABLE IF EXISTS `tbm_payroll_formula`;
CREATE TABLE `tbm_payroll_formula` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `payroll_id` int(11) DEFAULT NULL,
  `parameter_id` int(11) DEFAULT NULL,
  `operator_id` char(1) DEFAULT NULL,
  `order_id` int(11) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_payroll_formula
-- ----------------------------
INSERT INTO `tbm_payroll_formula` VALUES ('1', '56', '-6', '', '0', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('2', '56', '-5', '*', '1', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('3', '56', '56', '*', '2', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('4', '57', '-6', '', '0', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('5', '57', '-5', '*', '1', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('6', '57', '57', '*', '2', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('7', '58', '-6', '', '0', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('8', '58', '-5', '*', '1', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('9', '58', '58', '*', '2', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('10', '1', '-6', '', '0', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('11', '1', '-5', '*', '1', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('12', '1', '1', '*', '2', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('16', '2', '-6', '', '0', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('17', '2', '-5', '*', '1', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('18', '2', '2', '*', '2', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('19', '33', '-6', '', '0', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('20', '33', '-5', '*', '1', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('21', '33', '33', '*', '2', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('22', '45', '-6', '', '0', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('23', '45', '-5', '*', '1', '0');
INSERT INTO `tbm_payroll_formula` VALUES ('24', '45', '45', '*', '2', '0');

-- ----------------------------
-- Table structure for tbm_pelanggan
-- ----------------------------
DROP TABLE IF EXISTS `tbm_pelanggan`;
CREATE TABLE `tbm_pelanggan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kategori_id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `telepon` varchar(16) DEFAULT '',
  `npwp` varchar(30) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_pelanggan
-- ----------------------------
INSERT INTO `tbm_pelanggan` VALUES ('1', '2', 'INDADI UTAMA SDN BHD', 'JL, SUBANG JAYA NO 30', '085722984816', '345567456789', '1');
INSERT INTO `tbm_pelanggan` VALUES ('2', '26', 'PT. TRAGLOPINDO UTAMA', 'JALAN SABARUDDIN NO.8 SIMPANG BAKARAN BATU KELURAHAN SEI SEI RENGGAS PERMATA-KECAMATAN MEDAN AREA MEDAN (20214)-SUMATERA UTARA-INDONESIA', '62617321', '1', '0');
INSERT INTO `tbm_pelanggan` VALUES ('3', '26', 'CV. SWADAYA ABDI PUTRA', 'JL. JEND ABD. HARIS NASUTION NO. 5 MEDAN', '061-7878309', '2', '0');
INSERT INTO `tbm_pelanggan` VALUES ('4', '26', 'PT. BERKAH BUNDO BERSAMA', 'MEDAN', '', '3', '0');
INSERT INTO `tbm_pelanggan` VALUES ('5', '27', 'CV. MADANI SEJAHTERA', 'JL. STM RUKO STM BUSINESS CENTRE BLOK 1 NO. 024-025 MEDAN', '061-4146293', '4', '0');
INSERT INTO `tbm_pelanggan` VALUES ('6', '27', 'CV. HAR AGRITECH', 'MEDAN', '', '6', '0');
INSERT INTO `tbm_pelanggan` VALUES ('7', '26', 'CV. MANDIRI JAYA PERKASA', 'PEKANBARU', '', '7', '0');
INSERT INTO `tbm_pelanggan` VALUES ('8', '30', 'PT. JAYA ABADI SIAGA', 'MEDAN MARELAN', '', '77', '0');
INSERT INTO `tbm_pelanggan` VALUES ('9', '26', 'PT. VALMATIC INDONESIA', 'JL. KARTAMA NO 16 KELURAHAN MAHARATU KECAMATAN MARPOYAN DAMAI PEKANBARU-RIAU-INDONESIA', '761565887', '11', '0');
INSERT INTO `tbm_pelanggan` VALUES ('10', '26', 'CV. OKTA KARYA ENGINEERING', 'KOMPLEK ISTANA BISNIS CENTRE NO.45 -JL. BRIG.JEND KATAMSO MEDAN MAIMOON MEDAN 20159', '061-4517538', '332', '0');
INSERT INTO `tbm_pelanggan` VALUES ('11', '27', 'CV. KARYA PERKASA', 'KOMPLEK MMTC BLOK H NO. 8 MEDAN', '061-80089962', '33', '0');
INSERT INTO `tbm_pelanggan` VALUES ('12', '30', 'PT. PETRO ANDHARA ARTHA', 'JL. PAKU NO.17 LINGK III-MEDAN MARELAN', '061-6855515', '1', '0');
INSERT INTO `tbm_pelanggan` VALUES ('13', '28', 'UD. ANDI', 'SIBUHUAN', '', '1', '0');
INSERT INTO `tbm_pelanggan` VALUES ('14', '28', 'UD.HAFIZAH', 'PASIR JAE', '', '1', '0');
INSERT INTO `tbm_pelanggan` VALUES ('15', '28', 'UD.CAV', 'SIBUHUAN', '', '1', '0');
INSERT INTO `tbm_pelanggan` VALUES ('16', '26', 'PT. BUANA RANTAI BERKAT ABADI', '', '', '1', '0');
INSERT INTO `tbm_pelanggan` VALUES ('17', '31', 'PT. LARIS SUMUT MAKMUR', 'MEDAN', '', '1', '0');
INSERT INTO `tbm_pelanggan` VALUES ('18', '32', 'PT. TRAKINDO UTAMA', '', '', '1', '0');

-- ----------------------------
-- Table structure for tbm_pemasok
-- ----------------------------
DROP TABLE IF EXISTS `tbm_pemasok`;
CREATE TABLE `tbm_pemasok` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kategori_id` int(11) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `telepon` varchar(16) DEFAULT '',
  `fax` varchar(30) DEFAULT NULL,
  `contact_person` varchar(60) DEFAULT NULL,
  `no_sp` varchar(30) DEFAULT NULL,
  `fee` float(11,2) DEFAULT NULL,
  `id_kategori_harga` int(11) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_pemasok
-- ----------------------------
INSERT INTO `tbm_pemasok` VALUES ('2', '1', 'Tongku Hasibuan', 'Pasir Jae', '', '', '', '001', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('3', '2', 'CV. Berkah Mandiri', 'Sibuhuan', '', '', '', '002', null, '2', '0');
INSERT INTO `tbm_pemasok` VALUES ('4', '3', 'Andry E Sosa', 'Pasar Ujung Batu', '', '', '', '003', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('5', '12', 'Mandurana', 'Sibuhuan', '', '', '', '004', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('6', '13', 'ASM', 'Sibuhuan', '', '', '', '005', null, '13', '0');
INSERT INTO `tbm_pemasok` VALUES ('8', '14', 'Sejahtera Sawit', 'Sibuhuan', '', '', '', '006', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('10', '15', 'Zio', 'Sibuhuan', '', '', '', '007', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('11', '16', 'SHS', 'sibuhuan', '', '', '', '008', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('12', '17', 'UD. Rizki', 'Sibuhuan', '', '', '', '009', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('13', '18', 'Pinarik Jaya', 'Pinarik Sosa', '', '', '', '010', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('14', '19', 'PT. Sibuah Raya', 'Siali-ali', '', '', '', '011', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('15', '20', 'Rosmeini', 'Siali-ali', '', '', '', '012', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('18', '21', 'KT. SHBM', 'Sibuhuan', '', '', '', '013', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('19', '22', 'PT. Mujur Usaha Mandiri', 'Bunut', '', '', '', '014', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('20', '23', 'PT. Sinar Halomoan', 'Bunut', '', '', '', '015', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('21', '24', 'ASN', 'Sibuhuan', '', '', '', '016', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('22', '25', 'UD. Mitra Pribadi', 'Siali-ali', '', '', '', '017', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('23', '26', 'PT. TRAGLOPINDO UTAMA', 'JALAN SABARUDDIN NO.8 SIMPANG BAKARAN BATU KELURAHAN SEI SEI RENGGAS PERMATA-KECAMATAN MEDAN AREA MEDAN (20214)-SUMATERA UTARA-INDONESIA', '62617321', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('24', '26', 'CV. SWADAYA ABDI PUTRA', 'JL. JEND ABD. HARIS NASUTION NO. 5 MEDAN', '061-7878309', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('25', '26', 'PT. BERKAH BUNDO BERSAMA', 'MEDAN', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('26', '27', 'CV. MADANI SEJAHTERA', 'JL. STM RUKO STM BUSINESS CENTRE BLOK 1 NO. 024-025 MEDAN', '061-4146293', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('27', '27', 'CV. HAR AGRITECH', 'MEDAN', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('28', '26', 'CV. MANDIRI JAYA PERKASA', 'PEKANBARU', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('29', '30', 'PT. JAYA ABADI SIAGA', 'MEDAN MARELAN', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('30', '26', 'PT. VALMATIC INDONESIA', 'JL. KARTAMA NO 16 KELURAHAN MAHARATU KECAMATAN MARPOYAN DAMAI PEKANBARU-RIAU-INDONESIA', '761565887', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('31', '26', 'CV. OKTA KARYA ENGINEERING', 'KOMPLEK ISTANA BISNIS CENTRE NO.45 -JL. BRIG.JEND KATAMSO MEDAN MAIMOON MEDAN 20159', '061-4517538', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('32', '27', 'CV. KARYA PERKASA', 'KOMPLEK MMTC BLOK H NO. 8 MEDAN', '061-80089962', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('33', '30', 'PT. PETRO ANDHARA ARTHA', 'JL. PAKU NO.17 LINGK III-MEDAN MARELAN', '061-6855515', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('34', '28', 'UD. ANDI', 'SIBUHUAN', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('35', '28', 'UD.HAFIZAH', 'PASIR JAE', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('36', '28', 'UD.CAV', 'SIBUHUAN', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('37', '26', 'PT. BUANA RANTAI BERKAT ABADI', '', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('38', '31', 'PT. LARIS SUMUT MAKMUR', 'MEDAN', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('39', '32', 'PT. TRAKINDO UTAMA', '', '', '', '', '0', '0.00', '0', '0');

-- ----------------------------
-- Table structure for tbm_pendidikan
-- ----------------------------
DROP TABLE IF EXISTS `tbm_pendidikan`;
CREATE TABLE `tbm_pendidikan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(200) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_pendidikan
-- ----------------------------
INSERT INTO `tbm_pendidikan` VALUES ('1', 'S 3', '0');
INSERT INTO `tbm_pendidikan` VALUES ('2', 'S 2', '0');
INSERT INTO `tbm_pendidikan` VALUES ('3', 'S 1', '0');
INSERT INTO `tbm_pendidikan` VALUES ('4', 'D 3', '0');
INSERT INTO `tbm_pendidikan` VALUES ('5', 'D 2', '0');
INSERT INTO `tbm_pendidikan` VALUES ('6', 'D 1', '0');
INSERT INTO `tbm_pendidikan` VALUES ('7', 'SMA Sederajat', '0');

-- ----------------------------
-- Table structure for tbm_revenue
-- ----------------------------
DROP TABLE IF EXISTS `tbm_revenue`;
CREATE TABLE `tbm_revenue` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `revenue_category_id` int(11) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbm_revenue
-- ----------------------------
INSERT INTO `tbm_revenue` VALUES ('1', '1', 'PENDAPATAN TAMBAHAN', '0');

-- ----------------------------
-- Table structure for tbm_revenue_category
-- ----------------------------
DROP TABLE IF EXISTS `tbm_revenue_category`;
CREATE TABLE `tbm_revenue_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbm_revenue_category
-- ----------------------------
INSERT INTO `tbm_revenue_category` VALUES ('1', 'PENDAPATAN 12', '0');
INSERT INTO `tbm_revenue_category` VALUES ('2', 'PENDAPATAN 2', '1');

-- ----------------------------
-- Table structure for tbm_satuan
-- ----------------------------
DROP TABLE IF EXISTS `tbm_satuan`;
CREATE TABLE `tbm_satuan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) DEFAULT NULL,
  `singkatan` varchar(255) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_satuan
-- ----------------------------
INSERT INTO `tbm_satuan` VALUES ('1', 'Lembar', 'LBR', '1');
INSERT INTO `tbm_satuan` VALUES ('3', 'Karton', 'KTN', '1');
INSERT INTO `tbm_satuan` VALUES ('4', 'RIM', 'RIM', '1');
INSERT INTO `tbm_satuan` VALUES ('5', 'Test', 'Test1', '1');
INSERT INTO `tbm_satuan` VALUES ('6', 'ROLL', 'ROLL', '1');
INSERT INTO `tbm_satuan` VALUES ('7', 'BUNGKUS', 'BKS', '1');
INSERT INTO `tbm_satuan` VALUES ('8', 'BOX', 'BOX', '1');
INSERT INTO `tbm_satuan` VALUES ('9', 'PLANO', 'PLN', '1');
INSERT INTO `tbm_satuan` VALUES ('10', 'BUAH', 'BH', '1');
INSERT INTO `tbm_satuan` VALUES ('11', 'Test 7', 'Test 7', '1');
INSERT INTO `tbm_satuan` VALUES ('12', 'Kilogram', 'KG', '0');
INSERT INTO `tbm_satuan` VALUES ('13', 'Gram', 'GR', '0');
INSERT INTO `tbm_satuan` VALUES ('14', 'Buah', 'BH', '0');
INSERT INTO `tbm_satuan` VALUES ('15', 'Pcs', 'Pcs', '0');
INSERT INTO `tbm_satuan` VALUES ('16', 'Kotak', 'KTK', '0');
INSERT INTO `tbm_satuan` VALUES ('17', 'RIM', 'RIM', '0');
INSERT INTO `tbm_satuan` VALUES ('18', 'Lembar', 'Lbr', '0');
INSERT INTO `tbm_satuan` VALUES ('19', 'Botol', 'BTL', '0');
INSERT INTO `tbm_satuan` VALUES ('20', 'Gelas', 'GLS', '0');
INSERT INTO `tbm_satuan` VALUES ('21', 'Lusin', 'Lusin', '0');
INSERT INTO `tbm_satuan` VALUES ('22', 'Pack', 'Pack', '0');
INSERT INTO `tbm_satuan` VALUES ('23', 'Renceng', 'Renceng', '0');
INSERT INTO `tbm_satuan` VALUES ('24', 'TON', 'TON', '0');
INSERT INTO `tbm_satuan` VALUES ('25', 'Liter', 'LTR', '0');
INSERT INTO `tbm_satuan` VALUES ('26', 'Kaleng', 'KLG', '0');
INSERT INTO `tbm_satuan` VALUES ('27', 'PAIL', 'PAIL', '0');
INSERT INTO `tbm_satuan` VALUES ('28', 'SET', 'SET', '0');
INSERT INTO `tbm_satuan` VALUES ('29', 'METER', 'MTR', '0');
INSERT INTO `tbm_satuan` VALUES ('30', 'UNIT', 'UNIT', '0');
INSERT INTO `tbm_satuan` VALUES ('31', 'ROLL', 'ROLL', '0');
INSERT INTO `tbm_satuan` VALUES ('32', 'GULUNG', 'GLG', '0');
INSERT INTO `tbm_satuan` VALUES ('33', 'Bungkus', 'Bks', '0');
INSERT INTO `tbm_satuan` VALUES ('34', 'Blok', 'Blk', '0');
INSERT INTO `tbm_satuan` VALUES ('35', 'Batang', 'Btg', '0');
INSERT INTO `tbm_satuan` VALUES ('36', 'zak', 'zak', '0');
INSERT INTO `tbm_satuan` VALUES ('37', 'tube', 'tube', '0');
INSERT INTO `tbm_satuan` VALUES ('38', 'tabung', 'tbg', '0');
INSERT INTO `tbm_satuan` VALUES ('39', 'lebar', 'Lbr', '0');
INSERT INTO `tbm_satuan` VALUES ('40', 'Pasang', 'Psg', '0');

-- ----------------------------
-- Table structure for tbm_satuan_barang
-- ----------------------------
DROP TABLE IF EXISTS `tbm_satuan_barang`;
CREATE TABLE `tbm_satuan_barang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_barang` int(11) DEFAULT NULL,
  `id_satuan` int(11) DEFAULT NULL,
  `jumlah` float(11,2) DEFAULT NULL,
  `urutan` int(11) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1455 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_satuan_barang
-- ----------------------------
INSERT INTO `tbm_satuan_barang` VALUES ('10', '10', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('11', '11', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('12', '10', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('13', '11', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('14', '12', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('15', '13', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('16', '14', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('17', '15', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('18', '16', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('19', '17', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('20', '18', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('21', '19', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('22', '20', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('23', '21', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('24', '22', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('25', '23', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('26', '24', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('27', '25', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('28', '26', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('29', '27', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('30', '28', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('31', '29', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('32', '30', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('33', '31', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('34', '32', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('35', '33', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('36', '34', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('37', '35', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('38', '36', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('39', '37', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('40', '38', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('41', '39', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('42', '40', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('43', '41', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('44', '42', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('45', '43', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('46', '44', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('47', '45', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('48', '46', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('49', '47', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('50', '48', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('51', '49', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('52', '50', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('53', '51', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('54', '52', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('55', '53', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('56', '54', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('57', '55', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('58', '56', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('59', '57', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('60', '58', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('61', '59', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('62', '60', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('63', '61', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('64', '62', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('65', '63', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('66', '64', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('67', '65', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('68', '66', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('69', '67', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('70', '68', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('71', '69', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('72', '70', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('73', '71', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('74', '72', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('75', '73', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('76', '74', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('77', '75', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('78', '76', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('79', '77', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('80', '78', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('81', '79', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('82', '80', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('83', '81', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('84', '82', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('85', '83', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('86', '84', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('87', '85', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('88', '86', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('89', '87', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('90', '88', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('91', '89', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('92', '90', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('93', '91', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('94', '92', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('95', '93', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('96', '94', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('97', '95', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('98', '96', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('99', '97', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('100', '98', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('101', '99', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('102', '100', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('103', '101', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('104', '102', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('105', '103', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('106', '104', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('107', '105', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('108', '106', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('109', '107', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('110', '108', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('111', '109', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('112', '110', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('113', '111', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('114', '112', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('115', '113', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('116', '114', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('117', '115', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('118', '116', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('119', '117', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('120', '118', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('121', '119', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('122', '120', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('123', '121', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('124', '122', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('125', '123', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('126', '124', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('127', '125', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('128', '126', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('129', '127', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('130', '128', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('131', '129', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('132', '130', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('133', '131', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('134', '132', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('135', '133', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('136', '134', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('137', '135', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('138', '136', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('139', '137', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('140', '138', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('141', '139', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('142', '140', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('143', '141', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('144', '142', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('145', '143', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('146', '144', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('147', '145', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('148', '146', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('149', '147', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('150', '148', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('151', '149', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('152', '150', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('153', '151', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('154', '152', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('155', '153', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('156', '154', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('157', '155', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('158', '156', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('159', '157', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('160', '158', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('161', '159', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('162', '160', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('163', '161', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('164', '162', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('165', '163', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('166', '164', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('167', '165', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('168', '166', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('169', '167', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('170', '168', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('171', '169', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('172', '170', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('173', '171', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('174', '172', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('175', '173', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('176', '174', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('177', '175', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('178', '176', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('179', '177', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('180', '178', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('181', '179', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('182', '180', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('183', '181', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('184', '182', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('185', '183', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('186', '184', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('187', '185', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('188', '186', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('189', '187', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('190', '188', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('191', '189', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('192', '190', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('193', '191', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('194', '192', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('195', '193', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('196', '194', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('197', '195', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('198', '196', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('199', '197', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('200', '198', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('201', '199', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('202', '200', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('203', '201', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('204', '202', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('205', '203', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('206', '204', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('207', '205', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('208', '206', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('209', '207', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('210', '208', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('211', '209', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('212', '210', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('213', '211', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('214', '212', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('215', '213', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('216', '214', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('217', '215', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('218', '216', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('219', '217', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('220', '218', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('221', '219', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('222', '220', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('223', '221', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('224', '222', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('225', '223', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('226', '224', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('227', '225', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('228', '226', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('229', '227', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('230', '228', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('231', '229', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('232', '230', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('233', '231', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('234', '232', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('235', '233', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('236', '234', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('237', '235', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('238', '236', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('239', '237', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('240', '238', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('241', '239', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('242', '240', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('243', '241', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('244', '242', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('245', '243', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('246', '244', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('247', '245', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('248', '246', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('249', '247', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('250', '248', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('251', '249', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('252', '250', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('253', '251', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('254', '252', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('255', '253', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('256', '254', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('257', '255', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('258', '256', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('259', '257', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('260', '258', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('261', '259', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('262', '260', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('263', '261', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('264', '262', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('265', '263', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('266', '264', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('267', '265', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('268', '266', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('269', '267', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('270', '268', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('271', '269', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('272', '270', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('273', '271', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('274', '272', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('275', '273', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('276', '274', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('277', '275', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('278', '276', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('279', '277', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('280', '278', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('281', '279', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('282', '280', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('283', '281', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('284', '282', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('285', '283', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('286', '284', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('287', '285', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('288', '286', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('289', '287', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('290', '288', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('291', '289', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('292', '290', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('293', '291', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('294', '292', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('295', '293', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('296', '294', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('297', '295', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('298', '296', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('299', '297', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('300', '298', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('301', '299', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('302', '300', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('303', '301', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('304', '302', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('305', '303', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('306', '304', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('307', '305', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('308', '306', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('309', '307', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('310', '308', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('311', '309', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('312', '310', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('313', '311', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('314', '312', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('315', '313', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('316', '314', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('317', '315', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('318', '316', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('319', '317', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('320', '318', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('321', '319', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('322', '320', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('323', '321', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('324', '322', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('325', '323', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('326', '324', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('327', '325', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('328', '326', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('329', '327', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('330', '328', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('331', '329', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('332', '330', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('333', '331', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('334', '332', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('335', '333', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('336', '334', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('337', '335', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('338', '336', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('339', '337', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('340', '338', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('341', '339', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('342', '340', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('343', '341', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('344', '342', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('345', '343', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('346', '344', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('347', '345', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('348', '346', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('349', '347', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('350', '348', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('351', '349', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('352', '350', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('353', '351', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('354', '352', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('355', '353', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('356', '354', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('357', '355', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('358', '356', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('359', '357', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('360', '358', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('361', '359', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('362', '360', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('363', '361', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('364', '362', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('365', '363', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('366', '364', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('367', '365', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('368', '366', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('369', '367', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('370', '368', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('371', '369', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('372', '370', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('373', '371', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('374', '372', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('375', '373', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('376', '374', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('377', '375', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('378', '376', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('379', '377', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('380', '378', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('381', '379', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('382', '380', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('383', '381', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('384', '382', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('385', '383', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('386', '384', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('387', '385', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('388', '386', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('389', '387', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('390', '388', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('391', '389', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('392', '390', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('393', '391', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('394', '392', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('395', '393', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('396', '394', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('397', '395', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('398', '396', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('399', '397', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('400', '398', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('401', '399', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('402', '400', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('403', '401', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('404', '402', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('405', '403', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('406', '404', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('407', '405', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('408', '406', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('409', '407', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('410', '408', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('411', '409', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('412', '410', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('413', '411', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('414', '412', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('415', '413', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('416', '414', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('417', '415', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('418', '416', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('419', '417', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('420', '418', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('421', '419', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('422', '420', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('423', '421', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('424', '422', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('425', '423', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('426', '424', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('427', '425', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('428', '426', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('429', '427', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('430', '428', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('431', '429', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('432', '430', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('433', '431', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('434', '432', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('435', '433', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('436', '434', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('437', '435', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('438', '436', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('439', '437', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('440', '438', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('441', '439', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('442', '440', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('443', '441', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('444', '442', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('445', '443', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('446', '444', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('447', '445', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('448', '446', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('449', '447', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('450', '448', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('451', '449', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('452', '450', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('453', '451', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('454', '452', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('455', '453', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('456', '454', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('457', '455', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('458', '456', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('459', '457', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('460', '458', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('461', '459', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('462', '460', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('463', '461', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('464', '462', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('465', '463', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('466', '464', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('467', '465', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('468', '466', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('469', '467', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('470', '468', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('471', '469', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('472', '470', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('473', '471', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('474', '472', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('475', '473', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('476', '474', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('477', '475', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('478', '476', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('479', '477', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('480', '478', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('481', '479', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('482', '480', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('483', '481', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('484', '482', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('485', '483', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('486', '484', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('487', '485', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('488', '486', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('489', '487', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('490', '488', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('491', '489', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('492', '490', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('493', '491', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('494', '492', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('495', '493', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('496', '494', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('497', '495', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('498', '496', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('499', '497', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('500', '498', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('501', '499', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('502', '500', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('503', '501', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('504', '502', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('505', '503', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('506', '504', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('507', '505', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('508', '506', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('509', '507', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('510', '508', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('511', '509', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('512', '510', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('513', '511', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('514', '512', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('515', '513', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('516', '514', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('517', '515', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('518', '516', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('519', '517', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('520', '518', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('521', '519', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('522', '520', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('523', '521', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('524', '522', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('525', '523', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('526', '524', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('527', '525', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('528', '526', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('529', '527', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('530', '528', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('531', '529', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('532', '530', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('533', '531', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('534', '532', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('535', '533', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('536', '534', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('537', '535', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('538', '536', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('539', '537', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('540', '538', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('541', '539', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('542', '540', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('543', '541', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('544', '542', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('545', '543', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('546', '544', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('547', '545', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('548', '546', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('549', '547', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('550', '548', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('551', '549', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('552', '550', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('553', '551', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('554', '552', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('555', '553', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('556', '554', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('557', '555', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('558', '556', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('559', '557', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('560', '558', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('561', '559', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('562', '560', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('563', '561', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('564', '562', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('565', '563', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('566', '564', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('567', '565', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('568', '566', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('569', '567', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('570', '568', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('571', '569', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('572', '570', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('573', '571', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('574', '572', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('575', '573', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('576', '574', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('577', '575', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('578', '576', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('579', '577', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('580', '578', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('581', '579', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('582', '580', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('583', '581', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('584', '582', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('585', '583', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('586', '584', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('587', '585', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('588', '586', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('589', '587', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('590', '588', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('591', '589', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('592', '590', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('593', '591', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('594', '592', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('595', '593', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('596', '594', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('597', '595', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('598', '596', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('599', '597', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('600', '598', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('601', '599', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('602', '600', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('603', '601', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('604', '602', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('605', '603', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('606', '604', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('607', '605', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('608', '606', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('609', '607', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('610', '608', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('611', '609', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('612', '610', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('613', '611', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('614', '612', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('615', '613', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('616', '614', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('617', '615', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('618', '616', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('619', '617', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('620', '618', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('621', '619', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('622', '620', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('623', '621', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('624', '622', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('625', '623', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('626', '624', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('627', '625', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('628', '626', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('629', '627', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('630', '628', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('631', '629', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('632', '630', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('633', '631', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('634', '632', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('635', '633', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('636', '634', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('637', '635', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('638', '636', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('639', '637', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('640', '638', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('641', '639', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('642', '640', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('643', '641', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('644', '642', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('645', '643', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('646', '644', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('647', '645', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('648', '646', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('649', '647', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('650', '648', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('651', '649', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('652', '650', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('653', '651', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('654', '652', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('655', '653', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('656', '654', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('657', '655', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('658', '656', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('659', '657', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('660', '658', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('661', '659', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('662', '660', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('663', '661', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('664', '662', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('665', '663', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('666', '664', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('667', '665', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('668', '666', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('669', '667', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('670', '668', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('671', '669', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('672', '670', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('673', '671', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('674', '672', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('675', '673', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('676', '674', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('677', '675', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('678', '676', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('679', '677', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('680', '678', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('681', '679', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('682', '680', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('683', '681', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('684', '682', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('685', '683', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('686', '684', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('687', '685', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('688', '686', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('689', '687', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('690', '688', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('691', '689', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('692', '690', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('693', '691', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('694', '692', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('695', '693', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('696', '694', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('697', '695', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('698', '696', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('699', '697', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('700', '698', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('701', '699', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('702', '700', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('703', '701', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('704', '702', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('705', '703', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('706', '704', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('707', '705', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('708', '706', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('709', '707', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('710', '708', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('711', '709', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('712', '710', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('713', '711', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('714', '712', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('715', '713', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('716', '714', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('717', '715', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('718', '716', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('719', '717', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('720', '718', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('721', '719', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('722', '720', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('723', '721', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('724', '722', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('725', '723', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('726', '724', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('727', '725', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('728', '726', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('729', '727', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('730', '728', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('731', '729', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('732', '730', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('733', '731', '7', '1.00', '1', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('734', '732', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('735', '733', '7', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('736', '1019', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('737', '1019', '0', '0.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('738', '1020', '24', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('739', '1020', '12', '10000.00', '2', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('740', '1021', '24', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('741', '1021', '12', '1000.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('742', '13', '22', '1.00', '2', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('743', '13', '15', '10.00', '3', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('744', '14', '22', '1.00', '2', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('745', '14', '15', '5.00', '3', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('746', '1020', '12', '1000.00', '3', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('747', '12', '27', '1.00', '2', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('748', '13', '27', '1.00', '4', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('749', '14', '27', '1.00', '4', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('750', '15', '27', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('751', '13', '12', '20.00', '5', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('752', '12', '24', '1.00', '3', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('753', '12', '25', '1000.00', '4', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('754', '12', '27', '1.00', '5', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('755', '12', '12', '20.00', '6', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('756', '14', '12', '20.00', '5', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('757', '15', '12', '20.00', '3', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('758', '16', '25', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('759', '23', '25', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('760', '24', '25', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('761', '25', '25', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('762', '26', '25', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('763', '27', '25', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('764', '28', '25', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('765', '33', '26', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('766', '34', '26', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('767', '36', '26', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('768', '37', '24', '12.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('769', '35', '26', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('770', '38', '25', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('771', '39', '25', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('772', '40', '33', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('773', '41', '33', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('774', '42', '33', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('775', '43', '16', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('776', '44', '16', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('777', '45', '33', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('778', '46', '34', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('779', '47', '16', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('780', '48', '16', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('781', '49', '16', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('782', '50', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('783', '51', '34', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('784', '52', '34', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('785', '55', '34', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('786', '54', '34', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('787', '56', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('788', '53', '34', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('789', '58', '16', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('790', '59', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('791', '60', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('792', '63', '34', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('793', '64', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('794', '65', '16', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('795', '66', '16', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('796', '67', '16', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('797', '68', '17', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('798', '69', '17', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('799', '70', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('800', '71', '31', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('801', '72', '31', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('802', '73', '31', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('803', '74', '19', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('804', '75', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('805', '76', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('806', '77', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('807', '78', '34', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('808', '79', '34', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('809', '80', '16', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('810', '81', '32', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('811', '82', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('812', '83', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('813', '84', '16', '12.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('814', '86', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('815', '87', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('816', '88', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('817', '89', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('818', '91', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('819', '92', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('820', '93', '19', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('821', '94', '19', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('822', '97', '19', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('823', '99', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('824', '102', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('825', '107', '28', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('826', '108', '28', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('827', '109', '28', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('828', '110', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('829', '111', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('830', '112', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('831', '118', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('832', '119', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('833', '120', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('834', '121', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('835', '122', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('836', '123', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('837', '124', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('838', '125', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('839', '126', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('840', '127', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('841', '128', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('842', '785', '36', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('843', '130', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('844', '131', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('845', '132', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('846', '133', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('847', '134', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('848', '135', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('849', '137', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('850', '17', '24', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('851', '17', '25', '1.00', '3', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('852', '139', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('853', '140', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('854', '141', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('855', '142', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('856', '143', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('857', '144', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('858', '145', '33', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('859', '146', '33', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('860', '150', '12', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('861', '151', '12', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('862', '160', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('863', '166', '29', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('864', '199', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('865', '200', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('866', '201', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('867', '202', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('868', '203', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('869', '204', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('870', '205', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('871', '206', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('872', '207', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('873', '208', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('874', '117', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('875', '113', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('876', '114', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('877', '115', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('878', '116', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('879', '129', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('880', '147', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('881', '148', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('882', '152', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('883', '156', '28', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('884', '157', '28', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('885', '158', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('886', '171', '33', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('887', '172', '33', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('888', '173', '31', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('889', '174', '31', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('890', '175', '31', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('891', '210', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('892', '211', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('893', '212', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('894', '213', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('895', '214', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('896', '215', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('897', '216', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('898', '217', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('899', '219', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('900', '222', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('901', '223', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('902', '226', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('903', '227', '35', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('904', '228', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('905', '229', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('906', '230', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('907', '231', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('908', '232', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('909', '233', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('910', '234', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('911', '235', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('912', '236', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('913', '237', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('914', '238', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('915', '239', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('916', '240', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('917', '244', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('918', '246', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('919', '250', '28', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('920', '252', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('921', '253', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('922', '255', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('923', '259', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('924', '260', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('925', '261', '32', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('926', '262', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('927', '263', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('928', '264', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('929', '265', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('930', '266', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('931', '267', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('932', '268', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('933', '269', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('934', '270', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('935', '271', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('936', '272', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('937', '275', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('938', '276', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('939', '278', '12', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('940', '279', '12', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('941', '280', '12', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('942', '285', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('943', '286', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('944', '287', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('945', '288', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('946', '290', '26', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('947', '291', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('948', '292', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('949', '293', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('950', '298', '28', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('951', '300', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('952', '301', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('953', '302', '28', '1.00', '2', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('954', '302', '15', '1.00', '3', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('955', '303', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('956', '306', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('957', '307', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('958', '308', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('959', '309', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('960', '310', '28', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('961', '312', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('962', '314', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('963', '315', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('964', '316', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('965', '317', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('966', '318', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('967', '319', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('968', '874', '31', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('969', '875', '31', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('970', '195', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('971', '196', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('972', '892', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('973', '897', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('974', '857', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('975', '343', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('976', '788', '36', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('977', '807', '27', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('978', '808', '27', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('979', '809', '27', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('980', '810', '27', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('981', '811', '36', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('982', '95', '19', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('983', '90', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('984', '96', '19', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('985', '103', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('986', '186', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('987', '188', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('988', '189', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('989', '190', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('990', '191', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('991', '192', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('992', '193', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('993', '194', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('994', '323', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('995', '324', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('996', '328', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('997', '327', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('998', '329', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('999', '330', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1000', '331', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1001', '332', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1002', '333', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1003', '334', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1004', '335', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1005', '336', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1006', '337', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1007', '338', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1008', '339', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1009', '340', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1010', '341', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1011', '342', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1012', '344', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1013', '345', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1014', '18', '27', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1015', '100', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1016', '101', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1017', '198', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1018', '197', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1019', '1022', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1020', '1023', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1021', '764', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1022', '1024', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1023', '855', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1024', '851', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1025', '853', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1026', '856', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1027', '367', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1028', '359', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1029', '360', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1030', '361', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1031', '362', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1032', '363', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1033', '364', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1034', '365', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1035', '366', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1036', '368', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1037', '370', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1038', '371', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1039', '372', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1040', '373', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1041', '377', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1042', '378', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1043', '379', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1044', '380', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1045', '376', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1046', '381', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1047', '382', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1048', '383', '35', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1049', '385', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1050', '386', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1051', '387', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1052', '388', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1053', '389', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1054', '395', '35', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1055', '396', '35', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1056', '399', '35', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1057', '400', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1058', '401', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1059', '402', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1060', '403', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1061', '404', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1062', '405', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1063', '406', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1064', '407', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1065', '408', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1066', '411', '28', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1067', '412', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1068', '413', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1069', '414', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1070', '415', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1071', '416', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1072', '417', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1073', '418', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1074', '419', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1075', '420', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1076', '421', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1077', '422', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1078', '423', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1079', '424', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1080', '425', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1081', '426', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1082', '427', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1083', '428', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1084', '429', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1085', '430', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1086', '431', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1087', '437', '31', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1088', '439', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1089', '440', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1090', '441', '31', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1091', '442', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1092', '443', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1093', '445', '31', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1094', '448', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1095', '453', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1096', '456', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1097', '457', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1098', '458', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1099', '459', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1100', '460', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1101', '461', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1102', '464', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1103', '465', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1104', '466', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1105', '467', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1106', '468', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1107', '477', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1108', '469', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1109', '470', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1110', '471', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1111', '472', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1112', '473', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1113', '474', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1114', '475', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1115', '476', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1116', '487', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1117', '478', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1118', '479', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1119', '480', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1120', '481', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1121', '482', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1122', '483', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1123', '484', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1124', '485', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1125', '486', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1126', '497', '29', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1127', '490', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1128', '489', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1129', '491', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1130', '492', '28', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1131', '493', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1132', '496', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1133', '498', '29', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1134', '500', '29', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1135', '515', '28', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1136', '520', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1137', '526', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1138', '527', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1139', '528', '28', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1140', '531', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1141', '532', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1142', '533', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1143', '534', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1144', '535', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1145', '536', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1146', '546', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1147', '537', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1148', '538', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1149', '539', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1150', '540', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1151', '541', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1152', '542', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1153', '543', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1154', '544', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1155', '545', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1156', '556', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1157', '547', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1158', '548', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1159', '549', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1160', '550', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1161', '551', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1162', '552', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1163', '553', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1164', '554', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1165', '555', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1166', '566', '35', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1167', '562', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1168', '572', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1169', '573', '18', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1170', '574', '18', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1171', '575', '18', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1172', '576', '39', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1173', '577', '39', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1174', '578', '35', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1175', '582', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1176', '588', '35', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1177', '854', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1178', '355', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1179', '356', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1180', '351', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1181', '354', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1182', '565', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1183', '594', '35', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1184', '598', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1185', '599', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1186', '606', '29', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1187', '607', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1188', '608', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1189', '609', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1190', '612', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1191', '613', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1192', '614', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1193', '615', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1194', '616', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1195', '617', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1196', '618', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1197', '619', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1198', '620', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1199', '622', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1200', '623', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1201', '630', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1202', '631', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1203', '632', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1204', '633', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1205', '634', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1206', '645', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1207', '646', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1208', '647', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1209', '650', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1210', '651', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1211', '652', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1212', '653', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1213', '655', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1214', '656', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1215', '666', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1216', '659', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1217', '660', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1218', '661', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1219', '662', '28', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1220', '667', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1221', '669', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1222', '670', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1223', '672', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1224', '673', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1225', '674', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1226', '676', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1227', '701', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1228', '702', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1229', '703', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1230', '704', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1231', '707', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1232', '708', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1233', '713', '32', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1234', '714', '28', '1.00', '3', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1235', '715', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1236', '716', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1237', '717', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1238', '718', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1239', '719', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1240', '720', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1241', '721', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1242', '722', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1243', '723', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1244', '724', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1245', '734', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1246', '725', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1247', '726', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1248', '727', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1249', '728', '28', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1250', '729', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1251', '730', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1252', '731', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1253', '735', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1254', '736', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1255', '756', '35', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1256', '747', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1257', '748', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1258', '749', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1259', '751', '35', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1260', '750', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1261', '737', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1262', '350', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1263', '353', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1264', '738', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1265', '739', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1266', '740', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1267', '184', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1268', '185', '15', '1.00', '2', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1269', '741', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1270', '742', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1271', '758', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1272', '772', '36', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1273', '767', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1274', '765', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1275', '768', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1276', '769', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1277', '783', '33', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1278', '782', '27', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1279', '784', '33', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1280', '786', '33', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1281', '775', '26', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1282', '753', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1283', '755', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1284', '760', '35', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1285', '761', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1286', '776', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1287', '777', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1288', '780', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1289', '796', '33', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1290', '787', '27', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1291', '789', '36', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1292', '790', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1293', '791', '33', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1294', '792', '25', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1295', '793', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1296', '794', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1297', '795', '33', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1298', '797', '33', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1299', '798', '36', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1300', '799', '27', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1301', '800', '33', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1302', '801', '19', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1303', '802', '19', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1304', '803', '19', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1305', '804', '19', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1306', '805', '19', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1307', '806', '19', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1308', '812', '36', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1309', '813', '16', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1310', '814', '19', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1311', '815', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1312', '816', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1313', '827', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1314', '828', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1315', '829', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1316', '830', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1317', '831', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1318', '832', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1319', '833', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1320', '834', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1321', '835', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1322', '836', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1323', '847', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1324', '848', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1325', '849', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1326', '850', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1327', '852', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1328', '866', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1329', '858', '29', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1330', '859', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1331', '1017', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1332', '1018', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1333', '1016', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1334', '1014', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1335', '1013', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1336', '1008', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1337', '1010', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1338', '1011', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1339', '1012', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1340', '1006', '29', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1341', '1005', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1342', '1004', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1343', '1003', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1344', '1002', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1345', '1001', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1346', '1000', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1347', '999', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1348', '998', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1349', '997', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1350', '996', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1351', '987', '40', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1352', '988', '40', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1353', '989', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1354', '990', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1355', '991', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1356', '992', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1357', '993', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1358', '994', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1359', '986', '40', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1360', '977', '29', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1361', '978', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1362', '979', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1363', '980', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1364', '981', '29', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1365', '983', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1366', '976', '29', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1367', '967', '26', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1368', '968', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1369', '969', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1370', '970', '29', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1371', '971', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1372', '975', '29', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1373', '966', '28', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1374', '965', '28', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1375', '958', '38', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1376', '959', '38', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1377', '960', '38', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1378', '961', '38', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1379', '962', '37', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1380', '964', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1381', '957', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1382', '956', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1383', '949', '38', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1384', '950', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1385', '951', '31', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1386', '953', '29', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1387', '954', '29', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1388', '955', '29', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1389', '946', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1390', '940', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1391', '941', '28', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1392', '942', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1393', '943', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1394', '945', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1395', '923', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1396', '917', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1397', '918', '37', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1398', '919', '38', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1399', '920', '38', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1400', '921', '38', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1401', '922', '26', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1402', '916', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1403', '910', '28', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1404', '909', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1405', '898', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1406', '899', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1407', '901', '32', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1408', '902', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1409', '893', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1410', '887', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1411', '889', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1412', '891', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1413', '894', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1414', '895', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1415', '896', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1416', '886', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1417', '885', '12', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1418', '879', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1419', '880', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1420', '881', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1421', '882', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1422', '883', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1423', '884', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1424', '868', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1425', '871', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1426', '872', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1427', '873', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1428', '867', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1429', '865', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1430', '860', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1431', '862', '28', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1432', '863', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1433', '864', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1434', '837', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1435', '838', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1436', '840', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1437', '841', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1438', '842', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1439', '843', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1440', '844', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1441', '845', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1442', '846', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1443', '817', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1444', '818', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1445', '819', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1446', '820', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1447', '821', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1448', '822', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1449', '823', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1450', '824', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1451', '825', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1452', '826', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1453', '1025', '15', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1454', '84', '15', '1.00', '3', '0');

-- ----------------------------
-- Table structure for tbm_setting_komidel
-- ----------------------------
DROP TABLE IF EXISTS `tbm_setting_komidel`;
CREATE TABLE `tbm_setting_komidel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operator` varchar(30) DEFAULT NULL,
  `komidel` float(11,2) DEFAULT NULL,
  `nama` varchar(60) DEFAULT NULL,
  `singkatan` varchar(10) DEFAULT NULL,
  `harga` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_setting_komidel
-- ----------------------------
INSERT INTO `tbm_setting_komidel` VALUES ('1', '<=', '5.40', 'BUAH KECIL', 'BK', '2000.00', '0');
INSERT INTO `tbm_setting_komidel` VALUES ('2', '<=', '12.40', 'BUAH SEDANG', 'BS', '2500.00', '0');
INSERT INTO `tbm_setting_komidel` VALUES ('3', '<=', '17.40', 'BUAH BESAR', 'BB', '3000.00', '0');
INSERT INTO `tbm_setting_komidel` VALUES ('4', '>=', '17.50', 'BUAH SUPER', 'BSU', '4000.00', '0');

-- ----------------------------
-- Table structure for tbm_shift_setting
-- ----------------------------
DROP TABLE IF EXISTS `tbm_shift_setting`;
CREATE TABLE `tbm_shift_setting` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shif` varchar(58) DEFAULT NULL COMMENT '28 cuti istimewa 29 cuti keagamaan 30 melahirkan, 31 menikah,32 tahunan , 33, dinas, 34 izin, 35 lebur, 36 izin, 37 sakit',
  `datang` time DEFAULT NULL,
  `pulang` time DEFAULT NULL,
  `lama` int(4) DEFAULT NULL,
  `waktumakan` time DEFAULT NULL,
  `waktumakanselesai` time DEFAULT NULL,
  `ket` varchar(50) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_shift_setting
-- ----------------------------
INSERT INTO `tbm_shift_setting` VALUES ('1', '1', '06:00:00', '14:00:00', '8', '10:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('2', '2', '06:00:00', '18:00:00', '12', '12:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('3', '3', '07:00:00', '15:00:00', '8', '11:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('4', '4', '07:00:00', '16:00:00', '9', '11:30:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('5', '5', '07:00:00', '17:00:00', '10', '12:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('6', '6', '07:00:00', '19:00:00', '12', '13:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('7', '7', '08:00:00', '14:00:00', '6', '11:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('8', '8', '08:00:00', '16:00:00', '8', '12:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('9', '9', '08:00:00', '17:00:00', '9', '12:30:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('10', '10', '09:00:00', '17:00:00', '8', '13:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('11', '11', '09:00:00', '18:00:00', '9', '13:30:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('12', '12', '10:00:00', '18:00:00', '8', '14:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('13', '13', '11:00:00', '19:00:00', '8', '15:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('14', '14', '12:00:00', '20:00:00', '8', '16:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('15', '15', '14:00:00', '22:00:00', '8', '18:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('16', '16', '15:00:00', '22:00:00', '7', '18:30:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('17', '17', '15:00:00', '23:00:00', '8', '19:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('18', '18', '18:00:00', '06:00:00', '12', '12:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('19', '19', '19:00:00', '07:00:00', '12', '13:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('20', '20', '19:00:00', '23:00:00', '4', '21:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('21', '21', '21:00:00', '05:00:00', '8', '13:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('22', '22', '22:00:00', '06:00:00', '8', '14:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('23', '23', '22:00:00', '07:00:00', '9', '14:30:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('24', '24', '23:00:00', '07:00:00', '8', '15:00:00', null, null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('25', '25', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Cuti Istimewa', '0');
INSERT INTO `tbm_shift_setting` VALUES ('26', '26', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Cuti Keagamaan', '0');
INSERT INTO `tbm_shift_setting` VALUES ('27', '27', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Cuti Melahirkan', '0');
INSERT INTO `tbm_shift_setting` VALUES ('28', '28', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Cuti Menikah', '0');
INSERT INTO `tbm_shift_setting` VALUES ('29', '29', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Cuti Tahunan', '0');
INSERT INTO `tbm_shift_setting` VALUES ('30', '30', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Dinas', '0');
INSERT INTO `tbm_shift_setting` VALUES ('31', '31', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Izin', '0');
INSERT INTO `tbm_shift_setting` VALUES ('32', '32', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Lembur ', '1');
INSERT INTO `tbm_shift_setting` VALUES ('33', '33', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Libur', '1');
INSERT INTO `tbm_shift_setting` VALUES ('34', '34', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Sakit', '1');
INSERT INTO `tbm_shift_setting` VALUES ('35', '1344', '09:30:00', '17:30:00', '7', '14:30:00', '15:30:00', null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('36', '1', '08:00:00', '17:00:00', '8', '12:00:00', '13:00:00', null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('37', '2020', '08:00:00', '17:00:00', '8', '12:00:00', '13:00:00', null, '0');

-- ----------------------------
-- Table structure for tbm_status_karyawan
-- ----------------------------
DROP TABLE IF EXISTS `tbm_status_karyawan`;
CREATE TABLE `tbm_status_karyawan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_status_karyawan
-- ----------------------------
INSERT INTO `tbm_status_karyawan` VALUES ('1', 'BHL', '0');
INSERT INTO `tbm_status_karyawan` VALUES ('2', 'Training', '0');
INSERT INTO `tbm_status_karyawan` VALUES ('3', 'Tetap', '0');

-- ----------------------------
-- Table structure for tbm_sub_department
-- ----------------------------
DROP TABLE IF EXISTS `tbm_sub_department`;
CREATE TABLE `tbm_sub_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_department` int(11) DEFAULT NULL,
  `nama` varchar(200) DEFAULT NULL,
  `kode` varchar(60) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_sub_department
-- ----------------------------
INSERT INTO `tbm_sub_department` VALUES ('1', '0', 'Admin HRD', '1', '0');
INSERT INTO `tbm_sub_department` VALUES ('2', '0', 'Management', '02', '0');
INSERT INTO `tbm_sub_department` VALUES ('3', '0', 'Front Office', '03', '0');
INSERT INTO `tbm_sub_department` VALUES ('4', '0', 'Housekeeping', '04', '0');
INSERT INTO `tbm_sub_department` VALUES ('5', '0', 'Food & Beverage', '05', '0');
INSERT INTO `tbm_sub_department` VALUES ('6', '0', 'Purchasing', '06', '0');
INSERT INTO `tbm_sub_department` VALUES ('7', '0', 'Management', '07', '0');
INSERT INTO `tbm_sub_department` VALUES ('8', '0', 'AR & AP', '08', '0');
INSERT INTO `tbm_sub_department` VALUES ('9', '0', 'Management', '09', '0');

-- ----------------------------
-- Table structure for tbm_user_group
-- ----------------------------
DROP TABLE IF EXISTS `tbm_user_group`;
CREATE TABLE `tbm_user_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_user_group
-- ----------------------------
INSERT INTO `tbm_user_group` VALUES ('1', 'Super Administrator', '0');
INSERT INTO `tbm_user_group` VALUES ('2', 'Administrator', '0');
INSERT INTO `tbm_user_group` VALUES ('3', 'Operator', '0');
INSERT INTO `tbm_user_group` VALUES ('72', 'Operator Transaksi', '1');
INSERT INTO `tbm_user_group` VALUES ('73', 'Operator Transaksi', '0');
INSERT INTO `tbm_user_group` VALUES ('74', 'Kasir', '0');
INSERT INTO `tbm_user_group` VALUES ('75', 'Inventory', '0');
INSERT INTO `tbm_user_group` VALUES ('76', 'Purchasing', '0');
INSERT INTO `tbm_user_group` VALUES ('77', 'HRD', '0');
INSERT INTO `tbm_user_group` VALUES ('78', 'TRADING TBS', '0');
INSERT INTO `tbm_user_group` VALUES ('79', 'FINANCE', '0');
INSERT INTO `tbm_user_group` VALUES ('80', 'Produksi', '0');

-- ----------------------------
-- Table structure for tbm_user_menu_group
-- ----------------------------
DROP TABLE IF EXISTS `tbm_user_menu_group`;
CREATE TABLE `tbm_user_menu_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_group_id` int(11) DEFAULT NULL,
  `menu_id` int(11) DEFAULT NULL,
  `st` char(1) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=302 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_user_menu_group
-- ----------------------------
INSERT INTO `tbm_user_menu_group` VALUES ('1', '2', '2', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('2', '2', '3', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('3', '2', '5', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('4', '2', '6', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('5', '2', '8', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('6', '2', '9', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('7', '2', '11', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('8', '2', '12', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('9', '3', '2', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('10', '3', '3', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('11', '3', '5', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('12', '3', '6', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('13', '3', '8', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('14', '3', '9', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('15', '3', '11', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('16', '3', '12', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('17', '1', '2', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('18', '1', '3', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('19', '1', '5', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('20', '1', '6', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('21', '1', '8', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('22', '1', '9', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('23', '1', '11', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('24', '1', '12', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('25', '73', '2', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('26', '73', '3', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('27', '73', '5', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('28', '73', '6', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('29', '73', '8', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('30', '73', '9', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('31', '73', '11', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('32', '73', '12', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('33', '1', '14', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('34', '1', '15', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('35', '1', '16', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('36', '73', '14', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('37', '73', '15', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('38', '73', '16', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('39', '73', '16', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('40', '73', '14', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('41', '73', '15', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('42', '73', '16', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('43', '1', '18', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('44', '1', '19', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('45', '1', '22', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('46', '1', '22', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('47', '1', '23', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('48', '1', '20', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('49', '1', '21', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('50', '74', '2', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('51', '74', '3', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('52', '74', '5', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('53', '74', '6', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('54', '74', '8', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('55', '74', '9', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('56', '74', '11', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('57', '74', '12', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('58', '74', '14', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('59', '74', '15', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('60', '74', '16', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('61', '74', '18', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('62', '74', '19', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('63', '74', '20', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('64', '74', '21', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('65', '74', '22', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('66', '74', '23', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('67', '2', '23', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('68', '2', '16', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('69', '2', '22', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('70', '2', '18', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('71', '1', '24', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('72', '1', '25', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('75', '2', '21', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('76', '1', '26', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('77', '1', '27', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('78', '1', '28', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('79', '1', '29', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('80', '1', '30', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('81', '1', '34', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('82', '1', '35', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('83', '1', '32', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('84', '1', '33', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('85', '1', '36', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('86', '1', '37', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('87', '1', '38', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('88', '1', '40', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('89', '1', '39', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('90', '1', '41', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('91', '1', '50', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('92', '1', '51', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('93', '1', '52', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('94', '1', '53', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('95', '1', '54', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('96', '1', '43', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('97', '1', '44', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('98', '1', '45', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('99', '1', '48', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('100', '1', '47', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('101', '1', '46', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('102', '1', '55', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('103', '1', '56', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('104', '1', '57', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('105', '1', '60', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('106', '1', '64', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('107', '1', '63', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('108', '1', '62', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('109', '1', '61', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('110', '1', '65', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('111', '1', '59', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('112', '1', '58', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('113', '1', '66', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('114', '1', '67', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('115', '1', '68', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('116', '2', '33', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('117', '2', '57', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('118', '2', '60', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('119', '2', '32', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('120', '2', '56', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('121', '2', '45', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('122', '2', '46', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('123', '2', '47', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('124', '2', '48', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('125', '2', '43', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('126', '2', '44', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('127', '2', '61', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('128', '2', '62', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('129', '2', '28', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('130', '2', '63', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('131', '2', '29', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('132', '2', '64', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('133', '2', '27', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('134', '2', '58', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('135', '2', '58', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('136', '1', '69', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('137', '1', '70', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('138', '1', '71', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('139', '1', '42', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('140', '1', '72', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('141', '1', '74', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('142', '1', '73', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('143', '1', '75', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('144', '1', '76', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('145', '1', '77', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('146', '1', '78', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('147', '1', '79', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('148', '1', '80', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('149', '1', '81', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('150', '1', '81', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('151', '1', '82', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('152', '75', '16', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('153', '75', '18', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('154', '75', '76', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('155', '75', '37', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('156', '75', '69', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('157', '75', '68', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('158', '75', '68', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('159', '75', '77', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('160', '75', '29', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('161', '75', '5', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('162', '75', '2', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('163', '75', '30', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('164', '75', '9', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('165', '78', '40', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('166', '78', '12', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('167', '78', '36', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('168', '76', '59', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('169', '76', '58', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('170', '76', '29', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('171', '76', '5', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('172', '76', '9', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('173', '74', '70', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('174', '74', '35', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('175', '74', '75', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('176', '74', '65', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('177', '74', '66', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('178', '74', '41', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('179', '74', '55', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('180', '77', '42', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('181', '77', '72', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('182', '77', '42', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('183', '77', '73', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('184', '77', '79', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('185', '77', '53', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('186', '77', '78', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('187', '77', '52', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('188', '77', '80', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('189', '77', '54', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('190', '77', '47', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('191', '77', '46', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('192', '77', '44', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('193', '77', '45', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('194', '77', '43', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('195', '77', '48', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('196', '79', '38', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('197', '79', '67', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('198', '79', '55', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('199', '79', '81', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('200', '79', '82', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('201', '79', '70', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('202', '79', '71', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('203', '79', '75', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('204', '79', '58', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('205', '79', '59', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('206', '79', '12', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('207', '79', '57', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('208', '79', '56', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('209', '79', '60', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('210', '79', '61', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('211', '79', '62', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('212', '79', '62', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('213', '78', '28', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('214', '78', '6', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('215', '78', '33', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('216', '78', '33', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('217', '3', '36', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('218', '3', '28', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('219', '3', '71', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('220', '78', '38', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('221', '80', '2', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('222', '80', '3', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('223', '80', '5', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('224', '80', '6', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('225', '80', '9', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('226', '80', '12', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('227', '80', '14', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('228', '80', '15', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('229', '80', '16', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('230', '80', '18', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('231', '80', '25', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('232', '80', '27', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('233', '80', '28', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('234', '80', '29', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('235', '80', '30', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('236', '80', '32', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('237', '80', '33', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('238', '80', '34', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('239', '80', '35', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('240', '80', '36', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('241', '80', '37', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('242', '80', '38', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('243', '80', '39', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('244', '80', '40', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('245', '80', '41', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('246', '80', '42', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('247', '80', '43', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('248', '80', '44', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('249', '80', '45', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('250', '80', '46', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('251', '80', '48', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('252', '80', '50', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('253', '80', '51', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('254', '80', '52', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('255', '80', '53', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('256', '80', '54', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('257', '80', '55', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('258', '80', '56', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('259', '80', '57', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('260', '80', '58', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('261', '80', '59', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('262', '80', '60', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('263', '80', '61', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('264', '80', '62', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('265', '80', '63', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('266', '80', '64', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('267', '80', '65', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('268', '80', '66', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('269', '80', '67', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('270', '80', '68', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('271', '80', '69', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('272', '80', '70', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('273', '80', '71', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('274', '80', '72', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('275', '80', '73', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('276', '80', '74', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('277', '80', '75', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('278', '80', '76', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('279', '80', '77', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('280', '80', '78', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('281', '80', '79', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('282', '80', '80', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('283', '80', '81', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('284', '80', '82', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('285', '80', '83', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('286', '78', '69', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('287', '79', '76', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('288', '79', '16', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('289', '79', '48', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('290', '75', '27', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('291', '75', '3', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('292', '76', '71', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('293', '76', '18', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('294', '76', '37', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('295', '76', '16', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('296', '76', '76', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('297', '76', '27', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('298', '76', '27', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('299', '74', '60', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('300', '1', '93', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('301', '1', '94', '1', '0');

-- ----------------------------
-- Table structure for tbt_cetakan
-- ----------------------------
DROP TABLE IF EXISTS `tbt_cetakan`;
CREATE TABLE `tbt_cetakan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jns_transaksi` char(1) DEFAULT '0',
  `id_pelanggan` int(11) DEFAULT NULL,
  `nama_pelanggan` varchar(255) DEFAULT NULL,
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT NULL,
  `subtotal` float(11,2) DEFAULT NULL,
  `diskon` float(11,2) DEFAULT NULL,
  `total` float(11,2) DEFAULT NULL,
  `st_lunas` char(1) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_cetakan
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_cetakan_bayar
-- ----------------------------
DROP TABLE IF EXISTS `tbt_cetakan_bayar`;
CREATE TABLE `tbt_cetakan_bayar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) DEFAULT '0',
  `tgl_bayar` date DEFAULT NULL,
  `wkt_bayar` time DEFAULT NULL,
  `jml_bayar` float(11,2) DEFAULT NULL,
  `kembalian` float(11,2) DEFAULT NULL,
  `sisa_bayar` float(11,2) DEFAULT NULL,
  `st_dp` char(1) DEFAULT '0',
  `st_posting` char(1) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_cetakan_bayar
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_cetakan_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbt_cetakan_detail`;
CREATE TABLE `tbt_cetakan_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) DEFAULT '0',
  `id_cetakan` int(11) DEFAULT NULL,
  `nm_cetakan` varchar(60) DEFAULT NULL,
  `hrg_cetakan` float(11,2) DEFAULT '0.00',
  `jumlah_pesanan` int(11) DEFAULT NULL,
  `est_hari` int(11) DEFAULT NULL,
  `tt_hari` int(11) DEFAULT NULL,
  `lembur` float(11,2) DEFAULT NULL,
  `subtotal` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_cetakan_detail
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_cetakan_detail_bahan
-- ----------------------------
DROP TABLE IF EXISTS `tbt_cetakan_detail_bahan`;
CREATE TABLE `tbt_cetakan_detail_bahan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cetakan_detail` int(11) DEFAULT '0',
  `id_barang` int(11) DEFAULT NULL,
  `ukuran` varchar(100) DEFAULT NULL,
  `jml` float(11,2) DEFAULT NULL,
  `harga` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_cetakan_detail_bahan
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_cetakan_detail_param
-- ----------------------------
DROP TABLE IF EXISTS `tbt_cetakan_detail_param`;
CREATE TABLE `tbt_cetakan_detail_param` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_cetakan_detail` int(11) DEFAULT '0',
  `parameter` varchar(100) DEFAULT NULL,
  `harga` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_cetakan_detail_param
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_commodity_transaction
-- ----------------------------
DROP TABLE IF EXISTS `tbt_commodity_transaction`;
CREATE TABLE `tbt_commodity_transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_no` varchar(60) DEFAULT NULL,
  `tgl_do` date DEFAULT NULL,
  `no_do` varchar(60) DEFAULT NULL,
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT NULL,
  `tgl_masuk` date DEFAULT NULL,
  `wkt_masuk` time DEFAULT NULL,
  `tgl_keluar` date DEFAULT NULL,
  `wkt_keluar` time DEFAULT NULL,
  `no_kendaraan` varchar(60) DEFAULT NULL,
  `transporter` varchar(60) DEFAULT NULL,
  `jns_kontrak` char(1) DEFAULT '0',
  `id_kontrak` int(11) DEFAULT NULL,
  `pembeli` varchar(60) DEFAULT NULL,
  `alamat_pembeli` varchar(255) DEFAULT NULL,
  `npwp` varchar(30) DEFAULT NULL,
  `commodity_type` char(1) DEFAULT NULL,
  `bruto` decimal(36,2) DEFAULT NULL,
  `tarra` decimal(36,2) DEFAULT NULL,
  `netto_1` decimal(36,2) DEFAULT NULL,
  `potongan` float(11,2) DEFAULT NULL,
  `netto_2` decimal(36,2) DEFAULT NULL,
  `id_satuan` int(11) DEFAULT NULL,
  `harga` decimal(36,2) DEFAULT NULL,
  `total` decimal(36,2) DEFAULT NULL,
  `ffa` float(11,2) DEFAULT NULL,
  `moist` float(11,2) DEFAULT NULL,
  `dirt` float(11,2) DEFAULT NULL,
  `no_segel` varchar(60) DEFAULT NULL,
  `status` char(1) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbt_commodity_transaction
-- ----------------------------
INSERT INTO `tbt_commodity_transaction` VALUES ('1', 'COM/2017/06/00001', '2017-06-09', '00001/PT.SH/DO-CPO/VI/2017', '2017-06-09', '14:25:14', '2017-06-09', '12:54:00', '2017-06-09', '14:54:00', 'B 2346 HY', 'CV SINAR JAYA', '1', '6', 'CV SINAR JAYA', 'ghghhsgdfgdf', '354345', '0', '44340.00', '13770.00', '30570.00', '0.00', '30570.00', '12', '3000.00', '91710000.00', '2.74', '0.17', '0.02', '011573-011576', '1', '0');

-- ----------------------------
-- Table structure for tbt_contract_sales
-- ----------------------------
DROP TABLE IF EXISTS `tbt_contract_sales`;
CREATE TABLE `tbt_contract_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) DEFAULT '0',
  `sales_no` varchar(60) DEFAULT NULL,
  `commodity_type` int(11) DEFAULT '0',
  `id_pembeli` varchar(60) DEFAULT NULL,
  `alamat_pembeli` varchar(255) DEFAULT NULL,
  `npwp` varchar(30) DEFAULT NULL,
  `tgl_kontrak` date DEFAULT NULL,
  `tgl_jatuh_tempo` date DEFAULT NULL,
  `quantity` decimal(36,2) DEFAULT NULL,
  `delivered_quantity` decimal(36,2) DEFAULT '0.00',
  `satuan_commodity` int(11) DEFAULT NULL,
  `quality` text,
  `pricing` decimal(36,2) DEFAULT NULL,
  `delivery` varchar(200) DEFAULT NULL,
  `term_of_payment` text,
  `remark` text,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_contract_sales
-- ----------------------------
INSERT INTO `tbt_contract_sales` VALUES ('1', '3', '00001/PT.SH/PK/V/2017', '1', 'PEMBELI 1', null, null, '2017-05-07', null, '1500.00', '0.00', '12', 'test', '14500.00', 'test', 'test', 'test', '0');
INSERT INTO `tbt_contract_sales` VALUES ('2', '4', '00002/PT.SH/PK/V/2017', '1', 'PEMBELI 2', null, null, '2017-05-19', null, '1000.00', '0.00', '12', 'Moisture 8% max,  Impruties 8% max', '6180.00', 'Setelah kontrak disepakati', 'Transfer Bank ke rekening PT. SINAR HALOMOAN', 'tes', '0');
INSERT INTO `tbt_contract_sales` VALUES ('3', '1', '00001/PT.SH/FIB/VI/2017', '2', 'DENI UDENG', 'Jl. Sastra No 36a/35a ', '45456', '2017-06-06', null, '2000.00', '0.00', '12', 'Test', '5000.00', 'Test', 'Test', 'Test', '0');
INSERT INTO `tbt_contract_sales` VALUES ('6', '4', '00001/PT.SH/CPO/VI/2017', '0', 'CV SINAR JAYA', 'ghghhsgdfgdf', '354345', '2017-06-09', null, '30570.00', '30570.00', '12', '', '2000.00', '', '', '3', '0');

-- ----------------------------
-- Table structure for tbt_expense_karyawan
-- ----------------------------
DROP TABLE IF EXISTS `tbt_expense_karyawan`;
CREATE TABLE `tbt_expense_karyawan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_karyawan` int(11) DEFAULT NULL,
  `tgl` date DEFAULT NULL,
  `jns_expense` char(1) DEFAULT NULL,
  `jml_expense` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbt_expense_karyawan
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_expense_transaction
-- ----------------------------
DROP TABLE IF EXISTS `tbt_expense_transaction`;
CREATE TABLE `tbt_expense_transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_no` varchar(60) DEFAULT NULL,
  `tgl_transaksi` date DEFAULT NULL,
  `no_referensi` varchar(60) DEFAULT NULL,
  `expense_category_id` int(11) DEFAULT NULL,
  `expense_id` int(11) DEFAULT NULL,
  `deskripsi` varchar(100) DEFAULT NULL,
  `coa_id` int(11) DEFAULT NULL,
  `bank_id` int(11) DEFAULT NULL,
  `total_expense` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbt_expense_transaction
-- ----------------------------
INSERT INTO `tbt_expense_transaction` VALUES ('1', 'EXP/2017/05/00001', '2017-05-03', '32342', '1', '1', 'Biaya Sewa Kendaraan', '332', '3', '1300000.00', '1');
INSERT INTO `tbt_expense_transaction` VALUES ('2', 'EXP/2017/05/00002', '2017-05-03', '456363', '1', '2', 'Beban Telepon & Listrik', '243', '3', '351900.00', '0');
INSERT INTO `tbt_expense_transaction` VALUES ('3', 'EXP/2017/05/00003', '2017-05-24', 'R334356', '1', '2', 'pembelian pupuk urea', '640', '3', '200000.00', '0');

-- ----------------------------
-- Table structure for tbt_harga_tbs_order
-- ----------------------------
DROP TABLE IF EXISTS `tbt_harga_tbs_order`;
CREATE TABLE `tbt_harga_tbs_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tgl_transaksi` date DEFAULT NULL,
  `id_barang` int(11) DEFAULT NULL,
  `id_komidel` int(11) DEFAULT NULL,
  `id_kategori_harga` int(11) DEFAULT NULL,
  `harga` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_harga_tbs_order
-- ----------------------------
INSERT INTO `tbt_harga_tbs_order` VALUES ('1', '2017-05-09', '9', '1', '1', '1500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('2', '2017-05-09', '9', '2', '1', '2000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('3', '2017-05-09', '9', '3', '1', '2500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('4', '2017-05-09', '9', '4', '1', '3000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('5', '2017-05-09', '9', '1', '2', '3500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('6', '2017-05-09', '9', '2', '2', '4000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('7', '2017-05-09', '9', '3', '2', '4500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('8', '2017-05-09', '9', '4', '2', '5000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('9', '2017-05-22', '1021', '1', '1', '1350.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('10', '2017-05-22', '1021', '2', '1', '1350.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('11', '2017-05-22', '1021', '3', '1', '1450.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('12', '2017-05-22', '1021', '4', '1', '1550.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('13', '2017-05-22', '1021', '1', '2', '1250.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('14', '2017-05-22', '1021', '2', '2', '1350.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('15', '2017-05-22', '1021', '3', '2', '1450.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('16', '2017-05-22', '1021', '4', '2', '1450.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('17', '2017-05-22', '1021', '1', '3', '1350.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('18', '2017-05-22', '1021', '2', '3', '1250.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('19', '2017-05-22', '1021', '3', '3', '1450.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('20', '2017-05-22', '1021', '4', '3', '1450.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('21', '2017-05-23', '1020', '1', '1', '1300.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('22', '2017-05-23', '1020', '2', '1', '1350.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('23', '2017-05-23', '1020', '3', '1', '1400.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('24', '2017-05-23', '1020', '4', '1', '1450.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('25', '2017-05-23', '1020', '1', '2', '1350.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('26', '2017-05-23', '1020', '2', '2', '1300.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('27', '2017-05-23', '1020', '3', '2', '1350.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('28', '2017-05-23', '1020', '4', '2', '1400.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('29', '2017-05-23', '1020', '1', '3', '1300.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('30', '2017-05-23', '1020', '2', '3', '1350.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('31', '2017-05-23', '1020', '3', '3', '1400.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('32', '2017-05-23', '1020', '4', '3', '1450.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('33', '2017-05-23', '1021', '1', '1', '1700.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('34', '2017-05-23', '1021', '2', '1', '1700.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('35', '2017-05-23', '1021', '3', '1', '1720.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('36', '2017-05-23', '1021', '4', '1', '1730.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('37', '2017-05-23', '1021', '1', '2', '1775.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('38', '2017-05-23', '1021', '2', '2', '1350.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('39', '2017-05-23', '1021', '3', '2', '1795.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('40', '2017-05-23', '1021', '4', '2', '1805.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('41', '2017-05-23', '1021', '1', '3', '1810.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('42', '2017-05-23', '1021', '2', '3', '1810.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('43', '2017-05-23', '1021', '3', '3', '1830.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('44', '2017-05-23', '1021', '4', '3', '1840.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('45', '2017-06-03', '1021', '1', '1', '1500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('46', '2017-06-03', '1021', '2', '1', '2000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('47', '2017-06-03', '1021', '3', '1', '2500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('48', '2017-06-03', '1021', '4', '1', '3000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('49', '2017-06-03', '1021', '1', '2', '3500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('50', '2017-06-03', '1021', '2', '2', '4000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('51', '2017-06-03', '1021', '3', '2', '4500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('52', '2017-06-03', '1021', '4', '2', '5000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('53', '2017-06-03', '1021', '1', '3', '5500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('54', '2017-06-03', '1021', '2', '3', '6000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('55', '2017-06-03', '1021', '3', '3', '6500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('56', '2017-06-03', '1021', '4', '3', '7000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('57', '2017-06-03', '1020', '1', '1', '3500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('58', '2017-06-03', '1020', '2', '1', '4000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('59', '2017-06-03', '1020', '3', '1', '4500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('60', '2017-06-03', '1020', '4', '1', '5000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('61', '2017-06-03', '1020', '1', '2', '5500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('62', '2017-06-03', '1020', '2', '2', '6000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('63', '2017-06-03', '1020', '3', '2', '6500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('64', '2017-06-03', '1020', '4', '2', '7000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('65', '2017-06-03', '1020', '1', '3', '7500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('66', '2017-06-03', '1020', '2', '3', '8000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('67', '2017-06-03', '1020', '3', '3', '8500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('68', '2017-06-03', '1020', '4', '3', '9000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('69', '2017-05-30', '1021', '1', '1', '1500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('70', '2017-05-30', '1021', '2', '1', '2000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('71', '2017-05-30', '1021', '3', '1', '2500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('72', '2017-05-30', '1021', '4', '1', '3000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('73', '2017-05-30', '1021', '1', '2', '3500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('74', '2017-05-30', '1021', '2', '2', '4000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('75', '2017-05-30', '1021', '3', '2', '4500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('76', '2017-05-30', '1021', '4', '2', '5000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('77', '2017-05-30', '1021', '1', '3', '5500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('78', '2017-05-30', '1021', '2', '3', '6000.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('79', '2017-05-30', '1021', '3', '3', '6500.00', '0');
INSERT INTO `tbt_harga_tbs_order` VALUES ('80', '2017-05-30', '1021', '4', '3', '7000.00', '0');

-- ----------------------------
-- Table structure for tbt_incentive
-- ----------------------------
DROP TABLE IF EXISTS `tbt_incentive`;
CREATE TABLE `tbt_incentive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_karyawan` int(11) DEFAULT NULL,
  `bulan` char(2) DEFAULT NULL,
  `tahun` char(4) DEFAULT NULL,
  `jml_incentive` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbt_incentive
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_jurnal_buku_besar
-- ----------------------------
DROP TABLE IF EXISTS `tbt_jurnal_buku_besar`;
CREATE TABLE `tbt_jurnal_buku_besar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) DEFAULT NULL,
  `id_bank` int(11) DEFAULT NULL,
  `sumber_transaksi` char(1) DEFAULT '0',
  `jns_transaksi` char(1) DEFAULT '0',
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT '00:00:00',
  `no_transaksi` varchar(60) DEFAULT NULL,
  `id_coa` int(11) DEFAULT NULL,
  `keterangan` varchar(80) DEFAULT NULL,
  `saldo_awal` float(11,2) DEFAULT NULL,
  `saldo_transaksi` float(11,2) DEFAULT NULL,
  `saldo_akhir` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_jurnal_buku_besar
-- ----------------------------
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('1', '1', '3', '5', '0', '2017-05-01', '14:24:53', 'REV/2017/05/00001', '361', 'Modal Awal', '0.00', '100000000.00', '100000000.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('2', '2', '3', '5', '0', '2017-05-01', '14:25:40', 'REV/2017/05/00002', '786', 'Pendapatan Jasa Lain-lain', '100000000.00', '3250000.00', '103250000.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('3', '3', '3', '5', '0', '2017-05-01', '14:26:54', 'REV/2017/05/00003', '845', 'Setoran Modal ', '103250000.00', '25000000.00', '128250000.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('4', '1', '3', '4', '1', '2017-05-03', '14:33:37', 'EXP/2017/05/00001', '332', 'Biaya Sewa Kendaraan', '128250000.00', '1300000.00', '126950000.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('5', '2', '3', '4', '1', '2017-05-03', '14:40:16', 'EXP/2017/05/00002', '243', 'Beban Telepon & Listrik', '126950000.00', '351900.00', '126598096.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('6', '1', '3', '1', '1', '2017-05-09', '15:10:01', 'PO-PAY/2017/05/00001', '786', 'Pembayaran PO No PO/2017/05/00001 Kepada SANTOS JAYA ABADI', '126598096.00', '15000000.00', '111598096.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('7', '2', '3', '1', '1', '2017-05-09', '15:11:16', 'PO-PAY/2017/05/00002', '786', 'Pembayaran PO No PO/2017/05/00001 Kepada SANTOS JAYA ABADI', '111598096.00', '17730000.00', '93868096.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('8', '1', '2', '2', '1', '2017-05-09', '15:16:57', 'PAY/2017/05/00001', '786', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00001 Kepada SANTOS JAYA ABADI', '0.00', '21417260.00', '-21417260.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('9', '1', '3', '3', '0', '2017-05-09', '15:21:51', '00001/PT.SH/PK/V/2017', '786', 'Penerimaan Pembayaran Kontrak Penjualan Dari INDADI UTAMA SDN BHD', '93868096.00', '21750000.00', '115618096.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('10', '2', '4', '2', '1', '2017-05-23', '04:21:44', 'PAY/2017/05/00002', '508', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00003 Kepada UD. Rizki', '0.00', '11170870.00', '-11170870.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('11', '3', '4', '2', '1', '2017-05-23', '04:21:45', 'PAY/2017/05/00003', '508', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00005 Kepada UD. Rizki', '-11170870.00', '10171410.00', '-21342280.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('12', '4', '4', '2', '1', '2017-05-23', '04:21:45', 'PAY/2017/05/00004', '508', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00007 Kepada UD. Rizki', '-21342280.00', '1000000.00', '-22342280.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('13', '5', '8', '2', '1', '2017-05-23', '05:14:41', 'PAY/2017/05/00005', '758', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00004 Kepada CV. Berkah Mandiri', '0.00', '4929617.50', '-4929617.50', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('14', '3', '8', '1', '1', '2017-05-23', '06:15:30', 'PO-PAY/2017/05/00003', '217', 'Pembayaran PO No PO/2017/05/00002 Kepada ASM', '-4929617.50', '500000.00', '-5429617.50', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('15', '6', '8', '2', '1', '2017-05-23', '09:47:00', 'PAY/2017/05/00006', '508', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00006 Kepada Zio', '-5429617.50', '5337150.00', '-10766768.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('16', '7', '8', '2', '1', '2017-05-23', '09:47:00', 'PAY/2017/05/00007', '508', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00008 Kepada Zio', '-10766768.00', '761249984.00', '-772016768.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('17', '3', '3', '4', '1', '2017-05-24', '07:29:55', 'EXP/2017/05/00003', '640', 'pembelian pupuk urea', '115618096.00', '200000.00', '115418096.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('18', '8', '4', '2', '1', '2017-05-26', '10:30:54', 'PAY/2017/05/00008', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00011 Kepada CV. Berkah Mandiri', '-22342280.00', '7233490.00', '-29575770.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('19', '9', '4', '2', '1', '2017-05-26', '10:30:55', 'PAY/2017/05/00009', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00024 Kepada CV. Berkah Mandiri', '-29575770.00', '7823979.00', '-37399748.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('20', '10', '4', '2', '1', '2017-05-26', '10:30:55', 'PAY/2017/05/00010', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00027 Kepada CV. Berkah Mandiri', '-37399748.00', '2716556.25', '-40116304.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('21', '11', '4', '2', '1', '2017-05-26', '10:30:55', 'PAY/2017/05/00011', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00028 Kepada CV. Berkah Mandiri', '-40116304.00', '3816741.50', '-43933044.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('22', '12', '4', '2', '1', '2017-05-26', '10:30:56', 'PAY/2017/05/00012', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00034 Kepada CV. Berkah Mandiri', '-43933044.00', '7986824.00', '-51919868.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('23', '13', '4', '2', '1', '2017-05-26', '10:30:56', 'PAY/2017/05/00013', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00043 Kepada CV. Berkah Mandiri', '-51919868.00', '4842623.50', '-56762492.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('24', '14', '4', '2', '1', '2017-05-26', '10:32:58', 'PAY/2017/05/00014', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00012 Kepada UD. Rizki', '-56762492.00', '11130240.00', '-67892736.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('25', '15', '4', '2', '1', '2017-05-26', '10:32:59', 'PAY/2017/05/00015', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00016 Kepada UD. Rizki', '-67892736.00', '11777520.00', '-79670256.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('26', '16', '4', '2', '1', '2017-05-26', '10:32:59', 'PAY/2017/05/00016', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00045 Kepada UD. Rizki', '-79670256.00', '-75722800.00', '-3947456.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('27', '17', '8', '2', '1', '2017-05-26', '10:34:09', 'PAY/2017/05/00017', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00013 Kepada Tongku Hasibuan', '-772016768.00', '55821.00', '-772072576.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('28', '18', '8', '2', '1', '2017-05-26', '10:34:09', 'PAY/2017/05/00018', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00019 Kepada Tongku Hasibuan', '-772072576.00', '10580188.00', '-782652736.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('29', '19', '8', '2', '1', '2017-05-26', '10:34:09', 'PAY/2017/05/00019', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00020 Kepada Tongku Hasibuan', '-782652736.00', '8531656.00', '-791184384.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('30', '20', '8', '2', '1', '2017-05-26', '10:34:09', 'PAY/2017/05/00020', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00025 Kepada Tongku Hasibuan', '-791184384.00', '9779844.00', '-800964224.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('31', '21', '8', '2', '1', '2017-05-26', '10:34:10', 'PAY/2017/05/00021', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00026 Kepada Tongku Hasibuan', '-800964224.00', '-32948740.00', '-768015488.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('32', '22', '8', '2', '1', '2017-05-26', '10:34:10', 'PAY/2017/05/00022', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00030 Kepada Tongku Hasibuan', '-768015488.00', '6930606.50', '-774946112.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('33', '23', '8', '2', '1', '2017-05-26', '10:34:10', 'PAY/2017/05/00023', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00031 Kepada Tongku Hasibuan', '-774946112.00', '9235787.00', '-784181888.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('34', '24', '8', '2', '1', '2017-05-26', '10:34:10', 'PAY/2017/05/00024', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00035 Kepada Tongku Hasibuan', '-784181888.00', '2729616.00', '-786911488.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('35', '25', '4', '2', '1', '2017-05-26', '10:37:21', 'PAY/2017/05/00025', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00014 Kepada Zio', '-3947456.00', '8263510.00', '-12210966.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('36', '26', '4', '2', '1', '2017-05-26', '10:37:22', 'PAY/2017/05/00026', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00015 Kepada Zio', '-12210966.00', '9540520.00', '-21751486.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('37', '27', '4', '2', '1', '2017-05-26', '10:37:22', 'PAY/2017/05/00027', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00018 Kepada Zio', '-21751486.00', '6898000.00', '-28649486.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('38', '28', '4', '2', '1', '2017-05-26', '10:37:22', 'PAY/2017/05/00028', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00029 Kepada Zio', '-28649486.00', '5580570.00', '-34230056.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('39', '29', '4', '2', '1', '2017-05-26', '10:37:22', 'PAY/2017/05/00029', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00033 Kepada Zio', '-34230056.00', '9263170.00', '-43493224.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('40', '30', '4', '2', '1', '2017-05-26', '10:37:23', 'PAY/2017/05/00030', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00036 Kepada Zio', '-43493224.00', '9613570.00', '-53106792.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('41', '31', '4', '2', '1', '2017-05-26', '10:37:23', 'PAY/2017/05/00031', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00037 Kepada Zio', '-53106792.00', '7047430.00', '-60154224.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('42', '32', '4', '2', '1', '2017-05-26', '10:37:23', 'PAY/2017/05/00032', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00038 Kepada Zio', '-60154224.00', '7964650.00', '-68118872.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('43', '33', '4', '2', '1', '2017-05-26', '10:37:23', 'PAY/2017/05/00033', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00039 Kepada Zio', '-68118872.00', '3364830.00', '-71483704.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('44', '34', '4', '2', '1', '2017-05-26', '10:37:59', 'PAY/2017/05/00034', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00017 Kepada SHS', '-71483704.00', '11212680.00', '-82696384.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('45', '35', '4', '2', '1', '2017-05-26', '10:37:59', 'PAY/2017/05/00035', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00042 Kepada SHS', '-82696384.00', '10297190.00', '-92993576.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('46', '36', '9', '2', '1', '2017-05-26', '10:44:53', 'PAY/2017/05/00036', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00021 Kepada PT. Sibuah Raya', '0.00', '-94294144.00', '94294144.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('47', '37', '10', '2', '1', '2017-05-27', '04:25:19', 'PAY/2017/05/00037', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00022 Kepada PT. Mujur Usaha Ma', '0.00', '-81130888.00', '81130888.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('48', '38', '10', '2', '1', '2017-05-27', '04:25:19', 'PAY/2017/05/00038', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00023 Kepada PT. Mujur Usaha Ma', '81130888.00', '-69141184.00', '150272064.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('49', '39', '11', '2', '1', '2017-05-27', '04:57:57', 'PAY/2017/05/00039', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00032 Kepada PT. Sinar Halomoan', '0.00', '-87991800.00', '87991800.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('50', '40', '11', '2', '1', '2017-05-27', '04:58:22', 'PAY/2017/05/00040', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00040 Kepada PT. Sinar Halomoan', '87991800.00', '-28874360.00', '116866160.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('51', '41', '13', '2', '1', '2017-05-27', '04:59:41', 'PAY/2017/05/00041', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00041 Kepada Sejahtera Sawit', '0.00', '11578530.00', '-11578530.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('52', '42', '13', '2', '1', '2017-05-27', '05:00:30', 'PAY/2017/05/00042', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00044 Kepada Mandurana', '-11578530.00', '-79910640.00', '68332112.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('53', '43', '13', '2', '1', '2017-05-27', '05:00:46', 'PAY/2017/05/00043', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00046 Kepada PT. Sinar Halomoan', '68332112.00', '-67800000.00', '136132112.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('54', '16', '10', '2', '1', '2017-06-04', '10:22:14', 'PAY/2017/06/00001', '786', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/06/00018 Kepada UD. Mitra Pribadi', '150272064.00', '15000000.00', '135272064.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('55', '17', '8', '2', '1', '2017-06-04', '10:32:59', 'PAY/2017/06/00001', '844', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/06/00018 Kepada UD. Mitra Pribadi', '-786911488.00', '20000000.00', '-806911488.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('56', '18', '8', '2', '1', '2017-06-04', '10:35:17', 'PAY/2017/06/00001', '786', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/06/00018 Kepada UD. Mitra Pribadi', '-806911488.00', '16750000.00', '-823661504.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('57', '19', '8', '2', '1', '2017-06-04', '12:17:29', 'PAY/2017/06/00002', '508', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/06/00018 Kepada UD. Mitra Pribadi', '-823661504.00', '10000000.00', '-833661504.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('58', '20', '8', '2', '1', '2017-06-04', '12:18:06', 'PAY/2017/06/00003', '786', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/06/00018 Kepada UD. Mitra Pribadi', '-833661504.00', '2824080.00', '-836485568.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('59', '21', '9', '2', '1', '2017-06-04', '16:20:48', 'PAY/2017/06/00004', '786', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/06/00017 Kepada UD. Rizki', '94294144.00', '35000000.00', '59294144.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('60', '22', '8', '2', '1', '2017-06-04', '16:25:30', 'PAY/2017/06/00005', '786', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00067 Kepada UD. Rizki', '-836485568.00', '15000000.00', '-851485568.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('61', '23', '8', '2', '1', '2017-06-04', '16:29:45', 'PAY/2017/06/00006', '786', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00069 Kepada PT. Sibuah Raya', '-851485568.00', '10000000.00', '-861485568.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('62', '24', '9', '2', '1', '2017-06-04', '16:30:43', 'PAY/2017/06/00007', '845', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00068 Kepada PT. Mujur Usaha Ma', '59294144.00', '20000000.00', '39294144.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('63', '1', '8', '3', '0', '2017-06-06', '12:28:01', 'COM/2017/06/00001', '786', 'Penerimaan Pembayaran Penjualan Dari DENI UDENG', '-861485568.00', '20000000.00', '-841485568.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('64', '2', '9', '3', '0', '2017-06-06', '12:29:14', 'COM/2017/06/00001', '786', 'Penerimaan Pembayaran Penjualan Dari DENI UDENG', '39294144.00', '5000000.00', '44294144.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('65', '3', '9', '3', '0', '2017-06-06', '12:35:09', 'COM/2017/06/00001', '845', 'Penerimaan Pembayaran Penjualan Dari DENI UDENG', '44294144.00', '2750111.00', '47044256.00', '0');
INSERT INTO `tbt_jurnal_buku_besar` VALUES ('66', '1', '9', '3', '0', '2017-06-09', '14:42:37', 'COM/2017/06/00001', '844', 'Penerimaan Pembayaran Penjualan Dari CV SINAR JAYA', '47044256.00', '50000000.00', '97044256.00', '0');

-- ----------------------------
-- Table structure for tbt_jurnal_umum
-- ----------------------------
DROP TABLE IF EXISTS `tbt_jurnal_umum`;
CREATE TABLE `tbt_jurnal_umum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) DEFAULT NULL,
  `sumber_transaksi` char(1) DEFAULT '0',
  `jns_transaksi` char(1) DEFAULT '0',
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT '00:00:00',
  `no_transaksi` varchar(60) DEFAULT NULL,
  `keterangan` varchar(80) DEFAULT NULL,
  `jumlah_saldo` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=153 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_jurnal_umum
-- ----------------------------
INSERT INTO `tbt_jurnal_umum` VALUES ('1', '3', '6', '0', '2017-05-01', '14:26:54', 'REV/2017/05/00003', 'Kas', '128250000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('2', '1', '6', '1', '2017-05-01', '14:24:54', 'REV/2017/05/00001', 'Modal Awal', '100000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('3', '2', '6', '1', '2017-05-01', '14:25:40', 'REV/2017/05/00002', 'Pendapatan Jasa Lain-lain', '3250000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('4', '3', '6', '1', '2017-05-01', '14:26:54', 'REV/2017/05/00003', 'Setoran Modal ', '25000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('5', '1', '7', '0', '2017-05-03', '14:33:37', 'EXP/2017/05/00001', 'Biaya Sewa Kendaraan', '1300000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('6', '2', '7', '1', '2017-05-03', '14:40:16', 'EXP/2017/05/00002', 'Kas', '1651900.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('7', '2', '7', '0', '2017-05-03', '14:40:16', 'EXP/2017/05/00002', 'Beban Telepon & Listrik', '351900.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('8', '1', '8', '0', '2017-05-09', '15:01:52', 'PO/2017/05/00001', 'Uang Muka Pembelian', '5000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('9', '1', '3', '1', '2017-05-09', '15:16:57', 'PAY/2017/05/00001', 'Kas', '59147260.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('10', '1', '3', '0', '2017-05-09', '15:16:57', 'PAY/2017/05/00001', 'Perlengkapan', '55717260.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('11', '3', '1', '1', '2017-05-09', '15:09:09', 'RC/2017/05/00003', 'Hutang', '34300000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('12', '2', '2', '0', '2017-05-09', '15:11:16', 'PO-PAY/2017/05/00002', 'Hutang', '32730000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('13', '1', '4', '0', '2017-05-09', '15:21:00', '00001/PT.SH/PK/V/2017', 'Piutang', '21750000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('14', '1', '4', '1', '2017-05-09', '15:21:00', '00001/PT.SH/PK/V/2017', 'Pendapatan', '21750000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('15', '1', '5', '0', '2017-05-09', '15:21:51', '00001/PT.SH/PK/V/2017', 'Kas', '21750000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('16', '1', '5', '1', '2017-05-09', '15:21:51', '00001/PT.SH/PK/V/2017', 'Piutang', '21750000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('17', '2', '3', '0', '2017-05-23', '04:21:44', 'PAY/2017/05/00002', 'Perlengkapan', '11170870.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('18', '2', '3', '1', '2017-05-23', '04:21:44', 'PAY/2017/05/00002', 'Kas', '11170870.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('19', '3', '3', '0', '2017-05-23', '04:21:45', 'PAY/2017/05/00003', 'Perlengkapan', '10171410.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('20', '3', '3', '1', '2017-05-23', '04:21:45', 'PAY/2017/05/00003', 'Kas', '10171410.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('21', '4', '3', '0', '2017-05-23', '04:21:45', 'PAY/2017/05/00004', 'Perlengkapan', '1000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('22', '4', '3', '1', '2017-05-23', '04:21:45', 'PAY/2017/05/00004', 'Kas', '1000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('23', '5', '3', '0', '2017-05-23', '05:14:41', 'PAY/2017/05/00005', 'Perlengkapan', '4929617.50', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('24', '5', '3', '1', '2017-05-23', '05:14:41', 'PAY/2017/05/00005', 'Kas', '4929617.50', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('25', '2', '8', '0', '2017-05-23', '05:41:11', 'PO/2017/05/00002', 'Uang Muka Pembelian', '500000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('26', '2', '8', '1', '2017-05-23', '05:41:11', 'PO/2017/05/00002', 'Kas', '500000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('27', '4', '1', '0', '2017-05-23', '05:49:24', 'RC/2017/05/00004', 'Perlengkapan', '8000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('28', '4', '1', '1', '2017-05-23', '05:49:24', 'RC/2017/05/00004', 'Hutang', '8000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('29', '3', '2', '0', '2017-05-23', '06:15:30', 'PO-PAY/2017/05/00003', 'Hutang', '500000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('30', '3', '2', '1', '2017-05-23', '06:15:30', 'PO-PAY/2017/05/00003', 'Kas', '500000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('31', '6', '3', '0', '2017-05-23', '09:47:00', 'PAY/2017/05/00006', 'Perlengkapan', '5337150.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('32', '6', '3', '1', '2017-05-23', '09:47:00', 'PAY/2017/05/00006', 'Kas', '5337150.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('33', '7', '3', '0', '2017-05-23', '09:47:00', 'PAY/2017/05/00007', 'Perlengkapan', '761249984.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('34', '7', '3', '1', '2017-05-23', '09:47:00', 'PAY/2017/05/00007', 'Kas', '761249984.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('35', '3', '7', '0', '2017-05-24', '07:29:56', 'EXP/2017/05/00003', 'pembelian pupuk urea', '200000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('36', '3', '7', '1', '2017-05-24', '07:29:56', 'EXP/2017/05/00003', 'Kas', '200000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('37', '2', '4', '0', '2017-05-24', '09:46:17', '00002/PT.SH/PK/V/2017', 'Piutang', '618000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('38', '2', '4', '1', '2017-05-24', '09:46:17', '00002/PT.SH/PK/V/2017', 'Pendapatan', '618000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('39', '2', '4', '0', '2017-05-24', '10:02:18', '00002/PT.SH/PK/V/2017', 'Piutang', '6180000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('40', '2', '4', '1', '2017-05-24', '10:02:18', '00002/PT.SH/PK/V/2017', 'Pendapatan', '6180000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('41', '5', '1', '0', '2017-05-24', '11:06:55', 'RC/2017/05/00005', 'Perlengkapan', '7960000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('42', '5', '1', '1', '2017-05-24', '11:06:55', 'RC/2017/05/00005', 'Hutang', '7960000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('43', '8', '3', '0', '2017-05-26', '10:30:55', 'PAY/2017/05/00008', 'Perlengkapan', '7233490.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('44', '8', '3', '1', '2017-05-26', '10:30:55', 'PAY/2017/05/00008', 'Kas', '7233490.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('45', '9', '3', '0', '2017-05-26', '10:30:55', 'PAY/2017/05/00009', 'Perlengkapan', '7823979.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('46', '9', '3', '1', '2017-05-26', '10:30:55', 'PAY/2017/05/00009', 'Kas', '7823979.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('47', '10', '3', '0', '2017-05-26', '10:30:55', 'PAY/2017/05/00010', 'Perlengkapan', '2716556.25', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('48', '10', '3', '1', '2017-05-26', '10:30:55', 'PAY/2017/05/00010', 'Kas', '2716556.25', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('49', '11', '3', '0', '2017-05-26', '10:30:55', 'PAY/2017/05/00011', 'Perlengkapan', '3816741.50', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('50', '11', '3', '1', '2017-05-26', '10:30:55', 'PAY/2017/05/00011', 'Kas', '3816741.50', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('51', '12', '3', '0', '2017-05-26', '10:30:56', 'PAY/2017/05/00012', 'Perlengkapan', '7986824.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('52', '12', '3', '1', '2017-05-26', '10:30:56', 'PAY/2017/05/00012', 'Kas', '7986824.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('53', '13', '3', '0', '2017-05-26', '10:30:56', 'PAY/2017/05/00013', 'Perlengkapan', '4842623.50', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('54', '13', '3', '1', '2017-05-26', '10:30:56', 'PAY/2017/05/00013', 'Kas', '4842623.50', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('55', '14', '3', '0', '2017-05-26', '10:32:59', 'PAY/2017/05/00014', 'Perlengkapan', '11130240.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('56', '14', '3', '1', '2017-05-26', '10:32:59', 'PAY/2017/05/00014', 'Kas', '11130240.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('57', '15', '3', '0', '2017-05-26', '10:32:59', 'PAY/2017/05/00015', 'Perlengkapan', '11777520.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('58', '15', '3', '1', '2017-05-26', '10:32:59', 'PAY/2017/05/00015', 'Kas', '11777520.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('59', '16', '3', '0', '2017-05-26', '10:32:59', 'PAY/2017/05/00016', 'Perlengkapan', '-75722800.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('60', '16', '3', '1', '2017-05-26', '10:32:59', 'PAY/2017/05/00016', 'Kas', '-75722800.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('61', '17', '3', '0', '2017-05-26', '10:34:09', 'PAY/2017/05/00017', 'Perlengkapan', '55821.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('62', '17', '3', '1', '2017-05-26', '10:34:09', 'PAY/2017/05/00017', 'Kas', '55821.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('63', '18', '3', '0', '2017-05-26', '10:34:09', 'PAY/2017/05/00018', 'Perlengkapan', '10580188.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('64', '18', '3', '1', '2017-05-26', '10:34:09', 'PAY/2017/05/00018', 'Kas', '10580188.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('65', '19', '3', '0', '2017-05-26', '10:34:09', 'PAY/2017/05/00019', 'Perlengkapan', '8531656.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('66', '19', '3', '1', '2017-05-26', '10:34:09', 'PAY/2017/05/00019', 'Kas', '8531656.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('67', '20', '3', '0', '2017-05-26', '10:34:09', 'PAY/2017/05/00020', 'Perlengkapan', '9779844.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('68', '20', '3', '1', '2017-05-26', '10:34:09', 'PAY/2017/05/00020', 'Kas', '9779844.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('69', '21', '3', '0', '2017-05-26', '10:34:10', 'PAY/2017/05/00021', 'Perlengkapan', '-32948740.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('70', '21', '3', '1', '2017-05-26', '10:34:10', 'PAY/2017/05/00021', 'Kas', '-32948740.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('71', '22', '3', '0', '2017-05-26', '10:34:10', 'PAY/2017/05/00022', 'Perlengkapan', '6930606.50', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('72', '22', '3', '1', '2017-05-26', '10:34:10', 'PAY/2017/05/00022', 'Kas', '6930606.50', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('73', '23', '3', '0', '2017-05-26', '10:34:10', 'PAY/2017/05/00023', 'Perlengkapan', '9235787.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('74', '23', '3', '1', '2017-05-26', '10:34:10', 'PAY/2017/05/00023', 'Kas', '9235787.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('75', '24', '3', '0', '2017-05-26', '10:34:10', 'PAY/2017/05/00024', 'Perlengkapan', '2729616.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('76', '24', '3', '1', '2017-05-26', '10:34:10', 'PAY/2017/05/00024', 'Kas', '2729616.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('77', '25', '3', '0', '2017-05-26', '10:37:22', 'PAY/2017/05/00025', 'Perlengkapan', '8263510.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('78', '25', '3', '1', '2017-05-26', '10:37:22', 'PAY/2017/05/00025', 'Kas', '8263510.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('79', '26', '3', '0', '2017-05-26', '10:37:22', 'PAY/2017/05/00026', 'Perlengkapan', '9540520.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('80', '26', '3', '1', '2017-05-26', '10:37:22', 'PAY/2017/05/00026', 'Kas', '9540520.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('81', '27', '3', '0', '2017-05-26', '10:37:22', 'PAY/2017/05/00027', 'Perlengkapan', '6898000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('82', '27', '3', '1', '2017-05-26', '10:37:22', 'PAY/2017/05/00027', 'Kas', '6898000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('83', '28', '3', '0', '2017-05-26', '10:37:22', 'PAY/2017/05/00028', 'Perlengkapan', '5580570.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('84', '28', '3', '1', '2017-05-26', '10:37:22', 'PAY/2017/05/00028', 'Kas', '5580570.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('85', '29', '3', '0', '2017-05-26', '10:37:23', 'PAY/2017/05/00029', 'Perlengkapan', '9263170.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('86', '29', '3', '1', '2017-05-26', '10:37:23', 'PAY/2017/05/00029', 'Kas', '9263170.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('87', '30', '3', '0', '2017-05-26', '10:37:23', 'PAY/2017/05/00030', 'Perlengkapan', '9613570.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('88', '30', '3', '1', '2017-05-26', '10:37:23', 'PAY/2017/05/00030', 'Kas', '9613570.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('89', '31', '3', '0', '2017-05-26', '10:37:23', 'PAY/2017/05/00031', 'Perlengkapan', '7047430.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('90', '31', '3', '1', '2017-05-26', '10:37:23', 'PAY/2017/05/00031', 'Kas', '7047430.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('91', '32', '3', '0', '2017-05-26', '10:37:23', 'PAY/2017/05/00032', 'Perlengkapan', '7964650.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('92', '32', '3', '1', '2017-05-26', '10:37:23', 'PAY/2017/05/00032', 'Kas', '7964650.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('93', '33', '3', '0', '2017-05-26', '10:37:23', 'PAY/2017/05/00033', 'Perlengkapan', '3364830.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('94', '33', '3', '1', '2017-05-26', '10:37:24', 'PAY/2017/05/00033', 'Kas', '3364830.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('95', '34', '3', '0', '2017-05-26', '10:37:59', 'PAY/2017/05/00034', 'Perlengkapan', '11212680.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('96', '34', '3', '1', '2017-05-26', '10:37:59', 'PAY/2017/05/00034', 'Kas', '11212680.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('97', '35', '3', '0', '2017-05-26', '10:37:59', 'PAY/2017/05/00035', 'Perlengkapan', '10297190.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('98', '35', '3', '1', '2017-05-26', '10:37:59', 'PAY/2017/05/00035', 'Kas', '10297190.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('99', '36', '3', '0', '2017-05-26', '10:44:53', 'PAY/2017/05/00036', 'Perlengkapan', '-94294144.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('100', '36', '3', '1', '2017-05-26', '10:44:53', 'PAY/2017/05/00036', 'Kas', '-94294144.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('101', '37', '3', '0', '2017-05-27', '04:25:19', 'PAY/2017/05/00037', 'Perlengkapan', '-81130888.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('102', '37', '3', '1', '2017-05-27', '04:25:19', 'PAY/2017/05/00037', 'Kas', '-81130888.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('103', '38', '3', '0', '2017-05-27', '04:25:19', 'PAY/2017/05/00038', 'Perlengkapan', '-69141184.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('104', '38', '3', '1', '2017-05-27', '04:25:19', 'PAY/2017/05/00038', 'Kas', '-69141184.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('105', '39', '3', '0', '2017-05-27', '04:57:57', 'PAY/2017/05/00039', 'Perlengkapan', '-87991800.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('106', '39', '3', '1', '2017-05-27', '04:57:57', 'PAY/2017/05/00039', 'Kas', '-87991800.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('107', '40', '3', '0', '2017-05-27', '04:58:22', 'PAY/2017/05/00040', 'Perlengkapan', '-28874360.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('108', '40', '3', '1', '2017-05-27', '04:58:22', 'PAY/2017/05/00040', 'Kas', '-28874360.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('109', '41', '3', '0', '2017-05-27', '04:59:41', 'PAY/2017/05/00041', 'Perlengkapan', '11578530.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('110', '41', '3', '1', '2017-05-27', '04:59:41', 'PAY/2017/05/00041', 'Kas', '11578530.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('111', '42', '3', '0', '2017-05-27', '05:00:30', 'PAY/2017/05/00042', 'Perlengkapan', '-79910640.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('112', '42', '3', '1', '2017-05-27', '05:00:30', 'PAY/2017/05/00042', 'Kas', '-79910640.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('113', '43', '3', '0', '2017-05-27', '05:00:46', 'PAY/2017/05/00043', 'Perlengkapan', '-67800000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('114', '43', '3', '1', '2017-05-27', '05:00:46', 'PAY/2017/05/00043', 'Kas', '-67800000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('115', '6', '1', '0', '2017-06-02', '06:34:18', 'RC/2017/06/00001', 'Perlengkapan', '17200000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('116', '6', '1', '1', '2017-06-02', '06:34:18', 'RC/2017/06/00001', 'Hutang', '17200000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('117', '16', '3', '0', '2017-06-04', '10:22:14', 'PAY/2017/06/00001', 'Perlengkapan', '15000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('118', '16', '3', '1', '2017-06-04', '10:22:14', 'PAY/2017/06/00001', 'Kas', '15000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('119', '17', '3', '0', '2017-06-04', '10:32:59', 'PAY/2017/06/00001', 'Perlengkapan', '20000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('120', '17', '3', '1', '2017-06-04', '10:32:59', 'PAY/2017/06/00001', 'Kas', '20000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('121', '18', '3', '0', '2017-06-04', '10:35:17', 'PAY/2017/06/00001', 'Perlengkapan', '16750000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('122', '18', '3', '1', '2017-06-04', '10:35:18', 'PAY/2017/06/00001', 'Kas', '16750000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('123', '19', '3', '0', '2017-06-04', '12:17:29', 'PAY/2017/06/00002', 'Perlengkapan', '10000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('124', '19', '3', '1', '2017-06-04', '12:17:29', 'PAY/2017/06/00002', 'Kas', '10000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('125', '20', '3', '0', '2017-06-04', '12:18:06', 'PAY/2017/06/00003', 'Perlengkapan', '2824080.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('126', '20', '3', '1', '2017-06-04', '12:18:06', 'PAY/2017/06/00003', 'Kas', '2824080.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('127', '21', '3', '0', '2017-06-04', '16:20:48', 'PAY/2017/06/00004', 'Perlengkapan', '35000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('128', '21', '3', '1', '2017-06-04', '16:20:48', 'PAY/2017/06/00004', 'Kas', '35000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('129', '22', '3', '0', '2017-06-04', '16:25:30', 'PAY/2017/06/00005', 'Perlengkapan', '15000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('130', '22', '3', '1', '2017-06-04', '16:25:30', 'PAY/2017/06/00005', 'Kas', '15000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('131', '23', '3', '0', '2017-06-04', '16:29:45', 'PAY/2017/06/00006', 'Perlengkapan', '10000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('132', '23', '3', '1', '2017-06-04', '16:29:45', 'PAY/2017/06/00006', 'Kas', '10000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('133', '24', '3', '0', '2017-06-04', '16:30:43', 'PAY/2017/06/00007', 'Perlengkapan', '20000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('134', '24', '3', '1', '2017-06-04', '16:30:43', 'PAY/2017/06/00007', 'Kas', '20000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('135', '1', '4', '0', '2017-06-06', '11:06:42', 'COM/2017/06/00001', 'Piutang', '30000120.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('136', '1', '4', '1', '2017-06-06', '11:06:42', 'COM/2017/06/00001', 'Pendapatan', '30000120.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('137', '2', '4', '0', '2017-06-06', '11:07:41', 'COM/2017/06/00002', 'Piutang', '31500000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('138', '2', '4', '1', '2017-06-06', '11:07:41', 'COM/2017/06/00002', 'Pendapatan', '31500000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('139', '3', '4', '0', '2017-06-06', '11:14:24', 'COM/2017/06/00003', 'Piutang', '30900000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('140', '3', '4', '1', '2017-06-06', '11:14:24', 'COM/2017/06/00003', 'Pendapatan', '30900000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('141', '1', '5', '0', '2017-06-06', '12:28:01', 'COM/2017/06/00001', 'Kas', '20000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('142', '1', '5', '1', '2017-06-06', '12:28:01', 'COM/2017/06/00001', 'Piutang', '20000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('143', '2', '5', '0', '2017-06-06', '12:29:14', 'COM/2017/06/00001', 'Kas', '5000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('144', '2', '5', '1', '2017-06-06', '12:29:14', 'COM/2017/06/00001', 'Piutang', '5000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('145', '3', '5', '0', '2017-06-06', '12:35:09', 'COM/2017/06/00001', 'Kas', '2750111.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('146', '3', '5', '1', '2017-06-06', '12:35:09', 'COM/2017/06/00001', 'Piutang', '2750111.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('147', '1', '4', '0', '2017-06-09', '14:35:02', 'COM/2017/06/00001', 'Piutang', '91710000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('148', '1', '4', '1', '2017-06-09', '14:35:02', 'COM/2017/06/00001', 'Pendapatan', '91710000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('149', '1', '5', '0', '2017-06-09', '14:42:37', 'COM/2017/06/00001', 'Kas', '50000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('150', '1', '5', '1', '2017-06-09', '14:42:37', 'COM/2017/06/00001', 'Piutang', '50000000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('151', '1', '4', '0', '2017-06-09', '15:21:52', 'COM/2017/06/00001', 'Piutang', '91710000.00', '0');
INSERT INTO `tbt_jurnal_umum` VALUES ('152', '1', '4', '1', '2017-06-09', '15:21:52', 'COM/2017/06/00001', 'Pendapatan', '91710000.00', '0');

-- ----------------------------
-- Table structure for tbt_laba_rugi
-- ----------------------------
DROP TABLE IF EXISTS `tbt_laba_rugi`;
CREATE TABLE `tbt_laba_rugi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) DEFAULT NULL,
  `sumber_transaksi` char(1) DEFAULT '0',
  `jns_transaksi` char(1) DEFAULT '0',
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT '00:00:00',
  `no_transaksi` varchar(60) DEFAULT NULL,
  `keterangan` varchar(80) DEFAULT NULL,
  `jumlah_transaksi` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=67 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_laba_rugi
-- ----------------------------
INSERT INTO `tbt_laba_rugi` VALUES ('1', '1', '5', '0', '2017-05-01', '14:24:53', 'REV/2017/05/00001', 'Modal Awal', '100000000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('2', '2', '5', '0', '2017-05-01', '14:25:40', 'REV/2017/05/00002', 'Pendapatan Jasa Lain-lain', '3250000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('3', '3', '5', '0', '2017-05-01', '14:26:54', 'REV/2017/05/00003', 'Setoran Modal ', '25000000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('4', '1', '4', '1', '2017-05-03', '14:33:37', 'EXP/2017/05/00001', 'Biaya Sewa Kendaraan', '1300000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('5', '2', '4', '1', '2017-05-03', '14:40:16', 'EXP/2017/05/00002', 'Beban Telepon & Listrik', '351900.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('6', '1', '1', '1', '2017-05-09', '15:10:01', 'PO-PAY/2017/05/00001', 'Pembayaran PO No PO/2017/05/00001 Kepada SANTOS JAYA ABADI', '15000000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('7', '2', '1', '1', '2017-05-09', '15:11:16', 'PO-PAY/2017/05/00002', 'Pembayaran PO No PO/2017/05/00001 Kepada SANTOS JAYA ABADI', '17730000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('8', '1', '2', '1', '2017-05-09', '15:16:57', 'PAY/2017/05/00001', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00001 Kepada SANTOS JAYA ABADI', '21417260.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('9', '1', '3', '0', '2017-05-09', '15:21:51', '00001/PT.SH/PK/V/2017', 'Penerimaan Pembayaran Kontrak Penjualan Dari INDADI UTAMA SDN BHD', '21750000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('10', '2', '2', '1', '2017-05-23', '04:21:44', 'PAY/2017/05/00002', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00003 Kepada UD. Rizki', '11170870.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('11', '3', '2', '1', '2017-05-23', '04:21:45', 'PAY/2017/05/00003', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00005 Kepada UD. Rizki', '10171410.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('12', '4', '2', '1', '2017-05-23', '04:21:45', 'PAY/2017/05/00004', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00007 Kepada UD. Rizki', '1000000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('13', '5', '2', '1', '2017-05-23', '05:14:41', 'PAY/2017/05/00005', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00004 Kepada CV. Berkah Mandiri', '4929617.50', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('14', '3', '1', '1', '2017-05-23', '06:15:30', 'PO-PAY/2017/05/00003', 'Pembayaran PO No PO/2017/05/00002 Kepada ASM', '500000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('15', '6', '2', '1', '2017-05-23', '09:47:00', 'PAY/2017/05/00006', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00006 Kepada Zio', '5337150.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('16', '7', '2', '1', '2017-05-23', '09:47:00', 'PAY/2017/05/00007', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00008 Kepada Zio', '761249984.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('17', '3', '4', '1', '2017-05-24', '07:29:56', 'EXP/2017/05/00003', 'pembelian pupuk urea', '200000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('18', '8', '2', '1', '2017-05-26', '10:30:55', 'PAY/2017/05/00008', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00011 Kepada CV. Berkah Mandiri', '7233490.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('19', '9', '2', '1', '2017-05-26', '10:30:55', 'PAY/2017/05/00009', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00024 Kepada CV. Berkah Mandiri', '7823979.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('20', '10', '2', '1', '2017-05-26', '10:30:55', 'PAY/2017/05/00010', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00027 Kepada CV. Berkah Mandiri', '2716556.25', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('21', '11', '2', '1', '2017-05-26', '10:30:55', 'PAY/2017/05/00011', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00028 Kepada CV. Berkah Mandiri', '3816741.50', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('22', '12', '2', '1', '2017-05-26', '10:30:56', 'PAY/2017/05/00012', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00034 Kepada CV. Berkah Mandiri', '7986824.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('23', '13', '2', '1', '2017-05-26', '10:30:56', 'PAY/2017/05/00013', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00043 Kepada CV. Berkah Mandiri', '4842623.50', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('24', '14', '2', '1', '2017-05-26', '10:32:58', 'PAY/2017/05/00014', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00012 Kepada UD. Rizki', '11130240.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('25', '15', '2', '1', '2017-05-26', '10:32:59', 'PAY/2017/05/00015', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00016 Kepada UD. Rizki', '11777520.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('26', '16', '2', '1', '2017-05-26', '10:32:59', 'PAY/2017/05/00016', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00045 Kepada UD. Rizki', '-75722800.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('27', '17', '2', '1', '2017-05-26', '10:34:09', 'PAY/2017/05/00017', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00013 Kepada Tongku Hasibuan', '55821.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('28', '18', '2', '1', '2017-05-26', '10:34:09', 'PAY/2017/05/00018', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00019 Kepada Tongku Hasibuan', '10580188.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('29', '19', '2', '1', '2017-05-26', '10:34:09', 'PAY/2017/05/00019', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00020 Kepada Tongku Hasibuan', '8531656.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('30', '20', '2', '1', '2017-05-26', '10:34:09', 'PAY/2017/05/00020', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00025 Kepada Tongku Hasibuan', '9779844.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('31', '21', '2', '1', '2017-05-26', '10:34:10', 'PAY/2017/05/00021', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00026 Kepada Tongku Hasibuan', '-32948740.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('32', '22', '2', '1', '2017-05-26', '10:34:10', 'PAY/2017/05/00022', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00030 Kepada Tongku Hasibuan', '6930606.50', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('33', '23', '2', '1', '2017-05-26', '10:34:10', 'PAY/2017/05/00023', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00031 Kepada Tongku Hasibuan', '9235787.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('34', '24', '2', '1', '2017-05-26', '10:34:10', 'PAY/2017/05/00024', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00035 Kepada Tongku Hasibuan', '2729616.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('35', '25', '2', '1', '2017-05-26', '10:37:22', 'PAY/2017/05/00025', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00014 Kepada Zio', '8263510.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('36', '26', '2', '1', '2017-05-26', '10:37:22', 'PAY/2017/05/00026', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00015 Kepada Zio', '9540520.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('37', '27', '2', '1', '2017-05-26', '10:37:22', 'PAY/2017/05/00027', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00018 Kepada Zio', '6898000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('38', '28', '2', '1', '2017-05-26', '10:37:22', 'PAY/2017/05/00028', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00029 Kepada Zio', '5580570.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('39', '29', '2', '1', '2017-05-26', '10:37:23', 'PAY/2017/05/00029', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00033 Kepada Zio', '9263170.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('40', '30', '2', '1', '2017-05-26', '10:37:23', 'PAY/2017/05/00030', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00036 Kepada Zio', '9613570.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('41', '31', '2', '1', '2017-05-26', '10:37:23', 'PAY/2017/05/00031', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00037 Kepada Zio', '7047430.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('42', '32', '2', '1', '2017-05-26', '10:37:23', 'PAY/2017/05/00032', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00038 Kepada Zio', '7964650.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('43', '33', '2', '1', '2017-05-26', '10:37:23', 'PAY/2017/05/00033', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00039 Kepada Zio', '3364830.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('44', '34', '2', '1', '2017-05-26', '10:37:59', 'PAY/2017/05/00034', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00017 Kepada SHS', '11212680.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('45', '35', '2', '1', '2017-05-26', '10:37:59', 'PAY/2017/05/00035', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00042 Kepada SHS', '10297190.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('46', '36', '2', '1', '2017-05-26', '10:44:53', 'PAY/2017/05/00036', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00021 Kepada PT. Sibuah Raya', '-94294144.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('47', '37', '2', '1', '2017-05-27', '04:25:19', 'PAY/2017/05/00037', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00022 Kepada PT. Mujur Usaha Ma', '-81130888.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('48', '38', '2', '1', '2017-05-27', '04:25:19', 'PAY/2017/05/00038', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00023 Kepada PT. Mujur Usaha Ma', '-69141184.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('49', '39', '2', '1', '2017-05-27', '04:57:57', 'PAY/2017/05/00039', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00032 Kepada PT. Sinar Halomoan', '-87991800.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('50', '40', '2', '1', '2017-05-27', '04:58:22', 'PAY/2017/05/00040', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00040 Kepada PT. Sinar Halomoan', '-28874360.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('51', '41', '2', '1', '2017-05-27', '04:59:41', 'PAY/2017/05/00041', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00041 Kepada Sejahtera Sawit', '11578530.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('52', '42', '2', '1', '2017-05-27', '05:00:30', 'PAY/2017/05/00042', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00044 Kepada Mandurana', '-79910640.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('53', '43', '2', '1', '2017-05-27', '05:00:46', 'PAY/2017/05/00043', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00046 Kepada PT. Sinar Halomoan', '-67800000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('54', '16', '2', '1', '2017-06-04', '10:22:14', 'PAY/2017/06/00001', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/06/00018 Kepada UD. Mitra Pribadi', '15000000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('55', '17', '2', '1', '2017-06-04', '10:32:59', 'PAY/2017/06/00001', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/06/00018 Kepada UD. Mitra Pribadi', '20000000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('56', '18', '2', '1', '2017-06-04', '10:35:17', 'PAY/2017/06/00001', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/06/00018 Kepada UD. Mitra Pribadi', '16750000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('57', '19', '2', '1', '2017-06-04', '12:17:29', 'PAY/2017/06/00002', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/06/00018 Kepada UD. Mitra Pribadi', '10000000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('58', '20', '2', '1', '2017-06-04', '12:18:06', 'PAY/2017/06/00003', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/06/00018 Kepada UD. Mitra Pribadi', '2824080.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('59', '21', '2', '1', '2017-06-04', '16:20:48', 'PAY/2017/06/00004', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/06/00017 Kepada UD. Rizki', '35000000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('60', '22', '2', '1', '2017-06-04', '16:25:30', 'PAY/2017/06/00005', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00067 Kepada UD. Rizki', '15000000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('61', '23', '2', '1', '2017-06-04', '16:29:45', 'PAY/2017/06/00006', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00069 Kepada PT. Sibuah Raya', '10000000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('62', '24', '2', '1', '2017-06-04', '16:30:43', 'PAY/2017/06/00007', 'Pembayaran Pembelian Kelapa Sawit No TBS/2017/05/00068 Kepada PT. Mujur Usaha Ma', '20000000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('63', '1', '3', '0', '2017-06-06', '12:28:01', 'COM/2017/06/00001', 'Penerimaan Pembayaran Penjualan Dari DENI UDENG', '20000000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('64', '2', '3', '0', '2017-06-06', '12:29:14', 'COM/2017/06/00001', 'Penerimaan Pembayaran Penjualan Dari DENI UDENG', '5000000.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('65', '3', '3', '0', '2017-06-06', '12:35:09', 'COM/2017/06/00001', 'Penerimaan Pembayaran Penjualan Dari DENI UDENG', '2750111.00', '0');
INSERT INTO `tbt_laba_rugi` VALUES ('66', '1', '3', '0', '2017-06-09', '14:42:37', 'COM/2017/06/00001', 'Penerimaan Pembayaran Penjualan Dari CV SINAR JAYA', '50000000.00', '0');

-- ----------------------------
-- Table structure for tbt_lembur_karyawan
-- ----------------------------
DROP TABLE IF EXISTS `tbt_lembur_karyawan`;
CREATE TABLE `tbt_lembur_karyawan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_karyawan` int(11) DEFAULT NULL,
  `tgl` date DEFAULT NULL,
  `lama_lembur` int(11) DEFAULT NULL,
  `jns_lembur` char(1) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbt_lembur_karyawan
-- ----------------------------
INSERT INTO `tbt_lembur_karyawan` VALUES ('1', '1', '2017-05-21', '5', '1', '0');
INSERT INTO `tbt_lembur_karyawan` VALUES ('2', '1', '2017-05-20', '4', '3', '0');

-- ----------------------------
-- Table structure for tbt_modal_transaksi
-- ----------------------------
DROP TABLE IF EXISTS `tbt_modal_transaksi`;
CREATE TABLE `tbt_modal_transaksi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `st_modal` char(1) DEFAULT '0',
  `modal` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_modal_transaksi
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_mutasi_barang
-- ----------------------------
DROP TABLE IF EXISTS `tbt_mutasi_barang`;
CREATE TABLE `tbt_mutasi_barang` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT NULL,
  `jumlah_barang` int(11) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_mutasi_barang
-- ----------------------------
INSERT INTO `tbt_mutasi_barang` VALUES ('1', '2017-05-27', '06:36:07', '7', '0');

-- ----------------------------
-- Table structure for tbt_mutasi_barang_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbt_mutasi_barang_detail`;
CREATE TABLE `tbt_mutasi_barang_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) DEFAULT '0',
  `id_barang` int(11) DEFAULT NULL,
  `id_satuan` int(11) DEFAULT NULL,
  `jml` float(11,2) DEFAULT NULL,
  `jns_keluar` char(1) DEFAULT '3',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_mutasi_barang_detail
-- ----------------------------
INSERT INTO `tbt_mutasi_barang_detail` VALUES ('1', '1', '897', '12', '3.00', '3', '0');
INSERT INTO `tbt_mutasi_barang_detail` VALUES ('2', '1', '343', '15', '6.00', '3', '0');
INSERT INTO `tbt_mutasi_barang_detail` VALUES ('3', '1', '892', '12', '2.00', '3', '0');
INSERT INTO `tbt_mutasi_barang_detail` VALUES ('4', '1', '857', '15', '1.00', '3', '0');
INSERT INTO `tbt_mutasi_barang_detail` VALUES ('5', '1', '874', '31', '1.00', '3', '0');
INSERT INTO `tbt_mutasi_barang_detail` VALUES ('6', '1', '196', '15', '1.00', '3', '0');
INSERT INTO `tbt_mutasi_barang_detail` VALUES ('7', '1', '195', '15', '1.00', '3', '0');

-- ----------------------------
-- Table structure for tbt_pembayaran_po
-- ----------------------------
DROP TABLE IF EXISTS `tbt_pembayaran_po`;
CREATE TABLE `tbt_pembayaran_po` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_pembayaran` varchar(60) DEFAULT NULL,
  `id_po` int(11) DEFAULT NULL,
  `tgl_pembayaran` date DEFAULT NULL,
  `wkt_pembayaran` time DEFAULT NULL,
  `total_pembayaran` float(11,2) DEFAULT NULL,
  `id_coa` int(11) DEFAULT NULL,
  `jns_bayar` char(1) DEFAULT '0',
  `id_bank` int(11) DEFAULT NULL,
  `no_ref` varchar(60) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_pembayaran_po
-- ----------------------------
INSERT INTO `tbt_pembayaran_po` VALUES ('1', 'PO-PAY/2017/05/00001', '1', '2017-05-09', '15:10:01', '15000000.00', '786', '1', '3', '243543534', '0');
INSERT INTO `tbt_pembayaran_po` VALUES ('2', 'PO-PAY/2017/05/00002', '1', '2017-05-09', '15:11:15', '17730000.00', '786', '1', '3', '24353645', '0');
INSERT INTO `tbt_pembayaran_po` VALUES ('3', 'PO-PAY/2017/05/00003', '2', '2017-05-23', '06:15:30', '500000.00', '217', '0', '8', '', '0');

-- ----------------------------
-- Table structure for tbt_pembayaran_tbs
-- ----------------------------
DROP TABLE IF EXISTS `tbt_pembayaran_tbs`;
CREATE TABLE `tbt_pembayaran_tbs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tbs_order` int(11) DEFAULT NULL,
  `no_pembayaran` varchar(60) DEFAULT NULL,
  `tgl_pembayaran` date DEFAULT NULL,
  `wkt_pembayaran` time DEFAULT NULL,
  `jumlah_pembayaran` float(11,2) DEFAULT NULL,
  `id_coa` int(11) DEFAULT NULL,
  `jns_bayar` char(1) DEFAULT '0',
  `id_bank` int(11) DEFAULT NULL,
  `no_ref` varchar(60) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_pembayaran_tbs
-- ----------------------------
INSERT INTO `tbt_pembayaran_tbs` VALUES ('1', '2', 'PAY/2017/05/00001', '2017-05-23', '05:14:41', '4929617.50', '758', '0', '8', '', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('2', '3', 'PAY/2017/05/00002', '2017-05-23', '09:47:00', '766587136.00', '508', '0', '8', '', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('3', '1', 'PAY/2017/05/00003', '2017-05-23', '04:21:44', '22342280.00', '508', '1', '4', '10123245566', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('4', '7', 'PAY/2017/05/00004', '2017-05-26', '10:37:21', '67536248.00', '845', '1', '4', '0436.6968.41', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('5', '8', 'PAY/2017/05/00005', '2017-05-26', '10:37:58', '21509870.00', '845', '1', '4', '1980061005', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('6', '9', 'PAY/2017/05/00006', '2017-05-26', '10:44:53', '-94294144.00', '845', '1', '9', '411-322-01-0001', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('7', '4', 'PAY/2017/05/00007', '2017-05-26', '10:30:54', '34420216.00', '845', '1', '4', '0375273878', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('8', '5', 'PAY/2017/05/00008', '2017-05-26', '10:32:58', '-52815040.00', '845', '1', '4', '0534531025', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('9', '6', 'PAY/2017/05/00009', '2017-05-26', '10:34:08', '14894778.00', '845', '0', '8', '0534531025', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('10', '13', 'PAY/2017/05/00010', '2017-05-27', '04:59:41', '11578530.00', '845', '1', '13', '0424825250', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('11', '14', 'PAY/2017/05/00011', '2017-05-27', '05:00:30', '-79910640.00', '845', '1', '13', '2021956558', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('12', '15', 'PAY/2017/05/00012', '2017-05-27', '05:00:46', '-67800000.00', '845', '1', '13', '600760141', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('13', '10', 'PAY/2017/05/00013', '2017-05-27', '04:25:19', '-150272064.00', '845', '1', '10', '0367.01.001119.30.3', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('14', '11', 'PAY/2017/05/00014', '2017-05-27', '04:57:57', '-87991800.00', '845', '1', '11', '600760141', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('15', '12', 'PAY/2017/05/00015', '2017-05-27', '04:58:22', '-28874360.00', '845', '1', '11', '600760141', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('18', '99', 'PAY/2017/06/00001', '2017-06-04', '10:35:17', '16750000.00', '786', '0', '8', '', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('19', '99', 'PAY/2017/06/00002', '2017-06-04', '12:17:29', '10000000.00', '508', '0', '8', '', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('20', '99', 'PAY/2017/06/00003', '2017-06-04', '12:18:06', '2824080.00', '786', '0', '8', '', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('21', '98', 'PAY/2017/06/00004', '2017-06-04', '16:20:48', '35000000.00', '786', '1', '9', '789745645', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('22', '67', 'PAY/2017/06/00005', '2017-06-04', '16:25:30', '15000000.00', '786', '0', '8', '', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('23', '69', 'PAY/2017/06/00006', '2017-06-04', '16:29:45', '10000000.00', '786', '0', '8', '', '0');
INSERT INTO `tbt_pembayaran_tbs` VALUES ('24', '68', 'PAY/2017/06/00007', '2017-06-04', '16:30:43', '20000000.00', '845', '1', '9', '45678', '0');

-- ----------------------------
-- Table structure for tbt_pembayaran_tbs_copy
-- ----------------------------
DROP TABLE IF EXISTS `tbt_pembayaran_tbs_copy`;
CREATE TABLE `tbt_pembayaran_tbs_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_pembayaran` varchar(60) DEFAULT NULL,
  `id_tbs_order` int(11) DEFAULT NULL,
  `tgl_pembayaran` date DEFAULT NULL,
  `wkt_pembayaran` time DEFAULT NULL,
  `netto_1` float(11,2) DEFAULT NULL,
  `jumlah_bongkar` float(11,2) DEFAULT NULL,
  `subtotal_spsi` float(11,2) DEFAULT NULL,
  `netto_2` float(11,2) DEFAULT NULL,
  `harga` float(11,2) DEFAULT NULL,
  `subtotal_tbs` float(11,2) DEFAULT NULL,
  `fee` float(11,2) DEFAULT NULL,
  `subtotal_fee` float(11,2) DEFAULT NULL,
  `ppn` float(11,2) DEFAULT '0.00',
  `pph` float(11,2) DEFAULT NULL,
  `total_tbs_order` float(11,2) DEFAULT NULL,
  `id_coa` int(11) DEFAULT NULL,
  `jns_bayar` char(1) DEFAULT '0',
  `id_bank` int(11) DEFAULT NULL,
  `no_ref` varchar(60) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_pembayaran_tbs_copy
-- ----------------------------
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('1', 'PAY/2017/05/00001', '1', '2017-05-09', '15:16:56', '8660.00', '12.00', '103920.00', '8374.00', '3000.00', '25122000.00', '20.00', '167480.00', '10.00', '25.00', '21417260.00', '786', '1', '2', '12342352', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('2', 'PAY/2017/05/00002', '3', '2017-05-23', '04:21:44', '7490.00', '12.00', '89880.00', '7265.00', '1550.00', '11260750.00', '0.00', '0.00', '1.00', '1.00', '11170870.00', '508', '1', '4', '10123245566', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('3', 'PAY/2017/05/00003', '5', '2017-05-23', '04:21:44', '6820.00', '12.00', '81840.00', '6615.00', '1550.00', '10253250.00', '0.00', '0.00', '1.00', '1.00', '10171410.00', '508', '1', '4', '10123245566', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('4', 'PAY/2017/05/00004', '7', '2017-05-23', '04:21:45', '8890.00', '12.00', '106680.00', '8623.00', '1550.00', '13365650.00', '0.00', null, '1.00', '1.00', '1000000.00', '508', '1', '4', '10123245566', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('5', 'PAY/2017/05/00005', '4', '2017-05-23', '05:14:41', '6700.00', '12.00', '80400.00', '6499.00', '1450.00', '9423550.00', '0.00', null, '10.00', '25.00', '4929617.50', '758', '0', '8', '', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('6', 'PAY/2017/05/00006', '6', '2017-05-23', '09:47:00', '3560.00', '15000.00', '15000.00', '3453.00', '1550.00', '5352150.00', '0.00', '0.00', '2.00', '2.00', '5337150.00', '508', '0', '8', '', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('7', 'PAY/2017/05/00007', '8', '2017-05-23', '09:47:00', '500000.00', '12.00', '6000000.00', '495000.00', '1550.00', '767249984.00', '0.00', '0.00', '2.00', '2.00', '761249984.00', '508', '0', '8', '', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('8', 'PAY/2017/05/00008', '11', '2017-05-26', '10:30:54', '4900.00', '12.00', '58800.00', '4753.00', '1805.00', '8579165.00', '0.00', '0.00', '10.00', '25.00', '7233490.00', '845', '1', '4', '0375273878', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('9', 'PAY/2017/05/00009', '24', '2017-05-26', '10:30:55', '5300.00', '12.00', '63600.00', '5141.00', '1805.00', '9279505.00', '0.00', '0.00', '10.00', '25.00', '7823979.00', '845', '1', '4', '0375273878', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('10', 'PAY/2017/05/00010', '27', '2017-05-26', '10:30:55', '1840.00', '12.00', '22080.00', '1785.00', '1805.00', '3221925.00', '0.00', '0.00', '10.00', '25.00', '2716556.25', '845', '1', '4', '0375273878', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('11', 'PAY/2017/05/00011', '28', '2017-05-26', '10:30:55', '2600.00', '12.00', '31200.00', '2522.00', '1795.00', '4526990.00', '0.00', '0.00', '10.00', '25.00', '3816741.50', '845', '1', '4', '0375273878', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('12', 'PAY/2017/05/00012', '34', '2017-05-26', '10:30:56', '5410.00', '12.00', '64920.00', '5248.00', '1805.00', '9472640.00', '0.00', '0.00', '10.00', '25.00', '7986824.00', '845', '1', '4', '0375273878', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('13', 'PAY/2017/05/00013', '43', '2017-05-26', '10:30:56', '3280.00', '12.00', '39360.00', '3182.00', '1805.00', '5743510.00', '0.00', '0.00', '10.00', '25.00', '4842623.50', '845', '1', '4', '0375273878', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('14', 'PAY/2017/05/00014', '12', '2017-05-26', '10:32:58', '6680.00', '12.00', '80160.00', '6480.00', '1730.00', '11210400.00', '0.00', '0.00', '1.00', '1.00', '11130240.00', '845', '1', '4', '0534531025', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('15', 'PAY/2017/05/00015', '16', '2017-05-26', '10:32:59', '7110.00', '12.00', '85320.00', '6897.00', '1720.00', '11862840.00', '0.00', '0.00', '1.00', '1.00', '11777520.00', '845', '1', '4', '0534531025', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('16', 'PAY/2017/05/00016', '45', '2017-05-26', '10:32:59', '5680.00', '15000.00', '85200000.00', '5510.00', '1720.00', '9477200.00', '0.00', '0.00', '1.00', '1.00', '-75722800.00', '845', '1', '4', '0534531025', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('17', 'PAY/2017/05/00017', '13', '2017-05-26', '10:34:08', '4110.00', '15000.00', '61650000.00', '3987.00', '1720.00', '6857640.00', '0.00', null, '10.00', '25.00', '55821.00', '845', '0', '8', '0534531025', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('18', 'PAY/2017/05/00018', '19', '2017-05-26', '10:34:09', '7480.00', '12.00', '89760.00', '7256.00', '1730.00', '12552880.00', '0.00', null, '10.00', '25.00', '10580188.00', '845', '0', '8', '0534531025', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('19', 'PAY/2017/05/00019', '20', '2017-05-26', '10:34:09', '6020.00', '12.00', '72240.00', '5851.00', '1730.00', '10122230.00', '0.00', '0.00', '10.00', '25.00', '8531656.00', '845', '0', '8', '0534531025', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('20', 'PAY/2017/05/00020', '25', '2017-05-26', '10:34:09', '6900.00', '12.00', '82800.00', '6707.00', '1730.00', '11603110.00', '0.00', '0.00', '10.00', '25.00', '9779844.00', '845', '0', '8', '0534531025', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('21', 'PAY/2017/05/00021', '26', '2017-05-26', '10:34:10', '2430.00', '15000.00', '36450000.00', '2381.00', '1730.00', '4119130.00', '0.00', '0.00', '10.00', '25.00', '-32948740.00', '845', '0', '8', '0534531025', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('22', 'PAY/2017/05/00022', '30', '2017-05-26', '10:34:10', '4890.00', '12.00', '58680.00', '4753.00', '1730.00', '8222690.00', '0.00', '0.00', '10.00', '25.00', '6930606.50', '845', '0', '8', '0534531025', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('23', 'PAY/2017/05/00023', '31', '2017-05-26', '10:34:10', '6530.00', '12.00', '78360.00', '6334.00', '1730.00', '10957820.00', '0.00', '0.00', '10.00', '25.00', '9235787.00', '845', '0', '8', '0534531025', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('24', 'PAY/2017/05/00024', '35', '2017-05-26', '10:34:10', '1930.00', '12.00', '23160.00', '1872.00', '1730.00', '3238560.00', '0.00', '0.00', '10.00', '25.00', '2729616.00', '845', '0', '8', '0534531025', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('25', 'PAY/2017/05/00025', '14', '2017-05-26', '10:37:21', '4960.00', '12.00', '59520.00', '4811.00', '1730.00', '8323030.00', '0.00', '0.00', '2.00', '2.00', '8263510.00', '845', '1', '4', '0436.6968.41', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('26', 'PAY/2017/05/00026', '15', '2017-05-26', '10:37:22', '5760.00', '12.00', '69120.00', '5587.00', '1720.00', '9609640.00', '0.00', '0.00', '2.00', '2.00', '9540520.00', '845', '1', '4', '0436.6968.41', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('27', 'PAY/2017/05/00027', '18', '2017-05-26', '10:37:22', '4140.00', '12.00', '49680.00', '4016.00', '1730.00', '6947680.00', '0.00', '0.00', '2.00', '2.00', '6898000.00', '845', '1', '4', '0436.6968.41', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('28', 'PAY/2017/05/00028', '29', '2017-05-26', '10:37:22', '3350.00', '12.00', '40200.00', '3249.00', '1730.00', '5620770.00', '0.00', '0.00', '2.00', '2.00', '5580570.00', '845', '1', '4', '0436.6968.41', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('29', 'PAY/2017/05/00029', '33', '2017-05-26', '10:37:22', '5560.00', '12.00', '66720.00', '5393.00', '1730.00', '9329890.00', '0.00', '0.00', '2.00', '2.00', '9263170.00', '845', '1', '4', '0436.6968.41', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('30', 'PAY/2017/05/00030', '36', '2017-05-26', '10:37:23', '5770.00', '12.00', '69240.00', '5597.00', '1730.00', '9682810.00', '0.00', '0.00', '2.00', '2.00', '9613570.00', '845', '1', '4', '0436.6968.41', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('31', 'PAY/2017/05/00031', '37', '2017-05-26', '10:37:23', '4230.00', '12.00', '50760.00', '4103.00', '1730.00', '7098190.00', '0.00', '0.00', '2.00', '2.00', '7047430.00', '845', '1', '4', '0436.6968.41', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('32', 'PAY/2017/05/00032', '38', '2017-05-26', '10:37:23', '4780.00', '12.00', '57360.00', '4637.00', '1730.00', '8022010.00', '0.00', '0.00', '2.00', '2.00', '7964650.00', '845', '1', '4', '0436.6968.41', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('33', 'PAY/2017/05/00033', '39', '2017-05-26', '10:37:23', '2020.00', '12.00', '24240.00', '1959.00', '1730.00', '3389070.00', '0.00', '0.00', '2.00', '2.00', '3364830.00', '845', '1', '4', '0436.6968.41', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('34', 'PAY/2017/05/00034', '17', '2017-05-26', '10:37:58', '6730.00', '12.00', '80760.00', '6528.00', '1730.00', '11293440.00', '0.00', '0.00', '1.00', '1.00', '11212680.00', '845', '1', '4', '1980061005', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('35', 'PAY/2017/05/00035', '42', '2017-05-26', '10:37:59', '6180.00', '12.00', '74160.00', '5995.00', '1730.00', '10371350.00', '0.00', '0.00', '1.00', '1.00', '10297190.00', '845', '1', '4', '1980061005', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('36', 'PAY/2017/05/00036', '21', '2017-05-26', '10:44:53', '7080.00', '15000.00', '106200000.00', '6882.00', '1730.00', '11905860.00', '0.00', '0.00', '1.00', '1.00', '-94294144.00', '845', '1', '9', '411-322-01-0001', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('37', 'PAY/2017/05/00037', '22', '2017-05-27', '04:25:19', '6090.00', '15000.00', '91350000.00', '5907.00', '1730.00', '10219110.00', '0.00', '0.00', '0.00', '0.00', '-81130888.00', '845', '1', '10', '0367.01.001119.30.3', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('38', 'PAY/2017/05/00038', '23', '2017-05-27', '04:25:19', '5190.00', '15000.00', '77850000.00', '5034.00', '1730.00', '8708820.00', '0.00', '0.00', '0.00', '0.00', '-69141184.00', '845', '1', '10', '0367.01.001119.30.3', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('39', 'PAY/2017/05/00039', '32', '2017-05-27', '04:57:57', '6460.00', '15000.00', '96900000.00', '6363.00', '1400.00', '8908200.00', '0.00', '0.00', '0.00', '0.00', '-87991800.00', '845', '1', '11', '600760141', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('40', 'PAY/2017/05/00040', '40', '2017-05-27', '04:58:22', '2170.00', '15000.00', '32550000.00', '2137.00', '1720.00', '3675640.00', '0.00', '0.00', '0.00', '0.00', '-28874360.00', '845', '1', '11', '600760141', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('41', 'PAY/2017/05/00041', '41', '2017-05-27', '04:59:41', '6950.00', '12.00', '83400.00', '6741.00', '1730.00', '11661930.00', '0.00', '0.00', '1.00', '1.00', '11578530.00', '845', '1', '13', '0424825250', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('42', 'PAY/2017/05/00042', '44', '2017-05-27', '05:00:30', '6000.00', '15000.00', '90000000.00', '5832.00', '1730.00', '10089360.00', '0.00', '0.00', '1.00', '1.00', '-79910640.00', '845', '1', '13', '2021956558', '0');
INSERT INTO `tbt_pembayaran_tbs_copy` VALUES ('43', 'PAY/2017/05/00043', '46', '2017-05-27', '05:00:46', '4520.00', '15000.00', '67800000.00', '4249.00', null, '0.00', '0.00', '0.00', '0.00', '0.00', '-67800000.00', '845', '1', '13', '600760141', '0');

-- ----------------------------
-- Table structure for tbt_pembayaran_tbs_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbt_pembayaran_tbs_detail`;
CREATE TABLE `tbt_pembayaran_tbs_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pembayaran` varchar(60) DEFAULT NULL,
  `id_tbs_order` int(11) DEFAULT NULL,
  `netto_1` float(11,2) DEFAULT NULL,
  `jumlah_bongkar` float(11,2) DEFAULT NULL,
  `subtotal_spsi` float(11,2) DEFAULT NULL,
  `netto_2` float(11,2) DEFAULT NULL,
  `harga` float(11,2) DEFAULT NULL,
  `subtotal_tbs` float(11,2) DEFAULT NULL,
  `fee` float(11,2) DEFAULT NULL,
  `subtotal_fee` float(11,2) DEFAULT NULL,
  `ppn` float(11,2) DEFAULT '0.00',
  `pph` float(11,2) DEFAULT NULL,
  `total_tbs_order` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_pembayaran_tbs_detail
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_pembayaran_tbs_detail_copy
-- ----------------------------
DROP TABLE IF EXISTS `tbt_pembayaran_tbs_detail_copy`;
CREATE TABLE `tbt_pembayaran_tbs_detail_copy` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_pembayaran` varchar(60) DEFAULT NULL,
  `id_pembayaran` int(11) DEFAULT NULL,
  `tgl_pembayaran` date DEFAULT NULL,
  `wkt_pembayaran` time DEFAULT NULL,
  `jumlah_pembayaran` float(11,2) DEFAULT NULL,
  `id_coa` int(11) DEFAULT NULL,
  `jns_bayar` char(1) DEFAULT '0',
  `id_bank` int(11) DEFAULT NULL,
  `no_ref` varchar(60) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_pembayaran_tbs_detail_copy
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_pembelian
-- ----------------------------
DROP TABLE IF EXISTS `tbt_pembelian`;
CREATE TABLE `tbt_pembelian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pemasok` int(11) DEFAULT NULL,
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT NULL,
  `st_posting` char(1) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_pembelian
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_pembelian_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbt_pembelian_detail`;
CREATE TABLE `tbt_pembelian_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) DEFAULT '0',
  `id_barang` int(11) DEFAULT NULL,
  `jml` float(11,2) DEFAULT NULL,
  `harga` float(11,2) DEFAULT NULL,
  `total` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_pembelian_detail
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_penerimaan_penjualan
-- ----------------------------
DROP TABLE IF EXISTS `tbt_penerimaan_penjualan`;
CREATE TABLE `tbt_penerimaan_penjualan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_penjualan` int(11) DEFAULT NULL,
  `tgl_penerimaan` date DEFAULT NULL,
  `jumlah_dikirim` decimal(36,2) DEFAULT NULL,
  `jumlah_diterima` decimal(36,2) DEFAULT NULL,
  `jumlah_susut` decimal(36,2) DEFAULT NULL,
  `harga` decimal(36,2) DEFAULT NULL,
  `total_penjualan` decimal(36,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_penerimaan_penjualan
-- ----------------------------
INSERT INTO `tbt_penerimaan_penjualan` VALUES ('1', '1', '2017-06-09', '30570.00', '27500.00', '3070.00', '3000.00', '82500000.00', '0');

-- ----------------------------
-- Table structure for tbt_penerimaan_penjualan_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbt_penerimaan_penjualan_detail`;
CREATE TABLE `tbt_penerimaan_penjualan_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_parent` int(11) DEFAULT NULL,
  `tgl_pembayaran` date DEFAULT NULL,
  `wkt_pembayaran` time DEFAULT NULL,
  `total_pembayaran` decimal(36,2) DEFAULT NULL,
  `id_coa` int(11) DEFAULT NULL,
  `jns_bayar` char(1) DEFAULT '0',
  `id_bank` int(11) DEFAULT NULL,
  `no_ref` varchar(60) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_penerimaan_penjualan_detail
-- ----------------------------
INSERT INTO `tbt_penerimaan_penjualan_detail` VALUES ('1', '1', '2017-06-09', '14:42:37', '50000000.00', '844', '1', '9', '24545645564', '0');

-- ----------------------------
-- Table structure for tbt_penjualan
-- ----------------------------
DROP TABLE IF EXISTS `tbt_penjualan`;
CREATE TABLE `tbt_penjualan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `jns_transaksi` char(1) DEFAULT '0',
  `id_pelanggan` int(11) DEFAULT NULL,
  `nama_pelanggan` varchar(255) DEFAULT NULL,
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT NULL,
  `st_posting` char(1) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_penjualan
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_penjualan_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbt_penjualan_detail`;
CREATE TABLE `tbt_penjualan_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) DEFAULT '0',
  `id_barang` int(11) DEFAULT NULL,
  `jml` float(11,2) DEFAULT NULL,
  `id_harga` int(11) DEFAULT NULL,
  `harga` float(11,2) DEFAULT NULL,
  `diskon` float(11,2) DEFAULT NULL,
  `total` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_penjualan_detail
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_processing_product
-- ----------------------------
DROP TABLE IF EXISTS `tbt_processing_product`;
CREATE TABLE `tbt_processing_product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `processing_no` varchar(60) DEFAULT NULL,
  `tgl_processing` date DEFAULT NULL,
  `id_tbs` int(11) DEFAULT NULL,
  `id_satuan_tbs` int(11) DEFAULT NULL,
  `processing_qty` float(11,2) DEFAULT NULL,
  `cpo_qty` float(11,2) DEFAULT NULL,
  `id_satuan_cpo` int(11) DEFAULT NULL,
  `pk_qty` float(11,2) DEFAULT NULL,
  `id_satuan_pk` int(11) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbt_processing_product
-- ----------------------------
INSERT INTO `tbt_processing_product` VALUES ('1', 'PROC/2017/05/00001', '2017-05-09', '9', '12', '5000.00', '2500.00', '12', '2500.00', '12', '0');

-- ----------------------------
-- Table structure for tbt_processing_tbs
-- ----------------------------
DROP TABLE IF EXISTS `tbt_processing_tbs`;
CREATE TABLE `tbt_processing_tbs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_processing` varchar(30) DEFAULT NULL,
  `tgl_processing` date DEFAULT NULL,
  `wkt_processing` time DEFAULT NULL,
  `tbs_awal` float(11,4) DEFAULT NULL,
  `tbs_kebun` float(11,4) DEFAULT NULL,
  `tbs_luar` float(11,4) DEFAULT NULL,
  `tbs_potongan` float(11,4) DEFAULT NULL,
  `tbs_rbs_mentah` float(11,4) DEFAULT NULL,
  `tbs_rbs_masak` float(11,4) DEFAULT NULL,
  `tbs_restan_ramp` float(11,4) DEFAULT NULL,
  `tbs_restan_lantai` float(11,4) DEFAULT NULL,
  `tbs_akhir` float(11,4) DEFAULT NULL,
  `bst_akhir` float(11,4) DEFAULT NULL,
  `bst_in_process` float(11,4) DEFAULT NULL,
  `pk_bsk_akhir` float(11,4) DEFAULT NULL,
  `tbs_proses_shift_1` float(11,4) DEFAULT NULL,
  `tbs_proses_shift_2` float(11,4) DEFAULT '0.0000',
  `bst_kemarin` float(11,4) DEFAULT '0.0000',
  `oil_in_process` float(11,4) DEFAULT NULL,
  `pk_bsk` float(11,4) DEFAULT NULL,
  `cst_1` float(11,4) DEFAULT NULL,
  `cst_2` float(11,4) DEFAULT NULL,
  `cst_3` float(11,4) DEFAULT NULL,
  `ot_1` float(11,4) DEFAULT NULL,
  `ot_2` float(11,4) DEFAULT NULL,
  `rcv_1` float(11,4) DEFAULT NULL,
  `rcv_2` float(11,4) DEFAULT NULL,
  `rcv_3` float(11,4) DEFAULT NULL,
  `cot` float(11,4) DEFAULT NULL,
  `bst1_cpo_isi` float(11,4) DEFAULT NULL,
  `temp_bst1` float(11,4) DEFAULT NULL,
  `bst1_cpo_ffa` float(11,4) DEFAULT NULL,
  `bst1_cpo_moist` float(11,4) DEFAULT NULL,
  `bst1_cpo_impurities` float(11,4) DEFAULT NULL,
  `bst2_cpo_isi` float(11,4) DEFAULT NULL,
  `temp_bst2` float(11,4) DEFAULT NULL,
  `bst2_cpo_ffa` float(11,4) DEFAULT NULL,
  `bst2_cpo_moist` float(11,4) DEFAULT NULL,
  `bst2_cpo_impurities` float(11,4) DEFAULT NULL,
  `ffa_cst_1` float(11,4) DEFAULT NULL,
  `ffa_cst_2` float(11,4) DEFAULT NULL,
  `ffa_cst_3` float(11,4) DEFAULT NULL,
  `ffa_ot_1` float(11,4) DEFAULT NULL,
  `ffa_ot_2` float(11,4) DEFAULT NULL,
  `ffa_rcv_1` float(11,4) DEFAULT NULL,
  `ffa_rcv_2` float(11,4) DEFAULT NULL,
  `ffa_rcv_3` float(11,4) DEFAULT NULL,
  `ffa_cot` float(11,4) DEFAULT NULL,
  `bsk_no_1` float(11,4) DEFAULT NULL,
  `bsk_no_2` float(11,4) DEFAULT NULL,
  `bsk_no_3` float(11,4) DEFAULT NULL,
  `bsk_lantai` float(11,4) DEFAULT NULL,
  `nut_silo_no_1` float(11,4) DEFAULT NULL,
  `nut_silo_no_2` float(11,4) DEFAULT NULL,
  `nut_silo_no_3` float(11,4) DEFAULT NULL,
  `nut_silo_no_4` float(11,4) DEFAULT NULL,
  `nut_silo_lantai` float(11,4) DEFAULT NULL,
  `kernel_silo_no_1` float(11,4) DEFAULT NULL,
  `kernel_silo_no_2` float(11,4) DEFAULT NULL,
  `kernel_silo_no_3` float(11,4) DEFAULT NULL,
  `kernel_silo_lantai` float(11,4) DEFAULT NULL,
  `pengiriman_cpo` float(11,4) DEFAULT NULL,
  `pengiriman_kernel` float(11,4) DEFAULT NULL,
  `pengiriman_cangkang` float(11,4) DEFAULT NULL,
  `pengiriman_fibre` float(11,4) DEFAULT NULL,
  `pengiriman_limbah` float(11,4) DEFAULT NULL,
  `reject_cpo` float(11,4) DEFAULT NULL,
  `pengiriman_jangkos` float(11,4) DEFAULT NULL,
  `pengiriman_cpo_pagi_malam` float(11,4) DEFAULT NULL,
  `pengiriman_cpo_pagi_ini` float(11,4) DEFAULT NULL,
  `pengiriman_cpo_ffa_tinggi` float(11,4) DEFAULT NULL,
  `oil_dalam_mobil_cpo` float(11,4) DEFAULT NULL,
  `oil_dalam_mobil_cpo_malam` float(11,4) DEFAULT NULL,
  `reject_kernel` float(11,4) DEFAULT NULL,
  `mutu_cpo_ffa` float(11,4) DEFAULT NULL,
  `mutu_cpo_moisture` float(11,4) DEFAULT NULL,
  `mutu_cpo_impurities` float(11,4) DEFAULT NULL,
  `drain_minyak` float(11,4) DEFAULT NULL,
  `mutu_pk_moisture` float(11,4) DEFAULT NULL,
  `mutu_pk_impurities` float(11,4) DEFAULT NULL,
  `nomor_kolam_tanah` float(11,4) DEFAULT NULL,
  `kolam_tanah` float(11,4) DEFAULT NULL,
  `oil_recovered_ffa` float(11,4) DEFAULT NULL,
  `oil_recovered_moisture` float(11,4) DEFAULT NULL,
  `pengutipan_minyak` float(11,4) DEFAULT NULL,
  `produksi_abu_janjang_goni` float(11,4) DEFAULT NULL,
  `produksi_abu_janjang_kg` float(11,4) DEFAULT NULL,
  `bss_no_1` float(11,4) DEFAULT NULL,
  `bss_no_2` float(11,4) DEFAULT NULL,
  `bss_no_3` float(11,4) DEFAULT NULL,
  `bss_lantai` float(11,4) DEFAULT NULL,
  `etc_cst1_kg_cm` float(11,4) DEFAULT NULL,
  `etc_cst1_kg` float(11,4) DEFAULT NULL,
  `etc_cst2_kg_cm` float(11,4) DEFAULT NULL,
  `etc_cst2_kg` float(11,4) DEFAULT NULL,
  `etc_cst3_kg_cm` float(11,4) DEFAULT NULL,
  `etc_cst3_kg` float(11,4) DEFAULT NULL,
  `etc_ot1_kg_cm` float(11,4) DEFAULT NULL,
  `etc_ot1_kg` float(11,4) DEFAULT NULL,
  `etc_ot2_kg_cm` float(11,4) DEFAULT NULL,
  `etc_ot2_kg` float(11,4) DEFAULT NULL,
  `etc_rcv1_kg_cm` float(11,4) DEFAULT NULL,
  `etc_rcv1_kg` float(11,4) DEFAULT NULL,
  `etc_rcv2_kg_cm` float(11,4) DEFAULT NULL,
  `etc_rcv2_kg` float(11,4) DEFAULT NULL,
  `etc_rcv3_kg_cm` float(11,4) DEFAULT NULL,
  `etc_rcv3_kg` float(11,4) DEFAULT NULL,
  `etc_cot_kg_cm` float(11,4) DEFAULT NULL,
  `etc_cot_kg` float(11,4) DEFAULT NULL,
  `etc_bst1_kg_cm` float(11,4) DEFAULT NULL,
  `etc_bst1_kg` float(11,4) DEFAULT NULL,
  `etc_bst2_kg_cm` float(11,4) DEFAULT NULL,
  `etc_bst2_kg` float(11,4) DEFAULT NULL,
  `etc_ks1_kg_cm` float(11,4) DEFAULT NULL,
  `etc_ks1_kg` float(11,4) DEFAULT NULL,
  `etc_ks2_kg_cm` float(11,4) DEFAULT NULL,
  `etc_ks2_kg` float(11,4) DEFAULT NULL,
  `etc_ks3_kg_cm` float(11,4) DEFAULT NULL,
  `etc_ks3_kg` float(11,4) DEFAULT NULL,
  `etc_ns1_kg_cm` float(11,4) DEFAULT NULL,
  `etc_ns1_kg` float(11,4) DEFAULT NULL,
  `etc_ns2_kg_cm` float(11,4) DEFAULT NULL,
  `etc_ns2_kg` float(11,4) DEFAULT NULL,
  `etc_ns3_kg_cm` float(11,4) DEFAULT NULL,
  `etc_ns3_kg` float(11,4) DEFAULT NULL,
  `etc_ns4_kg_cm` float(11,4) DEFAULT NULL,
  `etc_ns4_kg` float(11,4) DEFAULT NULL,
  `etc_bsk1_kg_cm` float(11,4) DEFAULT NULL,
  `etc_bsk1_kg` float(11,4) DEFAULT NULL,
  `etc_bsk2_kg_cm` float(11,4) DEFAULT NULL,
  `etc_bsk2_kg` float(11,4) DEFAULT NULL,
  `etc_bsk3_kg_cm` float(11,4) DEFAULT NULL,
  `etc_bsk3_kg` float(11,4) DEFAULT NULL,
  `etc_bss1_kg_cm` float(11,4) DEFAULT NULL,
  `etc_bss1_kg` float(11,4) DEFAULT NULL,
  `etc_bss2_kg_cm` float(11,4) DEFAULT NULL,
  `etc_bss2_kg` float(11,4) DEFAULT NULL,
  `etc_bss3_kg_cm` float(11,4) DEFAULT NULL,
  `etc_bss3_kg` float(11,2) DEFAULT NULL,
  `jam_olah_tbs_1` time DEFAULT NULL,
  `jam_olah_tbs_2` time DEFAULT NULL,
  `jam_olah_nut_1` time DEFAULT NULL,
  `jam_olah_nut_2` time DEFAULT NULL,
  `jam_start_1` time DEFAULT NULL,
  `jam_start_2` time DEFAULT NULL,
  `jam_stop_1` time DEFAULT NULL,
  `jam_stop_2` time DEFAULT NULL,
  `jam_main_1` time DEFAULT NULL,
  `jam_main_2` time DEFAULT NULL,
  `jam_down_1` time DEFAULT NULL,
  `jam_down_2` time DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  `cst_1_temp` float(11,4) DEFAULT NULL,
  `cst_2_temp` float(11,4) DEFAULT NULL,
  `cst_3_temp` float(11,4) DEFAULT NULL,
  `ot_1_temp` float(11,4) DEFAULT NULL,
  `ot_2_temp` float(11,4) DEFAULT NULL,
  `rcv_1_temp` float(11,4) DEFAULT NULL,
  `rcv_2_temp` float(11,4) DEFAULT NULL,
  `rcv_3_temp` float(11,4) DEFAULT NULL,
  `cot_temp` float(11,4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_processing_tbs
-- ----------------------------
INSERT INTO `tbt_processing_tbs` VALUES ('1', 'PRC/2017/05/00001', '2017-05-24', '05:23:45', '178712.0000', '12749.0000', '162930.0000', '5351.0000', '0.7064', '1.0000', '0.0000', '0.0000', '48310.0000', '109567.4062', '23243.5176', '9534.6270', '5.0000', '6.0000', '55499.0000', '13369.0000', '14286.0000', '0.0000', '0.0000', '0.0000', '233.5000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '166.5000', '52.0000', '2.6100', '0.2000', '0.0280', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2.8000', '0.0000', '0.0000', '2.7600', '0.0000', '0.0000', '0.0000', '0.0000', '2.7300', '20.7000', '0.0000', '0.0000', '0.0000', '266.0000', '0.0000', '0.0000', '0.0000', '4708.0000', '281.0000', '0.0000', '0.0000', '1758.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2.8400', '0.2100', '0.0210', '0.0000', '7.1700', '6.8200', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '247.9300', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '113.3500', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '73.7200', '0.0000', '714.4400', '0.0000', '1409.5500', '1758.0000', '40.5700', '1758.0000', '42.3200', '0.0000', '0.0000', '3139.0000', '78.5300', '3139.0000', '78.5300', '0.0000', '78.5300', '0.0000', '0.0000', '19048.0000', '460.6100', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.00', '04:28:00', '06:19:00', '04:30:00', '05:00:00', '07:00:00', '14:00:00', '14:00:00', '21:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '0', '70.0000', '77.0000', '76.0000', '74.0000', '65.0000', '60.0000', '62.0000', '0.0000', '0.0000');
INSERT INTO `tbt_processing_tbs` VALUES ('2', 'PRC/2017/05/00002', '2017-05-26', '10:21:57', '48310.0000', '12571.0000', '224487.0000', '7212.0000', '0.0000', '0.6555', '0.0000', '0.0000', '18000.0000', '12256.8203', '23642.7422', '9524.0000', '3.0000', '7.0000', '109567.4062', '23243.5176', '9534.6270', '0.0000', '0.0000', '0.0000', '237.7000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '14.0000', '45.0000', '3.0800', '0.5000', '0.0400', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2.7400', '0.0000', '0.0000', '2.8300', '0.0000', '0.0000', '0.0000', '0.0000', '2.6600', '0.0000', '0.0000', '0.0000', '9524.0000', '268.0000', '0.0000', '0.0000', '0.0000', '6278.0000', '286.0000', '129.0000', '0.0000', '0.0000', '148600.0000', '32340.0000', '27780.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2.9200', '0.2000', '0.0200', '0.0000', '7.3600', '6.7800', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '247.9300', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '113.3500', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '73.7200', '0.0000', '714.4400', '0.0000', '1409.5500', '1758.0000', '40.5700', '1758.0000', '42.3200', '0.0000', '0.0000', '3139.0000', '78.5300', '3139.0000', '78.5300', '0.0000', '78.5300', '0.0000', '0.0000', '19048.0000', '460.6100', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.00', '03:16:00', '06:15:00', '03:00:00', '06:00:00', '07:00:00', '15:00:00', '15:00:00', '22:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '0', '70.0000', '77.0000', '76.0000', '75.0000', '65.0000', '60.0000', '62.0000', '0.0000', '0.0000');
INSERT INTO `tbt_processing_tbs` VALUES ('3', 'PRC/2017/05/00003', '2017-05-29', '03:32:16', '18000.0000', '18528.0000', '200605.0000', '6397.0000', '0.0000', '0.0000', '0.0000', '0.0000', '237133.0000', '12256.8203', '23642.7422', '9524.0000', '0.0000', '0.0000', '12256.8203', '23642.7422', '9524.0000', '0.0000', '0.0000', '0.0000', '237.7000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '14.0000', '45.0000', '3.0800', '0.5000', '0.0400', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2.7400', '0.0000', '0.0000', '2.8300', '0.0000', '0.0000', '0.0000', '0.0000', '2.6600', '0.0000', '0.0000', '0.0000', '9524.0000', '268.0000', '0.0000', '0.0000', '0.0000', '6278.0000', '286.0000', '129.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2.9200', '0.2000', '0.0200', '0.0000', '7.3600', '6.7800', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '247.9300', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '113.3500', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '73.7200', '0.0000', '714.4400', '0.0000', '1409.5500', '1758.0000', '40.5700', '1758.0000', '42.3200', '0.0000', '0.0000', '3139.0000', '78.5300', '3139.0000', '78.5300', '0.0000', '78.5300', '0.0000', '0.0000', '19048.0000', '460.6100', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '0', '70.0000', '77.0000', '76.0000', '75.0000', '65.0000', '60.0000', '62.0000', '0.0000', '0.0000');
INSERT INTO `tbt_processing_tbs` VALUES ('4', 'PRC/2017/06/00001', '2017-06-09', '16:52:52', '27670.9707', '32094.0000', '220613.0000', '8323.0000', '0.0000', '0.0000', '0.0000', '0.0000', '280378.0000', '17199.8262', '26252.9941', '1384.0000', '0.0000', '0.0000', '182987.7500', '26252.9902', '31484.4707', '0.0000', '0.0000', '0.0000', '265.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '26.9200', '51.0000', '3.2700', '0.2800', '1.0560', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2.6600', '0.0000', '0.0000', '2.7400', '0.0000', '0.0000', '0.0000', '0.0000', '2.4800', '0.0000', '0.0000', '0.0000', '1384.0000', '0.0000', '0.0000', '310.0000', '0.0000', '1569.0000', '357.0000', '467.0000', '0.0000', '0.0000', '165790.0000', '30100.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '2.8500', '0.2400', '0.0210', '0.0000', '7.2800', '6.3200', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '247.9300', '5379.0000', '0.0000', '0.0000', '0.0000', '0.0000', '113.3500', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '73.7200', '0.0000', '714.4400', '0.0000', '1409.5500', '0.0000', '40.5700', '1758.0000', '42.3200', '1758.0000', '0.0000', '0.0000', '78.5300', '3139.0000', '78.5300', '3139.0000', '78.5300', '0.0000', '0.0000', '0.0000', '460.6100', '19048.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '00:00:00', '0', '70.0000', '77.0000', '76.0000', '80.0000', '65.0000', '60.0000', '62.0000', '0.0000', '0.0000');

-- ----------------------------
-- Table structure for tbt_purchase_order
-- ----------------------------
DROP TABLE IF EXISTS `tbt_purchase_order`;
CREATE TABLE `tbt_purchase_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_ro` int(11) DEFAULT NULL,
  `status` char(1) DEFAULT '0',
  `no_po` varchar(255) DEFAULT NULL,
  `tgl_po` date DEFAULT NULL,
  `tgl_jatuh_tempo` date DEFAULT NULL,
  `id_supplier` int(11) DEFAULT NULL,
  `catatan` text,
  `ppn` float(11,2) DEFAULT NULL,
  `dp` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_purchase_order
-- ----------------------------
INSERT INTO `tbt_purchase_order` VALUES ('1', '1', '3', 'PO/2017/05/00001', '2017-05-09', '2017-06-10', '1', null, '10.00', '5000000.00', '0');
INSERT INTO `tbt_purchase_order` VALUES ('2', '2', '2', 'PO/2017/05/00002', '2017-05-23', '2017-06-30', '6', null, '0.00', '500000.00', '0');
INSERT INTO `tbt_purchase_order` VALUES ('3', '3', '2', 'PO/2017/05/00003', '2017-05-25', '2017-07-19', '4', null, '0.00', '0.00', '0');
INSERT INTO `tbt_purchase_order` VALUES ('4', '4', '2', 'PO/2017/05/00004', '2017-05-26', '2017-08-24', '3', null, '10.00', '0.00', '0');

-- ----------------------------
-- Table structure for tbt_purchase_order_biaya_lain
-- ----------------------------
DROP TABLE IF EXISTS `tbt_purchase_order_biaya_lain`;
CREATE TABLE `tbt_purchase_order_biaya_lain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_po` int(11) DEFAULT NULL,
  `nama_biaya` varchar(255) DEFAULT NULL,
  `biaya` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_purchase_order_biaya_lain
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_purchase_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbt_purchase_order_detail`;
CREATE TABLE `tbt_purchase_order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) DEFAULT '0',
  `id_ro_detail` int(11) DEFAULT NULL,
  `id_po` int(11) DEFAULT NULL,
  `id_barang` int(11) DEFAULT NULL,
  `id_satuan` int(11) DEFAULT NULL,
  `jumlah` float(11,2) DEFAULT NULL,
  `jumlah_diterima` float(11,2) DEFAULT '0.00',
  `harga_satuan_besar` float(11,2) DEFAULT NULL,
  `harga_satuan` float(11,2) DEFAULT NULL,
  `discount` float(11,2) DEFAULT NULL,
  `subtotal` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_purchase_order_detail
-- ----------------------------
INSERT INTO `tbt_purchase_order_detail` VALUES ('1', '1', '1', '1', '6', '14', '10.00', '10.00', '3850000.00', '3850000.00', '0.00', '38500000.00', '0');
INSERT INTO `tbt_purchase_order_detail` VALUES ('2', '1', '2', '1', '7', '12', '500.00', '500.00', '1800.00', '1800.00', '0.00', '900000.00', '0');
INSERT INTO `tbt_purchase_order_detail` VALUES ('3', '1', '3', '2', '13', '22', '10.00', '10.00', '0.00', '200000.00', '0.00', '2000000.00', '0');
INSERT INTO `tbt_purchase_order_detail` VALUES ('4', '1', '4', '2', '14', '22', '40.00', '40.00', '0.00', '150000.00', '0.00', '6000000.00', '0');
INSERT INTO `tbt_purchase_order_detail` VALUES ('5', '1', '5', '3', '12', '24', '4.00', '4.00', '0.00', '1340000.00', '0.00', '5360000.00', '0');
INSERT INTO `tbt_purchase_order_detail` VALUES ('6', '1', '6', '3', '13', '27', '13.00', '13.00', '200000.00', '200000.00', '0.00', '2600000.00', '0');
INSERT INTO `tbt_purchase_order_detail` VALUES ('7', '1', '7', '4', '785', '36', '400.00', '400.00', '0.00', '43000.00', '0.00', '17200000.00', '0');

-- ----------------------------
-- Table structure for tbt_receiving_order
-- ----------------------------
DROP TABLE IF EXISTS `tbt_receiving_order`;
CREATE TABLE `tbt_receiving_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_po` int(11) DEFAULT NULL,
  `no_document` varchar(60) DEFAULT NULL,
  `no_faktur` varchar(60) DEFAULT NULL,
  `tgl_terima` date DEFAULT NULL,
  `catatan` text,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_receiving_order
-- ----------------------------
INSERT INTO `tbt_receiving_order` VALUES ('1', '1', 'RC/2017/05/00001', '12423', '2017-05-09', null, '0');
INSERT INTO `tbt_receiving_order` VALUES ('2', '1', 'RC/2017/05/00002', '12423423', '2017-05-09', null, '0');
INSERT INTO `tbt_receiving_order` VALUES ('3', '1', 'RC/2017/05/00003', '8989545', '2017-05-09', null, '0');
INSERT INTO `tbt_receiving_order` VALUES ('4', '2', 'RC/2017/05/00004', '', '2017-05-23', null, '0');
INSERT INTO `tbt_receiving_order` VALUES ('5', '3', 'RC/2017/05/00005', 'FA09283245', '2017-05-24', null, '0');
INSERT INTO `tbt_receiving_order` VALUES ('6', '4', 'RC/2017/06/00001', 'C171061', '2017-06-02', null, '0');

-- ----------------------------
-- Table structure for tbt_receiving_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbt_receiving_order_detail`;
CREATE TABLE `tbt_receiving_order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_parent` int(11) DEFAULT NULL,
  `id_po_detail` int(11) DEFAULT NULL,
  `id_barang` int(11) DEFAULT NULL,
  `id_satuan` int(11) DEFAULT NULL,
  `expired_date` date DEFAULT NULL,
  `jumlah` float(11,2) DEFAULT NULL,
  `harga_satuan_besar` float(11,2) DEFAULT NULL,
  `harga_satuan` float(11,2) DEFAULT NULL,
  `discount` float(11,2) DEFAULT NULL,
  `subtotal` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_receiving_order_detail
-- ----------------------------
INSERT INTO `tbt_receiving_order_detail` VALUES ('1', '1', '1', '6', '14', '2020-09-01', '10.00', '3900000.00', '3900000.00', '15.00', '33150000.00', '0');
INSERT INTO `tbt_receiving_order_detail` VALUES ('2', '2', '2', '7', '12', '2020-09-01', '250.00', '2000.00', '2000.00', '5.00', '475000.00', '0');
INSERT INTO `tbt_receiving_order_detail` VALUES ('3', '3', '2', '7', '12', '2021-09-01', '250.00', '3000.00', '3000.00', '10.00', '675000.00', '0');
INSERT INTO `tbt_receiving_order_detail` VALUES ('4', '4', '3', '13', '22', '2019-02-01', '10.00', '200000.00', '200000.00', '0.00', '2000000.00', '0');
INSERT INTO `tbt_receiving_order_detail` VALUES ('5', '4', '4', '14', '22', '2103-02-01', '40.00', '150000.00', '150000.00', '0.00', '6000000.00', '0');
INSERT INTO `tbt_receiving_order_detail` VALUES ('6', '5', '5', '12', '24', '2018-01-01', '4.00', '1340000.00', '1340000.00', '0.00', '5360000.00', '0');
INSERT INTO `tbt_receiving_order_detail` VALUES ('7', '5', '6', '13', '27', '2020-02-01', '13.00', '200000.00', '200000.00', '0.00', '2600000.00', '0');
INSERT INTO `tbt_receiving_order_detail` VALUES ('8', '6', '7', '785', '36', '2017-08-01', '400.00', '43000.00', '43000.00', '0.00', '17200000.00', '0');

-- ----------------------------
-- Table structure for tbt_reporting_processing_tbs
-- ----------------------------
DROP TABLE IF EXISTS `tbt_reporting_processing_tbs`;
CREATE TABLE `tbt_reporting_processing_tbs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_processing` int(11) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  `tbs_kebun_sum` float(11,4) DEFAULT NULL,
  `tbs_luar_sum` float(11,4) DEFAULT NULL,
  `tbs_potongan_sum` float(11,4) DEFAULT NULL,
  `tbs_persediaan_sum` float(11,4) DEFAULT NULL,
  `tbs_olah_netto_sum` float(11,4) DEFAULT NULL,
  `tbs_olah_brutto_sum` float(11,4) DEFAULT NULL,
  `kirim_cpo_sum` float(11,4) DEFAULT NULL,
  `kirim_pk_sum` float(11,4) DEFAULT NULL,
  `kirim_cangkang_sum` float(11,4) DEFAULT NULL,
  `kirim_fibre_sum` float(11,4) DEFAULT NULL,
  `kirim_limbah_sum` float(11,4) DEFAULT NULL,
  `kirim_jangkos_sum` float(11,4) DEFAULT NULL,
  `jam_olah_tbs_sum` varchar(100) DEFAULT NULL,
  `jam_olah_nut_sum` varchar(100) DEFAULT NULL,
  `jam_main_sum` varchar(100) DEFAULT NULL,
  `jam_down_sum` varchar(100) DEFAULT NULL,
  `cpo_sum` float(11,4) DEFAULT NULL,
  `pk_sum` float(11,4) DEFAULT NULL,
  `reject_cpo_sum` float(11,4) DEFAULT NULL,
  `reject_kernel_sum` float(11,4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_reporting_processing_tbs
-- ----------------------------
INSERT INTO `tbt_reporting_processing_tbs` VALUES ('1', '1', '0', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0.0000', '0', '0', '0', '0', '0.0000', '0.0000', '0.0000', '0.0000');
INSERT INTO `tbt_reporting_processing_tbs` VALUES ('2', '2', '0', '12571.0000', '224487.0000', '7212.0000', '292580.0000', '267368.0000', '274580.0000', '148600.0000', '32340.0000', '27780.0000', '0.0000', '0.0000', '0.0000', '09:31', '09:00', '00:00', '00:00', '49931.0000', '32329.3730', '0.0000', '0.0000');
INSERT INTO `tbt_reporting_processing_tbs` VALUES ('3', '3', '0', '31099.0000', '425092.0000', '13609.0000', '536110.0000', '267368.0000', '274580.0000', '148600.0000', '32340.0000', '27780.0000', '0.0000', '0.0000', '0.0000', '09:31', '09:00', '00:00', '00:00', '48173.0000', '32329.3730', '0.0000', '0.0000');
INSERT INTO `tbt_reporting_processing_tbs` VALUES ('4', '4', '0', '63193.0000', '645705.0000', '21932.0000', '824811.0000', '267368.0000', '274580.0000', '314390.0000', '62440.0000', '27780.0000', '0.0000', '0.0000', '0.0000', '09:31', '09:00', '00:00', '00:00', '48176.0000', '32328.9023', '0.0000', '0.0000');

-- ----------------------------
-- Table structure for tbt_request_order
-- ----------------------------
DROP TABLE IF EXISTS `tbt_request_order`;
CREATE TABLE `tbt_request_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) DEFAULT '0',
  `no_ro` varchar(255) DEFAULT NULL,
  `tgl_ro` date DEFAULT NULL,
  `catatan` text,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_request_order
-- ----------------------------
INSERT INTO `tbt_request_order` VALUES ('1', '1', 'RO/2017/05/00001', '2017-05-09', null, '0');
INSERT INTO `tbt_request_order` VALUES ('2', '1', 'RO/2017/05/00002', '2017-05-23', null, '0');
INSERT INTO `tbt_request_order` VALUES ('3', '1', 'RO/2017/05/00003', '2017-05-25', null, '0');
INSERT INTO `tbt_request_order` VALUES ('4', '1', 'RO/2017/05/00004', '2017-05-26', null, '0');

-- ----------------------------
-- Table structure for tbt_request_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbt_request_order_detail`;
CREATE TABLE `tbt_request_order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) DEFAULT '0',
  `id_ro` int(11) DEFAULT NULL,
  `id_barang` int(11) DEFAULT NULL,
  `id_satuan` int(11) DEFAULT NULL,
  `jumlah` float(11,2) DEFAULT NULL,
  `harga_satuan_besar` float(11,2) DEFAULT NULL,
  `harga_satuan` float(11,2) DEFAULT NULL,
  `subtotal` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_request_order_detail
-- ----------------------------
INSERT INTO `tbt_request_order_detail` VALUES ('1', '1', '1', '6', '14', '10.00', '3850000.00', '3850000.00', '38500000.00', '0');
INSERT INTO `tbt_request_order_detail` VALUES ('2', '1', '1', '7', '12', '500.00', '1800.00', '1800.00', '900000.00', '0');
INSERT INTO `tbt_request_order_detail` VALUES ('3', '1', '2', '13', '22', '10.00', '0.00', '200000.00', '2000000.00', '0');
INSERT INTO `tbt_request_order_detail` VALUES ('4', '1', '2', '14', '22', '40.00', '0.00', '150000.00', '6000000.00', '0');
INSERT INTO `tbt_request_order_detail` VALUES ('5', '1', '3', '12', '24', '4.00', '0.00', '1340000.00', '5360000.00', '0');
INSERT INTO `tbt_request_order_detail` VALUES ('6', '1', '3', '13', '27', '13.00', '200000.00', '200000.00', '2600000.00', '0');
INSERT INTO `tbt_request_order_detail` VALUES ('7', '1', '4', '785', '36', '400.00', '0.00', '43000.00', '17200000.00', '0');

-- ----------------------------
-- Table structure for tbt_resign_employee
-- ----------------------------
DROP TABLE IF EXISTS `tbt_resign_employee`;
CREATE TABLE `tbt_resign_employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_karyawan` int(11) DEFAULT NULL,
  `tgl_resign` date DEFAULT NULL,
  `kategori_resign` text,
  `keterangan` text,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbt_resign_employee
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_revenue_transaction
-- ----------------------------
DROP TABLE IF EXISTS `tbt_revenue_transaction`;
CREATE TABLE `tbt_revenue_transaction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transaction_no` varchar(60) DEFAULT NULL,
  `tgl_transaksi` date DEFAULT NULL,
  `no_referensi` varchar(60) DEFAULT NULL,
  `revenue_category_id` int(11) DEFAULT NULL,
  `revenue_id` int(11) DEFAULT NULL,
  `deskripsi` varchar(100) DEFAULT NULL,
  `coa_id` int(11) DEFAULT NULL,
  `bank_id` int(11) DEFAULT NULL,
  `total_revenue` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbt_revenue_transaction
-- ----------------------------
INSERT INTO `tbt_revenue_transaction` VALUES ('1', 'REV/2017/05/00001', '2017-05-01', '997633', '1', '1', 'Modal Awal', '361', '3', '100000000.00', '0');
INSERT INTO `tbt_revenue_transaction` VALUES ('2', 'REV/2017/05/00002', '2017-05-01', '32423', '1', '1', 'Pendapatan Jasa Lain-lain', '786', '3', '3250000.00', '0');
INSERT INTO `tbt_revenue_transaction` VALUES ('3', 'REV/2017/05/00003', '2017-05-01', '9475934', '1', '1', 'Setoran Modal ', '845', '3', '25000000.00', '0');

-- ----------------------------
-- Table structure for tbt_sanksi
-- ----------------------------
DROP TABLE IF EXISTS `tbt_sanksi`;
CREATE TABLE `tbt_sanksi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_karyawan` int(11) DEFAULT NULL,
  `payroll_id` int(11) DEFAULT NULL,
  `tgl_sanksi` date DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbt_sanksi
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_santunan
-- ----------------------------
DROP TABLE IF EXISTS `tbt_santunan`;
CREATE TABLE `tbt_santunan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_karyawan` int(11) DEFAULT NULL,
  `id_payroll` int(11) DEFAULT NULL,
  `tgl_santunan` date DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbt_santunan
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_stock_opname
-- ----------------------------
DROP TABLE IF EXISTS `tbt_stock_opname`;
CREATE TABLE `tbt_stock_opname` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_stock_opname` varchar(60) DEFAULT NULL,
  `tgl_stock_opname` date DEFAULT NULL,
  `wkt_stock_opname` time DEFAULT NULL,
  `jumlah_barang` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_stock_opname
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_stock_opname_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbt_stock_opname_detail`;
CREATE TABLE `tbt_stock_opname_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_stock_opname` int(11) DEFAULT '0',
  `id_barang` int(11) DEFAULT NULL,
  `id_satuan` int(11) DEFAULT NULL,
  `stok_awal` float(11,2) DEFAULT NULL,
  `stok_akhir` float(11,2) DEFAULT NULL,
  `perbedaan` float(11,2) DEFAULT NULL,
  `status` char(1) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_stock_opname_detail
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_stok_in_out
-- ----------------------------
DROP TABLE IF EXISTS `tbt_stok_in_out`;
CREATE TABLE `tbt_stok_in_out` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_barang` int(11) DEFAULT NULL,
  `stok_awal` float(11,2) DEFAULT NULL,
  `stok_in` float(11,2) DEFAULT NULL,
  `nilai_in` float(11,2) DEFAULT NULL,
  `stok_out` float(11,2) DEFAULT NULL,
  `nilai_out` float(11,2) DEFAULT NULL,
  `stok_akhir` float(11,2) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `id_transaksi` int(11) DEFAULT NULL,
  `jns_transaksi` char(1) DEFAULT NULL,
  `tgl` date DEFAULT NULL,
  `wkt` time DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_stok_in_out
-- ----------------------------
INSERT INTO `tbt_stok_in_out` VALUES ('1', '6', '0.00', '10000000.00', '39000000.00', '0.00', '0.00', '10000000.00', '', '1', '1', '2017-05-09', '15:07:47', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('2', '7', '0.00', '250000.00', '500000.00', '0.00', '0.00', '250000.00', '', '2', '1', '2017-05-09', '15:08:23', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('3', '7', '250000.00', '250000.00', '750000.00', '0.00', '0.00', '500000.00', '', '3', '1', '2017-05-09', '15:09:09', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('4', '9', '0.00', '8374000.00', '25122000.00', '0.00', '0.00', '8374000.00', '', '1', '2', '2017-05-09', '15:16:57', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('5', '9', '8374000.00', '0.00', null, '5000000.00', null, '3374000.00', 'Produksi Commodity CPO & PK', '1', '6', '2017-05-09', '15:20:07', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('6', '10', '0.00', '2500.00', null, '0.00', null, '2500.00', 'Produksi Commodity CPO & PK', '1', '6', '2017-05-09', '15:20:07', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('7', '11', '0.00', '2500.00', null, '0.00', null, '2500.00', 'Produksi Commodity CPO & PK', '1', '6', '2017-05-09', '15:20:07', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('8', '11', '2500.00', '0.00', '0.00', '1500.00', '21750000.00', '1000.00', 'Penjualan Commodity CPO & PK', '1', '7', '2017-05-09', '15:21:00', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('9', '1021', '0.00', '7265000.00', '11260750.00', '0.00', '0.00', '7265000.00', '', '2', '2', '2017-05-23', '04:21:44', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('10', '1021', '7265000.00', '6615000.00', '10253250.00', '0.00', '0.00', '13880000.00', '', '3', '2', '2017-05-23', '04:21:45', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('11', '1021', '13880000.00', '8623000.00', '13365650.00', '0.00', '0.00', '22503000.00', '', '4', '2', '2017-05-23', '04:21:45', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('12', '1021', '22503000.00', '6499000.00', '9423550.00', '0.00', '0.00', '29002000.00', '', '5', '2', '2017-05-23', '05:14:41', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('13', '13', '0.00', '100.00', '2000000.00', '0.00', '0.00', '100.00', '', '4', '1', '2017-05-23', '05:49:24', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('14', '14', '0.00', '200.00', '6000000.00', '0.00', '0.00', '200.00', '', '5', '1', '2017-05-23', '05:49:24', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('15', '1021', '29002000.00', '3453000.00', '5352150.00', '0.00', '0.00', '32455000.00', '', '6', '2', '2017-05-23', '09:47:00', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('16', '1021', '32455000.00', '495000000.00', '767249984.00', '0.00', '0.00', '527455008.00', '', '7', '2', '2017-05-23', '09:47:00', 'ADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('17', '1021', '527455008.00', '0.00', '0.00', '306081.00', '0.00', '527148928.00', '', '1', '9', '2017-05-24', '05:23:46', 'HADISYA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('18', '10', '2500.00', '132810.92', '0.00', '0.00', '0.00', '135310.92', '', '1', '9', '2017-05-24', '05:23:46', 'HADISYA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('19', '11', '1000.00', '9534.63', '0.00', '0.00', '0.00', '10534.63', '', '1', '9', '2017-05-24', '05:23:46', 'HADISYA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('20', '11', '10534.63', '0.00', '0.00', '1000.00', '6180000.00', '9534.63', 'Penjualan Commodity CPO & PK', '2', '7', '2017-05-24', '10:02:18', 'XADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('21', '12', '0.00', '4000.00', '5360000.00', '0.00', '0.00', '4000.00', '', '6', '1', '2017-05-24', '11:06:55', 'FUTRI', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('22', '13', '100.00', '260.00', '2600000.00', '0.00', '0.00', '360.00', '', '7', '1', '2017-05-24', '11:06:55', 'FUTRI', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('23', '1021', '527148928.00', '0.00', '0.00', '267368.00', '0.00', '526881568.00', '', '2', '9', '2017-05-26', '10:21:57', 'HADISYA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('24', '10', '135310.92', '35899.56', '0.00', '0.00', '0.00', '171210.48', '', '2', '9', '2017-05-26', '10:21:57', 'HADISYA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('25', '11', '9534.63', '9524.00', '0.00', '0.00', '0.00', '19058.63', '', '2', '9', '2017-05-26', '10:21:57', 'HADISYA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('26', '1021', '526881568.00', '4753000.00', '8579165.00', '0.00', '0.00', '531634560.00', '', '8', '2', '2017-05-26', '10:30:55', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('27', '1021', '531634560.00', '5141000.00', '9279505.00', '0.00', '0.00', '536775552.00', '', '9', '2', '2017-05-26', '10:30:55', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('28', '1021', '536775552.00', '1785000.00', '3221925.00', '0.00', '0.00', '538560576.00', '', '10', '2', '2017-05-26', '10:30:55', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('29', '1021', '538560576.00', '2522000.00', '4526990.00', '0.00', '0.00', '541082560.00', '', '11', '2', '2017-05-26', '10:30:55', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('30', '1021', '541082560.00', '5248000.00', '9472640.00', '0.00', '0.00', '546330560.00', '', '12', '2', '2017-05-26', '10:30:56', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('31', '1021', '546330560.00', '3182000.00', '5743510.00', '0.00', '0.00', '549512576.00', '', '13', '2', '2017-05-26', '10:30:56', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('32', '1021', '549512576.00', '6480000.00', '11210400.00', '0.00', '0.00', '555992576.00', '', '14', '2', '2017-05-26', '10:32:59', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('33', '1021', '555992576.00', '6897000.00', '11862840.00', '0.00', '0.00', '562889600.00', '', '15', '2', '2017-05-26', '10:32:59', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('34', '1021', '562889600.00', '5510000.00', '9477200.00', '0.00', '0.00', '568399616.00', '', '16', '2', '2017-05-26', '10:32:59', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('35', '1021', '568399616.00', '3987000.00', '6857640.00', '0.00', '0.00', '572386624.00', '', '17', '2', '2017-05-26', '10:34:09', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('36', '1021', '572386624.00', '7256000.00', '12552880.00', '0.00', '0.00', '579642624.00', '', '18', '2', '2017-05-26', '10:34:09', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('37', '1021', '579642624.00', '5851000.00', '10122230.00', '0.00', '0.00', '585493632.00', '', '19', '2', '2017-05-26', '10:34:09', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('38', '1021', '585493632.00', '6707000.00', '11603110.00', '0.00', '0.00', '592200640.00', '', '20', '2', '2017-05-26', '10:34:09', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('39', '1021', '592200640.00', '2381000.00', '4119130.00', '0.00', '0.00', '594581632.00', '', '21', '2', '2017-05-26', '10:34:10', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('40', '1021', '594581632.00', '4753000.00', '8222690.00', '0.00', '0.00', '599334656.00', '', '22', '2', '2017-05-26', '10:34:10', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('41', '1021', '599334656.00', '6334000.00', '10957820.00', '0.00', '0.00', '605668672.00', '', '23', '2', '2017-05-26', '10:34:10', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('42', '1021', '605668672.00', '1872000.00', '3238560.00', '0.00', '0.00', '607540672.00', '', '24', '2', '2017-05-26', '10:34:10', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('43', '1021', '607540672.00', '4811000.00', '8323030.00', '0.00', '0.00', '612351680.00', '', '25', '2', '2017-05-26', '10:37:22', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('44', '1021', '612351680.00', '5587000.00', '9609640.00', '0.00', '0.00', '617938688.00', '', '26', '2', '2017-05-26', '10:37:22', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('45', '1021', '617938688.00', '4016000.00', '6947680.00', '0.00', '0.00', '621954688.00', '', '27', '2', '2017-05-26', '10:37:22', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('46', '1021', '621954688.00', '3249000.00', '5620770.00', '0.00', '0.00', '625203712.00', '', '28', '2', '2017-05-26', '10:37:22', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('47', '1021', '625203712.00', '5393000.00', '9329890.00', '0.00', '0.00', '630596736.00', '', '29', '2', '2017-05-26', '10:37:23', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('48', '1021', '630596736.00', '5597000.00', '9682810.00', '0.00', '0.00', '636193728.00', '', '30', '2', '2017-05-26', '10:37:23', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('49', '1021', '636193728.00', '4103000.00', '7098190.00', '0.00', '0.00', '640296704.00', '', '31', '2', '2017-05-26', '10:37:23', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('50', '1021', '640296704.00', '4637000.00', '8022010.00', '0.00', '0.00', '644933696.00', '', '32', '2', '2017-05-26', '10:37:23', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('51', '1021', '644933696.00', '1959000.00', '3389070.00', '0.00', '0.00', '646892672.00', '', '33', '2', '2017-05-26', '10:37:24', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('52', '1021', '646892672.00', '6528000.00', '11293440.00', '0.00', '0.00', '653420672.00', '', '34', '2', '2017-05-26', '10:37:59', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('53', '1021', '653420672.00', '5995000.00', '10371350.00', '0.00', '0.00', '659415680.00', '', '35', '2', '2017-05-26', '10:37:59', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('54', '1021', '659415680.00', '6882000.00', '11905860.00', '0.00', '0.00', '666297664.00', '', '36', '2', '2017-05-26', '10:44:53', 'GITA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('55', '1021', '666297664.00', '5907000.00', '10219110.00', '0.00', '0.00', '672204672.00', '', '37', '2', '2017-05-27', '04:25:19', 'GITA ', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('56', '1021', '672204672.00', '5034000.00', '8708820.00', '0.00', '0.00', '677238656.00', '', '38', '2', '2017-05-27', '04:25:19', 'GITA ', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('57', '1020', '0.00', '6363000.00', '8908200.00', '0.00', '0.00', '6363000.00', '', '39', '2', '2017-05-27', '04:57:58', 'GITA ', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('58', '1021', '677238656.00', '2137000.00', '3675640.00', '0.00', '0.00', '679375680.00', '', '40', '2', '2017-05-27', '04:58:22', 'GITA ', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('59', '1021', '679375680.00', '6741000.00', '11661930.00', '0.00', '0.00', '686116672.00', '', '41', '2', '2017-05-27', '04:59:41', 'GITA ', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('60', '1021', '686116672.00', '5832000.00', '10089360.00', '0.00', '0.00', '691948672.00', '', '42', '2', '2017-05-27', '05:00:30', 'GITA ', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('61', '1020', '6363000.00', '4249000.00', '0.00', '0.00', '0.00', '10612000.00', '', '43', '2', '2017-05-27', '05:00:46', 'GITA ', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('62', '897', null, '0.00', '0.00', '3.00', '0.00', '-3.00', '', '1', '3', '2017-05-27', '06:36:07', 'FUTRI', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('63', '343', null, '0.00', '0.00', '6.00', '0.00', '-6.00', '', '2', '3', '2017-05-27', '06:36:08', 'FUTRI', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('64', '892', null, '0.00', '0.00', '2.00', '0.00', '-2.00', '', '3', '3', '2017-05-27', '06:36:08', 'FUTRI', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('65', '857', null, '0.00', '0.00', '1.00', '0.00', '-1.00', '', '4', '3', '2017-05-27', '06:36:08', 'FUTRI', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('66', '874', null, '0.00', '0.00', '1.00', '0.00', '-1.00', '', '5', '3', '2017-05-27', '06:36:08', 'FUTRI', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('67', '196', null, '0.00', '0.00', '1.00', '0.00', '-1.00', '', '6', '3', '2017-05-27', '06:36:08', 'FUTRI', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('68', '195', null, '0.00', '0.00', '1.00', '0.00', '-1.00', '', '7', '3', '2017-05-27', '06:36:08', 'FUTRI', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('69', '1020', '10612000.00', '0.00', '0.00', '0.00', '0.00', '10612000.00', '', '3', '9', '2017-05-29', '03:32:16', 'HADISYA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('70', '1021', '691948672.00', '0.00', '0.00', '0.00', '0.00', '691948672.00', '', '3', '9', '2017-05-29', '03:32:16', 'HADISYA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('71', '10', '171210.48', '35899.56', '0.00', '0.00', '0.00', '207110.05', '', '3', '9', '2017-05-29', '03:32:16', 'HADISYA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('72', '11', '19058.63', '9524.00', '0.00', '0.00', '0.00', '28582.63', '', '3', '9', '2017-05-29', '03:32:16', 'HADISYA', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('73', '785', '0.00', '400.00', '17200000.00', '0.00', '0.00', '400.00', '', '8', '1', '2017-06-02', '06:34:18', 'FUTRI', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('74', '1021', '691948672.00', '11812000.00', '29530000.00', '0.00', '0.00', '703760640.00', '', '16', '2', '2017-06-04', '10:22:14', 'XADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('75', '1021', '703760640.00', '11812000.00', '29530000.00', '0.00', '0.00', '715572608.00', '', '17', '2', '2017-06-04', '10:32:59', 'XADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('76', '1021', '715572608.00', '11812000.00', '29530000.00', '0.00', '0.00', '727384576.00', '', '18', '2', '2017-06-04', '10:35:17', 'XADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('77', '1020', '10612000.00', '14968000.00', '71428496.00', '0.00', '0.00', '25580000.00', '', '21', '2', '2017-06-04', '16:20:48', 'XADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('78', '1021', '727384576.00', '19624000.00', '58872000.00', '0.00', '0.00', '747008576.00', '', '22', '2', '2017-06-04', '16:25:30', 'XADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('79', '1021', '747008576.00', '6755000.00', '16887500.00', '0.00', '0.00', '753763584.00', '', '23', '2', '2017-06-04', '16:29:45', 'XADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('80', '1021', '753763584.00', '11175000.00', '33525000.00', '0.00', '0.00', '764938560.00', '', '24', '2', '2017-06-04', '16:30:43', 'XADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('81', '11', '28582.63', '0.00', '0.00', '5000.00', '30900000.00', '23582.63', 'Penjualan Commodity', '3', '7', '2017-06-06', '11:14:24', 'XADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('82', '10', '207110.05', '0.00', '0.00', '30570.00', '91710000.00', '176540.05', 'Penjualan Commodity', '1', '7', '2017-06-09', '14:35:01', 'XADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('83', '10', '176540.05', '0.00', '0.00', '30570.00', '91710000.00', '145970.05', 'Penjualan Commodity', '1', '7', '2017-06-09', '15:21:51', 'XADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('84', '1020', '25580000.00', '0.00', '0.00', '0.00', '0.00', '25580000.00', '', '4', '9', '2017-06-09', '16:52:53', 'XADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('85', '1021', '764938560.00', '0.00', '0.00', '0.00', '0.00', '764938560.00', '', '4', '9', '2017-06-09', '16:52:53', 'XADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('86', '10', '145970.05', '43452.82', '0.00', '0.00', '0.00', '189422.88', '', '4', '9', '2017-06-09', '16:52:53', 'XADMIN', '0');
INSERT INTO `tbt_stok_in_out` VALUES ('87', '11', '23582.63', '1384.00', '0.00', '0.00', '0.00', '24966.63', '', '4', '9', '2017-06-09', '16:52:53', 'XADMIN', '0');

-- ----------------------------
-- Table structure for tbt_tbs_order
-- ----------------------------
DROP TABLE IF EXISTS `tbt_tbs_order`;
CREATE TABLE `tbt_tbs_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_tbs_order` varchar(30) DEFAULT NULL,
  `id_pemasok` int(11) DEFAULT NULL,
  `id_barang` int(11) DEFAULT NULL,
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT NULL,
  `tgl_jatuh_tempo` date DEFAULT NULL,
  `status` char(1) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_tbs_order
-- ----------------------------
INSERT INTO `tbt_tbs_order` VALUES ('1', 'TBS/2017/05/00001', '12', '1021', '2017-05-22', '06:45:52', null, '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('2', 'TBS/2017/05/00002', '3', '1021', '2017-05-22', '06:49:35', null, '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('3', 'TBS/2017/05/00003', '10', '1021', '2017-05-22', '07:00:19', null, '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('4', 'TBS/2017/05/00004', '3', '1021', '2017-05-23', '11:37:03', null, '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('5', 'TBS/2017/05/00005', '12', '1021', '2017-05-23', '11:37:58', null, '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('6', 'TBS/2017/05/00006', '2', '1021', '2017-05-23', '11:38:45', null, '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('7', 'TBS/2017/05/00007', '10', '1021', '2017-05-23', '11:45:49', null, '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('8', 'TBS/2017/05/00008', '11', '1021', '2017-05-23', '11:53:06', null, '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('9', 'TBS/2017/05/00009', '14', '1021', '2017-05-23', '11:59:45', null, '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('10', 'TBS/2017/05/00010', '19', '1021', '2017-05-23', '12:01:59', null, '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('11', 'TBS/2017/05/00011', '20', '1020', '2017-05-23', '12:14:26', null, '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('12', 'TBS/2017/05/00012', '20', '1021', '2017-05-23', '13:25:53', null, '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('13', 'TBS/2017/05/00013', '8', '1021', '2017-05-23', '13:26:35', null, '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('14', 'TBS/2017/05/00014', '5', '1021', '2017-05-23', '13:31:06', null, '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('15', 'TBS/2017/05/00015', '20', '1020', '2017-05-24', '03:05:46', null, '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('16', 'TBS/2017/05/00016', '3', '1021', '2017-05-24', '03:06:31', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('17', 'TBS/2017/05/00017', '12', '1021', '2017-05-24', '03:15:04', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('18', 'TBS/2017/05/00018', '2', '1021', '2017-05-24', '03:16:18', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('19', 'TBS/2017/05/00019', '10', '1021', '2017-05-24', '03:17:00', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('20', 'TBS/2017/05/00020', '11', '1021', '2017-05-24', '03:17:38', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('21', 'TBS/2017/05/00021', '6', '1021', '2017-05-24', '04:48:11', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('22', 'TBS/2017/05/00022', '3', '1021', '2017-05-25', '03:50:37', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('23', 'TBS/2017/05/00023', '12', '1021', '2017-05-25', '03:51:08', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('24', 'TBS/2017/05/00024', '2', '1021', '2017-05-25', '03:53:37', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('25', 'TBS/2017/05/00025', '11', '1021', '2017-05-25', '04:16:20', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('26', 'TBS/2017/05/00026', '10', '1021', '2017-05-25', '04:17:25', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('27', 'TBS/2017/05/00027', '6', '1021', '2017-05-25', '05:56:09', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('28', 'TBS/2017/05/00028', '3', '1021', '2017-05-26', '03:08:58', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('29', 'TBS/2017/05/00029', '2', '1021', '2017-05-26', '03:10:27', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('30', 'TBS/2017/05/00030', '10', '1021', '2017-05-26', '03:11:53', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('31', 'TBS/2017/05/00031', '20', '1020', '2017-05-26', '03:34:19', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('32', 'TBS/2017/05/00032', '11', '1021', '2017-05-26', '04:32:42', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('33', 'TBS/2017/05/00033', '19', '1021', '2017-05-26', '09:19:38', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('34', 'TBS/2017/05/00034', '12', '1021', '2017-05-26', '10:28:48', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('35', 'TBS/2017/05/00035', '6', '1021', '2017-05-26', '10:54:47', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('36', 'TBS/2017/05/00036', '5', '1021', '2017-05-26', '12:25:46', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('37', 'TBS/2017/05/00037', '12', '1021', '2017-05-27', '03:28:33', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('38', 'TBS/2017/05/00038', '10', '1021', '2017-05-27', '03:29:27', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('39', 'TBS/2017/05/00039', '3', '1021', '2017-05-27', '03:32:17', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('40', 'TBS/2017/05/00040', '2', '1021', '2017-05-27', '03:51:28', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('41', 'TBS/2017/05/00041', '5', '1021', '2017-05-27', '11:54:20', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('42', 'TBS/2017/05/00042', '11', '1021', '2017-05-27', '12:01:32', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('43', 'TBS/2017/05/00043', '3', '1021', '2017-05-28', '03:46:20', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('44', 'TBS/2017/05/00044', '2', '1021', '2017-05-28', '03:47:01', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('45', 'TBS/2017/05/00045', '10', '1021', '2017-05-28', '04:34:18', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('46', 'TBS/2017/05/00046', '20', '1020', '2017-05-28', '08:21:49', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('47', 'TBS/2017/05/00047', '12', '1021', '2017-05-28', '09:22:46', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('48', 'TBS/2017/05/00048', '19', '1021', '2017-05-28', '09:24:12', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('49', 'TBS/2017/05/00049', '11', '1021', '2017-05-28', '11:42:07', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('50', 'TBS/2017/05/00050', '8', '1021', '2017-05-28', '12:16:12', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('51', 'TBS/2017/05/00051', '5', '1021', '2017-05-28', '13:13:08', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('52', 'TBS/2017/05/00052', '8', '1021', '2017-05-29', '02:43:26', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('53', 'TBS/2017/05/00053', '10', '1021', '2017-05-29', '02:45:28', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('54', 'TBS/2017/05/00054', '3', '1021', '2017-05-29', '03:01:47', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('55', 'TBS/2017/05/00055', '12', '1021', '2017-05-29', '03:07:25', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('56', 'TBS/2017/05/00056', '2', '1021', '2017-05-29', '05:22:48', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('57', 'TBS/2017/05/00057', '5', '1021', '2017-05-29', '03:48:19', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('58', 'TBS/2017/05/00058', '11', '1021', '2017-05-29', '04:00:11', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('59', 'TBS/2017/05/00059', '20', '1020', '2017-05-29', '08:27:46', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('60', 'TBS/2017/05/00060', '14', '1021', '2017-05-29', '09:40:59', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('61', 'TBS/2017/05/00061', '19', '1021', '2017-05-29', '10:15:09', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('62', 'TBS/2017/05/00062', '3', '1021', '2017-05-30', '02:47:33', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('63', 'TBS/2017/05/00063', '2', '1021', '2017-05-30', '03:21:54', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('64', 'TBS/2017/05/00064', '10', '1021', '2017-05-30', '03:21:22', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('65', 'TBS/2017/05/00065', '20', '1020', '2017-05-30', '03:29:06', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('66', 'TBS/2017/05/00066', '11', '1021', '2017-05-30', '07:00:04', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('67', 'TBS/2017/05/00067', '12', '1021', '2017-05-30', '07:19:32', '2017-06-30', '1', '0');
INSERT INTO `tbt_tbs_order` VALUES ('68', 'TBS/2017/05/00068', '19', '1021', '2017-05-30', '09:12:41', '2017-12-01', '1', '0');
INSERT INTO `tbt_tbs_order` VALUES ('69', 'TBS/2017/05/00069', '14', '1021', '2017-05-30', '09:23:21', '2017-10-31', '1', '0');
INSERT INTO `tbt_tbs_order` VALUES ('70', 'TBS/2017/05/00070', '5', '1021', '2017-05-30', '13:58:32', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('71', 'TBS/2017/05/00071', '12', '1021', '2017-05-31', '03:40:40', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('72', 'TBS/2017/05/00072', '2', '1021', '2017-05-31', '03:41:54', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('73', 'TBS/2017/05/00073', '10', '1021', '2017-05-31', '03:42:24', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('74', 'TBS/2017/05/00074', '3', '1021', '2017-05-31', '03:42:58', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('75', 'TBS/2017/05/00075', '5', '1021', '2017-05-31', '03:45:02', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('76', 'TBS/2017/05/00076', '21', '1021', '2017-05-31', '04:35:55', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('77', 'TBS/2017/05/00077', '11', '1021', '2017-05-31', '05:04:41', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('78', 'TBS/2017/05/00078', '20', '1020', '2017-05-31', '08:37:27', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('79', 'TBS/2017/05/00079', '14', '1021', '2017-05-31', '09:31:31', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('80', 'TBS/2017/05/00080', '19', '1021', '2017-05-31', '10:01:05', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('81', 'TBS/2017/05/00081', '8', '1021', '2017-05-31', '12:26:21', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('82', 'TBS/2017/06/00001', '4', '1021', '2017-06-01', '04:14:43', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('83', 'TBS/2017/06/00002', '3', '1021', '2017-06-01', '04:17:54', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('84', 'TBS/2017/06/00003', '10', '1021', '2017-06-01', '04:18:41', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('85', 'TBS/2017/06/00004', '2', '1021', '2017-06-01', '04:19:49', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('86', 'TBS/2017/06/00005', '12', '1021', '2017-06-01', '04:21:01', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('87', 'TBS/2017/06/00006', '11', '1021', '2017-06-01', '04:31:04', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('88', 'TBS/2017/06/00007', '20', '1020', '2017-06-01', '09:19:36', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('89', 'TBS/2017/06/00008', '21', '1021', '2017-06-01', '11:21:37', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('90', 'TBS/2017/06/00009', '8', '1021', '2017-06-01', '11:49:03', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('91', 'TBS/2017/06/00010', '3', '1021', '2017-06-02', '02:44:16', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('92', 'TBS/2017/06/00011', '11', '1021', '2017-06-02', '03:20:47', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('93', 'TBS/2017/06/00012', '2', '1021', '2017-06-02', '03:42:44', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('94', 'TBS/2017/06/00013', '12', '1021', '2017-06-02', '04:11:44', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('95', 'TBS/2017/06/00014', '19', '1021', '2017-06-02', '06:37:18', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('96', 'TBS/2017/06/00015', '20', '1020', '2017-06-02', '08:22:24', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('97', 'TBS/2017/06/00016', '14', '1021', '2017-06-02', '10:26:33', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('98', 'TBS/2017/06/00017', '12', '1020', '2017-06-03', '19:26:09', '2017-07-31', '1', '0');
INSERT INTO `tbt_tbs_order` VALUES ('99', 'TBS/2017/06/00018', '22', '1021', '2017-06-03', '20:01:56', '2017-07-31', '2', '0');
INSERT INTO `tbt_tbs_order` VALUES ('100', 'TBS/2017/06/00019', '3', '1021', '2017-06-07', '10:46:39', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('101', 'TBS/2017/06/00020', '2', '1020', '2017-06-08', '12:02:24', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('102', 'TBS/2017/06/00021', '2', '1021', '2017-06-08', '12:03:15', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('103', 'TBS/2017/06/00022', '5', '1020', '2017-06-08', '12:04:29', null, '0', '0');
INSERT INTO `tbt_tbs_order` VALUES ('104', 'TBS/2017/06/00023', '8', '1020', '2017-06-08', '12:06:53', null, '0', '0');

-- ----------------------------
-- Table structure for tbt_tbs_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbt_tbs_order_detail`;
CREATE TABLE `tbt_tbs_order_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_tbs_order` varchar(30) DEFAULT NULL,
  `id_jenis_kendaraan` int(11) DEFAULT NULL,
  `no_polisi` varchar(60) DEFAULT NULL,
  `bruto` float(11,2) DEFAULT NULL,
  `tarra` float(11,2) DEFAULT NULL,
  `netto_1` float(11,2) DEFAULT NULL,
  `jumlah_bongkar` float(11,2) DEFAULT '0.00',
  `potongan` float(11,2) DEFAULT NULL,
  `hasil_potongan` float(11,2) DEFAULT NULL,
  `subtotal_spsi` float(11,2) DEFAULT '0.00',
  `netto_2` float(11,2) DEFAULT NULL,
  `harga` float(11,2) DEFAULT '0.00',
  `subtotal_tbs` float(11,2) DEFAULT '0.00',
  `jml_tandan` float(11,2) DEFAULT NULL,
  `komidel` float(11,2) DEFAULT NULL,
  `id_komidel` int(11) DEFAULT NULL,
  `fee` float(11,2) DEFAULT '0.00',
  `subtotal_fee` float(11,2) DEFAULT NULL,
  `ppn` float(11,2) DEFAULT NULL,
  `pph` float(11,2) DEFAULT NULL,
  `total_tbs_order` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=456 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_tbs_order_detail
-- ----------------------------
INSERT INTO `tbt_tbs_order_detail` VALUES ('1', 'TBS/2017/05/00001', '1', '123434', '12290.00', '3630.00', '8660.00', '12.00', '3.30', '286.00', '103920.00', '8374.00', '3000.00', '25122000.00', '413.00', '21.00', '4', '20.00', '167480.00', '10.00', '25.00', '21417260.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('2', 'TBS/2017/05/00002', '1', 'BK 9463 DR', '16530.00', '6820.00', '9710.00', '0.00', '3.00', '291.00', '0.00', '9419.00', '0.00', '0.00', '250.00', '39.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('3', '1', '1', 'BA 8049 AB', '10680.00', '3190.00', '7490.00', '12.00', '3.00', '225.00', '89880.00', '7265.00', '1550.00', '11260750.00', '316.00', '24.00', '4', '0.00', '0.00', '1.00', '1.00', '11170870.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('4', '2', '1', 'BK 8572 BP', '9890.00', '3190.00', '6700.00', '12.00', '3.00', '201.00', '80400.00', '6499.00', '1450.00', '9423550.00', '255.00', '26.00', '4', '0.00', null, '10.00', '25.00', '4929617.50', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('5', '1', '1', 'BA 9938 SU', '10360.00', '3540.00', '6820.00', '12.00', '3.00', '205.00', '81840.00', '6615.00', '1550.00', '10253250.00', '293.00', '23.00', '4', '0.00', '0.00', '1.00', '1.00', '10171410.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('6', '3', '2', 'BA 9061 XK', '7400.00', '3840.00', '3560.00', '15000.00', '3.00', '107.00', '15000.00', '3453.00', '1550.00', '5352150.00', '161.00', '22.00', '4', '0.00', '0.00', '2.00', '2.00', '5337150.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('7', '1', '1', 'BA 9264 DE', '12150.00', '3260.00', '8890.00', '12.00', '3.00', '267.00', '106680.00', '8623.00', '1550.00', '13365650.00', '412.00', '22.00', '4', '0.00', null, '1.00', '1.00', '1000000.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('8', '3', '1', 'BK00923', '4500000.00', '4000000.00', '500000.00', '12.00', '1.00', '5000.00', '6000000.00', '495000.00', '1550.00', '767249984.00', '135.00', '3704.00', '4', '0.00', '0.00', '2.00', '2.00', '761249984.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('9', '4', '1', 'BK0092', '4000.00', '3900.00', '100.00', '0.00', '1.00', '1.00', '0.00', '99.00', '0.00', '0.00', '120.00', '1.00', '1', '0.00', null, null, null, null, '1');
INSERT INTO `tbt_tbs_order_detail` VALUES ('10', 'TBS/2017/05/00010', '2', 'BB9820KK', '10000.00', '4000.00', '6000.00', '0.00', '3.00', '180.00', '0.00', '5820.00', '0.00', '0.00', '220.00', '27.00', '4', '0.00', null, null, null, null, '1');
INSERT INTO `tbt_tbs_order_detail` VALUES ('11', '4', '1', 'BM 8471 MA', '8260.00', '3360.00', '4900.00', '12.00', '3.00', '147.00', '58800.00', '4753.00', '1805.00', '8579165.00', '236.00', '21.00', '4', '0.00', '0.00', '10.00', '25.00', '7233490.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('12', '5', '1', 'BA 8049 AB', '9970.00', '3290.00', '6680.00', '12.00', '3.00', '200.00', '80160.00', '6480.00', '1730.00', '11210400.00', '312.00', '21.00', '4', '0.00', '0.00', '1.00', '1.00', '11130240.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('13', '6', '2', 'BM 8083 FA', '8410.00', '4300.00', '4110.00', '15000.00', '3.00', '123.00', '61650000.00', '3987.00', '1720.00', '6857640.00', '287.00', '14.00', '3', '0.00', null, '10.00', '25.00', '55821.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('14', '7', '1', 'BB 8006 LK', '8220.00', '3260.00', '4960.00', '12.00', '3.00', '149.00', '59520.00', '4811.00', '1730.00', '8323030.00', '225.00', '22.00', '4', '0.00', '0.00', '2.00', '2.00', '8263510.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('15', '7', '1', 'BA 8950 AJ', '9140.00', '3380.00', '5760.00', '12.00', '3.00', '173.00', '69120.00', '5587.00', '1720.00', '9609640.00', '372.00', '15.00', '3', '0.00', '0.00', '2.00', '2.00', '9540520.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('16', '5', '1', 'BA 9264 DE', '10800.00', '3690.00', '7110.00', '12.00', '3.00', '213.00', '85320.00', '6897.00', '1720.00', '11862840.00', '443.00', '16.00', '3', '0.00', '0.00', '1.00', '1.00', '11777520.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('17', '8', '1', 'BB 9204 FA', '10470.00', '3740.00', '6730.00', '12.00', '3.00', '202.00', '80760.00', '6528.00', '1730.00', '11293440.00', '322.00', '21.00', '4', '0.00', '0.00', '1.00', '1.00', '11212680.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('18', '7', '1', 'BB 9194 LK', '7240.00', '3100.00', '4140.00', '12.00', '3.00', '124.00', '49680.00', '4016.00', '1730.00', '6947680.00', '185.00', '22.00', '4', '0.00', '0.00', '2.00', '2.00', '6898000.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('19', '6', '1', 'BB 8173 KA', '11010.00', '3530.00', '7480.00', '12.00', '3.00', '224.00', '89760.00', '7256.00', '1730.00', '12552880.00', '343.00', '22.00', '4', '0.00', null, '10.00', '25.00', '10580188.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('20', '6', '1', 'BA 9384 JT', '9560.00', '3540.00', '6020.00', '12.00', '2.80', '169.00', '72240.00', '5851.00', '1730.00', '10122230.00', '268.00', '22.00', '4', '0.00', '0.00', '10.00', '25.00', '8531656.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('21', '9', '2', 'BK 9057 CY', '11730.00', '4650.00', '7080.00', '15000.00', '2.80', '198.00', '106200000.00', '6882.00', '1730.00', '11905860.00', '354.00', '20.00', '4', '0.00', '0.00', '1.00', '1.00', '-94294144.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('22', '10', '2', 'BK 9117 BN', '9710.00', '3620.00', '6090.00', '15000.00', '3.00', '183.00', '91350000.00', '5907.00', '1730.00', '10219110.00', '266.00', '23.00', '4', '0.00', '0.00', '0.00', '0.00', '-81130888.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('23', '10', '2', 'BK 9130 BN', '8740.00', '3550.00', '5190.00', '15000.00', '3.00', '156.00', '77850000.00', '5034.00', '1730.00', '8708820.00', '221.00', '23.00', '4', '0.00', '0.00', '0.00', '0.00', '-69141184.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('24', '4', '1', 'BM 2617 AC', '8390.00', '3090.00', '5300.00', '12.00', '3.00', '159.00', '63600.00', '5141.00', '1805.00', '9279505.00', '221.00', '24.00', '4', '0.00', '0.00', '10.00', '25.00', '7823979.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('25', '6', '1', 'BB 8339 KA', '10160.00', '3260.00', '6900.00', '12.00', '2.80', '193.00', '82800.00', '6707.00', '1730.00', '11603110.00', '306.00', '23.00', '4', '0.00', '0.00', '10.00', '25.00', '9779844.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('26', '6', '2', 'BB 8888 KT', '6070.00', '3640.00', '2430.00', '15000.00', '2.00', '49.00', '36450000.00', '2381.00', '1730.00', '4119130.00', '102.00', '24.00', '4', '0.00', '0.00', '10.00', '25.00', '-32948740.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('27', '4', '1', 'BB 8522 BP', '5030.00', '3190.00', '1840.00', '12.00', '3.00', '55.00', '22080.00', '1785.00', '1805.00', '3221925.00', '65.00', '28.00', '4', '0.00', '0.00', '10.00', '25.00', '2716556.25', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('28', '4', '1', 'BA 9103 XK', '6040.00', '3440.00', '2600.00', '12.00', '3.00', '78.00', '31200.00', '2522.00', '1795.00', '4526990.00', '152.00', '17.00', '3', '0.00', '0.00', '10.00', '25.00', '3816741.50', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('29', '7', '1', 'BB 8061 LK', '6470.00', '3120.00', '3350.00', '12.00', '3.00', '101.00', '40200.00', '3249.00', '1730.00', '5620770.00', '150.00', '22.00', '4', '0.00', '0.00', '2.00', '2.00', '5580570.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('30', '6', '1', 'BB 8272 KA', '8340.00', '3450.00', '4890.00', '12.00', '2.80', '137.00', '58680.00', '4753.00', '1730.00', '8222690.00', '214.00', '23.00', '4', '0.00', '0.00', '10.00', '25.00', '6930606.50', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('31', '6', '1', 'BK 8038 BP', '9700.00', '3170.00', '6530.00', '12.00', '3.00', '196.00', '78360.00', '6334.00', '1730.00', '10957820.00', '295.00', '22.00', '4', '0.00', '0.00', '10.00', '25.00', '9235787.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('32', '11', '2', 'BB 8483 KA', '10350.00', '3890.00', '6460.00', '15000.00', '1.50', '97.00', '96900000.00', '6363.00', '1400.00', '8908200.00', '423.00', '15.00', '3', '0.00', '0.00', '0.00', '0.00', '-87991800.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('33', '7', '1', 'BB 8087 KA', '8920.00', '3360.00', '5560.00', '12.00', '3.00', '167.00', '66720.00', '5393.00', '1730.00', '9329890.00', '263.00', '21.00', '4', '0.00', '0.00', '2.00', '2.00', '9263170.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('34', '4', '1', 'BK 8174 BY', '8670.00', '3260.00', '5410.00', '12.00', '3.00', '162.00', '64920.00', '5248.00', '1805.00', '9472640.00', '202.00', '27.00', '4', '0.00', '0.00', '10.00', '25.00', '7986824.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('35', '6', '1', 'BK 8624 CD', '5420.00', '3490.00', '1930.00', '12.00', '3.00', '58.00', '23160.00', '1872.00', '1730.00', '3238560.00', '82.00', '24.00', '4', '0.00', '0.00', '10.00', '25.00', '2729616.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('36', '7', '1', 'BB 8055 KA', '9360.00', '3590.00', '5770.00', '12.00', '3.00', '173.00', '69240.00', '5597.00', '1730.00', '9682810.00', '265.00', '22.00', '4', '0.00', '0.00', '2.00', '2.00', '9613570.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('37', '7', '1', 'BB 8238 LK', '7340.00', '3110.00', '4230.00', '12.00', '3.00', '127.00', '50760.00', '4103.00', '1730.00', '7098190.00', '168.00', '25.00', '4', '0.00', '0.00', '2.00', '2.00', '7047430.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('38', '7', '1', 'BB 8324 KA', '7940.00', '3160.00', '4780.00', '12.00', '3.00', '143.00', '57360.00', '4637.00', '1730.00', '8022010.00', '220.00', '22.00', '4', '0.00', '0.00', '2.00', '2.00', '7964650.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('39', '7', '1', 'BK 9636 VN', '5520.00', '3500.00', '2020.00', '12.00', '3.00', '61.00', '24240.00', '1959.00', '1730.00', '3389070.00', '76.00', '27.00', '4', '0.00', '0.00', '2.00', '2.00', '3364830.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('40', '12', '2', 'BB 8607 KA', '5810.00', '3640.00', '2170.00', '15000.00', '1.50', '33.00', '32550000.00', '2137.00', '1720.00', '3675640.00', '130.00', '17.00', '3', '0.00', '0.00', '0.00', '0.00', '-28874360.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('41', '13', '1', 'BA 9260 JM', '10350.00', '3400.00', '6950.00', '12.00', '3.00', '209.00', '83400.00', '6741.00', '1730.00', '11661930.00', '330.00', '21.00', '4', '0.00', '0.00', '1.00', '1.00', '11578530.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('42', '8', '1', 'BB 8234 KA', '9550.00', '3370.00', '6180.00', '12.00', '3.00', '185.00', '74160.00', '5995.00', '1730.00', '10371350.00', '286.00', '22.00', '4', '0.00', '0.00', '1.00', '1.00', '10297190.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('43', '4', '1', 'BA 9071 E', '6610.00', '3330.00', '3280.00', '12.00', '3.00', '98.00', '39360.00', '3182.00', '1805.00', '5743510.00', '148.00', '22.00', '4', '0.00', '0.00', '10.00', '25.00', '4842623.50', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('44', '14', '2', 'BK 9430 DB', '9950.00', '3950.00', '6000.00', '15000.00', '2.80', '168.00', '90000000.00', '5832.00', '1730.00', '10089360.00', '234.00', '26.00', '4', '0.00', '0.00', '1.00', '1.00', '-79910640.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('45', '5', '2', 'BM 9728 PU', '9630.00', '3950.00', '5680.00', '15000.00', '3.00', '170.00', '85200000.00', '5510.00', '1720.00', '9477200.00', '368.00', '15.00', '3', '0.00', '0.00', '1.00', '1.00', '-75722800.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('46', '15', '2', 'BK 9266 CD', '8270.00', '3750.00', '4520.00', '15000.00', '6.00', '271.00', '67800000.00', '4249.00', null, '0.00', '793.00', '6.00', '2', '0.00', '0.00', '0.00', '0.00', '-67800000.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('47', '16', '1', 'BK 8572 BP', '10330.00', '3300.00', '7030.00', '0.00', '3.00', '211.00', '0.00', '6819.00', '0.00', '0.00', '305.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('48', '16', '1', 'BB 8193 XF', '8950.00', '3210.00', '5740.00', '0.00', '3.00', '172.00', '0.00', '5568.00', '0.00', '0.00', '254.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('49', '17', '1', 'BA 9938 SU', '9660.00', '3610.00', '6050.00', '0.00', '3.00', '182.00', '0.00', '5868.00', '0.00', '0.00', '406.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('50', '16', '1', 'BK 9690 LP', '9720.00', '3490.00', '6230.00', '0.00', '3.00', '187.00', '0.00', '6043.00', '0.00', '0.00', '248.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('51', '18', '1', 'BB 8469 FA', '12860.00', '3420.00', '9440.00', '0.00', '3.00', '283.00', '0.00', '9157.00', '0.00', '0.00', '588.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('52', '19', '1', 'BK 8006 LK', '8800.00', '3130.00', '5670.00', '0.00', '3.00', '170.00', '0.00', '5500.00', '0.00', '0.00', '241.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('53', '20', '1', 'BB 8400 KA', '9780.00', '3580.00', '6200.00', '0.00', '3.00', '186.00', '0.00', '6014.00', '0.00', '0.00', '264.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('54', '19', '1', 'BM 9221 MA', '11020.00', '4310.00', '6710.00', '0.00', '3.00', '201.00', '0.00', '6509.00', '0.00', '0.00', '481.00', '14.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('55', '18', '1', 'BB 8611 LG', '8420.00', '3410.00', '5010.00', '0.00', '3.00', '150.00', '0.00', '4860.00', '0.00', '0.00', '251.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('56', '19', '3', 'BK 8621 YG', '4090.00', '1190.00', '2900.00', '0.00', '3.00', '87.00', '0.00', '2813.00', '0.00', '0.00', '196.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('57', '18', '1', 'BB 8539 KA', '10190.00', '3970.00', '6220.00', '0.00', '2.80', '174.00', '0.00', '6046.00', '0.00', '0.00', '426.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('58', '19', '1', 'BK 8589 LL', '9100.00', '3580.00', '5520.00', '0.00', '3.00', '166.00', '0.00', '5354.00', '0.00', '0.00', '343.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('59', '17', '1', 'BH 8453 AG', '10440.00', '3880.00', '6560.00', '0.00', '3.00', '197.00', '0.00', '6363.00', '0.00', '0.00', '314.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('60', '19', '1', 'BB 8007 KA', '8180.00', '3400.00', '4780.00', '0.00', '3.00', '143.00', '0.00', '4637.00', '0.00', '0.00', '201.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('61', '16', '1', 'BM 8344 MF', '9850.00', '3790.00', '6060.00', '0.00', '3.00', '182.00', '0.00', '5878.00', '0.00', '0.00', '244.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('62', '21', '1', 'BK 8337 BG', '8210.00', '3470.00', '4740.00', '0.00', '3.00', '142.00', '0.00', '4598.00', '0.00', '0.00', '215.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('63', '18', '1', 'F 8987 FH', '6260.00', '3020.00', '3240.00', '0.00', '3.00', '97.00', '0.00', '3143.00', '0.00', '0.00', '203.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('64', '19', '1', 'BB 9194 KA', '7790.00', '3290.00', '4500.00', '0.00', '3.00', '135.00', '0.00', '4365.00', '0.00', '0.00', '197.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('65', '18', '1', 'BA 9925 CY', '8150.00', '3290.00', '4860.00', '0.00', '3.00', '146.00', '0.00', '4714.00', '0.00', '0.00', '235.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('66', '16', '1', 'BB 8276 KA', '10120.00', '3370.00', '6750.00', '0.00', '3.00', '203.00', '0.00', '6547.00', '0.00', '0.00', '312.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('67', '18', '3', 'BB 8463 KA', '3390.00', '1360.00', '2030.00', '0.00', '3.00', '61.00', '0.00', '1969.00', '0.00', '0.00', '119.00', '17.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('68', '16', '1', 'BM 9971 AS', '8910.00', '3250.00', '5660.00', '0.00', '3.00', '170.00', '0.00', '5490.00', '0.00', '0.00', '224.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('69', '16', '3', 'BK 1163 DW', '3550.00', '1410.00', '2140.00', '0.00', '3.00', '64.00', '0.00', '2076.00', '0.00', '0.00', '101.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('70', '22', '1', 'BM 8471 MA', '7130.00', '3130.00', '4000.00', '0.00', '3.00', '120.00', '0.00', '3880.00', '0.00', '0.00', '180.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('71', '23', '2', 'BM 9728 PU', '8130.00', '3940.00', '4190.00', '0.00', '3.00', '126.00', '0.00', '4064.00', '0.00', '0.00', '184.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('72', '23', '2', 'BB 9069 KA', '9850.00', '4090.00', '5760.00', '0.00', '3.00', '173.00', '0.00', '5587.00', '0.00', '0.00', '384.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('73', '24', '2', 'BB 8472 KA', '8700.00', '3870.00', '4830.00', '0.00', '3.00', '145.00', '0.00', '4685.00', '0.00', '0.00', '229.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('74', '23', '1', 'BA 8049 AB', '11020.00', '3360.00', '7660.00', '0.00', '3.00', '230.00', '0.00', '7430.00', '0.00', '0.00', '327.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('75', '22', '1', 'BB 8207 LK', '9480.00', '3410.00', '6070.00', '0.00', '3.00', '182.00', '0.00', '5888.00', '0.00', '0.00', '274.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('76', '24', '1', 'BB 8584 KA', '11690.00', '3650.00', '8040.00', '0.00', '2.80', '225.00', '0.00', '7815.00', '0.00', '0.00', '364.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('77', '25', '1', 'BB 8400 KA', '8780.00', '3570.00', '5210.00', '0.00', '3.00', '156.00', '0.00', '5054.00', '0.00', '0.00', '245.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('78', '24', '1', 'BK 8038 BP', '10650.00', '3160.00', '7490.00', '0.00', '3.00', '225.00', '0.00', '7265.00', '0.00', '0.00', '280.00', '27.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('79', '26', '3', 'BK 8621 YG', '3100.00', '1170.00', '1930.00', '0.00', '3.00', '58.00', '0.00', '1872.00', '0.00', '0.00', '130.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('80', '26', '1', 'BK 8589 LL', '9150.00', '3410.00', '5740.00', '0.00', '3.00', '172.00', '0.00', '5568.00', '0.00', '0.00', '257.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('81', '26', '1', 'BM 9221 MA', '7470.00', '3520.00', '3950.00', '0.00', '3.00', '119.00', '0.00', '3831.00', '0.00', '0.00', '264.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('82', '26', '1', 'BA 9308 D', '9230.00', '3130.00', '6100.00', '0.00', '3.00', '183.00', '0.00', '5917.00', '0.00', '0.00', '376.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('83', '23', '1', 'BA 9938 SU', '12580.00', '3580.00', '9000.00', '0.00', '3.00', '270.00', '0.00', '8730.00', '0.00', '0.00', '387.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('84', '24', '1', 'BB 8469 FA', '10590.00', '3450.00', '7140.00', '0.00', '3.00', '214.00', '0.00', '6926.00', '0.00', '0.00', '335.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('85', '24', '1', 'BA 9925 CY', '9580.00', '3340.00', '6240.00', '0.00', '3.00', '187.00', '0.00', '6053.00', '0.00', '0.00', '302.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('86', '27', '1', 'BK 8337 BG', '8390.00', '3510.00', '4880.00', '0.00', '3.00', '146.00', '0.00', '4734.00', '0.00', '0.00', '218.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('87', '24', '1', 'BB 8026 LK', '4560.00', '3360.00', '1200.00', '0.00', '3.00', '36.00', '0.00', '1164.00', '0.00', '0.00', '40.00', '30.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('88', '28', '1', 'BK 8572 BP', '9900.00', '3130.00', '6770.00', '0.00', '3.00', '203.00', '0.00', '6567.00', '0.00', '0.00', '293.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('89', '28', '1', 'BK 9690 LP', '9960.00', '3490.00', '6470.00', '0.00', '3.00', '194.00', '0.00', '6276.00', '0.00', '0.00', '287.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('90', '29', '1', 'BK 8038 BP', '10970.00', '3120.00', '7850.00', '0.00', '3.00', '236.00', '0.00', '7614.00', '0.00', '0.00', '312.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('91', '28', '1', 'BM 8344 MF', '8050.00', '3670.00', '4380.00', '0.00', '3.00', '131.00', '0.00', '4249.00', '0.00', '0.00', '215.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('92', '30', '3', 'BK 8621 YG', '3640.00', '1220.00', '2420.00', '0.00', '3.00', '73.00', '0.00', '2347.00', '0.00', '0.00', '153.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('93', '28', '1', 'BB 8193 XF', '6780.00', '3210.00', '3570.00', '0.00', '3.00', '107.00', '0.00', '3463.00', '0.00', '0.00', '146.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('94', '31', '2', 'BK 9266 CD', '7850.00', '3770.00', '4080.00', '0.00', '1.50', '61.00', '0.00', '4019.00', '0.00', '0.00', '258.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('95', '31', '2', 'BB 8483 KA', '10710.00', '3860.00', '6850.00', '0.00', '5.00', '343.00', '0.00', '6507.00', '0.00', '0.00', '671.00', '10.00', '2', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('96', '31', '2', 'BB 8607 KA', '9550.00', '3620.00', '5930.00', '0.00', '5.00', '297.00', '0.00', '5633.00', '0.00', '0.00', '644.00', '9.00', '2', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('97', '30', '1', 'BM 9221 MA', '8250.00', '3450.00', '4800.00', '0.00', '3.00', '144.00', '0.00', '4656.00', '0.00', '0.00', '226.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('98', '32', '1', 'BB 8234 KA', '8070.00', '3270.00', '4800.00', '0.00', '3.00', '144.00', '0.00', '4656.00', '0.00', '0.00', '213.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('99', '32', '1', 'BB 9204 FA', '9990.00', '4340.00', '5650.00', '0.00', '3.80', '215.00', '0.00', '5435.00', '0.00', '0.00', '240.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('100', '30', '1', 'BB 8061 LK', '10180.00', '3290.00', '6890.00', '0.00', '3.00', '207.00', '0.00', '6683.00', '0.00', '0.00', '331.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('101', '29', '1', 'BB 8469 FA', '10400.00', '3300.00', '7100.00', '0.00', '3.00', '213.00', '0.00', '6887.00', '0.00', '0.00', '321.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('102', '29', '1', 'BA 9925 CY', '10230.00', '3330.00', '6900.00', '0.00', '3.00', '207.00', '0.00', '6693.00', '0.00', '0.00', '304.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('103', '29', '1', 'F 8987 FH', '7550.00', '3040.00', '4510.00', '0.00', '3.00', '135.00', '0.00', '4375.00', '0.00', '0.00', '275.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('104', '28', '1', 'BM 9971 AS', '8200.00', '3270.00', '4930.00', '0.00', '3.00', '148.00', '0.00', '4782.00', '0.00', '0.00', '245.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('105', '29', '1', 'BB 8389 LK', '5210.00', '3160.00', '2050.00', '0.00', '3.00', '62.00', '0.00', '1988.00', '0.00', '0.00', '106.00', '19.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('106', '31', '2', 'BB 8483 KA', '9330.00', '3860.00', '5470.00', '0.00', '1.50', '82.00', '0.00', '5388.00', '0.00', '0.00', '255.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('107', '33', '2', 'BK 9117 BN', '8860.00', '3610.00', '5250.00', '0.00', '3.00', '158.00', '0.00', '5092.00', '0.00', '0.00', '220.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('108', '29', '2', 'BB 8472 KA', '6870.00', '3820.00', '3050.00', '0.00', '3.00', '92.00', '0.00', '2958.00', '0.00', '0.00', '142.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('109', '33', '2', 'BK 9130 BN', '8000.00', '3580.00', '4420.00', '0.00', '3.00', '133.00', '0.00', '4287.00', '0.00', '0.00', '223.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('110', '29', '1', 'BB 8650 KA', '9090.00', '3640.00', '5450.00', '0.00', '2.80', '153.00', '0.00', '5297.00', '0.00', '0.00', '262.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('111', '34', '2', 'BM 9728 PU', '7880.00', '3900.00', '3980.00', '0.00', '3.00', '119.00', '0.00', '3861.00', '0.00', '0.00', '184.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('112', '35', '1', 'BB 8473 LG', '6480.00', '3120.00', '3360.00', '0.00', '3.00', '101.00', '0.00', '3259.00', '0.00', '0.00', '153.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('113', '33', '2', 'BK 9117 BN', '7490.00', '3590.00', '3900.00', '0.00', '3.00', '117.00', '0.00', '3783.00', '0.00', '0.00', '180.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('114', '30', '1', 'BB 8238 LK', '5930.00', '3160.00', '2770.00', '0.00', '3.00', '83.00', '0.00', '2687.00', '0.00', '0.00', '120.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('115', '34', '1', 'BK 8770 XT', '7180.00', '3170.00', '4010.00', '0.00', '3.00', '120.00', '0.00', '3890.00', '0.00', '0.00', '256.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('116', '29', '1', 'BA 9384 JT', '8750.00', '3490.00', '5260.00', '0.00', '2.80', '147.00', '0.00', '5113.00', '0.00', '0.00', '250.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('117', '31', '2', 'BB 8607 KA', '10260.00', '3650.00', '6610.00', '0.00', '1.50', '99.00', '0.00', '6511.00', '0.00', '0.00', '418.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('118', '29', '1', 'BB 8339 KA', '8220.00', '3300.00', '4920.00', '0.00', '2.80', '138.00', '0.00', '4782.00', '0.00', '0.00', '227.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('119', '29', '3', 'BB 123 KA', '2560.00', '1490.00', '1070.00', '0.00', '3.00', '32.00', '0.00', '1038.00', '0.00', '0.00', '45.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('120', '36', '4', 'AD 1628 HG', '15230.00', '6270.00', '8960.00', '0.00', '2.80', '251.00', '0.00', '8709.00', '0.00', '0.00', '320.00', '28.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('121', '34', '1', 'BK 8678 GW', '8070.00', '3390.00', '4680.00', '0.00', '3.00', '140.00', '0.00', '4540.00', '0.00', '0.00', '229.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('122', '31', '2', 'BK 9565 CI', '9240.00', '3980.00', '5260.00', '0.00', '1.50', '79.00', '0.00', '5181.00', '0.00', '0.00', '209.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('123', '28', '1', 'F 8124 FR', '6480.00', '3560.00', '2920.00', '0.00', '3.00', '88.00', '0.00', '2832.00', '0.00', '0.00', '138.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('124', '28', '1', 'BA 9103  XK', '9320.00', '3480.00', '5840.00', '0.00', '3.00', '175.00', '0.00', '5665.00', '0.00', '0.00', '256.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('125', '29', '1', 'BK 8624 CD', '8110.00', '3820.00', '4290.00', '0.00', '3.00', '129.00', '0.00', '4161.00', '0.00', '0.00', '174.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('126', '31', '2', 'BB 8483 KA', '9440.00', '3880.00', '5560.00', '0.00', '1.50', '83.00', '0.00', '5477.00', '0.00', '0.00', '263.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('127', '31', '2', 'BK 9169 CC', '9520.00', '3710.00', '5810.00', '0.00', '6.00', '349.00', '0.00', '5461.00', '0.00', '0.00', '575.00', '10.00', '2', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('128', '31', '2', 'BK 9266 CD', '8930.00', '3760.00', '5170.00', '0.00', '6.00', '310.00', '0.00', '4860.00', '0.00', '0.00', '545.00', '9.00', '2', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('129', '31', '2', 'BB 8607 KA', '5740.00', '3650.00', '2090.00', '0.00', '1.50', '31.00', '0.00', '2059.00', '0.00', '0.00', '158.00', '13.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('130', '37', '1', 'BA 8049 AB', '11570.00', '3410.00', '8160.00', '0.00', '3.00', '245.00', '0.00', '7915.00', '0.00', '0.00', '366.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('131', '38', '1', 'BK 8419 DV', '11820.00', '3120.00', '8700.00', '0.00', '3.00', '261.00', '0.00', '8439.00', '0.00', '0.00', '355.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('132', '37', '1', 'BA 9938 SU', '9250.00', '3520.00', '5730.00', '0.00', '3.00', '172.00', '0.00', '5558.00', '0.00', '0.00', '245.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('133', '39', '1', 'BB 8207 KA', '10110.00', '3340.00', '6770.00', '0.00', '3.00', '203.00', '0.00', '6567.00', '0.00', '0.00', '275.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('134', '40', '1', 'BK 8038 BP', '10530.00', '3160.00', '7370.00', '0.00', '3.00', '221.00', '0.00', '7149.00', '0.00', '0.00', '317.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('135', '38', '1', 'BB 8007 KA', '11410.00', '3520.00', '7890.00', '0.00', '3.00', '237.00', '0.00', '7653.00', '0.00', '0.00', '355.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('136', '38', '1', 'BB 8055 KA', '6930.00', '3200.00', '3730.00', '0.00', '3.00', '112.00', '0.00', '3618.00', '0.00', '0.00', '147.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('137', '37', '1', 'BH 8453 AG', '10330.00', '3400.00', '6930.00', '0.00', '3.00', '208.00', '0.00', '6722.00', '0.00', '0.00', '341.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('138', '38', '1', 'BK 8589 LL', '9270.00', '3400.00', '5870.00', '0.00', '3.00', '176.00', '0.00', '5694.00', '0.00', '0.00', '275.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('139', '38', '1', 'BB 9194 KA', '7210.00', '3200.00', '4010.00', '0.00', '3.00', '120.00', '0.00', '3890.00', '0.00', '0.00', '167.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('140', '40', '1', 'BB 8438 HC', '6000.00', '3340.00', '2660.00', '0.00', '3.00', '80.00', '0.00', '2580.00', '0.00', '0.00', '119.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('141', '38', '1', 'BA 8950 AJ', '9040.00', '3630.00', '5410.00', '0.00', '3.00', '162.00', '0.00', '5248.00', '0.00', '0.00', '336.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('142', '40', '1', 'BM 9588 LA', '5430.00', '3140.00', '2290.00', '0.00', '3.00', '69.00', '0.00', '2221.00', '0.00', '0.00', '90.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('143', '38', '1', 'BM 8158 MC', '7740.00', '3060.00', '4680.00', '0.00', '3.00', '140.00', '0.00', '4540.00', '0.00', '0.00', '180.00', '26.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('144', '40', '3', 'B 1861 WLO', '2220.00', '1400.00', '820.00', '0.00', '3.00', '25.00', '0.00', '795.00', '0.00', '0.00', '54.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('145', '40', '1', 'BA 9925 CY', '8820.00', '3360.00', '5460.00', '0.00', '3.00', '164.00', '0.00', '5296.00', '0.00', '0.00', '250.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('146', '41', '4', 'AD 1628 HG', '14030.00', '6260.00', '7770.00', '0.00', '2.80', '218.00', '0.00', '7552.00', '0.00', '0.00', '250.00', '31.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('147', '40', '1', 'BK 8426 FA', '10960.00', '3220.00', '7740.00', '0.00', '3.00', '232.00', '0.00', '7508.00', '0.00', '0.00', '330.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('148', '42', '1', 'BB 8400 KA', '10920.00', '3830.00', '7090.00', '0.00', '3.00', '213.00', '0.00', '6877.00', '0.00', '0.00', '328.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('149', '38', '3', 'BB 77 KA', '3170.00', '1600.00', '1570.00', '0.00', '3.00', '47.00', '0.00', '1523.00', '0.00', '0.00', '78.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('150', '43', '1', 'BM 8846 MA', '9880.00', '3950.00', '5930.00', '0.00', '3.50', '208.00', '0.00', '5722.00', '0.00', '0.00', '265.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('151', '44', '2', 'BB 8472 KA', '7000.00', '3750.00', '3250.00', '0.00', '3.80', '124.00', '0.00', '3126.00', '0.00', '0.00', '140.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('152', '45', '3', 'BK 8621 YG', '3480.00', '1320.00', '2160.00', '0.00', '3.50', '76.00', '0.00', '2084.00', '0.00', '0.00', '153.00', '14.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('153', '44', '2', 'BM 8022 MF', '8820.00', '3690.00', '5130.00', '0.00', '3.00', '154.00', '0.00', '4976.00', '0.00', '0.00', '218.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('154', '46', '2', 'BK 9169 CC', '11120.00', '3680.00', '7440.00', '0.00', '1.50', '112.00', '0.00', '7328.00', '0.00', '0.00', '320.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('155', '47', '1', 'BA 8049 AB', '7580.00', '3220.00', '4360.00', '0.00', '3.50', '153.00', '0.00', '4207.00', '0.00', '0.00', '181.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('156', '44', '3', 'BB 2017 KA', '2920.00', '1780.00', '1140.00', '0.00', '3.00', '34.00', '0.00', '1106.00', '0.00', '0.00', '85.00', '13.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('157', '44', '5', 'BB 8568 XC', '3230.00', '1720.00', '1510.00', '0.00', '3.00', '45.00', '0.00', '1465.00', '0.00', '0.00', '100.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('158', '44', '2', 'BM 9572 MH', '4710.00', '3950.00', '760.00', '0.00', '3.00', '23.00', '0.00', '737.00', '0.00', '0.00', '50.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('159', '48', '2', 'BK 9130 BN', '8800.00', '3520.00', '5280.00', '0.00', '3.00', '158.00', '0.00', '5122.00', '0.00', '0.00', '230.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('160', '48', '2', 'BK 9117 BN', '8100.00', '3650.00', '4450.00', '0.00', '3.00', '134.00', '0.00', '4316.00', '0.00', '0.00', '200.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('161', '44', '1', 'BB 8339 KA', '8900.00', '3290.00', '5610.00', '0.00', '2.80', '157.00', '0.00', '5453.00', '0.00', '0.00', '228.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('162', '44', '2', 'BM 9572 MH', '4810.00', '3950.00', '860.00', '0.00', '3.00', '26.00', '0.00', '834.00', '0.00', '0.00', '40.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('163', '43', '1', 'BK 8006 CN', '8920.00', '3520.00', '5400.00', '0.00', '3.00', '162.00', '0.00', '5238.00', '0.00', '0.00', '254.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('164', '45', '1', 'BA 8950 AJ', '8230.00', '3270.00', '4960.00', '0.00', '3.00', '149.00', '0.00', '4811.00', '0.00', '0.00', '328.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('165', '44', '1', 'BM 9006 LD', '9230.00', '3310.00', '5920.00', '0.00', '3.00', '178.00', '0.00', '5742.00', '0.00', '0.00', '278.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('166', '44', '3', 'B 1379 VR', '2220.00', '1520.00', '700.00', '0.00', '3.00', '21.00', '0.00', '679.00', '0.00', '0.00', '32.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('167', '45', '1', 'BB 8238 LK', '5870.00', '3100.00', '2770.00', '0.00', '3.00', '83.00', '0.00', '2687.00', '0.00', '0.00', '113.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('168', '44', '2', 'BB 8888 KT', '6500.00', '3660.00', '2840.00', '0.00', '3.00', '85.00', '0.00', '2755.00', '0.00', '0.00', '108.00', '26.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('169', '46', '2', 'BK 9565 CI', '10460.00', '3970.00', '6490.00', '0.00', '1.50', '97.00', '0.00', '6393.00', '0.00', '0.00', '416.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('170', '47', '1', 'BA 9264 DE', '9550.00', '3310.00', '6240.00', '0.00', '3.00', '187.00', '0.00', '6053.00', '0.00', '0.00', '256.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('171', '49', '1', 'BB 8712 HB', '8990.00', '3200.00', '5790.00', '0.00', '3.00', '174.00', '0.00', '5616.00', '0.00', '0.00', '243.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('172', '44', '1', 'BB 8650 KA', '11220.00', '3580.00', '7640.00', '0.00', '2.80', '214.00', '0.00', '7426.00', '0.00', '0.00', '362.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('173', '44', '3', 'B 1379 VR', '2620.00', '1540.00', '1080.00', '0.00', '3.00', '32.00', '0.00', '1048.00', '0.00', '0.00', '53.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('174', '44', '2', 'BB 8472 KA', '6900.00', '3860.00', '3040.00', '0.00', '3.00', '91.00', '0.00', '2949.00', '0.00', '0.00', '201.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('175', '50', '1', 'BB 8421 KA', '12870.00', '3820.00', '9050.00', '0.00', '3.00', '272.00', '0.00', '8778.00', '0.00', '0.00', '412.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('176', '44', '1', 'BK 8349 BO', '6210.00', '3650.00', '2560.00', '0.00', '3.00', '77.00', '0.00', '2483.00', '0.00', '0.00', '177.00', '14.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('177', '45', '1', 'BB 2672 CC', '10120.00', '3120.00', '7000.00', '0.00', '3.00', '210.00', '0.00', '6790.00', '0.00', '0.00', '278.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('178', '44', '5', 'BB 8568 XC', '3530.00', '1700.00', '1830.00', '0.00', '3.00', '55.00', '0.00', '1775.00', '0.00', '0.00', '83.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('179', '47', '1', 'BK 8770 XT', '8870.00', '3100.00', '5770.00', '0.00', '3.00', '173.00', '0.00', '5597.00', '0.00', '0.00', '267.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('180', '43', '1', 'BK 9690 LP', '9890.00', '3570.00', '6320.00', '0.00', '3.00', '190.00', '0.00', '6130.00', '0.00', '0.00', '281.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('181', '43', '1', 'BB 9007 LF', '6290.00', '3040.00', '3250.00', '0.00', '3.00', '98.00', '0.00', '3152.00', '0.00', '0.00', '145.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('182', '43', '1', 'BB 8921 HA', '10290.00', '3070.00', '7220.00', '0.00', '3.00', '217.00', '0.00', '7003.00', '0.00', '0.00', '335.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('183', '47', '2', 'BM 9728 PU', '8990.00', '3980.00', '5010.00', '0.00', '3.00', '150.00', '0.00', '4860.00', '0.00', '0.00', '230.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('184', '46', '2', 'BK 9266 CD', '9730.00', '3790.00', '5940.00', '0.00', '15.00', '891.00', '0.00', '5049.00', '0.00', '0.00', '270.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('185', '46', '2', 'BB 8527 KA', '10680.00', '3820.00', '6860.00', '0.00', '1.50', '103.00', '0.00', '6757.00', '0.00', '0.00', '294.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('186', '51', '4', 'BK 9463 DR', '14530.00', '6640.00', '7890.00', '0.00', '2.80', '221.00', '0.00', '7669.00', '0.00', '0.00', '380.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('187', '46', '2', 'BK 9565 CI', '7980.00', '3970.00', '4010.00', '0.00', '1.50', '60.00', '0.00', '3950.00', '0.00', '0.00', '195.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('188', '46', '2', 'BB 8483 KA', '10850.00', '3870.00', '6980.00', '0.00', '5.00', '349.00', '0.00', '6631.00', '0.00', '0.00', '656.00', '11.00', '2', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('189', '52', '1', 'BA 9260 JM', '11510.00', '3320.00', '8190.00', '0.00', '3.00', '246.00', '0.00', '7944.00', '0.00', '0.00', '370.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('190', '53', '1', 'BM 8158 MC', '11390.00', '3080.00', '8310.00', '0.00', '3.00', '249.00', '0.00', '8061.00', '0.00', '0.00', '337.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('191', '52', '1', 'BK 9636 VN', '13060.00', '3670.00', '9390.00', '0.00', '3.00', '282.00', '0.00', '9108.00', '0.00', '0.00', '406.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('192', '54', '1', 'BK 8572 BP', '8230.00', '3150.00', '5080.00', '0.00', '3.00', '152.00', '0.00', '4928.00', '0.00', '0.00', '226.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('193', '54', '1', 'BM 8471 MA', '10250.00', '3240.00', '7010.00', '0.00', '3.00', '210.00', '0.00', '6800.00', '0.00', '0.00', '310.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('194', '55', '1', 'BA 9938 SU', '11650.00', '3530.00', '8120.00', '0.00', '3.00', '244.00', '0.00', '7876.00', '0.00', '0.00', '327.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('195', '53', '1', 'BB 8061 LK', '8610.00', '3200.00', '5410.00', '0.00', '3.00', '162.00', '0.00', '5248.00', '0.00', '0.00', '260.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('196', '53', '3', 'BK 8621 YG', '3940.00', '1100.00', '2840.00', '0.00', '3.00', '85.00', '0.00', '2755.00', '0.00', '0.00', '189.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('197', '54', '1', 'BM 2617 AC', '8110.00', '3240.00', '4870.00', '0.00', '3.00', '146.00', '0.00', '4724.00', '0.00', '0.00', '227.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('198', '56', '2', 'BK 8261 YE', '8980.00', '3880.00', '5100.00', '0.00', '3.00', '153.00', '0.00', '4947.00', '0.00', '0.00', '338.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('199', '54', '1', 'BM 8846 MA', '9530.00', '4040.00', '5490.00', '0.00', '3.00', '165.00', '0.00', '5325.00', '0.00', '0.00', '260.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('200', '55', '1', 'BH 8453 AG', '10890.00', '4080.00', '6810.00', '0.00', '3.00', '204.00', '0.00', '6606.00', '0.00', '0.00', '336.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('201', '54', '1', 'BM 8344 MF', '8270.00', '3680.00', '4590.00', '0.00', '3.00', '138.00', '0.00', '4452.00', '0.00', '0.00', '182.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('202', '57', '2', 'BK 9430 DB', '9620.00', '4160.00', '5460.00', '0.00', '2.80', '153.00', '0.00', '5307.00', '0.00', '0.00', '244.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('203', '56', '1', 'BB 8611 LG', '10340.00', '3260.00', '7080.00', '0.00', '3.00', '212.00', '0.00', '6868.00', '0.00', '0.00', '349.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('204', '58', '1', 'BB 8400 KA', '9190.00', '3580.00', '5610.00', '0.00', '3.00', '168.00', '0.00', '5442.00', '0.00', '0.00', '243.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('205', '56', '1', 'BA 9384 JT', '8900.00', '3440.00', '5460.00', '0.00', '2.80', '153.00', '0.00', '5307.00', '0.00', '0.00', '254.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('206', '56', '1', 'BA 9282 D', '7690.00', '3020.00', '4670.00', '0.00', '3.00', '140.00', '0.00', '4530.00', '0.00', '0.00', '290.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('207', '56', '1', 'BB 8469 FA', '11000.00', '3300.00', '7700.00', '0.00', '3.00', '231.00', '0.00', '7469.00', '0.00', '0.00', '320.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('208', '56', '2', 'BB 8472 KA', '9010.00', '3830.00', '5180.00', '0.00', '3.00', '155.00', '0.00', '5025.00', '0.00', '0.00', '204.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('209', '55', '1', 'BA 8049 AB', '9160.00', '3440.00', '5720.00', '0.00', '3.00', '172.00', '0.00', '5548.00', '0.00', '0.00', '240.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('210', '58', '1', 'BB 8712 HB', '9490.00', '3300.00', '6190.00', '0.00', '3.00', '186.00', '0.00', '6004.00', '0.00', '0.00', '290.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('211', '54', '1', 'BK 8522 BP', '7080.00', '3310.00', '3770.00', '0.00', '3.00', '113.00', '0.00', '3657.00', '0.00', '0.00', '150.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('212', '56', '3', 'BK 1163 DW', '3260.00', '1400.00', '1860.00', '0.00', '3.00', '56.00', '0.00', '1804.00', '0.00', '0.00', '92.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('213', '53', '1', 'BA 8950 AJ', '9340.00', '3260.00', '6080.00', '0.00', '3.00', '182.00', '0.00', '5898.00', '0.00', '0.00', '377.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('214', '53', '1', 'BB 8007 KA', '10720.00', '3460.00', '7260.00', '0.00', '3.00', '218.00', '0.00', '7042.00', '0.00', '0.00', '311.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('215', '53', '1', 'BB 9194 LK', '7350.00', '3120.00', '4230.00', '0.00', '3.00', '127.00', '0.00', '4103.00', '0.00', '0.00', '283.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('216', '53', '1', 'BB 8201 KA', '8730.00', '3340.00', '5390.00', '0.00', '2.80', '151.00', '0.00', '5239.00', '0.00', '0.00', '233.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('217', '53', '1', 'BK 8108 BK', '11110.00', '3800.00', '7310.00', '0.00', '3.00', '219.00', '0.00', '7091.00', '0.00', '0.00', '356.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('218', '56', '1', 'BB 8051 LK', '7810.00', '3270.00', '4540.00', '0.00', '3.00', '136.00', '0.00', '4404.00', '0.00', '0.00', '272.00', '17.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('219', '56', '1', 'F 8987 FH', '6930.00', '3030.00', '3900.00', '0.00', '3.00', '117.00', '0.00', '3783.00', '0.00', '0.00', '233.00', '17.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('220', '56', '1', 'BA 9925 CY', '7480.00', '3260.00', '4220.00', '0.00', '3.00', '127.00', '0.00', '4093.00', '0.00', '0.00', '206.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('221', '56', '5', 'BK 8568 XC', '2080.00', '1680.00', '400.00', '0.00', '3.00', '12.00', '0.00', '388.00', '0.00', '0.00', '18.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('222', '59', '2', 'BB 8483 KA', '10620.00', '3860.00', '6760.00', '0.00', '1.50', '101.00', '0.00', '6659.00', '0.00', '0.00', '305.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('223', '53', '1', 'BB 8006 LK', '8210.00', '3130.00', '5080.00', '0.00', '3.00', '152.00', '0.00', '4928.00', '0.00', '0.00', '213.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('224', '53', '1', 'BB 8055 KA', '11720.00', '3480.00', '8240.00', '0.00', '3.00', '247.00', '0.00', '7993.00', '0.00', '0.00', '375.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('225', '56', '2', 'BB 9049 LK', '5820.00', '3990.00', '1830.00', '0.00', '3.00', '55.00', '0.00', '1775.00', '0.00', '0.00', '124.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('226', '56', '1', 'BB 8526 LG', '9220.00', '2880.00', '6340.00', '0.00', '3.00', '190.00', '0.00', '6150.00', '0.00', '0.00', '236.00', '27.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('227', '54', '1', 'BK 8006 CN', '8810.00', '3630.00', '5180.00', '0.00', '3.00', '155.00', '0.00', '5025.00', '0.00', '0.00', '245.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('228', '60', '2', 'BK 9057 CY', '11370.00', '4660.00', '6710.00', '0.00', '2.80', '188.00', '0.00', '6522.00', '0.00', '0.00', '342.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('229', '56', '1', 'BB 8389 LK', '4850.00', '3170.00', '1680.00', '0.00', '3.00', '50.00', '0.00', '1630.00', '0.00', '0.00', '118.00', '14.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('230', '56', '1', 'BB 8083 LK', '4410.00', '3010.00', '1400.00', '0.00', '3.00', '42.00', '0.00', '1358.00', '0.00', '0.00', '57.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('231', '56', '2', 'BB 8888 KT', '6050.00', '3660.00', '2390.00', '0.00', '2.00', '48.00', '0.00', '2342.00', '0.00', '0.00', '120.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('232', '61', '2', 'BK 9117 BN', '7040.00', '3610.00', '3430.00', '0.00', '3.00', '103.00', '0.00', '3327.00', '0.00', '0.00', '170.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('233', '61', '2', 'BK 9130 BN', '8750.00', '3550.00', '5200.00', '0.00', '3.00', '156.00', '0.00', '5044.00', '0.00', '0.00', '220.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('234', '52', '1', 'BB 8438 FH', '7690.00', '3220.00', '4470.00', '0.00', '3.00', '134.00', '0.00', '4336.00', '0.00', '0.00', '198.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('235', '58', '1', 'BB 8712 HB', '4800.00', '3110.00', '1690.00', '0.00', '3.00', '51.00', '0.00', '1639.00', '0.00', '0.00', '72.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('236', '53', '1', 'BB 2313 GC', '7470.00', '3130.00', '4340.00', '0.00', '3.00', '130.00', '0.00', '4210.00', '0.00', '0.00', '200.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('237', '57', '2', 'BK 9430 DB', '9200.00', '3990.00', '5210.00', '0.00', '2.80', '146.00', '0.00', '5064.00', '0.00', '0.00', '221.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('238', '56', '1', 'BA 9384 JT', '7390.00', '3460.00', '3930.00', '0.00', '2.80', '110.00', '0.00', '3820.00', '0.00', '0.00', '171.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('239', '56', '2', 'BK 8611 BK', '9150.00', '3790.00', '5360.00', '0.00', '3.00', '161.00', '0.00', '5199.00', '0.00', '0.00', '240.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('240', '55', '1', 'BK 9770 XT', '8060.00', '3110.00', '4950.00', '0.00', '3.00', '149.00', '0.00', '4801.00', '0.00', '0.00', '224.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('241', '56', '3', 'BB 1065 LK', '3160.00', '2010.00', '1150.00', '0.00', '3.00', '35.00', '0.00', '1115.00', '0.00', '0.00', '46.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('242', '59', '2', 'BB 8483 KA', '8870.00', '3850.00', '5020.00', '0.00', '1.50', '75.00', '0.00', '4945.00', '0.00', '0.00', '236.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('243', '53', '1', 'BK 8589 LL', '8070.00', '3230.00', '4840.00', '0.00', '3.00', '145.00', '0.00', '4695.00', '0.00', '0.00', '233.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('244', '59', '2', 'BK 9169 CC', '9340.00', '3710.00', '5630.00', '0.00', '1.50', '84.00', '0.00', '5546.00', '0.00', '0.00', '268.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('245', '56', '1', 'BB 8438 HC', '6100.00', '3370.00', '2730.00', '0.00', '3.00', '82.00', '0.00', '2648.00', '0.00', '0.00', '104.00', '26.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('246', '56', '1', 'BB 8650 KA', '9180.00', '3650.00', '5530.00', '0.00', '2.80', '155.00', '0.00', '5375.00', '0.00', '0.00', '268.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('247', '54', '1', 'BB 8173 KA', '10660.00', '3450.00', '7210.00', '0.00', '3.00', '216.00', '0.00', '6994.00', '0.00', '0.00', '286.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('248', '56', '3', 'BK 1163 DW', '2660.00', '1410.00', '1250.00', '0.00', '3.50', '44.00', '0.00', '1206.00', '0.00', '0.00', '50.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('249', '53', '1', 'BB 8007 KA', '7970.00', '3390.00', '4580.00', '0.00', '3.50', '160.00', '0.00', '4420.00', '0.00', '0.00', '216.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('250', '54', '1', 'F 8124 FR', '6270.00', '3580.00', '2690.00', '0.00', '3.50', '94.00', '0.00', '2596.00', '0.00', '0.00', '127.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('251', '57', '4', 'BK 9463 DR', '14940.00', '6610.00', '8330.00', '0.00', '3.30', '275.00', '0.00', '8055.00', '0.00', '0.00', '410.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('252', '54', '1', 'BM 9971 AS', '10150.00', '3210.00', '6940.00', '0.00', '3.50', '243.00', '0.00', '6697.00', '0.00', '0.00', '297.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('253', '53', '1', 'BK 9636 VN', '7470.00', '3560.00', '3910.00', '0.00', '3.00', '117.00', '0.00', '3793.00', '0.00', '0.00', '179.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('254', '59', '2', 'BK 9266 CD', '8150.00', '3790.00', '4360.00', '0.00', '1.50', '65.00', '0.00', '4295.00', '0.00', '0.00', '223.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('255', '62', '1', 'BM 8471 MA', '7120.00', '3220.00', '3900.00', '0.00', '3.00', '117.00', '0.00', '3783.00', '0.00', '0.00', '178.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('256', '62', '1', 'BB 8193 XF', '6470.00', '3180.00', '3290.00', '0.00', '3.00', '99.00', '0.00', '3191.00', '0.00', '0.00', '122.00', '27.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('257', '62', '1', 'BK 8572 BP', '7780.00', '3130.00', '4650.00', '0.00', '3.00', '140.00', '0.00', '4510.00', '0.00', '0.00', '206.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('258', '63', '1', 'BK 8038 BP', '9670.00', '3150.00', '6520.00', '0.00', '3.00', '196.00', '0.00', '6324.00', '0.00', '0.00', '281.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('259', '64', '1', 'BB 8007 KA', '8260.00', '3460.00', '4800.00', '0.00', '3.00', '144.00', '0.00', '4656.00', '0.00', '0.00', '226.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('260', '65', '2', 'BK 9565 CI', '9630.00', '3950.00', '5680.00', '0.00', '6.00', '341.00', '0.00', '5339.00', '0.00', '0.00', '612.00', '9.00', '2', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('261', '65', '2', 'BB 8527 KA', '7970.00', '3860.00', '4110.00', '0.00', '6.00', '247.00', '0.00', '3863.00', '0.00', '0.00', '471.00', '9.00', '2', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('262', '62', '1', 'BM 8344 MF', '10330.00', '3900.00', '6430.00', '0.00', '3.00', '193.00', '0.00', '6237.00', '0.00', '0.00', '329.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('263', '64', '3', 'BK 8621 YG', '3660.00', '1250.00', '2410.00', '0.00', '3.00', '72.00', '0.00', '2338.00', '0.00', '0.00', '164.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('264', '62', '1', 'BB 8921 HA', '10260.00', '3000.00', '7260.00', '0.00', '3.00', '218.00', '0.00', '7042.00', '0.00', '0.00', '323.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('265', '66', '1', 'BB 8400 KA', '9420.00', '3510.00', '5910.00', '0.00', '3.00', '177.00', '0.00', '5733.00', '0.00', '0.00', '271.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('266', '67', '1', 'BB 8008 KA', '10510.00', '3840.00', '6670.00', '12.00', '3.00', '200.00', '80040.00', '6470.00', '3000.00', '19410000.00', '287.00', '23.00', '4', '2.00', '12940.00', '1.00', '1.00', '19342900.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('267', '68', '2', 'BK 9130 BN', '9340.00', '3530.00', '5810.00', '15000.00', '3.00', '174.00', '15000.00', '5636.00', '3000.00', '16908000.00', '250.00', '23.00', '4', '0.00', '0.00', '0.00', '0.00', '16893000.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('268', '69', '2', 'BK 9057 CY', '11640.00', '4690.00', '6950.00', '15000.00', '2.80', '195.00', '15000.00', '6755.00', '2500.00', '16887500.00', '414.00', '17.00', '3', '0.00', '0.00', '1.00', '1.00', '16872500.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('269', '63', '1', 'BB 9051 KA', '4690.00', '3460.00', '1230.00', '0.00', '3.00', '37.00', '0.00', '1193.00', '0.00', '0.00', '57.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('270', '63', '1', 'BM 9812 AD', '4060.00', '2980.00', '1080.00', '0.00', '3.00', '32.00', '0.00', '1048.00', '0.00', '0.00', '44.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('271', '62', '1', 'BM 2617 AC', '9100.00', '3080.00', '6020.00', '0.00', '3.00', '181.00', '0.00', '5839.00', '0.00', '0.00', '250.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('272', '63', '2', 'BB 8888 KT', '7520.00', '3660.00', '3860.00', '0.00', '2.00', '77.00', '0.00', '3783.00', '0.00', '0.00', '153.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('273', '65', '2', 'BK 9266 CD', '10770.00', '3770.00', '7000.00', '0.00', '1.50', '105.00', '0.00', '6895.00', '0.00', '0.00', '336.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('274', '63', '2', 'BK 8611 BK', '7950.00', '3790.00', '4160.00', '0.00', '3.00', '125.00', '0.00', '4035.00', '0.00', '0.00', '180.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('275', '67', '5', 'BM 1546 FH', '3080.00', '1680.00', '1400.00', '12.00', '3.00', '42.00', '16800.00', '1358.00', '3000.00', '4074000.00', '69.00', '20.00', '4', '3.00', '4074.00', '1.00', '1.00', '4061274.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('276', '63', '1', 'BM 8997 FG', '5270.00', '3080.00', '2190.00', '0.00', '3.00', '66.00', '0.00', '2124.00', '0.00', '0.00', '90.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('277', '64', '1', 'BB 8201 KA', '7430.00', '3370.00', '4060.00', '0.00', '3.00', '122.00', '0.00', '3938.00', '0.00', '0.00', '177.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('278', '64', '1', 'BK 8108 BK', '9500.00', '3590.00', '5910.00', '0.00', '3.00', '177.00', '0.00', '5733.00', '0.00', '0.00', '279.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('279', '68', '2', 'BK 9117 BN', '9320.00', '3610.00', '5710.00', '15000.00', '3.00', '171.00', '15000.00', '5539.00', '3000.00', '16617000.00', '253.00', '23.00', '4', '0.00', '0.00', '0.00', '0.00', '16602000.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('280', '66', '1', 'BB 9062 KA', '6930.00', '3220.00', '3710.00', '0.00', '3.00', '111.00', '0.00', '3599.00', '0.00', '0.00', '151.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('281', '63', '1', 'BA 9176 JN', '7820.00', '3630.00', '4190.00', '0.00', '3.00', '126.00', '0.00', '4064.00', '0.00', '0.00', '170.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('282', '63', '1', 'BK 8349 BO', '6210.00', '3450.00', '2760.00', '0.00', '3.00', '83.00', '0.00', '2677.00', '0.00', '0.00', '126.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('283', '64', '1', 'BB 8238 LK', '7530.00', '3140.00', '4390.00', '0.00', '3.00', '132.00', '0.00', '4258.00', '0.00', '0.00', '206.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('284', '63', '5', 'BB 1065 LK', '3370.00', '2450.00', '920.00', '0.00', '3.00', '28.00', '0.00', '892.00', '0.00', '0.00', '32.00', '29.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('285', '67', '1', 'BK 8678 GW', '7760.00', '3380.00', '4380.00', '12.00', '3.00', '131.00', '52560.00', '4249.00', '3000.00', '12747000.00', '205.00', '21.00', '4', '4.00', '16996.00', '1.00', '1.00', '12711436.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('286', '63', '1', 'BB 8339 KA', '8990.00', '3330.00', '5660.00', '0.00', '2.80', '158.00', '0.00', '5502.00', '0.00', '0.00', '238.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('287', '67', '2', 'BM 9728 PU', '9360.00', '3880.00', '5480.00', '15000.00', '3.00', '164.00', '15000.00', '5316.00', '3000.00', '15948000.00', '239.00', '23.00', '4', '7.00', '37212.00', '1.00', '1.00', '15970212.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('288', '64', '2', 'BB 8483 KA', '6240.00', '3900.00', '2340.00', '0.00', '3.00', '70.00', '0.00', '2270.00', '0.00', '0.00', '149.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('289', '63', '1', 'BB 8238 KA', '4890.00', '3340.00', '1550.00', '0.00', '3.00', '47.00', '0.00', '1503.00', '0.00', '0.00', '68.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('290', '64', '1', 'BB 8438 FA', '9580.00', '3240.00', '6340.00', '0.00', '3.00', '190.00', '0.00', '6150.00', '0.00', '0.00', '303.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('291', '64', '1', 'BB 8234 KA', '6640.00', '3140.00', '3500.00', '0.00', '3.00', '105.00', '0.00', '3395.00', '0.00', '0.00', '160.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('292', '67', '1', 'BK 9636 BU', '5540.00', '3240.00', '2300.00', '12.00', '3.00', '69.00', '27600.00', '2231.00', '3000.00', '6693000.00', '101.00', '23.00', '4', '5.00', '11155.00', '1.00', '1.00', '6676555.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('293', '63', '1', 'BB 8526 LG', '8750.00', '2910.00', '5840.00', '0.00', '3.00', '175.00', '0.00', '5665.00', '0.00', '0.00', '235.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('294', '64', '1', 'BM 8158 MC', '8230.00', '3110.00', '5120.00', '0.00', '3.00', '154.00', '0.00', '4966.00', '0.00', '0.00', '218.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('295', '65', '2', 'BB 8527 KA', '9840.00', '3860.00', '5980.00', '0.00', '1.50', '90.00', '0.00', '5890.00', '0.00', '0.00', '262.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('296', '64', '1', 'BK 8419 DV', '7820.00', '3220.00', '4600.00', '0.00', '3.00', '138.00', '0.00', '4462.00', '0.00', '0.00', '210.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('297', '63', '2', 'BK 8611 BK', '8660.00', '3910.00', '4750.00', '0.00', '3.00', '143.00', '0.00', '4607.00', '0.00', '0.00', '204.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('298', '63', '3', 'BK 1163 DW', '3130.00', '1510.00', '1620.00', '0.00', '3.00', '49.00', '0.00', '1571.00', '0.00', '0.00', '82.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('299', '62', '1', 'BB 8921 HA', '9750.00', '3100.00', '6650.00', '0.00', '3.00', '200.00', '0.00', '6450.00', '0.00', '0.00', '254.00', '26.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('300', '63', '1', 'BB 8650 KA', '10680.00', '3630.00', '7050.00', '0.00', '2.80', '197.00', '0.00', '6853.00', '0.00', '0.00', '324.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('301', '65', '2', 'BK 9169 CC', '9070.00', '3730.00', '5340.00', '0.00', '6.00', '320.00', '0.00', '5020.00', '0.00', '0.00', '888.00', '6.00', '2', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('302', '64', '1', 'BB 8087 FA', '8050.00', '3290.00', '4760.00', '0.00', '3.50', '167.00', '0.00', '4593.00', '0.00', '0.00', '316.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('303', '70', '4', 'BK 9463 DR', '14240.00', '6790.00', '7450.00', '0.00', '3.00', '224.00', '0.00', '7226.00', '0.00', '0.00', '370.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('304', '65', '2', 'BK 9565 CI', '12090.00', '3980.00', '8110.00', '0.00', '1.50', '122.00', '0.00', '7988.00', '0.00', '0.00', '326.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('305', '71', '1', 'BA 8049 AB', '10370.00', '3440.00', '6930.00', '0.00', '3.00', '208.00', '0.00', '6722.00', '0.00', '0.00', '284.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('306', '71', '1', 'BA 9979 SM', '9470.00', '3430.00', '6040.00', '0.00', '3.00', '181.00', '0.00', '5859.00', '0.00', '0.00', '275.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('307', '72', '1', 'BM 8054 AU', '12290.00', '3260.00', '9030.00', '0.00', '3.00', '271.00', '0.00', '8759.00', '0.00', '0.00', '543.00', '17.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('308', '73', '1', 'BB 2313 GC', '8770.00', '3120.00', '5650.00', '0.00', '3.00', '170.00', '0.00', '5480.00', '0.00', '0.00', '245.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('309', '74', '1', 'BA 9103  XK', '9520.00', '3450.00', '6070.00', '0.00', '3.00', '182.00', '0.00', '5888.00', '0.00', '0.00', '408.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('310', '72', '1', 'BB 8611 LG', '10200.00', '3290.00', '6910.00', '0.00', '3.00', '207.00', '0.00', '6703.00', '0.00', '0.00', '340.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('311', '75', '2', 'BK 8340 CE', '9370.00', '3950.00', '5420.00', '0.00', '2.80', '152.00', '0.00', '5268.00', '0.00', '0.00', '220.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('312', '74', '1', 'BM 8471 MA', '8580.00', '3290.00', '5290.00', '0.00', '3.00', '159.00', '0.00', '5131.00', '0.00', '0.00', '229.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('313', '74', '1', 'BK 8572 BP', '11510.00', '3220.00', '8290.00', '0.00', '3.00', '249.00', '0.00', '8041.00', '0.00', '0.00', '361.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('314', '74', '1', 'BB 8276 LK', '8890.00', '3370.00', '5520.00', '0.00', '3.00', '166.00', '0.00', '5354.00', '0.00', '0.00', '249.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('315', '73', '1', 'BB 8007 KA', '11550.00', '3400.00', '8150.00', '0.00', '3.00', '245.00', '0.00', '7905.00', '0.00', '0.00', '368.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('316', '74', '1', 'BB 8207 LK', '9850.00', '3370.00', '6480.00', '0.00', '3.00', '194.00', '0.00', '6286.00', '0.00', '0.00', '322.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('317', '72', '1', 'BB 8173 KA', '10980.00', '3550.00', '7430.00', '0.00', '3.00', '223.00', '0.00', '7207.00', '0.00', '0.00', '321.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('318', '71', '1', 'BA 9264 DE', '10920.00', '3250.00', '7670.00', '0.00', '3.00', '230.00', '0.00', '7440.00', '0.00', '0.00', '313.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('319', '76', '1', 'BK 8337 BG', '7010.00', '3490.00', '3520.00', '0.00', '3.00', '106.00', '0.00', '3414.00', '0.00', '0.00', '240.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('320', '72', '1', 'BA 9990 YB', '5080.00', '3000.00', '2080.00', '0.00', '3.00', '62.00', '0.00', '2018.00', '0.00', '0.00', '90.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('321', '73', '3', 'BK 8621 YG', '3430.00', '1130.00', '2300.00', '0.00', '3.00', '69.00', '0.00', '2231.00', '0.00', '0.00', '142.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('322', '73', '1', 'BB 8288 FA', '10960.00', '3550.00', '7410.00', '0.00', '3.00', '222.00', '0.00', '7188.00', '0.00', '0.00', '330.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('323', '73', '1', 'BK 8589 LL', '9190.00', '3270.00', '5920.00', '0.00', '3.00', '178.00', '0.00', '5742.00', '0.00', '0.00', '376.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('324', '74', '1', 'BM 9971 AS', '8560.00', '3260.00', '5300.00', '0.00', '3.00', '159.00', '0.00', '5141.00', '0.00', '0.00', '248.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('325', '74', '2', 'BM 8733 MU', '8400.00', '4070.00', '4330.00', '0.00', '3.00', '130.00', '0.00', '4200.00', '0.00', '0.00', '195.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('326', '77', '1', 'BB 8234 KA', '7970.00', '3360.00', '4610.00', '0.00', '3.00', '138.00', '0.00', '4472.00', '0.00', '0.00', '194.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('327', '72', '1', 'BB 8026 LK', '4630.00', '3400.00', '1230.00', '0.00', '3.00', '37.00', '0.00', '1193.00', '0.00', '0.00', '53.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('328', '72', '1', 'BB 8795 HB', '7860.00', '3360.00', '4500.00', '0.00', '3.00', '135.00', '0.00', '4365.00', '0.00', '0.00', '300.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('329', '73', '1', 'BB 9194 LK', '8640.00', '3240.00', '5400.00', '0.00', '3.00', '162.00', '0.00', '5238.00', '0.00', '0.00', '205.00', '26.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('330', '73', '1', 'BA 8950 AJ', '9540.00', '3410.00', '6130.00', '0.00', '3.00', '184.00', '0.00', '5946.00', '0.00', '0.00', '380.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('331', '72', '1', 'BA 9925 CY', '9790.00', '3480.00', '6310.00', '0.00', '3.00', '189.00', '0.00', '6121.00', '0.00', '0.00', '280.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('332', '78', '2', 'BB 8483 KA', '12410.00', '3840.00', '8570.00', '0.00', '1.50', '129.00', '0.00', '8441.00', '0.00', '0.00', '325.00', '26.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('333', '72', '2', 'BA 9276 VG', '7020.00', '3890.00', '3130.00', '0.00', '3.00', '94.00', '0.00', '3036.00', '0.00', '0.00', '154.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('334', '72', '3', 'BK 1103 PI', '2110.00', '1500.00', '610.00', '0.00', '2.00', '12.00', '0.00', '598.00', '0.00', '0.00', '27.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('335', '73', '1', 'BB 8324 KA', '5380.00', '3210.00', '2170.00', '0.00', '3.00', '65.00', '0.00', '2105.00', '0.00', '0.00', '86.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('336', '73', '3', 'BB 77 KA', '2260.00', '1560.00', '700.00', '0.00', '3.00', '21.00', '0.00', '679.00', '0.00', '0.00', '36.00', '19.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('337', '79', '2', 'BK 9058 CY', '12340.00', '4790.00', '7550.00', '0.00', '2.80', '211.00', '0.00', '7339.00', '0.00', '0.00', '348.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('338', '72', '1', 'BB 8389 LK', '4710.00', '3160.00', '1550.00', '0.00', '3.00', '47.00', '0.00', '1503.00', '0.00', '0.00', '98.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('339', '72', '3', 'B 1861 WLO', '2570.00', '1400.00', '1170.00', '0.00', '3.00', '35.00', '0.00', '1135.00', '0.00', '0.00', '71.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('340', '72', '3', 'BK 1163 DW', '3660.00', '1430.00', '2230.00', '0.00', '3.00', '67.00', '0.00', '2163.00', '0.00', '0.00', '105.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('341', '72', '3', 'BK 2017 KA', '2470.00', '1510.00', '960.00', '0.00', '2.00', '19.00', '0.00', '941.00', '0.00', '0.00', '35.00', '27.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('342', '80', '2', 'BK 9130 BN', '8660.00', '3570.00', '5090.00', '0.00', '3.00', '153.00', '0.00', '4937.00', '0.00', '0.00', '225.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('343', '72', '2', 'BB 8888 KT', '8110.00', '3650.00', '4460.00', '0.00', '2.00', '89.00', '0.00', '4371.00', '0.00', '0.00', '140.00', '32.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('344', '80', '2', 'BK 9117 BN', '8050.00', '3610.00', '4440.00', '0.00', '3.00', '133.00', '0.00', '4307.00', '0.00', '0.00', '210.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('345', '71', '1', 'BB 8461 KA', '6490.00', '3540.00', '2950.00', '0.00', '3.00', '89.00', '0.00', '2861.00', '0.00', '0.00', '136.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('346', '72', '1', 'BA 9384 JT', '10440.00', '3550.00', '6890.00', '0.00', '2.80', '193.00', '0.00', '6697.00', '0.00', '0.00', '330.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('347', '75', '2', 'BK 9430 DB', '8370.00', '4020.00', '4350.00', '0.00', '2.80', '122.00', '0.00', '4228.00', '0.00', '0.00', '194.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('348', '74', '1', 'BK 8174 BY', '7580.00', '3190.00', '4390.00', '0.00', '3.00', '132.00', '0.00', '4258.00', '0.00', '0.00', '167.00', '26.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('349', '72', '3', 'B 1861 WLO', '2360.00', '1400.00', '960.00', '0.00', '3.00', '29.00', '0.00', '931.00', '0.00', '0.00', '47.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('350', '72', '1', 'BB 8083 LK', '6550.00', '3060.00', '3490.00', '0.00', '3.00', '105.00', '0.00', '3385.00', '0.00', '0.00', '141.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('351', '71', '1', 'BH 8453 AG', '10380.00', '3560.00', '6820.00', '0.00', '3.00', '205.00', '0.00', '6615.00', '0.00', '0.00', '299.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('352', '71', '2', 'BM 9728 PU', '6720.00', '3870.00', '2850.00', '0.00', '3.00', '86.00', '0.00', '2764.00', '0.00', '0.00', '127.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('353', '74', '1', 'BA 9103  XK', '10300.00', '3280.00', '7020.00', '0.00', '3.00', '211.00', '0.00', '6809.00', '0.00', '0.00', '431.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('354', '72', '1', 'BM 9006 LD', '8190.00', '3380.00', '4810.00', '0.00', '3.00', '144.00', '0.00', '4666.00', '0.00', '0.00', '240.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('355', '72', '1', 'BB 8584 KA', '11810.00', '3590.00', '8220.00', '0.00', '2.80', '230.00', '0.00', '7990.00', '0.00', '0.00', '356.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('356', '72', '2', 'BB 8144 LK', '8820.00', '3600.00', '5220.00', '0.00', '3.00', '157.00', '0.00', '5063.00', '0.00', '0.00', '344.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('357', '71', '1', 'BK 8678 GW', '10040.00', '3610.00', '6430.00', '0.00', '3.00', '193.00', '0.00', '6237.00', '0.00', '0.00', '295.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('358', '72', '3', 'B 1861 WLO', '2080.00', '1410.00', '670.00', '0.00', '3.00', '20.00', '0.00', '650.00', '0.00', '0.00', '23.00', '29.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('359', '72', '2', 'BK 8611 BK', '6950.00', '3860.00', '3090.00', '0.00', '3.00', '93.00', '0.00', '2997.00', '0.00', '0.00', '124.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('360', '72', '1', 'BB 9051 KA', '6310.00', '3500.00', '2810.00', '0.00', '3.00', '84.00', '0.00', '2726.00', '0.00', '0.00', '139.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('361', '74', '1', 'BB 8276 LK', '10870.00', '3610.00', '7260.00', '0.00', '3.00', '218.00', '0.00', '7042.00', '0.00', '0.00', '308.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('362', '73', '1', 'BB 8238 LK', '7450.00', '3220.00', '4230.00', '0.00', '3.00', '127.00', '0.00', '4103.00', '0.00', '0.00', '200.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('363', '71', '1', 'BA 9264 DE', '8160.00', '3380.00', '4780.00', '0.00', '3.00', '143.00', '0.00', '4637.00', '0.00', '0.00', '204.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('364', '81', '1', 'BA 9260 JM', '11550.00', '3380.00', '8170.00', '0.00', '3.00', '245.00', '0.00', '7925.00', '0.00', '0.00', '354.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('365', '73', '1', 'BB 8061 LK', '7200.00', '3150.00', '4050.00', '0.00', '3.00', '122.00', '0.00', '3928.00', '0.00', '0.00', '195.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('366', '71', '1', 'BK 9636 BU', '6580.00', '3190.00', '3390.00', '0.00', '3.00', '102.00', '0.00', '3288.00', '0.00', '0.00', '142.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('367', '73', '1', 'BB 8006 LK', '10130.00', '3130.00', '7000.00', '0.00', '3.00', '210.00', '0.00', '6790.00', '0.00', '0.00', '273.00', '26.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('368', '78', '2', 'BK 9169 CC', '10260.00', '3680.00', '6580.00', '0.00', '1.50', '99.00', '0.00', '6481.00', '0.00', '0.00', '285.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('369', '78', '2', 'BB 8483 KA', '6550.00', '3850.00', '2700.00', '0.00', '1.50', '41.00', '0.00', '2659.00', '0.00', '0.00', '145.00', '19.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('370', '78', '2', 'BB 8527 KA', '9310.00', '3850.00', '5460.00', '0.00', '1.50', '82.00', '0.00', '5378.00', '0.00', '0.00', '251.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('371', '78', '2', 'BK 9266 CD', '7800.00', '3780.00', '4020.00', '0.00', '6.00', '241.00', '0.00', '3779.00', '0.00', '0.00', '779.00', '5.00', '1', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('372', '82', '2', 'BM 9572 MH', '9900.00', '4020.00', '5880.00', '0.00', '2.80', '165.00', '0.00', '5715.00', '0.00', '0.00', '254.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('373', '83', '1', 'BA 9178 JB', '8610.00', '3430.00', '5180.00', '0.00', '3.00', '155.00', '0.00', '5025.00', '0.00', '0.00', '353.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('374', '84', '1', 'BB 8055 KA', '9830.00', '3540.00', '6290.00', '0.00', '3.00', '189.00', '0.00', '6101.00', '0.00', '0.00', '270.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('375', '84', '3', 'BK 8621 YG', '3820.00', '1200.00', '2620.00', '0.00', '3.00', '79.00', '0.00', '2541.00', '0.00', '0.00', '166.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('376', '85', '1', 'BB 8611 LG', '9610.00', '3280.00', '6330.00', '0.00', '3.00', '190.00', '0.00', '6140.00', '0.00', '0.00', '305.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('377', '85', '1', 'BK 8038 BP', '9830.00', '3050.00', '6780.00', '0.00', '3.00', '203.00', '0.00', '6577.00', '0.00', '0.00', '292.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('378', '86', '1', 'BA 9938 SU', '10590.00', '3690.00', '6900.00', '0.00', '3.00', '207.00', '0.00', '6693.00', '0.00', '0.00', '435.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('379', '84', '1', 'BA 8950 AJ', '9630.00', '3190.00', '6440.00', '0.00', '3.00', '193.00', '0.00', '6247.00', '0.00', '0.00', '287.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('380', '83', '1', 'BM 8344 MF', '10060.00', '3800.00', '6260.00', '0.00', '3.00', '188.00', '0.00', '6072.00', '0.00', '0.00', '260.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('381', '87', '1', 'BB 8400 KA', '8900.00', '3670.00', '5230.00', '0.00', '3.00', '157.00', '0.00', '5073.00', '0.00', '0.00', '223.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('382', '84', '1', 'BB 8288 FA', '10710.00', '4350.00', '6360.00', '0.00', '3.00', '191.00', '0.00', '6169.00', '0.00', '0.00', '414.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('383', '83', '1', 'BM 9971 AS', '8520.00', '3210.00', '5310.00', '0.00', '3.00', '159.00', '0.00', '5151.00', '0.00', '0.00', '248.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('384', '83', '1', 'BB 8921 HA', '7050.00', '3080.00', '3970.00', '0.00', '3.00', '119.00', '0.00', '3851.00', '0.00', '0.00', '172.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('385', '85', '1', 'BB 8795 HB', '8130.00', '3320.00', '4810.00', '0.00', '3.00', '144.00', '0.00', '4666.00', '0.00', '0.00', '312.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('386', '87', '1', 'BB 9204 FA', '11600.00', '3770.00', '7830.00', '0.00', '3.30', '258.00', '0.00', '7572.00', '0.00', '0.00', '331.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('387', '84', '1', 'BB 7770 HB', '11110.00', '3210.00', '7900.00', '0.00', '3.00', '237.00', '0.00', '7663.00', '0.00', '0.00', '523.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('388', '85', '1', 'BA 9925 CY', '10110.00', '3360.00', '6750.00', '0.00', '3.00', '203.00', '0.00', '6547.00', '0.00', '0.00', '431.00', '16.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('389', '86', '3', 'BB 8349 KA', '4550.00', '1410.00', '3140.00', '0.00', '3.00', '94.00', '0.00', '3046.00', '0.00', '0.00', '139.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('390', '83', '1', 'BK 8174 BY', '6090.00', '3090.00', '3000.00', '0.00', '3.00', '90.00', '0.00', '2910.00', '0.00', '0.00', '116.00', '26.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('391', '85', '2', 'BB 8888 KT', '6070.00', '3650.00', '2420.00', '0.00', '2.00', '48.00', '0.00', '2372.00', '0.00', '0.00', '80.00', '30.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('392', '85', '3', 'BK 1103 PI', '3110.00', '1510.00', '1600.00', '0.00', '2.00', '32.00', '0.00', '1568.00', '0.00', '0.00', '70.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('393', '88', '2', 'BB 8527 KA', '11110.00', '3840.00', '7270.00', '0.00', '1.50', '109.00', '0.00', '7161.00', '0.00', '0.00', '325.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('394', '83', '1', 'BK 8437 ND', '6150.00', '3260.00', '2890.00', '0.00', '3.00', '87.00', '0.00', '2803.00', '0.00', '0.00', '127.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('395', '85', '3', 'BB 1172 LK', '2360.00', '1510.00', '850.00', '0.00', '3.00', '26.00', '0.00', '824.00', '0.00', '0.00', '42.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('396', '85', '3', 'BK 1103 PI', '2430.00', '1520.00', '910.00', '0.00', '3.00', '27.00', '0.00', '883.00', '0.00', '0.00', '62.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('397', '84', '2', 'BM 8818 MH', '8830.00', '4050.00', '4780.00', '0.00', '3.00', '143.00', '0.00', '4637.00', '0.00', '0.00', '214.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('398', '85', '1', 'BB 8650 KA', '9760.00', '3570.00', '6190.00', '0.00', '2.80', '173.00', '0.00', '6017.00', '0.00', '0.00', '293.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('399', '89', '1', 'BK 8337 BG', '7330.00', '3560.00', '3770.00', '0.00', '3.00', '113.00', '0.00', '3657.00', '0.00', '0.00', '278.00', '14.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('400', '82', '2', 'BM 9303 MU', '8810.00', '4140.00', '4670.00', '0.00', '2.80', '131.00', '0.00', '4539.00', '0.00', '0.00', '209.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('401', '85', '1', 'BB 8584 KA', '9240.00', '3580.00', '5660.00', '0.00', '2.80', '158.00', '0.00', '5502.00', '0.00', '0.00', '266.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('402', '88', '2', 'BK 9266 CD', '6300.00', '3770.00', '2530.00', '0.00', '1.50', '38.00', '0.00', '2492.00', '0.00', '0.00', '100.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('403', '84', '1', 'BB 8324 KA', '5140.00', '3160.00', '1980.00', '0.00', '3.00', '59.00', '0.00', '1921.00', '0.00', '0.00', '129.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('404', '84', '1', 'BM 8158 MC', '9890.00', '3010.00', '6880.00', '0.00', '3.00', '206.00', '0.00', '6674.00', '0.00', '0.00', '277.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('405', '84', '1', 'BM 2617 AC', '8130.00', '3120.00', '5010.00', '0.00', '3.00', '150.00', '0.00', '4860.00', '0.00', '0.00', '241.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('406', '85', '1', 'BB 8469 FA', '10670.00', '3310.00', '7360.00', '0.00', '3.00', '221.00', '0.00', '7139.00', '0.00', '0.00', '316.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('407', '90', '1', 'BB 8438 FH', '8160.00', '3180.00', '4980.00', '0.00', '3.00', '149.00', '0.00', '4831.00', '0.00', '0.00', '245.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('408', '86', '2', 'BM 9728 PU', '7990.00', '3920.00', '4070.00', '0.00', '3.00', '122.00', '0.00', '3948.00', '0.00', '0.00', '155.00', '26.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('409', '84', '1', 'BB 2313 GC', '8160.00', '3290.00', '4870.00', '0.00', '3.00', '146.00', '0.00', '4724.00', '0.00', '0.00', '220.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('410', '86', '1', 'BA 8049 AB', '11350.00', '3460.00', '7890.00', '0.00', '3.00', '237.00', '0.00', '7653.00', '0.00', '0.00', '334.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('411', '83', '1', 'BB 8173 KA', '10780.00', '3410.00', '7370.00', '0.00', '3.00', '221.00', '0.00', '7149.00', '0.00', '0.00', '320.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('412', '84', '1', 'BM 9221 MA', '9270.00', '3600.00', '5670.00', '0.00', '3.00', '170.00', '0.00', '5500.00', '0.00', '0.00', '283.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('413', '84', '1', 'BB 8006 LK', '8900.00', '3080.00', '5820.00', '0.00', '3.00', '175.00', '0.00', '5645.00', '0.00', '0.00', '224.00', '26.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('414', '85', '3', 'BK 1103 PI', '2370.00', '1510.00', '860.00', '0.00', '3.00', '26.00', '0.00', '834.00', '0.00', '0.00', '37.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('415', '85', '1', 'BB 8339 KA', '7700.00', '3330.00', '4370.00', '0.00', '2.80', '122.00', '0.00', '4248.00', '0.00', '0.00', '182.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('416', '85', '1', 'BM 9006 LD', '7510.00', '3370.00', '4140.00', '0.00', '3.00', '124.00', '0.00', '4016.00', '0.00', '0.00', '198.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('417', '86', '1', 'BB 8461 KA', '9000.00', '3560.00', '5440.00', '0.00', '3.00', '163.00', '0.00', '5277.00', '0.00', '0.00', '239.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('418', '88', '2', 'BK 9565 CI', '8940.00', '3950.00', '4990.00', '0.00', '1.50', '75.00', '0.00', '4915.00', '0.00', '0.00', '197.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('419', '87', '1', 'BB 8400 KA', '11160.00', '3830.00', '7330.00', '0.00', '3.00', '220.00', '0.00', '7110.00', '0.00', '0.00', '296.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('420', '86', '1', 'BA 9938 SU', '7630.00', '3760.00', '3870.00', '0.00', '3.00', '116.00', '0.00', '3754.00', '0.00', '0.00', '191.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('421', '85', '1', 'BK 8175 YK', '8990.00', '3120.00', '5870.00', '0.00', '3.00', '176.00', '0.00', '5694.00', '0.00', '0.00', '229.00', '26.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('422', '84', '1', 'BB 8238 LK', '6980.00', '3130.00', '3850.00', '0.00', '3.00', '116.00', '0.00', '3734.00', '0.00', '0.00', '174.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('423', '85', '2', 'BB 9049 LK', '6480.00', '3870.00', '2610.00', '0.00', '3.00', '78.00', '0.00', '2532.00', '0.00', '0.00', '131.00', '20.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('424', '83', '1', 'BA 9103  XK', '7810.00', '3290.00', '4520.00', '0.00', '3.00', '136.00', '0.00', '4384.00', '0.00', '0.00', '183.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('425', '84', '1', 'BB 8007 KA', '7240.00', '3380.00', '3860.00', '0.00', '3.00', '116.00', '0.00', '3744.00', '0.00', '0.00', '145.00', '27.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('426', '86', '1', 'BA 9979 SM', '9650.00', '3630.00', '6020.00', '0.00', '3.00', '181.00', '0.00', '5839.00', '0.00', '0.00', '267.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('427', '88', '2', 'BB 8483 KA', '7230.00', '3820.00', '3410.00', '0.00', '1.50', '51.00', '0.00', '3359.00', '0.00', '0.00', '142.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('428', '86', '1', 'BK 8678 GW', '10260.00', '3400.00', '6860.00', '0.00', '3.00', '206.00', '0.00', '6654.00', '0.00', '0.00', '281.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('429', '91', '1', 'BB 8276 LK', '10920.00', '3380.00', '7540.00', '0.00', '3.00', '226.00', '0.00', '7314.00', '0.00', '0.00', '348.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('430', '91', '1', 'BK 8572 BP', '10590.00', '3250.00', '7340.00', '0.00', '3.00', '220.00', '0.00', '7120.00', '0.00', '0.00', '310.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('431', '91', '1', 'BK 9690 LP', '10370.00', '3550.00', '6820.00', '0.00', '3.00', '205.00', '0.00', '6615.00', '0.00', '0.00', '286.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('432', '91', '1', 'BB 8193 XF', '10210.00', '3190.00', '7020.00', '0.00', '3.00', '211.00', '0.00', '6809.00', '0.00', '0.00', '283.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('433', '92', '1', 'BB 8067 JA', '7760.00', '3630.00', '4130.00', '0.00', '3.00', '124.00', '0.00', '4006.00', '0.00', '0.00', '198.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('434', '93', '3', 'BM 9342 DH', '2830.00', '1310.00', '1520.00', '0.00', '3.00', '46.00', '0.00', '1474.00', '0.00', '0.00', '53.00', '29.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('435', '94', '1', 'BH 8453 AG', '11030.00', '4100.00', '6930.00', '0.00', '3.00', '208.00', '0.00', '6722.00', '0.00', '0.00', '314.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('436', '93', '1', 'BK 8038 BP', '10020.00', '3260.00', '6760.00', '0.00', '3.00', '203.00', '0.00', '6557.00', '0.00', '0.00', '298.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('437', '93', '2', 'BK 8611 BK', '7100.00', '3840.00', '3260.00', '0.00', '3.00', '98.00', '0.00', '3162.00', '0.00', '0.00', '220.00', '15.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('438', '91', '1', 'BM 9971 AS', '9830.00', '3180.00', '6650.00', '0.00', '3.00', '200.00', '0.00', '6450.00', '0.00', '0.00', '272.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('439', '93', '1', 'BA 9925 CY', '8460.00', '3300.00', '5160.00', '0.00', '3.00', '155.00', '0.00', '5005.00', '0.00', '0.00', '241.00', '21.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('440', '95', '2', 'BK 9130 BN', '8270.00', '3620.00', '4650.00', '0.00', '3.00', '140.00', '0.00', '4510.00', '0.00', '0.00', '200.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('441', '93', '1', 'BA 9176 JN', '8290.00', '3440.00', '4850.00', '0.00', '3.00', '146.00', '0.00', '4704.00', '0.00', '0.00', '193.00', '25.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('442', '96', '2', 'BB 8483 KA', '10850.00', '3820.00', '7030.00', '0.00', '1.50', '105.00', '0.00', '6925.00', '0.00', '0.00', '296.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('443', '94', '3', 'BM 9034 TG', '3440.00', '1760.00', '1680.00', '0.00', '3.00', '50.00', '0.00', '1630.00', '0.00', '0.00', '124.00', '14.00', '3', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('444', '97', '2', 'BK 9058 CY', '12000.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '1', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('445', '98', '1', 'BA 8049 AB', '11680.00', '3240.00', '8440.00', '12.00', '3.50', '295.00', '101280.00', '8145.00', '5000.00', '40725000.00', '394.00', '21.00', '4', '5.00', '40725.00', '1.00', '1.00', '40664444.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('446', '98', '2', 'BA 9938 SU', '10890.00', '3820.00', '7070.00', '15000.00', '3.50', '247.00', '15000.00', '6823.00', '4500.00', '30703500.00', '446.00', '16.00', '3', '5.00', '34115.00', '1.00', '1.00', '30722616.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('447', '99', '1', 'BM 9227 LP', '9090.00', '4170.00', '4920.00', '12.00', '3.50', '172.00', '59040.00', '4748.00', '2500.00', '11870000.00', '370.00', '13.00', '3', '10.00', '47480.00', '1.00', '1.00', '11858440.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('448', '99', '2', 'BM 9397 PU', '11310.00', '3990.00', '7320.00', '15000.00', '3.50', '256.00', '15000.00', '7064.00', '2500.00', '17660000.00', '481.00', '15.00', '3', '10.00', '70640.00', '1.00', '1.00', '17715640.00', '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('449', '100', '1', 'BG 45636', '12920.00', '3420.00', '9500.00', '0.00', '3.50', '333.00', '0.00', '9167.00', '0.00', '0.00', '419.00', '23.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('450', '101', '1', '1389 th', '12929.00', '3750.00', '9179.00', '0.00', '3.50', '321.00', '0.00', '8858.00', '0.00', '0.00', '413.00', '22.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('451', '101', '3', 'bd 8967', '14567.00', '2350.00', '12217.00', '0.00', '10.00', '1222.00', '0.00', '10995.00', '0.00', '0.00', '354.00', '35.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('452', '102', '2', '4567', '13590.00', '2765.00', '10825.00', '0.00', '3.50', '379.00', '0.00', '10446.00', '0.00', '0.00', '450.00', '24.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('453', '103', '3', '4589 tb', '14896.00', '4500.00', '10396.00', '0.00', '3.50', '364.00', '0.00', '10032.00', '0.00', '0.00', '325.00', '32.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('454', '104', '1', 'dw 12344', '45000.00', '12350.00', '32650.00', '0.00', '3.50', '1143.00', '0.00', '31507.00', '0.00', '0.00', '413.00', '79.00', '4', '0.00', null, null, null, null, '0');
INSERT INTO `tbt_tbs_order_detail` VALUES ('455', '104', '5', '1389 th', '56000.00', '12350.00', '43650.00', '0.00', '3.00', '1310.00', '0.00', '42340.00', '0.00', '0.00', '354.00', '123.00', '4', '0.00', null, null, null, null, '0');

-- ----------------------------
-- Table structure for tbt_transaksi_luar
-- ----------------------------
DROP TABLE IF EXISTS `tbt_transaksi_luar`;
CREATE TABLE `tbt_transaksi_luar` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sumber_transaksi` char(1) DEFAULT '0',
  `jns_transaksi` char(1) DEFAULT '0',
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT '00:00:00',
  `keterangan` varchar(80) DEFAULT NULL,
  `jml_transaksi` float(11,2) DEFAULT NULL,
  `st_posting` char(1) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_transaksi_luar
-- ----------------------------
