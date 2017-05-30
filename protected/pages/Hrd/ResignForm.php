<?PHP
class ResignForm extends MainConf
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
			$this->BindKaryawan();
			
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','jQuery("#table-1 tbody").append("'.$tblBody.'");');
		}
	}
	
	public function BindKaryawan()
	{
		$sql = "SELECT id,nama FROM tbm_karyawan WHERE deleted = '0' AND aktif = '0' ";
			$this->id_karyawan->DataSource = $this->queryAction($sql,'S');
			$this->id_karyawan->DataBind();
	}
	
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_resign_employee.id,
					tbt_resign_employee.tgl_resign,
					tbt_resign_employee.kategori_resign,
					tbt_resign_employee.keterangan,
					tbm_karyawan.nama
				FROM
					tbt_resign_employee
				INNER JOIN tbm_karyawan ON tbm_karyawan.id = tbt_resign_employee.id_karyawan
				WHERE
					tbt_resign_employee.deleted = '0'
				ORDER BY 
					tbt_resign_employee.id ASC ";
		$arr = $this->queryAction($sql,'S');
		
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($arr as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_resign'],'3').'</td>';
				$tblBody .= '<td>'.$row['kategori_resign'].'</td>';
				$tblBody .= '<td>'.$row['keterangan'].'</td>';
				/*$tblBody .= '<td>';
				$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
				$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';	
				$tblBody .=	'</td>';	*/	
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
		$Record = RevenueTransactionRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->idRevenueTransaction->Value = $id;
			$this->tgl_transaksi->Text = $this->ConvertDate($Record->tgl_transaksi,'1');
			$this->no_referensi->text = $Record->no_referensi;
			$this->DDCategory->SelectedValue = $Record->revenue_category_id;
			$this->revenueCategoryChanged();
			$this->DDRevenue->SelectedValue = $Record->revenue_id;
			$this->deskripsi->Text = $Record->deskripsi;
			$this->DDBank->SelectedValue = $Record->bank_id;
			$this->total_revenue->text = $Record->total_revenue;
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
		$Record = RevenueTransactionRecord::finder()->findByPk($id);
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
		if($this->idResign->Value != '')
			$Record = ResignEmployeeRecord::finder()->findByPk($this->idResign->Value);
		else
		{
			$Record = new ResignEmployeeRecord();
		}
		
		$Record->tgl_resign = $this->ConvertDate($this->tgl_resign->Text,'2');
		$Record->id_karyawan = $this->id_karyawan->SelectedValue;
		$Record->kategori_resign = $this->kategori_resign->text;
		$Record->keterangan = $this->keterangan->text;
		$Record->save();
		
		$KaryawanRecord = KaryawanRecord::finder()->findByPk($this->id_karyawan->SelectedValue);
		$KaryawanRecord->aktif = '1';
		$KaryawanRecord->save();
		
		$tblBody = $this->BindGrid();
		$this->idResign->Value = "";	
		$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("Data Berhasil Disimpan");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						jQuery("a[href=\"#listTab\"]").tab("show");
						BindGrid();');	
		
		
	}
	public function cetakClicked()
	{
			$this->Response->redirect($this->Service->constructUrl('Hrd.cetakResignFormPdf'));
	}
}
?>
