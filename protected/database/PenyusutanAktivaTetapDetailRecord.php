<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class PenyusutanAktivaTetapDetailRecord extends TActiveRecord
{
	const TABLE='tbd_penyusutan_aktiva_detail';

	public $id;
	public $id_penyusutan;
	public $tahun;
	public $bulan;
	public $nilai_penyusutan_bulanan;
	public $jumlah_hari;
	public $nilai_penyusutan_harian;

	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>