<?PHP
class StockOpname extends MainConf
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
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_stock_opname.id,
					tbt_stock_opname.no_stock_opname,
					tbt_stock_opname.tgl_stock_opname,
					tbt_stock_opname.wkt_stock_opname,
					tbt_stock_opname.jumlah_barang
				FROM
					tbt_stock_opname
				WHERE
					tbt_stock_opname.deleted = '0'
				ORDER BY 
					tbt_stock_opname.id ASC ";
		$arr = $this->queryAction($sql,'S');
		
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($arr as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['no_stock_opname'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_stock_opname'],'3').'</td>';
				$tblBody .= '<td>'.$row['jumlah_barang'].'</td>';
				$tblBody .= '<td>';
				$tblBody .= '<a href=\"#\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"cetakClicked('.$row['id'].')\"><i class=\"entypo-print\"></i>Cetak</a>';				
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
	
	public function loadProductProses($sender,$param)
	{
		$jns_inventory = $this->jns_inventory->SelectedValue;
		
		if($jns_inventory == '0')
		{
			$sqlWhere = " AND tbm_kategori_barang.tipe_kategori = '1' ";
		}
		elseif($jns_inventory == '1')
		{
			$sqlWhere = " AND tbm_kategori_barang.tipe_kategori = '2' ";
		}
		elseif($jns_inventory == '2')
		{
			$sqlWhere = " AND tbm_kategori_barang.tipe_kategori = '0' ";
		}
		
		$sql = "SELECT
					tbm_barang.id,
					tbm_barang.nama,
					tbm_satuan.id AS id_satuan,
					tbm_satuan.nama AS nama_satuan
				FROM
					tbm_barang
				INNER JOIN tbm_kategori_barang ON tbm_kategori_barang.id = tbm_barang.kategori_id
				INNER JOIN tbm_satuan_barang ON tbm_satuan_barang.id_barang = tbm_barang.id
				INNER JOIN tbm_satuan ON tbm_satuan.id = tbm_satuan_barang.id_satuan
				WHERE
					tbm_barang.deleted = '0'
				AND tbm_satuan_barang.deleted = '0'
				AND tbm_satuan.deleted = '0'
				AND tbm_kategori_barang.deleted = '0'
				".$sqlWhere."
				ORDER BY
					tbm_barang.id ASC,
					tbm_satuan_barang.urutan ASC ";
					
		$arr = $this->queryAction($sql,'S');
		var_dump($sql);
		$tblBodyStock = '';
		$arrStok = array();
		foreach($arr as $row)
		{
			$sqlStock = "SELECT
								SUM(tbd_stok_barang.stok) AS stok
							FROM
								tbd_stok_barang
							WHERE
								tbd_stok_barang.deleted = '0'
							AND tbd_stok_barang.id_barang = '".$row['id']."'
							GROUP BY
								tbd_stok_barang.id_barang ";
				$arrStock = $this->queryAction($sqlStock,'S');
				
				if($arrStock)
					$stok = $arrStock[0]['stok'];
				else
					$stok = 0;
				
				$realQty = $this->getTargetUom($row['id'],$stok); 
				
				$currentStok = 0;
				foreach($realQty as $rowQty)
				{
					if($row['nama_satuan'] == $rowQty['name'])
					{
						$currentStok = $rowQty['qty'];
						break;
					}		
				}
				
			$arrStok[] = array('idBarang'=>$row['id'],
								'namaBarang'=>utf8_encode($row['nama']),
								'idSatuan'=>$row['id_satuan'],
								'namaSatuan'=>$row['nama_satuan'],
								'stokAwal'=>$currentStok);
		}
		//var_dump($arrStok);
		$arrJson = json_encode($arrStok);
			$this->getPage()->getClientScript()->registerEndScript
					('','RenderTempTable('.$arrJson.');');
		
	}
	
	public function submitBtnClicked($sender,$param)
	{
		$StockOpnameTable = $param->CallbackParameter->StockOpnameTable;
		
		$StockOpnameRecord = new StockOpnameRecord();
		$StockOpnameRecord->no_stock_opname = $this->GenerateNoDocument('STK');
		$StockOpnameRecord->tgl_stock_opname = $this->ConvertDate($this->tgl_transaksi->Text,'2');
		$StockOpnameRecord->wkt_stock_opname = date("G:i:s");
		$StockOpnameRecord->jumlah_barang = count($StockOpnameTable);
		$StockOpnameRecord->username = $this->User->IsUser;
		$StockOpnameRecord->save();
		
		$arrStokBarang = array();
		foreach($StockOpnameTable as $row)
		{
			$StockOpnameDetailRecord = new StockOpnameDetailRecord();
			$StockOpnameDetailRecord->id_stock_opname = $StockOpnameRecord->id;
			$StockOpnameDetailRecord->id_barang = $row->idBarang;
			$StockOpnameDetailRecord->id_satuan = $row->idSatuan;
			$StockOpnameDetailRecord->stok_awal = $row->stokAwal;
			$StockOpnameDetailRecord->stok_akhir = $row->stokAkhir;
			$StockOpnameDetailRecord->perbedaan = $row->perbedaan;
			$StockOpnameDetailRecord->status = $row->jns_perbedaan;
			$StockOpnameDetailRecord->save();
			
			$StokBaru = $this->getTargetUom($row->idBarang,$row->stokAkhir,$row->idSatuan,'1','0');
			var_dump($StokBaru);
			$stFind = '0';
			foreach($arrStokBarang as $subKey => $subArray)
			{
				if($subArray['idBarang'] == $row->idBarang)
				{
					$arrStokBarang[$subKey]['StokBaru'] += $StokBaru;
					$stFind = '1';
					break 1;
				}
			}
			
			if($stFind != '1')
			{
				$arrStokBarang[] = array("idBarang"=>$row->idBarang,"StokBaru"=>$StokBaru);
			}
		}
		
		$NilaiPersediaanBaru = 0;
		foreach($arrStokBarang as $rowStokBarang)
		{
			
			$StockBarangRecord = StockBarangRecord::finder()->find('id_barang = ? AND deleted = ?',$rowStokBarang['idBarang'],'0');
			if($StockBarangRecord)
				$stokAwal = $StockBarangRecord->stok;
			else
			{
				$stokAwal = 0;
				$StockBarangRecord = new StockBarangRecord();
				$StockBarangRecord->id_barang = $rowStokBarang['idBarang'];
				$StockBarangRecord->expired_date = '0000-00-00';
			}
				
			$stokAkhir = $rowStokBarang['StokBaru'];
			$StockBarangRecord->stok = $stokAkhir;
			$StockBarangRecord->save();	
			
			$hargaSatuanBesar = $this->GetLastProductPrice($rowStokBarang['idBarang']);
					
					if($hargaSatuanBesar > 0)
					{
						$sqlSatuanAkhir = "SELECT 
												tbm_satuan_barang.id,
												tbm_satuan_barang.id_satuan 
											FROM 
												tbm_satuan_barang 
											WHERE 
												tbm_satuan_barang.deleted != '1' 
												AND tbm_satuan_barang.id_barang = '".$rowStokBarang['idBarang']."'
											ORDER BY tbm_satuan_barang.urutan DESC LIMIT 1 ";
						$arrSatuanAkhir = $this->queryAction($sqlSatuanAkhir,'S');
						$idSatuanAkhir = $arrSatuanAkhir[0]['id_satuan'];
						
						$hargaReal = $this->checkConversionPrice($rowBarang['id'],$idSatuanAkhir,$hargaSatuanBesar);
					}
					else
					{
						$hargaReal = 0;
					}
			
			$NilaiPersediaanBaru = $hargaReal * $stokAkhir;		
			
			if($stokAwal > $stokAkhir)
			{
				$stok_in = 0;
				$stok_out = $stokAwal - $stokAkhir;
				$nilaiIn = 0;
				$nilaiOut = $stok_out * $hargaReal;
			}
			elseif($stokAwal < $stokAkhir)
			{
				$stok_in = $stokAkhir - $stokAwal;
				$stok_out = 0 ;
				$nilaiIn = $stok_in * $hargaReal;
				$nilaiOut = 0;
				
			}
			else
			{
				$stok_in = 0;
				$stok_out = 0 ;
				$nilaiIn = 0;
				$nilaiOut = 0;
			}
			
			
			
				
			$StockInOutRecord = new StockInOutRecord();
				$StockInOutRecord->id_barang = $rowStokBarang['idBarang'];
				$StockInOutRecord->stok_awal = $stokAwal;
				$StockInOutRecord->stok_in = $stok_in;
				$StockInOutRecord->nilai_in = $nilaiIn;
				$StockInOutRecord->stok_out = $stok_out;
				$StockInOutRecord->nilai_out = $nilaiOut;
				$StockInOutRecord->stok_akhir = $stokAkhir;
				$StockInOutRecord->keterangan = 'Stok Opname';
				$StockInOutRecord->id_transaksi = $StockOpnameRecord->id;
				$StockInOutRecord->jns_transaksi = '8';
				$StockInOutRecord->tgl = $this->ConvertDate($this->tgl_transaksi->Text,'2');
				$StockInOutRecord->wkt= date("G:i:s");
				$StockInOutRecord->username = $this->User->IsUser;
				$StockInOutRecord->save();
				
		}
		
		if($NilaiPersediaanBaru > 0)
		{
			$jnsInventory = $this->jns_inventory->SelectedValue;
			if($jnsInventory == '0')
			{
				$namaAkun = 'Persediaan Bahan Baku';
			}
			elseif($jnsInventory == '1')
			{
				$namaAkun = 'Persediaan Barang Dagangan';
			}
			elseif($jnsInventory == '2')
			{
				$namaAkun = 'Perlengkapan';
			}
			
			$sqlSaldoAkhir = "SELECT * FROM tbt_jurnal_buku_besar WHERE nama_akun = '".$namaAkun."' ORDER BY id DESC LIMIT 1";
			$arrSaldoAkhir = $this->queryAction($sqlSaldoAkhir,'S');
			$saldoAkhir = $arrSaldoAkhir[0]['saldo_akhir'];
			
			if($NilaiPersediaanBaru > $saldoAkhir)
			{
				$selisihPersediaan = $NilaiPersediaanBaru - $saldoAkhir;
				$this->InsertJurnalUmum($StockOpnameRecord->id,
												'15',
												'0',
												$StockOpnameRecord->tgl_stock_opname,
												$StockOpnameRecord->wkt_stock_opname,
												$namaAkun,
												$selisihPersediaan,
												$StockOpnameRecord->no_stock_opname);
							
							$this->InsertJurnalUmum($StockOpnameRecord->id,
												'15',
												'1',
												$StockOpnameRecord->tgl_stock_opname,
												$StockOpnameRecord->wkt_stock_opname,
												'Pendapatan Lain-lain',
												$selisihPersediaan,
												$StockOpnameRecord->no_stock_opname);
							
							/*$this->InsertJurnalBukuBesar($StockOpnameRecord->id,
															'15',
															'0',
															$StockOpnameRecord->no_stock_opname,
															$StockOpnameRecord->tgl_stock_opname,
															$StockOpnameRecord->wkt_stock_opname,
															'',
															'',
															$namaAkun,
															'Perhitungan Stok Opname No. '.$StockOpnameRecord->no_stock_opname,
															$selisihPersediaan);
							
							$this->InsertJurnalBukuBesar($StockOpnameRecord->id,
															'15',
															'0',
															$StockOpnameRecord->no_stock_opname,
															$StockOpnameRecord->tgl_stock_opname,
															$StockOpnameRecord->wkt_stock_opname,
															'',
															'',
															'Pendapatan Lain-lain',
															'Perhitungan Stok Opname No.'.$StockOpnameRecord->no_stock_opname,
															$selisihPersediaan);*/
															
							$this->InsertLabaRugi($StockOpnameRecord->id,
													'15',
													'0',
													$StockOpnameRecord->tgl_stock_opname,
													$StockOpnameRecord->wkt_stock_opname,
													'Selisih Persediaan Stok Opname',
													$selisihPersediaan,
													$StockOpnameRecord->no_stock_opname);
													
			}
			elseif($NilaiPersediaanBaru < $saldoAkhir)
			{
				$selisihPersediaan = $saldoAkhir - $NilaiPersediaanBaru;
				
				$this->InsertJurnalUmum($StockOpnameRecord->id,
												'15',
												'0',
												$StockOpnameRecord->tgl_stock_opname,
												$StockOpnameRecord->wkt_stock_opname,
												'Beban Lain-lain',
												$selisihPersediaan,
												$StockOpnameRecord->no_stock_opname);
												
				$this->InsertJurnalUmum($StockOpnameRecord->id,
												'15',
												'1',
												$StockOpnameRecord->tgl_stock_opname,
												$StockOpnameRecord->wkt_stock_opname,
												$namaAkun,
												$selisihPersediaan,
												$StockOpnameRecord->no_stock_opname);
							
				/*$this->InsertJurnalBukuBesar($StockOpnameRecord->id,
															'15',
															'0',
															$StockOpnameRecord->no_stock_opname,
															$StockOpnameRecord->tgl_stock_opname,
															$StockOpnameRecord->wkt_stock_opname,
															'',
															'',
															'Beban Lain-lain',
															'Perhitungan Stok Opname No.'.$StockOpnameRecord->no_stock_opname,
															$selisihPersediaan);
							
				$this->InsertJurnalBukuBesar($StockOpnameRecord->id,
															'15',
															'1',
															$StockOpnameRecord->no_stock_opname,
															$StockOpnameRecord->tgl_stock_opname,
															$StockOpnameRecord->wkt_stock_opname,
															'',
															'',
															$namaAkun,
															'Perhitungan Stok Opname No. '.$StockOpnameRecord->no_stock_opname,
															$selisihPersediaan);*/
																							
							$this->InsertLabaRugi($StockOpnameRecord->id,
													'15',
													'1',
													$StockOpnameRecord->tgl_stock_opname,
													$StockOpnameRecord->wkt_stock_opname,
													'Selisih Persediaan Stok Opname',
													$selisihPersediaan,
													$StockOpnameRecord->no_stock_opname);
													
			}
		}
		$tblBody = $this->BindGrid();
		$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("Data Stock Opname Berhasil Disimpan");
						jQuery("a[href=\"#listTab\"]").tab("show");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						BindGrid();');	
		
		
	}
	
	public function cetakClicked($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$this->Response->redirect($this->Service->constructUrl('Inventory.cetakStokOpnamePdf',array("id"=>$id)));
	}
}
?>
