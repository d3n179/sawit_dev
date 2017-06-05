<?PHP
class SettingHargaTbsOrder extends MainConf
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
					tbt_tbs_order.id,
					tbt_tbs_order.id_pemasok,
					tbt_tbs_order.id_barang,
					tbt_tbs_order.no_tbs_order,
					tbt_tbs_order.tgl_transaksi,
					tbm_pemasok.nama AS pemasok,
					tbm_kategori_barang.id AS kategori_barang_id,
					tbm_barang.nama AS barang,
					COUNT(tbt_tbs_order_detail.id) AS jml_transaksi,
					SUM(tbt_tbs_order_detail.netto_2) AS Total_Berat
				FROM
					tbt_tbs_order
				INNER JOIN tbt_tbs_order_detail ON tbt_tbs_order_detail.id_tbs_order = tbt_tbs_order.id
				INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_tbs_order.id_barang
				INNER JOIN tbm_kategori_barang ON tbm_kategori_barang.id = tbm_barang.kategori_id
				WHERE
					tbt_tbs_order.deleted = '0'
				AND tbt_tbs_order.`status` = '0'
				AND tbt_tbs_order_detail.deleted = '0'
				GROUP BY
					tbm_barang.id,
					tbt_tbs_order.tgl_transaksi
				ORDER BY
					tbt_tbs_order.id ASC ";
					
	/*	$sql = "SELECT
					tbt_tbs_order.id,
					tbt_tbs_order.no_tbs_order,
					tbt_tbs_order.tgl_transaksi,
					tbm_pemasok.nama AS pemasok,
					tbm_barang.nama AS barang,
					tbt_tbs_order.no_polisi,
					tbm_jenis_kendaraan.jenis_kendaraan,
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
				INNER JOIN tbm_jenis_kendaraan ON tbm_jenis_kendaraan.id = tbt_tbs_order.id_jenis_kendaraan
				WHERE
					tbt_tbs_order.deleted = '0'
					AND tbt_tbs_order.status = '0'
				ORDER BY tbt_tbs_order.id ASC ";*/
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
				$actionBtn='';
				
				$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id_barang'].',\''.$row['tgl_transaksi'].'\')\"><i class=\"entypo-pencil\" ></i>Set Harga</a>&nbsp;&nbsp;';
				
				
				$idSatuan = BarangSatuanRecord::finder()->find('id_barang = ? AND urutan = ?',$row['id_barang'],'1')->id_satuan;
				$nmSatuan = SatuanRecord::finder()->findByPk($idSatuan)->nama;
				$tblBody .= '<tr>';
				//$tblBody .= '<td>'.$row['no_tbs_order'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_transaksi'],'3').'</td>';
				$tblBody .= '<td>'.$row['barang'].'</td>';
				$tblBody .= '<td>'.$row['jml_transaksi'].'</td>';
				$tblBody .= '<td>'.$row['Total_Berat'].' '.$nmSatuan.'</td>';
				//$tblBody .= '<td>'.$row['barang'].'</td>';
				//$tblBody .= '<td>'.$row['netto_2'].'</td>';
				//$tblBody .= '<td>'.$row['kategori_tbs'].'</td>';
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
		$idBarang = $param->CallbackParameter->idBarang;
		$tglTransaksi = $param->CallbackParameter->tglTransaksi;
		$nmBarang = BarangRecord::finder()->findByPk($idBarang)->nama;
		
		$this->tglTransaksi->Value = $tglTransaksi;
		$this->nmTgl->Text = $this->ConvertDate($tglTransaksi,'3');
		$this->idBarang->Value = $idBarang;
		$this->nmBarang->Text = $nmBarang;
		$arr = array();
		$sqlKategHarga = "SELECT
								tbm_kategori_harga.id,
								tbm_kategori_harga.nama
							FROM
								tbm_kategori_harga
							WHERE
								tbm_kategori_harga.deleted = '0' 
							ORDER BY tbm_kategori_harga.nama ASC";
		$arrKategHarga = $this->queryAction($sqlKategHarga,'S');	
		foreach($arrKategHarga as $rowHarga)
		{
			$idKategHarga = $rowHarga['id'];
			
			$sqlKomidel = "SELECT
					tbm_setting_komidel.id,
					tbm_setting_komidel.nama,
					tbt_harga_tbs_order.harga
				FROM
					tbm_setting_komidel
				LEFT JOIN tbt_harga_tbs_order ON tbt_harga_tbs_order.id_komidel = tbm_setting_komidel.id
				AND tbt_harga_tbs_order.id_kategori_harga = '$idKategHarga' AND tbt_harga_tbs_order.tgl_transaksi = '$tglTransaksi' AND tbt_harga_tbs_order.id_barang = '$idBarang'
				WHERE
					tbm_setting_komidel.deleted = '0' 
				ORDER BY tbm_setting_komidel.komidel ASC ";
			$arrKomidel = $this->queryAction($sqlKomidel,'S');	
			foreach($arrKomidel as  $rowKomidel)
			{
				$arr[] = array("idKategoriHarga"=>$idKategHarga,
								"NamaKategoriHarga"=>$rowHarga['nama'],
								"idKomidel"=>$rowKomidel['id'],
								"NamaKomidel"=>$rowKomidel['nama'],
								"harga"=>$rowKomidel['harga']);
			}
		}	
		
		$arrJson = json_encode($arr,true);			
		$this->getPage()->getClientScript()->registerEndScript
					('','
						unloadContent();
						RenderTempTable('.$arrJson.');
						jQuery("#modal-1").modal("show");
					');	
	}
	
	
	public function submitBtnClicked($sender,$param)
	{
			$idBarang = $this->idBarang->Value;
			$tglTransaksi = $this->tglTransaksi->Value;		
			$detailKomidel = $param->CallbackParameter->KomidelTable;
			
			foreach($detailKomidel as $row)
			{
				$HargaTbsOrderRecord = HargaTbsOrderRecord::finder()->find('tgl_transaksi = ? AND id_komidel = ? AND id_barang = ? AND id_kategori_harga = ?',$tglTransaksi,$row->idKomidel,$idBarang,$row->idKategoriHarga);
				
				if(!$HargaTbsOrderRecord)
					$HargaTbsOrderRecord = new HargaTbsOrderRecord();
					
				$HargaTbsOrderRecord->tgl_transaksi = $tglTransaksi;
				$HargaTbsOrderRecord->id_komidel = $row->idKomidel;
				$HargaTbsOrderRecord->id_kategori_harga = $row->idKategoriHarga;
				$HargaTbsOrderRecord->id_barang = $idBarang;
				$HargaTbsOrderRecord->harga = $row->Harga;
				
				$HargaTbsOrderRecord->deleted;	
				$HargaTbsOrderRecord->save();
			}
			
			$this->getPage()->getClientScript()->registerEndScript
							('','
							toastr.info("Harga Telah Diset");
							jQuery("#modal-1").modal("hide");
							clearForm();');	
			
			
			
		
	}

}
?>
