<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class ContractSalesRecord extends TActiveRecord
{
	const TABLE='tbt_contract_sales';

	public $id;
	public $status;
	public $sales_no;
	public $commodity_type;
	public $id_pembeli;
	public $alamat_pembeli;
	public $npwp;
	public $tgl_kontrak;
	public $tgl_jatuh_tempo;
	public $quantity;
	public $delivered_quantity;
	public $satuan_commodity;
	public $quality;
	public $pricing;
	public $delivery;
	public $term_of_payment;
	public $remark;
	public $tgl_do;
	public $no_do;
	public $no_surat_kuasa;


	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>
