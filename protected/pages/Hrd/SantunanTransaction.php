<?PHP
class SantunanTransaction extends MainConf
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
			
			$sqlSantunan = "SELECT id, globaldistribusi AS nama FROM tbm_payrol WHERE deleted ='0' AND subkategori = '3' ";
			$arrSantunan = $this->queryAction($sqlSantunan,'S');
			$this->DDSantunan->DataSource = $arrSantunan;
			$this->DDSantunan->DataBind();
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
					tbt_santunan.id,
					tbm_karyawan.nama AS karyawan,
					tbm_payrol.globaldistribusi AS santunan,
					tbt_santunan.tgl_santunan
				FROM
					tbt_santunan
				INNER JOIN tbm_karyawan ON tbm_karyawan.id = tbt_santunan.id_karyawan
				INNER JOIN tbm_payrol ON tbm_payrol.id = tbt_santunan.id_payroll
				WHERE
					tbt_santunan.deleted = '0'
				ORDER BY 
					tbt_santunan.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['karyawan'].'</td>';
				$tblBody .= '<td>'.$row['santunan'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_santunan'],'3').'</td>';
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
		$Record = SantunanRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Santunan';
			$this->idSantunan->Value = $id;
			$this->DDKaryawan->SelectedValue = $Record->id_karyawan;
			$this->DDSantunan->SelectedValue = $Record->id_payroll;
			$this->tglSantunan->Text = $this->ConvertDate($Record->tgl_santunan,'1');
			
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
		$Record = SantunanRecord::finder()->findByPk($id);
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
			if($this->idSantunan->Value != '')
			{
				$Record = SantunanRecord::finder()->findByPk($this->idSantunan->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new SantunanRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$Record->id_karyawan = $this->DDKaryawan->SelectedValue;
			$Record->id_payroll = $this->DDSantunan->SelectedValue;
			$Record->tgl_santunan = $this->ConvertDate($this->tglSantunan->Text,'2');
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
		$this->Response->redirect($this->Service->constructUrl('Hrd.cetakSantunanTransactionPdf'));
	}
}
?>
