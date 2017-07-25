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
			$tblBodyHistory = $this->BindGridHistory();
			$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						jQuery("#table-2 tbody").append("'.$tblBodyHistory.'");');	
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
				AND (tbt_tbs_order.`status` = '0' OR tbt_tbs_order.`status` = '1' OR tbt_tbs_order.`status` = '2')
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
		var_dump($id);
		if($TbsOrderRecord->status == '1')
			$this->jatuh_tempo->Text = $this->ConvertDate($TbsOrderRecord->tgl_jatuh_tempo,'1');
		else
			$this->jatuh_tempo->Text = '';
		
		$this->Pemasok->Text = $nmPemasok;
		$this->jnsKelapaSawit->Text = $nmbarang;
		
			$this->modalJudul->Text = 'Proses Pembayaran';
			
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
			
			$query = "SELECT
					SUM(
						tbt_pembayaran_tbs.jumlah_pembayaran
					) AS jumlah_pembayaran
				FROM
					tbt_pembayaran_tbs
				WHERE
					tbt_pembayaran_tbs.id_tbs_order = '$id'
					AND tbt_pembayaran_tbs.deleted = '0' ";
				
			$arrQuery = $this->queryAction($query,'S');
			
			$sudahDibayar = 0;
			foreach($arrQuery as $rowQuery)
			{
				$sudahDibayar += $rowQuery['jumlah_pembayaran'];
			}
			
			$this->total_tbs_dibayar->Text = $sudahDibayar;
			
			$arrJson = json_encode($array,true);	
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					RenderTempTable('.$arrJson.');
					jQuery("#modal-1").modal("show");
					');	
		
	}
	
	public function importBtnClicked($sender,$param)
	{
		$sql = "SELECT
					*
				FROM
					tbm_kategori_pelanggan
				WHERE
					deleted = '0'";
					
		$arr = $this->queryAction($sql,'S');
		foreach($arr as $row)
		{
			$idLama = $row['id'];
			$PemasokKategoriRecord = new PemasokKategoriRecord();
			$PemasokKategoriRecord->jenis_kategori = '1';
			$PemasokKategoriRecord->nama = $row['nama'];
			$PemasokKategoriRecord->ppn = 0;
			$PemasokKategoriRecord->pph = 0;
			$PemasokKategoriRecord->deleted = 0;
			$PemasokKategoriRecord->save();
			
			$sqlUpdate = "UPDATE tbm_pelanggan SET kategori_id = '".$PemasokKategoriRecord->id."' WHERE kategori_id = '".$idLama."' ";
			$this->queryAction($sqlUpdate,'C');
		}
		
		$sql = "SELECT
					*
				FROM
					tbm_pelanggan
				WHERE
					deleted = '0'";
					
		$arr = $this->queryAction($sql,'S');
		foreach($arr as $row)
		{
			$PemasokRecord = new PemasokRecord();
			$PemasokRecord->kategori_id = $row['kategori_id'];
			$PemasokRecord->nama = $row['nama'];
			$PemasokRecord->alamat = $row['alamat'];
			$PemasokRecord->telepon = $row['telepon'];
			$PemasokRecord->fax = '';
			$PemasokRecord->contact_person = '';
			$PemasokRecord->fee = 0;
			$PemasokRecord->no_sp = '0';
			$PemasokRecord->id_kategori_harga = '0';
			$PemasokRecord->deleted = 0;
			$PemasokRecord->save();
			
		}
		
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
		$total_tbs = str_replace(",","",$this->total_tbs->Text);
		$totalBayar = str_replace(",","",$this->jml_bayar->Text);
		$sisaBayar = str_replace(",","",$this->sisa_bayar->Text);
		
		$TbsOrderRecord = TbsOrderRecord::finder()->findByPk($idTbsOrder);
		
		$statusLama = $TbsOrderRecord->status;
		
		if($totalBayar >= $sisaBayar)
		{
			$TbsOrderRecord->status = '3';
			$statusBaru = '3';
		}
		else
		{
			if($TbsOrderRecord->status == '0' || $TbsOrderRecord->status == '1')
			{
				$TbsOrderRecord->status = '2';
				$TbsOrderRecord->tgl_jatuh_tempo = $this->ConvertDate($this->jatuh_tempo->Text,'2');
				$statusBaru = '2';
			}
			elseif($TbsOrderRecord->status == '2')
			{
				$TbsOrderRecord->status = '2';
				$statusBaru = '2';
			}
		}
		
		$TbsOrderRecord->save();
		
		$DetailBayar = $param->CallbackParameter->BayarTbsTable;
		$BayarTbsOrderRecord = new BayarTbsOrderRecord();
		$BayarTbsOrderRecord->no_pembayaran = $this->GenerateNoDocument('PAY');
		$BayarTbsOrderRecord->tgl_pembayaran  = date("Y-m-d");
		$BayarTbsOrderRecord->wkt_pembayaran = date("G:i:s");
		$BayarTbsOrderRecord->id_tbs_order = $idTbsOrder;
		
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
			if($row->status == '0' || $row->status == '1')
			{
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
				}
				
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
		
			if($totalBayar > 0)
			{	
				if(($statusLama == '0' || $statusLama == '1') &&  $statusBaru == '3')	
				{
					if($BayarTbsOrderRecord->id_bank != '8')	
						$namaAkun = 'Kas Bank';
					else
						$namaAkun = 'Kas';
						
					$this->UbahSaldoKas('1',$BayarTbsOrderRecord->id_bank,$BayarTbsOrderRecord->jumlah_pembayaran);
					
					$this->InsertJurnalUmum($BayarTbsOrderRecord->id,
											'3',
											'0',
											$BayarTbsOrderRecord->tgl_pembayaran,
											date("G:i:s"),
											'Persediaan Bahan Baku',
											$BayarTbsOrderRecord->jumlah_pembayaran,
											$BayarTbsOrderRecord->no_pembayaran);
											
					$this->InsertJurnalUmum($BayarTbsOrderRecord->id,
											'3',
											'1',
											$BayarTbsOrderRecord->tgl_pembayaran,
											date("G:i:s"),
											'Kas',
											$BayarTbsOrderRecord->jumlah_pembayaran,
											$BayarTbsOrderRecord->no_pembayaran,
											$BayarTbsOrderRecord->id_bank);
											
					$this->InsertJurnalBukuBesar($BayarTbsOrderRecord->id,
												'4',
												'1',
												$BayarTbsOrderRecord->no_pembayaran,
												$BayarTbsOrderRecord->tgl_pembayaran,
												date("G:i:s"),
												$BayarTbsOrderRecord->id_coa,
												$BayarTbsOrderRecord->id_bank,
												$namaAkun,
												'Pembayaran Pembelian Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
												$BayarTbsOrderRecord->jumlah_pembayaran);
																	
					$this->InsertJurnalBukuBesar($BayarPoOrderRecord->id,
												'4',
												'0',
												$BayarTbsOrderRecord->no_pembayaran,
												$BayarTbsOrderRecord->tgl_pembayaran,
												date("G:i:s"),
												$BayarTbsOrderRecord->id_coa,
												$BayarTbsOrderRecord->id_bank,
												"Persediaan Bahan Baku",
												'Pembayaran Pembelian Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
												$BayarTbsOrderRecord->jumlah_pembayaran);
					
					$keterangan = 'Pembelian Tunai Kepada '.$supplierName;
					$this->InsertJurnalPengeluaranKas($BayarTbsOrderRecord->id,
													$BayarTbsOrderRecord->no_pembayaran,
													'2',
													$BayarTbsOrderRecord->tgl_pembayaran,
													date("G:i:s"),
													$keterangan,
													'',
													'',
													$BayarTbsOrderRecord->jumlah_pembayaran,
													0);	
									
				}
				elseif(($statusLama == '0' || $statusLama == '1') &&  $statusBaru == '2')
				{
					if($BayarTbsOrderRecord->id_bank != '8')	
						$namaAkun = 'Kas Bank';
					else
						$namaAkun = 'Kas';
						
					$this->UbahSaldoKas('1',$BayarTbsOrderRecord->id_bank,$BayarTbsOrderRecord->jumlah_pembayaran);
					
					$this->InsertJurnalUmum($BayarTbsOrderRecord->id,
											'3',
											'0',
											$BayarTbsOrderRecord->tgl_pembayaran,
											date("G:i:s"),
											'Persediaan Bahan Baku',
											$total_tbs,
											$BayarTbsOrderRecord->no_pembayaran);
											
					$this->InsertJurnalUmum($BayarTbsOrderRecord->id,
											'3',
											'1',
											$BayarTbsOrderRecord->tgl_pembayaran,
											date("G:i:s"),
											'Hutang',
											$total_tbs - $totalBayar,
											$BayarTbsOrderRecord->no_pembayaran);	
																
					$this->InsertJurnalUmum($BayarTbsOrderRecord->id,
											'3',
											'1',
											$BayarTbsOrderRecord->tgl_pembayaran,
											date("G:i:s"),
											'Kas',
											$BayarTbsOrderRecord->jumlah_pembayaran,
											$BayarTbsOrderRecord->no_pembayaran,
											$BayarTbsOrderRecord->id_bank);
											
					$this->InsertJurnalBukuBesar($BayarTbsOrderRecord->id,
												'4',
												'1',
												$BayarTbsOrderRecord->no_pembayaran,
												$BayarTbsOrderRecord->tgl_pembayaran,
												date("G:i:s"),
												$BayarTbsOrderRecord->id_coa,
												$BayarTbsOrderRecord->id_bank,
												$namaAkun,
												'Pembelian Secara Kredit & Tunai Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
												$BayarTbsOrderRecord->jumlah_pembayaran);
																	
					$this->InsertJurnalBukuBesar($BayarPoOrderRecord->id,
												'4',
												'0',
												$BayarTbsOrderRecord->no_pembayaran,
												$BayarTbsOrderRecord->tgl_pembayaran,
												date("G:i:s"),
												$BayarTbsOrderRecord->id_coa,
												$BayarTbsOrderRecord->id_bank,
												"Persediaan Bahan Baku",
												'Pembelian Secara Kredit & Tunai Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
												$total_tbs);
					
					$this->InsertJurnalBukuBesar($BayarPoOrderRecord->id,
												'4',
												'0',
												$BayarTbsOrderRecord->no_pembayaran,
												$BayarTbsOrderRecord->tgl_pembayaran,
												date("G:i:s"),
												$BayarTbsOrderRecord->id_coa,
												$BayarTbsOrderRecord->id_bank,
												"Hutang",
												'Pembelian Secara Kredit & Tunai Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
												$total_tbs - $totalBayar);
																			
					$keterangan = $supplierName;
					$this->InsertJurnalPengeluaranKas($BayarTbsOrderRecord->id,
													$BayarTbsOrderRecord->no_pembayaran,
													'1',
													$BayarTbsOrderRecord->tgl_pembayaran,
													date("G:i:s"),
													$keterangan,
													'',
													'',
													$BayarTbsOrderRecord->jumlah_pembayaran,
													0);	
													
					$this->InsertJurnalPembelian($TbsOrderRecord->id,
										$TbsOrderRecord->no_tbs_order,
										'1',
										date("Y-m-d"),
										date("G:i:s"),
										$supplierName,
										'',
										'',
										$total_tbs - $totalBayar);
													
				}
				elseif($statusLama == '2' &&  $statusBaru == '2')
				{
					if($BayarTbsOrderRecord->id_bank != '8')	
						$namaAkun = 'Kas Bank';
					else
						$namaAkun = 'Kas';
						
					$this->UbahSaldoKas('1',$BayarTbsOrderRecord->id_bank,$BayarTbsOrderRecord->jumlah_pembayaran);
											
					$this->InsertJurnalUmum($BayarTbsOrderRecord->id,
											'3',
											'0',
											$BayarTbsOrderRecord->tgl_pembayaran,
											date("G:i:s"),
											'Hutang',
											$BayarTbsOrderRecord->jumlah_pembayaran,
											$BayarTbsOrderRecord->no_pembayaran);	
																
					$this->InsertJurnalUmum($BayarTbsOrderRecord->id,
											'3',
											'1',
											$BayarTbsOrderRecord->tgl_pembayaran,
											date("G:i:s"),
											'Kas',
											$BayarTbsOrderRecord->jumlah_pembayaran,
											$BayarTbsOrderRecord->no_pembayaran,
											$BayarTbsOrderRecord->id_bank);
											
					$this->InsertJurnalBukuBesar($BayarTbsOrderRecord->id,
												'4',
												'1',
												$BayarTbsOrderRecord->no_pembayaran,
												$BayarTbsOrderRecord->tgl_pembayaran,
												date("G:i:s"),
												$BayarTbsOrderRecord->id_coa,
												$BayarTbsOrderRecord->id_bank,
												$namaAkun,
												'Pembayaran Pembelian Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
												$BayarTbsOrderRecord->jumlah_pembayaran);
					
					$this->InsertJurnalBukuBesar($BayarPoOrderRecord->id,
												'4',
												'1',
												$BayarTbsOrderRecord->no_pembayaran,
												$BayarTbsOrderRecord->tgl_pembayaran,
												date("G:i:s"),
												$BayarTbsOrderRecord->id_coa,
												$BayarTbsOrderRecord->id_bank,
												"Hutang",
												'Pembayaran Pembelian Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
												$BayarTbsOrderRecord->jumlah_pembayaran);
																			
					$keterangan = $supplierName;
					$this->InsertJurnalPengeluaranKas($BayarTbsOrderRecord->id,
													$BayarTbsOrderRecord->no_pembayaran,
													'1',
													$BayarTbsOrderRecord->tgl_pembayaran,
													date("G:i:s"),
													$keterangan,
													'',
													'',
													$BayarTbsOrderRecord->jumlah_pembayaran,
													0);	
				}
				
				/*$this->InsertLabaRugi($BayarTbsOrderRecord->id,
									'2',
									'1',
									$BayarTbsOrderRecord->tgl_pembayaran,
									date("G:i:s"),
									'Pembayaran Pembelian Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
									$BayarTbsOrderRecord->jumlah_pembayaran,
									$BayarTbsOrderRecord->no_pembayaran);*/
				
			}
			else
			{
				$this->InsertJurnalUmum($BayarTbsOrderRecord->id,
											'3',
											'0',
											$BayarTbsOrderRecord->tgl_pembayaran,
											date("G:i:s"),
											'Persediaan Bahan Baku',
											$total_tbs,
											$BayarTbsOrderRecord->no_pembayaran);
											
				$this->InsertJurnalUmum($BayarTbsOrderRecord->id,
											'3',
											'1',
											$BayarTbsOrderRecord->tgl_pembayaran,
											date("G:i:s"),
											'Hutang',
											$total_tbs,
											$BayarTbsOrderRecord->no_pembayaran);	
																
				
											
					$this->InsertJurnalBukuBesar($BayarPoOrderRecord->id,
												'4',
												'0',
												$BayarTbsOrderRecord->no_pembayaran,
												$BayarTbsOrderRecord->tgl_pembayaran,
												date("G:i:s"),
												'',
												'',
												"Persediaan Bahan Baku",
												'Pembelian Secara Kredit Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
												$total_tbs);
					
					$this->InsertJurnalBukuBesar($BayarPoOrderRecord->id,
												'4',
												'0',
												$BayarTbsOrderRecord->no_pembayaran,
												$BayarTbsOrderRecord->tgl_pembayaran,
												date("G:i:s"),
												$BayarTbsOrderRecord->id_coa,
												$BayarTbsOrderRecord->id_bank,
												"Hutang",
												'Pembelian Secara Kredit Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
												$total_tbs);
			}
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
							var url = "'.$urlTemp.'";
							window.open(url, "_blank");
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
