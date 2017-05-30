<?PHP
class SanksiTransaction extends MainConf
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
			
			$sqlSanksi = "SELECT id, globaldistribusi AS nama FROM tbm_payrol WHERE deleted ='0' AND subkategori = '7' ";
			$arrSanksi = $this->queryAction($sqlSanksi,'S');
			$this->DDSanksi->DataSource = $arrSanksi;
			$this->DDSanksi->DataBind();
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
					tbt_sanksi.id,
					tbm_karyawan.nama AS karyawan,
					tbm_payrol.globaldistribusi AS sanksi,
					tbt_sanksi.tgl_sanksi
				FROM
					tbt_sanksi
				INNER JOIN tbm_karyawan ON tbm_karyawan.id = tbt_sanksi.id_karyawan
				INNER JOIN tbm_payrol ON tbm_payrol.id = tbt_sanksi.payroll_id
				WHERE
					tbt_sanksi.deleted = '0'
				ORDER BY 
					tbt_sanksi.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['karyawan'].'</td>';
				$tblBody .= '<td>'.$row['sanksi'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_sanksi'],'3').'</td>';
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
		$Record = SanksiRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Sanksi';
			$this->idSanksi->Value = $id;
			$this->DDKaryawan->SelectedValue = $Record->id_karyawan;
			$this->DDSanksi->SelectedValue = $Record->payroll_id;
			$this->tglSanksi->Text = $this->ConvertDate($Record->tgl_sanksi,'1');
			
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
		$Record = SanksiRecord::finder()->findByPk($id);
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
			if($this->idSanksi->Value != '')
			{
				$Record = SanksiRecord::finder()->findByPk($this->idSanksi->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new SanksiRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$Record->id_karyawan = $this->DDKaryawan->SelectedValue;
			$Record->payroll_id = $this->DDSanksi->SelectedValue;
			$Record->tgl_sanksi = $this->ConvertDate($this->tglSanksi->Text,'2');
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
