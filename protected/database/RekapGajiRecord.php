<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class RekapGajiRecord extends TActiveRecord
{
	const TABLE='tbt_rekap_gaji';

	public $id;
	public $bulan;
	public $tahun;
	public $total_gaji_dibayarkan;
	public $status;
	
	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>
