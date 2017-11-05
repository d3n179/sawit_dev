<?PHP
class PurchaseOrder extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			
			$sql = "SELECT
							tbm_pemasok.id,
							tbm_pemasok.nama
						FROM
							tbm_pemasok
							INNER JOIN tbm_kategori_pemasok ON tbm_kategori_pemasok.id = tbm_pemasok.kategori_id
						WHERE
							tbm_pemasok.deleted = '0' 
							AND tbm_kategori_pemasok.jenis_kategori = '1' ";
					
			$arr = $this->queryAction($sql,'S');
			$this->DDSupplier->DataSource = $arr;
			$this->DDSupplier->DataBind();
			
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
						('','jQuery("#table-1 tbody").append("'.$tblBody.'");');	
		}
	}
	
	public function jnsByrChanged()
	{
		if($this->DDJnsBayar->SelectedValue == '0')
		{
			$this->DDBank->Enabled = false;
		}
		else
		{
			$this->DDBank->Enabled = true;
		}
	}
	
	public function dpChanged()
	{
		$dp = str_replace(",","",$this->dp->Text);
		if($dp > 0 )
		{
			$this->DDCoa->Enabled = false;
			$this->DDJnsBayar->Enabled = true;
		}
		else
		{
			$this->DDCoa->Enabled = false;
			$this->DDJnsBayar->Enabled = false;
			$this->DDBank->Enabled = false;
		}
	}
	
	public function bindROCallback()
	{
		$sql ="SELECT
					tbt_request_order.id,
					tbt_request_order.no_ro
				FROM
					tbt_request_order
				INNER JOIN tbt_request_order_detail ON tbt_request_order_detail.id_ro = tbt_request_order.id
				WHERE
					tbt_request_order.`status` = '1'
				AND tbt_request_order_detail.`status` = '0'
				AND tbt_request_order.deleted = '0'
				AND tbt_request_order_detail.deleted = '0'
				GROUP BY
					tbt_request_order.id ";
		$arr = $this->queryAction($sql,'S');
		$this->DDRequestOrder->DataSource = $arr;
		$this->DDRequestOrder->DataBind();
	}
	
	public function roChanged()
	{
		$idRo = $this->DDRequestOrder->SelectedValue;
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
					AND tbt_request_order_detail.status = '0'
					AND tbt_request_order_detail.id_ro = '$idRo'
					ORDER BY
						tbt_request_order_detail.id ASC ";
			$arr = $this->queryAction($sql,'S');
			$arrJson = json_encode($arr,true);
			var_dump($arrJson);
			$this->getPage()->getClientScript()->registerEndScript
					('','
					RenderTempTable('.$arrJson.');');
	}
	
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_purchase_order.id,
					tbt_purchase_order.`status`,
					tbt_purchase_order.no_po,
					tbt_purchase_order.tgl_po,
					tbm_pemasok.nama AS supplier,
					tbt_purchase_order.catatan,
					tbt_purchase_order.ppn,
					COUNT(
						tbt_purchase_order_detail.id
					) AS jml_item,
					SUM(
						tbt_purchase_order_detail.subtotal
					) AS total_biaya
				FROM
					tbt_purchase_order
				INNER JOIN tbt_purchase_order_detail ON tbt_purchase_order_detail.id_po = tbt_purchase_order.id
				INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_purchase_order.id_supplier
				WHERE
					tbt_purchase_order.deleted = '0'
				AND tbt_purchase_order_detail.deleted = '0'
				GROUP BY
					tbt_purchase_order.id
				ORDER BY 
					tbt_purchase_order.status ASC ";
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
					$actionBtn = '';
				}
				elseif($row['status'] == '1')
				{
					$status = '<div class=\"label label-danger\">PARSIAL</div>';
					$actionBtn = '';
				}
				elseif($row['status'] == '2')
				{
					$status = '<div class=\"label label-success\">DITERIMA</div>';
					$actionBtn = '';
				}
				elseif($row['status'] == '3')
				{
					$status = '<div class=\"label label-warning\">DIBAYAR</div>';
					$actionBtn = '';
				}
				
				$sqlBiaya = "SELECT
									tbt_purchase_order_biaya_lain.nama_biaya,
									tbt_purchase_order_biaya_lain.biaya
								FROM
									tbt_purchase_order_biaya_lain
								WHERE
									tbt_purchase_order_biaya_lain.deleted = '0'
								AND tbt_purchase_order_biaya_lain.id_po = '".$row['id']."' ";

				$arrBiaya = $this->queryAction($sqlBiaya,'S');
				$BiayaLain = 0;
				if($arrBiaya)
				{
					foreach($arrBiaya as $rowBiaya)
					{
						$BiayaLain += $rowBiaya['biaya'];
					}
				}
				
				$ppnPercent = $row['ppn'];
				$ppn = $row['total_biaya'] * ($ppnPercent / 100);
		
				$actionBtn = '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"cetakClicked('.$row['id'].')\"><i class=\"entypo-print\" ></i>Cetak</a>&nbsp;&nbsp;';
				if($row['status'] == '1')
				{
					$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-primary btn-sm btn-icon icon-left\" OnClick=\"closingClicked('.$row['id'].')\"><i class=\"entypo-check\" ></i>Closing</a>&nbsp;&nbsp;';
				}
				
				$tglPo = $this->ConvertDate($row['tgl_po'],'3');
				$tblBody .= '<tr>';
				$tblBody .= '<td class=\"details-control dont_shown\"><input type=\"hidden\" value=\"'.$row['id'].'\"></td>';
				$tblBody .= '<td align=\"center\">'.$status.'</td>';
				$tblBody .= '<td>'.$row['no_po'].'</td>';
				$tblBody .= '<td>'.$tglPo.'</td>';
				$tblBody .= '<td>'.$row['supplier'].'</td>';
				$tblBody .= '<td>'.$row['jml_item'].'</td>';
				$tblBody .= '<td>'.number_format($row['total_biaya']+$ppn+$BiayaLain,2,'.',',').'</td>';
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
	
	public function closingCallback($sender,$param)
	{
		$idPO = $this->idPOClosing->Value;
		if($idPO != '')
		{
			$PurchaseOrderRecord = PurchaseOrderRecord::finder()->findByPk($idPO);
			$PurchaseOrderRecord->status = '2';
			$PurchaseOrderRecord->tgl_jatuh_tempo = $this->ConvertDate($this->tglJthTempo->Text,'2');
			$PurchaseOrderRecord->save();
			
			$sql = "UPDATE tbt_purchase_order_detail SET status = '1' WHERE id_po = '".$idPO."' ";
			$this->queryAction($sql,'C');
			
			$sqlReceiving = "SELECT
									tbt_receiving_order.id,
									tbt_receiving_order.id_po,
									tbt_receiving_order.no_document,
									SUM(
										tbt_receiving_order_detail.subtotal
									) AS total_receiving
								FROM
									tbt_receiving_order
								INNER JOIN tbt_receiving_order_detail ON tbt_receiving_order_detail.id_parent = tbt_receiving_order.id
								WHERE
									tbt_receiving_order.deleted != '1'
								AND tbt_receiving_order_detail.deleted != '1'
								AND tbt_receiving_order.id_po = '".$idPO."'
								GROUP BY
									tbt_receiving_order.id_po ";
				$arrReceiving = $this->queryAction($sqlReceiving,'S');
				$idRO = $arrReceiving[0]['id'];
				$noDocumentRo = $arrReceiving[0]['no_document'];
				$jmlSaldo = $arrReceiving[0]['total_receiving'];	
							
				$ppnPo = $PurchaseOrderRecord->ppn;
				$dpPo = $PurchaseOrderRecord->dp;
				if($ppnPo > 0)
				{
					$ppnSaldo = $jmlSaldo * ($ppnPo / 100);
					$jmlSaldo += $ppnSaldo;
				}
				
				$sqlBiaya = "SELECT
								tbt_purchase_order_biaya_lain.nama_biaya,
								tbt_purchase_order_biaya_lain.biaya
							FROM
								tbt_purchase_order_biaya_lain
							WHERE
								tbt_purchase_order_biaya_lain.deleted = '0'
							AND tbt_purchase_order_biaya_lain.id_po = '".$idPO."' ";

				$arrBiaya = $this->queryAction($sqlBiaya,'S');
				if($arrBiaya)
				{
					foreach($arrBiaya as $rowBiaya)
					{
						$jmlSaldo += $rowBiaya['biaya'];
					}
				}
				var_dump($jmlSaldo);
				if($dpPo > 0)
				{
					$jmlSaldo -= $dpPo;
				}
				var_dump($jmlSaldo);
				
				$this->InsertJurnalUmum($idRO,
										'1',
										'0',
										date("Y-m-d"),
										date("G:i:s"),
										'Perlengkapan',
										$jmlSaldo - $dpPo,
										$noDocumentRo);
										
				$this->InsertJurnalUmum($idRO,
										'1',
										'1',
										date("Y-m-d"),
										date("G:i:s"),
										'Hutang',
										$jmlSaldo - $dpPo,
										$noDocumentRo);
				
				$this->InsertJurnalBukuBesar($idRO,
														'2',
														'0',
														$noDocumentRo,
														date("Y-m-d"),
														date("G:i:s"),
														'',
														'',
														'Perlengkapan',
														'Penerimaan Perlengkapan Dari PO No '.$PurchaseOrderRecord->no_po,
														$jmlSaldo - $dpPo);
														
				$this->InsertJurnalBukuBesar($idRO,
														'2',
														'0',
														$noDocumentRo,
														date("Y-m-d"),
														date("G:i:s"),
														'',
														'',
														"Hutang",
														'Penerimaan Perlengkapan Dari PO No '.$PurchaseOrderRecord->no_po,
														$jmlSaldo - $dpPo);
																				
				
				
				$supplierName = PemasokRecord::finder()->findByPk($PurchaseOrderRecord->id_supplier)->nama;		
								
				$this->InsertJurnalPembelian($idRO,
											$noDocumentRo,
											'1',
											date("Y-m-d"),
											date("G:i:s"),
											$supplierName,
											'',
											'',
											$jmlSaldo - $dpPo);
				$this->closingStockPO($idPO);
											
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
					('','
					toastr.info("Purchase Order NO <strong>'.$PurchaseOrderRecord->no_po.'</strong> Telah Diclosing");
					jQuery("#table-1").dataTable().fnDestroy();
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					BindGrid();
					unloadContent();
					jQuery("#modal-3").modal("hide");
					');
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					toastr.info("Purchase Order Kosong");
					unloadContent();
					');
		}
		
	}
	
	public function closingStockPO($idPo)
	{
		
		$sqlRO = "SELECT
					tbt_receiving_order_detail.id,
					tbt_receiving_order_detail.id_barang,
					tbt_receiving_order_detail.expired_date,
					tbt_receiving_order_detail.jumlah,
					tbt_receiving_order_detail.id_satuan
				FROM
					tbt_receiving_order_detail
				INNER JOIN tbt_receiving_order ON tbt_receiving_order.id_po = '".$idPo."'
				WHERE
					tbt_receiving_order_detail.deleted != '1'
				ORDER BY
					tbt_receiving_order_detail.id ASC ";
		$dataRO = $this->queryAction($sqlRO,'S');
		foreach($dataRO as $row)
		{
			
				$sql = "SELECT 
								SUM(tbd_stok_barang.stok) AS stok
							FROM
								tbd_stok_barang
							WHERE
								tbd_stok_barang.deleted = '0' 
								AND tbd_stok_barang.id_barang = '".$row['id_barang']."' ";
							
					$arr = $this->queryAction($sql,'S');
					
					if($arr[0]['stok'] > 0)
						$stokAwal = $arr[0]['stok'];
					else
						$stokAwal = 0;
						
						
				$qtyConversion = $this->getTargetUom($row['id_barang'],$row['jumlah'],$row['id_satuan'],'1','0');
				
				$StockBarangRecord = StockBarangRecord::finder()->find('id_barang = ? AND deleted = ?',$row['id_barang'],'0');
				
				if($StockBarangRecord)
				{
					$StockBarangRecord->stok += $qtyConversion;	
				}
				else
				{
					$StockBarangRecord = new StockBarangRecord();
					$StockBarangRecord->id_barang = $row['id_barang'];
					$StockBarangRecord->stok = $qtyConversion;
					$StockBarangRecord->expired_date = '0000-00-00';
					$StockBarangRecord->deleted = '0';
				}
				
				$StockBarangRecord->save();
				
				$StockInOutRecord = new StockInOutRecord();
				$StockInOutRecord->id_barang = $row['id_barang'];
				$StockInOutRecord->stok_awal = $stokAwal;
				$StockInOutRecord->stok_in = $qtyConversion;
				$StockInOutRecord->nilai_in = $nilaiIn;
				$StockInOutRecord->stok_out = 0;
				$StockInOutRecord->nilai_out = 0;
				$StockInOutRecord->stok_akhir = $stokAwal + $qtyConversion;
				$StockInOutRecord->keterangan = '';
				$StockInOutRecord->id_transaksi = $row['id'];
				$StockInOutRecord->jns_transaksi = "1";
				$StockInOutRecord->tgl = date("Y-m-d");
				$StockInOutRecord->wkt= date("G:i:s");
				$StockInOutRecord->username = $this->User->IsUser;
				$StockInOutRecord->save();
		}
		
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
		$tglPo = $this->tglPo->Text;
		$detailRO = $param->CallBackParameter->PurchaseOrderTable;
		$BiayaTable = $param->CallBackParameter->BiayaTable;
		var_dump($detailRO);
		$msg = "Purchase Order Telah Dibuat";
		
		if(count($detailRO) > 0)
		{
			$PurchaseOrderRecord = new PurchaseOrderRecord();
			$PurchaseOrderRecord->no_po = $this->GenerateNoDocument('PO');
			$PurchaseOrderRecord->tgl_po = $this->ConvertDate($tglPo,'2');
			$PurchaseOrderRecord->id_ro = $this->DDRequestOrder->SelectedValue;
			$PurchaseOrderRecord->id_supplier = $this->DDSupplier->SelectedValue;
			$PurchaseOrderRecord->ppn = $this->ppn->text;
			$PurchaseOrderRecord->dp = str_replace(",","",$this->dp->text);
			$PurchaseOrderRecord->status = '0';
			$PurchaseOrderRecord->deleted = '0';
			$PurchaseOrderRecord->save();
			foreach($detailRO as $row)
			{
				$PurchaseOrderDetailRecord = new PurchaseOrderDetailRecord();
				$PurchaseOrderDetailRecord->status = '0'; 
				
				$PurchaseOrderDetailRecord->id_ro_detail = $row->id_edit;
				$PurchaseOrderDetailRecord->id_po = $PurchaseOrderRecord->id;
				$PurchaseOrderDetailRecord->id_barang = $row->IdBarang;
				$PurchaseOrderDetailRecord->id_satuan = $row->IdSatuan;
				$PurchaseOrderDetailRecord->jumlah = $row->Jumlah;
				$PurchaseOrderDetailRecord->jumlah_diterima = 0;
				$PurchaseOrderDetailRecord->harga_satuan_besar = $row->hargaSatuanBesar;
				$PurchaseOrderDetailRecord->harga_satuan = $row->harga;
				$PurchaseOrderDetailRecord->discount = $row->discount;
				$PurchaseOrderDetailRecord->subtotal = $row->subtotal;
				$PurchaseOrderDetailRecord->deleted = $row->deleted;
				$PurchaseOrderDetailRecord->save();
				
				$RequestOrderDetailRecord = RequestOrderDetailRecord::finder()->findByPk($row->id_edit);
				$RequestOrderDetailRecord->status = '1';
				$RequestOrderDetailRecord->save();
			}
			
			foreach($BiayaTable as $rowBiaya)
			{
				$PurchaseOrderBiayaLainRecord = new PurchaseOrderBiayaLainRecord();
				$PurchaseOrderBiayaLainRecord->id_po = $PurchaseOrderRecord->id;
				$PurchaseOrderBiayaLainRecord->nama_biaya = $rowBiaya->nama_biaya;
				$PurchaseOrderBiayaLainRecord->biaya = $rowBiaya->biaya;
				$PurchaseOrderBiayaLainRecord->save();
			}
			
			if($PurchaseOrderRecord->dp > 0)
			{
				if($this->DDBank->SelectedValue != '')
				{
					$idBank = $this->DDBank->SelectedValue;
					$namaAkun = "Kas Bank";
				}
				else
				{
					$idBank = '8';
					$namaAkun = "Kas";
				}
				
				$PurchaseOrderRecord->id_bank = $idBank;
				$PurchaseOrderRecord->id_coa = $this->DDCoa->Text;
				$PurchaseOrderRecord->save();
				
				$supplierName = PemasokRecord::finder()->findByPk($PurchaseOrderRecord->id_supplier)->nama;
				
				$this->UbahSaldoKas('1',$PurchaseOrderRecord->id_bank,$PurchaseOrderRecord->dp);
				
				$this->InsertJurnalBukuBesar($PurchaseOrderRecord->id,
														'1',
														'1',
														$PurchaseOrderRecord->no_po,
														date("Y-m-d"),
														date("G:i:s"),
														$PurchaseOrderRecord->id_coa,
														$PurchaseOrderRecord->id_bank,
														$namaAkun,
														'Pembayaran DP PO No '.$PurchaseOrderRecord->no_po.' Kepada '.$supplierName,
														$PurchaseOrderRecord->dp);
														
				$this->InsertJurnalBukuBesar($PurchaseOrderRecord->id,
														'1',
														'0',
														$PurchaseOrderRecord->no_po,
														date("Y-m-d"),
														date("G:i:s"),
														$PurchaseOrderRecord->id_coa,
														$PurchaseOrderRecord->id_bank,
														"Perlengkapan",
														'Pembayaran DP PO No '.$PurchaseOrderRecord->no_po.' Kepada '.$supplierName,
														$PurchaseOrderRecord->dp);
																	
				/*$this->InsertLabaRugi($PurchaseOrderRecord->id,
									'6',
									'1',
									$PurchaseOrderRecord->tgl_po,
									date("G:i:s"),
									"Uang Muka Pembelian",
									$PurchaseOrderRecord->dp,
									$PurchaseOrderRecord->no_po);*/
									
				$this->InsertJurnalUmum($PurchaseOrderRecord->id,
									'8',
									'0',
									$PurchaseOrderRecord->tgl_po,
									date("G:i:s"),
									'Perlengkapan',
									$PurchaseOrderRecord->dp,
									$PurchaseOrderRecord->no_po);
										
				$this->InsertJurnalUmum($PurchaseOrderRecord->id,
										'8',
										'1',
										$PurchaseOrderRecord->tgl_po,
										date("G:i:s"),
										'Kas',
										$PurchaseOrderRecord->dp,
										$PurchaseOrderRecord->no_po);
				
				$namaPemasok = PemasokRecord::finder()->findByPk($PurchaseOrderRecord->id_supplier)->nama;
				
				$this->InsertJurnalPengeluaranKas($PurchaseOrderRecord->id,
													$PurchaseOrderRecord->no_po,
													'3',
													$PurchaseOrderRecord->tgl_po,
													date("G:i:s"),
													$namaPemasok,
													'Bayar Uang Muka',
													'',
													$PurchaseOrderRecord->dp,
													0);
	
	
	
			}
									
			$tblBody = $this->BindGrid();
			
		$url = "index.php?page=Transaksi.cetakPurchaseOrder&idPo=".$PurchaseOrderRecord->id;
			
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("'.$msg.'");
						clearForm();
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						jQuery("#cetakPOFrame").attr("src","'.$url.'")
						jQuery("#modal-2").modal("show");');	
		}
		
	}
	
	
	public function generateDetailCallback($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		
		$sql = "SELECT
					tbt_purchase_order_detail.id,
					tbt_purchase_order_detail.id_barang,
					tbm_barang.nama,
					tbt_purchase_order_detail.id_satuan,
					tbm_satuan.nama AS satuan,
					tbt_purchase_order_detail.harga_satuan_besar,
					tbt_purchase_order_detail.harga_satuan,
					tbt_purchase_order_detail.jumlah,
					tbt_purchase_order_detail.discount,
					tbt_purchase_order_detail.subtotal
				FROM
					tbt_purchase_order_detail
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_purchase_order_detail.id_barang
				INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_purchase_order_detail.id_satuan
				WHERE
					tbt_purchase_order_detail.deleted = '0'
				AND tbt_purchase_order_detail.id_po = '$id'
				ORDER BY
					tbt_purchase_order_detail.id ASC ";
					
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
					$tblBody .= '<td>'.$row['discount'].'</td>';	
					$tblBody .= '<td>'.number_format($row['subtotal'],2,'.',',').'</td>';			
					$tblBody .= '</tr>';
			}
		}
		
		$sqlBiaya = "SELECT
									tbt_purchase_order_biaya_lain.nama_biaya,
									tbt_purchase_order_biaya_lain.biaya
								FROM
									tbt_purchase_order_biaya_lain
								WHERE
									tbt_purchase_order_biaya_lain.deleted = '0'
								AND tbt_purchase_order_biaya_lain.id_po = '".$id."' ";

				$arrBiaya = $this->queryAction($sqlBiaya,'S');
				$BiayaLain = 0;
				if($arrBiaya)
				{
					foreach($arrBiaya as $rowBiaya)
					{
							$tblBodyBiaya .= '<tr>';
							$tblBodyBiaya .= '<td>'.$rowBiaya['nama_biaya'].'</td>';
							$tblBodyBiaya .= '<td>'.number_format($rowBiaya['biaya'],2,'.',',').'</td>';			
							$tblBodyBiaya .= '</tr>';
					}
				}

		$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#tableDetail-'.$id.' tbody").empty();
					jQuery("#tableDetail-'.$id.' tbody").append("'.$tblBody.'");
					jQuery("#tableBiayaDetail-'.$id.' tbody").empty();
					jQuery("#tableBiayaDetail-'.$id.' tbody").append("'.$tblBodyBiaya.'");
					unloadContent();');
	}
	
	public function cetakClicked($sender,$param)
	{
		$idPo = $param->CallbackParameter->id;
		$url = "index.php?page=Transaksi.cetakPurchaseOrder&idPo=".$idPo;
		$folderApp = explode("/",$_SERVER['REQUEST_URI']);
		$urlTemp="http://".$_SERVER['HTTP_HOST']."/".$folderApp[1]."/".$url;
		
		$this->getPage()->getClientScript()->registerEndScript('',"
					var url = '".$urlTemp."';
					window.open(url, '_blank');
					unloadContent();
		");
	}
}
?>
