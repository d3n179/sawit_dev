<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class AktivaTetapRecord extends TActiveRecord
{
	const TABLE='tbm_aktiva_tetap';

	public $id;
	public $kode_akun;
	public $nama;
	public $tgl_perolehan;
	public $harga_perolehan;
	public $nilai_residu;
	public $umur_ekonomis;
	public $tgl_akhir_peggunaan;
	public $jumlah_aktiva;
	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>
