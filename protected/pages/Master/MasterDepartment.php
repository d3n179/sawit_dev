<?PHP
class MasterDepartment extends MainConf
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
					tbm_department.id,
					tbm_department.nama,
					tbm_department.kode
				FROM 
					tbm_department
				WHERE 
					tbm_department.deleted = '0' 
					AND tbm_department.id_parent = '0'
				ORDER BY 
					tbm_department.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
			
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['kode'].'</td>';
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
		$Record = DepartmentRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Department';
			$this->idDepartment->Value = $id;
			$this->nama->Text = $Record->nama;
			$this->kode->Text = $Record->kode;
			
			$sqlDetail = "SELECT 
							tbm_department.id,
							tbm_department.nama,
							tbm_department.kode
						FROM 
							tbm_department
						WHERE 
							tbm_department.deleted = '0' 
							AND tbm_department.id_parent = '$id'
						ORDER BY 
							tbm_department.id ASC ";
			$arrDetail = $this->queryAction($sqlDetail,'S');
			
			$arrSub = json_encode($arrDetail,true);		
			$this->getPage()->getClientScript()->registerEndScript
					('','
					renderTempTable('.$arrSub.');
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
		$Record = DepartmentRecord::finder()->findByPk($id);
		if($Record)
		{
			$Record->deleted = '1';
			$Record->save();
			$sql = "UPDATE tbm_department SET deleted ='1' WHERE id_parent = '".$id."' ";
			$this->queryAction($sql,'C');
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
		$kode = trim($this->kode->Text);
		$SubdepartmentTable = $param->CallbackParameter->SubdepartmentTable;
		
			if($this->idDepartment->Value != '')
			{
				$Record = DepartmentRecord::finder()->findByPk($this->idDepartment->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new DepartmentRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$Record->nama = $nama;
			$Record->kode = $kode;
			$Record->save(); 
			
			if(count($SubdepartmentTable) > 0)
			{
				foreach($SubdepartmentTable as $row)
				{
					if($row->id_edit != '')
					{
						$SubRecord = DepartmentRecord::finder()->findByPk($row->id_edit);
					}
					else
					{
						$SubRecord = new DepartmentRecord();
					}
					
					$SubRecord->id_parent = $Record->id;
					$SubRecord->nama = $row->namaSub;
					$SubRecord->kode = $row->kodeSub;
					$SubRecord->deleted = $row->deleted;
					$SubRecord->save(); 
				}
			}
			
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
