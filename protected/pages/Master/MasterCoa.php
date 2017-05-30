<?PHP
class MasterCoa extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$sqlGroup = "SELECT id,CONCAT(kode_group,' - ',nama) AS nama FROM tbm_coa_kodrek_group WHERE deleted ='0' ";
			$arrGroup = $this->queryAction($sqlGroup,'S');
			$this->DDGroup->DataSource = $arrGroup;
			$this->DDGroup->DataBind();
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
					tbm_coa.id,
					tbm_coa.nama,
					tbm_coa.kode_coa,
					tbm_coa.id_group_coa
				FROM 
					tbm_coa
				WHERE 
					tbm_coa.deleted = '0' 
				ORDER BY 
					tbm_coa.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
				if($row['id_group_coa'] != '')
					$GrouCoaName =  GroupCoaRecord::finder()->findByPk($row['id_group_coa'])->nama;
				else
					$GrouCoaName =  'Lain-lain';
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$GrouCoaName.'</td>';
				$tblBody .= '<td>'.$row['kode_coa'].'</td>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
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
		$Record = CoaRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Coa';
			$this->idCoa->Value = $id;
			$this->nama->Text = $Record->nama;
			$this->kodeCoa->Text = $Record->kode_coa;
			$this->DDGroup->SelectedValue = $Record->id_group_coa;
			$show = '.hide()';
			
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
		$Record = CoaRecord::finder()->findByPk($id);
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
		$nama = trim($this->nama->Text);
		$kodeCoa = trim($this->kodeCoa->Text);
		$groupCoa = $this->DDGroup->SelectedValue;
			if($this->idCoa->Value != '')
			{
				$Record = CoaRecord::finder()->findByPk($this->idCoa->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new CoaRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$Record->nama = $nama;
			$Record->kode_coa = $kodeCoa;
			$Record->id_group_coa = $groupCoa;
			$Record->save(); 
			
			$this->nama->Text = '';
			$this->kodeCoa->Text = '';
			$this->DDGroup->SelectedValue = 'empty';
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
	
	public function clearForm()
	{
	}
	
}
?>
