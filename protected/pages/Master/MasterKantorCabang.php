<?PHP
class MasterKantorCabang extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$sql = "SELECT id,nama FROM tbm_kota WHERE deleted ='0' ";
			$arr = $this->queryAction($sql,'S');
			$this->DDKota->DataSource = $arr;
			$this->DDKota->DataBind();
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
					tbm_cabang.id,
					tbm_cabang.nama,
					tbm_cabang.alamat,
					tbm_kota.nama AS nama_kota,
					tbm_cabang.telp,
					tbm_cabang.email,
					tbm_cabang.nama_kontak,
					tbm_cabang.pendapatan,
					tbm_cabang.umk,
					tbm_cabang.ump
				FROM 
					tbm_cabang
				INNER JOIN tbm_kota ON tbm_kota.id = tbm_cabang.id_kota
				WHERE 
					tbm_cabang.deleted = '0' 
				ORDER BY 
					tbm_cabang.id ASC ";
					
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
			
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$row['alamat'].'</td>';
				$tblBody .= '<td>'.$row['nama_kota'].'</td>';
				$tblBody .= '<td>'.$row['telp'].'</td>';
				$tblBody .= '<td>'.$row['email'].'</td>';
				$tblBody .= '<td>'.$row['nama_kontak'].'</td>';
				$tblBody .= '<td>'.$row['pendapatan'].'</td>';
				$tblBody .= '<td>'.$row['umk'].'</td>';
				$tblBody .= '<td>'.$row['ump'].'</td>';
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
		$Record = KantorCabangRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Kantor Cabang';
			$this->idCabang->Value = $id;
			$this->nama->Text = $Record->nama;
			$this->telp->Text = $Record->telp;
			$this->email->Text = $Record->email;
			$this->cp->Text = $Record->nama_kontak;
			$this->alamat->Text = $Record->alamat;
			$this->DDKota->SelectedValue = $Record->id_kota;
			$this->pendapatan->Text = $Record->pendapatan;
			$this->umk->Text = $Record->umk;
			$this->ump->Text = $Record->ump;
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
		$Record = KantorCabangRecord::finder()->findByPk($id);
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
		
			if($this->idCabang->Value != '')
			{
				$Record = KantorCabangRecord::finder()->findByPk($this->idCabang->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new KantorCabangRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$Record->nama = strtoupper($this->nama->Text);
			$Record->telp = $this->telp->Text;
			$Record->email = $this->email->Text;
			$Record->nama_kontak = $this->cp->Text;
			$Record->alamat = $this->alamat->Text;
			$Record->id_kota = $this->DDKota->SelectedValue;
			$Record->pendapatan = str_replace(",","",$this->pendapatan->Text);
			$Record->umk = str_replace(",","",$this->umk->Text);
			$Record->ump = str_replace(",","",$this->ump->Text);
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
