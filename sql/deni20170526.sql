ALTER TABLE `tbm_kategori_barang`
ADD COLUMN `id_coa`  int(11) NULL AFTER `nama`;

ALTER TABLE `tbm_barang`
ADD COLUMN `kelompok_id`  char(1) NULL DEFAULT 0 AFTER `kategori_id`;

