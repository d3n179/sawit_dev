<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class TbsOrderRecord extends TActiveRecord
{
	const TABLE='tbt_tbs_order';

	public $id;
	public $no_tbs_order;
	public $id_pemasok;
	public $id_barang;
	public $tgl_transaksi;
	public $wkt_transaksi;
	public $tgl_jatuh_tempo;
	public $status;
	public $deleted;
	
	


	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>
