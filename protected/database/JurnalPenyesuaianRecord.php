<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class JurnalPenyesuaianRecord extends TActiveRecord
{
	const TABLE='tbt_jurnal_penyesuaian';

	public $id;
	public $id_penyesuaian;
	public $jns_transaksi;
	public $tgl_transaksi;
	public $wkt_transaksi;
	public $keterangan;
	public $jumlah_saldo;
	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>