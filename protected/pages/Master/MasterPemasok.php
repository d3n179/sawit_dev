<?PHP
class MasterPemasok extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$sqlKategori = "SELECT id,nama FROM tbm_kategori_pemasok WHERE deleted ='0' AND jenis_kategori = '1' ";
			$arrKategori = $this->queryAction($sqlKategori,'S');
			$this->DDKategori->DataSource = $arrKategori;
			$this->DDKategori->DataBind();
			
			$sqlKategoriHarga = "SELECT id,nama FROM tbm_kategori_harga WHERE deleted ='0' ";
			$arrKategoriHarga = $this->queryAction($sqlKategoriHarga,'S');
			$this->DDKategoriHarga->DataSource = $arrKategoriHarga;
			$this->DDKategoriHarga->DataBind();
			
			$sqlJenis = "SELECT id,jenis_kendaraan FROM tbm_jenis_kendaraan WHERE deleted ='0' ";
			$arrJenis = $this->queryAction($sqlJenis,'S');
			$this->DDJnsKendaraan->DataSource = $arrJenis;
			$this->DDJnsKendaraan->DataBind();
			
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
	
	public function kategoriChanged()
	{
		$idKategori = $this->DDKategori->SelectedValue;
		$PemasokKategoriRecord = PemasokKategoriRecord::finder()->findByPk($idKategori);
		
		$this->getPage()->getClientScript()->registerEndScript
						('','
						kategoriChanged('.$PemasokKategoriRecord->jenis_kategori.');');	
	}
	
	public function BindGrid()
	{
		$sql = "SELECT 
					tbm_pemasok.id,
					tbm_pemasok.nama,
					tbm_pemasok.alamat,
					tbm_pemasok.telepon,
					tbm_pemasok.fax,
					tbm_pemasok.contact_person,
					tbm_pemasok.no_sp,
					tbm_pemasok.fee,
					tbm_kategori_pemasok.nama AS kategori,
					tbm_kategori_harga.nama AS kategori_harga
				FROM 
					tbm_pemasok
				INNER JOIN tbm_kategori_pemasok ON tbm_kategori_pemasok.id = tbm_pemasok.kategori_id
				LEFT JOIN tbm_kategori_harga ON tbm_kategori_harga.id = tbm_pemasok.id_kategori_harga
				WHERE 
					tbm_pemasok.deleted = '0' 
					AND tbm_kategori_pemasok.jenis_kategori = '1'
				ORDER BY 
					tbm_pemasok.id ASC ";
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
				$tblBody .= '<td>'.$row['fax'].'</td>';
				$tblBody .= '<td>'.$row['contact_person'].'</td>';
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
		$Record = PemasokRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Kategori Pemasok';
			$this->idPemasok->Value = $id;
			$this->nama->Text = $Record->nama;
			$this->alamat->Text = $Record->alamat;
			$this->telepon->Text = $Record->telepon;
			$this->fax->Text = $Record->fax;
			$this->contact_person->Text = $Record->contact_person;
			$this->DDKategori->SelectedValue = $Record->kategori_id;
			$this->DDKategoriHarga->SelectedValue = $Record->id_kategori_harga;
			$this->no_sp->Text = $Record->no_sp;
			
			$PemasokKategoriRecord = PemasokKategoriRecord::finder()->findByPk($Record->kategori_id);
		
			$sql = "SELECT
						tbm_kendaraan_pemasok.id,
						tbm_kendaraan_pemasok.id_jenis_kendaraan,
						tbm_kendaraan_pemasok.no_polisi,
						tbm_jenis_kendaraan.jenis_kendaraan
					FROM
						tbm_kendaraan_pemasok
					INNER JOIN tbm_jenis_kendaraan ON tbm_jenis_kendaraan.id = tbm_kendaraan_pemasok.id_jenis_kendaraan
					WHERE
						tbm_kendaraan_pemasok.deleted = '0'
					AND tbm_kendaraan_pemasok.id_pemasok = '$id' ";
					
			$arr = $this->queryAction($sql,'S');
			$arrJson = json_encode($arr,true);
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					RenderTempTable('.$arrJson.');
					kategoriChanged('.$PemasokKategoriRecord->jenis_kategori.')
					jQuery("#modal-1").modal("show");');
			
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
		$Record = PemasokRecord::finder()->findByPk($id);
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
		$kategoriHarga = $this->DDKategoriHarga->SelectedValue;
		$no_sp = trim($this->no_sp->Text);
		$KendaraanPemasokList = $param->CallBackParameter->KendaraanPemasokTable;
		
			if($this->idPemasok->Value != '')
			{
				$Record = PemasokRecord::finder()->findByPk($this->idPemasok->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new PemasokRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$Record->nama = $nama;
			$Record->alamat = $alamat;
			$Record->telepon = $telepon;
			$Record->fax = trim($this->fax->Text);
			$Record->contact_person = trim($this->contact_person->Text);
			$Record->kategori_id = $kategori;
			$Record->id_kategori_harga = $kategoriHarga;
			$Record->no_sp = $no_sp;
			$Record->save(); 
			
			/*foreach($KendaraanPemasokList as $row)
			{
				if($row->id_edit == '')
				{
					$KendaraanPemasokRecord = new KendaraanPemasokRecord();
				}
				else
				{
					$KendaraanPemasokRecord = KendaraanPemasokRecord::finder()->findByPk($row->id_edit);
				}
				$KendaraanPemasokRecord->id_pemasok = $Record->id;
				$KendaraanPemasokRecord->id_jenis_kendaraan = $row->IdJnsKendaraan;
				$KendaraanPemasokRecord->no_polisi = strtoupper($row->NoPolisi);
				
				$KendaraanPemasokRecord->deleted = $row->deleted;
				
				$KendaraanPemasokRecord->save(); 
			}*/
			
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
	
	public function clearForm()
	{
	}
	
}
?>
