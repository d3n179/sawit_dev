<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class IncentiveRecord extends TActiveRecord
{
	const TABLE='tbt_incentive';

	public $id;
	public $id_karyawan;
	public $bulan;
	public $tahun;
	public $jml_incentive;
	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>
