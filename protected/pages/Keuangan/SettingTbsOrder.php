<?PHP
class SettingTbsOrder extends MainConf
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
			$tblBodyHistory = $this->BindGridHistory();
			$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						jQuery("#table-2 tbody").append("'.$tblBodyHistory.'");');	
		}
	}
	
	public function BindGridHistory()
	{
		$sql = "SELECT
					tbt_pembayaran_tbs.id,
					tbt_pembayaran_tbs.no_pembayaran,
					tbt_pembayaran_tbs.tgl_pembayaran,
					tbt_tbs_order.no_tbs_order,
					tbm_pemasok.nama,
					tbt_pembayaran_tbs.jns_bayar,
					tbt_pembayaran_tbs.jumlah_pembayaran AS total_pembayaran
				FROM
					tbt_pembayaran_tbs
				INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_pembayaran_tbs.id_tbs_order
				INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
				WHERE
					tbt_pembayaran_tbs.deleted = '0' ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
				if($row['jns_bayar'] == '0')
					$jnsBayar = 'Cash';
				else
					$jnsBayar = 'Bank Transfer';
				
				$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-primary btn-sm btn-icon icon-left\" OnClick=\"cetakKwitansiClicked('.$row['id'].')\"><i class=\"entypo-print\" ></i>Cetak Kwitansi</a>&nbsp;&nbsp;';
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['no_pembayaran'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_pembayaran'],'3').'</td>';
				$tblBody .= '<td>'.$row['no_tbs_order'].'</td>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$jnsBayar.'</td>';
				$tblBody .= '<td>'.number_format($row['total_pembayaran'],2,'.',',').'</td>';	
				$tblBody .= '<td>'.$actionBtn.'</td>';	
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = '';
		}
		
		return 	$tblBody;
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_tbs_order.id,
					tbt_tbs_order.no_tbs_order,
					tbt_tbs_order.id_pemasok,
					tbt_tbs_order.id_barang,
					tbt_tbs_order.no_tbs_order,
					tbt_tbs_order.tgl_transaksi,
					tbm_pemasok.nama AS pemasok,
					tbm_barang.nama AS barang,
					tbm_kategori_barang.id AS kategori_barang_id,
					COUNT(tbt_tbs_order_detail.no_polisi) AS jml_kendaraan,
					SUM(tbt_tbs_order_detail.netto_2) AS Total_Berat
				FROM
					tbt_tbs_order
				INNER JOIN tbt_tbs_order_detail ON tbt_tbs_order_detail.id_tbs_order = tbt_tbs_order.id
				INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_tbs_order.id_barang
				INNER JOIN tbm_kategori_barang ON tbm_kategori_barang.id = tbm_barang.kategori_id
				WHERE
					tbt_tbs_order.deleted = '0'
				AND tbt_tbs_order_detail.deleted = '0'
				AND (tbt_tbs_order.`status` = '0' OR tbt_tbs_order.`status` = '1')
				GROUP BY
					tbt_tbs_order.id
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
				
				$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Proses</a>&nbsp;&nbsp;';
				
				$idSatuan = BarangSatuanRecord::finder()->find('id_barang = ? AND urutan = ?',$row['id_barang'],'1')->id_satuan;
				$nmSatuan = SatuanRecord::finder()->findByPk($idSatuan)->nama;
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['no_tbs_order'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_transaksi'],'3').'</td>';
				$tblBody .= '<td>'.$row['pemasok'].'</td>';
				$tblBody .= '<td>'.$row['barang'].'</td>';
				$tblBody .= '<td>'.$row['jml_kendaraan'].'</td>';
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
		$id = $param->CallbackParameter->id;
		$TbsOrderRecord = TbsOrderRecord::finder()->findByPk($id);
		$idBarang = $TbsOrderRecord->id_barang;
		$idPemasok = $TbsOrderRecord->id_pemasok;
		$tglTransaksi = $TbsOrderRecord->tgl_transaksi;
		$kategoriBarangId = BarangRecord::finder()->findByPK($idBarang)->kategori_id;
		
		
		$nmPemasok = PemasokRecord::finder()->findBypk($idPemasok)->nama;
		$nmbarang = BarangRecord::finder()->findBypk($idBarang)->nama;
		
		$this->idTbsOrder->Value = $id;
		$this->statusTbsOrder->Value = $TbsOrderRecord->status;
		$this->tglTbs->Value = $tglTransaksi;
		$this->idBarang->Value = $idBarang;
		$this->idPemasok->Value = $idPemasok;
		
		$this->Pemasok->Text = $nmPemasok;
		$this->jnsKelapaSawit->Text = $nmbarang;
		
			$this->modalJudul->Text = 'Setting Transaksi TBS';
			
			if($TbsOrderRecord->status == '0')
			{
				$sql = "SELECT
							tbt_tbs_order_detail.id AS idTransaksi,
							tbt_tbs_order_detail.no_polisi,
							tbm_jenis_kendaraan.jenis_kendaraan,
							tbt_tbs_order_detail.netto_1,
							tbt_tbs_order_detail.netto_2,
							tbt_harga_tbs_order.harga,
							tbt_tbs_order_detail.subtotal_tbs,
							tbm_jenis_kendaraan.jenis_bongkar,
							tbm_jenis_kendaraan.jumlah_bongkar,
							tbt_tbs_order_detail.subtotal_spsi,
							IF(tbm_pemasok.fee > 0,tbm_pemasok.fee,0) as fee,
							tbt_tbs_order_detail.subtotal_fee,
							tbm_kategori_pemasok.ppn,
							tbm_kategori_pemasok.pph,
							tbt_tbs_order_detail.total_tbs_order,
							tbm_setting_komidel.nama AS kategori_tbs,
							tbt_tbs_order.`status`
						FROM
							tbt_tbs_order_detail
						INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_tbs_order_detail.id_tbs_order
						INNER JOIN tbm_barang ON tbm_barang.id = tbt_tbs_order.id_barang
						INNER JOIN tbm_setting_komidel ON tbm_setting_komidel.id = tbt_tbs_order_detail.id_komidel
						INNER JOIN tbm_jenis_kendaraan ON tbm_jenis_kendaraan.id = tbt_tbs_order_detail.id_jenis_kendaraan
						INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
						LEFT JOIN tbt_harga_tbs_order ON tbt_harga_tbs_order.id_komidel = tbt_tbs_order_detail.id_komidel 
							AND tbt_harga_tbs_order.tgl_transaksi = '$tglTransaksi' AND tbt_harga_tbs_order.id_barang = '$idBarang' 
							AND tbt_harga_tbs_order.id_kategori_harga = tbm_pemasok.id_kategori_harga
						INNER JOIN tbm_kategori_pemasok ON tbm_kategori_pemasok.id = tbm_pemasok.kategori_id
						WHERE
							tbt_tbs_order.deleted = '0'
							AND tbt_tbs_order_detail.id_tbs_order = '$id'
							AND tbt_tbs_order_detail.deleted = '0'
						ORDER BY
							tbt_tbs_order.id ASC ";
			}
			else
			{
				$sql = "SELECT
							tbt_tbs_order_detail.id AS idTransaksi,
							tbt_tbs_order_detail.no_polisi,
							tbm_jenis_kendaraan.jenis_kendaraan,
							tbt_tbs_order_detail.netto_1,
							tbt_tbs_order_detail.netto_2,
							tbt_tbs_order_detail.harga,
							tbt_tbs_order_detail.subtotal_tbs,
							tbm_jenis_kendaraan.jenis_bongkar,
							tbm_jenis_kendaraan.jumlah_bongkar,
							tbt_tbs_order_detail.subtotal_spsi,
							tbt_tbs_order_detail.fee,
							tbt_tbs_order_detail.subtotal_fee,
							tbt_tbs_order_detail.ppn,
							tbt_tbs_order_detail.pph,
							tbt_tbs_order_detail.total_tbs_order,
							tbm_setting_komidel.nama AS kategori_tbs,
							tbt_tbs_order.`status`
						FROM
							tbt_tbs_order_detail
						INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_tbs_order_detail.id_tbs_order
						INNER JOIN tbm_barang ON tbm_barang.id = tbt_tbs_order.id_barang
						INNER JOIN tbm_setting_komidel ON tbm_setting_komidel.id = tbt_tbs_order_detail.id_komidel
						INNER JOIN tbm_jenis_kendaraan ON tbm_jenis_kendaraan.id = tbt_tbs_order_detail.id_jenis_kendaraan
						INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
						LEFT JOIN tbt_harga_tbs_order ON tbt_harga_tbs_order.id_komidel = tbt_tbs_order_detail.id_komidel 
							AND tbt_harga_tbs_order.tgl_transaksi = '$tglTransaksi' AND tbt_harga_tbs_order.id_barang = '$idBarang' 
							AND tbt_harga_tbs_order.id_kategori_harga = tbm_pemasok.id_kategori_harga
						INNER JOIN tbm_kategori_pemasok ON tbm_kategori_pemasok.id = tbm_pemasok.kategori_id
						WHERE
							tbt_tbs_order.deleted = '0'
							AND tbt_tbs_order_detail.id_tbs_order = '$id'
							AND tbt_tbs_order_detail.deleted = '0'
						ORDER BY
							tbt_tbs_order.id ASC ";

			}
			$array = $this->queryAction($sql,'S');
		
			$arrJson = json_encode($array,true);	
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
		$idPemasok = $this->idPemasok->Value;
		$idTbsOrder = $this->idTbsOrder->Value;
		$tglTbs = $this->tglTbs->Value;
		$IdSatuan = BarangSatuanRecord::finder()->find('id_barang = ?  AND urutan = ? ',$idBarang,1)->id_satuan;
		$totalNettoMasuk = 0;
		$totalTbsMasuk = 0;
		
		$TbsOrderRecord = TbsOrderRecord::finder()->findByPk($idTbsOrder);
		$TbsOrderRecord->status = '1';
		$TbsOrderRecord->save();
		
		$DetailBayar = $param->CallbackParameter->BayarTbsTable;
		$totalTbsOrder = 0;
		foreach($DetailBayar as $row)
		{		
			//if($row->status == '0')
			//{
				$TbsOrderDetailRecord = TbsOrderDetailRecord::finder()->findByPk($row->idTransaksi);
				if($TbsOrderDetailRecord)
				{
					$TbsOrderDetailRecord->jumlah_bongkar = $row->jumlah_bongkar;
					$TbsOrderDetailRecord->netto_1 = $row->netto_1;
					$TbsOrderDetailRecord->subtotal_spsi = $row->subtotal_spsi;
					$TbsOrderDetailRecord->harga = $row->harga;
					$TbsOrderDetailRecord->subtotal_tbs = $row->subtotal_tbs;
					$TbsOrderDetailRecord->fee = $row->fee;
					$TbsOrderDetailRecord->subtotal_fee = $row->subtotal_fee;
					$TbsOrderDetailRecord->ppn = $row->ppn;
					$TbsOrderDetailRecord->pph = $row->pph;
					$TbsOrderDetailRecord->total_tbs_order = $row->total_tbs_order;
					$TbsOrderDetailRecord->save();
					
					$totalTbsOrder += $row->total_tbs_order;
				}
				
				$totalNettoMasuk += $row->netto_2;
				$totalTbsMasuk += $row->subtotal_tbs;
				
				$msg = "Setting Transaksi TBS Telah Diproses";	
			//}
			
		}
		
		$supplierName = PemasokRecord::finder()->findByPk($idPemasok)->nama;
		$this->InsertJurnalUmum($TbsOrderRecord->id,
											'3',
											'0',
											$TbsOrderRecord->tgl_transaksi,
											date("G:i:s"),
											'Persediaan Bahan Baku',
											$totalTbsOrder,
											$TbsOrderRecord->no_tbs_order);
											
				$this->InsertJurnalUmum($TbsOrderRecord->id,
											'3',
											'1',
											$TbsOrderRecord->tgl_transaksi,
											date("G:i:s"),
											'Hutang',
											$totalTbsOrder,
											$TbsOrderRecord->no_tbs_order);	
																
				
											
					$this->InsertJurnalBukuBesar($TbsOrderRecord->id,
												'4',
												'0',
												$TbsOrderRecord->no_tbs_order,
												$TbsOrderRecord->tgl_transaksi,
												date("G:i:s"),
												'',
												'',
												"Persediaan Bahan Baku",
												'Pembelian Secara Kredit Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
												$totalTbsOrder);
					
					$this->InsertJurnalBukuBesar($TbsOrderRecord->id,
												'4',
												'0',
												$TbsOrderRecord->no_tbs_order,
												$TbsOrderRecord->tgl_transaksi,
												date("G:i:s"),
												'',
												'',
												"Hutang",
												'Pembelian Secara Kredit Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
												$totalTbsOrder);
												
			$this->InsertJurnalPembelian($TbsOrderRecord->id,
										$TbsOrderRecord->no_tbs_order,
										'1',
										date("Y-m-d"),
										date("G:i:s"),
										$supplierName,
										'',
										'',
										$totalTbsOrder);
		
						
	$tblBody = $this->BindGrid();
		$id = $BayarTbsOrderRecord->id;
		$url = "index.php?page=Keuangan.cetakKwtPembayaranTbs&id=".$id;
		
		$folderApp = explode("/",$_SERVER['REQUEST_URI']);
		$urlTemp="http://".$_SERVER['HTTP_HOST']."/".$folderApp[1]."/".$url;
		
			$this->getPage()->getClientScript()->registerEndScript
							('','
							toastr.info("'.$msg.'");
							jQuery("#modal-1").modal("hide");
							jQuery("#table-1").dataTable().fnDestroy();
							jQuery("#table-1 tbody").empty();
							jQuery("#table-1 tbody").append("'.$tblBody.'");
							clearForm();
							BindGrid();
							unloadContent();');	
			
			
			
		
	}
	
	public function cetakKwitansiClicked($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$url = "index.php?page=Keuangan.cetakKwtPembayaranTbs&id=".$id;
		
		$folderApp = explode("/",$_SERVER['REQUEST_URI']);
		$urlTemp="http://".$_SERVER['HTTP_HOST']."/".$folderApp[1]."/".$url;
		
		$this->getPage()->getClientScript()->registerEndScript('',"
					var url = '".$urlTemp."';
					window.open(url, '_blank');
					unloadContent();
		");
		
			/*$this->getPage()->getClientScript()->registerEndScript
							('','
							jQuery("#cetakFrame").attr("src","'.$url.'");
							jQuery("#modal-3").modal("show");
							');	*/
	}
}
?>
