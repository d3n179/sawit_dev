/*
Navicat MySQL Data Transfer

Source Server         : LOCALHOST
Source Server Version : 50516
Source Host           : localhost:3306
Source Database       : sawit_dev

Target Server Type    : MYSQL
Target Server Version : 50516
File Encoding         : 65001

Date: 2017-07-24 08:08:10
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
-- Table structure for tbd_penyusutan_aktiva
-- ----------------------------
DROP TABLE IF EXISTS `tbd_penyusutan_aktiva`;
CREATE TABLE `tbd_penyusutan_aktiva` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_aktiva` int(11) DEFAULT NULL,
  `tahun_ke` int(11) DEFAULT NULL,
  `tahun` int(11) DEFAULT NULL,
  `jml_bulan` int(11) DEFAULT NULL,
  `nilai_penyusutan` float(36,2) DEFAULT NULL,
  `nilai_aktiva` float(36,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbd_penyusutan_aktiva
-- ----------------------------

-- ----------------------------
-- Table structure for tbd_penyusutan_aktiva_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbd_penyusutan_aktiva_detail`;
CREATE TABLE `tbd_penyusutan_aktiva_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_penyusutan` int(11) DEFAULT NULL,
  `tahun` int(11) DEFAULT NULL,
  `bulan` int(11) DEFAULT NULL,
  `nilai_penyusutan_bulanan` float(36,2) DEFAULT NULL,
  `jumlah_hari` int(11) DEFAULT NULL,
  `nilai_penyusutan_harian` float(36,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbd_penyusutan_aktiva_detail
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbd_stok_barang
-- ----------------------------

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
INSERT INTO `tbd_user` VALUES ('admin', '5e0f71d35f82960d72d60a8299c2a626', 'putra mahkota alam hsb', '1', '1', '2011-10-03', '14:16:08', '2017-07-10', '4:45:22', '1', '', '0');
INSERT INTO `tbd_user` VALUES ('bamz', 'a9d3b5ad5cade993e537dc01f2ac6030', 'bamz', '1', '1', '2016-01-21', '14:39:27', '2016-02-05', '12:34:34', '0', '', '1');
INSERT INTO `tbd_user` VALUES ('daulay', '57644532717f4075c0ab94ce5d8a0e68', 'Adil Habib Daulay', '77', '1', '2017-06-09', '5:27:49', '2017-07-10', '9:31:38', '1', '', '0');
INSERT INTO `tbd_user` VALUES ('duha', 'e10adc3949ba59abbe56e057f20f883e', 'Duha Sukrina Harahap', '78', '1', '2017-05-23', '12:24:00', '2017-06-30', '10:08:35', '1', '', '0');
INSERT INTO `tbd_user` VALUES ('febi', '827ccb0eea8a706c4c34a16891f84e7b', 'febi', '2', '1', '2016-01-21', '14:36:54', '2016-02-03', '18:15:03', '0', '', '1');
INSERT INTO `tbd_user` VALUES ('Futri', 'e10adc3949ba59abbe56e057f20f883e', 'Futri Sasmeita Hasibuan', '75', '1', '2017-05-10', '4:45:58', '2017-07-07', '9:36:57', '1', '', '0');
INSERT INTO `tbd_user` VALUES ('gita', '827ccb0eea8a706c4c34a16891f84e7b', 'Gita Kharisma Oktavia Hrp', '74', '1', '2017-05-27', '4:10:32', '2017-07-01', '6:25:44', '0', '', '0');
INSERT INTO `tbd_user` VALUES ('gustami', 'e10adc3949ba59abbe56e057f20f883e', 'Gustami', '76', '1', '2017-06-13', '3:41:42', '2017-07-07', '11:12:53', '1', '', '0');
INSERT INTO `tbd_user` VALUES ('hadisya', 'e10adc3949ba59abbe56e057f20f883e', 'Hadisya Sally Oktavia Nasution', '80', '1', '2017-05-23', '12:24:58', '2017-07-10', '5:19:42', '0', '', '1');
INSERT INTO `tbd_user` VALUES ('hadisyah', 'e10adc3949ba59abbe56e057f20f883e', 'Hadisyah Sally Oktavia Nasutio', '80', '1', '2017-06-08', '5:39:33', '2017-06-21', '9:22:49', '0', '', '0');
INSERT INTO `tbd_user` VALUES ('huda', '46d8bee3d4f2615b00099f264c22f1e3', 'huda', '74', '1', '2016-01-26', '19:35:53', '2016-02-03', '10:33:27', '0', '', '1');
INSERT INTO `tbd_user` VALUES ('ida', 'e10adc3949ba59abbe56e057f20f883e', 'Ida Yanti Hasibuan', '3', '1', '2017-06-12', '8:21:28', '2017-07-10', '3:26:55', '1', '', '0');
INSERT INTO `tbd_user` VALUES ('nurmuliana', 'e10adc3949ba59abbe56e057f20f883e', 'Nurmuliana Daulay', '79', '1', '2017-05-24', '7:23:08', '2017-07-07', '10:36:46', '1', '', '0');
INSERT INTO `tbd_user` VALUES ('operator', 'd8578edf8458ce06fbc5bb76a58c5ca4', 'Deni Andriansah', '73', '1', '2015-12-25', '4:04:37', '2015-12-25', '5:46:25', '0', '', '0');
INSERT INTO `tbd_user` VALUES ('pinta', 'bf5e9c42dce63bc7467cb5a6e1959f1e', 'pinta riski mala hasibuan', '3', '1', '2017-05-22', '6:26:41', '2017-07-10', '9:03:20', '1', '', '0');
INSERT INTO `tbd_user` VALUES ('test', 'd8578edf8458ce06fbc5bb76a58c5ca4', 'Test', '2', '1', '2015-12-24', '23:08:14', '2017-04-25', '11:18:59', '0', '', '1');
INSERT INTO `tbd_user` VALUES ('xadmin', 'd8578edf8458ce06fbc5bb76a58c5ca4', 'xadmin', '1', '1', '2011-10-03', '14:16:08', '2017-07-23', '18:50:27', '1', '', '0');

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
-- Table structure for tbm_aktiva_tetap
-- ----------------------------
DROP TABLE IF EXISTS `tbm_aktiva_tetap`;
CREATE TABLE `tbm_aktiva_tetap` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kode_akun` varchar(50) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `tgl_perolehan` date DEFAULT NULL,
  `harga_perolehan` float(36,2) DEFAULT NULL,
  `nilai_residu` float(36,2) DEFAULT '0.00',
  `umur_ekonomis` int(11) DEFAULT NULL,
  `tgl_akhir_peggunaan` date DEFAULT NULL,
  `jumlah_aktiva` int(11) DEFAULT '1',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of tbm_aktiva_tetap
-- ----------------------------

-- ----------------------------
-- Table structure for tbm_bank
-- ----------------------------
DROP TABLE IF EXISTS `tbm_bank`;
CREATE TABLE `tbm_bank` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(200) DEFAULT NULL,
  `no_rek` varchar(60) DEFAULT NULL,
  `nama_pemilik` varchar(100) DEFAULT NULL,
  `saldo` decimal(36,2) DEFAULT '0.00',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_bank
-- ----------------------------
INSERT INTO `tbm_bank` VALUES ('1', 'BANK PANIN', null, null, '0.00', '1');
INSERT INTO `tbm_bank` VALUES ('2', 'BANK BCA', '54656755', 'Udeng BUdeng', '0.00', '1');
INSERT INTO `tbm_bank` VALUES ('3', 'BANK ASIA', '98022341', 'Deni Andriansah', '0.00', '1');
INSERT INTO `tbm_bank` VALUES ('4', 'BANK BNI', '5476565645', 'Deni Andriansah', '0.00', '1');
INSERT INTO `tbm_bank` VALUES ('5', 'BANK JB', '958384738', 'Ani', '0.00', '1');
INSERT INTO `tbm_bank` VALUES ('6', 'BI', null, null, '0.00', '1');
INSERT INTO `tbm_bank` VALUES ('7', 'BIAYA 1', null, null, '0.00', '1');
INSERT INTO `tbm_bank` VALUES ('8', 'PETTY CASH', null, null, '50000000.00', '');
INSERT INTO `tbm_bank` VALUES ('9', 'ANZ INDONESIA', '4113220100001', 'PT. Sibuah Raya', '25000000.00', '0');
INSERT INTO `tbm_bank` VALUES ('10', 'BRI', '36701001119303', 'PT. Mujur Usaha Mandiri', '80000000.00', '0');
INSERT INTO `tbm_bank` VALUES ('11', 'BNI', '600760141', 'Pt. Sinar Halomoan', '70000000.00', '0');
INSERT INTO `tbm_bank` VALUES ('12', 'BNI', '2021956558', 'Mandurana Tbs', '0.00', '0');
INSERT INTO `tbm_bank` VALUES ('13', 'BNI', '436696841', 'Ud. Zio', '0.00', '0');
INSERT INTO `tbm_bank` VALUES ('14', 'BNI', '1980061005', 'Shs', '0.00', '0');
INSERT INTO `tbm_bank` VALUES ('15', 'BNI', '534531025', 'Ud.rizki', '0.00', '0');
INSERT INTO `tbm_bank` VALUES ('16', 'BNI', '377354972', 'Ud. Mitra Pribadi', '0.00', '0');
INSERT INTO `tbm_bank` VALUES ('17', 'BNI', '458054499', 'Ud. Pinarik Jaya', '0.00', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=1028 DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

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
INSERT INTO `tbm_barang` VALUES ('1026', null, 'SENG PLAT ALUMINIUM 0,6MM', '15', '0', '0.00', '10.00', '200.00', '0');
INSERT INTO `tbm_barang` VALUES ('1027', null, 'CETAK SURAT PENGANTAR TBS', '11', '0', '50.00', '300.00', '500.00', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=133 DEFAULT CHARSET=utf8;

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
INSERT INTO `tbm_barang_harga` VALUES ('81', '777', '2017-06-11', '25900.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('82', '783', '2017-06-11', '30000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('83', '783', '2017-06-11', '30000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('84', '302', '2017-06-11', '2500.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('85', '309', '2017-06-11', '135000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('86', '1021', '2017-06-12', '1660.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('87', '1021', '2017-06-12', '1745.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('88', '1021', '2017-06-12', '1745.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('89', '1021', '2017-06-12', '1670.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('90', '776', '2017-06-12', '30000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('91', '1021', '2017-06-13', '1745.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('92', '166', '2017-06-17', '20000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('93', '10', '2017-06-17', '8060.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('94', '777', '2017-06-19', '65900.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('95', '101', '2017-06-19', '300000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('96', '26', '2017-06-19', '1000000000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('97', '28', '2017-06-19', '1000000000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('98', '166', '2017-06-19', '20000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('99', '776', '2017-06-19', '30000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('100', '59', '2017-06-19', '120000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('101', '59', '2017-06-19', '120000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('102', '734', '2017-06-19', '15000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('103', '1021', '2017-07-01', '1605.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('104', '1021', '2017-07-01', '1605.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('105', '1020', '2017-07-01', '1640.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('106', '1021', '2017-07-01', '1530.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('107', '1021', '2017-07-01', '1605.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('108', '1021', '2017-07-01', '1605.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('109', '1021', '2017-07-01', '1605.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('110', '1021', '2017-07-01', '1605.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('111', '734', '2017-07-03', '10000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('112', '1021', '2017-07-07', '1640.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('113', '1021', '2017-07-07', '1640.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('114', '1021', '2017-07-21', '1745.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('115', '10', '2017-07-21', '3000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('116', '41', '2017-07-21', '1000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('117', '319', '2017-07-21', '150000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('118', '1021', '2017-07-21', '1735.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('119', '1021', '2017-07-21', '1735.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('120', '1011', '2017-07-23', '15000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('121', '309', '2017-07-23', '35000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('122', '101', '2017-07-23', '300000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('123', '674', '2017-07-23', '10000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('124', '1011', '2017-07-23', '15000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('125', '41', '2017-07-23', '1000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('126', '324', '2017-07-23', '35000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('127', '1011', '2017-07-23', '15000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('128', '41', '2017-07-23', '1000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('129', '324', '2017-07-23', '35000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('130', '1011', '2017-07-23', '15000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('131', '41', '2017-07-23', '1000.00', '0');
INSERT INTO `tbm_barang_harga` VALUES ('132', '324', '2017-07-23', '35000.00', '0');

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
  `id_group_coa` varchar(60) DEFAULT NULL,
  `kode_coa` varchar(60) DEFAULT NULL,
  `group_type` varchar(12) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=967 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_coa
-- ----------------------------
INSERT INTO `tbm_coa` VALUES ('2', '0', '1000', 'A', 'AKUN AKTIVA', '0');
INSERT INTO `tbm_coa` VALUES ('3', '1000', '1100', 'A', 'AKUN AKTIVA LANCAR EUY', '0');
INSERT INTO `tbm_coa` VALUES ('4', '1100', '1100.1', 'A', 'KAS', '0');
INSERT INTO `tbm_coa` VALUES ('5', '1100.1', '1100.1.1', 'A', 'Kas Operasional', '0');
INSERT INTO `tbm_coa` VALUES ('6', '1100.1', '1100.1.2', 'A', 'Kas Kecil', '0');
INSERT INTO `tbm_coa` VALUES ('7', '1100.1', '1100.1.3', 'A', 'Kas Kebun', '0');
INSERT INTO `tbm_coa` VALUES ('8', '1100.1', '1100.1.4', 'A', 'Selisih Kas', '0');
INSERT INTO `tbm_coa` VALUES ('9', '1100', '1100.2', 'A', 'BANK', '0');
INSERT INTO `tbm_coa` VALUES ('10', '1100.2', '1100.2.1', 'A', 'Bank BNI Rek. 3001109620', '0');
INSERT INTO `tbm_coa` VALUES ('11', '1100.2', '1100.2.2', 'A', 'Bank BNI Rek. 0226254813', '0');
INSERT INTO `tbm_coa` VALUES ('12', '1100', '1100.3', 'A', 'PIUTANG USAHA', '0');
INSERT INTO `tbm_coa` VALUES ('13', '1100.3', '1100.3.1', 'A', 'Piutang Usaha PT. Sari Dumai Sejati', '0');
INSERT INTO `tbm_coa` VALUES ('14', '1100.3', '1100.3.2', 'A', 'Piutang  Usaha : PT. PHG', '0');
INSERT INTO `tbm_coa` VALUES ('15', '1100', '1100.4', 'A', 'PIUTANG HUBUNGAN AFILIASI', '0');
INSERT INTO `tbm_coa` VALUES ('16', '1100.4', '1100.4.1', 'A', 'Piutang Kepada SPBU H. Rajamin Hasibuan', '0');
INSERT INTO `tbm_coa` VALUES ('17', '1100.4', '1100.4.2', 'A', 'Piutang Kepada PT. ……..', '0');
INSERT INTO `tbm_coa` VALUES ('18', '1100.4', '1100.4.3', 'A', 'Piutang Kepada PT. ……..', '0');
INSERT INTO `tbm_coa` VALUES ('19', '1100.4', '1100.4.4', 'A', 'Piutang Kepada PT. ……..', '0');
INSERT INTO `tbm_coa` VALUES ('20', '1100', '1100.5', 'A', 'PIUTANG STAFF DAN KARYAWAN', '0');
INSERT INTO `tbm_coa` VALUES ('21', '1100.5', '1100.5.1', 'A', 'Piutang Staff', '0');
INSERT INTO `tbm_coa` VALUES ('22', '1100.5', '1100.5.2', 'A', 'Piutang Karyawan Tetap', '0');
INSERT INTO `tbm_coa` VALUES ('23', '1100.5', '1100.5.3', 'A', 'Piutang Karyawan BHL', '0');
INSERT INTO `tbm_coa` VALUES ('24', '1100', '1000.6', 'A', 'UANG MUKA', '0');
INSERT INTO `tbm_coa` VALUES ('25', '1000.6', '1100.6.1', 'A', 'Uang Muka : Direksi', '0');
INSERT INTO `tbm_coa` VALUES ('26', '1000.6', '1100.6.2', 'A', 'Uang Muka : Staff', '0');
INSERT INTO `tbm_coa` VALUES ('27', '1000.6', '1100.6.3', 'A', 'Uang Muka : Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('28', '1000.6', '1100.6.4', 'A', 'Uang Muka : Supplier', '0');
INSERT INTO `tbm_coa` VALUES ('29', '1100', '1100.7', 'A', 'PERSEDIAAN', '0');
INSERT INTO `tbm_coa` VALUES ('30', '1100.7', '1100.7.1', 'A', 'Bahan Baku (Raw Material)', '0');
INSERT INTO `tbm_coa` VALUES ('31', '1100.7.1', '1100.7.1.1', 'A', 'Tandan Buah Segar (TBS)', '0');
INSERT INTO `tbm_coa` VALUES ('32', '1100.7', '1100.7.2', 'A', 'Bahan Dalam Proses (Work In Process)', '0');
INSERT INTO `tbm_coa` VALUES ('33', '1100.7.2', '1100.7.2.1', 'A', 'Persediaan Dalam Proses Crude Palm Oil (CPO)', '0');
INSERT INTO `tbm_coa` VALUES ('34', '1100.7.2', '1100.7.2.2', 'A', 'Persediaan Dalam Proses Palm Kernel (PK)', '0');
INSERT INTO `tbm_coa` VALUES ('35', '1100.7', '1100.7.3', 'A', 'Bahan Jadi (Finish Good)', '0');
INSERT INTO `tbm_coa` VALUES ('36', '1100.7.3', '1100.7.3.1', 'A', 'Persediaan Bahan Jadi Crude Palm Oil (CPO)', '0');
INSERT INTO `tbm_coa` VALUES ('37', '1100.7.3', '1100.7.3.2', 'A', 'Persediaan Bahan Jadi Palm Kernel (PK)', '0');
INSERT INTO `tbm_coa` VALUES ('38', '1100.7', '1100.7.4', 'A', 'Persediaan Pupuk', '0');
INSERT INTO `tbm_coa` VALUES ('39', '1100.7.4', '1100.7.4.1', 'A', 'Urea', '0');
INSERT INTO `tbm_coa` VALUES ('40', '1100.7.4', '1100.7.4.2', 'A', 'Dolomit', '0');
INSERT INTO `tbm_coa` VALUES ('41', '1100.7.4', '1100.7.4.3', 'A', 'TSP', '0');
INSERT INTO `tbm_coa` VALUES ('42', '1100.7', '1100.7.5', 'A', 'Chemical', '0');
INSERT INTO `tbm_coa` VALUES ('43', '1100.7.5', '1100.7.5.1', 'A', 'Chemical PKS', '0');
INSERT INTO `tbm_coa` VALUES ('44', '1100.7.5', '1100.7.5.2', 'A', 'Chemical Laboratorium', '0');
INSERT INTO `tbm_coa` VALUES ('45', '1100.7.5', '1100.7.5.3', 'A', 'Chemical Kebun', '0');
INSERT INTO `tbm_coa` VALUES ('46', '1100.7.5', '1100.7.5.4', 'A', 'Chemical Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('47', '1100.7', '1100.7.6', 'A', 'BBM, Pelumas dan Oli', '0');
INSERT INTO `tbm_coa` VALUES ('48', '1100.7.6', '1100.7.6a', 'A', 'BBM, Pelumas dan Oli PKS', '0');
INSERT INTO `tbm_coa` VALUES ('49', '1100.7.6a', '1100.7.6a1', 'A', 'BBM', '0');
INSERT INTO `tbm_coa` VALUES ('50', '1100.7.6a', '1100.7.6a2', 'A', 'Oli', '0');
INSERT INTO `tbm_coa` VALUES ('51', '1100.7.6', '1100.7.6b', 'A', 'BBM, Pelumas dan Oli Kebun', '0');
INSERT INTO `tbm_coa` VALUES ('52', '1100.7.6b', '1100.7.6b1', 'A', 'BBM', '0');
INSERT INTO `tbm_coa` VALUES ('53', '1100.7.6b', '1100.7.6b2', 'A', 'Oli', '0');
INSERT INTO `tbm_coa` VALUES ('54', '1100.7', '1100.7.7', 'A', 'SPARE PART', '0');
INSERT INTO `tbm_coa` VALUES ('55', '1100.7.7', '1100.7.7a', 'A', 'Spare Part PKS', '0');
INSERT INTO `tbm_coa` VALUES ('56', '1100.7.7a', '1100.7.7a1', 'A', 'Sparepart Kendaraan', '0');
INSERT INTO `tbm_coa` VALUES ('57', '1100.7.7a', '1100.7.7a2', 'A', 'Sparepart Mesin Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('58', '1100.7.7a', '1100.7.7a3', 'A', 'Sparepart Peralatan Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('59', '1100.7.7a', '1100.7.7a4', 'A', 'Sparepart Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('60', '1100.7.7a', '1100.7.7a5', 'A', 'Alat-alat Laboratorium', '0');
INSERT INTO `tbm_coa` VALUES ('61', '1100.7.7a', '1100.7.7a6', 'A', 'Sparepart Mesin Listrik', '0');
INSERT INTO `tbm_coa` VALUES ('62', '1100.7.7', '1100.7.7b', 'A', 'Spare Part Kebun', '0');
INSERT INTO `tbm_coa` VALUES ('63', '1100.7.7b', '1100.7.7b1', 'A', 'Sparepart Kendaraan', '0');
INSERT INTO `tbm_coa` VALUES ('64', '1100.7.7b', '1100.7.7b2', 'A', 'Sparepart mesin Dompeng', '0');
INSERT INTO `tbm_coa` VALUES ('65', '1100.7.7b', '1100.7.7b3', 'A', 'Sparepart Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('66', '1100.7', '1100.7.8', 'A', 'BAHAN BANGUNAN, ELEKTRIK & LISTRIK', '0');
INSERT INTO `tbm_coa` VALUES ('67', '1100.7.8', '1100.7.8a', 'A', 'BAHAN BANGUNAN, ELEKTRIK & LISTRIK PKS', '0');
INSERT INTO `tbm_coa` VALUES ('68', '1100.7.8a', '1100.7.8a1', 'A', 'Persediaan Bahan Elektrik & Listrik', '0');
INSERT INTO `tbm_coa` VALUES ('69', '1100.7.8a', '1100.7.8a2', 'A', 'Peralatan Instalasi Air', '0');
INSERT INTO `tbm_coa` VALUES ('70', '1100.7.8a', '1100.7.8a3', 'A', 'Bahan Bangunan', '0');
INSERT INTO `tbm_coa` VALUES ('71', '1100.7.8', '1100.7.8b', 'A', 'BAHAN BANGUNAN, ELEKTRIK & LISTRIK KEBUN', '0');
INSERT INTO `tbm_coa` VALUES ('72', '1100.7.8b', '1100.7.8b1', 'A', 'Persediaan Bahan Elektrik & Listrik', '0');
INSERT INTO `tbm_coa` VALUES ('73', '1100.7.8b', '1100.7.8b2', 'A', 'Peralatan Instalasi Air', '0');
INSERT INTO `tbm_coa` VALUES ('74', '1100.7.8b', '1100.7.8b3', 'A', 'Bahan Bangunan', '0');
INSERT INTO `tbm_coa` VALUES ('75', '1100.7', '1100.7.9', 'A', 'BIBITAN & KACANGAN', '0');
INSERT INTO `tbm_coa` VALUES ('76', '1100.7.9', '1100.7.9.1', 'A', 'Kacangan', '0');
INSERT INTO `tbm_coa` VALUES ('77', '1100.7.9', '1100.7.9.2', 'A', 'Bibitan Kebun Aek Siala', '0');
INSERT INTO `tbm_coa` VALUES ('78', '1100.7.9', '1100.7.9.3', 'A', 'Bibitan Kebun Bunut', '0');
INSERT INTO `tbm_coa` VALUES ('79', '1100.7.9', '1100.7.9.4', 'A', '.....', '0');
INSERT INTO `tbm_coa` VALUES ('80', '1100.7', '1100.7.10', 'A', 'MATERIAL LAINNYA', '0');
INSERT INTO `tbm_coa` VALUES ('81', '1100.7.10', '1100.7.10.1', 'A', 'Material lainnya PKS', '0');
INSERT INTO `tbm_coa` VALUES ('82', '1100.7.10', '1100.7.10.2', 'A', 'Material lainnya Kebun Aek Siala', '0');
INSERT INTO `tbm_coa` VALUES ('83', '1100.7.10', '1100.7.10.3', 'A', 'Material Lainnya Kebun Bunut', '0');
INSERT INTO `tbm_coa` VALUES ('84', '1100.7.10', '1100.7.10.4', 'A', 'Alat Tulis Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('85', '1100.7.10', '1100.7.10.5', 'A', 'Material Lainnya Kandir', '0');
INSERT INTO `tbm_coa` VALUES ('86', '1100.7.10', '1100.7.10.6', 'A', 'Material Bengkel', '0');
INSERT INTO `tbm_coa` VALUES ('87', '1100.7.10', '1100.7.10.7', 'A', 'Locist', '0');
INSERT INTO `tbm_coa` VALUES ('88', '1100.7.10', '1100.7.10.8', 'A', 'Material Lainnya Laboratorium', '0');
INSERT INTO `tbm_coa` VALUES ('89', '1100.7', '1100.7.11', 'A', 'KLINIK', '0');
INSERT INTO `tbm_coa` VALUES ('90', '1100.7.11', '1100.7.11.1', 'A', 'Obat - obatan', '0');
INSERT INTO `tbm_coa` VALUES ('91', '1100', '1100.8', 'A', 'PAJAK DIBAYAR DIMUKA (Prepaid Tax)', '0');
INSERT INTO `tbm_coa` VALUES ('92', '1100.8', '1100.8.1', 'A', 'Pajak Dibayar dimuka - PPN Masukan', '0');
INSERT INTO `tbm_coa` VALUES ('93', '1100.8', '1100.8.2', 'A', 'Pajak Dibayar dimuka - PPh 21', '0');
INSERT INTO `tbm_coa` VALUES ('94', '1100.8', '1100.8.3', 'A', 'Pajak Dibayar dimuka - PPh 23', '0');
INSERT INTO `tbm_coa` VALUES ('95', '1100.8', '1100.8.4', 'A', 'Pajak Dibayar dimuka - PPh 25', '0');
INSERT INTO `tbm_coa` VALUES ('96', '1100.8', '1100.8.5', 'A', 'Pajak Dibayar dimuka - PPh 29', '0');
INSERT INTO `tbm_coa` VALUES ('97', '1100.8', '1100.8.6', 'A', 'Pajak Bumi dan Bangunan (PBB)', '0');
INSERT INTO `tbm_coa` VALUES ('98', '1100', '1100.9', 'A', 'BIAYA DIBAYAR DIMUKA (Prepaid Expenses)', '0');
INSERT INTO `tbm_coa` VALUES ('99', '1100.9', '1100.9.1', 'A', 'Gaji dan upah', '0');
INSERT INTO `tbm_coa` VALUES ('100', '1100.9', '1100.9.2', 'A', 'Perjalanan dinas', '0');
INSERT INTO `tbm_coa` VALUES ('101', '1100.9', '1100.9.3', 'A', 'Asuransi', '0');
INSERT INTO `tbm_coa` VALUES ('102', '1100.9', '1100.9.4', 'A', 'Sewa', '0');
INSERT INTO `tbm_coa` VALUES ('103', '1100.9', '1100.9.5', 'A', 'Bonus Staff', '0');
INSERT INTO `tbm_coa` VALUES ('104', '1100.9', '1100.9.6', 'A', 'Konsultan', '0');
INSERT INTO `tbm_coa` VALUES ('105', '1100.9', '1100.9.7', 'A', 'Perobatan', '0');
INSERT INTO `tbm_coa` VALUES ('106', '1100.9', '1100.9.8', 'A', 'THR', '0');
INSERT INTO `tbm_coa` VALUES ('107', '1100.9', '1100.9.9', 'A', 'Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('108', '1000', '1200', 'B', 'AKTIVA TIDAK LANCAR', '0');
INSERT INTO `tbm_coa` VALUES ('109', '1200', '1200.1', 'B', 'PIUTANG AFILIASI JK. PANJANG', '0');
INSERT INTO `tbm_coa` VALUES ('110', '1200.1', '1200.1.1', 'B', 'PT……..', '0');
INSERT INTO `tbm_coa` VALUES ('111', '1200.1', '1200.1.2', 'B', 'CV……', '0');
INSERT INTO `tbm_coa` VALUES ('112', '1200', '1200.2', 'B', 'PIUTANG PLASMA PROJECT', '0');
INSERT INTO `tbm_coa` VALUES ('113', '1200.2', '1200.2.1', 'B', 'KKPA', '0');
INSERT INTO `tbm_coa` VALUES ('114', '1200.2', '1200.2.2', 'B', 'PIR', '0');
INSERT INTO `tbm_coa` VALUES ('115', '1200', '1200.3', 'B', 'AKTIVA TANGGUHAN', '0');
INSERT INTO `tbm_coa` VALUES ('116', '1200.3', '1200.3.1', 'B', 'Aktiva Pajak Tangguhan', '0');
INSERT INTO `tbm_coa` VALUES ('117', '1200.3', '1200.3.2', 'B', 'Aktiva Biaya Tangguhan', '0');
INSERT INTO `tbm_coa` VALUES ('118', '1200', '1200.4', 'B', 'INVESTASI JANGKA PANJANG', '0');
INSERT INTO `tbm_coa` VALUES ('119', '1200.4', '1200.4.1', 'B', 'PT. ….', '0');
INSERT INTO `tbm_coa` VALUES ('120', '1200.4', '1200.4.2', 'B', 'PT. ….', '0');
INSERT INTO `tbm_coa` VALUES ('121', '1200', '1200.5', 'B', 'ASSET', '0');
INSERT INTO `tbm_coa` VALUES ('122', '1200.5', '1200.5a', 'B', 'TANAMAN MENGHASILKAN', '0');
INSERT INTO `tbm_coa` VALUES ('123', '1200.5a', '1200.5a1', 'B', 'TM Desa Siali- Ali', '0');
INSERT INTO `tbm_coa` VALUES ('124', '1200.5a', '1200.5a2', 'B', 'TM Desa Bunut', '0');
INSERT INTO `tbm_coa` VALUES ('125', '1200.5a', '1200.5a3', 'B', 'TM….', '0');
INSERT INTO `tbm_coa` VALUES ('126', '1200.5', '1200.5b', 'B', 'TANAH', '0');
INSERT INTO `tbm_coa` VALUES ('127', '1200.5b', '1200.5b1', 'B', 'Tanah Kebun Desa Siborna Bunut', '0');
INSERT INTO `tbm_coa` VALUES ('128', '1200.5b', '1200.5b2', 'B', 'Tanah Kebun di Desa Si  Ali-ali', '0');
INSERT INTO `tbm_coa` VALUES ('129', '1200.5b', '1200.5b3', 'B', 'Tanah....', '0');
INSERT INTO `tbm_coa` VALUES ('130', '1200.5', '1200.5c', 'B', 'BANGUNAN', '0');
INSERT INTO `tbm_coa` VALUES ('131', '1200.5c', '1200.5c1', 'B', 'Bangunan Kantor & Mes', '0');
INSERT INTO `tbm_coa` VALUES ('132', '1200.5c', '1200.5c2', 'B', 'Bangunan Kantor Kebun Bunut', '0');
INSERT INTO `tbm_coa` VALUES ('133', '1200.5c', '1200.5c3', 'B', 'Bangunan Kantor Kebun Aek Siala', '0');
INSERT INTO `tbm_coa` VALUES ('134', '1200.5c', '1200.5c4', 'B', 'Bangunan Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('135', '1200.5c', '1200.5c5', 'B', 'Bangunan Kantor Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('136', '1200.5c', '1200.5c6', 'B', 'Bangunan Pos Satpam PKS', '0');
INSERT INTO `tbm_coa` VALUES ('137', '1200.5c', '1200.5c7', 'B', 'Bangunan Pos Satpam Kebun Bunut', '0');
INSERT INTO `tbm_coa` VALUES ('138', '1200.5c', '1200.5c8', 'B', 'Bangunan Pos Satpam Aek Siala', '0');
INSERT INTO `tbm_coa` VALUES ('139', '1200.5c', '1200.5c9', 'B', 'Bangunan Perumahan Staff', '0');
INSERT INTO `tbm_coa` VALUES ('140', '1200.5c', '1200.5c10', 'B', 'Bangunan Perumahan Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('141', '1200.5c', '1200.5c11', 'B', 'Bangunan Rumah Pompa', '0');
INSERT INTO `tbm_coa` VALUES ('142', '1200.5c', '1200.5c12', 'B', 'Banguna Gudang & Workshop', '0');
INSERT INTO `tbm_coa` VALUES ('143', '1200.5c', '1200.5c13', 'B', 'Bangunan Kamar Mandi', '0');
INSERT INTO `tbm_coa` VALUES ('144', '1200.5c', '1200.5c14', 'B', 'Bangunan Mussholla', '0');
INSERT INTO `tbm_coa` VALUES ('145', '1200.5c', '1200.5c15', 'B', 'Bangunan Timbangan', '0');
INSERT INTO `tbm_coa` VALUES ('146', '1200.5', '1200.5d', 'B', 'INFRASTRUKTUR', '0');
INSERT INTO `tbm_coa` VALUES ('147', '1200.5d', '1200.5d1', 'B', 'Jalan PKS', '0');
INSERT INTO `tbm_coa` VALUES ('148', '1200.5d', '1200.5d2', 'B', 'Main Road & Collection Road Desa Siali - Ali', '0');
INSERT INTO `tbm_coa` VALUES ('149', '1200.5d', '1200.5d3', 'B', 'Main Road & Collection Road Desa Bunut', '0');
INSERT INTO `tbm_coa` VALUES ('150', '1200.5d', '1200.5d4', 'B', 'Peralatan Loading Ramp', '0');
INSERT INTO `tbm_coa` VALUES ('151', '1200.5d', '1200.5d5', 'B', 'Kolam Limbah', '0');
INSERT INTO `tbm_coa` VALUES ('152', '1200.5d', '1200.5d6', 'B', 'Retaining Wall', '0');
INSERT INTO `tbm_coa` VALUES ('153', '1200.5', '1200.5e', 'B', 'MESIN DAN PERALATAN', '0');
INSERT INTO `tbm_coa` VALUES ('154', '1200.5e', '1200.5e1', 'B', 'Fruit Receiping Station', '0');
INSERT INTO `tbm_coa` VALUES ('155', '1200.5e', '1200.5e2', 'B', 'Stelizer Station', '0');
INSERT INTO `tbm_coa` VALUES ('156', '1200.5e', '1200.5e3', 'B', 'Theresing Station', '0');
INSERT INTO `tbm_coa` VALUES ('157', '1200.5e', '1200.5e4', 'B', 'Pres Station', '0');
INSERT INTO `tbm_coa` VALUES ('158', '1200.5e', '1200.5e5', 'B', 'Clarification Station', '0');
INSERT INTO `tbm_coa` VALUES ('159', '1200.5e', '1200.5e6', 'B', 'Depericarper Station', '0');
INSERT INTO `tbm_coa` VALUES ('160', '1200.5e', '1200.5e7', 'B', 'Kernel Recovery Station', '0');
INSERT INTO `tbm_coa` VALUES ('161', '1200.5e', '1200.5e8', 'B', 'Boiler Station', '0');
INSERT INTO `tbm_coa` VALUES ('162', '1200.5e', '1200.5e9', 'B', 'Power House Station', '0');
INSERT INTO `tbm_coa` VALUES ('163', '1200.5e', '1200.5e10', 'B', 'Boiler Feed Water Treatment Plant', '0');
INSERT INTO `tbm_coa` VALUES ('164', '1200.5e', '1200.5e11', 'B', 'Raw Water Teratment Plant', '0');
INSERT INTO `tbm_coa` VALUES ('165', '1200.5e', '1200.5e12', 'B', 'Electrical Instalation & Equitmen', '0');
INSERT INTO `tbm_coa` VALUES ('166', '1200.5e', '1200.5e13', 'B', 'Pipings (Including Valves)', '0');
INSERT INTO `tbm_coa` VALUES ('167', '1200.5e', '1200.5e14', 'B', 'Effluent Treatment Plant', '0');
INSERT INTO `tbm_coa` VALUES ('168', '1200.5e', '1200.5e15', 'B', 'Miscellaneous Equitment', '0');
INSERT INTO `tbm_coa` VALUES ('169', '1200.5', '1200.5f', 'B', 'TRANSPORTASI', '0');
INSERT INTO `tbm_coa` VALUES ('170', '1200.5f', '1200.5f1', 'B', 'Alat Berat', '0');
INSERT INTO `tbm_coa` VALUES ('171', '1200.5f', '1200.5f2', 'B', 'Dump Truk', '0');
INSERT INTO `tbm_coa` VALUES ('172', '1200.5f', '1200.5f3', 'B', 'Mobil', '0');
INSERT INTO `tbm_coa` VALUES ('173', '1200.5f', '1200.5f4', 'B', 'Sepeda Motor', '0');
INSERT INTO `tbm_coa` VALUES ('174', '1200.5f', '1200.5f5', 'B', 'Transportasi Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('175', '1200.5', '1200.5g', 'B', 'PERLENGKAPAN KANTOR, PERABOT DAN LAINNYA', '0');
INSERT INTO `tbm_coa` VALUES ('176', '1200.5g', '1200.5g1', 'B', 'Perabot', '0');
INSERT INTO `tbm_coa` VALUES ('177', '1200.5g', '1200.5g2', 'B', 'Perlengkapan Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('178', '1200.5g', '1200.5g3', 'B', 'Perlengkapan Perumahan', '0');
INSERT INTO `tbm_coa` VALUES ('179', '1200', '1200.6', 'B', 'ASSET DALAM PROSES', '0');
INSERT INTO `tbm_coa` VALUES ('180', '1200.6', '1200.6a', 'B', 'PABRIK', '0');
INSERT INTO `tbm_coa` VALUES ('181', '1200.6a', '1200.6a1', 'B', 'Bangunan Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('182', '1200.6a', '1200.6a2', 'B', 'Mesin Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('183', '1200.6a', '1200.6a3', 'B', 'Asset Pabrik Dalam Proses Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('184', '1200.6', '1200.6b', 'B', 'Land Clearing', '0');
INSERT INTO `tbm_coa` VALUES ('185', '1200.6b', '1200.6b1', 'B', 'Kebun Bunut', '0');
INSERT INTO `tbm_coa` VALUES ('186', '1200.6b', '1200.6b2', 'B', 'Kebun Aek Siala', '0');
INSERT INTO `tbm_coa` VALUES ('187', '1200.6b', '1200.6b3', 'B', 'Kebun Ujung Gading', '0');
INSERT INTO `tbm_coa` VALUES ('188', '1200.6', '1200.6c', 'B', 'REHABILITASI AREA', '0');
INSERT INTO `tbm_coa` VALUES ('189', '1200.6c', '1200.6c1', 'B', 'Kebun Bunut', '0');
INSERT INTO `tbm_coa` VALUES ('190', '1200.6c', '1200.6c2', 'B', 'Kebun Aek Siala', '0');
INSERT INTO `tbm_coa` VALUES ('191', '1200.6c', '1200.6c3', 'B', 'Kebun Ujung Gading', '0');
INSERT INTO `tbm_coa` VALUES ('192', '1200.6', '1200.6d', 'B', 'TANAMAN BELUM MENGHASILKAN', '0');
INSERT INTO `tbm_coa` VALUES ('193', '1200.6d', '1200.6d1', 'B', 'TBM Desa Siali- Ali', '0');
INSERT INTO `tbm_coa` VALUES ('194', '1200.6d', '1200.6d2', 'B', 'TBM Desa Bunut', '0');
INSERT INTO `tbm_coa` VALUES ('195', '1200.6d', '1200.6d3', 'B', 'TBM……', '0');
INSERT INTO `tbm_coa` VALUES ('196', '1200.6', '1200.6e', 'B', 'INFRASTRUKTUR', '0');
INSERT INTO `tbm_coa` VALUES ('197', '1200.6e', '1200.6e1', 'B', 'Jalan', '0');
INSERT INTO `tbm_coa` VALUES ('198', '1200.6e', '1200.6e2', 'B', 'Jembatan', '0');
INSERT INTO `tbm_coa` VALUES ('199', '1200.6e', '1200.6e3', 'B', 'Parit', '0');
INSERT INTO `tbm_coa` VALUES ('200', '1200.6e', '1200.6e4', 'B', 'Bangunan Kantor HO', '0');
INSERT INTO `tbm_coa` VALUES ('201', '1200.6e', '1200.6e5', 'B', 'Bangunan Kantor Kebun Bunut', '0');
INSERT INTO `tbm_coa` VALUES ('202', '1200.6e', '1200.6e6', 'B', 'Bangunan Kantor Kebun Aek Siala', '0');
INSERT INTO `tbm_coa` VALUES ('203', '1200.6e', '1200.6e7', 'B', 'Pos Satpam', '0');
INSERT INTO `tbm_coa` VALUES ('204', '1200.6e', '1200.6e8', 'B', 'Perumahan Staff', '0');
INSERT INTO `tbm_coa` VALUES ('205', '1200.6e', '1200.6e9', 'B', 'Perumahan Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('206', '1200.6e', '1200.6e10', 'B', 'Mess', '0');
INSERT INTO `tbm_coa` VALUES ('207', '1200.6e', '1200.6e10', 'B', 'Sarana Umum', '0');
INSERT INTO `tbm_coa` VALUES ('208', '1200', '1200.7', 'B', 'AKUMULASI PENYUSUTAN', '0');
INSERT INTO `tbm_coa` VALUES ('209', '1200.7', '1200.7a', 'B', 'AKUMULASI PENYUSUTAN TANAMAN', '0');
INSERT INTO `tbm_coa` VALUES ('210', '1200.7a', '1200.7.a1', 'B', 'Ak. Penyusutan TM KEBUN SIALI-ALI', '0');
INSERT INTO `tbm_coa` VALUES ('211', '1200.7a', '1200.7.a2', 'B', 'Ak. Penyusutan TM KEBUN SIBORNA BUNUT', '0');
INSERT INTO `tbm_coa` VALUES ('212', '1200.7', '1200.7b', 'B', 'AMORTISASI TANAH', '0');
INSERT INTO `tbm_coa` VALUES ('213', '1200.7b', '1200.7b1', 'B', 'Amortisasi HGU Kebun Aek Siala No. 222', '0');
INSERT INTO `tbm_coa` VALUES ('214', '1200.7b', '1200.7b2', 'B', 'Amortisasi HGU Kebun Aek Siala No. 2', '0');
INSERT INTO `tbm_coa` VALUES ('215', '1200.7b', '1200.7b3', 'B', 'Amortisasi HGU Kebun Aek Siala No. 3', '0');
INSERT INTO `tbm_coa` VALUES ('216', '1200.7b', '1200.7b4', 'B', 'Amortisasi HGU Kebun Aek Siala No. 4', '0');
INSERT INTO `tbm_coa` VALUES ('217', '1200.7', '1200.7c', 'B', 'AKUMULASI PENYUSUTAN BANGUNAN', '0');
INSERT INTO `tbm_coa` VALUES ('218', '1200.7c', '1200.7c1', 'B', 'Ak. Penyusutan Bangunan Kantor & Mes', '0');
INSERT INTO `tbm_coa` VALUES ('219', '1200.7c', '1200.7c2', 'B', 'Ak. Penyusutan Bangunan Kantor Kebun Bunut', '0');
INSERT INTO `tbm_coa` VALUES ('220', '1200.7c', '1200.7c3', 'B', 'Ak. Penyusutan Bangunan Kantor Kebun Aek Siala', '0');
INSERT INTO `tbm_coa` VALUES ('221', '1200.7c', '1200.7c4', 'B', 'Ak. Penyusutan Bangunan Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('222', '1200.7c', '1200.7c5', 'B', 'Ak. Penyusutan Bangunan Kantor Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('223', '1200.7c', '1200.7c6', 'B', 'Ak. Penyusutan Bangunan Pos Satpam PKS', '0');
INSERT INTO `tbm_coa` VALUES ('224', '1200.7c', '1200.7c7', 'B', 'Ak. Penyusutan Bangunan Pos Satpam Kebun Bunut', '0');
INSERT INTO `tbm_coa` VALUES ('225', '1200.7c', '1200.7c8', 'B', 'Ak. Penyusutan Bangunan Pos Satpam Aek Siala', '0');
INSERT INTO `tbm_coa` VALUES ('226', '1200.7c', '1200.7c9', 'B', 'Ak. Penyusutan Bangunan Perumahan Staff', '0');
INSERT INTO `tbm_coa` VALUES ('227', '1200.7c', '1200.7c10', 'B', 'Ak. Penyusutan Bangunan Perumahan Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('228', '1200.7c', '1200.7c11', 'B', 'Ak. Penyusutan Bangunan Rumah Pompa', '0');
INSERT INTO `tbm_coa` VALUES ('229', '1200.7c', '1200.7c12', 'B', 'Ak. Penyusutan Banguna Gudang & Workshop', '0');
INSERT INTO `tbm_coa` VALUES ('230', '1200.7c', '1200.7c13', 'B', 'Ak. Penyusutan Bangunan Kamar Mandi', '0');
INSERT INTO `tbm_coa` VALUES ('231', '1200.7c', '1200.7c14', 'B', 'Ak. Penyusutan Bangunan Mussholla', '0');
INSERT INTO `tbm_coa` VALUES ('232', '1200.7c', '1200.7c15', 'B', 'Ak. Penyusutan Bangunan Timbangan', '0');
INSERT INTO `tbm_coa` VALUES ('233', '1200.7', '1200.7d', 'B', 'AKUMULASI PENYUSUTAN INFRASTRUKTUR', '0');
INSERT INTO `tbm_coa` VALUES ('234', '1200.7d', '1200.7d1', 'B', 'Ak. Penyusutan Jalan PKS', '0');
INSERT INTO `tbm_coa` VALUES ('235', '1200.7d', '1200.7d2', 'B', 'Ak. Penyusutan Main Road & Collection Road Desa Siali - Ali', '0');
INSERT INTO `tbm_coa` VALUES ('236', '1200.7d', '1200.7d3', 'B', 'Ak. Penyusutan Main Road & Collection Road Desa Bunut', '0');
INSERT INTO `tbm_coa` VALUES ('237', '1200.7d', '1200.7d4', 'B', 'Ak. Penyusutan Peralatan Loading Ramp', '0');
INSERT INTO `tbm_coa` VALUES ('238', '1200.7d', '1200.7d5', 'B', 'Ak. Penyusutan Kolam Limbah', '0');
INSERT INTO `tbm_coa` VALUES ('239', '1200.7d', '1200.7d6', 'B', 'Ak. Penyusutan Retaining Wall', '0');
INSERT INTO `tbm_coa` VALUES ('240', '1200.7', '1200.7e', 'B', 'AKUMULASI MESIN DAN PERALATAN', '0');
INSERT INTO `tbm_coa` VALUES ('241', '1200.7e', '1200.7e1', 'B', 'Ak. Penyusutan Fruit Receiping Station', '0');
INSERT INTO `tbm_coa` VALUES ('242', '1200.7e', '1200.7e2', 'B', 'Ak. Penyusutan Stelizer Station', '0');
INSERT INTO `tbm_coa` VALUES ('243', '1200.7e', '1200.7e3', 'B', 'Ak. Penyusutan Theresing Station', '0');
INSERT INTO `tbm_coa` VALUES ('244', '1200.7e', '1200.7e4', 'B', 'Ak. Penyusutan Pres Station', '0');
INSERT INTO `tbm_coa` VALUES ('245', '1200.7e', '1200.7e5', 'B', 'Ak. Penyusutan Clarification Station', '0');
INSERT INTO `tbm_coa` VALUES ('246', '1200.7e', '1200.7e6', 'B', 'Ak. Penyusutan Depericarper Station', '0');
INSERT INTO `tbm_coa` VALUES ('247', '1200.7e', '1200.7e7', 'B', 'Ak. Penyusutan Kernel Recovery Station', '0');
INSERT INTO `tbm_coa` VALUES ('248', '1200.7e', '1200.7e8', 'B', 'Ak. Penyusutan Boiler Station', '0');
INSERT INTO `tbm_coa` VALUES ('249', '1200.7e', '1200.7e9', 'B', 'Ak. Penyusutan Power House Station', '0');
INSERT INTO `tbm_coa` VALUES ('250', '1200.7e', '1200.7e10', 'B', 'Ak. Penyusutan Boiler Feed Water Treatment Plant', '0');
INSERT INTO `tbm_coa` VALUES ('251', '1200.7e', '1200.7e11', 'B', 'Ak. Penyusutan Raw Water Teratment Plant', '0');
INSERT INTO `tbm_coa` VALUES ('252', '1200.7e', '1200.7e12', 'B', 'Ak. Penyusutan Electrical Instalation & Equitmen', '0');
INSERT INTO `tbm_coa` VALUES ('253', '1200.7e', '1200.7e13', 'B', 'Ak. Penyusutan Pipings (Including Valves)', '0');
INSERT INTO `tbm_coa` VALUES ('254', '1200.7e', '1200.7e14', 'B', 'Ak. Penyusutan Effluent Treatment Plant', '0');
INSERT INTO `tbm_coa` VALUES ('255', '1200.7e', '1200.7e15', 'B', 'Ak. Penyusutan Miscellaneous Equitment', '0');
INSERT INTO `tbm_coa` VALUES ('256', '1200.7', '1200.7f', 'B', 'AKUMULASI PENYUSUTAN TRANSPORTASI', '0');
INSERT INTO `tbm_coa` VALUES ('257', '1200.7f', '1200.7f1', 'B', 'Ak. Penyusutan Alat Berat', '0');
INSERT INTO `tbm_coa` VALUES ('258', '1200.7f', '1200.7f2', 'B', 'Ak. Penyusutan Dump Truk', '0');
INSERT INTO `tbm_coa` VALUES ('259', '1200.7f', '1200.7f3', 'B', 'Ak. Penyusutan Mobil', '0');
INSERT INTO `tbm_coa` VALUES ('260', '1200.7f', '1200.7f4', 'B', 'Ak. Penyusutan Sepeda Motor', '0');
INSERT INTO `tbm_coa` VALUES ('261', '1200.7f', '1200.7f5', 'B', 'Ak. Penyusutan Transportasi Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('262', '1200.7', '1200.7g', 'B', 'AKUM. PERLENGKAPAN KANTOR, PERABOT DAN LAINNYA', '0');
INSERT INTO `tbm_coa` VALUES ('263', '1200.7g', '1200.7g1', 'B', 'Ak. Penyusutan Perabot', '0');
INSERT INTO `tbm_coa` VALUES ('264', '1200.7g', '1200.7g2', 'B', 'Ak. Penyusutan Perlengkapan Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('265', '1200.7g', '1200.7g3', 'B', 'Ak. Penyusutan Perlengkapan Perumahan', '0');
INSERT INTO `tbm_coa` VALUES ('266', '0', '2000', 'C', 'AKUN HUTANG', '0');
INSERT INTO `tbm_coa` VALUES ('267', '2000', '2100', 'C', 'HUTANG LANCAR', '0');
INSERT INTO `tbm_coa` VALUES ('268', '2100', '2100.1', 'C', 'HUTANG USAHA', '0');
INSERT INTO `tbm_coa` VALUES ('269', '2100.1', '2100.1.1', 'C', 'Hutang Usaha PT. PETRO ANDHARA ARTHA', '0');
INSERT INTO `tbm_coa` VALUES ('270', '2100.1', '2100.1.2', 'C', 'Hutang Usaha PT. LARIS Sumut Makmur', '0');
INSERT INTO `tbm_coa` VALUES ('271', '2100.1', '2100.1.3', 'C', 'Hutang Usaha PT. ANUGRAH PRIMA SEJATI', '0');
INSERT INTO `tbm_coa` VALUES ('272', '2100.1', '2100.1.4', 'C', 'Hutang Usaha CV. PANCA JAYA', '0');
INSERT INTO `tbm_coa` VALUES ('273', '2100.1', '2100.1.5', 'C', 'Hutang Usaha CV. NOVITA KARYA', '0');
INSERT INTO `tbm_coa` VALUES ('274', '2100.1', '2100.1.6', 'C', 'Hutang Usaha PT. ANGKASA TEHNIK MANDIRI', '0');
INSERT INTO `tbm_coa` VALUES ('275', '2100.1', '2100.1.7', 'C', 'Hutang Usaha CV. KARYA PERKASA', '0');
INSERT INTO `tbm_coa` VALUES ('276', '2100.1', '2100.1.8', 'C', 'Hutang Usaha UD. ANDI', '0');
INSERT INTO `tbm_coa` VALUES ('277', '2100.1', '2100.1.8.a', 'C', 'Hutang Usaha PENGANGKUTAN ANDI', '0');
INSERT INTO `tbm_coa` VALUES ('278', '2100.1', '2100.1.9', 'C', 'Hutang Usaha UD. HMS', '0');
INSERT INTO `tbm_coa` VALUES ('279', '2100.1', '2100.1.10', 'C', 'Hutang Usaha PT. PERSADA PALEMBANG RAYA', '0');
INSERT INTO `tbm_coa` VALUES ('280', '2100.1', '2100.1.11', 'C', 'Hutang Usaha UD. INDRA RARO OLO', '0');
INSERT INTO `tbm_coa` VALUES ('281', '2100.1', '2100.1.12', 'C', 'Hutang Usaha UD. RARO OLO', '0');
INSERT INTO `tbm_coa` VALUES ('282', '2100.1', '2100.1.12.a', 'C', 'Hutang Usaha CV. RARO OLO', '0');
INSERT INTO `tbm_coa` VALUES ('283', '2100.1', '2100.1.12.b', 'C', 'Hutang Usaha TBS CV. RARO OLO', '0');
INSERT INTO `tbm_coa` VALUES ('284', '2100.1', '2100.1.13', 'C', 'Hutang Usaha CV. MULTI ENGINEERING', '0');
INSERT INTO `tbm_coa` VALUES ('285', '2100.1', '2100.1.14', 'C', 'Hutang Usaha UD. AGA MEBEL', '0');
INSERT INTO `tbm_coa` VALUES ('286', '2100.1', '2100.1.15', 'C', 'Hutang Usaha Lain - lain', '0');
INSERT INTO `tbm_coa` VALUES ('287', '2100.1', '2100.1.16', 'C', 'Hutang Usaha Saudara Fhoto', '0');
INSERT INTO `tbm_coa` VALUES ('288', '2100.1', '2100.1.17', 'C', 'Hutang Usaha UD. Palas Jaya Tehnik', '0');
INSERT INTO `tbm_coa` VALUES ('289', '2100.1', '2100.1.18', 'C', 'Hutang Usaha PT. Trakindo Utama', '0');
INSERT INTO `tbm_coa` VALUES ('290', '2100.1', '2100.1.19', 'C', 'Hutang Usaha SPBU', '0');
INSERT INTO `tbm_coa` VALUES ('291', '2100.1', '2100.1.20', 'C', 'Hutang Usaha CV. Okta Karya Engineering', '0');
INSERT INTO `tbm_coa` VALUES ('292', '2100.1', '2100.1.21', 'C', 'Hutang Usaha Spssi', '0');
INSERT INTO `tbm_coa` VALUES ('293', '2100.1', '2100.1.22', 'C', 'Hutang Usaha PT. ALTRAK 1978', '0');
INSERT INTO `tbm_coa` VALUES ('294', '2100.1', '2100.1.23', 'C', 'Hutang Usaha UD. HAFIZAH', '0');
INSERT INTO `tbm_coa` VALUES ('295', '2100.1', '2100.1.24', 'C', 'Hutang Usaha Medan Traktor', '0');
INSERT INTO `tbm_coa` VALUES ('296', '2100.1', '2100.1.25', 'C', 'Hutang Usaha PT. JAYA ABADI SIAGA', '0');
INSERT INTO `tbm_coa` VALUES ('297', '2100.1', '2100.1.26', 'C', 'Hutang Usaha CV. Sinar Jaya', '0');
INSERT INTO `tbm_coa` VALUES ('298', '2100.1', '2100.1.27', 'C', 'Hutang Usaha CV. Mujur Trans', '0');
INSERT INTO `tbm_coa` VALUES ('299', '2100.1', '2100.1.28', 'C', 'Hutang Usaha PT. Wijaya Karya Cipta Mandiri', '0');
INSERT INTO `tbm_coa` VALUES ('300', '2100.1', '2100.1.29', 'C', 'Hutang Usaha PT. BUANA RANTAI BERKAT ABADI', '0');
INSERT INTO `tbm_coa` VALUES ('301', '2100.1', '2100.1.30', 'C', 'Hutang Usaha PT. Traglopindo Utama', '0');
INSERT INTO `tbm_coa` VALUES ('302', '2100.1', '2100.1.31', 'C', 'Hutang Usaha TBS RM.Tria', '0');
INSERT INTO `tbm_coa` VALUES ('303', '2100.1', '2100.1.32', 'C', 'Hutang Usaha TBS Berkah Mandiri', '0');
INSERT INTO `tbm_coa` VALUES ('304', '2100.1', '2100.1.33', 'C', 'Hutang Usaha TBS Rifaldi Anggina', '0');
INSERT INTO `tbm_coa` VALUES ('305', '2100.1', '2100.1.34', 'C', 'Hutang Usaha PT. KARYA SOLUSINDO ANDALAN', '0');
INSERT INTO `tbm_coa` VALUES ('306', '2100.1', '2100.1.35', 'C', 'Hutang Usaha TBS Mitra Pribadi', '0');
INSERT INTO `tbm_coa` VALUES ('307', '2100.1', '2100.1.36', 'C', 'Hutang Usaha TBS Andry E Sosa', '0');
INSERT INTO `tbm_coa` VALUES ('308', '2100.1', '2100.1.37', 'C', 'Hutang Usaha TBS Tongku Hasibuan', '0');
INSERT INTO `tbm_coa` VALUES ('309', '2100.1', '2100.1.38', 'C', 'Hutang Usaha TBS Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('310', '2100.1', '2100.1.39', 'C', 'Hutang Usaha CV. Mandiri Jaya Perkasa', '0');
INSERT INTO `tbm_coa` VALUES ('311', '2100.1', '2100.1.40', 'C', 'Hutang Usaha TBS Zio', '0');
INSERT INTO `tbm_coa` VALUES ('312', '2100.1', '2100.1.41', 'C', 'Hutang Usaha TBS Mandurana', '0');
INSERT INTO `tbm_coa` VALUES ('313', '2100.1', '2100.1.42', 'C', 'Hutang Usaha PT. OMETRACO ARYA SAMANTA', '0');
INSERT INTO `tbm_coa` VALUES ('314', '2100.1', '2100.1.43', 'C', 'Hutang Usaha PT. ANDALAS DINAMIKA', '0');
INSERT INTO `tbm_coa` VALUES ('315', '2100.1', '2100.1.44', 'C', 'Hutang Usaha PT. BUMI ABADI SEJAHTERA', '0');
INSERT INTO `tbm_coa` VALUES ('316', '2100.1', '2100.1.45', 'C', 'Hutang Usaha PHOTO COPY MITRA PRATAMA', '0');
INSERT INTO `tbm_coa` VALUES ('317', '2100.1', '2100.1.46', 'C', 'Hutang Usaha CV. MADANI SEJAHTERA', '0');
INSERT INTO `tbm_coa` VALUES ('318', '2100.1', '2100.1.47', 'C', 'Hutang Usaha PT. VALMATIC INDONESIA', '0');
INSERT INTO `tbm_coa` VALUES ('319', '2100.1', '2100.1.48', 'C', 'Mungkin tani jaya', '0');
INSERT INTO `tbm_coa` VALUES ('320', '2100.1', '2100.1.49', 'C', 'Hutang Usaha CV. SWADAYA ABDI PUTRA', '0');
INSERT INTO `tbm_coa` VALUES ('321', '2100.1', '2100.1.50', 'C', 'Hutang Usaha UD. CAV', '0');
INSERT INTO `tbm_coa` VALUES ('322', '2100.1', '2100.1.51', 'C', 'Hutang Usaha OSK', '0');
INSERT INTO `tbm_coa` VALUES ('323', '2100.1', '2100.1.52', 'C', 'Hutang Usaha TBS Sejahtera Sawit', '0');
INSERT INTO `tbm_coa` VALUES ('324', '2100.1', '2100.1.53', 'C', 'Hutang Usaha TBS ASN', '0');
INSERT INTO `tbm_coa` VALUES ('325', '2100.1', '2100.1.54', 'C', 'Hutang Usaha TBS Mujur Usaha Mandiri', '0');
INSERT INTO `tbm_coa` VALUES ('326', '2100.1', '2100.1.55', 'C', 'Hutang Usaha SHS', '0');
INSERT INTO `tbm_coa` VALUES ('327', '2100.1', '2100.1.56', 'C', 'Hutang Usaha PT. BERKAH BUNDO BERSAMA/RUDIANSYAH', '0');
INSERT INTO `tbm_coa` VALUES ('328', '2100.1', '2100.1.57', 'C', 'Hutang Usaha CV. HAR AGRITECH', '0');
INSERT INTO `tbm_coa` VALUES ('329', '2100.1', '2100.1.58', 'C', 'Hutang Usaha Pak Hery Saputra', '0');
INSERT INTO `tbm_coa` VALUES ('330', '2100.1', '2100.1.59', 'C', 'Hutang Usaha USAHA TEKHNIK MANDIRI (UTM)', '0');
INSERT INTO `tbm_coa` VALUES ('331', '2100.1', '2100.1.60', 'C', 'Hutang Usaha CV. AA TEKNIK', '0');
INSERT INTO `tbm_coa` VALUES ('332', '2100.1', '2100.1.61', 'C', 'Hutang Usaha TBS UD. Rizki', '0');
INSERT INTO `tbm_coa` VALUES ('333', '2100.1', '2100.1.62', 'C', 'Hutang Usaha TBS Pinarik Jaya', '0');
INSERT INTO `tbm_coa` VALUES ('334', '2100.1', '2100.1.63', 'C', 'Hutang Usaha CV. SOSA STAR WEB', '0');
INSERT INTO `tbm_coa` VALUES ('335', '2100', '2100.2', 'C', 'HUTANG BANK JANGKA PENDEK', '0');
INSERT INTO `tbm_coa` VALUES ('336', '2100.2', '2100.2.1', 'C', 'Bank BNI Rek. 375866018', '0');
INSERT INTO `tbm_coa` VALUES ('337', '2100.2', '2100.2.2', 'C', 'Bank BNI Rek. 226369958', '0');
INSERT INTO `tbm_coa` VALUES ('338', '2100.2', '2100.2.3', 'C', 'Bank BNI Rek. 226374527', '0');
INSERT INTO `tbm_coa` VALUES ('339', '2100.2', '2100.2.4', 'C', 'Bank BNI Rek. 226414802', '0');
INSERT INTO `tbm_coa` VALUES ('340', '2100.2', '2100.2.5', 'C', 'Bank BNI Rek. 226416015', '0');
INSERT INTO `tbm_coa` VALUES ('341', '2100.2', '2100.2.6', 'C', 'Bank BNI Rek. 260141524', '0');
INSERT INTO `tbm_coa` VALUES ('342', '2100.2', '2100.2.7', 'C', 'Bank BNI Rek. 298919546', '0');
INSERT INTO `tbm_coa` VALUES ('343', '2100.2', '2100.2.8', 'C', 'Bank BNI Rek. 375275468', '0');
INSERT INTO `tbm_coa` VALUES ('344', '2100', '2100.3', 'C', 'HUTANG AFILIASI', '0');
INSERT INTO `tbm_coa` VALUES ('345', '2100.3', '2100.3.1', 'C', 'Hutang kepada H. Rajamin Hasibuan', '0');
INSERT INTO `tbm_coa` VALUES ('346', '2100.3', '2100.3.2', 'C', 'Hutang kepada Putra Mahkota Hasibuan', '0');
INSERT INTO `tbm_coa` VALUES ('347', '2100', '2100.4', 'C', 'BIAYA MASIH HARUS DIBAYAR', '0');
INSERT INTO `tbm_coa` VALUES ('348', '2100.4', '2100.4.1', 'C', 'Bunga Bank', '0');
INSERT INTO `tbm_coa` VALUES ('349', '2100.4', '2100.4.2', 'C', 'Gaji/Upah, THR Yang Masih Harus Dibayar', '0');
INSERT INTO `tbm_coa` VALUES ('350', '2100.4', '2100.4.3', 'C', 'Bonus', '0');
INSERT INTO `tbm_coa` VALUES ('351', '2100.4', '2100.4.4', 'C', 'Asuransi (BPJS Kesehatan)', '0');
INSERT INTO `tbm_coa` VALUES ('352', '2100.4', '2100.4.5', 'C', 'Profesional Fee', '0');
INSERT INTO `tbm_coa` VALUES ('353', '2100.4', '2100.4.6', 'C', 'Jamsostek (BPJS Ketenagakerjaan)', '0');
INSERT INTO `tbm_coa` VALUES ('354', '2100.4', '2100.4.7', 'C', 'Sewa', '0');
INSERT INTO `tbm_coa` VALUES ('355', '2100.4', '2100.4.8', 'C', 'Pemeliharaan Bangunan', '0');
INSERT INTO `tbm_coa` VALUES ('356', '2100.4', '2100.4.9', 'C', 'Transportasi CPO', '0');
INSERT INTO `tbm_coa` VALUES ('357', '2100.4', '2100.4.10', 'C', 'Transportasi PK', '0');
INSERT INTO `tbm_coa` VALUES ('358', '2100.4', '2100.4.11', 'C', 'Transportasi Lain-lain', '0');
INSERT INTO `tbm_coa` VALUES ('359', '2100', '2100.5', 'C', 'HUTANG PAJAK', '0');
INSERT INTO `tbm_coa` VALUES ('360', '2100.5', '2100.5.1', 'C', 'Hutang Pajak - PPN Keluaran', '0');
INSERT INTO `tbm_coa` VALUES ('361', '2100.5', '2100.5.2', 'C', 'Hutang Pajak - PPh 21', '0');
INSERT INTO `tbm_coa` VALUES ('362', '2100.5', '2100.5.3', 'C', 'Hutang Pajak - PPh 23', '0');
INSERT INTO `tbm_coa` VALUES ('363', '2100.5', '2100.5.4', 'C', 'Hutang Pajak - PPh 25', '0');
INSERT INTO `tbm_coa` VALUES ('364', '2100.5', '2100.5.5', 'C', 'Hutang Pajak - PPh 29', '0');
INSERT INTO `tbm_coa` VALUES ('365', '2100.5', '2100.5.6', 'C', 'Hutang Pajak - PBB', '0');
INSERT INTO `tbm_coa` VALUES ('366', '2100.5', '2100.5.7', 'C', 'Hutang Pajak - PPh 22', '0');
INSERT INTO `tbm_coa` VALUES ('367', '2100.5', '2100.5.8', 'C', 'Hutang Pajak - PPh Final', '0');
INSERT INTO `tbm_coa` VALUES ('368', '2100', '2100.6', 'C', 'UANG MUKA PENJUALAN (Advance on Sales)', '0');
INSERT INTO `tbm_coa` VALUES ('369', '2100.6', '2100.6.1', 'C', 'Uang Muka PT. Sari Dumai Sejati', '0');
INSERT INTO `tbm_coa` VALUES ('370', '2100.6', '2100.6.2', 'C', 'PT. ….', '0');
INSERT INTO `tbm_coa` VALUES ('371', '2000', '2200', 'C', 'HUTANG TIDAK LANCAR', '0');
INSERT INTO `tbm_coa` VALUES ('372', '2200', '2200.1', 'C', 'HUTANG BANK JANGKA PANJANG', '0');
INSERT INTO `tbm_coa` VALUES ('373', '2200.1', '2200.1.1', 'C', 'Hutang Bank Jangka Panjang BNI Rek KMK 375866018', '0');
INSERT INTO `tbm_coa` VALUES ('374', '2200.1', '2200.1.2', 'C', 'Hutang Bank Jangka Panjang BNI Rek KI 226369958', '0');
INSERT INTO `tbm_coa` VALUES ('375', '2200.1', '2200.1.3', 'C', 'Hutang Bank Jangka Panjang BNI Rek KI 226374527', '0');
INSERT INTO `tbm_coa` VALUES ('376', '2200.1', '2200.1.4', 'C', 'Hutang Bank Jangka Panjang BNI Rek KI 226414802', '0');
INSERT INTO `tbm_coa` VALUES ('377', '2200.1', '2200.1.5', 'C', 'Hutang Bank Jangka Panjang BNI Rek KI 226416015', '0');
INSERT INTO `tbm_coa` VALUES ('378', '2200.1', '2200.1.6', 'C', 'Hutang Bank Jangka Panjang BNI Rek KI 260141524', '0');
INSERT INTO `tbm_coa` VALUES ('379', '2200.1', '2200.1.7', 'C', 'Hutang Bank Jangka Panjang BNI Rek KI 298919546', '0');
INSERT INTO `tbm_coa` VALUES ('380', '2200.1', '2200.1.8', 'C', 'Hutang Bank Jangka Panjang BNI Rek KI 375275468', '0');
INSERT INTO `tbm_coa` VALUES ('381', '2200', '2200.2', 'C', 'HUTANG LEASING', '0');
INSERT INTO `tbm_coa` VALUES ('382', '2200.2', '2200.2.1', 'C', 'PT. ….', '0');
INSERT INTO `tbm_coa` VALUES ('383', '2200.2', '2200.2.2', 'C', 'PT. ….', '0');
INSERT INTO `tbm_coa` VALUES ('384', '2200', '2200.3', 'C', 'HUTANG AFILIASI', '0');
INSERT INTO `tbm_coa` VALUES ('385', '2200.3', '2200.3.1', 'C', 'Hutang JK. Panjang Kepada Pemilik', '0');
INSERT INTO `tbm_coa` VALUES ('386', '2200.3', '2200.3.2', 'C', 'PT. ….', '0');
INSERT INTO `tbm_coa` VALUES ('387', '2200', '2200.4', 'C', 'KEWAJIBAN PAJAK TANGGUHAN', '0');
INSERT INTO `tbm_coa` VALUES ('388', '2200.4', '2200.4.1', 'C', 'Kewajiban Pajak Tangguhan', '0');
INSERT INTO `tbm_coa` VALUES ('389', '0', '3000', 'D', 'EKUITAS', '0');
INSERT INTO `tbm_coa` VALUES ('390', '3000', '3100', 'D', 'Modal', '0');
INSERT INTO `tbm_coa` VALUES ('391', '3100', '3100.1', 'D', 'Modal Awal/Saham', '0');
INSERT INTO `tbm_coa` VALUES ('392', '3100', '3100.2', 'D', 'Tambahan Modal Disetor', '0');
INSERT INTO `tbm_coa` VALUES ('393', '3000', '3200', 'D', 'Penarikan - Test', '0');
INSERT INTO `tbm_coa` VALUES ('394', '3000', '3300', 'D', 'Laba/Rugi Ditahan', '0');
INSERT INTO `tbm_coa` VALUES ('395', '3300', '3300.1', 'D', 'Laba/Rugi Ditahan', '0');
INSERT INTO `tbm_coa` VALUES ('396', '3000', '3400', 'D', 'Laba Tahun Sebelumnya', '0');
INSERT INTO `tbm_coa` VALUES ('397', '3400', '3400.1', 'D', 'Laba/Rugi Tahun Sebelumnya', '0');
INSERT INTO `tbm_coa` VALUES ('398', '3000', '3500', 'D', 'Laba/Rugi Tahun Berjalan', '0');
INSERT INTO `tbm_coa` VALUES ('399', '3500', '3500.1', 'D', 'Laba/Rugi Tahun Berjalan', '0');
INSERT INTO `tbm_coa` VALUES ('400', '0', '4000', 'E', 'PENDAPATAN', '0');
INSERT INTO `tbm_coa` VALUES ('401', '4000', '4100', 'E', 'PENDAPATAN PENJUALAN', '0');
INSERT INTO `tbm_coa` VALUES ('402', '4100', '4100.1', 'E', 'Crude Palm Oil (CPO)', '0');
INSERT INTO `tbm_coa` VALUES ('403', '4100.1', '4100.1.1', 'E', 'Lokal', '0');
INSERT INTO `tbm_coa` VALUES ('404', '4100.1', '4100.1.2', 'E', 'Ekspor', '0');
INSERT INTO `tbm_coa` VALUES ('405', '4100', '4100.2', 'E', 'Palm Kernel (PK)', '0');
INSERT INTO `tbm_coa` VALUES ('406', '4100.2', '4100.2.1', 'E', 'Lokal', '0');
INSERT INTO `tbm_coa` VALUES ('407', '4100.2', '4100.2.2', 'E', 'Ekspor', '0');
INSERT INTO `tbm_coa` VALUES ('408', '4100', '4100.3', 'E', 'FFB/TBS', '0');
INSERT INTO `tbm_coa` VALUES ('409', '4100.3', '4100.3.1', 'E', 'Lokal', '0');
INSERT INTO `tbm_coa` VALUES ('410', '4100', '4100.4', 'E', 'Penjualan Lain-lain', '0');
INSERT INTO `tbm_coa` VALUES ('411', '4100.4', '4100.4.1', 'E', 'Cangkang', '0');
INSERT INTO `tbm_coa` VALUES ('412', '4100.4', '4100.4.2', 'E', 'Fibre', '0');
INSERT INTO `tbm_coa` VALUES ('413', '4100.4', '4100.4.3', 'E', 'Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('414', '4100', '4100.5', 'E', 'Pendapatan Lain-lain', '0');
INSERT INTO `tbm_coa` VALUES ('415', '4100.5', '4100.5.1', 'E', 'Pendapatan Lain-lain', '0');
INSERT INTO `tbm_coa` VALUES ('416', '4000', '4200', 'E', 'SALES DISCOUNT', '0');
INSERT INTO `tbm_coa` VALUES ('417', '4200', '4200.1', 'E', 'Lokal', '0');
INSERT INTO `tbm_coa` VALUES ('418', '4200.1', '4200.1.1', 'E', 'CPO', '0');
INSERT INTO `tbm_coa` VALUES ('419', '4200.1', '4200.1.2', 'E', 'PK', '0');
INSERT INTO `tbm_coa` VALUES ('420', '4200', '4200.2', 'E', 'Ekspor', '0');
INSERT INTO `tbm_coa` VALUES ('421', '4200.2', '4200.2.1', 'E', 'CPO', '0');
INSERT INTO `tbm_coa` VALUES ('422', '4200.2', '4200.2.2', 'E', 'PK', '0');
INSERT INTO `tbm_coa` VALUES ('423', '4000', '4300', 'E', 'SALES RETURNED', '0');
INSERT INTO `tbm_coa` VALUES ('424', '4300', '4300.1', 'E', 'Lokal', '0');
INSERT INTO `tbm_coa` VALUES ('425', '4300.1', '4300.1.1', 'E', 'CPO', '0');
INSERT INTO `tbm_coa` VALUES ('426', '4300.1', '4300.1.2', 'E', 'PK', '0');
INSERT INTO `tbm_coa` VALUES ('427', '4300', '4300.2', 'E', 'Ekspor', '0');
INSERT INTO `tbm_coa` VALUES ('428', '4300.2', '4300.2.1', 'E', 'CPO', '0');
INSERT INTO `tbm_coa` VALUES ('429', '4300.2', '4300.2.2', 'E', 'PK', '0');
INSERT INTO `tbm_coa` VALUES ('430', '4000', '4400', 'E', 'IKHTISAR HARGA POKOK PRODUKSI', '0');
INSERT INTO `tbm_coa` VALUES ('431', '4400', '4400.1', 'E', 'Ikhtisar Harga Pokok Produksi CPO', '0');
INSERT INTO `tbm_coa` VALUES ('432', '4400', '4400.2', 'E', 'Ikhtisar Harga Pokok Produksi PK', '0');
INSERT INTO `tbm_coa` VALUES ('433', '4000', '4500', 'E', 'IKHTISAR LABA RUGI', '0');
INSERT INTO `tbm_coa` VALUES ('434', '4500', '4500.1', 'E', 'Ikhtisar Laba Rugi CPO', '0');
INSERT INTO `tbm_coa` VALUES ('435', '4500', '4500.2', 'E', 'Ikhtisar Laba Rugi PK', '0');
INSERT INTO `tbm_coa` VALUES ('436', '0', '5000', 'F', 'HARGA POKOK PRODUKSI/PENJUALAN', '0');
INSERT INTO `tbm_coa` VALUES ('437', '5000', '5100', 'F', 'BAHAN BAKU', '0');
INSERT INTO `tbm_coa` VALUES ('438', '5100', '5100.1', 'F', 'TBS Kebun :', '0');
INSERT INTO `tbm_coa` VALUES ('439', '5100.1', '5100.1.1', 'F', 'Pemeliharaan Jalan', '0');
INSERT INTO `tbm_coa` VALUES ('440', '5100.1.1', '5100.1.1.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('441', '5100.1.1', '5100.1.1.2', 'F', 'Biaya Pemborong', '0');
INSERT INTO `tbm_coa` VALUES ('442', '5100.1.1', '5100.1.1.3', 'F', 'Biaya Material', '0');
INSERT INTO `tbm_coa` VALUES ('443', '5100.1.1', '5100.1.1.4', 'F', 'Biaya Transport', '0');
INSERT INTO `tbm_coa` VALUES ('444', '5100.1.1', '5100.1.1.5', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('445', '5100.1', '5100.1.2', 'F', 'Pemeliharaan Saluran Air', '0');
INSERT INTO `tbm_coa` VALUES ('446', '5100.1.2', '5100.1.2.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('447', '5100.1.2', '5100.1.2.2', 'F', 'Biaya Pemborong', '0');
INSERT INTO `tbm_coa` VALUES ('448', '5100.1.2', '5100.1.2.3', 'F', 'Biaya Material', '0');
INSERT INTO `tbm_coa` VALUES ('449', '5100.1.2', '5100.1.2.4', 'F', 'Biaya Transport', '0');
INSERT INTO `tbm_coa` VALUES ('450', '5100.1.2', '5100.1.2.5', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('451', '5100.1', '5100.1.3', 'F', 'Pasar Pikul', '0');
INSERT INTO `tbm_coa` VALUES ('452', '5100.1.3', '5100.1.3.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('453', '5100.1.3', '5100.1.3.2', 'F', 'Biaya Pemborong', '0');
INSERT INTO `tbm_coa` VALUES ('454', '5100.1.3', '5100.1.3.3', 'F', 'Biaya Material', '0');
INSERT INTO `tbm_coa` VALUES ('455', '5100.1.3', '5100.1.3.4', 'F', 'Biaya Transport', '0');
INSERT INTO `tbm_coa` VALUES ('456', '5100.1.3', '5100.1.3.5', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('457', '5100.1', '5100.1.4', 'F', 'Penyisipan', '0');
INSERT INTO `tbm_coa` VALUES ('458', '5100.1.4', '5100.1.4.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('459', '5100.1.4', '5100.1.4.2', 'F', 'Biaya Pemborong', '0');
INSERT INTO `tbm_coa` VALUES ('460', '5100.1.4', '5100.1.4.3', 'F', 'Biaya Material', '0');
INSERT INTO `tbm_coa` VALUES ('461', '5100.1.4', '5100.1.4.4', 'F', 'Biaya Transport', '0');
INSERT INTO `tbm_coa` VALUES ('462', '5100.1.4', '5100.1.4.5', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('463', '5100.1', '5100.1.5', 'F', 'Piringan', '0');
INSERT INTO `tbm_coa` VALUES ('464', '5100.1.5', '5100.1.5.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('465', '5100.1.5', '5100.1.5.2', 'F', 'Biaya Pemborong', '0');
INSERT INTO `tbm_coa` VALUES ('466', '5100.1.5', '5100.1.5.3', 'F', 'Biaya Material', '0');
INSERT INTO `tbm_coa` VALUES ('467', '5100.1.5', '5100.1.5.4', 'F', 'Biaya Transport', '0');
INSERT INTO `tbm_coa` VALUES ('468', '5100.1.5', '5100.1.5.5', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('469', '5100.1', '5100.1.6', 'F', 'Babatan', '0');
INSERT INTO `tbm_coa` VALUES ('470', '5100.1.6', '5100.1.6.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('471', '5100.1.6', '5100.1.6.2', 'F', 'Biaya Pemborong', '0');
INSERT INTO `tbm_coa` VALUES ('472', '5100.1.6', '5100.1.6.3', 'F', 'Biaya Material', '0');
INSERT INTO `tbm_coa` VALUES ('473', '5100.1.6', '5100.1.6.4', 'F', 'Biaya Transport', '0');
INSERT INTO `tbm_coa` VALUES ('474', '5100.1.6', '5100.1.6.5', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('475', '5100.1', '5100.1.7', 'F', 'Dongkel anak kayu', '0');
INSERT INTO `tbm_coa` VALUES ('476', '5100.1.7', '5100.1.7.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('477', '5100.1.7', '5100.1.7.2', 'F', 'Biaya Pemborong', '0');
INSERT INTO `tbm_coa` VALUES ('478', '5100.1.7', '5100.1.7.3', 'F', 'Biaya Material', '0');
INSERT INTO `tbm_coa` VALUES ('479', '5100.1.7', '5100.1.7.4', 'F', 'Biaya Transport', '0');
INSERT INTO `tbm_coa` VALUES ('480', '5100.1.7', '5100.1.7.5', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('481', '5100.1', '5100.1.8', 'F', 'Pemberantasan lalang', '0');
INSERT INTO `tbm_coa` VALUES ('482', '5100.1.8', '5100.1.8.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('483', '5100.1.8', '5100.1.8.2', 'F', 'Biaya Pemborong', '0');
INSERT INTO `tbm_coa` VALUES ('484', '5100.1.8', '5100.1.8.3', 'F', 'Biaya Material', '0');
INSERT INTO `tbm_coa` VALUES ('485', '5100.1.8', '5100.1.8.4', 'F', 'Biaya Transport', '0');
INSERT INTO `tbm_coa` VALUES ('486', '5100.1.8', '5100.1.8.5', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('487', '5100.1', '5100.1.9', 'F', 'Pemupukan', '0');
INSERT INTO `tbm_coa` VALUES ('488', '5100.1.9', '5100.1.9.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('489', '5100.1.9', '5100.1.9.2', 'F', 'Biaya Pemborong', '0');
INSERT INTO `tbm_coa` VALUES ('490', '5100.1.9', '5100.1.9.3', 'F', 'Biaya Material', '0');
INSERT INTO `tbm_coa` VALUES ('491', '5100.1.9', '5100.1.9.4', 'F', 'Biaya Transport', '0');
INSERT INTO `tbm_coa` VALUES ('492', '5100.1.9', '5100.1.9.5', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('493', '5100.1.9', '5100.1.9.6', 'F', 'Biaya Pengangkutan Pupuk', '0');
INSERT INTO `tbm_coa` VALUES ('494', '5100.1', '5100.1.10', 'F', 'Pemberantasan hama penyakit', '0');
INSERT INTO `tbm_coa` VALUES ('495', '5100.1.10', '5100.1.10.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('496', '5100.1.10', '5100.1.10.2', 'F', 'Biaya Pemborong', '0');
INSERT INTO `tbm_coa` VALUES ('497', '5100.1.10', '5100.1.10.3', 'F', 'Biaya Material', '0');
INSERT INTO `tbm_coa` VALUES ('498', '5100.1.10', '5100.1.10.4', 'F', 'Biaya Transport', '0');
INSERT INTO `tbm_coa` VALUES ('499', '5100.1.10', '5100.1.10.5', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('500', '5100.1', '5100.1.11', 'F', 'Prunning', '0');
INSERT INTO `tbm_coa` VALUES ('501', '5100.1.11', '5100.1.11.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('502', '5100.1.11', '5100.1.11.2', 'F', 'Biaya Pemborong', '0');
INSERT INTO `tbm_coa` VALUES ('503', '5100.1.11', '5100.1.11.3', 'F', 'Biaya Material', '0');
INSERT INTO `tbm_coa` VALUES ('504', '5100.1.11', '5100.1.11.4', 'F', 'Biaya Transport', '0');
INSERT INTO `tbm_coa` VALUES ('505', '5100.1.11', '5100.1.11.5', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('506', '5100.1', '5100.1.12', 'F', 'Pemeliharaan Tanaman', '0');
INSERT INTO `tbm_coa` VALUES ('507', '5100.1.12', '5100.1.12.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('508', '5100.1.12', '5100.1.12.2', 'F', 'Biaya Pemborong', '0');
INSERT INTO `tbm_coa` VALUES ('509', '5100.1.12', '5100.1.12.3', 'F', 'Biaya Material', '0');
INSERT INTO `tbm_coa` VALUES ('510', '5100.1.12', '5100.1.12.4', 'F', 'Biaya Transport', '0');
INSERT INTO `tbm_coa` VALUES ('511', '5100.1.12', '5100.1.12.5', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('512', '5100.1', '5100.1.13', 'F', 'Penyemprotan', '0');
INSERT INTO `tbm_coa` VALUES ('513', '5100.1.13', '5100.1.13.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('514', '5100.1.13', '5100.1.13.2', 'F', 'Biaya Pemborong', '0');
INSERT INTO `tbm_coa` VALUES ('515', '5100.1.13', '5100.1.13.3', 'F', 'Biaya Material', '0');
INSERT INTO `tbm_coa` VALUES ('516', '5100.1.13', '5100.1.13.4', 'F', 'Biaya Transport', '0');
INSERT INTO `tbm_coa` VALUES ('517', '5100.1.13', '5100.1.13.5', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('518', '5100.1', '5100.1.14', 'F', 'Biaya Panen', '0');
INSERT INTO `tbm_coa` VALUES ('519', '5100.1.14', '5100.1.14.1', 'F', 'Tree Sensus', '0');
INSERT INTO `tbm_coa` VALUES ('520', '5100.1.14', '5100.1.14.2', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('521', '5100.1.14', '5100.1.14.3', 'F', 'Biaya Pemborong', '0');
INSERT INTO `tbm_coa` VALUES ('522', '5100.1.14', '5100.1.14.4', 'F', 'Biaya Transport', '0');
INSERT INTO `tbm_coa` VALUES ('523', '5100.1.14', '5100.1.14.5', 'F', 'Biaya Material', '0');
INSERT INTO `tbm_coa` VALUES ('524', '5100.1.14', '5100.1.14.6', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('525', '5100.1', '5100.1.15', 'F', 'Biaya Administrasi Umum Kebun', '0');
INSERT INTO `tbm_coa` VALUES ('526', '5100.1.15', '5100.1.15.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('527', '5100.1.15', '5100.1.15.2', 'F', 'Transport dalam kebun', '0');
INSERT INTO `tbm_coa` VALUES ('528', '5100.1.15', '5100.1.15.3', 'F', 'Penyusutan Tanaman Menghasilkan', '0');
INSERT INTO `tbm_coa` VALUES ('529', '5100.1.15', '5100.1.15.4', 'F', 'PBB', '0');
INSERT INTO `tbm_coa` VALUES ('530', '5100.1.15', '5100.1.15.5', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('531', '5100.1.15', '5100.1.15.6', 'F', 'Penyusutan Bangunan Permanen', '0');
INSERT INTO `tbm_coa` VALUES ('532', '5100.1.15', '5100.1.15.7', 'F', 'Penyusutan Bangunan Semi Permanen', '0');
INSERT INTO `tbm_coa` VALUES ('533', '5100.1.15', '5100.1.15.8', 'F', 'Penyusutan Sarana dan Prasarana Kebun', '0');
INSERT INTO `tbm_coa` VALUES ('534', '5100.1.15', '5100.1.15.9', 'F', 'Amortisasi HGU', '0');
INSERT INTO `tbm_coa` VALUES ('535', '5100.1', '5100.1.16', 'F', 'Biaya Transport Ke PKS', '0');
INSERT INTO `tbm_coa` VALUES ('536', '5100.1.16', '5100.1.16.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('537', '5100.1.16', '5100.1.16.2', 'F', 'Biaya BBM,Oli dan Pelumas lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('538', '5100.1.16', '5100.1.16.3', 'F', 'Sparepart Kendaraan', '0');
INSERT INTO `tbm_coa` VALUES ('539', '5100.1.16', '5100.1.16.4', 'F', 'Sewa Kendaraan', '0');
INSERT INTO `tbm_coa` VALUES ('540', '5100.1', '5100.1.17', 'F', 'Biaya Bibitan', '0');
INSERT INTO `tbm_coa` VALUES ('541', '5100.1.17', '5100.1.17.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('542', '5100.1.17', '5100.1.17.2', 'F', 'Biaya Pemborong', '0');
INSERT INTO `tbm_coa` VALUES ('543', '5100.1.17', '5100.1.17.3', 'F', 'Biaya Material', '0');
INSERT INTO `tbm_coa` VALUES ('544', '5100.1.17', '5100.1.17.4', 'F', 'Biaya Transport', '0');
INSERT INTO `tbm_coa` VALUES ('545', '5100.1.17', '5100.1.17.5', 'F', 'Biaya Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('546', '5100', '5100.1a', 'F', 'Alokasi Biaya TBS Kebun', '0');
INSERT INTO `tbm_coa` VALUES ('547', '5100', '5100.2', 'F', 'Pembelian TBS Luar', '0');
INSERT INTO `tbm_coa` VALUES ('548', '5100.2', '5100.2.1', 'F', 'Ongkos angkut TBS', '0');
INSERT INTO `tbm_coa` VALUES ('549', '5100.2', '5100.2.2', 'F', 'Pembelian TBS Luar/Agen', '0');
INSERT INTO `tbm_coa` VALUES ('550', '5100.2', '5100.2.3', 'F', 'Biaya TBS Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('551', '5100', '5100.2a', 'F', 'Biaya Angkut Pembelian', '0');
INSERT INTO `tbm_coa` VALUES ('552', '5100.2a', '5100.2a.1', 'F', 'Biaya Angkut Pembelian', '0');
INSERT INTO `tbm_coa` VALUES ('553', '5100', '5100.2b', 'F', 'Return Pembelian', '0');
INSERT INTO `tbm_coa` VALUES ('554', '5100.2b', '5100.2b.1', 'F', 'Return Pembelian', '0');
INSERT INTO `tbm_coa` VALUES ('555', '5100', '5100.2c', 'F', 'Purchase Discount', '0');
INSERT INTO `tbm_coa` VALUES ('556', '5100.2c', '5100.2c.1', 'F', 'Purchase Discount', '0');
INSERT INTO `tbm_coa` VALUES ('557', '5000', '5200', 'F', 'BIAYA PENGOLAHAN', '0');
INSERT INTO `tbm_coa` VALUES ('558', '5200', '5200.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('559', '5200.1', '5200.1.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('560', '5200.1', '5200.1.2', 'F', 'Biaya Lembur', '0');
INSERT INTO `tbm_coa` VALUES ('561', '5200.1', '5200.1.3', 'F', 'Biaya THR/Bonus', '0');
INSERT INTO `tbm_coa` VALUES ('562', '5200.1', '5200.1.4', 'F', 'Biaya Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('563', '5200.1', '5200.1.5', 'F', 'Biaya Perobatan', '0');
INSERT INTO `tbm_coa` VALUES ('564', '5200.1', '5200.1.6', 'F', 'Natura/Beras', '0');
INSERT INTO `tbm_coa` VALUES ('565', '5200.1', '5200.1.7', 'F', 'Biaya Pesangon Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('566', '5200', '5200.2', 'F', 'Biaya Consumable', '0');
INSERT INTO `tbm_coa` VALUES ('567', '5200.2', '5200.2.1', 'F', 'Biaya Umum', '0');
INSERT INTO `tbm_coa` VALUES ('568', '5200.2', '5200.2.2', 'F', 'Bahan Kimia Proses', '0');
INSERT INTO `tbm_coa` VALUES ('569', '5200.2', '5200.2.3', 'F', 'Bahan Kimia Boiler', '0');
INSERT INTO `tbm_coa` VALUES ('570', '5200.2', '5200.2.4', 'F', 'Pakaian dan Perlengkapan', '0');
INSERT INTO `tbm_coa` VALUES ('571', '5200.2', '5200.2.5', 'F', 'Consumable Laboratorium', '0');
INSERT INTO `tbm_coa` VALUES ('572', '5200.2', '5200.2.6', 'F', 'Consumable Grading', '0');
INSERT INTO `tbm_coa` VALUES ('573', '5200.2', '5200.2.7', 'F', 'Consumable Timbangan', '0');
INSERT INTO `tbm_coa` VALUES ('574', '5200.2', '5200.2.8', 'F', 'Biaya Consumable Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('575', '5200', '5200.2a', 'F', 'Return Pembelian', '0');
INSERT INTO `tbm_coa` VALUES ('576', '5200.2a', '5200.2a.1', 'F', 'Return Pembelian', '0');
INSERT INTO `tbm_coa` VALUES ('577', '5200', '5200.2b', 'F', 'Purchase Discount', '0');
INSERT INTO `tbm_coa` VALUES ('578', '5200.2b', '5200.2b.1', 'F', 'Purchase Discount', '0');
INSERT INTO `tbm_coa` VALUES ('579', '5200', '5200.3', 'F', 'Biaya Extra Fooding', '0');
INSERT INTO `tbm_coa` VALUES ('580', '5200.3', '5200.3.1', 'F', 'Biaya Extra Fooding Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('581', '5000', '5300', 'F', 'BIAYA DILUAR PROSES (PROCESSING OVERHEAD)', '0');
INSERT INTO `tbm_coa` VALUES ('582', '5300', '5300.1', 'F', 'Biaya Peralatan Kerja', '0');
INSERT INTO `tbm_coa` VALUES ('583', '5300.1', '5300.1.1', 'F', 'Biaya Peralatan Kerja Laboratorium', '0');
INSERT INTO `tbm_coa` VALUES ('584', '5300.1', '5300.1.2', 'F', 'Biaya Peralatan Kerja Grading', '0');
INSERT INTO `tbm_coa` VALUES ('585', '5300.1', '5300.1.3', 'F', 'Biaya Peralatan Kerja Umum', '0');
INSERT INTO `tbm_coa` VALUES ('586', '5300', '5300.2', 'F', 'Biaya Instalasi Listrik Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('587', '5300.2', '5300.2.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('588', '5300.2', '5300.2.2', 'F', 'Biaya Lembur', '0');
INSERT INTO `tbm_coa` VALUES ('589', '5300.2', '5300.2.3', 'F', 'Biaya THR/Bonus', '0');
INSERT INTO `tbm_coa` VALUES ('590', '5300.2', '5300.2.4', 'F', 'Biaya Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('591', '5300.2', '5300.2.5', 'F', 'Biaya Perobatan', '0');
INSERT INTO `tbm_coa` VALUES ('592', '5300.2', '5300.2.6', 'F', 'Natura/Beras', '0');
INSERT INTO `tbm_coa` VALUES ('593', '5300.2', '5300.2.7', 'F', 'Biaya Pesangon Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('594', '5300.2', '5300.2.8', 'F', 'Biaya Perawatan instalasi listrik Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('595', '5300.2', '5300.2.9', 'F', 'Biaya lain-lain instalasi pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('596', '5300', '5300.3', 'F', 'Biaya Instalasi Air', '0');
INSERT INTO `tbm_coa` VALUES ('597', '5300.3', '5300.3.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('598', '5300.3', '5300.3.2', 'F', 'Biaya THR/Bonus', '0');
INSERT INTO `tbm_coa` VALUES ('599', '5300.3', '5300.3.3', 'F', 'Biaya Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('600', '5300.3', '5300.3.4', 'F', 'Biaya Pengobatan', '0');
INSERT INTO `tbm_coa` VALUES ('601', '5300.3', '5300.3.5', 'F', 'Natura/Beras', '0');
INSERT INTO `tbm_coa` VALUES ('602', '5300.3', '5300.3.6', 'F', 'Biaya Pesangon Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('603', '5300.3', '5300.3.7', 'F', 'Material Instalasi air', '0');
INSERT INTO `tbm_coa` VALUES ('604', '5300.3', '5300.3.8', 'F', 'Biaya Perawatan Instalasi Air', '0');
INSERT INTO `tbm_coa` VALUES ('605', '5300.3', '5300.3.9', 'F', 'Biaya Lain-lain Instalasi Air', '0');
INSERT INTO `tbm_coa` VALUES ('606', '5300', '5300.4', 'F', 'Biaya Bahan Bakar', '0');
INSERT INTO `tbm_coa` VALUES ('607', '5300.4', '5300.4.1', 'F', 'Biaya BBM', '0');
INSERT INTO `tbm_coa` VALUES ('608', '5300.4', '5300.4.2', 'F', 'Biaya Oli dan Pelumas lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('609', '5300.4', '5300.4.3', 'F', 'Biaya Bahan Bakar Lainnya', '0');
INSERT INTO `tbm_coa` VALUES ('610', '5300', '5300.5', 'F', 'Biaya Laboratorium', '0');
INSERT INTO `tbm_coa` VALUES ('611', '5300.5', '5300.5.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('612', '5300.5', '5300.5.2', 'F', 'Biaya Lembur', '0');
INSERT INTO `tbm_coa` VALUES ('613', '5300.5', '5300.5.3', 'F', 'Biaya THR/Bonus', '0');
INSERT INTO `tbm_coa` VALUES ('614', '5300.5', '5300.5.4', 'F', 'Biaya Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('615', '5300.5', '5300.5.5', 'F', 'Biaya Perobatan', '0');
INSERT INTO `tbm_coa` VALUES ('616', '5300.5', '5300.5.6', 'F', 'Natura/Beras', '0');
INSERT INTO `tbm_coa` VALUES ('617', '5300.5', '5300.5.7', 'F', 'Biaya Pesangon Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('618', '5300', '5300.6', 'F', 'Sortasi', '0');
INSERT INTO `tbm_coa` VALUES ('619', '5300.6', '5300.6.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('620', '5300.6', '5300.6.2', 'F', 'Biaya Lembur', '0');
INSERT INTO `tbm_coa` VALUES ('621', '5300.6', '5300.6.3', 'F', 'Biaya THR/Bonus', '0');
INSERT INTO `tbm_coa` VALUES ('622', '5300.6', '5300.6.4', 'F', 'Biaya Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('623', '5300.6', '5300.6.5', 'F', 'Biaya Perobatan', '0');
INSERT INTO `tbm_coa` VALUES ('624', '5300.6', '5300.6.6', 'F', 'Natura/Beras', '0');
INSERT INTO `tbm_coa` VALUES ('625', '5300.6', '5300.6.7', 'F', 'Biaya Pesangon Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('626', '5300', '5300.7', 'F', 'Biaya Maintenance/Workshop', '0');
INSERT INTO `tbm_coa` VALUES ('627', '5300.7', '5300.7.1', 'F', 'Biaya Material dan Bahan Konstruksi', '0');
INSERT INTO `tbm_coa` VALUES ('628', '5300.7', '5300.7.2', 'F', 'Biaya Sparepart Internal', '0');
INSERT INTO `tbm_coa` VALUES ('629', '5300.7', '5300.7.3', 'F', 'Biaya Sparepart Eksternal', '0');
INSERT INTO `tbm_coa` VALUES ('630', '5300.7', '5300.7.4', 'F', 'External Service', '0');
INSERT INTO `tbm_coa` VALUES ('631', '5300.7', '5300.7.5', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('632', '5300.7', '5300.7.6', 'F', 'Biaya Lembur', '0');
INSERT INTO `tbm_coa` VALUES ('633', '5300.7', '5300.7.7', 'F', 'Biaya THR/Bonus', '0');
INSERT INTO `tbm_coa` VALUES ('634', '5300.7', '5300.7.8', 'F', 'Biaya Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('635', '5300.7', '5300.7.9', 'F', 'Biaya Perobatan', '0');
INSERT INTO `tbm_coa` VALUES ('636', '5300.7', '5300.7.10', 'F', 'Natura/Beras', '0');
INSERT INTO `tbm_coa` VALUES ('637', '5300.7', '5300.7.11', 'F', 'Biaya Pesangon Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('638', '5300.7', '5300.7.12', 'F', 'Maintenance peralatan workshop', '0');
INSERT INTO `tbm_coa` VALUES ('639', '5300.7', '5300.7.13', 'F', 'Pakaian dan Perlengkapan safety', '0');
INSERT INTO `tbm_coa` VALUES ('640', '5300', '5300.8', 'F', 'Biaya Transport Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('641', '5300.8', '5300.8.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('642', '5300.8', '5300.8.2', 'F', 'Biaya Lembur', '0');
INSERT INTO `tbm_coa` VALUES ('643', '5300.8', '5300.8.3', 'F', 'Biaya THR/Bonus', '0');
INSERT INTO `tbm_coa` VALUES ('644', '5300.8', '5300.8.4', 'F', 'Biaya Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('645', '5300.8', '5300.8.5', 'F', 'Biaya Perobatan', '0');
INSERT INTO `tbm_coa` VALUES ('646', '5300.8', '5300.8.6', 'F', 'Natura/Beras', '0');
INSERT INTO `tbm_coa` VALUES ('647', '5300.8', '5300.8.7', 'F', 'Biaya Pesangon Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('648', '5000', '5400', 'F', 'Biaya Administrasi & Umum Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('649', '5400', '5400.1', 'F', 'Biaya Gaji Kantor Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('650', '5400.1', '5400.1.1', 'F', 'Biaya Gaji/Upah Kantor Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('651', '5400.1', '5400.1.2', 'F', 'Biaya Lembur dan Tunjangan', '0');
INSERT INTO `tbm_coa` VALUES ('652', '5400.1', '5400.1.3', 'F', 'Biaya Extra Fooding', '0');
INSERT INTO `tbm_coa` VALUES ('653', '5400.1', '5400.1.4', 'F', 'Biaya Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('654', '5400.1', '5400.1.5', 'F', 'Biaya Perobatan', '0');
INSERT INTO `tbm_coa` VALUES ('655', '5400.1', '5400.1.6', 'F', 'Natura/Beras', '0');
INSERT INTO `tbm_coa` VALUES ('656', '5400.1', '5400.1.7', 'F', 'Biaya Pesangon Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('657', '5400', '5400.2', 'F', 'Biaya Keamanan', '0');
INSERT INTO `tbm_coa` VALUES ('658', '5400.2', '5400.2.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('659', '5400.2', '5400.2.2', 'F', 'Biaya Lembur', '0');
INSERT INTO `tbm_coa` VALUES ('660', '5400.2', '5400.2.3', 'F', 'Biaya THR/Bonus', '0');
INSERT INTO `tbm_coa` VALUES ('661', '5400.2', '5400.2.4', 'F', 'Biaya Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('662', '5400.2', '5400.2.5', 'F', 'Biaya Pengobatan', '0');
INSERT INTO `tbm_coa` VALUES ('663', '5400.2', '5400.2.6', 'F', 'Natura/Beras', '0');
INSERT INTO `tbm_coa` VALUES ('664', '5400.2', '5400.2.7', 'F', 'Biaya Pesangon Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('665', '5400.2', '5400.2.8', 'F', 'Biaya Extra Fooding', '0');
INSERT INTO `tbm_coa` VALUES ('666', '5400.2', '5400.2.9', 'F', 'Biaya Seragam Keamanan', '0');
INSERT INTO `tbm_coa` VALUES ('667', '5400.2', '5400.2.10', 'F', 'Biaya Lain Keamanan', '0');
INSERT INTO `tbm_coa` VALUES ('668', '5400', '5400.3', 'F', 'Timbangan', '0');
INSERT INTO `tbm_coa` VALUES ('669', '5400.3', '5400.3.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('670', '5400.3', '5400.3.2', 'F', 'Biaya Lembur', '0');
INSERT INTO `tbm_coa` VALUES ('671', '5400.3', '5400.3.3', 'F', 'Biaya THR/Bonus', '0');
INSERT INTO `tbm_coa` VALUES ('672', '5400.3', '5400.3.4', 'F', 'Biaya Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('673', '5400.3', '5400.3.5', 'F', 'Biaya Pengobatan', '0');
INSERT INTO `tbm_coa` VALUES ('674', '5400.3', '5400.3.6', 'F', 'Natura/Beras', '0');
INSERT INTO `tbm_coa` VALUES ('675', '5400.3', '5400.3.7', 'F', 'Biaya Pesangon Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('676', '5400.3', '5400.3.8', 'F', 'Biaya Extra Fooding', '0');
INSERT INTO `tbm_coa` VALUES ('677', '5400.3', '5400.3.9', 'F', 'Biaya Lain-lain', '0');
INSERT INTO `tbm_coa` VALUES ('678', '5400', '5400.4', 'F', 'Gudang Central', '0');
INSERT INTO `tbm_coa` VALUES ('679', '5400.4', '5400.4.1', 'F', 'Biaya Gaji/Upah', '0');
INSERT INTO `tbm_coa` VALUES ('680', '5400.4', '5400.4.2', 'F', 'Biaya Lembur', '0');
INSERT INTO `tbm_coa` VALUES ('681', '5400.4', '5400.4.3', 'F', 'Biaya THR/Bonus', '0');
INSERT INTO `tbm_coa` VALUES ('682', '5400.4', '5400.4.4', 'F', 'Biaya Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('683', '5400.4', '5400.4.5', 'F', 'Biaya Pengobatan', '0');
INSERT INTO `tbm_coa` VALUES ('684', '5400.4', '5400.4.6', 'F', 'Natura/Beras', '0');
INSERT INTO `tbm_coa` VALUES ('685', '5400.4', '5400.4.7', 'F', 'Biaya Pesangon Karyawan', '0');
INSERT INTO `tbm_coa` VALUES ('686', '5400.4', '5400.4.8', 'F', 'Biaya Extra Fooding', '0');
INSERT INTO `tbm_coa` VALUES ('687', '5400.4', '5400.4.9', 'F', 'Biaya Bongkar Muat Gudang', '0');
INSERT INTO `tbm_coa` VALUES ('688', '5400.4', '5400.4.10', 'F', 'Biaya Pengangkutan Barang', '0');
INSERT INTO `tbm_coa` VALUES ('689', '5400.4', '5400.4.11', 'F', 'Biaya Selisih Timbangan Material', '0');
INSERT INTO `tbm_coa` VALUES ('690', '5400.4', '5400.4.12', 'F', 'Biaya Penyesuaian Stock barang Digudang', '0');
INSERT INTO `tbm_coa` VALUES ('691', '5400.4', '5400.4.13', 'F', 'Biaya Lain-lain', '0');
INSERT INTO `tbm_coa` VALUES ('692', '5400', '5400.5', 'F', 'Biaya Umum Kantor Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('693', '5400.5', '5400.5.1', 'F', 'Biaya Alat Tulis Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('694', '5400.5', '5400.5.2', 'F', 'Komputer', '0');
INSERT INTO `tbm_coa` VALUES ('695', '5400.5', '5400.5.3', 'F', 'Furniture/Perabot', '0');
INSERT INTO `tbm_coa` VALUES ('696', '5400', '5400.6', 'F', 'Biaya Penyusutan Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('697', '5400.6', '5400.6.1', 'F', 'Penyusutan Harta Kelompok I', '0');
INSERT INTO `tbm_coa` VALUES ('698', '5400.6', '5400.6.2', 'F', 'Penyusutan Harta Kelompok II', '0');
INSERT INTO `tbm_coa` VALUES ('699', '5400.6', '5400.6.3', 'F', 'Penyusutan Harta Kelompok III', '0');
INSERT INTO `tbm_coa` VALUES ('700', '5400.6', '5400.6.4', 'F', 'Penyusutan Bangunan Permanen', '0');
INSERT INTO `tbm_coa` VALUES ('701', '5400.6', '5400.6.5', 'F', 'Penyusutan Bangunan Semi Permanen', '0');
INSERT INTO `tbm_coa` VALUES ('702', '5400.6', '5400.6.6', 'F', 'Penyusutan Bangunan Tidak Permanen', '0');
INSERT INTO `tbm_coa` VALUES ('703', '5400.6', '5400.6.7', 'F', 'Penyusutan Sarana dan Prasarana', '0');
INSERT INTO `tbm_coa` VALUES ('704', '5400.6', '5400.6.8', 'F', 'Amortisasi HGU', '0');
INSERT INTO `tbm_coa` VALUES ('705', '5400.6', '5400.6.9', 'F', 'Amortisasi HGB', '0');
INSERT INTO `tbm_coa` VALUES ('706', '5000', '5500', 'F', 'Alokasi Biaya', '0');
INSERT INTO `tbm_coa` VALUES ('707', '5500', '5500.1', 'F', 'Biaya Alokasi Vehicle', '0');
INSERT INTO `tbm_coa` VALUES ('708', '5500.1', '5500.1.1', 'F', 'Alokasi Biaya Wheel Loader 1', '0');
INSERT INTO `tbm_coa` VALUES ('709', '5500.1', '5500.1.2', 'F', 'Alokasi Biaya Wheel Loader 2', '0');
INSERT INTO `tbm_coa` VALUES ('710', '5500.1', '5500.1.3', 'F', 'Alokasi Biaya Colt diesel', '0');
INSERT INTO `tbm_coa` VALUES ('711', '5500', '5500.2', 'F', 'Biaya Alokasi Power Supply', '0');
INSERT INTO `tbm_coa` VALUES ('712', '5500.2', '5500.2.1', 'F', 'Alokasi Listrik', '0');
INSERT INTO `tbm_coa` VALUES ('713', '5500.2', '5500.2.2', 'F', 'Alokasi Steam', '0');
INSERT INTO `tbm_coa` VALUES ('714', '5500', '5500.3', 'F', 'Biaya Alokasi Water Supply', '0');
INSERT INTO `tbm_coa` VALUES ('715', '5500.3', '5500.3.1', 'F', 'Alokasi air untuk Processing', '0');
INSERT INTO `tbm_coa` VALUES ('716', '5000', '5600', 'F', 'Alokasi Biaya GA ke COGS PKS', '0');
INSERT INTO `tbm_coa` VALUES ('717', '0', '6000', 'G', 'BIAYA PENJUALAN', '0');
INSERT INTO `tbm_coa` VALUES ('718', '6000', '6100', 'G', 'Biaya Pengangkutan & Pemasaran Lain-TBS', '0');
INSERT INTO `tbm_coa` VALUES ('719', '6100', '6100.1', 'G', 'Biaya Pengangkutan TBS', '0');
INSERT INTO `tbm_coa` VALUES ('720', '6100', '6100.2', 'G', 'Biaya Kawal TBS', '0');
INSERT INTO `tbm_coa` VALUES ('721', '6100', '6100.3', 'G', 'Biaya Muat Return TBS', '0');
INSERT INTO `tbm_coa` VALUES ('722', '6100', '6100.4', 'G', 'Biaya Bongkar TBS', '0');
INSERT INTO `tbm_coa` VALUES ('723', '6100', '6100.5', 'G', 'Biaya lainnya Pengangkutan & Pemasaran TBS', '0');
INSERT INTO `tbm_coa` VALUES ('724', '6000', '6200', 'G', 'Biaya Pengangkutan & Pemasaran CPO/PK', '0');
INSERT INTO `tbm_coa` VALUES ('725', '6200', '6200.1', 'G', 'Biaya Pengangkutan CPO', '0');
INSERT INTO `tbm_coa` VALUES ('726', '6200', '6200.2', 'G', 'Biaya Pengangkutan PK', '0');
INSERT INTO `tbm_coa` VALUES ('727', '6200', '6200.3', 'G', 'Biaya Pengangkutan Cangkang', '0');
INSERT INTO `tbm_coa` VALUES ('728', '6200', '6200.4', 'G', 'Biaya Pengangkutan Abu Janjang', '0');
INSERT INTO `tbm_coa` VALUES ('729', '6200', '6200.5', 'G', 'Biaya Kawal CPO/PK', '0');
INSERT INTO `tbm_coa` VALUES ('730', '6200', '6200.6', 'G', 'Biaya Lain-lain Pengangkutan dan Pemasaran CPO/PK', '0');
INSERT INTO `tbm_coa` VALUES ('731', '0', '7000', 'H', 'BIAYA ADMINISTRASI DAN UMUM', '0');
INSERT INTO `tbm_coa` VALUES ('732', '7000', '7100', 'H', 'Biaya Gaji/Upah dan Tunjangan', '0');
INSERT INTO `tbm_coa` VALUES ('733', '7100', '7100.1', 'H', 'Biaya-biaya Staff', '0');
INSERT INTO `tbm_coa` VALUES ('734', '7100.1', '7100.1.1', 'H', 'Gaji Pegawai Staff', '0');
INSERT INTO `tbm_coa` VALUES ('735', '7100.1', '7100.1.2', 'H', 'THR dan Bonus Staff', '0');
INSERT INTO `tbm_coa` VALUES ('736', '7100.1', '7100.1.3', 'H', 'Tunjangan Perumahan Staff', '0');
INSERT INTO `tbm_coa` VALUES ('737', '7100.1', '7100.1.4', 'H', 'Tunjangan Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('738', '7100.1', '7100.1.5', 'H', 'Tunjangan Pengobatan Staff', '0');
INSERT INTO `tbm_coa` VALUES ('739', '7100.1', '7100.1.6', 'H', 'Natura/Beras Staff', '0');
INSERT INTO `tbm_coa` VALUES ('740', '7100.1', '7100.1.7', 'H', 'Tunjangan PPh 21 Staff', '0');
INSERT INTO `tbm_coa` VALUES ('741', '7100.1', '7100.1.8', 'H', 'Pesangon Staff', '0');
INSERT INTO `tbm_coa` VALUES ('742', '7100.1', '7100.1.9', 'H', 'Pakaian Seragam Staff', '0');
INSERT INTO `tbm_coa` VALUES ('743', '7100.1', '7100.1.10', 'H', 'Tunjangan Komunikasi Staff', '0');
INSERT INTO `tbm_coa` VALUES ('744', '7100.1', '7100.1.11', 'H', 'Tunjangan BBM dan Maintenance Staff', '0');
INSERT INTO `tbm_coa` VALUES ('745', '7100.1', '7100.1.12', 'H', 'Tunjangan lain-lain', '0');
INSERT INTO `tbm_coa` VALUES ('746', '7100', '7100.2', 'H', 'Biaya - Biaya Non Staff', '0');
INSERT INTO `tbm_coa` VALUES ('747', '7100.2', '7100.2.1', 'H', 'Gaji Pegawai Non Staff Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('748', '7100.2', '7100.2.2', 'H', 'Premi Pegawai Non Staff Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('749', '7100.2', '7100.2.3', 'H', 'Lembur Pegawai Non Staff Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('750', '7100.2', '7100.2.4', 'H', 'THR dan Bonus Non Staff Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('751', '7100.2', '7100.2.5', 'H', 'Tunjangan Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('752', '7100.2', '7100.2.6', 'H', 'Tunjangan Pengobatan Non Staff', '0');
INSERT INTO `tbm_coa` VALUES ('753', '7100.2', '7100.2.7', 'H', 'Tunjangan Natura/Beras', '0');
INSERT INTO `tbm_coa` VALUES ('754', '7100.2', '7100.2.8', 'H', 'Pesangon Non Staff', '0');
INSERT INTO `tbm_coa` VALUES ('755', '7100.2', '7100.2.9', 'H', 'Tunjangan PPh 21 Non Staff', '0');
INSERT INTO `tbm_coa` VALUES ('756', '7100.2', '7100.2.10', 'H', 'Tunjangan Perumahan Non Staff', '0');
INSERT INTO `tbm_coa` VALUES ('757', '7100.2', '7100.2.11', 'H', 'Tunjangan Seragam Non Staff', '0');
INSERT INTO `tbm_coa` VALUES ('758', '7100.2', '7100.2.12', 'H', 'Tunjangan Lain-lain Non Staff', '0');
INSERT INTO `tbm_coa` VALUES ('759', '7100', '7100.3', 'H', 'Biaya Kebersihan Kantor dan Mess', '0');
INSERT INTO `tbm_coa` VALUES ('760', '7100.3', '7100.3.1', 'H', 'Gaji Pegawai Non Staff Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('761', '7100.3', '7100.3.2', 'H', 'Premi Pegawai Non Staff Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('762', '7100.3', '7100.3.3', 'H', 'Lembur Pegawai Non Staff Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('763', '7100.3', '7100.3.4', 'H', 'THR dan Bonus Non Staff Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('764', '7100.3', '7100.3.5', 'H', 'Tunjangan Jamsostek', '0');
INSERT INTO `tbm_coa` VALUES ('765', '7100.3', '7100.3.6', 'H', 'Tunjangan Pengobatan Non Staff', '0');
INSERT INTO `tbm_coa` VALUES ('766', '7100.3', '7100.3.7', 'H', 'Tunjangan Natura/Beras', '0');
INSERT INTO `tbm_coa` VALUES ('767', '7100.3', '7100.3.8', 'H', 'Pesangon Non Staff', '0');
INSERT INTO `tbm_coa` VALUES ('768', '7100.3', '7100.3.9', 'H', 'Tunjangan PPh 21 Non Staff', '0');
INSERT INTO `tbm_coa` VALUES ('769', '7100.3', '7100.3.10', 'H', 'Tunjangan Perumahan Non Staff', '0');
INSERT INTO `tbm_coa` VALUES ('770', '7100.3', '7100.3.11', 'H', 'Tunjangan Seragam Non Staff', '0');
INSERT INTO `tbm_coa` VALUES ('771', '7100.3', '7100.3.12', 'H', 'Tunjangan Lain-lain Non Staff', '0');
INSERT INTO `tbm_coa` VALUES ('772', '7000', '7200', 'H', 'Biaya Umum dan Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('773', '7200', '7200.1', 'H', 'Biaya Administrasi', '0');
INSERT INTO `tbm_coa` VALUES ('774', '7200.1', '7200.1.1', 'H', 'Biaya Alat Tulis Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('775', '7200.1', '7200.1.2', 'H', 'Biaya Materai', '0');
INSERT INTO `tbm_coa` VALUES ('776', '7200.1', '7200.1.3', 'H', 'Biaya Pengiriman Surat dan Dokumen', '0');
INSERT INTO `tbm_coa` VALUES ('777', '7200.1', '7200.1.4', 'H', 'Biaya Cetakan dan Formulir', '0');
INSERT INTO `tbm_coa` VALUES ('778', '7200.1', '7200.1.5', 'H', 'Biaya Fotocopy dan Jilid', '0');
INSERT INTO `tbm_coa` VALUES ('779', '7200.1', '7200.1.6', 'H', 'Biaya Langganan Majalah dan Koran', '0');
INSERT INTO `tbm_coa` VALUES ('780', '7200.1', '7200.1.7', 'H', 'Biaya Dokumentasi', '0');
INSERT INTO `tbm_coa` VALUES ('781', '7200.1', '7200.1.8', 'H', 'Biaya Konsumsi Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('782', '7200.1', '7200.1.9', 'H', 'Biaya Komunikasi', '0');
INSERT INTO `tbm_coa` VALUES ('783', '7200.1', '7200.1.10', 'H', 'Biaya Telepon', '0');
INSERT INTO `tbm_coa` VALUES ('784', '7200.1', '7200.1.11', 'H', 'Biaya Jaringan', '0');
INSERT INTO `tbm_coa` VALUES ('785', '7200.1', '7200.1.12', 'H', 'Biaya Operasional dan Perawatan Komputer/Printer', '0');
INSERT INTO `tbm_coa` VALUES ('786', '7200.1', '7200.1.13', 'H', 'Biaya Sewa Kendaraan', '0');
INSERT INTO `tbm_coa` VALUES ('787', '7200.1', '7200.1.14', 'H', 'Biaya Alat Kebersihan', '0');
INSERT INTO `tbm_coa` VALUES ('788', '7200', '7200.2', 'H', 'Biaya Pajak dan Perizinan', '0');
INSERT INTO `tbm_coa` VALUES ('789', '7200.2', '7200.2.1', 'H', 'Biaya Pengurusan Surat Izin', '0');
INSERT INTO `tbm_coa` VALUES ('790', '7200.2', '7200.2.2', 'H', 'Biaya PBB', '0');
INSERT INTO `tbm_coa` VALUES ('791', '7200.2', '7200.2.3', 'H', 'Biaya Pajak dan Lain-lain', '0');
INSERT INTO `tbm_coa` VALUES ('792', '7200', '7200.3', 'H', 'Biaya Listrik dan Air', '0');
INSERT INTO `tbm_coa` VALUES ('793', '7200.3', '7200.3.1', 'H', 'Biaya Listrik', '0');
INSERT INTO `tbm_coa` VALUES ('794', '7200.3', '7200.3.2', 'H', 'Biaya Air', '0');
INSERT INTO `tbm_coa` VALUES ('795', '7200.3', '7200.3.3', 'H', 'Biaya Lain-lain', '0');
INSERT INTO `tbm_coa` VALUES ('796', '7200', '7200.4', 'H', 'Biaya Inventaris', '0');
INSERT INTO `tbm_coa` VALUES ('797', '7200.4', '7200.4.1', 'H', 'Biaya Inventaris dan Perabot Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('798', '7200.4', '7200.4.2', 'H', 'Biaya Inventaris dan Perabot Mess/Perumahan', '0');
INSERT INTO `tbm_coa` VALUES ('799', '7200.4', '7200.4.3', 'H', 'Biaya Inventaris dan Perabot Kantor Kebun', '0');
INSERT INTO `tbm_coa` VALUES ('800', '7200.4', '7200.4.4', 'H', 'Biaya Inventaris dan Perabot Mess Kebun/Perumahan', '0');
INSERT INTO `tbm_coa` VALUES ('801', '7200.4', '7200.4.5', 'H', 'Biaya Inventaris dan Perabot Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('802', '7200.4', '7200.4.6', 'H', 'Biaya Pemeliharaan Inventaris dan Perabot Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('803', '7200.4', '7200.4.7', 'H', 'Biaya Pemeliharaan Inventaris dan Perabot Mess/Perumahaan', '0');
INSERT INTO `tbm_coa` VALUES ('804', '7200.4', '7200.4.8', 'H', 'Biaya Pemeliharaan Inventaris dan Perabot Kantor Kebun', '0');
INSERT INTO `tbm_coa` VALUES ('805', '7200.4', '7200.4.9', 'H', 'Biaya Pemeliharaan Inventaris dan Perabot Mess/Perumahaan Kebun', '0');
INSERT INTO `tbm_coa` VALUES ('806', '7200.4', '7200.4.10', 'H', 'Biaya Pemeliharaan Inventaris dan Perabot Pabrik', '0');
INSERT INTO `tbm_coa` VALUES ('807', '7200', '7200.5', 'H', 'Biaya Pengembangan SDM', '0');
INSERT INTO `tbm_coa` VALUES ('808', '7200.5', '7200.5.1', 'H', 'Biaya Pendidikan dan Pelatihan', '0');
INSERT INTO `tbm_coa` VALUES ('809', '7200.5', '7200.5.2', 'H', 'Biaya Rekrut dan Pengadaan Pegawai', '0');
INSERT INTO `tbm_coa` VALUES ('810', '7200.5', '7200.5.3', 'H', 'Biaya Pindah/Mutasi', '0');
INSERT INTO `tbm_coa` VALUES ('811', '7200.5', '7200.5.4', 'H', 'Biaya Olahraga dan Rekreasi', '0');
INSERT INTO `tbm_coa` VALUES ('812', '7200', '7200.6', 'H', 'Biaya Perjalanan Dinas', '0');
INSERT INTO `tbm_coa` VALUES ('813', '7200.6', '7200.6.1', 'H', 'Biaya Perjalanan Dinas Staff/Karyawan Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('814', '7200.6', '7200.6.2', 'H', 'Biaya Perjalanan Dinas Staff PKS/Karyawan Kebun', '0');
INSERT INTO `tbm_coa` VALUES ('815', '7200.6', '7200.6.3', 'H', 'Biaya Perjalanan Dinas Non Staff/Karyawan Kantor', '0');
INSERT INTO `tbm_coa` VALUES ('816', '7200.6', '7200.6.4', 'H', 'Biaya Perjalanan Dinas Non Staff PKS/Karyawan Kebun', '0');
INSERT INTO `tbm_coa` VALUES ('817', '7200', '7200.7', 'H', 'Biaya Representatif dan Commodity Development (CD)', '0');
INSERT INTO `tbm_coa` VALUES ('818', '7200.7', '7200.7.1', 'H', 'Biaya Sumbangan', '0');
INSERT INTO `tbm_coa` VALUES ('819', '7200.7', '7200.7.2', 'H', 'Biaya Jamuan Tamu', '0');
INSERT INTO `tbm_coa` VALUES ('820', '7200.7', '7200.7.3', 'H', 'Biaya Perayaan dan Upacara', '0');
INSERT INTO `tbm_coa` VALUES ('821', '7200.7', '7200.7.4', 'H', 'Biaya Duka cita', '0');
INSERT INTO `tbm_coa` VALUES ('822', '7200.7', '7200.7.5', 'H', 'Biaya Pengembangan Masyarakat', '0');
INSERT INTO `tbm_coa` VALUES ('823', '7200', '7200.8', 'H', 'Biaya FFB Trading', '0');
INSERT INTO `tbm_coa` VALUES ('824', '7200.8', '7200.8.1', 'H', 'Biaya Komunikasi', '0');
INSERT INTO `tbm_coa` VALUES ('825', '7200.8', '7200.8.2', 'H', 'Biaya Alokasi Kendaraan', '0');
INSERT INTO `tbm_coa` VALUES ('826', '7200.8', '7200.8.3', 'H', 'Biaya Survey', '0');
INSERT INTO `tbm_coa` VALUES ('827', '7200.8', '7200.8.4', 'H', 'Biaya Perjalanan Dinas', '0');
INSERT INTO `tbm_coa` VALUES ('828', '7200', '7200.9', 'H', 'Biaya Penyusutan dan Amortisasi', '0');
INSERT INTO `tbm_coa` VALUES ('829', '7200.9', '7200.9.1', 'H', 'Penyusutan Harta Kelompok I', '0');
INSERT INTO `tbm_coa` VALUES ('830', '7200.9', '7200.9.2', 'H', 'Penyusutan Harta Kelompok II', '0');
INSERT INTO `tbm_coa` VALUES ('831', '7200.9', '7200.9.3', 'H', 'Penyusutan Harta Kelompok III', '0');
INSERT INTO `tbm_coa` VALUES ('832', '7200.9', '7200.9.4', 'H', 'Penyusutan Bangunan Permanen', '0');
INSERT INTO `tbm_coa` VALUES ('833', '7200.9', '7200.9.5', 'H', 'Penyusutan Bangunan Non Permanen', '0');
INSERT INTO `tbm_coa` VALUES ('834', '7200.9', '7200.9.6', 'H', 'Penyusutan Sarana dan Prasarana', '0');
INSERT INTO `tbm_coa` VALUES ('835', '7200', '7200.10', 'H', 'Biaya Administrasi Bank', '0');
INSERT INTO `tbm_coa` VALUES ('836', '7200.10', '7200.10.1', 'H', 'Biaya Buku Cek/Giro', '0');
INSERT INTO `tbm_coa` VALUES ('837', '7200.10', '7200.10.2', 'H', 'Biaya Administrasi Bank', '0');
INSERT INTO `tbm_coa` VALUES ('838', '7200.10', '7200.10.3', 'H', 'Biaya Bunga Bank', '0');
INSERT INTO `tbm_coa` VALUES ('839', '7200', '7200.11', 'H', 'Biaya Asuransi', '0');
INSERT INTO `tbm_coa` VALUES ('840', '7200.11', '7200.11.1', 'H', 'Biaya Asuransi Cash In Transit', '0');
INSERT INTO `tbm_coa` VALUES ('841', '7200.11', '7200.11.2', 'H', 'Biaya Asuransi Cash In Hand', '0');
INSERT INTO `tbm_coa` VALUES ('842', '7200.11', '7200.11.3', 'H', 'Biaya Asuransi All Risk', '0');
INSERT INTO `tbm_coa` VALUES ('843', '7200', '7200.12', 'H', 'Jasa Tenaga Ahli', '0');
INSERT INTO `tbm_coa` VALUES ('844', '7200.12', '7200.12.1', 'H', 'Jasa Actuaria', '0');
INSERT INTO `tbm_coa` VALUES ('845', '7200.12', '7200.12.2', 'H', 'Jasa Accountan Public', '0');
INSERT INTO `tbm_coa` VALUES ('846', '7200.12', '7200.12.3', 'H', 'Jasa Tenaga Ahli Lainya', '0');
INSERT INTO `tbm_coa` VALUES ('847', '7200', '7200.13', 'H', 'Biaya Lain-Lain', '0');
INSERT INTO `tbm_coa` VALUES ('848', '7200.13', '7200.13.1', 'H', 'Biaya Lain-lain', '0');
INSERT INTO `tbm_coa` VALUES ('849', '7200.13', '7200.13.2', 'H', 'Biaya Operasional Direksi', '0');
INSERT INTO `tbm_coa` VALUES ('850', '7200.13', '7200.13.3', 'H', 'Biaya Obat-obatan', '0');
INSERT INTO `tbm_coa` VALUES ('961', '0', '45874958693', null, 'Test Euy', '1');
INSERT INTO `tbm_coa` VALUES ('962', '0', '878978978', null, 'TEST 2', '0');
INSERT INTO `tbm_coa` VALUES ('963', '878978978', '4645645', null, 'ANAK TEST 2', '0');
INSERT INTO `tbm_coa` VALUES ('964', '4645645', '898989767', null, 'ANAKNYA ANAK TEST 2', '0');
INSERT INTO `tbm_coa` VALUES ('965', '0', '12312323423', null, 'NODE 2', '0');
INSERT INTO `tbm_coa` VALUES ('966', '12312323423', '4534534534', null, 'sdgerwefe', '0');

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
  `id_coa` int(11) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_department
-- ----------------------------
INSERT INTO `tbm_department` VALUES ('1', '0', 'Operational', '2', null, '1');
INSERT INTO `tbm_department` VALUES ('2', '0', 'Manager', '1', null, '1');
INSERT INTO `tbm_department` VALUES ('3', '0', 'Assisten', '2', null, '1');
INSERT INTO `tbm_department` VALUES ('4', '0', 'Transport & Alat Berat', '3', null, '1');
INSERT INTO `tbm_department` VALUES ('5', '0', 'Finance', '6', null, '1');
INSERT INTO `tbm_department` VALUES ('6', '5', 'Sub Finance', '6456', null, '1');
INSERT INTO `tbm_department` VALUES ('7', '5', 'Sub FInance 2', '667', null, '1');
INSERT INTO `tbm_department` VALUES ('8', '0', 'Keuangan & Akuntansi', '2', null, '0');
INSERT INTO `tbm_department` VALUES ('9', '8', 'IT Jaringan', '901', null, '1');
INSERT INTO `tbm_department` VALUES ('10', '8', 'IT Software', '902', null, '1');
INSERT INTO `tbm_department` VALUES ('11', '2', '001', '1', null, '1');
INSERT INTO `tbm_department` VALUES ('12', '3', '002', '2', null, '1');
INSERT INTO `tbm_department` VALUES ('13', '4', '003', '3', null, '1');
INSERT INTO `tbm_department` VALUES ('14', '8', '004', '4', null, '1');
INSERT INTO `tbm_department` VALUES ('15', '0', 'Gudang', '3', null, '0');
INSERT INTO `tbm_department` VALUES ('16', '15', 'Pengadaan & Logistik', '1', null, '0');
INSERT INTO `tbm_department` VALUES ('17', '0', 'Keamanan', '4', null, '0');
INSERT INTO `tbm_department` VALUES ('18', '17', 'Dandru Satpam', '1', null, '0');
INSERT INTO `tbm_department` VALUES ('19', '0', 'Kantor PKS', '5', null, '1');
INSERT INTO `tbm_department` VALUES ('20', '19', 'Kr. Produksi', '1', null, '1');
INSERT INTO `tbm_department` VALUES ('21', '0', '', '', null, '1');
INSERT INTO `tbm_department` VALUES ('22', '21', '007', '7', null, '1');
INSERT INTO `tbm_department` VALUES ('23', '0', 'Kantor & Timbangan', '6', null, '0');
INSERT INTO `tbm_department` VALUES ('24', '23', '006', '6', null, '1');
INSERT INTO `tbm_department` VALUES ('25', '0', 'Proses', '7', null, '0');
INSERT INTO `tbm_department` VALUES ('26', '142', ' Mandor Proses', '3', null, '1');
INSERT INTO `tbm_department` VALUES ('27', '0', 'Proses Shift II', '8', null, '1');
INSERT INTO `tbm_department` VALUES ('28', '27', '008', '8', null, '1');
INSERT INTO `tbm_department` VALUES ('29', '0', 'Workshop', '8', null, '0');
INSERT INTO `tbm_department` VALUES ('30', '29', 'Mandor Mekanik', '2', null, '0');
INSERT INTO `tbm_department` VALUES ('31', '0', 'Transport & Alat Berat', '1', null, '0');
INSERT INTO `tbm_department` VALUES ('33', '8', ' Staff Accounting & Budget ', '2', null, '0');
INSERT INTO `tbm_department` VALUES ('34', '0', 'Laboratorium', '9', null, '0');
INSERT INTO `tbm_department` VALUES ('35', '34', 'Analyst', '2', null, '0');
INSERT INTO `tbm_department` VALUES ('38', '0', '', '', null, '1');
INSERT INTO `tbm_department` VALUES ('40', '0', 'Sortase', '10', null, '0');
INSERT INTO `tbm_department` VALUES ('41', '40', 'Pengawas Sortase', '1', null, '0');
INSERT INTO `tbm_department` VALUES ('44', '0', 'BHL Kandir', '12', null, '1');
INSERT INTO `tbm_department` VALUES ('46', '0', 'BHL PKS', '13', null, '1');
INSERT INTO `tbm_department` VALUES ('48', '0', 'Kepala & Pengawas', '14', null, '1');
INSERT INTO `tbm_department` VALUES ('51', '48', 'Kepala', '14', null, '1');
INSERT INTO `tbm_department` VALUES ('52', '0', 'Assisten', '15', null, '1');
INSERT INTO `tbm_department` VALUES ('53', '52', 'Assisten Keuangan & SDM', '1', null, '1');
INSERT INTO `tbm_department` VALUES ('54', '0', 'Manager', '13', null, '1');
INSERT INTO `tbm_department` VALUES ('55', '54', 'Mill Manager', '16', null, '1');
INSERT INTO `tbm_department` VALUES ('56', '0', 'Kebersihan & Taman', '11', null, '0');
INSERT INTO `tbm_department` VALUES ('57', '56', 'Kebersihan & Taman', '1', null, '0');
INSERT INTO `tbm_department` VALUES ('59', '58', 'Kebersihan & Taman', '17', null, '1');
INSERT INTO `tbm_department` VALUES ('61', '60', 'Kebersihan & Taman', '17', null, '1');
INSERT INTO `tbm_department` VALUES ('62', '48', 'Pengawas', '14', null, '1');
INSERT INTO `tbm_department` VALUES ('63', '34', 'Pb. Analyst', '3', null, '0');
INSERT INTO `tbm_department` VALUES ('64', '34', 'Operator Kolam Limbah', '4', null, '0');
INSERT INTO `tbm_department` VALUES ('65', '34', 'Pb. Operator Kolam Limbah', '5', null, '0');
INSERT INTO `tbm_department` VALUES ('66', '34', 'Deskphack', '6', null, '0');
INSERT INTO `tbm_department` VALUES ('67', '29', 'Mandor Listrik', '3', null, '0');
INSERT INTO `tbm_department` VALUES ('68', '29', 'Mekanik', '4', null, '0');
INSERT INTO `tbm_department` VALUES ('69', '29', 'Pb. Mekanik', '5', null, '0');
INSERT INTO `tbm_department` VALUES ('70', '29', 'Mekanik Elektrik', '6', null, '0');
INSERT INTO `tbm_department` VALUES ('71', '29', 'Pb. Mekanik Elektrik', '7', null, '0');
INSERT INTO `tbm_department` VALUES ('72', '52', 'Assisten Proses Shift I', '2', null, '1');
INSERT INTO `tbm_department` VALUES ('73', '52', 'Assisten Proses Shift II', '3', null, '1');
INSERT INTO `tbm_department` VALUES ('74', '31', 'Operator Wel Loader', '1', null, '0');
INSERT INTO `tbm_department` VALUES ('75', '31', 'Pb. Operator Wel Loader', '2', null, '0');
INSERT INTO `tbm_department` VALUES ('76', '8', ' Staff Accounting & Pajak ', '3', null, '0');
INSERT INTO `tbm_department` VALUES ('77', '8', ' Staff Keuangan & Kasir ', '4', null, '0');
INSERT INTO `tbm_department` VALUES ('78', '15', 'Kr. Gudang', '2', null, '0');
INSERT INTO `tbm_department` VALUES ('79', '15', 'Pb. Kr. Gudang', '3', null, '0');
INSERT INTO `tbm_department` VALUES ('80', '17', 'Anggota Satpam', '2', null, '0');
INSERT INTO `tbm_department` VALUES ('81', '23', 'Pengawas Timbangan', '1', null, '1');
INSERT INTO `tbm_department` VALUES ('82', '23', 'Kr. Timbangan', '3', null, '0');
INSERT INTO `tbm_department` VALUES ('83', '23', 'Pb. Kr. Timbangan', '4', null, '0');
INSERT INTO `tbm_department` VALUES ('84', '142', ' Operator Loading Ramp', '4', null, '1');
INSERT INTO `tbm_department` VALUES ('85', '142', 'Pb. Operator Loading Ramp', '5', null, '1');
INSERT INTO `tbm_department` VALUES ('86', '142', 'Operator Rebusan', '6', null, '1');
INSERT INTO `tbm_department` VALUES ('87', '142', 'Pb. Operator Rebusan', '7', null, '1');
INSERT INTO `tbm_department` VALUES ('88', '142', 'Operator Pressan ', '8', null, '1');
INSERT INTO `tbm_department` VALUES ('89', '142', 'Pb. Operator Pressan', '9', null, '1');
INSERT INTO `tbm_department` VALUES ('90', '142', 'Operator Kernel ', '10', null, '1');
INSERT INTO `tbm_department` VALUES ('91', '142', 'Pb. Operator Kernel ', '11', null, '1');
INSERT INTO `tbm_department` VALUES ('92', '142', 'Operator Kamar Mesin ', '12', null, '1');
INSERT INTO `tbm_department` VALUES ('93', '142', 'Pb. Operator Kamar Mesin', '13', null, '1');
INSERT INTO `tbm_department` VALUES ('94', '142', 'Operator Boiler ', '14', null, '1');
INSERT INTO `tbm_department` VALUES ('95', '142', 'Pb. Operator Boiler ', '15', null, '1');
INSERT INTO `tbm_department` VALUES ('96', '142', 'Operator Water Triatman ', '16', null, '1');
INSERT INTO `tbm_department` VALUES ('97', '142', 'Pb.Operator Water Triatman ', '17', null, '1');
INSERT INTO `tbm_department` VALUES ('98', '142', 'Operator Klarifikasi ', '18', null, '1');
INSERT INTO `tbm_department` VALUES ('99', '142', 'Pb. Operator Klarifikasi', '19', null, '1');
INSERT INTO `tbm_department` VALUES ('100', '27', 'Mandor Proses Shift II', '2', null, '1');
INSERT INTO `tbm_department` VALUES ('101', '27', 'Operator Loading Ramp Shift II', '3', null, '1');
INSERT INTO `tbm_department` VALUES ('102', '27', 'Pb. Operator Loading Ramp Shift II', '4', null, '1');
INSERT INTO `tbm_department` VALUES ('103', '27', 'Operator Rebusan Shift II', '5', null, '1');
INSERT INTO `tbm_department` VALUES ('104', '27', 'Pb. Operator Rebusan Shift II', '6', null, '1');
INSERT INTO `tbm_department` VALUES ('105', '27', 'Operator Pressan Shift II', '7', null, '1');
INSERT INTO `tbm_department` VALUES ('106', '27', 'Pb. Operator Pressan Shift II', '8', null, '1');
INSERT INTO `tbm_department` VALUES ('107', '27', 'Operator Kernel Shift II', '9', null, '1');
INSERT INTO `tbm_department` VALUES ('108', '27', 'Pb. Operator Kernel Shift II', '10', null, '1');
INSERT INTO `tbm_department` VALUES ('109', '27', 'Operator Kamar Mesin Shift II', '11', null, '1');
INSERT INTO `tbm_department` VALUES ('110', '27', 'Pb. Operator Kamar Mesin Shift II', '12', null, '1');
INSERT INTO `tbm_department` VALUES ('111', '27', 'Operator Boiler Shift II', '13', null, '1');
INSERT INTO `tbm_department` VALUES ('112', '27', 'Pb. Operator Boiler Shift II', '14', null, '1');
INSERT INTO `tbm_department` VALUES ('113', '27', 'Operator Water Triatman Shift II', '15', null, '1');
INSERT INTO `tbm_department` VALUES ('114', '27', 'Pb. Operator Water Triatman Shift II', '16', null, '1');
INSERT INTO `tbm_department` VALUES ('115', '27', 'OperatorKlarifikasi Shift II', '17', null, '1');
INSERT INTO `tbm_department` VALUES ('116', '27', 'Pb. OperatorKlarifikasi Shift II', '18', null, '1');
INSERT INTO `tbm_department` VALUES ('117', '40', 'Mandor Sortase', '2', null, '0');
INSERT INTO `tbm_department` VALUES ('118', '40', 'Sortase', '3', null, '0');
INSERT INTO `tbm_department` VALUES ('119', '56', 'Cleaning Service Kantor', '2', null, '0');
INSERT INTO `tbm_department` VALUES ('120', '56', 'Cleaning Service Mess', '3', null, '0');
INSERT INTO `tbm_department` VALUES ('121', '23', 'Pengawas Timbangan & Payroll', '1', null, '0');
INSERT INTO `tbm_department` VALUES ('122', '34', 'Kepala Laboratorium', '1', null, '0');
INSERT INTO `tbm_department` VALUES ('123', '29', 'Kepala Bengkel', '1', null, '0');
INSERT INTO `tbm_department` VALUES ('124', '8', 'Assisten Keuangan & SDM', '1', null, '0');
INSERT INTO `tbm_department` VALUES ('125', '142', 'Assisten Proses', '2', null, '1');
INSERT INTO `tbm_department` VALUES ('126', '142', 'Operator Kernel ', '20', null, '1');
INSERT INTO `tbm_department` VALUES ('128', '142', 'Mill Manager', '1', null, '1');
INSERT INTO `tbm_department` VALUES ('129', '23', 'Kr. Produksi', '2', null, '0');
INSERT INTO `tbm_department` VALUES ('143', '151', 'Mill Manager', '1', null, '1');
INSERT INTO `tbm_department` VALUES ('144', '25', 'Assisten Proses', '2', null, '0');
INSERT INTO `tbm_department` VALUES ('145', '25', 'Mandor Proses', '3', null, '0');
INSERT INTO `tbm_department` VALUES ('146', '25', 'Operator Loading Ramp', '4', null, '0');
INSERT INTO `tbm_department` VALUES ('148', '147', 'Assisten Proses', '2', null, '1');
INSERT INTO `tbm_department` VALUES ('149', '147', 'Mandor Proses', '3', null, '1');
INSERT INTO `tbm_department` VALUES ('150', '147', 'Operator Loading Ramp', '4', null, '1');
INSERT INTO `tbm_department` VALUES ('152', '151', 'Assisten Proses', '2', null, '1');
INSERT INTO `tbm_department` VALUES ('153', '151', 'Mandor Proses', '3', null, '1');
INSERT INTO `tbm_department` VALUES ('154', '151', 'Operator Loading Ramp', '4', null, '1');
INSERT INTO `tbm_department` VALUES ('155', '25', 'Pb. Operator Loading Ramp', '5', null, '0');
INSERT INTO `tbm_department` VALUES ('156', '25', 'Operator Rebusan', '6', null, '0');
INSERT INTO `tbm_department` VALUES ('157', '25', 'Pb. Operator Rebusan', '7', null, '0');
INSERT INTO `tbm_department` VALUES ('158', '25', 'Operator Pressan ', '8', null, '0');
INSERT INTO `tbm_department` VALUES ('159', '25', 'Pb. Operator Pressan', '9', null, '0');
INSERT INTO `tbm_department` VALUES ('160', '25', 'Operator Kernel', '10', null, '0');
INSERT INTO `tbm_department` VALUES ('161', '25', 'Pb. Operator Kernel', '11', null, '0');
INSERT INTO `tbm_department` VALUES ('162', '25', 'Operator Kamar Mesin ', '12', null, '0');
INSERT INTO `tbm_department` VALUES ('163', '25', 'Pb. Operator Kamar Mesin', '13', null, '0');
INSERT INTO `tbm_department` VALUES ('164', '25', 'Operator Boiler', '14', null, '0');
INSERT INTO `tbm_department` VALUES ('165', '25', 'Pb. Operator Boiler ', '15', null, '0');
INSERT INTO `tbm_department` VALUES ('166', '25', 'Operator Water Triatman ', '16', null, '0');
INSERT INTO `tbm_department` VALUES ('167', '25', 'Pb.Operator Water Triatman ', '17', null, '0');
INSERT INTO `tbm_department` VALUES ('168', '25', 'Operator Klarifikasi ', '18', null, '0');
INSERT INTO `tbm_department` VALUES ('169', '25', 'Pb. Operator Klarifikasi', '19', null, '0');
INSERT INTO `tbm_department` VALUES ('170', '25', 'Mill Manager', '1', null, '0');
INSERT INTO `tbm_department` VALUES ('171', '25', 'Operator Bunpress', '20', null, '0');
INSERT INTO `tbm_department` VALUES ('172', '25', 'Pb. Operator Bunpress', '21', null, '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbm_expense
-- ----------------------------
INSERT INTO `tbm_expense` VALUES ('1', '1', 'PEMBIBITAN', '0');
INSERT INTO `tbm_expense` VALUES ('2', '1', 'PEMUPUKAN', '0');
INSERT INTO `tbm_expense` VALUES ('3', '1', 'PEMBIBITAN', '1');
INSERT INTO `tbm_expense` VALUES ('4', '3', 'ALAT TULIS & CETAKAN', '0');
INSERT INTO `tbm_expense` VALUES ('5', '4', 'BELI BENSIN', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbm_expense_category
-- ----------------------------
INSERT INTO `tbm_expense_category` VALUES ('1', 'BIAYA KEBUN', '0');
INSERT INTO `tbm_expense_category` VALUES ('2', 'BIAYA 2', '0');
INSERT INTO `tbm_expense_category` VALUES ('3', 'ATK', '0');
INSERT INTO `tbm_expense_category` VALUES ('4', 'ONGKOS', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_golongan_karyawan
-- ----------------------------
INSERT INTO `tbm_golongan_karyawan` VALUES ('1', 'F-1', '2063250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('2', 'F-2', '2068250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('3', 'F-3', '2450000.00', '1');
INSERT INTO `tbm_golongan_karyawan` VALUES ('4', 'F-3', '2073250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('5', 'G-1', '2003250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('6', 'F-4', '2078250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('7', 'F-5', '2083250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('8', 'F-6', '2088250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('9', 'F-7', '2093250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('10', 'D-7', '2243250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('11', 'SKU', '1983250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('12', 'G-2', '2008250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('13', 'G-3', '2013250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('14', 'G-4', '2018250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('15', 'G-5', '2023250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('16', 'G-6', '2028250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('17', 'G-7', '2033250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('18', 'E-1', '2133250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('19', 'E-2', '2138250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('20', 'E-3', '2143250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('21', 'E-4', '2148250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('22', 'E-5', '2153250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('23', 'E-6', '2158250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('24', 'E-7', '2163250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('25', 'D-1', '2213250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('26', 'D-2', '2218250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('27', 'D-3', '2223250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('28', 'D-4', '2228250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('29', 'D-5', '2233250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('30', 'D-6', '2238250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('31', 'C-1', '2303250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('32', 'C-2', '2308250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('33', 'C-3', '2313250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('34', 'C-4', '2318250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('35', 'C-5', '2323250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('36', 'C-6', '2328250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('37', 'C-7', '2333250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('38', 'B-1', '2403250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('39', 'B-2', '2408250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('40', 'B-3', '2413250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('41', 'B-4', '2418250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('42', 'B-5', '2423250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('43', 'B-6', '2428250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('44', 'B-7', '2433250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('45', 'A-1', '2513250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('46', 'A-2', '2518250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('47', 'A-3', '2523250.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('48', 'SENIOR MANAGER', '15500000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('49', 'MANAGER', '10095000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('50', 'ASSISTEN MANAGER', '7595000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('51', 'ASSISTEN 1-7', '5945000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('52', 'ASSISTEN 1-6', '5795000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('53', 'ASSISTEN 1-5', '5645000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('54', 'ASSISTEN 1-4', '5495000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('55', 'ASSISTEN 1-3', '5345000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('56', 'ASSISTEN 1-2', '5195000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('57', 'ASSISTEN 1-1', '5045000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('58', 'ASSISTEN 2-7', '5000000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('59', 'ASSISTEN 2-6', '4850000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('60', 'ASSISTEN 2-5', '4700000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('61', 'ASSISTEN 2-4', '4550000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('62', 'ASSISTEN 2-3', '4400000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('63', 'ASSISTEN 2-2', '4250000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('64', 'ASSISTEN 2-1', '4100000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('65', 'ASSISTEN 3-7', '3950000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('66', 'ASSISTEN 3-6', '3875000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('67', 'ASSISTEN 3-5', '3800000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('68', 'ASSISTEN 3-4', '3725000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('69', 'ASSISTEN 3-3', '3650000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('70', 'ASSISTEN 3-2', '3575000.00', '0');
INSERT INTO `tbm_golongan_karyawan` VALUES ('71', 'ASSISTEN 3-1', '3500000.00', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_jabatan
-- ----------------------------
INSERT INTO `tbm_jabatan` VALUES ('1', '8', '10', 'Seniort Programmer', '1010101', '3', '1', '12', null, null, '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('2', '31', '32', 'Pb. Operator Wel Loader', '2', '2', '1', '12', null, null, '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('3', '31', '32', 'Operator Wel Loader', '1', '2', '1', '12', null, null, '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('4', '8', '33', 'Staff Accounting & Budget', '2', '1', '1', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('5', '8', '76', 'Staff Accounting & Pajak', '3', '1', '1', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('6', '8', '77', 'Staff Keuangan & Kasir', '3', '1', '1', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('7', '15', '16', 'Pengadaan & Logistik', '1', '1', '1', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('8', '15', '78', 'Kr. Gudang', '2', '1', '1', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('9', '15', '79', 'Pb. Kr. Gudang', '3', '1', '1', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('10', '17', '18', 'Danru Satpam', '1', '1', '1', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('11', '19', '20', 'Kr. Produksi', '1', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('12', '23', '121', 'Pegawas Timbangan & Payroll', '1', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('13', '19', '20', 'Kr. Produksi', '5', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('14', '48', '51', 'Kepala Laboratorium', '14', '1', '0', '12', '0', '0', '1561300', '1');
INSERT INTO `tbm_jabatan` VALUES ('15', '48', '51', 'Pengawas Timbangan & Payroll', '14', '1', '0', '12', '0', '0', '526300', '1');
INSERT INTO `tbm_jabatan` VALUES ('16', '48', '51', 'Pengawas Sortase', '14', '1', '0', '12', '0', '0', '1471300', '1');
INSERT INTO `tbm_jabatan` VALUES ('17', '8', '124', 'Assisten Keuangan', '1', '1', '0', '12', '0', '150000', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('18', '54', '55', 'Mill Manager', '16', '1', '0', '12', '0', '150000', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('19', '25', '26', 'Mandor Proses Shift I', '7', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('20', '27', '28', 'Mandor Proses Shift II', '8', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('21', '25', '26', 'Operator Klarifikasi Shift I', '7', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('22', '27', '28', 'Operator Klarifikasi Shift II', '8', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('23', '25', '26', ' Operator Kernel Shift I ', '7', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('24', '27', '28', ' Operator Kernel Shift II', '8', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('25', '25', '26', ' Pb. Operator Boiler Shift I ', '7', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('26', '27', '28', ' Pb. Operator Boiler Shift II', '8', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('27', '25', '26', ' Pb. Operator Bunpress Shift I ', '7', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('28', '25', '125', 'Assisten Proses Shift I', '2', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('29', '25', '26', ' Pb. Operator Rebusan Shift I ', '7', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('30', '27', '28', ' Pb. Operator Rebusan Shift II', '8', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('31', '25', '26', ' Pb. Operator Water Triatman Shift I ', '7', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('32', '27', '28', ' Pb. Operator Water Triatman Shift II', '8', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('33', '25', '26', ' Pb. Operator Boiler Shift I ', '7', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('34', '25', '26', ' Operator Kamar Mesin Shift I  ', '7', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('35', '27', '28', ' Operator Kamar Mesin Shift II', '8', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('36', '25', '26', 'Pb. Operator Kamar Mesin Shift I ', '7', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('37', '27', '28', 'Pb. Operator Kamar Mesin Shift I', '8', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('38', '25', '26', ' Pb. Operator Pressan Shift I ', '7', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('39', '27', '28', ' Pb. Operator Pressan Shift II', '8', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('40', '25', '26', 'Operator Pressan Shift I ', '7', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('41', '27', '28', 'Operator Pressan Shift II', '8', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('42', '25', '26', ' Operator Loading Ramp Shift I', '7', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('43', '27', '28', ' Operator Loading Ramp Shift I', '8', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('44', '25', '26', 'Pb. Operator Loading Ramp Shift I', '7', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('45', '27', '28', 'Pb. Operator Loading Ramp Shift II', '8', '1', '0', '12', '0', '0', '0', '1');
INSERT INTO `tbm_jabatan` VALUES ('46', '29', '67', 'Mandor Listrik', '3', '1', '0', '12', '0', '0', '1266750', '0');
INSERT INTO `tbm_jabatan` VALUES ('47', '29', '30', 'Mandor Mekanik', '2', '1', '0', '12', '0', '0', '180000', '0');
INSERT INTO `tbm_jabatan` VALUES ('48', '29', '68', 'Mekanik', '4', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('49', '29', '69', 'Pb. Mekanik', '5', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('50', '29', '70', 'Mekanik Elektrik', '6', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('51', '29', '30', 'Pb. Mekanik Elektrik', '7', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('52', '34', '35', ' Analyst ', '2', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('53', '34', '63', 'Pb.  Analyst ', '3', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('54', '34', '64', ' Operator Kolam Limbah ', '4', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('55', '34', '65', 'Pb. Operator Kolam Limbah', '5', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('56', '34', '66', ' Deskphack ', '6', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('57', '40', '41', 'Pengawas Sortase', '1', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('58', '17', '80', 'Anggota Satpam', '2', '12', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('59', '34', '122', 'Kepala Laboratorium', '1', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('60', '25', '26', 'Mandor Proses Shift I', '3', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('61', '25', '84', 'Operator Loading Ramp Shift I', '4', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('62', '25', '85', 'Pb. Operator Loading Ramp Shift I', '5', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('63', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('64', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('65', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('66', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('67', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('68', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('69', '0', '0', '', '', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('70', '25', '86', 'Operator Rebusan Shift I', '6', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('71', '25', '87', 'Pb. Operator Rebusan Shift I', '7', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('72', '25', '88', 'Operator Pressan Shift I', '8', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('73', '25', '89', 'Pb. Operator Pressan Shift I', '9', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('74', '25', '90', 'Operator Kernel Shift I', '10', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('75', '25', '91', 'Pb. Operator Kernel Shift I', '11', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('76', '25', '92', 'Operator Kamar Mesin Shift I', '12', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('77', '25', '93', 'Operator Kamar Mesin Shift I', '13', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('78', '25', '94', 'Operator Boiler Shift I', '14', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('79', '25', '95', 'Pb. Operator Boiler Shift I', '15', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('80', '25', '96', 'Operator Water Triatman Shift I', '16', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('81', '25', '97', 'Pb. Operator Water Triatman Shift I', '17', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('82', '25', '98', 'Operator Klarifikasi Shift I', '18', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('83', '25', '99', 'Pb. Operator Klarifikasi Shift I', '19', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('84', '25', '125', 'Assisten Proses Shift II', '2', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('85', '25', '26', 'Mandor Proses Shift II', '3', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('86', '25', '146', 'Operator Loading Ramp Shift II', '4', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('87', '25', '85', 'Pb. Operator Loading Ramp Shift II', '5', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('88', '25', '86', 'Operator Rebusan Shift II', '6', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('89', '25', '87', 'Pb. Operator Rebusan Shift II', '7', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('90', '25', '88', 'Operator Pressan Shift II', '8', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('91', '25', '89', 'Pb. Operator Pressan Shift II', '9', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('92', '25', '90', 'Operator Kernel Shift II', '10', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('93', '25', '91', 'Pb. Operator Kernel Shift II', '11', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('94', '25', '162', 'Operator Kamar Mesin Shift II', '12', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('95', '25', '163', 'Pb. Operator Kamar Mesin Shift II', '13', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('96', '25', '164', 'Operator Boiler Shift II', '14', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('97', '25', '165', 'Pb. Operator Boiler Shift II', '15', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('98', '25', '166', 'Operator Water Triatman Shift II', '16', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('99', '25', '167', 'Pb. Operator Water Triatman Shift II', '17', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('100', '25', '168', 'Operator Klarifikasi Shift II', '18', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('101', '25', '169', 'Pb. Operator Klarifikasi Shift II', '19', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('102', '25', '170', 'Mill Manager', '1', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('103', '40', '118', 'Sortase', '3', '10', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('104', '23', '129', 'Kr. Produksi', '2', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('105', '23', '82', 'Kr. Timbangan', '3', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('106', '23', '83', 'Pb. Kr. Timbangan', '4', '1', '0', '0', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('107', '25', '171', 'Operator Bunpress Shift I', '20', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('108', '25', '172', 'Pb. Operator Bunpress Shift I', '21', '1', '0', '12', '0', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('109', '25', '171', 'Operator Bunpress Shift II', '20', '1', '0', '12', '1', '0', '0', '0');
INSERT INTO `tbm_jabatan` VALUES ('110', '25', '172', 'Pb. Operator Bunpress Shift II', '21', '1', '0', '12', '0', '1', '0', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_jadwal
-- ----------------------------
INSERT INTO `tbm_jadwal` VALUES ('1', '0', '1', '2017-04-03', '2', '12:00:00', '06:00:00', '18:00:00', '12', '2017-04-03', '03:02:59', 'ADMIN', null, null, null, '06:30:00', '17:30:00', null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '0', '2', '0');
INSERT INTO `tbm_jadwal` VALUES ('2', '0', '1', '2017-04-04', '3', '11:00:00', '07:00:00', '15:00:00', '8', '2017-04-03', '03:02:59', 'ADMIN', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', null, '0', '0');
INSERT INTO `tbm_jadwal` VALUES ('3', '0', '2', '2017-04-03', '2', '12:00:00', '06:00:00', '18:00:00', '12', '2017-04-03', '03:02:59', 'ADMIN', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '25', '2', '0');
INSERT INTO `tbm_jadwal` VALUES ('4', '0', '2', '2017-04-04', '5', '12:00:00', '07:00:00', '17:00:00', '10', '2017-04-03', '03:02:59', 'ADMIN', null, null, null, '09:30:00', null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '0', '1', '0');
INSERT INTO `tbm_jadwal` VALUES ('5', '0', '1', '2017-05-03', '1', '10:00:00', '06:00:00', '14:00:00', '8', '2017-05-03', '15:31:54', 'ADMIN', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '24', '2', '0');
INSERT INTO `tbm_jadwal` VALUES ('6', '0', '2', '2017-05-03', '15', '18:00:00', '14:00:00', '22:00:00', '8', '2017-05-03', '15:31:54', 'ADMIN', null, null, null, '14:30:00', '22:30:00', null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '0', '2', '0');
INSERT INTO `tbm_jadwal` VALUES ('7', '0', '8', '2017-06-01', '36', '12:00:00', '08:00:00', '16:00:00', '7', '2017-06-30', '11:43:29', 'DAULAY', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', null, '0', '0');
INSERT INTO `tbm_jadwal` VALUES ('8', '0', '8', '2017-06-02', '36', '12:00:00', '08:00:00', '16:00:00', '7', '2017-06-30', '11:43:29', 'DAULAY', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', null, '0', '0');
INSERT INTO `tbm_jadwal` VALUES ('9', '0', '8', '2017-06-03', '36', '12:00:00', '08:00:00', '16:00:00', '7', '2017-06-30', '11:43:29', 'DAULAY', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', null, '0', '0');
INSERT INTO `tbm_jadwal` VALUES ('10', '0', '8', '2017-06-04', '36', '12:00:00', '08:00:00', '16:00:00', '7', '2017-06-30', '11:43:29', 'DAULAY', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', null, '0', '0');
INSERT INTO `tbm_jadwal` VALUES ('11', '0', '8', '2017-06-05', '36', '12:00:00', '08:00:00', '16:00:00', '7', '2017-06-30', '11:43:30', 'DAULAY', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', null, '0', '0');
INSERT INTO `tbm_jadwal` VALUES ('12', '0', '8', '2017-06-21', '36', '12:00:00', '08:00:00', '16:00:00', '7', '2017-06-30', '11:43:30', 'DAULAY', null, null, null, '08:00:00', '16:00:00', null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '0', '2', '0');
INSERT INTO `tbm_jadwal` VALUES ('13', '0', '8', '2017-06-20', '36', '12:00:00', '08:00:00', '16:00:00', '7', '2017-06-30', '11:43:30', 'DAULAY', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '1', '2', '0');
INSERT INTO `tbm_jadwal` VALUES ('14', '0', '8', '2017-06-12', '36', '12:00:00', '08:00:00', '16:00:00', '7', '2017-06-30', '11:43:30', 'DAULAY', null, null, null, '08:30:00', '16:00:00', null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '0', '2', '1');
INSERT INTO `tbm_jadwal` VALUES ('15', '0', '8', '2017-06-06', '36', '12:00:00', '08:00:00', '16:00:00', '7', '2017-06-30', '11:43:30', 'DAULAY', null, null, null, '08:07:00', '16:00:00', null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '0', '2', '1');
INSERT INTO `tbm_jadwal` VALUES ('16', '0', '8', '2017-06-07', '36', '12:00:00', '08:00:00', '16:00:00', '7', '2017-06-30', '11:43:30', 'DAULAY', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '1', '2', '0');
INSERT INTO `tbm_jadwal` VALUES ('17', '0', '8', '2017-06-08', '36', '12:00:00', '08:00:00', '16:00:00', '7', '2017-06-30', '11:43:30', 'DAULAY', null, null, null, '08:00:00', '17:00:00', null, null, null, '0', '0', '0', '0', null, '2', '0', '0', '0', '2', '0');
INSERT INTO `tbm_jadwal` VALUES ('18', '0', '8', '2017-06-09', '36', '12:00:00', '08:00:00', '16:00:00', '7', '2017-06-30', '11:43:30', 'DAULAY', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', null, '0', '0');
INSERT INTO `tbm_jadwal` VALUES ('19', '0', '21', '2017-06-01', '41', '12:00:00', '08:00:00', '17:00:00', '7', '2017-06-30', '11:43:29', 'DAULAY', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', null, '0', '0');
INSERT INTO `tbm_jadwal` VALUES ('20', '0', '21', '2017-06-02', '41', '12:00:00', '08:00:00', '17:00:00', '7', '2017-06-30', '11:43:29', 'DAULAY', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', null, '0', '0');
INSERT INTO `tbm_jadwal` VALUES ('21', '0', '21', '2017-06-03', '41', '12:00:00', '08:00:00', '17:00:00', '7', '2017-06-30', '11:43:29', 'DAULAY', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', null, '0', '0');
INSERT INTO `tbm_jadwal` VALUES ('22', '0', '21', '2017-06-04', '41', '12:00:00', '08:00:00', '17:00:00', '7', '2017-06-30', '11:43:29', 'DAULAY', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', null, '0', '0');
INSERT INTO `tbm_jadwal` VALUES ('23', '0', '21', '2017-06-05', '41', '12:00:00', '08:00:00', '17:00:00', '7', '2017-06-30', '11:43:29', 'DAULAY', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', null, '0', '0');
INSERT INTO `tbm_jadwal` VALUES ('24', '0', '21', '2017-06-06', '41', '12:00:00', '08:00:00', '17:00:00', '7', '2017-06-30', '11:43:29', 'DAULAY', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', null, '0', '0');
INSERT INTO `tbm_jadwal` VALUES ('25', '0', '21', '2017-06-08', '41', '12:00:00', '08:00:00', '17:00:00', '7', '2017-06-30', '11:43:29', 'DAULAY', null, null, null, null, null, null, null, null, '0', '0', '0', '0', null, '2', '0', '0', null, '0', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_karyawan
-- ----------------------------
INSERT INTO `tbm_karyawan` VALUES ('1', '1', '1', null, '0', '10810Den2400001', '10507624', 'Deni Andriansah', '0', 'Bandung', '1989-04-02', 'Sastra 36', '43', '0', '1', null, '3', '85722984816', '2010-08-20', '0', '1', '1', '1234534556344', null, null, null, '1', null, '0', '0', null, '1');
INSERT INTO `tbm_karyawan` VALUES ('2', '1', '1', null, '0', '10117Ude7600001', '0978976t786576', 'Udeng Budeng', '1', 'Surabaya', '1991-11-20', 'fghfghdrfgh', '35', '1', '1', null, '4', '4566756', '2017-01-18', '0', '3', '1', '4364564645', null, null, null, '1', null, '0', '0', null, '1');
INSERT INTO `tbm_karyawan` VALUES ('3', '1', '3', '5', '2', '2013.10.11009', '787', 'Arjun', '0', 'Papaso', '1986-02-05', 'Kom. Perumahan PT. Sinar Halomoan', '50', '1', '1', null, '7', '78787', '2013-10-17', '0', '3', '0', '', null, null, null, '1', '160000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('4', '1', '2', '1', '0', '10915Angre00002', 'ewrewre', 'Anggi Pranata', '0', 'Tamora', '1995-04-09', 'Komp. Perumahan PT. Sinar Halomoan', '50', '0', '1', null, '7', '34434', '2015-09-12', '0', '3', '0', '', null, null, null, '1', '10000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('5', '1', '4', '1', '0', '10414Duhew00002', 'wew', 'Duha Sukrina Harahap', '1', 'medan', '1992-09-09', 'Mompang', '50', '0', '1', null, '3', '45454', '2014-04-09', '0', '3', '0', '', null, null, null, '1', '10000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('6', '1', '5', '1', '0', '10215Nur4500002', '4545', 'Nurmuliana Daulay', '1', 'Siolip', '1986-08-05', 'Latong', '50', '0', '1', null, '3', '454', '2015-02-10', '0', '3', '0', '', null, null, null, '1', '10000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('7', '1', '6', '1', '0', '10215Git4500002', '454545', 'Gita Kharisma Octavia Hrp', '1', 'Sipangko', '1988-10-05', 'Komp. Peruman PT. Sinar Halomoan', '50', '1', '1', null, '4', '232323', '2015-02-02', '0', '3', '0', '', null, null, null, '1', '10000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('8', '1', '7', '10', '0', '2015.05.11006', '3434343434', 'Ahmad Gustami Nasution', '0', 'Paringgonan', '1990-08-30', 'Komp. Perumahan PT. Sinar Halomoan', '50', '1', '1', null, '3', '0', '2012-12-12', '0', '3', '0', '', null, null, null, '1', '130000', '1', '1', '0', '0');
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
INSERT INTO `tbm_karyawan` VALUES ('20', '2', '11', '2', '0', '2015.02.22004', '86767', 'Pinta Riski Mala Hasibuan', '1', 'Sibuhuan', '1990-01-28', 'Kom. Perumahan PT. Sinar Halomoan', '67', '1', '1', null, '3', '2131323', '2015-01-12', '0', '3', '0', '', null, null, null, '2', '100000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('21', '1', '12', '46', '3', '2014.03.11002', '0', 'Adil Habib Daulay', '0', 'Pasar Ujung Batu', '1982-02-24', 'Kom. Perumahan PT. Sinar Halomoan', '67', '1', '1', null, '3', '+6281320094001', '2014-03-31', '0', '3', '11', '0355860371', null, null, null, '1', '190000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('22', '2', '106', '1', '0', '2015.03.22005', '0', 'Ida Yanti Hasibuan', '1', 'Sialambue', '1990-02-01', 'Desa Sialambue Kecamatan Barumun Kabupaten Padang Lawas Provinsi Sumatera Utara. ', '67', '0', '1', null, '3', '0', '2015-03-01', '0', '3', '0', '', null, null, null, '2', '100000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('23', '2', '105', '2', '0', '2015.03.22006', '0', 'Hadisyah Sally Oktavia ', '1', 'Tangerang', '1991-10-10', 'Lingkungan II Pasar Sibuhuan Kecamatan Barumun Kabupaten Padang Lawas Provinsi Sumatera Utara.', '67', '0', '1', null, '7', '0', '2015-03-02', '0', '3', '0', '', null, null, null, '2', '100000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('24', '2', '60', '44', '3', '2015.08.21007', '0', 'Parhanuddin Harahap', '0', 'Sibuhuan', '1984-02-09', 'Lingkungan III Pasar Sibuhuan Kec. Barumun Kab. Padang LawasProvinsi Sumatera Utara', '67', '1', '1', null, '7', '0', '2015-08-06', '0', '3', '0', '', null, null, null, '2', '190000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('25', '2', '82', '10', '3', '2015.02.21009', '0', 'Akhirullah Hasibuan', '0', 'Parau Sorat', '1981-03-04', 'Desa Parau Sorat, Kecamatan Sosa Kabupaten Padang Lawas, Provinsi Sumatera Utara ', '67', '1', '1', null, '7', '0', '2015-02-21', '0', '3', '0', '', null, null, null, '2', '190000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('26', '2', '74', '10', '2', '2015.06.21010', '0', 'Habibi Swandi Pohan', '0', 'Padang Sidimpuan', '1989-12-28', 'Desa Sukarame, Kecamatan Kualuh Hulu Kabupaten Labuhanbatu Utara, Provinsi Sumatera Utara. ', '50', '1', '1', null, '7', '0', '2015-06-13', '0', '3', '0', '', null, null, null, '2', '160000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('27', '2', '79', '1', '0', '2013.10.21011', '0', 'Muhammad Nijam Hasibuan', '0', 'Binabo Jae', '1994-06-26', 'Desa Binabo Jae, Kecamatan Barumun Kabupaten Padang Lawas, Provinsi Sumatera Utara ', '67', '0', '1', null, '7', '0', '2013-10-07', '0', '3', '0', '', null, null, null, '2', '100000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('28', '2', '107', '1', '4', '2015.03.21012', '0', 'Sutan Nasution', '0', 'Tangga Bosi', '1976-02-10', 'Desa Tangga Bosi, Kecamatan Lubuk Barumun Kabupaten Padang Lawas, Provinsi Sumatera Utara', '67', '1', '1', null, '7', '0', '2015-03-02', '0', '3', '0', '', null, null, null, '2', '220000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('29', '2', '71', '1', '0', '2015.03.21013', '0', 'Rahmat Fauzi Hasibuan ', '0', 'Mompang', '1990-07-03', 'Desa Mompang, Kecamatan Barumun, Kabupaten Padang Lawas, Provinsi Sumatera Utara', '67', '0', '1', null, '7', '0', '2015-03-25', '0', '3', '0', '', null, null, null, '2', '100000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('30', '2', '81', '1', '0', '2015.03.21014', '0', 'Samsuddin Pasaribu ', '0', 'Sungai Jior', '1994-06-26', 'Desa Pasir Julu, Kecamatan Sosa Kabupaten Padang Lawas, Provinsi Sumatera Utara', '67', '0', '1', null, '7', '0', '2015-03-18', '0', '3', '0', '', null, null, null, '2', '100000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('31', '2', '79', '1', '2', '2015.03.21015', '0', 'Irdan Suandi Lubis ', '0', 'Hasahatan Julu', '1993-08-28', 'Desa Hasahatan Julu, Kecamatan Barumun Kabupaten Padang Lawas, Provinsi Sumatera Utara ', '67', '1', '1', null, '7', '0', '2015-03-25', '0', '3', '0', '', null, null, null, '2', '160000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('32', '2', '71', '5', '1', '2015.09.21016', '0', 'Munawir Saputra Nasution', '0', 'Hurung Jilok', '1993-05-12', 'Hurung Jilok Kec. Sosa Padang Lawas Provinsi Sumatera Utara ', '67', '1', '1', null, '7', '0', '2015-09-18', '0', '3', '0', '', null, null, null, '2', '130000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('33', '2', '79', '1', '0', '2015.03.21017', '0', ' Ahmad Daulay ', '0', 'Pasir Jae', '1991-11-15', 'Desa Ampolu, Kecamatan Sosa Kabupaten Padang Lawas, Provinsi Sumatera Utara', '67', '0', '1', null, '7', '0', '2015-03-18', '0', '3', '0', '', null, null, null, '2', '100000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('34', '2', '76', '10', '2', '2015.05.21018', '0', 'Taufan Firdaus ', '0', 'Ledong Barat', '1989-05-13', 'Komp. Perumahan PT. Sinar Halomoan', '67', '1', '1', null, '7', '0', '2015-05-28', '0', '3', '0', '', null, null, null, '2', '160000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('35', '2', '73', '5', '0', '2015.12.21020', '0', ' Duraman Soleh Hasibuan ', '0', 'Pasir Jae', '1997-07-20', 'Desa Pasir Jae, Kec. Sosa Kab. Padang Lawas - Sumatera Utara', '67', '0', '1', null, '7', '0', '2015-12-28', '0', '3', '0', '', null, null, null, '2', '100000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('36', '2', '73', '1', '0', '2015.03.21021', '0', ' Andry Daulay ', '0', 'Ampolu', '1992-05-11', 'Desa hurung Jilok, Kecamatan Sosa Kabupaten Padang Lawas, Provinsi Sumatera Utara. ', '67', '0', '1', null, '7', '0', '2015-03-18', '0', '3', '0', '', null, null, null, '2', '100000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('37', '2', '83', '11', '0', '2016.02.21032', '0', ' Samson Nauli Siregar ', '0', 'Parau Sorat', '1993-09-23', 'Parau Sorat Kec. Sosa Kab. Padang Lawas - Sumatera Utara', '67', '0', '1', null, '7', '0', '2016-02-29', '0', '3', '0', '', null, null, null, '2', '100000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('38', '2', '85', '44', '1', '2015.02.21022', '0', 'Ahmad Muslihuddin Nasution ', '0', 'Janjilobi', '1990-07-03', 'Desa Janjilobi, Kecamatan Barumun, Kabupaten Padang Lawas Provinsi Sumatera Utara ', '67', '1', '1', null, '7', '0', '2015-02-25', '0', '3', '0', '', null, null, null, '2', '130000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('39', '2', '86', '10', '2', '2015.03.21023', '0', 'Ilham Munawir Hasibuan', '0', 'Pasir Jae', '1986-07-20', 'Komp.Perumahan PT. Sinar Halomoan', '67', '1', '1', null, '7', '0', '2015-03-18', '0', '3', '0', '', null, null, null, '2', '130000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('40', '2', '88', '10', '0', '2015.03.21024', '0', 'Hasim Muda Pasaribu', '0', 'Desa Surodingin', '1987-12-04', 'Desa Surodingin, Kecamatan Lubuk Barumun Kabupaten Padang Lawas, Provinsi Sumatera Utara.', '67', '0', '1', null, '7', '0', '2015-03-07', '0', '3', '0', '', null, null, null, '2', '100000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('41', '2', '91', '1', '2', '2015.05.21026', '0', 'Hubbi Hasibuan', '0', 'Sabarimba', '1987-12-14', 'Desa Sabarimba, Kecamatan Barumun Kabupaten Padang Lawas, Provinsi Sumatera Utara', '67', '1', '1', null, '7', '0', '2015-05-18', '0', '3', '0', '', null, null, null, '2', '160000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('42', '2', '92', '10', '3', '2014.01.21028', '0', 'Alamsyah Nasution', '0', 'Aek Bargot', '1982-02-21', 'Desa Aek Bargot, Kecamatan Sosopan Kabupaten Padang Lawas, Provinsi Sumatera Utara.', '67', '1', '1', null, '7', '0', '2014-01-07', '0', '3', '0', '', null, null, null, '2', '190000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('43', '2', '94', '10', '3', '2015.12.21029', '0', 'Sahrul Suhaili Harahap', '0', 'Hutaibus', '1987-09-02', 'Sangkilon, KEc. Lubuk Barumun Kab. Padang Lawas - Sumatera Utara', '67', '1', '1', null, '3', '0', '2015-12-07', '0', '3', '0', '', null, null, null, '2', '190000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('44', '2', '97', '1', '0', '2015.11.21030', '0', 'Samsuddin Hasibuan', '0', 'Medan', '1986-07-07', 'Surodingin Kecamatan Lubuk Barumun Kabupaten Padang Lawas Provinsi Sumatera Utara', '67', '0', '1', null, '7', '0', '2015-09-14', '0', '3', '0', '', null, null, null, '2', '100000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('45', '2', '96', '10', '0', '2015.03.21031', '0', 'Guntur Hasibuan', '0', 'Pasir Jae', '1995-05-15', 'Desa Hurung Jilok, Kecamatan Sosa Kabupaten Padang Lawas, Provinsi Sumatera Utara', '67', '0', '1', null, '7', '0', '2015-03-18', '0', '3', '0', '', null, null, null, '2', '100000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('46', '2', '99', '1', '2', '2015.03.21033', '0', 'Mhd. Dahrul Lubis', '0', 'Ramba', '1993-07-07', 'Kom. Perumahan PT. Sinar Halomoan', '67', '1', '1', null, '7', '0', '2015-03-18', '0', '3', '0', '', null, null, null, '2', '160000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('47', '2', '89', '1', '0', '2015.10.21034', '0', 'Baluddin Hasibuan', '0', 'Sibuhuan', '1984-02-09', 'Desa Surodingin Kecamatan Lubuk Barumun Kabupaten Padang Lawas â€“ Sumatera Utara', '67', '0', '1', null, '7', '0', '2015-10-05', '0', '3', '0', '', null, null, null, '2', '100000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('48', '2', '100', '5', '2', '2016.01.21019', '0', 'Idris Setiawan', '0', 'Melati II', '1992-10-24', 'Dusun Jering I Melati II Kec. Perbaungan Kab. Serdang Bedagai', '43', '1', '1', null, '7', '0', '2016-01-18', '0', '3', '0', '', null, null, null, '2', '160000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('49', '2', '89', '1', '2', '2015.02.21036', '0', 'Zainul S. Daulay', '0', 'Ampolu', '1994-07-07', 'Komp. Perumahan PT. Sinar Halomoan', '67', '1', '1', null, '7', '0', '2015-02-21', '0', '3', '0', '', null, null, null, '2', '160000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('50', '2', '50', '10', '2', '2015.03.21039', '0', 'Ahmad Pauzan Hasibuan', '0', 'Hurung Jilok', '1996-02-28', 'Pasir Hurung Jilok Kec. Sosa Kab. Padang Lawas Provinsi Sumatera Utara', '67', '1', '1', null, '7', '0', '2015-03-19', '0', '3', '0', '', null, null, null, '2', '160000', '1', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('51', '2', '49', '11', '2', '2015.12.21043', '0', 'Nanang Yendika', '0', 'Kepala Sungai', '1991-07-18', 'Dusun Kepala Sungai II Desa Suka Mulia Kec. Secanggang Kab. Langkat - Sumatera Utara', '50', '1', '1', null, '7', '0', '2015-12-26', '0', '3', '0', '', null, null, null, '2', '160000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('52', '2', '49', '11', '3', '2016.01.21044', '0', 'Miswar Pasaribu', '0', 'Pasir Jae', '1982-03-15', 'Desa Pasir Jae, Kec. Sosa Kab. Padang Lawas - Sumatera Utara', '67', '1', '1', null, '7', '0', '2016-01-05', '0', '3', '0', '', null, null, null, '2', '190000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('53', '2', '49', '1', '2', '2016.07.21047', '0', 'Teguh Nugraha', '0', 'Perbaungan', '1984-03-30', 'Link. X Desa Tualang Kec. Perbaungan Kab. Serdang Bedagai - Sumatera Utara', '50', '1', '1', null, '6', '0', '2016-07-12', '0', '3', '0', '', null, null, null, '2', '160000', '0', '1', '0', '0');
INSERT INTO `tbm_karyawan` VALUES ('54', '2', '49', '1', '4', '2016.10.21046', '0', 'Muslim Siregar', '0', 'Gunung Matua', '1977-08-22', 'Desa Gunung Matua Kec. Portibi Kabupaten Padang Lawas Utara - Sumatra Utara', '67', '1', '1', null, '7', '0', '2016-10-28', '0', '3', '0', '', null, null, null, '2', '220000', '0', '1', '0', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

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
INSERT INTO `tbm_kategori_barang` VALUES ('16', '1', 'Buah Luar', '786', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_kategori_pemasok
-- ----------------------------
INSERT INTO `tbm_kategori_pemasok` VALUES ('1', '0', 'Tongku Hasibuan', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('2', '0', 'CV. Berkah Mandiri', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('3', '0', 'Andry E Sosa', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('4', '0', '4', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('5', '0', '5', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('6', '0', '6', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('7', '0', '7', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('8', '0', '8', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('9', '0', '9', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('10', '0', '10', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('11', '0', '11', null, null, '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('12', '0', 'Mandurana', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('13', '0', 'ASN', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('14', '0', 'Sejahtera Sawit', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('15', '0', 'Zio', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('16', '0', 'SHS', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('17', '0', 'UD. Rizki', '10.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('18', '0', 'Pinarik Jaya', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('19', '0', 'PT. Sibuah Raya', '10.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('20', '0', 'Rosmeini', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('21', '0', 'KT. SHBM', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('22', '0', 'PT. Mujur Usaha Mandiri', '10.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('23', '0', 'PT. Sinar Halomoan', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('24', '0', 'SP 16', '0.00', '0.00', '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('25', '0', 'SP 17', '0.00', '0.00', '1');
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
INSERT INTO `tbm_kategori_pemasok` VALUES ('36', '1', 'SPAREPART PABRIK', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('37', '1', 'LABORATORIUM', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('38', '1', 'UMUM', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('39', '1', 'ATK & CETAKAN', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('40', '1', 'BBM & PELUMAS', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('41', '1', 'OLI & PELUMAS', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('42', '1', 'SPAREPART KENDERAAN', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('43', '1', 'BANGUNAN', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('44', '1', 'ELEKTRIK', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('45', '1', 'SPAREPART ALAT BERAT', '0.00', '0.00', '0');
INSERT INTO `tbm_kategori_pemasok` VALUES ('46', '0', 'SP 18', '0.00', '0.00', '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('47', '0', 'SP 19', '0.00', '0.00', '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('48', '0', 'SP 20', '0.00', '0.00', '1');
INSERT INTO `tbm_kategori_pemasok` VALUES ('49', '0', 'Sawit Makmur', '0.00', '0.00', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_menu
-- ----------------------------
INSERT INTO `tbm_menu` VALUES ('1', '0', 'Master Data', null, 'entypo-cog', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('2', '69', 'Master Barang', 'Master.MasterBarang', '', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('3', '69', 'Master Satuan', 'Master.MasterSatuan', '', '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('5', '71', 'Master Pemasok Tbs', 'Master.MasterPemasokTbs', '', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('6', '69', 'Master Supplier Barang', 'Master.MasterPemasok', '', '1', '7', '0');
INSERT INTO `tbm_menu` VALUES ('7', '17', 'Transaksi', '', 'entypo-basket', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('8', '0', 'Timbangan', '', 'entypo-basket', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('9', '7', 'Pembelian Barang', 'Transaksi.PurchaseOrder', '', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('12', '104', 'Laporan Timbangan', 'Laporan.LaporanTimbangan', null, '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('13', '0', 'Admin', null, 'entypo-user', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('14', '13', 'User Group', 'Admin.UserGroup', null, '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('15', '13', 'User Admin', 'Admin.UserAdmin', null, '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('16', '101', 'Kartu Stok Barang', 'Inventory.KartuStok', '', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('17', '0', 'Inventory', null, 'entypo-folder', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('18', '7', 'Pengeluaran Barang', 'Inventory.MutasiBarangRusak', null, '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('25', '13', 'Profil Perusahaan', 'Admin.ProfilPerusahaan', null, '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('27', '69', 'Master Kategori Barang', 'Master.MasterKategoriBarang', '', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('28', '71', 'Master Kategori Pemasok', 'Master.MasterKategoriPemasok', '', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('29', '69', 'Master Kategori Pelanggan', 'Master.MasterKategoriPelanggan', '', '0', '3', '0');
INSERT INTO `tbm_menu` VALUES ('30', '7', 'Permintaan Barang', 'Transaksi.RequestOrder', '', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('31', '0', 'Finance', null, 'entypo-chart-line', '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('32', '71', 'Setting Komidel', 'Setting.SettingKomidel', '', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('33', '71', 'Setting Kendaraan', 'Setting.JenisKendaraan', '', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('34', '100', 'Konfirmasi Permintaan', 'Transaksi.AdminRequestOrder', null, '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('35', '100', 'Pembayaran TBS', 'Keuangan.BayarTbsOrder', null, '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('36', '103', 'Transaksi TBS', 'Transaksi.TbsOrder', '', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('37', '7', 'Penerimaan Barang', 'Inventory.ReceivingOrder', '', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('38', '71', 'Setting Harga TBS', 'Keuangan.SettingHargaTbsOrder', null, '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('39', '100', 'Kontrak Penjualan', 'Transaksi.ContractSales', null, '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('40', '103', 'LHP', 'Inventory.ProcessingTbs', '', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('41', '100', 'Pembayaran PO', 'Keuangan.BayarPo', null, '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('42', '49', 'Master Data HRD', '', 'entypo-users', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('43', '42', 'Master Cabang', 'Master.MasterKantorCabang', null, '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('44', '42', 'Master Department', 'Master.MasterDepartment', null, '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('45', '42', 'Master Karyawan', 'Master.MasterKaryawan', null, '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('46', '42', 'Master Jabatan', 'Master.MasterJabatan', null, '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('48', '42', 'Rekap Gaji Karyawan', 'Hrd.LaporanRekapGajiKaryawan', null, '1', '6', '0');
INSERT INTO `tbm_menu` VALUES ('49', '0', 'HRD', null, 'entypo-suitcase', '1', '6', '0');
INSERT INTO `tbm_menu` VALUES ('50', '72', 'Pengaturan Shift', 'Hrd.ShiftSetting', '', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('51', '72', 'Jadwal Karyawan', 'Hrd.JadwalShiftKaryawan', '', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('52', '73', 'Incentive Karyawan', 'Hrd.IncentiveTransaction', '', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('53', '73', 'Biaya Karyawan', 'Hrd.ExpenseKaryawan', '', '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('54', '73', 'Absensi Karyawan', 'Hrd.AbsensiKaryawan', '', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('55', '100', 'Penerimaan Penjualan', 'Keuangan.PenerimaanJual', null, '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('56', '70', 'Master Group Coa', 'Master.MasterGroupCoa', '', '1', '10', '1');
INSERT INTO `tbm_menu` VALUES ('57', '70', 'Master Coa', 'Master.MasterCoa', '', '1', '11', '0');
INSERT INTO `tbm_menu` VALUES ('58', '101', 'Laporan Pembelian Barang', 'Laporan.LaporanPurchaseOrder', '', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('59', '101', 'Laporan Permintaan Barang', 'Laporan.LaporanRequestOrder', '', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('60', '70', 'Master Bank', 'Master.MasterBank', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('61', '70', 'Kategori Pengeluaran', 'Master.MasterExpenseCategory', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('62', '70', 'Master Pengeluaran', 'Master.MasterExpense', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('63', '70', 'Kategori Pendapatan', 'Master.MasterRevenueCategory', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('64', '70', 'Master Pendapatan', 'Master.MasterRevenue', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('65', '100', 'Transaksi Pengeluaran', 'Keuangan.ExpenseTransaction', '', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('66', '100', 'Transaksi Pendapatan', 'Keuangan.RevenueTransaction', '', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('67', '98', 'Buku Kas', 'Keuangan.BukuKas', null, '1', '6', '0');
INSERT INTO `tbm_menu` VALUES ('68', '7', 'Production Product', 'Inventory.ProductionProduct', null, '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('69', '17', 'Master Data', '', 'entypo-archive', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('70', '31', 'Master Data Transaksi', '', 'entypo-switch', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('71', '8', 'Master Data', '', 'entypo-briefcase', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('72', '49', 'Setting Absensi', '', 'entypo-layout', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('73', '49', 'Kegiatan Karyawan', '', 'entypo-github', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('74', '13', 'Admin Menu', 'Admin.MenuAdmin', null, '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('75', '98', 'Laporan Umur Hutang PO', 'Keuangan.LaporanHutangPO', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('76', '101', 'Laporan Pemakaian', 'Inventory.LaporanPemakaian', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('77', '7', 'Stok Opname', 'Inventory.StockOpname', '', '1', '6', '0');
INSERT INTO `tbm_menu` VALUES ('78', '73', 'Lembur Karyawan', 'Hrd.LemburKaryawan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('79', '73', 'Jadwal Per Karyawan', 'Hrd.JadwalPerKaryawan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('80', '73', 'Resign Karyawan', 'Hrd.ResignForm', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('81', '98', 'Laporan Laba Rugi', 'Keuangan.LaporanLabaRugi', '', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('82', '98', 'Laporan Jurnal Umum', 'Keuangan.LaporanJurnalUmum', '', '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('83', '42', 'Master Golongan Karyawan', 'Master.MasterGolongan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('84', '104', 'Kartu Stok Tbs', 'Inventory.KartuStokTbs', '', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('85', '101', 'Laporan Barang Rusak', 'Inventory.LaporanBarangRusak', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('86', '49', 'Laporan HRD', '', 'entypo-doc-text', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('87', '86', 'Laporan Absensi Karyawan', 'Hrd.LaporanAbsensiKaryawan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('88', '86', 'Laporan Lembur Karyawan', 'Hrd.LaporanLemburKaryawan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('89', '86', 'Laporan Incentive Karyawan', 'Hrd.LaporanIncentiveKaryawan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('90', '86', 'Laporan Resign Karyawan', 'Hrd.LaporanResignKaryawan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('91', '98', 'Laporan Pembayaran PO', 'Laporan.LaporanPembayaranPurchaseOrder', '', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('92', '98', 'Laporan Pembayaran TBS', 'Laporan.LaporanPembayaranTbs', '', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('93', '98', 'Laporan Umur Hutang TBS', 'Keuangan.LaporanHutangTbs', '', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('94', '103', 'Transaksi Commodity', 'Transaksi.CommodityTransaction', '', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('95', '104', 'Laporan Penjualan Commodity', 'Laporan.LaporanPenjualanCommodity', '', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('96', '100', 'Saldo Awal Bank', 'Keuangan.SaldoAwalBank', '', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('97', '100', 'Mutasi Kas', 'Keuangan.MutasiKas', '', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('98', '31', 'Laporan Finance', null, 'entypo-doc-text', '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('100', '31', 'Form Transaksi', null, 'entypo-basket', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('101', '17', 'Laporan Gudang', null, 'entypo-doc-text', '1', '12', '0');
INSERT INTO `tbm_menu` VALUES ('103', '8', 'Form Transaksi', null, 'entypo-basket', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('104', '8', 'Laporan', '', 'entypo-doc-text', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('105', '104', 'Stok Commodity', 'Inventory.StokCommodity', '', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('106', '103', 'Setting Tbs Order', 'Keuangan.SettingTbsOrder', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('107', '100', 'Pembayaran Gaji Karyawan', 'Hrd.PembayaranGajiKaryawan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('108', '98', 'Laporan Pembelian TBS', 'Laporan.LaporanPembelianTbs', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('109', '70', 'Aktiva Tetap', 'Keuangan.AktivaTetap', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('110', '100', 'Closing Report', 'Keuangan.ClosingKeuanganBulanan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('111', '98', 'Neraca', 'Keuangan.NeracaBulanan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('112', '98', 'Laporan Jurnal Pembelian', 'Keuangan.LaporanJurnalPembelian', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('113', '98', 'Laporan Jurnal Pengeluaran Kas', 'Keuangan.LaporanJurnalPengeluaranKas', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('114', '98', 'Laporan Jurnal Penjualan', 'Keuangan.LaporanJurnalPenjualan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('115', '98', 'Laporan Jurnal Penerimaan Kas', 'Keuangan.LaporanJurnalPenerimaanKas', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('116', '101', 'Stok Barang', 'Inventory.StokBarang', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('117', '98', 'Laporan Jurnal Penyesuaian', 'Keuangan.LaporanJurnalPenyesuaian', '', '1', null, '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_pemasok
-- ----------------------------
INSERT INTO `tbm_pemasok` VALUES ('2', '1', 'Tongku Hasibuan', 'Pasir Jae', '', '', '', '001', null, '2', '0');
INSERT INTO `tbm_pemasok` VALUES ('3', '2', 'CV. Berkah Mandiri', 'Sibuhuan', '', '', '', '002', null, '2', '0');
INSERT INTO `tbm_pemasok` VALUES ('4', '3', 'Andry E Sosa', 'Pasar Ujung Batu', '', '', '', '003', null, '2', '0');
INSERT INTO `tbm_pemasok` VALUES ('5', '12', 'Mandurana', 'Sibuhuan', '', '', '', '004', null, '1', '0');
INSERT INTO `tbm_pemasok` VALUES ('6', '13', 'ASN', 'Sibuhuan', '', '', '', '005', null, '2', '0');
INSERT INTO `tbm_pemasok` VALUES ('8', '14', 'Sejahtera Sawit', 'Sibuhuan', '', '', '', '006', null, '2', '0');
INSERT INTO `tbm_pemasok` VALUES ('10', '15', 'Zio', 'Sibuhuan', '', '', '', '007', null, '2', '0');
INSERT INTO `tbm_pemasok` VALUES ('11', '16', 'SHS', 'sibuhuan', '', '', '', '008', null, '2', '0');
INSERT INTO `tbm_pemasok` VALUES ('12', '17', 'UD. Rizki', 'Sibuhuan', '', '', '', '009', null, '2', '0');
INSERT INTO `tbm_pemasok` VALUES ('13', '18', 'Pinarik Jaya', 'Pinarik Sosa', '', '', '', '010', null, '2', '0');
INSERT INTO `tbm_pemasok` VALUES ('14', '19', 'PT. Sibuah Raya', 'Siali-ali', '', '', '', '011', null, '2', '0');
INSERT INTO `tbm_pemasok` VALUES ('15', '20', 'Rosmeini', 'Siali-ali', '', '', '', '012', null, '2', '0');
INSERT INTO `tbm_pemasok` VALUES ('18', '21', 'KT. SHBM', 'Sibuhuan', '', '', '', '013', null, '2', '0');
INSERT INTO `tbm_pemasok` VALUES ('19', '22', 'PT. Mujur Usaha Mandiri', 'Bunut', '', '', '', '014', null, '3', '0');
INSERT INTO `tbm_pemasok` VALUES ('20', '23', 'PT. Sinar Halomoan', 'Bunut', '', '', '', '015', null, '3', '0');
INSERT INTO `tbm_pemasok` VALUES ('21', '24', '-', 'Sibuhuan', '', '', '', '016', null, '2', '1');
INSERT INTO `tbm_pemasok` VALUES ('22', '25', 'UD. Mitra Pribadi', 'Siali-ali', '', '', '', '017', null, '1', '1');
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
INSERT INTO `tbm_pemasok` VALUES ('40', '26', 'PT. TRAGLOPINDO UTAMA', 'JALAN SABARUDDIN NO.8 SIMPANG BAKARAN BATU KELURAHAN SEI SEI RENGGAS PERMATA-KECAMATAN MEDAN AREA MEDAN (20214)-SUMATERA UTARA-INDONESIA', '62617321', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('41', '26', 'CV. SWADAYA ABDI PUTRA', 'JL. JEND ABD. HARIS NASUTION NO. 5 MEDAN', '061-7878309', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('42', '26', 'PT. BERKAH BUNDO BERSAMA', 'MEDAN', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('43', '27', 'CV. MADANI SEJAHTERA', 'JL. STM RUKO STM BUSINESS CENTRE BLOK 1 NO. 024-025 MEDAN', '061-4146293', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('44', '27', 'CV. HAR AGRITECH', 'MEDAN', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('45', '26', 'CV. MANDIRI JAYA PERKASA', 'PEKANBARU', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('46', '30', 'PT. JAYA ABADI SIAGA', 'MEDAN MARELAN', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('47', '26', 'PT. VALMATIC INDONESIA', 'JL. KARTAMA NO 16 KELURAHAN MAHARATU KECAMATAN MARPOYAN DAMAI PEKANBARU-RIAU-INDONESIA', '761565887', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('48', '26', 'CV. OKTA KARYA ENGINEERING', 'KOMPLEK ISTANA BISNIS CENTRE NO.45 -JL. BRIG.JEND KATAMSO MEDAN MAIMOON MEDAN 20159', '061-4517538', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('49', '27', 'CV. KARYA PERKASA', 'KOMPLEK MMTC BLOK H NO. 8 MEDAN', '061-80089962', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('50', '30', 'PT. PETRO ANDHARA ARTHA', 'JL. PAKU NO.17 LINGK III-MEDAN MARELAN', '061-6855515', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('51', '28', 'UD. ANDI', 'SIBUHUAN', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('52', '28', 'UD.HAFIZAH', 'PASIR JAE', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('53', '28', 'UD.CAV', 'SIBUHUAN', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('54', '26', 'PT. BUANA RANTAI BERKAT ABADI', '', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('55', '31', 'PT. LARIS SUMUT MAKMUR', 'MEDAN', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('56', '32', 'PT. TRAKINDO UTAMA', '', '', '', '', '0', '0.00', '0', '0');
INSERT INTO `tbm_pemasok` VALUES ('57', '25', 'UD. Mitra Pribadi', 'SIali-ali', '', '', '', '017', null, '2', '1');
INSERT INTO `tbm_pemasok` VALUES ('58', '49', 'Sawit Makmur', 'Sibuhuan', '', '', '', '020', null, '2', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbm_revenue
-- ----------------------------
INSERT INTO `tbm_revenue` VALUES ('1', '1', 'PENDAPATAN TAMBAHAN', '0');
INSERT INTO `tbm_revenue` VALUES ('2', '3', 'MEMPERGUNAKAN ALAT BERAT', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbm_revenue_category
-- ----------------------------
INSERT INTO `tbm_revenue_category` VALUES ('1', 'PENDAPATAN 12', '0');
INSERT INTO `tbm_revenue_category` VALUES ('2', 'PENDAPATAN 2', '1');
INSERT INTO `tbm_revenue_category` VALUES ('3', 'ADMINISTRASI', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

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
INSERT INTO `tbm_satuan` VALUES ('41', 'Drum', 'Drum', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=1462 DEFAULT CHARSET=utf8;

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
INSERT INTO `tbm_satuan_barang` VALUES ('1455', '23', '41', '1.00', '3', '1');
INSERT INTO `tbm_satuan_barang` VALUES ('1456', '23', '41', '209.00', '4', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1457', '25', '41', '209.00', '3', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1458', '26', '41', '209.00', '3', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1459', '28', '41', '209.00', '3', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1460', '1026', '18', '1.00', '1', '0');
INSERT INTO `tbm_satuan_barang` VALUES ('1461', '1027', '34', '1.00', '1', '0');

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
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbm_shift_setting
-- ----------------------------
INSERT INTO `tbm_shift_setting` VALUES ('1', '1', '06:00:00', '14:00:00', '8', '10:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('2', '2', '06:00:00', '18:00:00', '12', '12:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('3', '3', '07:00:00', '15:00:00', '8', '11:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('4', '4', '07:00:00', '16:00:00', '9', '11:30:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('5', '5', '07:00:00', '17:00:00', '10', '12:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('6', '6', '07:00:00', '19:00:00', '12', '13:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('7', '7', '08:00:00', '14:00:00', '6', '11:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('8', '8', '08:00:00', '16:00:00', '8', '12:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('9', '9', '08:00:00', '17:00:00', '9', '12:30:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('10', '10', '09:00:00', '17:00:00', '8', '13:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('11', '11', '09:00:00', '18:00:00', '9', '13:30:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('12', '12', '10:00:00', '18:00:00', '8', '14:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('13', '13', '11:00:00', '19:00:00', '8', '15:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('14', '14', '12:00:00', '20:00:00', '8', '16:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('15', '15', '14:00:00', '22:00:00', '8', '18:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('16', '16', '15:00:00', '22:00:00', '7', '18:30:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('17', '17', '15:00:00', '23:00:00', '8', '19:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('18', '18', '18:00:00', '06:00:00', '12', '12:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('19', '19', '19:00:00', '07:00:00', '12', '13:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('20', '20', '19:00:00', '23:00:00', '4', '21:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('21', '21', '21:00:00', '05:00:00', '8', '13:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('22', '22', '22:00:00', '06:00:00', '8', '14:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('23', '23', '22:00:00', '07:00:00', '9', '14:30:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('24', '24', '23:00:00', '07:00:00', '8', '15:00:00', null, null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('25', '25', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Cuti Istimewa', '1');
INSERT INTO `tbm_shift_setting` VALUES ('26', '26', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Cuti Keagamaan', '1');
INSERT INTO `tbm_shift_setting` VALUES ('27', '27', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Cuti Melahirkan', '1');
INSERT INTO `tbm_shift_setting` VALUES ('28', '28', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Cuti Menikah', '1');
INSERT INTO `tbm_shift_setting` VALUES ('29', '29', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Cuti Tahunan', '1');
INSERT INTO `tbm_shift_setting` VALUES ('30', '30', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Dinas', '1');
INSERT INTO `tbm_shift_setting` VALUES ('31', '31', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Izin', '1');
INSERT INTO `tbm_shift_setting` VALUES ('32', '32', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Lembur ', '1');
INSERT INTO `tbm_shift_setting` VALUES ('33', '33', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Libur', '1');
INSERT INTO `tbm_shift_setting` VALUES ('34', '34', '00:00:00', '00:00:00', '0', '00:00:00', null, 'Sakit', '1');
INSERT INTO `tbm_shift_setting` VALUES ('35', '1344', '09:30:00', '17:30:00', '7', '14:30:00', '15:30:00', null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('36', 'Kandir - Bulan Puasa', '08:00:00', '16:00:00', '7', '12:00:00', '13:00:00', null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('37', '2020', '08:00:00', '17:00:00', '8', '12:00:00', '13:00:00', null, '1');
INSERT INTO `tbm_shift_setting` VALUES ('38', 'Kantor, Gudang, Sortase & Timbangan', '07:00:00', '16:00:00', '7', '12:00:00', '14:00:00', null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('39', 'Proses Shift I', '07:00:00', '14:00:00', '7', '00:00:00', '00:00:00', null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('40', 'Proses Shift II', '14:00:00', '21:00:00', '7', '00:00:00', '00:00:00', null, '0');
INSERT INTO `tbm_shift_setting` VALUES ('41', 'Kandir', '08:00:00', '17:00:00', '7', '12:00:00', '14:00:00', null, '0');

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
INSERT INTO `tbm_user_group` VALUES ('3', 'Operator Timbangan', '0');
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
) ENGINE=InnoDB AUTO_INCREMENT=568 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_user_menu_group
-- ----------------------------
INSERT INTO `tbm_user_menu_group` VALUES ('1', '2', '2', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('2', '2', '3', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('3', '2', '5', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('4', '2', '6', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('6', '2', '9', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('7', '2', '11', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('8', '2', '12', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('9', '3', '2', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('10', '3', '3', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('11', '3', '5', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('12', '3', '6', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('14', '3', '9', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('15', '3', '11', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('16', '3', '12', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('17', '1', '2', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('18', '1', '3', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('19', '1', '5', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('20', '1', '6', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('22', '1', '9', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('23', '1', '11', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('24', '1', '12', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('25', '73', '2', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('26', '73', '3', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('27', '73', '5', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('28', '73', '6', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('30', '73', '9', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('31', '73', '11', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('32', '73', '12', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('33', '1', '14', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('34', '1', '15', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('35', '1', '16', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('36', '73', '14', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('37', '73', '15', '0', '0');
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
INSERT INTO `tbm_user_menu_group` VALUES ('55', '74', '9', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('56', '74', '11', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('57', '74', '12', '1', '0');
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
INSERT INTO `tbm_user_menu_group` VALUES ('135', '2', '58', '1', '0');
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
INSERT INTO `tbm_user_menu_group` VALUES ('149', '1', '81', '1', '0');
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
INSERT INTO `tbm_user_menu_group` VALUES ('167', '78', '36', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('168', '76', '59', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('169', '76', '58', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('170', '76', '29', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('171', '76', '5', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('172', '76', '9', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('173', '74', '70', '1', '0');
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
INSERT INTO `tbm_user_menu_group` VALUES ('198', '79', '55', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('199', '79', '81', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('200', '79', '82', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('201', '79', '70', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('202', '79', '71', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('203', '79', '75', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('204', '79', '58', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('205', '79', '59', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('206', '79', '12', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('207', '79', '57', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('208', '79', '56', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('209', '79', '60', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('210', '79', '61', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('211', '79', '62', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('212', '79', '62', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('213', '78', '28', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('214', '78', '6', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('215', '78', '33', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('216', '78', '33', '0', '0');
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
INSERT INTO `tbm_user_menu_group` VALUES ('275', '80', '73', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('276', '80', '74', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('277', '80', '75', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('278', '80', '76', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('279', '80', '77', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('280', '80', '78', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('281', '80', '79', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('282', '80', '80', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('283', '80', '81', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('284', '80', '82', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('285', '80', '83', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('286', '78', '69', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('287', '79', '76', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('288', '79', '16', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('289', '79', '48', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('290', '75', '27', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('291', '75', '3', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('292', '76', '71', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('293', '76', '18', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('294', '76', '37', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('295', '76', '16', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('296', '76', '76', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('297', '76', '27', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('298', '76', '27', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('299', '74', '60', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('300', '1', '86', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('301', '1', '84', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('302', '1', '85', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('303', '1', '87', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('304', '1', '88', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('305', '1', '89', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('306', '1', '90', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('307', '1', '91', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('308', '1', '92', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('309', '1', '93', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('310', '1', '83', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('311', '1', '94', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('312', '3', '94', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('313', '2', '74', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('314', '2', '14', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('315', '2', '25', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('316', '2', '98', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('317', '2', '15', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('318', '2', '98', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('319', '2', '100', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('320', '2', '71', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('321', '2', '34', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('322', '2', '70', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('323', '2', '97', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('324', '2', '34', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('325', '2', '35', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('326', '2', '36', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('327', '2', '65', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('328', '2', '39', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('329', '2', '38', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('330', '2', '66', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('331', '2', '40', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('332', '2', '55', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('333', '2', '41', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('334', '2', '94', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('335', '2', '96', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('336', '2', '73', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('337', '2', '86', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('338', '2', '42', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('339', '2', '72', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('340', '2', '7', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('341', '2', '101', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('342', '2', '53', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('343', '2', '69', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('344', '2', '52', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('345', '2', '53', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('346', '2', '54', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('347', '2', '78', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('348', '2', '79', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('349', '2', '80', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('350', '2', '95', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('351', '2', '84', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('352', '2', '75', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('353', '2', '91', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('354', '2', '92', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('355', '2', '84', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('356', '2', '67', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('357', '2', '93', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('358', '2', '81', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('359', '2', '82', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('360', '2', '59', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('361', '2', '76', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('362', '2', '85', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('363', '2', '87', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('364', '2', '88', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('365', '2', '90', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('366', '2', '89', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('367', '2', '83', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('368', '2', '50', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('369', '2', '51', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('370', '2', '103', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('371', '2', '104', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('372', '2', '30', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('373', '2', '68', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('374', '2', '77', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('375', '2', '37', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('376', '1', '98', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('377', '1', '98', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('378', '1', '100', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('379', '1', '96', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('380', '1', '100', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('381', '1', '96', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('382', '1', '97', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('383', '1', '96', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('384', '1', '97', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('385', '1', '96', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('386', '1', '95', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('387', '1', '103', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('388', '1', '104', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('389', '1', '103', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('390', '1', '101', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('391', '1', '7', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('392', '1', '101', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('393', '75', '7', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('394', '75', '101', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('395', '75', '85', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('396', '75', '58', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('397', '75', '59', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('398', '76', '101', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('399', '76', '7', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('400', '76', '30', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('401', '78', '84', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('402', '78', '5', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('403', '78', '103', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('404', '78', '104', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('405', '79', '98', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('406', '79', '98', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('407', '79', '100', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('408', '79', '36', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('409', '79', '35', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('410', '79', '34', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('411', '79', '97', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('412', '79', '65', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('413', '79', '39', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('414', '79', '66', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('415', '79', '41', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('416', '79', '95', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('417', '79', '84', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('418', '79', '91', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('419', '79', '92', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('420', '79', '93', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('421', '79', '85', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('422', '79', '87', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('423', '79', '88', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('424', '79', '89', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('425', '79', '90', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('426', '79', '63', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('427', '79', '64', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('428', '74', '92', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('429', '74', '91', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('430', '74', '93', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('431', '74', '81', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('432', '74', '58', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('433', '74', '67', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('434', '78', '94', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('435', '3', '103', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('436', '80', '103', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('437', '1', '105', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('438', '76', '6', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('439', '76', '28', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('440', '3', '7', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('441', '3', '14', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('442', '3', '15', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('443', '3', '16', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('444', '3', '18', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('445', '3', '25', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('446', '3', '27', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('447', '3', '29', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('448', '3', '30', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('449', '3', '32', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('450', '3', '33', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('451', '3', '34', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('452', '3', '35', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('453', '3', '37', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('454', '3', '38', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('455', '3', '39', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('456', '3', '40', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('457', '3', '41', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('458', '3', '42', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('459', '3', '43', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('460', '3', '44', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('461', '3', '45', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('462', '3', '46', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('463', '3', '48', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('464', '3', '50', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('465', '3', '51', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('466', '3', '52', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('467', '3', '53', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('468', '3', '54', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('469', '3', '55', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('470', '3', '56', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('471', '3', '57', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('472', '3', '58', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('473', '3', '59', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('474', '3', '60', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('475', '3', '61', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('476', '3', '62', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('477', '3', '63', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('478', '3', '64', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('479', '3', '65', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('480', '3', '66', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('481', '3', '67', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('482', '3', '68', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('483', '3', '69', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('484', '3', '70', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('485', '3', '72', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('486', '3', '73', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('487', '3', '74', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('488', '3', '75', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('489', '3', '76', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('490', '3', '77', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('491', '3', '78', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('492', '3', '79', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('493', '3', '80', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('494', '3', '81', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('495', '3', '82', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('496', '3', '83', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('497', '3', '84', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('498', '3', '85', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('499', '3', '86', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('500', '3', '87', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('501', '3', '88', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('502', '3', '89', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('503', '3', '90', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('504', '3', '91', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('505', '3', '92', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('506', '3', '93', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('507', '3', '95', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('508', '3', '96', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('509', '3', '97', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('510', '3', '98', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('511', '3', '100', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('512', '3', '101', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('513', '3', '104', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('514', '3', '105', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('515', '76', '69', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('516', '74', '100', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('517', '78', '35', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('518', '78', '35', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('519', '78', '71', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('520', '78', '100', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('521', '78', '92', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('522', '79', '96', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('523', '79', '96', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('524', '77', '86', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('525', '77', '87', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('526', '77', '88', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('527', '77', '89', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('528', '77', '90', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('529', '77', '83', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('530', '77', '50', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('531', '77', '50', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('532', '77', '50', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('533', '77', '51', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('534', '80', '100', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('535', '78', '106', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('536', '1', '106', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('537', '2', '105', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('538', '76', '85', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('539', '76', '91', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('540', '80', '95', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('541', '74', '61', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('542', '74', '62', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('543', '74', '63', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('544', '74', '64', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('545', '74', '64', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('546', '74', '98', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('547', '74', '86', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('548', '74', '48', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('549', '74', '42', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('550', '1', '108', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('551', '78', '108', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('552', '78', '98', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('553', '74', '108', '0', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('554', '74', '108', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('555', '1', '110', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('556', '1', '111', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('557', '1', '109', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('558', '79', '110', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('559', '79', '109', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('560', '79', '111', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('561', '1', '107', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('562', '1', '113', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('563', '1', '114', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('564', '1', '115', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('565', '1', '112', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('566', '1', '116', '1', '0');
INSERT INTO `tbm_user_menu_group` VALUES ('567', '1', '117', '1', '0');

-- ----------------------------
-- Table structure for tbt_bayar_rekap_gaji
-- ----------------------------
DROP TABLE IF EXISTS `tbt_bayar_rekap_gaji`;
CREATE TABLE `tbt_bayar_rekap_gaji` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no_pembayaran` varchar(60) DEFAULT NULL,
  `tgl_pembayaran` date DEFAULT NULL,
  `id_rekap` int(11) DEFAULT '0',
  `total_gaji_dibayarkan` decimal(36,2) DEFAULT NULL,
  `user` varchar(60) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_bayar_rekap_gaji
-- ----------------------------

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
  `no_surat_kuasa` varchar(60) DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbt_commodity_transaction
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_contract_sales
-- ----------------------------
DROP TABLE IF EXISTS `tbt_contract_sales`;
CREATE TABLE `tbt_contract_sales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` char(1) DEFAULT '0',
  `sales_no` varchar(60) DEFAULT NULL,
  `tgl_do` date DEFAULT NULL,
  `no_do` varchar(255) DEFAULT NULL,
  `no_surat_kuasa` varchar(255) DEFAULT NULL,
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_contract_sales
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbt_expense_transaction
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_harga_tbs_order
-- ----------------------------

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
  `nama_akun` varchar(255) DEFAULT NULL,
  `keterangan` varchar(80) DEFAULT NULL,
  `saldo` float(11,2) DEFAULT NULL,
  `saldo_akhir` float(11,2) DEFAULT NULL,
  `posisi_saldo_akhir` char(1) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_jurnal_buku_besar
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_jurnal_pembelian
-- ----------------------------
DROP TABLE IF EXISTS `tbt_jurnal_pembelian`;
CREATE TABLE `tbt_jurnal_pembelian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) DEFAULT NULL,
  `no_transaksi` varchar(60) DEFAULT NULL,
  `jns_transaksi` char(1) DEFAULT '0',
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT '00:00:00',
  `keterangan` varchar(255) DEFAULT NULL,
  `nama_akun` varchar(255) DEFAULT NULL,
  `ref` varchar(255) DEFAULT NULL,
  `jumlah` float(36,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_jurnal_pembelian
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_jurnal_penerimaan_kas
-- ----------------------------
DROP TABLE IF EXISTS `tbt_jurnal_penerimaan_kas`;
CREATE TABLE `tbt_jurnal_penerimaan_kas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) DEFAULT NULL,
  `no_transaksi` varchar(60) DEFAULT NULL,
  `jns_transaksi` char(1) DEFAULT '0',
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT '00:00:00',
  `keterangan` varchar(255) DEFAULT NULL,
  `nama_akun` varchar(255) DEFAULT NULL,
  `ref` varchar(255) DEFAULT NULL,
  `jumlah` float(36,2) DEFAULT NULL,
  `potongan` float(36,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_jurnal_penerimaan_kas
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_jurnal_pengeluaran_kas
-- ----------------------------
DROP TABLE IF EXISTS `tbt_jurnal_pengeluaran_kas`;
CREATE TABLE `tbt_jurnal_pengeluaran_kas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) DEFAULT NULL,
  `no_transaksi` varchar(60) DEFAULT NULL,
  `jns_transaksi` char(1) DEFAULT '0',
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT '00:00:00',
  `keterangan` varchar(255) DEFAULT NULL,
  `nama_akun` varchar(255) DEFAULT NULL,
  `ref` varchar(255) DEFAULT NULL,
  `jumlah` float(36,2) DEFAULT NULL,
  `potongan` float(36,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_jurnal_pengeluaran_kas
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_jurnal_penjualan
-- ----------------------------
DROP TABLE IF EXISTS `tbt_jurnal_penjualan`;
CREATE TABLE `tbt_jurnal_penjualan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) DEFAULT NULL,
  `no_transaksi` varchar(60) DEFAULT NULL,
  `jns_transaksi` char(1) DEFAULT '0',
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT '00:00:00',
  `keterangan` varchar(255) DEFAULT NULL,
  `syarat` varchar(255) DEFAULT NULL,
  `ref` varchar(0) DEFAULT NULL,
  `jumlah` float(36,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_jurnal_penjualan
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_jurnal_penyesuaian
-- ----------------------------
DROP TABLE IF EXISTS `tbt_jurnal_penyesuaian`;
CREATE TABLE `tbt_jurnal_penyesuaian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_penyesuaian` int(11) DEFAULT NULL,
  `jns_transaksi` char(1) DEFAULT '0',
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT '00:00:00',
  `keterangan` varchar(80) DEFAULT NULL,
  `jumlah_saldo` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_jurnal_penyesuaian
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_jurnal_umum
-- ----------------------------
DROP TABLE IF EXISTS `tbt_jurnal_umum`;
CREATE TABLE `tbt_jurnal_umum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) DEFAULT NULL,
  `sumber_transaksi` char(1) DEFAULT '0',
  `jns_transaksi` char(1) DEFAULT '0',
  `id_bank` int(11) DEFAULT NULL,
  `tgl_transaksi` date DEFAULT NULL,
  `wkt_transaksi` time DEFAULT '00:00:00',
  `no_transaksi` varchar(60) DEFAULT NULL,
  `keterangan` varchar(80) DEFAULT NULL,
  `jumlah_saldo` float(11,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_jurnal_umum
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_laba_rugi
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tbt_lembur_karyawan
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_mutasi_barang
-- ----------------------------

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
  `st_asset` char(1) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_mutasi_barang_detail
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_mutasi_kas
-- ----------------------------
DROP TABLE IF EXISTS `tbt_mutasi_kas`;
CREATE TABLE `tbt_mutasi_kas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tgl_transaksi` date DEFAULT NULL,
  `no_referensi` varchar(60) DEFAULT NULL,
  `id_bank_asal` int(11) DEFAULT NULL,
  `id_bank_tujuan` int(11) DEFAULT NULL,
  `deskripsi` varchar(100) DEFAULT NULL,
  `jumlah_mutasi` decimal(36,2) DEFAULT NULL,
  `biaya_admin` decimal(36,2) DEFAULT NULL,
  `total_mutasi` decimal(36,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbt_mutasi_kas
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_pembayaran_po
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_pembayaran_tbs
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_pembayaran_tbs_copy
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_penerimaan_penjualan
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_penerimaan_penjualan_detail
-- ----------------------------

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
-- Table structure for tbt_penyesuaian
-- ----------------------------
DROP TABLE IF EXISTS `tbt_penyesuaian`;
CREATE TABLE `tbt_penyesuaian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bulan` varchar(2) DEFAULT '0',
  `tahun` varchar(4) DEFAULT NULL,
  `status` char(1) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_penyesuaian
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_penyesuaian_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbt_penyesuaian_detail`;
CREATE TABLE `tbt_penyesuaian_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_penyesuaian` int(11) DEFAULT '0',
  `kelompok_akun` char(1) DEFAULT NULL,
  `jenis_saldo` char(1) DEFAULT NULL,
  `asal_saldo` int(11) DEFAULT NULL,
  `nama_akun` varchar(255) DEFAULT NULL,
  `nilai_akun` float(36,2) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_penyesuaian_detail
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbt_processing_product
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_processing_tbs
-- ----------------------------

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
  `id_bank` int(11) DEFAULT NULL,
  `id_coa` int(11) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_purchase_order
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_purchase_order_detail
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_receiving_order
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_receiving_order_detail
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_rekap_gaji
-- ----------------------------
DROP TABLE IF EXISTS `tbt_rekap_gaji`;
CREATE TABLE `tbt_rekap_gaji` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bulan` varchar(2) DEFAULT '0',
  `tahun` varchar(4) DEFAULT NULL,
  `total_gaji_dibayarkan` decimal(36,2) DEFAULT NULL,
  `status` char(1) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_rekap_gaji
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_rekap_gaji_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbt_rekap_gaji_detail`;
CREATE TABLE `tbt_rekap_gaji_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_rekap` int(11) DEFAULT '0',
  `id_bayar` int(11) DEFAULT NULL,
  `id_karyawan` int(11) DEFAULT NULL,
  `jml_gaji_dibayarkan` decimal(36,2) DEFAULT NULL,
  `jns_bayar` char(1) DEFAULT '0',
  `id_bank` int(11) DEFAULT NULL,
  `no_ref` varchar(60) DEFAULT NULL,
  `id_coa` int(11) DEFAULT NULL,
  `status` char(1) DEFAULT '0',
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_rekap_gaji_detail
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_rekap_neraca
-- ----------------------------
DROP TABLE IF EXISTS `tbt_rekap_neraca`;
CREATE TABLE `tbt_rekap_neraca` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bulan` varchar(2) DEFAULT '0',
  `tahun` varchar(4) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_rekap_neraca
-- ----------------------------

-- ----------------------------
-- Table structure for tbt_rekap_neraca_detail
-- ----------------------------
DROP TABLE IF EXISTS `tbt_rekap_neraca_detail`;
CREATE TABLE `tbt_rekap_neraca_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_rekap` int(11) DEFAULT '0',
  `kelompok_akun` char(1) DEFAULT NULL,
  `nama_akun` varchar(255) DEFAULT NULL,
  `nilai_akun` float(36,2) DEFAULT NULL,
  `deleted` char(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_rekap_neraca_detail
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_reporting_processing_tbs
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_request_order
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_request_order_detail
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 PACK_KEYS=0;

-- ----------------------------
-- Records of tbt_revenue_transaction
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_stok_in_out
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_tbs_order
-- ----------------------------

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbt_tbs_order_detail
-- ----------------------------

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
