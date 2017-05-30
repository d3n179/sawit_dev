ALTER TABLE `tbt_pembayaran_po`
ADD COLUMN `jns_bayar`  char(1) NULL DEFAULT 0 AFTER `id_coa`,
ADD COLUMN `id_bank`  int(11) NULL AFTER `jns_bayar`,
ADD COLUMN `no_ref`  varchar(60) NULL AFTER `id_bank`;

ALTER TABLE `tbt_pembayaran_tbs`
ADD COLUMN `id_coa`  int(11) NULL AFTER `total_tbs_order`,
ADD COLUMN `jns_bayar`  char(1) NULL DEFAULT 0 AFTER `id_coa`,
ADD COLUMN `id_bank`  int(11) NULL AFTER `jns_bayar`,
ADD COLUMN `no_ref`  varchar(60) NULL AFTER `id_bank`;



