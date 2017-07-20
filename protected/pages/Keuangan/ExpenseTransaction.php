<?PHP
class ExpenseTransaction extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			
		}
		
	}
	
	
	public function onPreRender($param)
	{
		parent::onPreRender($param);
		
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$sql = "SELECT id,nama FROM tbm_expense_category WHERE deleted = '0' ";
			$this->DDCategory->DataSource = $this->queryAction($sql,'S');
			$this->DDCategory->DataBind();
			
			$sql = "SELECT id, nama FROM tbm_bank WHERE deleted != '1' ";
			$this->DDBank->DataSource = $this->queryAction($sql,'S');
			$this->DDBank->DataBind();
			
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','jQuery("#table-1 tbody").append("'.$tblBody.'");');
		}
	}
	
	public function expenseCategoryChanged()
	{
		$idCategoryExpense = $this->DDCategory->SelectedValue;
		
		if($idCategoryExpense != '')
		{
			$sql = "SELECT id,nama FROM tbm_expense WHERE deleted = '0' AND expense_category_id = '$idCategoryExpense' ";
			$this->DDExpense->DataSource = $this->queryAction($sql,'S');
			$this->DDExpense->DataBind();
			$this->DDExpense->Enabled = true;
		}
		else
		{
			$this->DDExpense->SelectedValue = 'empty';
			$this->DDExpense->Enabled = false;
		}
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_expense_transaction.id,
					tbt_expense_transaction.transaction_no,
					tbt_expense_transaction.tgl_transaksi,
					tbt_expense_transaction.no_referensi,
					tbm_expense.nama AS nama_expense,
					tbt_expense_transaction.deskripsi,
					tbm_bank.nama AS nama_bank,
					tbt_expense_transaction.total_expense,
					tbt_expense_transaction.deleted
				FROM
					tbt_expense_transaction
				INNER JOIN tbm_expense ON tbm_expense.id = tbt_expense_transaction.expense_id
				INNER JOIN tbm_bank ON tbm_bank.id = tbt_expense_transaction.bank_id
				WHERE
					tbt_expense_transaction.deleted = '0'
				ORDER BY 
					tbt_expense_transaction.id ASC ";
		$arr = $this->queryAction($sql,'S');
		
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($arr as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['transaction_no'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_transaksi'],'3').'</td>';
				$tblBody .= '<td>'.$row['no_referensi'].'</td>';
				$tblBody .= '<td>'.$row['nama_expense'].'</td>';
				$tblBody .= '<td>'.$row['nama_bank'].'</td>';
				$tblBody .= '<td>'.number_format($row['total_expense'],2,".",",").'</td>';
				$tblBody .= '<td>';
				$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
				$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';	
				$tblBody .=	'</td>';		
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = '';
		}
		return 	$tblBody;
	}

	public function editForm($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$Record = ExpenseTransactionRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->idExpenseTransaction->Value = $id;
			$this->tgl_transaksi->Text = $this->ConvertDate($Record->tgl_transaksi,'1');
			$this->no_referensi->text = $Record->no_referensi;
			$this->DDCategory->SelectedValue = $Record->expense_category_id;
			$this->expenseCategoryChanged();
			$this->DDExpense->SelectedValue = $Record->expense_id;
			$this->deskripsi->Text = $Record->deskripsi;
			$this->DDBank->SelectedValue = $Record->bank_id;
			$this->total_expense->text = $Record->total_expense;
			$this->DDCoa->text = $Record->coa_id;
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					bindSelect2();
					jQuery("a[href=\"#formTab\"]").tab("show").empty().append("<i class=\"fa fa-pencil\"></i> Edit");
					');	
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					toastr.error("Data Tidak Ditemukan");
					');	
		}
	}
	
	public function deleteData($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$Record = ExpenseTransactionRecord::finder()->findByPk($id);
		if($Record)
		{
			$Record->deleted = '1';
			$Record->save();
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
					('','
					toastr.info("Data Telah Dihapus");
					jQuery("#table-1").dataTable().fnDestroy();
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					BindGrid();
					unloadContent();
					');
		}
		else
		{
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					toastr.error("Data gagal Dihapus");
					');
		}
	}
	
	public function submitBtnClicked($sender,$param)
	{
		if($this->idExpenseTransaction->Value != '')
			$Record = ExpenseTransactionRecord::finder()->findByPk($this->idExpenseTransaction->Value);
		else
		{
			$Record = new ExpenseTransactionRecord();
			$Record->transaction_no = $this->GenerateNoDocument('EXP');
		}
		
		$Record->tgl_transaksi = $this->ConvertDate($this->tgl_transaksi->Text,'2');
		$Record->no_referensi = $this->no_referensi->text;
		$Record->expense_category_id = $this->DDCategory->SelectedValue;
		$Record->expense_id = $this->DDExpense->SelectedValue;
		$Record->deskripsi = $this->deskripsi->text;
		$Record->bank_id = $this->DDBank->SelectedValue;
		$Record->total_expense = str_replace(",","",$this->total_expense->text);
		$Record->coa_id = $this->DDCoa->text;
		$Record->save();
		
		$this->InsertJurnalBukuBesar($Record->id,
										'4',
										'1',
										$Record->transaction_no,
										$Record->tgl_transaksi,
										date("G:i:s"),
										$Record->coa_id,
										$Record->bank_id,
										$Record->deskripsi,
										$Record->total_expense);
		
		$this->InsertLabaRugi($Record->id,
								'4',
								'1',
								$Record->tgl_transaksi,
								date("G:i:s"),
								$Record->deskripsi,
								$Record->total_expense,
								$Record->transaction_no);
		
		$this->InsertJurnalUmum($Record->id,
								'7',
								'0',
								$Record->tgl_transaksi,
								date("G:i:s"),
								$Record->deskripsi,
								$Record->total_expense,
								$Record->transaction_no);
									
		$this->InsertJurnalUmum($Record->id,
									'7',
									'1',
									$Record->tgl_transaksi,
									date("G:i:s"),
									'Kas',
									$Record->total_expense,
									$Record->transaction_no,
									$Record->bank_id);
									
		$tblBody = $this->BindGrid();
		$this->idExpenseTransaction->Value = "";	
		$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("Data Berhasil Disimpan");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						jQuery("a[href=\"#listTab\"]").tab("show");
						BindGrid();');	
		
		
	}
	
}
?>
