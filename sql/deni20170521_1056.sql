ALTER TABLE `tbm_karyawan`
ADD COLUMN `id_golongan`  int(11) NULL AFTER `id_jabatan`,
ADD COLUMN `id_ptkp`  char(1) DEFAULT 0 AFTER `id_golongan`,
ADD COLUMN `tunjangan_natura`  float(11,0) NULL AFTER `posisi_dinas`,
ADD COLUMN `tambahan_keluarga`  int(11) NULL AFTER `st_bpjs_ketenagakerjaan`;

ALTER TABLE `tbm_jadwal`
ADD COLUMN `st_telat`  char(1) NULL DEFAULT 0 AFTER `st`;

ALTER TABLE `tbm_jabatan`
ADD COLUMN `tunjangan_jabatan`  float(11,0) NULL AFTER `jatah_cuti`;

/*
Navicat MySQL Data Transfer

Source Server         : LOCALHOST
Source Server Version : 50555
Source Host           : localhost:3306
Source Database       : sawit

Target Server Type    : MYSQL
Target Server Version : 50555
File Encoding         : 65001

Date: 2017-05-22 03:28:54
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=InnoDB AUTO_INCREMENT=84 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tbm_menu
-- ----------------------------
INSERT INTO `tbm_menu` VALUES ('1', '0', 'Master Data', null, 'entypo-cog', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('2', '69', 'Master Product', 'Master.MasterBarang', '', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('3', '69', 'Master Unit', 'Master.MasterSatuan', '', '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('5', '71', 'Master Customer', 'Master.MasterPelanggan', '', '1', '6', '0');
INSERT INTO `tbm_menu` VALUES ('6', '71', 'Master Supplier', 'Master.MasterPemasok', '', '1', '7', '0');
INSERT INTO `tbm_menu` VALUES ('7', '0', 'Transaction', null, 'entypo-basket', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('8', '7', 'Sales Order', 'Transaksi.Penjualan', null, '0', '1', '1');
INSERT INTO `tbm_menu` VALUES ('9', '7', 'Purchase Order', 'Transaksi.PurchaseOrder', null, '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('10', '0', 'Reporting', null, 'entypo-doc-text', '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('11', '10', 'Sales Report', 'Laporan.LaporanPenjualan', null, '0', '1', '1');
INSERT INTO `tbm_menu` VALUES ('12', '10', 'Laporan Timbangan', 'Laporan.LaporanTimbangan', null, '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('13', '0', 'Admin', null, 'entypo-user', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('14', '13', 'User Group', 'Admin.UserGroup', null, '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('15', '13', 'User Admin', 'Admin.UserAdmin', null, '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('16', '17', 'Stock Card', 'Inventory.KartuStok', null, '1', '1', '0');
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
INSERT INTO `tbm_menu` VALUES ('27', '69', 'Master Categori Product', 'Master.MasterKategoriBarang', '', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('28', '71', 'Master Category Supplier', 'Master.MasterKategoriPemasok', '', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('29', '71', 'Master Category Customer', 'Master.MasterKategoriPelanggan', '', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('30', '7', 'Request Order', 'Transaksi.RequestOrder', null, '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('31', '0', 'Finance', null, 'entypo-chart-line', '1', '7', '0');
INSERT INTO `tbm_menu` VALUES ('32', '69', 'Setting Komidel', 'Setting.SettingKomidel', '', '1', '8', '0');
INSERT INTO `tbm_menu` VALUES ('33', '69', 'Setting Kendaraan', 'Setting.JenisKendaraan', '', '1', '9', '0');
INSERT INTO `tbm_menu` VALUES ('34', '31', 'Admin Request Order', 'Transaksi.AdminRequestOrder', null, '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('35', '31', 'Pembayaran TBS', 'Keuangan.BayarTbsOrder', null, '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('36', '7', 'Tbs Order', 'Transaksi.TbsOrder', null, '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('37', '17', 'Receiving Order', 'Inventory.ReceivingOrder', null, '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('38', '31', 'Setting Harga Transaksi', 'Keuangan.SettingHargaTbsOrder', null, '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('39', '7', 'Kontrak Penjualan', 'Transaksi.ContractSales', null, '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('40', '17', 'Processing TBS', 'Inventory.ProcessingTbs', null, '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('41', '31', 'Pembayaran PO', 'Keuangan.BayarPo', null, '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('42', '49', 'Master Data HRD', '', 'entypo-users', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('43', '42', 'Master Cabang', 'Master.MasterKantorCabang', null, '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('44', '42', 'Master Department', 'Master.MasterDepartment', null, '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('45', '42', 'Master Karyawan', 'Master.MasterKaryawan', null, '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('46', '42', 'Master Jabatan', 'Master.MasterJabatan', null, '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('47', '42', 'Master Level Distribusi', 'Master.MasterLevelDistribusi', null, '1', '5', '1');
INSERT INTO `tbm_menu` VALUES ('48', '42', 'Rekap Gaji Karyawan', 'Hrd.LaporanRekapGajiKaryawan', null, '1', '6', '0');
INSERT INTO `tbm_menu` VALUES ('49', '0', 'HRD', null, 'entypo-suitcase', '1', '8', '0');
INSERT INTO `tbm_menu` VALUES ('50', '72', 'Shift Setting', 'Hrd.ShiftSetting', '', '1', '1', '0');
INSERT INTO `tbm_menu` VALUES ('51', '72', 'Jadwal Karyawan', 'Hrd.JadwalShiftKaryawan', '', '1', '2', '0');
INSERT INTO `tbm_menu` VALUES ('52', '73', 'Incentive Karyawan', 'Hrd.IncentiveTransaction', '', '1', '4', '0');
INSERT INTO `tbm_menu` VALUES ('53', '73', 'Expense Karyawan', 'Hrd.ExpenseKaryawan', '', '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('54', '73', 'Absensi Karyawan', 'Hrd.AbsensiKaryawan', '', '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('55', '31', 'Penerimaan Penjualan', 'Keuangan.PenerimaanJual', null, '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('56', '70', 'Master Group Coa', 'Master.MasterGroupCoa', '', '1', '10', '0');
INSERT INTO `tbm_menu` VALUES ('57', '70', 'Master Coa', 'Master.MasterCoa', '', '1', '11', '0');
INSERT INTO `tbm_menu` VALUES ('58', '10', 'Laporan Purchase Order', 'Laporan.LaporanPurchaseOrder', null, '1', '6', '0');
INSERT INTO `tbm_menu` VALUES ('59', '10', 'Laporan Request Order', 'Laporan.LaporanRequestOrder', null, '1', '7', '0');
INSERT INTO `tbm_menu` VALUES ('60', '70', 'Master Bank', 'Master.MasterBank', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('61', '70', 'Master Expense Category', 'Master.MasterExpenseCategory', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('62', '70', 'Master Expense', 'Master.MasterExpense', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('63', '70', 'Master Revenue Category', 'Master.MasterRevenueCategory', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('64', '70', 'Master Revenue', 'Master.MasterRevenue', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('65', '7', 'Expense Transaction', 'Keuangan.ExpenseTransaction', null, '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('66', '7', 'Revenue Transaction', 'Keuangan.RevenueTransaction', null, '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('67', '31', 'Buku Kas', 'Keuangan.BukuKas', null, '1', '6', '0');
INSERT INTO `tbm_menu` VALUES ('68', '17', 'Production Product', 'Inventory.ProductionProduct', null, '1', '5', '0');
INSERT INTO `tbm_menu` VALUES ('69', '17', 'Master Data Product', '', 'entypo-archive', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('70', '31', 'Master Data Transaction', '', 'entypo-switch', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('71', '31', 'Master Data Business Partner', '', 'entypo-briefcase', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('72', '49', 'Setting Absensi', '', 'entypo-layout', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('73', '49', 'Kegiatan Karyawan', '', 'entypo-github', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('74', '13', 'Admin Menu', 'Admin.MenuAdmin', null, '1', '3', '0');
INSERT INTO `tbm_menu` VALUES ('75', '31', 'Laporan Hutang', 'Keuangan.LaporanHutang', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('76', '17', 'Laporan Pemakaian', 'Inventory.LaporanPemakaian', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('77', '17', 'Stock Opname', 'Inventory.StockOpname', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('78', '73', 'Lembur Karyawan', 'Hrd.LemburKaryawan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('79', '73', 'Jadwal Per Karyawan', 'Hrd.JadwalPerKaryawan', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('80', '73', 'Resign Karyawan', 'Hrd.ResignForm', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('81', '31', 'Laporan Laba Rugi', 'Keuangan.LaporanLabaRugi', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('82', '31', 'Laporan Jurnal Umum', 'Keuangan.LaporanJurnalUmum', '', '1', null, '0');
INSERT INTO `tbm_menu` VALUES ('83', '42', 'Master Golongan Karyawan', 'Master.MasterGolongan', '', '1', null, '0');


/*
Navicat MySQL Data Transfer

Source Server         : LOCALHOST
Source Server Version : 50555
Source Host           : localhost:3306
Source Database       : sawit

Target Server Type    : MYSQL
Target Server Version : 50555
File Encoding         : 65001

Date: 2017-05-21 17:34:09
*/

SET FOREIGN_KEY_CHECKS=0;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
