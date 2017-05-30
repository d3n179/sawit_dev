<?PHP
class MasterSatuan extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		
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
		$SatuanRecord = SatuanRecord::finder()->findAll('deleted = ? ORDER BY id ASC','0');
		
		$count = count($SatuanRecord);
		$tblBody = '';
		if($count > 0)
		{
			foreach($SatuanRecord as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row->nama.'</td>';
				$tblBody .= '<td>'.$row->singkatan.'</td>';
				$tblBody .= '<td>';
				$tblBody .= '<a href=\"#\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row->id.')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
				$tblBody .= '<a href=\"#\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row->id.')\"><i class=\"entypo-cancel\"></i>Delete</a>';				
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
		$SatuanRecord = SatuanRecord::finder()->findByPk($id);
		if($SatuanRecord)
		{
			$this->modalJudul->Text = 'Edit Satuan';
			$this->idSatuan->Value = $id;
			$this->nama->Text = $SatuanRecord->nama;
			$this->singkatan->Text = $SatuanRecord->singkatan;
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
		$SatuanRecord = SatuanRecord::finder()->findByPk($id);
		if($SatuanRecord)
		{
			$SatuanRecord->deleted = '1';
			$SatuanRecord->save();
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
		$nama = trim($this->nama->Text);
		$singkatan = trim($this->singkatan->Text);
		
		if($this->idSatuan->Value != '')
		{
			$SatuanRecord = SatuanRecord::finder()->findByPk($this->idSatuan->Value);
			$msg = "Data Berhasil Diedit";
		}
		else
		{
			$SatuanRecord = new SatuanRecord();
			$msg = "Data Berhasil Disimpan";
		}
		
		$SatuanRecord->nama = $nama;
		$SatuanRecord->singkatan = $singkatan;
		$SatuanRecord->save(); 
		
		$this->nama->Text = '';
		$this->singkatan->Text = '';
		
		$SatuanRecord = SatuanRecord::finder()->findAll('deleted = ?','0');
		$tblBody = $this->BindGrid();
		
		$this->getPage()->getClientScript()->registerEndScript
					('','
					toastr.info("'.$msg.'");
					jQuery("#modal-1").modal("hide");
					jQuery("#table-1").dataTable().fnDestroy();
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					BindGrid();');	
	}
	
}
?>
