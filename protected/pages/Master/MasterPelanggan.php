<?PHP
class MasterPelanggan extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$sqlKategori = "SELECT id,nama FROM tbm_kategori_pelanggan WHERE deleted ='0' ";
			$arrKategori = $this->queryAction($sqlKategori,'S');
			$this->DDKategori->DataSource = $arrKategori;
			$this->DDKategori->DataBind();
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
					tbm_pelanggan.id,
					tbm_pelanggan.nama,
					tbm_pelanggan.alamat,
					tbm_pelanggan.telepon,
					tbm_kategori_pelanggan.nama AS kategori
				FROM 
					tbm_pelanggan
				INNER JOIN tbm_kategori_pelanggan ON tbm_kategori_pelanggan.id = tbm_pelanggan.kategori_id
				WHERE 
					tbm_pelanggan.deleted = '0' 
				ORDER BY 
					tbm_pelanggan.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
			
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['kategori'].'</td>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$row['alamat'].'</td>';
				$tblBody .= '<td>'.$row['telepon'].'</td>';
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
		$Record = PelangganRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Kategori Product';
			$this->idPelanggan->Value = $id;
			$this->nama->Text = $Record->nama;
			$this->alamat->Text = $Record->alamat;
			$this->telepon->Text = $Record->telepon;
			$this->npwp->Text = $Record->npwp;
			$this->DDKategori->SelectedValue = $Record->kategori_id;
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
		$Record = PelangganRecord::finder()->findByPk($id);
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
		$alamat = trim($this->alamat->Text);
		$telepon = trim($this->telepon->Text);
		$kategori = $this->DDKategori->SelectedValue;
			if($this->idPelanggan->Value != '')
			{
				$Record = PelangganRecord::finder()->findByPk($this->idPelanggan->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new PelangganRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$Record->nama = $nama;
			$Record->alamat = $alamat;
			$Record->telepon = $telepon;
			$Record->kategori_id = $kategori;
			$Record->npwp = $this->npwp->Text;
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
	
	public function clearForm()
	{
	}
	
}
?>
