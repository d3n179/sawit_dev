<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class KendaraanPemasokRecord extends TActiveRecord
{
	const TABLE='tbm_kendaraan_pemasok';

	public $id;
	public $id_pemasok;
	public $id_jenis_kendaraan;
	public $no_polisi;
	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>
