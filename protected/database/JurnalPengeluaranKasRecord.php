<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class JurnalPengeluaranKasRecord extends TActiveRecord
{
	const TABLE='tbt_jurnal_pengeluaran_kas';

	public $id;
	public $id_transaksi;
	public $no_transaksi;
	public $jns_transaksi;
	public $tgl_transaksi;
	public $wkt_transaksi;
	public $keterangan;
	public $nama_akun;
	public $ref;
	public $jumlah;
	public $potongan;
	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>
