<?php
/**
 * Auto generated by prado-cli.php on 2008-03-18 12:28:13.
 */
class ExpenseTransactionRecord extends TActiveRecord
{
	const TABLE='tbt_expense_transaction';

	public $id;
	public $transaction_no;
	public $tgl_transaksi;
	public $no_referensi;
	public $expense_category_id;
	public $expense_id;
	public $deskripsi;
	public $coa_id;
	public $bank_id;
	public $total_expense;
	public $deleted;
	
	public static function finder($className=__CLASS__)
	{
		return parent::finder($className);
	}
}
?>
