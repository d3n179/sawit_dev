<?PHP
class MasterKategoriBarang extends MainConf
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
					tbm_kategori_barang.id,
					tbm_kategori_barang.tipe_kategori,
					tbm_kategori_barang.nama
				FROM 
					tbm_kategori_barang
				WHERE 
					tbm_kategori_barang.deleted = '0' 
				ORDER BY 
					tbm_kategori_barang.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
			
				if($row['tipe_kategori'] == '1')
				{
					$kategName = 'SAWIT';
				}
				elseif($row['tipe_kategori'] == '0')
				{
					$kategName = 'BIASA';
				}
				elseif($row['tipe_kategori'] == '2')
				{
					$kategName = 'BARANG PRODUKSI';
				}
				
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$kategName.'</td>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>';
				if($row['tipe_kategori'] != '2')
				{
					$tblBody .= '<a href=\"#\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
					$tblBody .= '<a href=\"#\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';	
				}
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
		$Record = BarangKategoriRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Kategori Product';
			$this->idKategoriBarang->Value = $id;
			$this->RBTypeBrng->SelectedValue = $Record->tipe_kategori;
			$this->nama->Text = $Record->nama;
			$this->DDCoa->Text = $Record->id_coa;
			$show = '.hide()';
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					bindSelect2();
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
		$Record = BarangKategoriRecord::finder()->findByPk($id);
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
		
			if($this->idKategoriBarang->Value != '')
			{
				$Record = BarangKategoriRecord::finder()->findByPk($this->idKategoriBarang->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new BarangKategoriRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$Record->tipe_kategori = $this->RBTypeBrng->SelectedValue;;
			$Record->nama = $nama;
			$Record->id_coa = $this->DDCoa->Text;
			$Record->save(); 
			
			$this->nama->Text = '';
			
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
