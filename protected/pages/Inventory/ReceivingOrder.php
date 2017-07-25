<?PHP
class ReceivingOrder extends MainConf
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
						('','jQuery("#table-1 tbody").append("'.$tblBody.'");');	
		}
	}
	
	public function bindPOCallback()
	{
		$sql ="SELECT
					tbt_purchase_order.id,
					tbt_purchase_order.no_po
				FROM
					tbt_purchase_order
				WHERE
					(tbt_purchase_order.`status` = '0' OR tbt_purchase_order.`status` = '1')
				AND tbt_purchase_order.deleted = '0'
				GROUP BY
					tbt_purchase_order.id ";
		$arr = $this->queryAction($sql,'S');
		$this->DDPurchaseOrder->DataSource = $arr;
		$this->DDPurchaseOrder->DataBind();
	}
	
	public function poChanged()
	{
		$idPo = $this->DDPurchaseOrder->SelectedValue;
		if($idPo != '')
		{
			$PurchaseOrderRecord = PurchaseOrderRecord::finder()->findByPk($idPo);
			$idSupplier = $PurchaseOrderRecord->id_supplier;
			$nmSupplier = PemasokRecord::finder()->findByPK($idSupplier)->nama;
			$tglPo = $this->ConvertDate($PurchaseOrderRecord->tgl_po,'1');
			
			$this->tglPo->Text = $tglPo;
			$this->supplierName->Text = $nmSupplier;
			$sql = "SELECT
							tbt_purchase_order_detail.id,
							tbt_purchase_order_detail.id_barang,
							tbm_barang.nama,
							tbt_purchase_order_detail.id_satuan,
							tbm_satuan.nama AS satuan,
							tbt_purchase_order_detail.harga_satuan_besar,
							tbt_purchase_order_detail.harga_satuan,
							tbt_purchase_order_detail.jumlah,
							(tbt_purchase_order_detail.jumlah - tbt_purchase_order_detail.jumlah_diterima) AS SisaPenerimaan,
							tbt_purchase_order_detail.jumlah_diterima,
							tbt_purchase_order_detail.discount,
							tbt_purchase_order_detail.subtotal
						FROM
							tbt_purchase_order_detail
						INNER JOIN tbm_barang ON tbm_barang.id = tbt_purchase_order_detail.id_barang
						INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_purchase_order_detail.id_satuan
						WHERE
							tbt_purchase_order_detail.deleted = '0'
						AND tbt_purchase_order_detail.status = '0'
						AND tbt_purchase_order_detail.id_po = '$idPo'
						ORDER BY
							tbt_purchase_order_detail.id ASC ";
				$arr = $this->queryAction($sql,'S');
				$arrEncode = array();
				foreach($arr as $row)
				{
							
					$arrEncode[] = array('id'=>$row['id'],
										'id_barang'=>$row['id_barang'],
										'nama'=>utf8_encode($row['nama']),
										'id_satuan'=>$row['id_satuan'],
										'satuan'=>$row['satuan'],
										'harga_satuan_besar'=>$row['harga_satuan_besar'],
										'harga_satuan'=>$row['harga_satuan'],
										'jumlah'=>$row['jumlah'],
										'SisaPenerimaan'=>$row['SisaPenerimaan'],
										'jumlah_diterima'=>$row['jumlah_diterima'],
										'discount'=>$row['discount'],
										'subtotal'=>$row['subtotal']);
				}
			}
			
			$arrJson = json_encode($arrEncode,true);
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					RenderTempTable('.$arrJson.');');
	}
	
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_receiving_order.id,
					tbt_purchase_order.id AS id_po,
					tbt_purchase_order.no_po,
					tbt_receiving_order.no_document,
					tbt_receiving_order.tgl_terima,
					tbm_pemasok.nama AS supplier,
					tbt_receiving_order.catatan,
					COUNT(
						tbt_receiving_order_detail.id
					) AS jml_item,
					SUM(
						tbt_receiving_order_detail.subtotal
					) AS total_biaya
				FROM
					tbt_receiving_order
				INNER JOIN tbt_receiving_order_detail ON tbt_receiving_order_detail.id_parent = tbt_receiving_order.id
				INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_receiving_order.id_po
				INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_purchase_order.id_supplier
				WHERE
					tbt_receiving_order.deleted = '0'
				AND tbt_receiving_order_detail.deleted = '0'
				GROUP BY
					tbt_receiving_order.id
				ORDER BY 
					tbt_receiving_order.id ASC ";
		$arr = $this->queryAction($sql,'S');
		
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($arr as $row)
			{
				$sqlBiaya = "SELECT
											tbt_purchase_order_biaya_lain.nama_biaya,
											tbt_purchase_order_biaya_lain.biaya
										FROM
											tbt_purchase_order_biaya_lain
										WHERE
											tbt_purchase_order_biaya_lain.deleted = '0'
										AND tbt_purchase_order_biaya_lain.id_po = '".$row['id_po']."' ";

						$arrBiaya = $this->queryAction($sqlBiaya,'S');
						$BiayaLain = 0;
						if($arrBiaya)
						{
							foreach($arrBiaya as $rowBiaya)
							{
								$BiayaLain += $rowBiaya['biaya'];
							}
						}
				
				$actionBtn = '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"viewClicked('.$row['id'].')\"><i class=\"entypo-search\" ></i>View</a>&nbsp;&nbsp;';
				$tglTerima = $this->ConvertDate($row['tgl_terima'],'3');
				$tblBody .= '<tr>';
				$tblBody .= '<td class=\"details-control dont_shown\"><input type=\"hidden\" value=\"'.$row['id'].'\"></td>';
				$tblBody .= '<td>'.$row['no_po'].'</td>';
				$tblBody .= '<td>'.$row['no_document'].'</td>';
				$tblBody .= '<td>'.$tglTerima.'</td>';
				$tblBody .= '<td>'.$row['supplier'].'</td>';
				$tblBody .= '<td>'.$row['jml_item'].'</td>';
				$tblBody .= '<td>'.number_format($row['total_biaya']+$BiayaLain,2,'.',',').'</td>';	
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
	
	public function submitBtnClicked($sender,$param)
	{
		$tglPo = $this->tglPo->Text;
		$idPo = $this->DDPurchaseOrder->SelectedValue;
		$detailRO = $param->CallBackParameter->ReceivingOrderTable;
		var_dump($detailRO);
		$msg = "Receiving Order Telah Diproses";
		
		if(count($detailRO) > 0)
		{
			$ReceivingOrderRecord = new ReceivingOrderRecord();
			$ReceivingOrderRecord->no_document = $this->GenerateNoDocument('RC');
			$ReceivingOrderRecord->tgl_terima = date("Y-m-d");
			$ReceivingOrderRecord->no_faktur = $this->noFaktur->Text;
			$ReceivingOrderRecord->id_po = $this->DDPurchaseOrder->SelectedValue;
			$ReceivingOrderRecord->save();
			$jmlSaldo = 0;
			foreach($detailRO as $row)
			{
				$urutan = BarangSatuanRecord::finder()->find('id_barang = ? AND id_satuan = ? ',$row->IdBarang,$row->IdSatuan)->urutan;
				
				$hrgSatuanBesar = $this->GetPriceUom($row->IdBarang,$urutan,$row->harga);
				
				$expiredArr = explode("/",$row->expiredDate);
				$month = $expiredArr[0];
				$year = $expiredArr[1];
				$expiredDate = $year."-".$month."-01";
				$ReceivingOrderDetailRecord = new ReceivingOrderDetailRecord();
				$ReceivingOrderDetailRecord->id_po_detail = $row->id_edit;
				$ReceivingOrderDetailRecord->id_parent = $ReceivingOrderRecord->id;
				$ReceivingOrderDetailRecord->id_barang = $row->IdBarang;
				$ReceivingOrderDetailRecord->id_satuan = $row->IdSatuan;
				$ReceivingOrderDetailRecord->jumlah = $row->JumlahDiterima;
				$ReceivingOrderDetailRecord->expired_date = $expiredDate;
				$ReceivingOrderDetailRecord->harga_satuan = $row->harga;
				$ReceivingOrderDetailRecord->harga_satuan_besar = $hrgSatuanBesar;
				$ReceivingOrderDetailRecord->discount = $row->discount;
				$ReceivingOrderDetailRecord->subtotal = $row->subtotal;
				$ReceivingOrderDetailRecord->deleted = $row->deleted;
				$ReceivingOrderDetailRecord->save();
				
				$jmlSaldo += $row->subtotal;
				
				$nilaiIn = $row->harga * $row->JumlahDiterima;
				
				$PurchaseOrderDetailRecord = PurchaseOrderDetailRecord::finder()->findByPk($row->id_edit);
				$jmlDiterima = $PurchaseOrderDetailRecord->jumlah_diterima + $row->JumlahDiterima;
				$jmlPesan = $PurchaseOrderDetailRecord->jumlah;
				
				if($jmlDiterima == $jmlPesan)
					$PurchaseOrderDetailRecord->status = '1';
				
				$PurchaseOrderDetailRecord->jumlah_diterima = $jmlDiterima;
				$PurchaseOrderDetailRecord->save();
				
				$BarangHargaRecord = new BarangHargaRecord();
				$BarangHargaRecord->id_barang = $row->IdBarang;
				$BarangHargaRecord->tgl = date("Y-m-d");
				$BarangHargaRecord->harga = $hrgSatuanBesar;
				$BarangHargaRecord->deleted = '0';
				$BarangHargaRecord->save();
				
				$sql = "SELECT 
								SUM(tbd_stok_barang.stok) AS stok
							FROM
								tbd_stok_barang
							WHERE
								tbd_stok_barang.deleted = '0' 
								AND tbd_stok_barang.id_barang = '".$row->IdBarang."' ";
							
					$arr = $this->queryAction($sql,'S');
					
					if($arr[0]['stok'] > 0)
						$stokAwal = $arr[0]['stok'];
					else
						$stokAwal = 0;
						
						
				$qtyConversion = $this->getTargetUom($row->IdBarang,$row->JumlahDiterima,$row->IdSatuan,'1','0');
				
				$StockBarangRecord = StockBarangRecord::finder()->find('id_barang = ? AND deleted = ?',$row->IdBarang,'0');
				
				if($StockBarangRecord)
				{
					$StockBarangRecord->stok += $qtyConversion;	
				}
				else
				{
					$StockBarangRecord = new StockBarangRecord();
					$StockBarangRecord->id_barang = $row->IdBarang;
					$StockBarangRecord->stok = $qtyConversion;
					$StockBarangRecord->expired_date = '0000-00-00';
					$StockBarangRecord->deleted = '0';
				}
				
				$StockBarangRecord->save();
				
				$StockInOutRecord = new StockInOutRecord();
				$StockInOutRecord->id_barang = $row->IdBarang;
				$StockInOutRecord->stok_awal = $stokAwal;
				$StockInOutRecord->stok_in = $qtyConversion;
				$StockInOutRecord->nilai_in = $nilaiIn;
				$StockInOutRecord->stok_out = 0;
				$StockInOutRecord->nilai_out = 0;
				$StockInOutRecord->stok_akhir = $stokAwal + $qtyConversion;
				$StockInOutRecord->keterangan = '';
				$StockInOutRecord->id_transaksi = $ReceivingOrderDetailRecord->id;
				$StockInOutRecord->jns_transaksi = "1";
				$StockInOutRecord->tgl = date("Y-m-d");
				$StockInOutRecord->wkt= date("G:i:s");
				$StockInOutRecord->username = $this->User->IsUser;
				$StockInOutRecord->save();
			}
			
			$sql = "SELECT 
						tbt_purchase_order_detail.id
					FROM
						tbt_purchase_order_detail
					WHERE
						tbt_purchase_order_detail.`status` = '0' 
						AND tbt_purchase_order_detail.id_po = '$idPo' ";
			$arr = $this->queryAction($sql,'S');
			
			if($arr)
			{
				$PurchaseOrderRecord = PurchaseOrderRecord::finder()->findByPk($idPo);
				$PurchaseOrderRecord->status = '1';
				$PurchaseOrderRecord->save();
			}
			else
			{
				$PurchaseOrderRecord = PurchaseOrderRecord::finder()->findByPk($idPo);
				$PurchaseOrderRecord->status = '2';
				$PurchaseOrderRecord->tgl_jatuh_tempo = $this->ConvertDate($this->tgl_jatuh_tempo->Text,'2');
				$PurchaseOrderRecord->save();
				
				$sqlReceiving = "SELECT
									tbt_receiving_order.id,
									tbt_receiving_order.id_po,
									SUM(
										tbt_receiving_order_detail.subtotal
									) AS total_receiving
								FROM
									tbt_receiving_order
								INNER JOIN tbt_receiving_order_detail ON tbt_receiving_order_detail.id_parent = tbt_receiving_order.id
								WHERE
									tbt_receiving_order.deleted != '1'
								AND tbt_receiving_order_detail.deleted != '1'
								AND tbt_receiving_order.id_po = '".$PurchaseOrderRecord->id."'
								GROUP BY
									tbt_receiving_order.id_po ";
				$arrReceiving = $this->queryAction($sqlReceiving,'S');
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
							AND tbt_purchase_order_biaya_lain.id_po = '".$idPo."' ";

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
				
				$this->InsertJurnalUmum($ReceivingOrderRecord->id,
										'1',
										'0',
										date("Y-m-d"),
										date("G:i:s"),
										'Perlengkapan',
										$jmlSaldo - $dpPo,
										$ReceivingOrderRecord->no_document);
										
				$this->InsertJurnalUmum($ReceivingOrderRecord->id,
										'1',
										'1',
										date("Y-m-d"),
										date("G:i:s"),
										'Hutang',
										$jmlSaldo - $dpPo,
										$ReceivingOrderRecord->no_document);
				
				$this->InsertJurnalBukuBesar($ReceivingOrderRecord->id,
														'2',
														'0',
														$ReceivingOrderRecord->no_document,
														date("Y-m-d"),
														date("G:i:s"),
														'',
														'',
														'Perlengkapan',
														'Penerimaan Perlengkapan Dari PO No '.$PurchaseOrderRecord->no_po,
														$jmlSaldo - $dpPo);
														
				$this->InsertJurnalBukuBesar($ReceivingOrderRecord->id,
														'2',
														'0',
														$ReceivingOrderRecord->no_document,
														date("Y-m-d"),
														date("G:i:s"),
														'',
														'',
														"Hutang",
														'Penerimaan Perlengkapan Dari PO No '.$PurchaseOrderRecord->no_po,
														$jmlSaldo - $dpPo);
																				
				
				
				$supplierName = PemasokRecord::finder()->findByPk($PurchaseOrderRecord->id_supplier)->nama;		
								
				$this->InsertJurnalPembelian($ReceivingOrderRecord->id,
											$ReceivingOrderRecord->no_document,
											'1',
											date("Y-m-d"),
											date("G:i:s"),
											$supplierName,
											'',
											'',
											$jmlSaldo - $dpPo);
			}
			$tblBody = $this->BindGrid();
				
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("'.$msg.'");
						uploadImg('.$ReceivingOrderRecord->id.');
						
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");');	
		}
		
	}
	
	
	public function generateDetailCallback($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		
		$sql = "SELECT
					tbt_receiving_order_detail.id,
					tbt_receiving_order_detail.id_barang,
					tbm_barang.nama,
					tbt_receiving_order_detail.id_satuan,
					tbm_satuan.nama AS satuan,
					tbt_receiving_order_detail.expired_date,
					tbt_receiving_order_detail.harga_satuan_besar,
					tbt_receiving_order_detail.harga_satuan,
					tbt_receiving_order_detail.jumlah,
					tbt_receiving_order_detail.discount,
					tbt_receiving_order_detail.subtotal
				FROM
					tbt_receiving_order_detail
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_receiving_order_detail.id_barang
				INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_receiving_order_detail.id_satuan
				WHERE
					tbt_receiving_order_detail.deleted = '0'
				AND tbt_receiving_order_detail.id_parent = '$id'
				ORDER BY
					tbt_receiving_order_detail.id ASC ";
					
		$arr = $this->queryAction($sql,'S');
		
		if(count($arr) > 0)
		{
			foreach($arr as $row)
			{
				$tglExpired = $this->ConvertDate($row['expired_date'],'3');
					$tblBody .= '<tr>';
					$tblBody .= '<td>'.mysql_escape_string($row['nama']).'</td>';
					$tblBody .= '<td>'.$row['satuan'].'</td>';
					$tblBody .= '<td>'.$tglExpired.'</td>';
					$tblBody .= '<td>'.number_format($row['harga_satuan'],2,'.',',').'</td>';
					$tblBody .= '<td>'.$row['jumlah'].'</td>';	
					$tblBody .= '<td>'.$row['discount'].'</td>';	
					$tblBody .= '<td>'.number_format($row['subtotal'],2,'.',',').'</td>';			
					$tblBody .= '</tr>';
			}
		}
		
		$idPo = ReceivingOrderRecord::finder()->findByPk($id)->id_po;
		$sqlBiaya = "SELECT
									tbt_purchase_order_biaya_lain.nama_biaya,
									tbt_purchase_order_biaya_lain.biaya
								FROM
									tbt_purchase_order_biaya_lain
								WHERE
									tbt_purchase_order_biaya_lain.deleted = '0'
								AND tbt_purchase_order_biaya_lain.id_po = '".$idPo."' ";

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
	
	public function viewClickedCallback($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$ReceivingOrderRecord = ReceivingOrderRecord::finder()->findbyPk($id);
		$filename = sha1($ReceivingOrderRecord->no_document);
		$targetPath = "http://".$_SERVER['SERVER_NAME'].dirname($_SERVER['REQUEST_URI'])."/gallery/ReceivingOrder/".$filename;
		
		$this->getPage()->getClientScript()->registerEndScript('',"
		jQuery('#imageRC').attr('src','".$targetPath."')
		jQuery('#modal-2').modal('show');
		unloadContent();
		");
	}
}
?>
