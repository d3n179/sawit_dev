<?PHP
class MasterKategoriPemasok extends MainConf
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
	
	public function jenisChanged()
	{
		if($this->DDJenisKategori->SelectedValue == '0')
		{
			//$this->ppnPanel->Visible= true;
			$this->ppnPanel->Enabled= true;
		}
		else
		{
			//$this->ppnPanel->Visible= false;
			$this->ppnPanel->Enabled= false;
		}
	}
	
	public function BindGrid()
	{
		$sql = "SELECT 
					tbm_kategori_pemasok.id,
					tbm_kategori_pemasok.jenis_kategori,
					tbm_kategori_pemasok.nama,
					tbm_kategori_pemasok.ppn,
					tbm_kategori_pemasok.pph
				FROM 
					tbm_kategori_pemasok
				WHERE 
					tbm_kategori_pemasok.deleted = '0' 
				ORDER BY 
					tbm_kategori_pemasok.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
				if($row['jenis_kategori'] == '0')
					$jnsKategori = "Pemasok TBS";
				else
					$jnsKategori = "Pemasok Barang";
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$jnsKategori.'</td>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$row['ppn'].'</td>';
				$tblBody .= '<td>'.$row['pph'].'</td>';
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
		$Record = PemasokKategoriRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Kategori Supplier';
			$this->idKategoriPemasok->Value = $id;
			$this->DDJenisKategori->SelectedValue = $Record->jenis_kategori;
			$this->nama->Text = $Record->nama;
			$this->ppn->Text = $Record->ppn;
			$this->pph->Text = $Record->pph;
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
		$Record = PemasokKategoriRecord::finder()->findByPk($id);
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
		
			if($this->idKategoriPemasok->Value != '')
			{
				$Record = PemasokKategoriRecord::finder()->findByPk($this->idKategoriPemasok->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new PemasokKategoriRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$Record->jenis_kategori = $this->DDJenisKategori->SelectedValue;
			$Record->nama = $nama;
			$Record->ppn = $this->ppn->Text;
			$Record->pph = $this->pph->Text;
			$Record->save(); 
			
			$this->DDJenisKategori->SelectedValue = '';
			$this->nama->Text = '';
			$this->pph->Text = '';;
			$this->ppn->Text = '';
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
