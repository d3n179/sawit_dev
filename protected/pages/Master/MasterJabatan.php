<?PHP
class MasterJabatan extends MainConf
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
			$sqlDepartment = "SELECT 
									id,
									nama
								FROM 
									tbm_department 
								WHERE 
									deleted ='0'
									AND id_parent = '0' ";
			$arrDepartment = $this->queryAction($sqlDepartment,'S');
			$this->id_department->DataSource = $arrDepartment;
			$this->id_department->DataBind();
			
			$sqlLevel = "SELECT 
									id,
									nilai
								FROM 
									tbm_level_distribusi 
								WHERE 
									deleted = '0'";
			$arrLevel = $this->queryAction($sqlLevel,'S');
			$this->id_level_distribusi->DataSource = $arrLevel;
			$this->id_level_distribusi->DataBind();
								
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#table-1 tbody").append("'.$tblBody.'");');	
		}
	}
	
	public function departmentChanged()
	{
		$idDepartment = $this->id_department->SelectedValue;
		if($idDepartment != '' && $idDepartment != 'empty')
		{
			$sqlSubDepartment = "SELECT 
									id,
									nama
								FROM 
									tbm_department 
								WHERE 
									deleted ='0'
									AND id_parent = '$idDepartment' ";
			$arrSubDepartment = $this->queryAction($sqlSubDepartment,'S');
			$this->id_subdepartment->DataSource = $arrSubDepartment;
			$this->id_subdepartment->DataBind();
		}
		else
		{
			$this->id_subdepartment->DataSource = '';
			$this->id_subdepartment->DataBind();
		}
	}
	
	public function BindGrid()
	{
		$sql = "SELECT 
					tbm_jabatan.id,
					a.nama AS department,
					b.nama AS subdepartment,
					tbm_jabatan.nama,
					tbm_jabatan.kode,
					tbm_jabatan.kuota,
					tbm_jabatan.jatah_cuti,
					tbm_jabatan.tunjangan_jabatan,
					tbm_jabatan.tunjangan_komunikasi,
					tbm_jabatan.premi_karyawan
				FROM 
					tbm_jabatan
					INNER JOIN tbm_department a ON a.id = tbm_jabatan.id_department
					INNER JOIN tbm_department b ON b.id = tbm_jabatan.id_subdepartment
				WHERE 
					tbm_jabatan.deleted = '0' 
				ORDER BY 
					tbm_jabatan.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
			
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['department'].'</td>';
				$tblBody .= '<td>'.$row['subdepartment'].'</td>';
				$tblBody .= '<td>'.$row['kode'].'</td>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$row['kuota'].'</td>';
				$tblBody .= '<td>'.$row['jatah_cuti'].'</td>';
				$tblBody .= '<td>'.number_format($row['tunjangan_jabatan'],2,'.',',').'</td>';
				$tblBody .= '<td>'.number_format($row['tunjangan_komunikasi'],2,'.',',').'</td>';
				$tblBody .= '<td>'.number_format($row['premi_karyawan'],2,'.',',').'</td>';
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
		$Record = JabatanRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Jabatan';
			$this->idJabatan->Value = $id;
			$this->id_department->SelectedValue = $Record->id_department;
			$this->departmentChanged();
			$this->id_subdepartment->SelectedValue = $Record->id_subdepartment;
			$this->nama->Text = $Record->nama;
			$this->kode->Text = $Record->kode;
			$this->kuota->Text = $Record->kuota;
			$this->jatah_cuti->Text = $Record->jatah_cuti;
			$this->id_level_distribusi->SelectedValue = $Record->id_level_distribusi;
			$this->tunjangan_jabatan->Text = $Record->tunjangan_jabatan;
			$this->tunjangan_komunikasi->Text = $Record->tunjangan_komunikasi;
			$this->premi_karyawan->Text = $Record->premi_karyawan;
			
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
		$Record = JabatanRecord::finder()->findByPk($id);
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
			if($this->idJabatan->Value != '')
			{
				$Record = JabatanRecord::finder()->findByPk($this->idJabatan->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new JabatanRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$Record->id_department = $this->id_department->SelectedValue;
			$Record->id_subdepartment = $this->id_subdepartment->SelectedValue;
			$Record->nama = $this->nama->Text;
			$Record->kode = $this->kode->Text;
			$Record->kuota = $this->kuota->Text;
			$Record->jatah_cuti = $this->jatah_cuti->Text;
			$Record->tunjangan_jabatan = $this->tunjangan_jabatan->Text;
			$Record->tunjangan_komunikasi = $this->tunjangan_komunikasi->Text;
			$Record->premi_karyawan = $this->premi_karyawan->Text;
			$Record->id_level_distribusi = $this->id_level_distribusi->SelectedValue;
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
