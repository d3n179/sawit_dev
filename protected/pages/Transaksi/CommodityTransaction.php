<?PHP
class CommodityTransaction extends MainConf
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
			$sql = "SELECT id,sales_no AS nama FROM tbt_contract_sales WHERE deleted !='1' AND (status = '1' OR status = '3') ";
			$this->DDKontrak->DataSource = $this->queryAction($sql,'S');
			$this->DDKontrak->DataBind();
			
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','jQuery("#table-1 tbody").append("'.$tblBody.'");');
		}
	}
	
	public function kontrakChanged()
	{
		$idKontrak = $this->DDKontrak->SelectedValue;
		var_dump($this->DDKontrak->SelectedValue);
		if($idKontrak != '')
		{
			$ContractSalesRecord = ContractSalesRecord::finder()->findByPk($idKontrak);
			if($ContractSalesRecord)
			{
				$this->Pembeli->Text = $ContractSalesRecord->id_pembeli;
				$this->npwp->Text = $ContractSalesRecord->npwp;
				$this->alamat_pembeli->Text = $ContractSalesRecord->alamat_pembeli;
				$this->commodity_type->SelectedValue = $ContractSalesRecord->commodity_type;
				$this->harga->Text = $ContractSalesRecord->pricing;
			}
		}
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_commodity_transaction.id,
					tbt_commodity_transaction.transaction_no,
					tbt_commodity_transaction.no_kendaraan,
					tbt_commodity_transaction.nama_supir,
					tbt_commodity_transaction.transporter,
					tbt_commodity_transaction.tgl_transaksi,
					tbt_commodity_transaction.pembeli,
					tbt_commodity_transaction.commodity_type,
					tbt_commodity_transaction.netto_2,
					tbt_commodity_transaction.id_satuan,
					tbm_satuan.nama AS satuan,
					tbt_commodity_transaction.harga,
					tbt_commodity_transaction.total,
					tbt_commodity_transaction.status,
					tbt_commodity_transaction.deleted
				FROM
					tbt_commodity_transaction
					INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_commodity_transaction.id_satuan
				WHERE
					tbt_commodity_transaction.deleted = '0'
				ORDER BY 
					tbt_commodity_transaction.status ASC ";
		$arr = $this->queryAction($sql,'S');
		
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($arr as $row)
			{
				if($row['commodity_type'] == '0')
					$commodity_type = 'CPO - Crude Palm Oil';
				elseif($row['commodity_type'] == '1')
					$commodity_type = 'PK - Palm Kernel';
				elseif($row['commodity_type'] == '2')
					$commodity_type = 'FIBRE';
				elseif($row['commodity_type'] == '3')
					$commodity_type = 'CANGKANG';
					
				if($row['status'] == '0')
				{
					$actionBtn = '<a href=\"javascript:void(0)\" class=\"btn btn-primary btn-sm btn-icon icon-left\" OnClick=\"prosesClicked('.$row['id'].')\"><i class=\"entypo-check\" ></i>Proses</a>&nbsp;&nbsp;';
					$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
					$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';	
				}
				elseif($row['status'] != '0' )
				{
					//$actionBtn = '<a href=\"javascript:void(0)\" class=\"btn btn-orange btn-sm btn-icon icon-left\" OnClick=\"cetakClicked('.$row['id'].')\"><i class=\"entypo-print\" ></i>Cetak DO</a>&nbsp;&nbsp;';
					//$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"cetakSkpClicked('.$row['id'].')\"><i class=\"entypo-print\" ></i>Cetak SKP</a>&nbsp;&nbsp;';
					$actionBtn = '<a href=\"javascript:void(0)\" class=\"btn btn-primary btn-sm btn-icon icon-left\" OnClick=\"cetakTiketClicked('.$row['id'].')\"><i class=\"entypo-print\" ></i>Cetak Tiket</a>&nbsp;&nbsp;';
				}
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['transaction_no'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_transaksi'],'3').'</td>';
				$tblBody .= '<td>'.$row['pembeli'].'</td>';
				$tblBody .= '<td>'.$row['no_kendaraan'].'</td>';
				$tblBody .= '<td>'.$row['nama_supir'].'</td>';
				$tblBody .= '<td>'.$row['transporter'].'</td>';
				$tblBody .= '<td>'.$commodity_type.'</td>';
				$tblBody .= '<td>'.$row['netto_2'].'</td>';
				$tblBody .= '<td>'.$row['satuan'].'</td>';
				$tblBody .= '<td>'.number_format($row['harga'],2,".",",").'</td>';
				$tblBody .= '<td>'.number_format($row['total'],2,".",",").'</td>';
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
	
	public function prosesClicked($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$Record = CommodityTransactionRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->idCommodityTransaction->Value = $id;
			$this->tgl_masuk->Text = $this->ConvertDate($Record->tgl_masuk,'1');
			$this->wkt_masuk->Text = $Record->wkt_masuk;
			$this->tgl_keluar->Text = $this->ConvertDate($Record->tgl_keluar,'1');
			$this->wkt_keluar->Text = $Record->wkt_keluar;
			$this->JnsKontrak->SelectedValue = $Record->jns_kontrak;
			
			if($Record->jns_kontrak == '1')	
			{
				$this->DDKontrak->SelectedValue = $Record->id_kontrak;
				$this->no_do->text = '';
			}
			else
			{
				$this->DDKontrak->SelectedValue = 'empty';
				$this->no_do->text = $Record->no_do;
			}
			
			$this->no_kendaraan->Text = $Record->no_kendaraan;
			$this->nama_supir->Text = $Record->nama_supir;
			$this->transporter->Text = $Record->transporter;	
			$this->Pembeli->Text = $Record->pembeli;
			$this->npwp->Text = $Record->npwp;
			$this->alamat_pembeli->Text = $Record->alamat_pembeli;
			$this->commodity_type->SelectedValue = $Record->commodity_type;
			$this->bruto->text = $Record->bruto;
			$this->tarra->text = $Record->tarra;
			$this->netto_1->text = $Record->netto_1;
			$this->potongan->text = $Record->potongan;
			$this->netto_2->text = $Record->netto_2;
			$this->harga->text = $Record->harga;
			$this->total->text = $Record->total;
			$this->ffa->text = $Record->ffa;
			$this->moist->text = $Record->moist;
			$this->dirt->text = $Record->dirt;
			$this->no_segel->text = $Record->no_segel;
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					var jnsKontrak = '.$Record->jns_kontrak.';
					
					if(jnsKontrak == "0")
					{
						jQuery("#noDoManual").show();
						jQuery("#noKontrak").hide();
					}
					else if(jnsKontrak == "1")
					{
						jQuery("#noDoManual").hide();
						jQuery("#noKontrak").show();
					}
					
					jQuery("#'.$this->tgl_masuk->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->wkt_masuk->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->tgl_keluar->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->wkt_keluar->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->JnsKontrak->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->DDKontrak->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->no_do->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->Pembeli->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->no_kendaraan->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->nama_supir->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->transporter->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->npwp->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->alamat_pembeli->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->commodity_type->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->bruto->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->tarra->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->netto_1->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->potongan->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->netto_2->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->harga->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->ffa->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->moist->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->dirt->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->no_segel->getClientID().'").prop("disabled",true);
					jQuery("a[href=\"#formTab\"]").tab("show").empty().append("<i class=\"entypo-check\"></i> Proses");
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
	
	public function editForm($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$Record = CommodityTransactionRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->idCommodityTransaction->Value = $id;
			$this->tgl_masuk->Text = $this->ConvertDate($Record->tgl_masuk,'1');
			$this->wkt_masuk->Text = $Record->wkt_masuk;
			$this->tgl_keluar->Text = $this->ConvertDate($Record->tgl_keluar,'1');
			$this->wkt_keluar->Text = $Record->wkt_keluar;
			$this->JnsKontrak->SelectedValue = $Record->jns_kontrak;
			
			if($Record->jns_kontrak == '1')	
			{
				$this->DDKontrak->SelectedValue = $Record->id_kontrak;
				$this->no_do->text = '';
			}
			else
			{
				$this->DDKontrak->SelectedValue = 'empty';
				$this->no_do->text = $Record->no_do;
			}
			
			
			
			$this->no_kendaraan->Text = $Record->no_kendaraan;
			$this->nama_supir->Text = $Record->nama_supir;
			$this->transporter->Text = $Record->transporter;		
			$this->Pembeli->Text = $Record->pembeli;
			$this->npwp->Text = $Record->npwp;
			$this->alamat_pembeli->Text = $Record->alamat_pembeli;
			$this->commodity_type->SelectedValue = $Record->commodity_type;
			$this->bruto->text = $Record->bruto;
			$this->tarra->text = $Record->tarra;
			$this->netto_1->text = $Record->netto_1;
			$this->potongan->text = $Record->potongan;
			$this->netto_2->text = $Record->netto_2;
			$this->harga->text = $Record->harga;
			$this->total->text = $Record->total;
			$this->ffa->text = $Record->ffa;
			$this->moist->text = $Record->moist;
			$this->dirt->text = $Record->dirt;
			$this->no_segel->text = $Record->no_segel;
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					var jnsKontrak = '.$Record->jns_kontrak.';
					
					if(jnsKontrak == "0")
					{
						jQuery("#noDoManual").show();
						jQuery("#noKontrak").hide();
					}
					else if(jnsKontrak == "1")
					{
						jQuery("#noDoManual").hide();
						jQuery("#noKontrak").show();
					}
					
					jQuery("#'.$this->JnsKontrak->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->DDKontrak->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->no_do->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->Pembeli->getClientID().'").prop("disabled",true);
					jQuery("#'.$this->npwp->getClientID().'").prop("disabled",false);
					jQuery("#'.$this->alamat_pembeli->getClientID().'").prop("disabled",false);
					jQuery("#'.$this->commodity_type->getClientID().'").prop("disabled",true);
					jQuery("a[href=\"#formTab\"]").tab("show").empty().append("<i class=\"fa fa-pencil\"></i> Edit");
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
		$Record = CommodityTransactionRecord::finder()->findByPk($id);
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
		if($this->idCommodityTransaction->Value != '')
			$Record = CommodityTransactionRecord::finder()->findByPk($this->idCommodityTransaction->Value);
		else
		{
			$Record = new CommodityTransactionRecord();
			$Record->transaction_no = $this->GenerateNoDocument('COM');
			$Record->tgl_transaksi = date("Y-m-d");
			$Record->wkt_transaksi = date("G:i:s");
		}
		
		if($this->formStatus->Value != '2')
		{
			$Record->tgl_masuk = $this->ConvertDate($this->tgl_masuk->Text,'2');
			$Record->wkt_masuk = $this->wkt_masuk->Text;
			$Record->tgl_keluar = $this->ConvertDate($this->tgl_keluar->Text,'2');
			$Record->wkt_keluar = $this->wkt_keluar->Text;
			
			if($this->idCommodityTransaction->Value == '')
			{
				if($this->JnsKontrak->SelectedValue == '1')	
				{
					$Record->jns_kontrak = $this->JnsKontrak->SelectedValue;
					$Record->id_kontrak = $this->DDKontrak->SelectedValue;
					$Record->no_do = '';
				}
				else
				{
					$Record->jns_kontrak = '0';
					$arrContractSales = array("tipeCommodity"=>$this->commodity_type->SelectedValue,
												"tglKontrak"=>date("Y-m-d"),
												"id_pembeli"=>$this->Pembeli->Text,
												"alamat_pembeli"=>$this->alamat_pembeli->Text,
												"npwp"=>$this->npwp->Text,
												"quantity"=>$this->netto_2->text,
												"pricing"=>$this->harga->text);
					$Record->id_kontrak = $this->createNewContract($arrContractSales);
					$Record->no_do = $this->no_do->Text;
				}
			}
			
			$Record->no_kendaraan = strtoupper($this->no_kendaraan->Text);
			$Record->nama_supir = strtoupper($this->nama_supir->Text);
			$Record->transporter = strtoupper($this->transporter->Text);		
			$Record->pembeli = strtoupper($this->Pembeli->Text);
			$Record->npwp = $this->npwp->Text;
			$Record->alamat_pembeli = $this->alamat_pembeli->Text;
			$Record->commodity_type = $this->commodity_type->SelectedValue;
			$Record->bruto = $this->bruto->text;
			$Record->tarra = $this->tarra->text;
			$Record->netto_1 = $this->netto_1->text;
			$Record->potongan = $this->potongan->text;
			$Record->netto_2 = $this->netto_2->text;
			$Record->id_satuan = '12';
			$Record->harga = $this->harga->text;
			$Record->total = $this->total->text;
			$Record->ffa = $this->ffa->text;
			$Record->moist = $this->moist->text;
			$Record->dirt = $this->dirt->text;
			$Record->no_segel = $this->no_segel->text;

			$Record->save();
			
			$tblBody = $this->BindGrid();
			$this->idCommodityTransaction->Value = "";	
			$this->getPage()->getClientScript()->registerEndScript
							('','
							toastr.info("Data Berhasil Disimpan");
							jQuery("#table-1").dataTable().fnDestroy();
							jQuery("#table-1 tbody").empty();
							jQuery("#table-1 tbody").append("'.$tblBody.'");
							jQuery("a[href=\"#listTab\"]").tab("show");
							BindGrid();');
						
		}
		else
		{
			$arrDoc = $this->GenerateNoDO(date("m"),date("Y"),$Record->commodity_type);
			$Record->tgl_do = date("Y-m-d");
			//$Record->no_do = $arrDoc['noDO'];
			$Record->no_surat_kuasa = $arrDoc['noSKP'];
			
			$ContractSalesRecord = ContractSalesRecord::finder()->findByPk($Record->id_kontrak);
			if($ContractSalesRecord)
			{
				$newDeliveredQty = $ContractSalesRecord->delivered_quantity + $Record->netto_2;
				if($newDeliveredQty > $ContractSalesRecord->quantity)
				{
					$ContractSalesRecord->status = '4';
					$ContractSalesRecord->delivered_quantity = $ContractSalesRecord->quantity;
				}
				else
				{
					$ContractSalesRecord->delivered_quantity += $Record->netto_2;	
				}	
								
				$ContractSalesRecord->save();
			}
							
			$commodityType = $Record->commodity_type;
			
			if($commodityType == '0' || $commodityType == '1')
			{
				if($commodityType == '0')
					$idBarang = '10';
				elseif($commodityType == '1')
					$idBarang = '11';
				
				$Qty = $this->getTargetUom($idBarang,$Record->netto_2,$Record->id_satuan,'1','0');
				
				$urutan = BarangSatuanRecord::finder()->find('id_barang = ? AND id_satuan = ? ',$idBarang,$Record->id_satuan)->urutan;
				$hrgSatuanBesar = $this->GetPriceUom($idBarang,$urutan,$Record->harga);
				
				$BarangHargaRecord = new BarangHargaRecord();
				$BarangHargaRecord->id_barang = $idBarang;
				$BarangHargaRecord->tgl = date("Y-m-d");
				$BarangHargaRecord->harga = $hrgSatuanBesar;
				$BarangHargaRecord->deleted = '0';
				$BarangHargaRecord->save();
						
				
										
				$satuanNama = SatuanRecord::finder()->findByPk($Record->id_satuan)->nama;
				$StockBarangRecord = StockBarangRecord::finder()->find('id_barang = ? AND expired_date = ?',$idBarang,"0000-00-00");
				if($StockBarangRecord)
				{
					$currentQty = $this->getTargetUom($idBarang,$StockBarangRecord->stok,'0','1',$Record->id_satuan);
					if($currentQty >= $Qty)
					{
						$stokAwal = $StockBarangRecord->stok;
						$stokIn = 0;
						$stokOut = $Qty;
						$stokAkhir = $stokAwal - $Qty;
						
						$StockBarangRecord->stok = $stokAkhir;
						$StockBarangRecord->save();
						
						$StockInOutRecord = new StockInOutRecord();
						$StockInOutRecord->id_barang = $idBarang;
						$StockInOutRecord->stok_awal = $stokAwal;
						$StockInOutRecord->stok_in = $stokIn;
						$StockInOutRecord->nilai_in = 0;
						$StockInOutRecord->stok_out = $stokOut;
						$StockInOutRecord->nilai_out = $Record->total;
						$StockInOutRecord->stok_akhir = $stokAkhir;
						$StockInOutRecord->keterangan = "Penjualan Commodity";
						$StockInOutRecord->id_transaksi = $Record->id;
						$StockInOutRecord->jns_transaksi = '7';
						$StockInOutRecord->tgl = date("Y-m-d");
						$StockInOutRecord->wkt = date("G:i:s");
						$StockInOutRecord->username = $this->User->IsUser;
						//$StockInOutRecord->save();
						if($StockInOutRecord->save())
						{
							$this->InsertJurnalUmum($Record->id,
												'10',
												'0',
												date("Y-m-d"),
												date("G:i:s"),
												'Piutang',
												$Record->total,
												$Record->transaction_no);
							
							$this->InsertJurnalUmum($Record->id,
												'10',
												'1',
												date("Y-m-d"),
												date("G:i:s"),
												'Pendapatan',
												$Record->total,
												$Record->transaction_no);
							
							$this->InsertJurnalBukuBesar($Record->id,
															'10',
															'0',
															$Record->transaction_no,
															date("Y-m-d"),
															date("G:i:s"),
															'',
															'',
															'Piutang',
															'Penjualan Commoditty Secara Kredit',
															$Record->total);
							
							$this->InsertJurnalBukuBesar($Record->id,
															'10',
															'0',
															$Record->transaction_no,
															date("Y-m-d"),
															date("G:i:s"),
															'',
															'',
															'Pendapatan',
															'Penjualan Commoditty Secara Kredit',
															$Record->total);
															
							$this->InsertLabaRugi($Record->id,
													'10',
													'0',
													date("Y-m-d"),
													date("G:i:s"),
													'Penjualan Commoditty Secara Kredit',
													$Record->total,
													$Record->transaction_no);
							
							$this->InsertJurnalPenjualan($Record->id,
											$Record->transaction_no,
											'1',
											date("Y-m-d"),
											date("G:i:s"),
											$Record->pembeli,
											'',
											'',
											$Record->total);
											
							$Record->status = '1';
							$Record->save();
							$tblBody = $this->BindGrid();
							$this->getPage()->getClientScript()->registerEndScript
							('','
								toastr.info("Data Berhasil Diproses");
								jQuery("#table-1").dataTable().fnDestroy();
								jQuery("#table-1 tbody").empty();
								jQuery("#table-1 tbody").append("'.$tblBody.'");
								jQuery("a[href=\"#listTab\"]").tab("show");
								BindGrid();');
						}
					}
					else
					{
						$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.error("Stok Barang Tidak Cukup ! <br> Stok Saat Ini : '.$currentQty.' '.$satuanNama.'");
						unloadContent();
						');
					}
							
				}
				else
				{
					$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.error("Stok Barang Kosong !");
						unloadContent();
						');
				}
			}
			else
			{
				$this->InsertJurnalUmum($Record->id,
									'10',
									'0',
									date("Y-m-d"),
									date("G:i:s"),
									'Piutang',
									$Record->total,
									$Record->transaction_no);
				
				$this->InsertJurnalUmum($Record->id,
									'10',
									'1',
									date("Y-m-d"),
									date("G:i:s"),
									'Pendapatan',
									$Record->total,
									$Record->transaction_no);
				
				$this->InsertJurnalBukuBesar($Record->id,
												'10',
												'0',
												$Record->transaction_no,
												date("Y-m-d"),
												date("G:i:s"),
												'',
												'',
												'Piutang',
												'Penjualan Commoditty Secara Kredit',
												$Record->total);
				
				$this->InsertJurnalBukuBesar($Record->id,
												'10',
												'0',
												$Record->transaction_no,
												date("Y-m-d"),
												date("G:i:s"),
												'',
												'',
												'Pendapatan',
												'Penjualan Commoditty Secara Kredit',
												$Record->total);
												
				$this->InsertLabaRugi($Record->id,
										'10',
										'0',
										date("Y-m-d"),
										date("G:i:s"),
										'Penjualan Commoditty Secara Kredit',
										$Record->total,
										$Record->transaction_no);
				
				$this->InsertJurnalPenjualan($Record->id,
											$Record->transaction_no,
											'1',
											date("Y-m-d"),
											date("G:i:s"),
											$Record->pembeli,
											'',
											'',
											$Record->total);
																								
				$Record->status = '1';
				$Record->save();
				$tblBody = $this->BindGrid();
				$this->getPage()->getClientScript()->registerEndScript
							('','
							toastr.info("Data Berhasil Diproses");
							jQuery("#table-1").dataTable().fnDestroy();
							jQuery("#table-1 tbody").empty();
							jQuery("#table-1 tbody").append("'.$tblBody.'");
							jQuery("a[href=\"#listTab\"]").tab("show");
							BindGrid();');
							
			}
		}
		
		/*$this->InsertJurnalBukuBesar($Record->id,
										'5',
										'0',
										$Record->transaction_no,
										$Record->tgl_transaksi,
										date("G:i:s"),
										$Record->coa_id,
										$Record->bank_id,
										$Record->deskripsi,
										$Record->total_revenue);
		
		$this->InsertLabaRugi($Record->id,
								'5',
								'0',
								$Record->tgl_transaksi,
								date("G:i:s"),
								$Record->deskripsi,
								$Record->total_revenue,
								$Record->transaction_no);
		
		$this->InsertJurnalUmum($Record->id,
								'6',
								'0',
								$Record->tgl_transaksi,
								date("G:i:s"),
								'Kas',
								$Record->total_revenue,
								$Record->transaction_no);
									
		$this->InsertJurnalUmum($Record->id,
									'6',
									'1',
									$Record->tgl_transaksi,
									date("G:i:s"),
									$Record->deskripsi,
									$Record->total_revenue,
									$Record->transaction_no);*/
															
			
	}
	
	public function createNewContract($arrContractSales)
	{				
		$bln = date("m");
		$thn = date("Y");
		
		$ContractSalesRecord = new ContractSalesRecord();
		$ContractSalesRecord->sales_no = $this->GenerateNoSales($bln,$thn,$arrContractSales['tipeCommodity']);
		$ContractSalesRecord->tgl_kontrak = $arrContractSales['tglKontrak'];
		$ContractSalesRecord->id_pembeli = strtoupper($arrContractSales['id_pembeli']);
		$ContractSalesRecord->alamat_pembeli = $arrContractSales['alamat_pembeli'];
		$ContractSalesRecord->npwp = $arrContractSales['npwp'];
		$ContractSalesRecord->commodity_type = $arrContractSales['tipeCommodity'];
		$ContractSalesRecord->quantity = $arrContractSales['quantity'];
		$ContractSalesRecord->satuan_commodity = 12;
		$ContractSalesRecord->quality = '';
		$ContractSalesRecord->pricing = $arrContractSales['pricing'];
		$ContractSalesRecord->delivery = '';
		$ContractSalesRecord->term_of_payment = '';
		$ContractSalesRecord->remark = '';
		$ContractSalesRecord->status = '3';
		$ContractSalesRecord->save();
		
		return $ContractSalesRecord->id;
	}
	
	public function cetakClicked($sender,$param)
	{
		$id = $param->CallbackParameter->id; 
		$url = "index.php?page=Transaksi.cetakDeliveryOrderPdf&id=".$id;
		$this->getPage()->getClientScript()->registerEndScript
							('','
							unloadContent();
							jQuery("#cetakFrame").attr("src","'.$url.'");
							jQuery("#modal-3").modal("show");');	
	}
	
	public function cetakSkpClicked($sender,$param)
	{
		$id = $param->CallbackParameter->id; 
		$url = "index.php?page=Transaksi.cetakSuratKuasaAngkutPdf&id=".$id;
		$this->getPage()->getClientScript()->registerEndScript
							('','
							unloadContent();
							jQuery("#cetakFrame").attr("src","'.$url.'");
							jQuery("#modal-3").modal("show");');	
	}
	
	public function cetakTiketClicked($sender,$param)
	{
		$id = $param->CallbackParameter->id; 
		$url = "index.php?page=Transaksi.cetakTimbanganCommodityPdf&id=".$id;
		$this->getPage()->getClientScript()->registerEndScript
							('','
							unloadContent();
							jQuery("#cetakFrame").attr("src","'.$url.'");
							jQuery("#modal-3").modal("show");');	
	}
}
?>
