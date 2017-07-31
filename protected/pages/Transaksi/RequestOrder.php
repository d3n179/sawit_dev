<?PHP
class RequestOrder extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			
			/*$sqlBarang = "SELECT
							tbm_barang.id,
							tbm_barang.nama
						FROM
							tbm_barang
						INNER JOIN 
							tbm_kategori_barang ON tbm_kategori_barang.id = tbm_barang.kategori_id
						WHERE
							tbm_barang.deleted = '0' 
							AND tbm_kategori_barang.tipe_kategori = '0' ";
					
			$arrBarang = $this->queryAction($sqlBarang,'S');
			$this->DDBarang->DataSource = $arrBarang;
			$this->DDBarang->DataBind();*/
			
		}
		
	}
	
	public function onPreRender($param)
	{
		parent::onPreRender($param);
		
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','jQuery("#table-1 tbody").append("'.$tblBody.'");');	
		}
	}
	
	public function barangChanged()
	{
		$idBarang = $this->DDBarang->Text;
		if($idBarang != '')
		{
			
			$sqlSatuan = "SELECT
							tbm_satuan.id,
							tbm_satuan.nama
						FROM
							tbm_satuan
						INNER JOIN tbm_satuan_barang ON tbm_satuan_barang.id_satuan = tbm_satuan.id
						WHERE
							tbm_satuan.deleted = '0'
						AND tbm_satuan_barang.deleted = '0'
						AND tbm_satuan_barang.id_barang = '$idBarang' ";
			var_dump($sqlSatuan);			
			$arrSatuan = $this->queryAction($sqlSatuan,'S');
			$this->DDSatuan->DataSource = $arrSatuan;
			$this->DDSatuan->DataBind();
			
		}
		else
		{
			$this->DDSatuan->SelectedValue = '';
			$this->Jumlah->Text = '';
		}
	}
	
	public function satuanChanged()
	{
		$idBarang = $this->DDBarang->Text;
		$idSatuan = $this->DDSatuan->SelectedValue;
		var_dump($idBarang);
		var_dump($idSatuan);	
		$hargaSatuanBesar = $this->GetLastProductPrice($idBarang);
		
		if($hargaSatuanBesar > 0)
		{
			$hargaPerSatuan = $this->checkConversionPrice($idBarang,$idSatuan,$hargaSatuanBesar);
		}
		else
		{
			$hargaPerSatuan = 0;
		}
		
		$this->hargaSatuanBesar->Value = $hargaSatuanBesar;
		$this->harga->Text = $hargaPerSatuan;
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_request_order.id,
					tbt_request_order.`status`,
					tbt_request_order.no_ro,
					tbt_request_order.tgl_ro,
					tbt_request_order.catatan,
					COUNT(
						tbt_request_order_detail.id
					) AS jml_item,
					SUM(
						tbt_request_order_detail.subtotal
					) AS total_biaya
				FROM
					tbt_request_order
				INNER JOIN tbt_request_order_detail ON tbt_request_order_detail.id_ro = tbt_request_order.id
				WHERE
					tbt_request_order.deleted = '0'
				AND tbt_request_order_detail.deleted = '0'
				GROUP BY
					tbt_request_order.id
				ORDER BY 
					tbt_request_order.id ASC ";
		$arr = $this->queryAction($sql,'S');
		
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($arr as $row)
			{
				
				if($row['status'] == '0')
				{
					$status = '<div class=\"label label-secondary\">NEW</div>';
					$actionBtn = '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
					$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';
				}
				elseif($row['status'] == '1')
				{
					$status = '<div class=\"label label-success\">DITERIMA</div>';
					$actionBtn = '';
				}
				elseif($row['status'] == '2')
				{
					$status = '<div class=\"label label-danger\">DITOLAK</div>';
					$actionBtn = '';
				}
				
				$tglRo = $this->ConvertDate($row['tgl_ro'],'3');
				$tblBody .= '<tr>';
				$tblBody .= '<td class=\"details-control dont_shown\"><input type=\"hidden\" value=\"'.$row['id'].'\"></td>';
				$tblBody .= '<td align=\"center\">'.$status.'</td>';
				$tblBody .= '<td>'.$row['no_ro'].'</td>';
				$tblBody .= '<td>'.$tglRo.'</td>';
				$tblBody .= '<td>'.$row['jml_item'].'</td>';
				$tblBody .= '<td>'.number_format($row['total_biaya'],2,'.',',').'</td>';
				$tblBody .= '<td>'.$row['catatan'].'</td>';
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
		$RequestOrderRecord = RequestOrderRecord::finder()->findByPk($id);
		if($RequestOrderRecord)
		{
			$this->modalJudul->Text = 'Edit Request Order';
			$this->idRo->Value = $id;
			$this->tglRo->Text = $this->ConvertDate($RequestOrderRecord->tgl_ro,'1');
			$this->catatan->Text = $RequestOrderRecord->catatan;
			$sql = "SELECT
						tbt_request_order_detail.id,
						tbt_request_order_detail.id_barang,
						tbm_barang.nama,
						tbt_request_order_detail.id_satuan,
						tbm_satuan.nama AS satuan,
						tbt_request_order_detail.harga_satuan_besar,
						tbt_request_order_detail.harga_satuan,
						tbt_request_order_detail.jumlah,
						tbt_request_order_detail.subtotal
					FROM
						tbt_request_order_detail
					INNER JOIN tbm_barang ON tbm_barang.id = tbt_request_order_detail.id_barang
					INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_request_order_detail.id_satuan
					WHERE
						tbt_request_order_detail.deleted = '0'
					AND tbt_request_order_detail.id_ro = '$id'
					ORDER BY
						tbt_request_order_detail.id ASC ";
			$arr = $this->queryAction($sql,'S');
			$arrJson = json_encode($arr,true);
			var_dump($arrJson);
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					RenderTempTable('.$arrJson.');
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
		$RequestOrderRecord = RequestOrderRecord::finder()->findByPk($id);
		if($RequestOrderRecord)
		{
			$RequestOrderRecord->deleted = '1';
			$RequestOrderRecord->save();
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
		$tglRO = $this->tglRo->Text;
		$detailRO = $param->CallBackParameter->RequestOrderTable;
		var_dump($detailRO);
		if($this->idRo->Value != '')
		{
			$RequestOrderRecord = RequestOrderRecord::finder()->findByPk($this->idRo->Value);
			$msg = "Data Berhasil Diedit";
		}
		else
		{
			$RequestOrderRecord = new RequestOrderRecord();
			$msg = "Data Berhasil Disimpan";
			$RequestOrderRecord->no_ro = $this->GenerateNoDocument('RO');
			$RequestOrderRecord->status = '0';
		}
			
			$RequestOrderRecord->tgl_ro = $this->ConvertDate($tglRO,'2');
			$RequestOrderRecord->catatan = $this->catatan->Text;
			$RequestOrderRecord->save();
				
			foreach($detailRO as $row)
			{
				if($row->id_edit != '')
				{
					$RequestOrderDetailRecord =  RequestOrderDetailRecord::finder()->findByPk($row->id_edit);
				}
				else
				{
					$RequestOrderDetailRecord = new RequestOrderDetailRecord();
					$RequestOrderDetailRecord->status = '0'; 
				}
				
				$RequestOrderDetailRecord->id_ro = $RequestOrderRecord->id;
				$RequestOrderDetailRecord->id_barang = $row->IdBarang;
				$RequestOrderDetailRecord->id_satuan = $row->IdSatuan;
				$RequestOrderDetailRecord->jumlah = $row->Jumlah;
				$RequestOrderDetailRecord->harga_satuan_besar = $row->hargaSatuanBesar;
				$RequestOrderDetailRecord->harga_satuan = $row->harga;
				$RequestOrderDetailRecord->subtotal = $row->subtotal;
				$RequestOrderDetailRecord->deleted = $row->deleted;
				$RequestOrderDetailRecord->save();
			}
			
			$this->idRo->Value = '';
			$this->tglRo->Text = '';
			$tblBody = $this->BindGrid();
			
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("'.$msg.'");
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");');	
		
	}
	
	public function checkMaxBeli()
	{
		$Barang = $this->DDBarang->Text;
		$Satuan = $this->DDSatuan->SelectedValue;
		$Jumlah = $this->Jumlah->Text;
		
		$idMaxSatuan = BarangSatuanRecord::finder()->find('urutan = ? AND id_barang = ? AND deleted = ?','1',$Barang,'0')->id_satuan;
		$MaxBeliBulanan = BarangRecord::finder()->findByPk($Barang)->max_beli_bulanan;
		if($MaxBeliBulanan > 0)
		{
			$sqlStock = "SELECT
								SUM(tbd_stok_barang.stok) AS stok
							FROM
								tbd_stok_barang
							WHERE
								tbd_stok_barang.expired_date > CURDATE()
							AND id_barang = '$Barang'
							AND deleted != '1' ";
			$arrStock = $this->queryAction($sqlStock,'S');
			$CurrentStock = $arrStock[0]['stok'];
			$CurrentStock = $this->getTargetUom($Barang,$CurrentStock,'0','1',$idMaxSatuan);
			
			$AddStock = $Jumlah;
			$AddStock = $this->getTargetUom($Barang,$AddStock,$Satuan,'1',$idMaxSatuan);
			
			$TotalStock = $CurrentStock + $AddStock;
			if($TotalStock > $MaxBeliBulanan)
			{
				$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						toastr.error("Jumlah Pembelian Bulanan telah melebihi maksimum pembelian bulanan !");
						');
			}
			else
			{
				$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						addBarang();
						');
			}
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						addBarang();
						');
		}
		
	}
	
	public function generateDetailCallback($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		
		$sql = "SELECT
					tbt_request_order_detail.id,
					tbt_request_order_detail.id_barang,
					tbm_barang.nama,
					tbt_request_order_detail.id_satuan,
					tbm_satuan.nama AS satuan,
					tbt_request_order_detail.harga_satuan_besar,
					tbt_request_order_detail.harga_satuan,
					tbt_request_order_detail.jumlah,
					tbt_request_order_detail.subtotal
				FROM
					tbt_request_order_detail
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_request_order_detail.id_barang
				INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_request_order_detail.id_satuan
				WHERE
					tbt_request_order_detail.deleted = '0'
				AND tbt_request_order_detail.id_ro = '$id'
				ORDER BY
					tbt_request_order_detail.id ASC ";
					
		$arr = $this->queryAction($sql,'S');
		var_dump($sql);
		if(count($arr) > 0)
		{
			foreach($arr as $row)
			{
					$tblBody .= '<tr>';
					$tblBody .= '<td>'.$row['nama'].'</td>';
					$tblBody .= '<td>'.$row['satuan'].'</td>';
					$tblBody .= '<td>'.number_format($row['harga_satuan'],2,'.',',').'</td>';
					$tblBody .= '<td>'.$row['jumlah'].'</td>';	
					$tblBody .= '<td>'.number_format($row['subtotal'],2,'.',',').'</td>';			
					$tblBody .= '</tr>';
			}
		}
		$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#tableDetail-'.$id.' tbody").empty();
					jQuery("#tableDetail-'.$id.' tbody").append("'.$tblBody.'");
					unloadContent();');
	}
	
	public function importBtnClicked()
	{
		$sql = "SELECT
						transaksi_po_januari.NO_PO,
						transaksi_po_januari.TGL_PO,
						transaksi_po_januari.PPN,
						transaksi_po_januari.PEMASOK,
						transaksi_po_januari.ALAMAT_PEMASOK,
						(SELECT tbm_pemasok.id FROM tbm_pemasok WHERE lower(tbm_pemasok.nama) = lower(transaksi_po_januari.PEMASOK) AND tbm_pemasok.deleted = '0' LIMIT 1) AS id_pemasok
					FROM
						transaksi_po_januari
					WHERE
						NO_PO != ''
					AND TGL_PO != ''
					AND PEMASOK != ''
					AND ALAMAT_PEMASOK != ''
					GROUP BY NO_PO ";
		$arr = $this->queryAction($sql,'S');
		foreach($arr as $row)
		{
			$noPO = $row['NO_PO'];
			$PPN = $row['PPN'];
			$tglPO = $row['TGL_PO'];
			$arrTglPO = explode("/",$tglPO);
			
			if($arrTglPO[0] < 10)
				$tglFormat = '0'.$arrTglPO[0];
			
			if($arrTglPO[1] < 10)
				$blnFormat = '0'.$arrTglPO[1];
					
			$PODATE = $arrTglPO[2].'-'.$blnFormat.'-'.$tglFormat;
			
			$RequestOrderRecord = new RequestOrderRecord();
			$RequestOrderRecord->no_ro = $this->GenerateNoDocument('RO');
			$RequestOrderRecord->status = '2';
			$RequestOrderRecord->tgl_ro = $PODATE;
			$RequestOrderRecord->catatan = '';
			$RequestOrderRecord->save();
			
			$ROID = $RequestOrderRecord->id;
			
			$PurchaseOrderRecord = new PurchaseOrderRecord();
			$PurchaseOrderRecord->no_po = $this->GenerateNoDocument('PO');
			$PurchaseOrderRecord->tgl_po = $PODATE;
			$PurchaseOrderRecord->id_ro = $ROID;
			$PurchaseOrderRecord->id_supplier = $row['id_pemasok'];
			$PurchaseOrderRecord->ppn = $PPN;
			$PurchaseOrderRecord->dp = 0;
			$PurchaseOrderRecord->status = '3';
			$PurchaseOrderRecord->deleted = '0';
			$PurchaseOrderRecord->save();
			$POID = $PurchaseOrderRecord->id;
			
			$ReceivingOrderRecord = new ReceivingOrderRecord();
			$ReceivingOrderRecord->no_document = $this->GenerateNoDocument('RC');
			$ReceivingOrderRecord->tgl_terima = $PODATE;
			$ReceivingOrderRecord->no_faktur = $noPO;
			$ReceivingOrderRecord->id_po = $POID;
			$ReceivingOrderRecord->save();
			$RECOID = $ReceivingOrderRecord->id;
			
			$TotalPO = 0;
			$sqlDetail = "SELECT
							transaksi_po_januari.NAMA_ITEM,
							transaksi_po_januari.JUMLAH,
							transaksi_po_januari.HARGA_SATUAN,
							(
								SELECT
									tbm_barang.id
								FROM
									tbm_barang
								WHERE
									lower(tbm_barang.nama) = transaksi_po_januari.NAMA_ITEM
								AND tbm_barang.deleted != '1'
								LIMIT 1
							) AS id_barang,
							transaksi_po_januari.SATUAN,
							(
								SELECT
									tbm_satuan.id
								FROM
									tbm_satuan
								WHERE
									lower(tbm_satuan.singkatan) = transaksi_po_januari.SATUAN
								AND tbm_satuan.deleted != '1'
								LIMIT 1
							) AS id_satuan
						FROM
							transaksi_po_januari
						WHERE transaksi_po_januari.NO_PO = '".$noPO."' ";
			$arrDetail = $this->queryAction($sqlDetail,'S');
			foreach($arrDetail as $rowDetail)
			{
				$RequestOrderDetailRecord = new RequestOrderDetailRecord();
				$RequestOrderDetailRecord->status = '1'; 
				$RequestOrderDetailRecord->id_ro = $ROID;
				$RequestOrderDetailRecord->id_barang = $rowDetail['id_barang'];
				$RequestOrderDetailRecord->id_satuan = $rowDetail['id_satuan'];
				$RequestOrderDetailRecord->jumlah = $rowDetail['JUMLAH'];
				$RequestOrderDetailRecord->harga_satuan_besar = $rowDetail['HARGA_SATUAN'];
				$RequestOrderDetailRecord->harga_satuan = $rowDetail['HARGA_SATUAN'];
				$RequestOrderDetailRecord->subtotal = $rowDetail['HARGA_SATUAN'] * $rowDetail['JUMLAH'];
				$RequestOrderDetailRecord->deleted = '0';
				$RequestOrderDetailRecord->save();
				
				$PurchaseOrderDetailRecord = new PurchaseOrderDetailRecord();
				$PurchaseOrderDetailRecord->status = '1'; 
				$PurchaseOrderDetailRecord->id_ro_detail = $RequestOrderDetailRecord->id;
				$PurchaseOrderDetailRecord->id_po = $POID;
				$PurchaseOrderDetailRecord->id_barang = $rowDetail['id_barang'];
				$PurchaseOrderDetailRecord->id_satuan = $rowDetail['id_satuan'];
				$PurchaseOrderDetailRecord->jumlah = $rowDetail['JUMLAH'];
				$PurchaseOrderDetailRecord->jumlah_diterima = $rowDetail['JUMLAH'];
				$PurchaseOrderDetailRecord->harga_satuan_besar = $rowDetail['HARGA_SATUAN'];
				$PurchaseOrderDetailRecord->harga_satuan = $rowDetail['HARGA_SATUAN'];
				$PurchaseOrderDetailRecord->discount = 0;
				$PurchaseOrderDetailRecord->subtotal = $rowDetail['HARGA_SATUAN'] * $rowDetail['JUMLAH'];
				$PurchaseOrderDetailRecord->deleted = '0';
				$PurchaseOrderDetailRecord->save();
				
				$ReceivingOrderDetailRecord = new ReceivingOrderDetailRecord();
				$ReceivingOrderDetailRecord->id_po_detail = $PurchaseOrderDetailRecord->id;
				$ReceivingOrderDetailRecord->id_parent = $RECOID;
				$ReceivingOrderDetailRecord->id_barang = $rowDetail['id_barang'];
				$ReceivingOrderDetailRecord->id_satuan = $rowDetail['id_satuan'];
				$ReceivingOrderDetailRecord->jumlah = $rowDetail['JUMLAH'];
				$ReceivingOrderDetailRecord->expired_date = '0000-00-00';
				$ReceivingOrderDetailRecord->harga_satuan = $rowDetail['HARGA_SATUAN'];
				$ReceivingOrderDetailRecord->harga_satuan_besar = $rowDetail['HARGA_SATUAN'];
				$ReceivingOrderDetailRecord->discount = 0;
				$ReceivingOrderDetailRecord->subtotal = $rowDetail['HARGA_SATUAN'] * $rowDetail['JUMLAH'];
				$ReceivingOrderDetailRecord->deleted = '0';
				$ReceivingOrderDetailRecord->save();
				
				$BarangHargaRecord = new BarangHargaRecord();
				$BarangHargaRecord->id_barang = $rowDetail['id_barang'];
				$BarangHargaRecord->tgl = $PODATE;
				$BarangHargaRecord->harga = $rowDetail['HARGA_SATUAN'];
				$BarangHargaRecord->deleted = '0';
				$BarangHargaRecord->save();
				
				$TotalPO +=  $rowDetail['HARGA_SATUAN'] * $rowDetail['JUMLAH'];
				$nilaiIn = $rowDetail['HARGA_SATUAN'] * $rowDetail['JUMLAH'];
				
				$sqlStok = "SELECT 
								SUM(tbd_stok_barang.stok) AS stok
							FROM
								tbd_stok_barang
							WHERE
								tbd_stok_barang.deleted = '0' 
								AND tbd_stok_barang.id_barang = '".$rowDetail['id_barang']."' ";
							
				$arrStok = $this->queryAction($sqlStok,'S');
					
				if($arrStok[0]['stok'] > 0)
					$stokAwal = $arrStok[0]['stok'];
				else
					$stokAwal = 0;
					
				$qtyConversion = $this->getTargetUom($rowDetail['id_barang'],$rowDetail['JUMLAH'],$rowDetail['id_satuan'],'1','0');
				
				$StockBarangRecord = StockBarangRecord::finder()->find('id_barang = ? AND deleted = ?',$rowDetail['id_barang'],'0');
				
				if($StockBarangRecord)
				{
					$StockBarangRecord->stok += $qtyConversion;	
				}
				else
				{
					$StockBarangRecord = new StockBarangRecord();
					$StockBarangRecord->id_barang = $rowDetail['id_barang'];
					$StockBarangRecord->stok = $qtyConversion;
					$StockBarangRecord->expired_date = '0000-00-00';
					$StockBarangRecord->deleted = '0';
				}
				
				$StockBarangRecord->save();
				
				$StockInOutRecord = new StockInOutRecord();
				$StockInOutRecord->id_barang = $rowDetail['id_barang'];
				$StockInOutRecord->stok_awal = $stokAwal;
				$StockInOutRecord->stok_in = $qtyConversion;
				$StockInOutRecord->nilai_in = $nilaiIn;
				$StockInOutRecord->stok_out = 0;
				$StockInOutRecord->nilai_out = 0;
				$StockInOutRecord->stok_akhir = $stokAwal + $qtyConversion;
				$StockInOutRecord->keterangan = '';
				$StockInOutRecord->id_transaksi = $ReceivingOrderDetailRecord->id;
				$StockInOutRecord->jns_transaksi = "1";
				$StockInOutRecord->tgl = $PODATE;
				$StockInOutRecord->wkt= date("G:i:s");
				$StockInOutRecord->username = $this->User->IsUser;
				$StockInOutRecord->save();
				
			}
			if($PPN > 0)
			{
				$pajakPo = $TotalPO * ($PPN / 100);
				$TotalPO += $pajakPo;
			}
			
			$BayarPoOrderRecord = new BayarPoOrderRecord();
			$BayarPoOrderRecord->no_pembayaran = $this->GenerateNoDocument('PO-PAY');
			$BayarPoOrderRecord->id_po = $POID;
			$BayarPoOrderRecord->tgl_pembayaran = $PODATE;
			$BayarPoOrderRecord->wkt_pembayaran = date("G:i:s");
			$BayarPoOrderRecord->total_pembayaran = $TotalPO;
			$BayarPoOrderRecord->id_coa = '795';	
			$BayarPoOrderRecord->jns_bayar = '1';	
			$BayarPoOrderRecord->id_bank = '11';
			$BayarPoOrderRecord->no_ref = '4534545';		
			$BayarPoOrderRecord->save();
			 
			$namaAkun = 'Kas Bank';
					
			$supplierName = PemasokRecord::finder()->findByPk($row['id_pemasok'])->nama;
		
		$this->UbahSaldoKas('1',$BayarPoOrderRecord->id_bank,$BayarPoOrderRecord->total_pembayaran);
		
		$this->InsertJurnalBukuBesar($BayarPoOrderRecord->id,
									'3',
									'0',
									$BayarPoOrderRecord->no_pembayaran,
									$BayarPoOrderRecord->tgl_pembayaran,
									date("G:i:s"),
									$BayarPoOrderRecord->id_coa,
									$BayarPoOrderRecord->id_bank,
									"Perlengkapan",
									'Pembayaran PO No '.$PurchaseOrderRecord->no_po.' Kepada '.$supplierName,
									$BayarPoOrderRecord->total_pembayaran);
									
		$this->InsertJurnalBukuBesar($BayarPoOrderRecord->id,
									'3',
									'1',
									$BayarPoOrderRecord->no_pembayaran,
									$BayarPoOrderRecord->tgl_pembayaran,
									date("G:i:s"),
									$BayarPoOrderRecord->id_coa,
									$BayarPoOrderRecord->id_bank,
									$namaAkun,
									'Pembayaran PO No '.$PurchaseOrderRecord->no_po.' Kepada '.$supplierName,
									$BayarPoOrderRecord->total_pembayaran);
														
		$this->InsertJurnalUmum($BayarPoOrderRecord->id,
								'2',
								'0',
								$BayarPoOrderRecord->tgl_pembayaran,
								date("G:i:s"),
								'Perlengkapan',
								$BayarPoOrderRecord->total_pembayaran,
								$BayarPoOrderRecord->no_pembayaran);
									
		$this->InsertJurnalUmum($BayarPoOrderRecord->id,
								'2',
								'1',
								$BayarPoOrderRecord->tgl_pembayaran,
								date("G:i:s"),
								$namaAkun,
								$BayarPoOrderRecord->total_pembayaran,
								$BayarPoOrderRecord->no_pembayaran,
								$BayarPoOrderRecord->id_bank);
		
		$this->InsertJurnalPengeluaranKas($BayarPoOrderRecord->id,
											$BayarPoOrderRecord->no_pembayaran,
											'1',
											$BayarPoOrderRecord->tgl_pembayaran,
											date("G:i:s"),
											$supplierName,
											'',
											'',
											$BayarPoOrderRecord->total_pembayaran,
											0);
		}
			
	}
	
	public function importBtnClicked2()
	{
		$sql = "SELECT
					transaksi_po_januari.NAMA_ITEM,
					(
						SELECT
							tbm_barang.id
						FROM
							tbm_barang
						WHERE
							lower(tbm_barang.nama) = lower(transaksi_po_januari.NAMA_ITEM)
						AND tbm_barang.deleted != '1'
						LIMIT 1
					) AS id_barang,
					transaksi_po_januari.SATUAN,
					(
						SELECT
							tbm_satuan.id
						FROM
							tbm_satuan
						WHERE
							lower(tbm_satuan.singkatan) = lower(transaksi_po_januari.SATUAN)
						AND tbm_satuan.deleted != '1'
						LIMIT 1
					) AS id_satuan
				FROM
					transaksi_po_januari ";
					
		$arr = $this->queryAction($sql,'S');
		
		foreach($arr as $row)
		{
			if($row['id_barang'] == '' && $row['id_satuan'] == '')
			{
				$BarangRecord = new BarangRecord();
				$BarangRecord->kode_barang = '';
				$BarangRecord->nama = $row['NAMA_ITEM'];
				$BarangRecord->kelompok_id = '0';
				$BarangRecord->kategori_id = '10';
				$BarangRecord->min_stock = 0;
				$BarangRecord->max_stock = 0;
				$BarangRecord->max_beli_bulanan = 0;
				$BarangRecord->deleted = '0';
				$BarangRecord->save();
				
				$SatuanRecord = new SatuanRecord();
				$SatuanRecord->nama = $row['SATUAN'];
				$SatuanRecord->singkatan = $row['SATUAN'];
				$SatuanRecord->deleted = '0';
				$SatuanRecord->save();
				
				$BarangSatuanRecord = new BarangSatuanRecord();
				$BarangSatuanRecord->id_barang = $BarangRecord->id;
				$BarangSatuanRecord->id_satuan = $SatuanRecord->id;
				$BarangSatuanRecord->jumlah = 1;
				$BarangSatuanRecord->urutan = 1;
				$BarangSatuanRecord->deleted = '0';
				$BarangSatuanRecord->save();
			}
			elseif($row['id_barang'] != '' && $row['id_satuan'] == '')
			{
				$BarangRecord = BarangRecord::finder()->findByPk($row['id_barang']);
				
				$SatuanRecord = new SatuanRecord();
				$SatuanRecord->nama = $row['SATUAN'];
				$SatuanRecord->singkatan = $row['SATUAN'];
				$SatuanRecord->deleted = '0';
				$SatuanRecord->save();
				
				$BarangSatuanRecord = new BarangSatuanRecord();
				$BarangSatuanRecord->id_barang = $BarangRecord->id;
				$BarangSatuanRecord->id_satuan = $SatuanRecord->id;
				$BarangSatuanRecord->jumlah = 1;
				$BarangSatuanRecord->urutan = 1;
				$BarangSatuanRecord->deleted = '0';
				$BarangSatuanRecord->save();
			}
			elseif($row['id_barang'] == '' && $row['id_satuan'] != '')
			{
				$BarangRecord = new BarangRecord();
				$BarangRecord->kode_barang = '';
				$BarangRecord->nama = $row['NAMA_ITEM'];
				$BarangRecord->kelompok_id = '0';
				$BarangRecord->kategori_id = '10';
				$BarangRecord->min_stock = 0;
				$BarangRecord->max_stock = 0;
				$BarangRecord->max_beli_bulanan = 0;
				$BarangRecord->deleted = '0';
				$BarangRecord->save();
				
				$SatuanRecord = SatuanRecord::finder()->findByPk($row['id_satuan']);
				
				$BarangSatuanRecord = new BarangSatuanRecord();
				$BarangSatuanRecord->id_barang = $BarangRecord->id;
				$BarangSatuanRecord->id_satuan = $SatuanRecord->id;
				$BarangSatuanRecord->jumlah = 1;
				$BarangSatuanRecord->urutan = 1;
				$BarangSatuanRecord->deleted = '0';
				$BarangSatuanRecord->save();
			}
		}
		
		$sqlPemasok = "SELECT
						transaksi_po_januari.NO_PO,
						transaksi_po_januari.TGL_PO,
						transaksi_po_januari.PPN,
						transaksi_po_januari.PEMASOK,
						transaksi_po_januari.ALAMAT_PEMASOK,
						(SELECT tbm_pemasok.id FROM tbm_pemasok WHERE lower(tbm_pemasok.nama) = lower(transaksi_po_januari.PEMASOK) AND tbm_pemasok.deleted = '0' LIMIT 1) AS id_pemasok
					FROM
						transaksi_po_januari
					WHERE
						NO_PO != ''
					AND TGL_PO != ''
					AND PEMASOK != ''
					AND ALAMAT_PEMASOK != ''
					GROUP BY NO_PO ";
		$arrPemasok = $this->queryAction($sqlPemasok,'S');
		foreach($arrPemasok as $row)
		{
			if($row['id_pemasok'] == '')
			{
				$PemasokRecord = new PemasokRecord();
				$PemasokRecord->kategori_id = '26';
				$PemasokRecord->nama = $row['PEMASOK'];;
				$PemasokRecord->alamat = $row['ALAMAT_PEMASOK'];
				$PemasokRecord->telepon = '';
				$PemasokRecord->fax = '';
				$PemasokRecord->contact_person = '';
				$PemasokRecord->fee = 0;
				$PemasokRecord->no_sp = '';
				$PemasokRecord->id_kategori_harga = 0;
				$PemasokRecord->deleted = '0';
				$PemasokRecord->save();
			}
		}
		
	}
	
}
?>
