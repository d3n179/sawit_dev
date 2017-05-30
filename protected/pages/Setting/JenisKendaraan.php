<?PHP
class JenisKendaraan extends MainConf
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
					tbm_jenis_kendaraan.id,
					tbm_jenis_kendaraan.jenis_kendaraan,
					tbm_jenis_kendaraan.jenis_bongkar,
					tbm_jenis_kendaraan.jumlah_bongkar
				FROM 
					tbm_jenis_kendaraan
				WHERE 
					tbm_jenis_kendaraan.deleted = '0' 
				ORDER BY 
					tbm_jenis_kendaraan.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
			
				if($row['jenis_bongkar'] == '0')
					$nmBongkar = "Jumlah Bongkar";
				elseif($row['jenis_bongkar'] == '1')
					$nmBongkar = "Harga Bongkar";
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['jenis_kendaraan'].'</td>';
				$tblBody .= '<td>'.$nmBongkar.'</td>';
				$tblBody .= '<td>'.$row['jumlah_bongkar'].'</td>';
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
		$Record = JenisKendaraanRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Data';
			$this->idBongkar->Value = $id;
			$this->jnsKendaraan->Text = $Record->jenis_kendaraan;
			$this->jnsBongkar->SelectedValue = $Record->jenis_bongkar;
			$this->jumlah->Text = $Record->jumlah_bongkar;
			
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
		$Record = JenisKendaraanRecord::finder()->findByPk($id);
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
		$jnsKendaraan = strtoupper($this->jnsKendaraan->Text);
		$jumlah = $this->jumlah->Text;
		$stFind = false;
		
			if($this->idBongkar->Value != '')
			{
				$Record = JenisKendaraanRecord::finder()->findByPk($this->idBongkar->Value);
				$msg = "Data Berhasil Diedit";
				
				if($jnsKendaraan != $Record->jenis_kendaraan)
				{
					$stFind = $this->cekData($jnsKendaraan);
				}
				
			}
			else
			{
				$Record = new JenisKendaraanRecord();
				$msg = "Data Berhasil Disimpan";
				
				$stFind = $this->cekData($jnsKendaraan);
			}
			
			if(!$stFind)
			{
				$Record->jenis_kendaraan = $jnsKendaraan;
				$Record->jenis_bongkar = $this->jnsBongkar->SelectedValue;
				$Record->jumlah_bongkar = $jumlah;
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
							toastr.error("Data Tersebut Sudah Ada !");');	
			}
	}
	
	
	public function cekData($jnsKendaraan)
	{
		$cekData = JenisKendaraanRecord::finder()->find('jenis_kendaraan = ? AND deleted = ?',$jnsKendaraan,'0');
		
		if($cekData)
			return true;
		else
			return false;
	}
}
?>
