<?PHP
class BayarTbsOrder extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$sql = "SELECT id,nama AS nama FROM tbm_bank WHERE deleted ='0' ";
			$arr = $this->queryAction($sql,'S');
			$this->DDBank->DataSource = $arr;
			$this->DDBank->DataBind();
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
	
	public function jnsByrChanged()
	{
		if($this->DDJnsBayar->SelectedValue == '0')
		{
			$this->DDBank->Enabled = false;
			
			$this->noRef->Enabled = false;
		}
		else
		{
			$this->DDBank->Enabled = true;
			
			$this->noRef->Enabled = true;
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
					tbm_barang.nama AS barang,
					tbm_kategori_barang.id AS kategori_barang_id,
					COUNT(tbt_tbs_order.no_polisi) AS jml_kendaraan,
					SUM(tbt_tbs_order.netto_2) AS Total_Berat
				FROM
					tbt_tbs_order
				INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_tbs_order.id_barang
				INNER JOIN tbm_kategori_barang ON tbm_kategori_barang.id = tbm_barang.kategori_id
				WHERE
					tbt_tbs_order.deleted = '0'
				AND (tbt_tbs_order.`status` = '0' OR tbt_tbs_order.`status` = '1')
				GROUP BY
					tbt_tbs_order.id_pemasok,
					tbt_tbs_order.id_barang,
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
				
				$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id_pemasok'].','.$row['id_barang'].','.$row['kategori_barang_id'].',\''.$row['tgl_transaksi'].'\')\"><i class=\"entypo-pencil\" ></i>Proses</a>&nbsp;&nbsp;';
				
				
				$idSatuan = BarangSatuanRecord::finder()->find('id_barang = ? AND urutan = ?',$row['id_barang'],'1')->id_satuan;
				$nmSatuan = SatuanRecord::finder()->findByPk($idSatuan)->nama;
				$tblBody .= '<tr>';
				//$tblBody .= '<td>'.$row['no_tbs_order'].'</td>';
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
		$idPemasok = $param->CallbackParameter->idPemasok;
		$idBarang = $param->CallbackParameter->idBarang;
		$kategoriBarangId = $param->CallbackParameter->kategoriBarangId;
		$tglTransaksi = $param->CallbackParameter->tglTransaksi;
		$nmPemasok = PemasokRecord::finder()->findBypk($idPemasok)->nama;
		$nmbarang = BarangRecord::finder()->findBypk($idBarang)->nama;
		
		$this->tglTbs->Value = $tglTransaksi;
		$this->idBarang->Value = $idBarang;
		$this->idPemasok->Value = $idPemasok;
		
		$this->Pemasok->Text = $nmPemasok;
		$this->jnsKelapaSawit->Text = $nmbarang;
		
			$this->modalJudul->Text = 'Proses Pembayaran';
			
			$sql = "SELECT
						tbt_pembayaran_tbs_detail.id AS idPembayaranDetail,
						tbt_tbs_order.id AS idTransaksi,
						tbt_tbs_order.no_polisi,
						tbm_jenis_kendaraan.jenis_kendaraan,
						tbt_tbs_order.netto_1,
						tbt_tbs_order.netto_2,
						tbt_harga_tbs_order.harga,
						tbt_pembayaran_tbs_detail.subtotal_tbs,
						tbm_jenis_kendaraan.jenis_bongkar,
						tbm_jenis_kendaraan.jumlah_bongkar,
						tbt_pembayaran_tbs_detail.subtotal_spsi,
						IF(tbm_pemasok.fee > 0,tbm_pemasok.fee,0) as fee,
						tbt_pembayaran_tbs_detail.subtotal_fee,
						tbm_kategori_pemasok.ppn,
						tbm_kategori_pemasok.pph,
						tbt_pembayaran_tbs_detail.total_tbs_order,
						tbm_setting_komidel.nama AS kategori_tbs,
						tbt_tbs_order.`status`
					FROM
						tbt_tbs_order
					INNER JOIN tbm_barang ON tbm_barang.id = tbt_tbs_order.id_barang
					INNER JOIN tbm_setting_komidel ON tbm_setting_komidel.id = tbt_tbs_order.id_komidel
					INNER JOIN tbm_jenis_kendaraan ON tbm_jenis_kendaraan.id = tbt_tbs_order.id_jenis_kendaraan
					INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
					LEFT JOIN tbt_harga_tbs_order ON tbt_harga_tbs_order.id_komidel = tbt_tbs_order.id_komidel 
						AND tbt_harga_tbs_order.tgl_transaksi = '$tglTransaksi' AND tbt_harga_tbs_order.id_barang = '$kategoriBarangId' 
						AND tbt_harga_tbs_order.id_kategori_harga = tbm_pemasok.id_kategori_harga
					INNER JOIN tbm_kategori_pemasok ON tbm_kategori_pemasok.id = tbm_pemasok.kategori_id
					LEFT JOIN tbt_pembayaran_tbs_detail ON tbt_pembayaran_tbs_detail.id_tbs_order = tbt_tbs_order.id
					WHERE
						tbt_tbs_order.deleted = '0'
						AND tbt_tbs_order.tgl_transaksi = '$tglTransaksi'
						AND tbt_tbs_order.id_pemasok = '$idPemasok'
						AND tbt_tbs_order.id_barang = '$idBarang'
						AND (tbt_tbs_order.`status` = '0' OR tbt_tbs_order.`status` = '1')
					ORDER BY
						tbt_tbs_order.id ASC ";
			$array = $this->queryAction($sql,'S');
			foreach($array as $subkey => $subArray)
			{
				if($subArray['idPembayaranDetail'] != '')
				{
					$BayarTbsOrderDetailRecord = BayarTbsOrderDetailRecord::finder()->findByPk($subArray['idPembayaranDetail']);
					if($BayarTbsOrderDetailRecord)
					{
						$array[$subkey]['netto_1'] = $BayarTbsOrderDetailRecord->netto_1;
						$array[$subkey]['netto_2'] = $BayarTbsOrderDetailRecord->netto_2;
						$array[$subkey]['harga'] = $BayarTbsOrderDetailRecord->harga;
						$array[$subkey]['jumlah_bongkar'] = $BayarTbsOrderDetailRecord->jumlah_bongkar;
						$array[$subkey]['fee'] = $BayarTbsOrderDetailRecord->fee;
						$array[$subkey]['ppn'] = $BayarTbsOrderDetailRecord->ppn;
						$array[$subkey]['pph'] = $BayarTbsOrderDetailRecord->pph;
					}
				}
			}
			
			$query = "SELECT
					SUM(
						tbt_pembayaran_tbs.jumlah_pembayaran
					) AS jumlah_pembayaran
				FROM
					tbt_pembayaran_tbs
				WHERE
					tbt_pembayaran_tbs.id_barang = '$idBarang'
				AND tbt_pembayaran_tbs.id_pemasok = '$idPemasok'
				AND tbt_pembayaran_tbs.tgl_tbs = '$tglTransaksi' ";
				
			$arrQuery = $this->queryAction($query,'S');
			
			$this->total_tbs_dibayar->Text = $arrQuery[0]['jumlah_pembayaran'];
			
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
		$tglTbs = $this->tglTbs->Value;
		$IdSatuan = BarangSatuanRecord::finder()->find('id_barang = ?  AND urutan = ? ',$idBarang,1)->id_satuan;
		$totalNettoMasuk = 0;
		$totalTbsMasuk = 0;
		$totalBayar = str_replace(",","",$this->jml_bayar->Text);
		$sisaBayar = str_replace(",","",$this->sisa_bayar->Text);
		
		
		
		$DetailBayar = $param->CallbackParameter->BayarTbsTable;
		$BayarTbsOrderRecord = new BayarTbsOrderRecord();
		$BayarTbsOrderRecord->no_pembayaran = $this->GenerateNoDocument('PAY');
		$BayarTbsOrderRecord->tgl_pembayaran  = date("Y-m-d");
		$BayarTbsOrderRecord->wkt_pembayaran = date("G:i:s");
		$BayarTbsOrderRecord->id_barang = $idBarang;
		$BayarTbsOrderRecord->id_pemasok = $idPemasok;
		$BayarTbsOrderRecord->tgl_tbs = $tglTbs;
		
		if($totalBayar >= $sisaBayar)
			$BayarTbsOrderRecord->jumlah_pembayaran = $sisaBayar;
		else
			$BayarTbsOrderRecord->jumlah_pembayaran = $totalBayar;
		
		$BayarTbsOrderRecord->id_coa = $this->DDCoa->Text;	
		$BayarTbsOrderRecord->jns_bayar = $this->DDJnsBayar->SelectedValue;
		
		if($this->DDJnsBayar->SelectedValue == '1')
			$BayarTbsOrderRecord->id_bank =$this->DDBank->SelectedValue; 
		else
			$BayarTbsOrderRecord->id_bank = '8';
				
		$BayarTbsOrderRecord->no_ref = $this->noRef->Text;
		$BayarTbsOrderRecord->deleted = '0';
		$BayarTbsOrderRecord->save();
		
		foreach($DetailBayar as $row)
		{		
			if($row->idPembayaranDetail == '')
			{
				$Record = new BayarTbsOrderDetailRecord();
				$Record->id_pembayaran = $BayarTbsOrderRecord->id;
				$Record->id_tbs_order = $row->idTransaksi;
				$Record->netto_1 = $row->netto_1;
				$Record->jumlah_bongkar = $row->jumlah_bongkar;
				$Record->subtotal_spsi = $row->subtotal_spsi;
				$Record->netto_2 = $row->netto_2;
				$Record->harga = $row->harga;
				$Record->subtotal_tbs = $row->subtotal_tbs;
				$Record->fee = $row->fee;
				$Record->subtotal_fee = $row->subtotal_fee;
				$Record->ppn = $row->ppn;
				$Record->pph = $row->pph;
				$Record->total_tbs_order = $row->total_tbs_order;
				$Record->deleted = '0';
				$Record->save(); 
				$totalNettoMasuk += $row->netto_2;
				$totalTbsMasuk += $row->subtotal_tbs;
				
				$msg = "Pembayaran TBS Telah Diproses";						
				$BarangHargaRecord = new BarangHargaRecord();
				$BarangHargaRecord->id_barang = $idBarang;
				$BarangHargaRecord->tgl = date("Y-m-d");
				$BarangHargaRecord->harga = $row->harga;
				$BarangHargaRecord->deleted = '0';
				$BarangHargaRecord->save();
			}
			
			$TbsOrderRecord = TbsOrderRecord::finder()->findByPk($row->idTransaksi);
			if($totalBayar >= $sisaBayar)	
				$TbsOrderRecord->status = '2';
			else
				$TbsOrderRecord->status = '1';
					
			$TbsOrderRecord->save();
		}
		
		if($totalNettoMasuk > 0 && $totalTbsMasuk > 0)
		{
			$expiredDate = '0000-00-00';		
				$sql = "SELECT 
								SUM(tbd_stok_barang.stok) AS stok
							FROM
								tbd_stok_barang
							WHERE
								tbd_stok_barang.deleted = '0' 
								AND tbd_stok_barang.id_barang = '".$idBarang."' ";
									
				$arr = $this->queryAction($sql,'S');
							
				if($arr[0]['stok'] > 0)
					$stokAwal = $arr[0]['stok'];
				else
					$stokAwal = 0;
								
				$qtyConversion = $this->getTargetUom($idBarang,$totalNettoMasuk,$IdSatuan,'1','0');
						
				$StockBarangRecord = StockBarangRecord::finder()->find('id_barang = ? AND expired_date = ? AND deleted = ?',$idBarang,$expiredDate,'0');
						
				if($StockBarangRecord)
				{
					$StockBarangRecord->stok += $qtyConversion;	
				}
				else
				{
					$StockBarangRecord = new StockBarangRecord();
					$StockBarangRecord->id_barang = $idBarang;
					$StockBarangRecord->stok = $qtyConversion;
					$StockBarangRecord->expired_date = $expiredDate;
					$StockBarangRecord->deleted = '0';
				}
						
				$StockBarangRecord->save();
						
				$StockInOutRecord = new StockInOutRecord();
				$StockInOutRecord->id_barang = $idBarang;
				$StockInOutRecord->stok_awal = $stokAwal;
				$StockInOutRecord->stok_in = $qtyConversion;
				$StockInOutRecord->nilai_in = $totalTbsMasuk;
				$StockInOutRecord->stok_out = 0;
				$StockInOutRecord->nilai_out = 0;
				$StockInOutRecord->stok_akhir = $stokAwal + $qtyConversion;
				$StockInOutRecord->keterangan = '';
				$StockInOutRecord->id_transaksi = $BayarTbsOrderRecord->id;
				$StockInOutRecord->jns_transaksi = "2";
				$StockInOutRecord->tgl = date("Y-m-d");
				$StockInOutRecord->wkt= date("G:i:s");
				$StockInOutRecord->username = $this->User->IsUser;
				$StockInOutRecord->save();
		}
				
		$supplierName = PemasokRecord::finder()->findByPk($this->idPemasok->Value)->nama;
		$this->InsertJurnalBukuBesar($BayarTbsOrderRecord->id,
									'2',
									'1',
									$BayarTbsOrderRecord->no_pembayaran,
									$BayarTbsOrderRecord->tgl_pembayaran,
									date("G:i:s"),
									$BayarTbsOrderRecord->id_coa,
									$BayarTbsOrderRecord->id_bank,
									'Pembayaran Pembelian Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
									$BayarTbsOrderRecord->jumlah_pembayaran);
			
			$this->InsertLabaRugi($BayarTbsOrderRecord->id,
								'2',
								'1',
								$BayarTbsOrderRecord->tgl_pembayaran,
								date("G:i:s"),
								'Pembayaran Pembelian Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
								$BayarTbsOrderRecord->jumlah_pembayaran,
								$BayarTbsOrderRecord->no_pembayaran);
			
			$this->InsertJurnalUmum($BayarTbsOrderRecord->id,
								'3',
								'0',
								$BayarTbsOrderRecord->tgl_pembayaran,
								date("G:i:s"),
								'Perlengkapan',
								$BayarTbsOrderRecord->jumlah_pembayaran,
								$BayarTbsOrderRecord->no_pembayaran);
									
			$this->InsertJurnalUmum($BayarTbsOrderRecord->id,
									'3',
									'1',
									$BayarTbsOrderRecord->tgl_pembayaran,
									date("G:i:s"),
									'Kas',
									$BayarTbsOrderRecord->jumlah_pembayaran,
									$BayarTbsOrderRecord->no_pembayaran);
						
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
