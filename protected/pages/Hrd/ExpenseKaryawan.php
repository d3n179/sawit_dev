<?PHP
class ExpenseKaryawan extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$sqlKaryawan = "SELECT id, nama FROM tbm_karyawan WHERE deleted ='0' ";
			$arrKaryawan = $this->queryAction($sqlKaryawan,'S');
			$this->DDKaryawan->DataSource = $arrKaryawan;
			$this->DDKaryawan->DataBind();
			
		}
		
	}
	
	public function onPreRender($param)
	{
		parent::onPreRender($param);
		
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#table-1 tbody").append("'.$tblBody.'");');	
		}
	}
	
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_expense_karyawan.id,
					tbm_karyawan.nama AS karyawan,
					tbt_expense_karyawan.tgl ,
					tbt_expense_karyawan.jns_expense,
					tbt_expense_karyawan.jml_expense
				FROM
					tbt_expense_karyawan
				INNER JOIN tbm_karyawan ON tbm_karyawan.id = tbt_expense_karyawan.id_karyawan
				WHERE
					tbt_expense_karyawan.deleted = '0'
				ORDER BY 
					tbt_expense_karyawan.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
				if($row['jns_expense'] == '1')
					$jnsExpense = 'Pinjaman';
				elseif($row['jns_expense'] == '2')
					$jnsExpense = 'Kantin';
				elseif($row['jns_expense'] == '3')
					$jnsExpense = 'Koperasi';
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['karyawan'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl'],'3').'</td>';
				$tblBody .= '<td>'.$jnsExpense.'</td>';
				$tblBody .= '<td>'.number_format($row['jml_expense'],2,'.','.').'</td>';
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
		$Record = ExpenseKaryawanRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Expense Karyawan';
			$this->idExpenseKaryawan->Value = $id;
			$this->DDKaryawan->SelectedValue = $Record->id_karyawan;
			$this->tgl_expense->Text = $this->ConvertDate($Record->tgl,'1');
			$this->DDJenisExpense->SelectedValue = $Record->jns_expense;
			$this->jml_expense->Text = $Record->jml_expense;
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					jQuery("#modal-1").modal("show");
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
		$Record = ExpenseKaryawanRecord::finder()->findByPk($id);
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
			if($this->idExpenseKaryawan->Value != '')
			{
				$Record = ExpenseKaryawanRecord::finder()->findByPk($this->idExpenseKaryawan->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new ExpenseKaryawanRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$Record->id_karyawan = $this->DDKaryawan->SelectedValue;
			$Record->tgl = $this->ConvertDate($this->tgl_expense->Text,'2');
			$Record->jns_expense = $this->DDJenisExpense->SelectedValue;
			$Record->jml_expense = $this->jml_expense->Text;
			$Record->save(); 
			
			$tblBody = $this->BindGrid();
			
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("'.$msg.'");
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						clearForm();
						BindGrid();');	
		
		
	}
	
	public function clearForm()
	{
	}
	
	public function cetakClicked()
	{
		$this->Response->redirect($this->Service->constructUrl('Hrd.cetakSanksiTransactionPdf'));
	}
}
?>
