<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class JurnalBukuBesarRecord extends TActiveRecord
{
	const TABLE='tbt_jurnal_buku_besar';

	public $id;
	public $id_transaksi;
	public $sumber_transaksi;
	public $jns_transaksi;
	public $tgl_transaksi;
	public $wkt_transaksi;
	public $keterangan;
	public $id_bank;
	public $no_transaksi;
	public $nama_akun;
	public $id_coa;
	public $saldo;
	public $saldo_akhir;
	public $posisi_saldo_akhir;
	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>
