<?PHP
class TbsOrder extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			
			$sqlPemasok = "SELECT
							tbm_pemasok.id,
							tbm_pemasok.nama
						FROM
							tbm_pemasok
						WHERE
							tbm_pemasok.deleted = '0' ";
					
			$arrPemasok= $this->queryAction($sqlPemasok,'S');
			$this->DDPemasok->DataSource = $arrPemasok;
			$this->DDPemasok->DataBind();
			
			$sqlKendaraan = "SELECT
							tbm_jenis_kendaraan.id,
							tbm_jenis_kendaraan.jenis_kendaraan
						FROM
							tbm_jenis_kendaraan
						WHERE
							tbm_jenis_kendaraan.deleted = '0' ";
					
			$arrKendaraan= $this->queryAction($sqlKendaraan,'S');
			$this->DDJenisKendaraan->DataSource = $arrKendaraan;
			$this->DDJenisKendaraan->DataBind();
			
			
			$sqlBarang = "SELECT
							tbm_barang.id,
							tbm_barang.nama
						FROM
							tbm_barang
						INNER JOIN 
							tbm_kategori_barang ON tbm_kategori_barang.id = tbm_barang.kategori_id
						WHERE
							tbm_barang.deleted = '0' 
							AND tbm_kategori_barang.tipe_kategori = '1' ";
					
			$arrBarang = $this->queryAction($sqlBarang,'S');
			$this->DDBarang->DataSource = $arrBarang;
			$this->DDBarang->DataBind();
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
	
	
	public function komidelCallback($sender,$param)
	{
		$komidel = $param->CallBackParameter->komidel;
		
		$sql = "SELECT
					tbm_setting_komidel.id,
					tbm_setting_komidel.operator,
					tbm_setting_komidel.komidel,
					tbm_setting_komidel.nama
				FROM
					tbm_setting_komidel
				WHERE
					tbm_setting_komidel.deleted = '0'
				ORDER BY
					tbm_setting_komidel.komidel ASC ";
					
		$arrKomidel = $this->queryAction($sql,'S');
		$kategoriTbs = '';
		$idKomidel = '';
		if($arrKomidel)
		{
			foreach($arrKomidel as $row)
			{
				if($row['operator'] == '<=')
				{
					if($komidel <= $row['komidel'])
					{
						$kategoriTbs = $row['nama'];
						$idKomidel = $row['id'];
						break;
					}
				}
				elseif($row['operator'] == '>=')
				{
					if($komidel >= $row['komidel'])
					{
						$kategoriTbs = $row['nama'];
						$idKomidel = $row['id'];
						break;
					}
				}
				
			}
		}
		
		$this->idKomidel->Value = $idKomidel;
		$this->kategori_tbs->Text = $kategoriTbs;
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_tbs_order.id,
					tbt_tbs_order.no_tbs_order,
					tbt_tbs_order.tgl_transaksi,
					tbm_pemasok.nama AS pemasok,
					tbm_barang.nama AS barang,
					tbt_tbs_order.bruto,
					tbt_tbs_order.tarra,
					tbt_tbs_order.netto_1,
					tbt_tbs_order.potongan,
					tbt_tbs_order.netto_2,
					tbt_tbs_order.jml_tandan,
					tbt_tbs_order.komidel,
					tbt_tbs_order.status,
					tbm_setting_komidel.nama AS kategori_tbs
				FROM
					tbt_tbs_order
				INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_tbs_order.id_barang
				INNER JOIN tbm_setting_komidel ON tbm_setting_komidel.id = tbt_tbs_order.id_komidel
				WHERE
					tbt_tbs_order.deleted = '0'
				ORDER BY tbt_tbs_order.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
				$actionBtn='';
				
				if($row['status'] == '0')
				{
					$actionBtn .= '<a href=\"#\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
					$actionBtn .= '<a href=\"#\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';
				}
				
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['no_tbs_order'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_transaksi'],'3').'</td>';
				$tblBody .= '<td>'.$row['pemasok'].'</td>';
				$tblBody .= '<td>'.$row['barang'].'</td>';
				$tblBody .= '<td>'.$row['bruto'].'</td>';
				$tblBody .= '<td>'.$row['tarra'].'</td>';
				$tblBody .= '<td>'.$row['netto_1'].'</td>';
				$tblBody .= '<td>'.$row['potongan'].'</td>';
				$tblBody .= '<td>'.$row['netto_2'].'</td>';
				$tblBody .= '<td>'.$row['jml_tandan'].'</td>';
				$tblBody .= '<td>'.$row['komidel'].'</td>';
				$tblBody .= '<td>'.$row['kategori_tbs'].'</td>';
				$tblBody .= '<td>';
				$tblBody .= $actionBtn;
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
		$Record = TbsOrderRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Data';
			
			$this->idTbsOrder->Value = $Record->id;
			
			$this->DDBarang->SelectedValue = $Record->id_barang;
			$this->DDPemasok->SelectedValue = $Record->id_pemasok;
			$this->DDJenisKendaraan->SelectedValue = $Record->id_jenis_kendaraan ;
			
			$this->no_polisi->Text = $Record->no_polisi;
			$this->bruto->Text = $Record->bruto;
			$this->tarra->Text = $Record->tarra;
			$this->netto_1->Text = $Record->netto_1;
			$this->potongan->Text = $Record->potongan ;
			$this->hasil_potongan->Text = $Record->hasil_potongan;
			$this->netto_2->Text = $Record->netto_2;
			$this->jml_tandan->Text = $Record->jml_tandan ;
			$this->komidel->Text = $Record->komidel ;
			$this->idKomidel->Value = $Record->id_komidel;
			$this->kategori_tbs->Text = KomidelRecord::finder()->findByPk($Record->id_komidel)->nama;
		
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
		$Record = BongkarSPSIRecord::finder()->findByPk($id);
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
		$idTbsOrder = $this->idTbsOrder->Value;
		$idJenisKendaraan = $this->DDJenisKendaraan->SelectedValue;
		$idBarang = $this->DDBarang->SelectedValue;
		$idPemasok = $this->DDPemasok->SelectedValue;
		
		$no_polisi = $this->no_polisi->Text;
		$bruto = $this->bruto->Text;
		$tarra = $this->tarra->Text;
		$netto_1 = $this->netto_1->Text;
		$potongan = $this->potongan->Text;
		$hasil_potongan = $this->hasil_potongan->Text;
		$netto_2 = $this->netto_2->Text;
		$jml_tandan = $this->jml_tandan->Text;
		$komidel = $this->komidel->Text;
		$idKomidel = $this->idKomidel->Value;
		$kategori_tbs = $this->kategori_tbs->Text;
				
		
			if($idTbsOrder != '')
			{
				$Record = TbsOrderRecord::finder()->findByPk($idTbsOrder);
				$msg = "Data Berhasil Diedit";
				
				
			}
			else
			{
				$Record = new TbsOrderRecord();
				$msg = "Data Berhasil Disimpan";
				$Record->no_tbs_order = $this->GenerateNoDocument('TBS');
			}
			
			$Record->id_barang = $idBarang;
			$Record->id_pemasok = $idPemasok;
			$Record->id_jenis_kendaraan = $idJenisKendaraan;
			$Record->no_polisi = strtoupper($no_polisi);
			$Record->tgl_transaksi = date("Y-m-d");
			$Record->wkt_transaksi = date("G:i:s");
			$Record->bruto = $bruto;
			$Record->tarra = $tarra;
			$Record->netto_1 = $netto_1;
			$Record->potongan = $potongan;
			$Record->hasil_potongan = $hasil_potongan;
			$Record->netto_2 = $netto_2;
			$Record->jml_tandan = $jml_tandan;
			$Record->komidel = $komidel;
			$Record->id_komidel= $idKomidel;
			$Record->status= '0';
			$Record->deleted= '0';
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

}
?>
