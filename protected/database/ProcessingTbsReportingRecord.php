<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class ProcessingTbsReportingRecord extends TActiveRecord
{
	const TABLE='tbt_reporting_processing_tbs';

	public $id;
	public $id_processing;
	public $tbs_kebun_sum;
	public $tbs_luar_sum;
	public $tbs_potongan_sum;
	public $tbs_persediaan_sum;
	public $tbs_olah_netto_sum;
	public $tbs_olah_brutto_sum;
	public $kirim_cpo_sum;
	public $kirim_pk_sum;
	public $kirim_cangkang_sum;
	public $kirim_fibre_sum;
	public $kirim_limbah_sum;
	public $kirim_jangkos_sum;
	public $jam_olah_tbs_sum;
	public $jam_olah_nut_sum;
	public $jam_main_sum;
	public $jam_down_sum;
	public $cpo_sum;
	public $pk_sum;
	public $reject_cpo_sum;
	public $reject_kernel_sum;



	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>
