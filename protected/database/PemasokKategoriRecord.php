<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class PemasokKategoriRecord extends TActiveRecord
{
	const TABLE='tbm_kategori_pemasok';

	public $id;
	public $jenis_kategori;
	public $nama;
	public $ppn;
	public $pph;
	
	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>
