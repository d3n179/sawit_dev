<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class BpjsKaryawanRecord extends TActiveRecord
{
	const TABLE='tbm_bpjs_karyawan';

	public $id;
	
	public $id_karyawan;
	public $jns_bpjs;
	public $jumlah_upah;
	public $perusahaan;
	public $karyawan;
	public $tambahan_keluarga;
	public $total_bpjs;
	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>