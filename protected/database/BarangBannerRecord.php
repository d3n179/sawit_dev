<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class BarangBannerRecord extends TActiveRecord
{
	const TABLE='tbm_barang_banner';

	public $id;
	public $id_parent_barang;
	public $id_barang;
	public $jml;
	
	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>
