<?PHP
class BayarPo extends MainConf
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
					tbt_pembayaran_po.no_pembayaran,
					tbt_pembayaran_po.tgl_pembayaran,
					tbt_purchase_order.no_po,
					tbm_pemasok.nama,
					tbt_pembayaran_po.jns_bayar,
					tbt_pembayaran_po.total_pembayaran
				FROM
					tbt_pembayaran_po
				INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_pembayaran_po.id_po
				INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_purchase_order.id_supplier
				WHERE
					tbt_pembayaran_po.deleted = '0' ";
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
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['no_pembayaran'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_pembayaran'],'3').'</td>';
				$tblBody .= '<td>'.$row['no_po'].'</td>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$jnsBayar.'</td>';
				$tblBody .= '<td>'.number_format($row['total_pembayaran'],2,'.',',').'</td>';		
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
					tbt_purchase_order.id,
					tbt_purchase_order.id_supplier,
					tbt_purchase_order.tgl_po,
					tbt_purchase_order.no_po,
					tbt_purchase_order.ppn,
					tbt_purchase_order.dp,
					tbt_purchase_order.tgl_jatuh_tempo,
					tbm_pemasok.nama AS pemasok,
					SUM(tbt_purchase_order_detail.subtotal) AS Total_PO
				FROM
					tbt_purchase_order
				INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_purchase_order.id_supplier
				INNER JOIN tbt_purchase_order_detail ON tbt_purchase_order_detail.id_po = tbt_purchase_order.id
				WHERE
					tbt_purchase_order.deleted = '0'
				AND tbt_purchase_order.`status` = '2'
				GROUP BY
					tbt_purchase_order.id
				ORDER BY
					tbt_purchase_order.id ASC ";
					
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
				$ttlPo = 0;
				
				$sqlRO = "SELECT
							tbt_receiving_order_detail.jumlah,
							tbt_receiving_order_detail.harga_satuan,
							tbt_receiving_order_detail.discount,
							tbt_receiving_order_detail.subtotal
						FROM
							tbt_receiving_order
						INNER JOIN tbt_receiving_order_detail ON tbt_receiving_order_detail.id_parent = tbt_receiving_order.id
						INNER JOIN tbm_barang ON tbm_barang.id = tbt_receiving_order_detail.id_barang
						INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_receiving_order_detail.id_satuan 
						WHERE
							tbt_receiving_order.id_po = '".$row['id']."' ";
							
				$arrRO = $this->queryAction($sqlRO,'S');
				
				foreach($arrRO as $rowRO)
				{
					$ttlPo += $rowRO['subtotal'];
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
				
				$ppnCurrency = $ttlPo * ($row['ppn'] / 100);
				$ttlPo += $ppnCurrency;
				$ttlPo += $BiayaLain;
				$ttlPo -= $row['dp'];
				
				$ttlByrPo = 0;
				$sqlRecord = "SELECT total_pembayaran FROM tbt_pembayaran_po WHERE id_po = '".$row['id']."' AND deleted = '0' ";
				$arrRecord = $this->queryAction($sqlRecord,'S');
				
				if(count($arrRecord) > 0)
				{
					foreach($arrRecord as $rowRecord)
					{
						$ttlByrPo +=  $rowRecord['total_pembayaran'];
					}
				}
				
				$sisaBayar = $ttlPo - $ttlByrPo;
				
				$actionBtn='';
				
				$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Proses</a>&nbsp;&nbsp;';
				
				$date1 = date("Y-m-d");
				$date2 = $row['tgl_jatuh_tempo'];

				$diff = abs(strtotime($date2) - strtotime($date1));

				$years = floor($diff / (365*60*60*24));
				$months = floor(($diff - $years * 365*60*60*24) / (30*60*60*24));
				$days = floor(($diff - $years * 365*60*60*24 - $months*30*60*60*24)/ (60*60*24));
				
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['no_po'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_po'],'3').'</td>';
				$tblBody .= '<td>'.$row['pemasok'].'</td>';
				$tblBody .= '<td>'.number_format($ttlPo,2,'.',',').'</td>';
				$tblBody .= '<td>'.number_format($ttlByrPo,2,'.',',').'</td>';
				$tblBody .= '<td>'.number_format($sisaBayar,2,'.',',').'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_jatuh_tempo'],'3').'</td>';
				$tblBody .= '<td>'.$months.' Bulan '.$days.' Hari</td>';
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
		$idPo = $param->CallbackParameter->idPo;
		
		$this->idPo->Value = $idPo;
		$this->idPemasok->Value = $idPemasok;
		$PurchaseOrderRecord = PurchaseOrderRecord::finder()->findByPk($idPo);
		
		$nmPemasok = PemasokRecord::finder()->findByPk($PurchaseOrderRecord->id_supplier)->nama;
		
		$this->Pemasok->Text = $nmPemasok;
		
		$this->dp->Text = $PurchaseOrderRecord->dp;
		$this->ppn->Text = $PurchaseOrderRecord->ppn;
		
		$this->modalJudul->Text = 'Proses Pembayaran';
		$ttlPo = 0;
			$sql = "SELECT
						tbt_receiving_order.no_faktur,
						tbt_receiving_order.tgl_terima,
						tbm_barang.nama AS nama_barang,
						tbm_satuan.nama AS satuan,
						tbt_receiving_order_detail.jumlah,
						tbt_receiving_order_detail.harga_satuan,
						tbt_receiving_order_detail.discount,
						tbt_receiving_order_detail.subtotal
					FROM
						tbt_receiving_order
					INNER JOIN tbt_receiving_order_detail ON tbt_receiving_order_detail.id_parent = tbt_receiving_order.id
					INNER JOIN tbm_barang ON tbm_barang.id = tbt_receiving_order_detail.id_barang
					INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_receiving_order_detail.id_satuan 
					WHERE
						tbt_receiving_order.id_po = '$idPo' ";
			$arr = $this->queryAction($sql,'S');
			var_dump($sql);
			$count = count($arr);
			$tblBody = '';
			if($arr > 0)
			{
				foreach($arr as $row)
				{
					$tblBody .= '<tr>';
					$tblBody .= '<td>'.$row['no_faktur'].'</td>';
					$tblBody .= '<td>'.$this->ConvertDate($row['tgl_terima'],'3').'</td>';
					$tblBody .= '<td>'.mysql_escape_string($row['nama_barang']).'</td>';
					$tblBody .= '<td>'.$row['jumlah'].'</td>';
					$tblBody .= '<td>'.$row['satuan'].'</td>';
					$tblBody .= '<td>'.number_format($row['harga_satuan'],2,'.',',').'</td>';	
					$tblBody .= '<td>'.number_format($row['discount'],2,'.','').'</td>';	
					$tblBody .= '<td>'.number_format($row['subtotal'],2,'.',',').'</td>';		
					$tblBody .= '</tr>';
					
					$ttlPo += $row['subtotal'];
				}
			}
			else
			{
				$tblBody = '';
			}
			
			$tblBodyBiaya = '';
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
							$BiayaLain += $rowBiaya['biaya'];
					}
				}
				
			$ppnCurrency = $ttlPo * ($PurchaseOrderRecord->ppn / 100);
			
			$ttlPo += $ppnCurrency;
			$ttlPo += $BiayaLain;
			$ttlPo -= $PurchaseOrderRecord->dp;
			
			$this->total_po->Text = $ttlPo;
			
			$ttlByrPo = 0;
			$sqlRecord = "SELECT total_pembayaran FROM tbt_pembayaran_po WHERE id_po = '".$idPo."' AND deleted = '0' ";
			$arrRecord = $this->queryAction($sqlRecord,'S');
			if(count($arrRecord) > 0)
			{
				foreach($arrRecord as $rowRecord)
				{
					$ttlByrPo +=  $rowRecord['total_pembayaran'];
				}
			}
			$this->total_po_bayar->Text = $ttlByrPo;
			
			$sisaBayar = $ttlPo - $ttlByrPo;
			
			$this->sisa_bayar->Text = $sisaBayar;
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#tableBayar").dataTable().fnDestroy();
					jQuery("#tableBayar tbody").empty();
					jQuery("#tableBayar tbody").append("'.$tblBody.'");
					jQuery("#tableBiaya").dataTable().fnDestroy();
					jQuery("#tableBiaya tbody").empty();
					jQuery("#tableBiaya tbody").append("'.$tblBodyBiaya.'");
					
					BindGridBayar();
					BindGridBiaya();
					jQuery("#modal-1").modal("show");
					unloadContent();
					');	
		
	}
	
	
	public function submitBtnClicked()
	{
		$idPo = $this->idPo->Value;
		$idCoa = $this->DDCoa->Text;
		$sisa_bayar = str_replace(",","",$this->sisa_bayar->Text);
		$totalBayar = str_replace(",","",$this->jml_bayar->Text);
		$BayarPoOrderRecord = new BayarPoOrderRecord();
		$BayarPoOrderRecord->no_pembayaran = $this->GenerateNoDocument('PO-PAY');
		$BayarPoOrderRecord->id_po = $idPo;
		$BayarPoOrderRecord->tgl_pembayaran = date("Y-m-d");
		$BayarPoOrderRecord->wkt_pembayaran = date("G:i:s");
		
		if($totalBayar >= $sisa_bayar)
			$BayarPoOrderRecord->total_pembayaran = $sisa_bayar;
		else
			$BayarPoOrderRecord->total_pembayaran = $totalBayar;
		
		$BayarPoOrderRecord->id_coa = $idCoa;	
		$BayarPoOrderRecord->jns_bayar = $this->DDJnsBayar->SelectedValue;	
		
		
		
		if($this->DDJnsBayar->SelectedValue == '1')
		{
			$BayarPoOrderRecord->id_bank =$this->DDBank->SelectedValue; 
			$namaAkun = 'Kas Bank';
		}
		else
		{
			$BayarPoOrderRecord->id_bank = '8';
			$namaAkun = 'Kas';
		}
				
		$BayarPoOrderRecord->no_ref = $this->noRef->Text;		
		$BayarPoOrderRecord->save();
		
		if($totalBayar >= $sisa_bayar)
		{
			$PurchaseOrderRecord = PurchaseOrderRecord::finder()->findByPk($idPo);
			$PurchaseOrderRecord->status = '3';
			$PurchaseOrderRecord->save();
		}
		
		$PurchaseOrderRecord = PurchaseOrderRecord::finder()->findByPk($idPo);
			
		$supplierName = PemasokRecord::finder()->findByPk($PurchaseOrderRecord->id_supplier)->nama;
		
		$this->UbahSaldoKas('1',$BayarPoOrderRecord->id_bank,$BayarPoOrderRecord->total_pembayaran);
		
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
														
		$this->InsertJurnalBukuBesar($BayarPoOrderRecord->id,
									'3',
									'1',
									$BayarPoOrderRecord->no_pembayaran,
									$BayarPoOrderRecord->tgl_pembayaran,
									date("G:i:s"),
									$BayarPoOrderRecord->id_coa,
									$BayarPoOrderRecord->id_bank,
									"Hutang",
									'Pembayaran PO No '.$PurchaseOrderRecord->no_po.' Kepada '.$supplierName,
									$BayarPoOrderRecord->total_pembayaran);
																					
		/*$this->InsertLabaRugi($BayarPoOrderRecord->id,
								'1',
								'1',
								$BayarPoOrderRecord->tgl_pembayaran,
								date("G:i:s"),
								'Pembayaran PO No '.$PurchaseOrderRecord->no_po.' Kepada '.$supplierName,
								$BayarPoOrderRecord->total_pembayaran,
								$BayarPoOrderRecord->no_pembayaran);*/
		
		
		$this->InsertJurnalUmum($BayarPoOrderRecord->id,
								'2',
								'0',
								$BayarPoOrderRecord->tgl_pembayaran,
								date("G:i:s"),
								'Hutang',
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
															
		$msg = "Pembayaran Po Telah Diproses ";
		$tblBody = $this->BindGrid();
		$tblBodyHistory = $this->BindGridHistory();
			
			$this->getPage()->getClientScript()->registerEndScript
							('','
							toastr.info("'.$msg.'");
							jQuery("#modal-1").modal("hide");
							jQuery("#table-1").dataTable().fnDestroy();
							jQuery("#table-1 tbody").empty();
							jQuery("#table-1 tbody").append("'.$tblBody.'");
							jQuery("#table-2").dataTable().fnDestroy();
							jQuery("#table-2 tbody").empty();
							jQuery("#table-2 tbody").append("'.$tblBodyHistory.'");
							clearForm();
							BindGrid();
							BindGridHistory();');	
			
			
			
		
	}

}
?>
