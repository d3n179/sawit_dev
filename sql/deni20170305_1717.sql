ALTER TABLE `tbt_receiving_order_detail`
ADD COLUMN `discount`  float(11,2) NULL AFTER `harga_satuan`;

ALTER TABLE `tbt_receiving_order`
ADD COLUMN `no_faktur`  varchar(60) NULL AFTER `no_document`;



