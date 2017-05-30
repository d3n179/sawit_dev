<?PHP
class SettingKomidel extends MainConf
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
					tbm_setting_komidel.id,
					tbm_setting_komidel.nama,
					tbm_setting_komidel.singkatan,
					CONCAT(tbm_setting_komidel.operator,' ',tbm_setting_komidel.komidel) AS komidel
				FROM 
					tbm_setting_komidel
				WHERE 
					tbm_setting_komidel.deleted = '0' 
				ORDER BY 
					tbm_setting_komidel.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
			
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$row['singkatan'].'</td>';
				$tblBody .= '<td>'.$row['komidel'].'</td>';
				$tblBody .= '<td>';
				$tblBody .= '<a href=\"#\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
				$tblBody .= '<a href=\"#\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';	
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
		$Record = KomidelRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Komidel';
			$this->idKomidel->Value = $id;
			$this->DDKomidel->SelectedValue = $Record->operator;
			$this->komidel->Text = $Record->komidel;
			$this->harga->Text = $Record->harga;
			$this->nama->Text = $Record->nama;
			$this->singkatan->Text = $Record->singkatan;
			
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
		$Record = KomidelRecord::finder()->findByPk($id);
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
		$komidel = $this->komidel->Text;
		$nama = strtoupper($this->nama->Text);
		$singkatan = strtoupper($this->singkatan->Text);
		$operator = $this->DDKomidel->SelectedValue;
		$harga = str_replace(",","",$this->harga->Text);
		$stFind = false;
		
			if($this->idKomidel->Value != '')
			{
				$Record = KomidelRecord::finder()->findByPk($this->idKomidel->Value);
				$msg = "Data Berhasil Diedit";
				
				if($komidel != $Record->komidel)
				{
					$stFind = $this->cekKomidel($komidel);
				}
				
			}
			else
			{
				$Record = new KomidelRecord();
				$msg = "Data Berhasil Disimpan";
				
				$stFind = $this->cekKomidel($komidel);
			}
			
			if(!$stFind)
			{
				$Record->komidel = $komidel;
				$Record->operator = $operator;
				$Record->nama = $nama;
				$Record->singkatan = $singkatan;
				$Record->harga = $harga;
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
			else
			{
				$this->getPage()->getClientScript()->registerEndScript
							('','
							toastr.error("Komidel Tersebut Sudah Ada !");');	
			}
			
			
			
		
	}
	
	
	public function cekKomidel($komidel)
	{
		var_dump($komidel);
		$cekKomidel = KomidelRecord::finder()->find('komidel = ? AND deleted = ?',$komidel,'0');
		var_dump($cekKomidel);
		if($cekKomidel)
			return true;
		else
			return false;
	}
}
?>
