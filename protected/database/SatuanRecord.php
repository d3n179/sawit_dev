<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class SatuanRecord extends TActiveRecord
{
	const TABLE='tbm_satuan';

	public $id;
	public $nama;
	public $singkatan;

	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>
