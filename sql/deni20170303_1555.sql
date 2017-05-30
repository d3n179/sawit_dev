ALTER TABLE `tbm_barang`
ADD COLUMN `min_stock`  float(11,2) NULL AFTER `kategori_id`,
ADD COLUMN `max_stock`  float(11,2) NULL AFTER `min_stock`,
ADD COLUMN `max_beli_bulanan`  float(11,2) NULL AFTER `max_stock`;

ALTER TABLE `tbt_purchase_order`
ADD COLUMN `ppn`  float(11,2) NULL AFTER `catatan`,
ADD COLUMN `dp`  float(11,2) NULL AFTER `ppn`;

ALTER TABLE `tbt_purchase_order_detail`
ADD COLUMN `discount`  float(11,2) NULL AFTER `harga_satuan`;

