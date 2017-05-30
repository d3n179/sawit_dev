<?PHP
class MasterLevelDistribusi extends MainConf
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
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#table-1 tbody").append("'.$tblBody.'");');	
		}
	}
	
	
	public function BindGrid()
	{
		$sql = "SELECT 
					tbm_level_distribusi.id,
					tbm_level_distribusi.kode,
					tbm_level_distribusi.nilai,
					tbm_level_distribusi.bpjs_distribusi,
					tbm_level_distribusi.dinas_distribusi
				FROM 
					tbm_level_distribusi
				WHERE 
					tbm_level_distribusi.deleted = '0' 
				ORDER BY 
					tbm_level_distribusi.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
			
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['kode'].'</td>';
				$tblBody .= '<td>'.$row['nilai'].'</td>';
				$tblBody .= '<td>'.$row['bpjs_distribusi'].'</td>';
				$tblBody .= '<td>'.$row['dinas_distribusi'].'</td>';
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
		$Record = LevelDistribusiRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Level Distribusi';
			$this->idLevel->Value = $id;
			$this->kode->Text = $Record->kode;
			$this->nilai->Text = $Record->nilai;
			$this->bpjs_distribusi->Text = $Record->bpjs_distribusi;
			$this->dinas_distribusi->Text = $Record->dinas_distribusi;
			
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
		$Record = LevelDistribusiRecord::finder()->findByPk($id);
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
		$kode = trim($this->kode->Text);
		$nilai = trim($this->nilai->Text);
		$bpjs_distribusi = trim($this->bpjs_distribusi->Text);
		$dinas_distribusi = trim($this->dinas_distribusi->Text);
		
			if($this->idLevel->Value != '')
			{
				$Record = LevelDistribusiRecord::finder()->findByPk($this->idLevel->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new LevelDistribusiRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$Record->kode = $kode;
			$Record->nilai = $nilai;
			$Record->bpjs_distribusi = $bpjs_distribusi;
			$Record->dinas_distribusi = $dinas_distribusi;
			$Record->save(); 
			
			$tblBody = $this->BindGrid();
			
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("'.$msg.'");
						clearForm();
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						BindGrid();');	
		
	}
	
	
}
?>
