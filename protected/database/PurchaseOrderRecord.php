<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class PurchaseOrderRecord extends TActiveRecord
{
	const TABLE='tbt_purchase_order';

	public $id;
	public $status;
	public $no_po;
	public $id_ro;
	public $tgl_po;
	public $tgl_jatuh_tempo;
	public $catatan;
	public $id_supplier;
	public $ppn;
	public $dp;
	
	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>
