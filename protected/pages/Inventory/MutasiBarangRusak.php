<?PHP
class MutasiBarangRusak extends MainConf
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
				
		}
	}
	
	public function onLoadComplete($param)
	{
		parent::onLoadComplete($param);
		
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			//$this->DDBarang->DataSource = $arrBarang;
			//$this->DDBarang->DataBind();
			$arrJson = $this->getDataProduct();
			$this->product_id_arr->Value = json_encode($arrJson);
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#table-1 tbody").append("'.$tblBody.'");');
		}
	}
	
	public function barangChanged()
	{
		$idBarang = $this->product_id_select2->Value;
		if($idBarang != '')
		{
			var_dump($idBarang);
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
						
			$arrSatuan = $this->queryAction($sqlSatuan,'S');
			$this->DDSatuan->DataSource = $arrSatuan;
			$this->DDSatuan->DataBind();
			
		}
		else
		{
			$this->DDSatuan->DataSource = '';
			$this->DDSatuan->SelectedValue = '';
			$this->jml->Text = '';
		}
	}
	
	public function getProductArray()
	{
		$arrJson = $this->getDataProduct();
		$this->product_id_arr->Value = json_encode($arrJson);
		$this->getPage()->getClientScript()->registerEndScript
						('','
						bindProduct();');
	}
	
	public function getDataProduct()
	{
		$sqlBarang = "SELECT
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
			$arrJson = array();
			foreach($arrBarang as $row)
			{
				$sqlStok = "SELECT SUM(stok) AS stok FROM tbd_stok_barang WHERE id_barang = '".$row['id']."' AND deleted != '1' ";
				$arrStok = $this->queryAction($sqlStok,'S');
				if($arrStok)
				{
					$stok = $arrStok[0]['stok'];
					if($stok == 0)
					{
						$disabled = true;
						$text = "<b><i>(STOCK 0)</i></b>";
						$stoktext = "";
					}
					elseif($stok == NULL)
					{
						$disabled = true;
						$text = "<b><i>(EMPTY STOCK)</i></b>";
						$stoktext = "";
					}
					else
					{
						$currentStok = $this->getTargetUom($row['id'],$stok,'0','0','0');
						$text = '';
						$stoktext = '';
						foreach($currentStok as $rowStok)
						{
							$stoktext .= $rowStok['qty']." ".$rowStok['name']." ";
						}
		
						$disabled = false;
					}
				}
				else
				{
					$disabled = true;
					$text = "<b><i>(EMPTY STOCK)</i></b>";
				}
				
				$arrJson[] = array("id"=>$row['id'],"text"=>utf8_encode($row['nama'])." ".$text,"stok"=>$stok,"stokText"=>$stoktext,"disabled"=>$disabled);
			}
			
		return $arrJson;
	}
	
	public function BindGrid()
	{
		$MutasiBarangRecord = MutasiBarangRecord::finder()->findAll('deleted = ? ORDER BY id ASC','0');
		
		$count = count($MutasiBarangRecord);
		$tblBody = '';
		if($count > 0)
		{
			foreach($MutasiBarangRecord as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row->tgl_transaksi.'</td>';
				$tblBody .= '<td>'.$row->wkt_transaksi.'</td>';
				$tblBody .= '<td>'.$row->jumlah_barang.'</td>';
				$tblBody .= '<td>';
				$tblBody .= '<a href=\"#\" class=\"btn btn-gold btn-sm btn-icon icon-left\" OnClick=\"detailClicked('.$row->id.')\"><i class=\"entypo-doc-text-inv\"></i>Detail</a>&nbsp;&nbsp;';	
				$tblBody .= '<a href=\"#\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"cetakClicked('.$row->id.')\"><i class=\"entypo-print\"></i>Cetak</a>';
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
	
	public function tambahBtnClicked($sender,$param)
	{
		$idBarang = $this->product_id_select2->Value;
		$stokBarang = $this->product_id_stok->Value;
		$idSatuan = $this->DDSatuan->SelectedValue;
		$stokOut = $this->getTargetUom($idBarang,$this->jml->Text,$idSatuan,'1','0');
		
		if($stokBarang >= $stokOut)
		{
			$this->getPage()->getClientScript()->registerEndScript
						('','
						tambahBtnClicked();');
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.error("Stok Barang Tidak Cukup !");');
		}
		
	}
	
	public function deleteBrngClicked($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$arr = json_decode($this->arrBarang->Value,true);
		
		foreach($arr as $subKey => $subArray)
		{
			if($subArray['id_barang'] == $id)
				unset($arr[$subKey]);	
		}
		
		$this->arrBarang->Value = json_encode($arr,true);
		$this->bindBarangRusak();
	}
	
	
	public function bindBarangRusak()
	{
		$arr = json_decode($this->arrBarang->Value,true);
		if(count($arr) > 0)
		{
			$tblBody="";
			foreach($arr as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['nama_barang'].'</td>';
				$tblBody .= '<td>'.$row['jml'].'</td>';
				$tblBody .= '<td>';
				$tblBody .= '<a href=\"#\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id_barang'].')\"><i class=\"entypo-cancel\"></i>Delete</a>';							
				$tblBody .=	'</td>';			
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = "";
		}
		
		$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#tableBrngRusak").dataTable().fnDestroy();
					jQuery("#tableBrngRusak tbody").empty();
					jQuery("#tableBrngRusak tbody").append("'.$tblBody.'");
					BindGridBrgRusak();');	
	}
	
	function detailClicked($sender,$param)
	{
		$idtrans = $param->CallbackParameter->id;
		
		$sql = "SELECT
					tbt_mutasi_barang_detail.id_barang,
					tbm_barang.nama AS barang,
					tbt_mutasi_barang_detail.id_satuan,
					tbm_satuan.nama AS satuan,
					tbt_mutasi_barang_detail.jml,
					tbt_mutasi_barang_detail.jns_keluar
				FROM
					tbt_mutasi_barang_detail
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_mutasi_barang_detail.id_barang
				INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_mutasi_barang_detail.id_satuan
				WHERE
					tbt_mutasi_barang_detail.id_transaksi = '$idtrans'
				AND tbt_mutasi_barang_detail.deleted = '0' ";
		$arr = $this->queryAction($sql,'S');
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			foreach($arr as $row)
			{
				if($row['jns_keluar'] == '3')
					$JnsKeluar = 'Pemakaian Produksi';
				elseif($row['jns_keluar'] == '4')
					$JnsKeluar = 'Barang Rusak';
				elseif($row['jns_keluar'] == '5')
					$JnsKeluar = 'Expired';
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['barang'].'</td>';
				$tblBody .= '<td>'.$row['satuan'].'</td>';
				$tblBody .= '<td>'.$row['jml'].'</td>';
				$tblBody .= '<td>'.$JnsKeluar.'</td>';
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = '';
		}
		
		$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#modal-2").modal("show");
						jQuery("#tableBrng").dataTable().fnDestroy();
						jQuery("#tableBrng tbody").empty();
						jQuery("#tableBrng tbody").append("'.$tblBody.'");
						BindGridBrg();
						unloadContent();');	
		
	}
	
	public function submitBtnClicked($sender,$param)
	{
		$arr = $param->CallbackParameter->MutasiTable;
		
		if(count($arr) > 0)
		{
			$tglTrans = date("Y-m-d");
			$wktTrans = date("G:i:s"); 
			$MutasiBarangRecord = new MutasiBarangRecord();
			$MutasiBarangRecord->tgl_transaksi = $tglTrans;
			$MutasiBarangRecord->wkt_transaksi = $wktTrans;
			$MutasiBarangRecord->jumlah_barang = count($arr);
			$MutasiBarangRecord->save(); 
			
			foreach($arr as $row)
			{
				$hargaSatuanBesar = $this->GetLastProductPrice($row->IdBarang);
		
				if($hargaSatuanBesar > 0)
				{
					$hargaReal = $this->checkConversionPrice($row->IdBarang,$row->IdSatuan,$hargaSatuanBesar);
				}
				else
				{
					$hargaReal = 0;
				}
					
				$MutasiBarangDetailRecord = new MutasiBarangDetailRecord();
				$MutasiBarangDetailRecord->id_transaksi = $MutasiBarangRecord->id;
				$MutasiBarangDetailRecord->id_barang = $row->IdBarang;
				$MutasiBarangDetailRecord->id_satuan = $row->IdSatuan;
				$MutasiBarangDetailRecord->jml = $row->Jumlah;
				$MutasiBarangDetailRecord->jns_keluar = $row->jenisPengeluaran;
				$MutasiBarangDetailRecord->deleted = '0';
				$MutasiBarangDetailRecord->save();
				
				$sql = "SELECT 
							SUM(tbd_stok_barang.stok) AS stok 
						FROM 
							tbd_stok_barang 
						WHERE 
							tbd_stok_barang.id_barang = '".$row->IdBarang."' ";
				$arrStok = $this->queryAction($sql,'S');
				$stok = $arrStok[0]['stok'];
				$currentStok = $stok; //$this->getTargetUom($row->IdBarang,$stok,'0','1',$row->IdSatuan);
				
				$minStok = $this->getTargetUom($row->IdBarang,$row->Jumlah,$row->IdSatuan,'1','0');
				$sqlId = "SELECT 
								id
							FROM
								tbd_stok_barang
							WHERE
								tbd_stok_barang.deleted = '0' 
								AND tbd_stok_barang.id_barang = '".$row->IdBarang."' 
							ORDER BY tbd_stok_barang.expired_date ASC";
				$arrId = $this->queryAction($sqlId ,'S');
				
				foreach($arrId as $rowId)
				{
					$stockId = $rowId['id'];
					$StockBarangRecord = StockBarangRecord::finder()->findByPk($stockId);
					if($StockBarangRecord->stok >= $minStok)
					{
						$StockBarangRecord->stok -= $minStok;
						$StockBarangRecord->save(); 
						break;
					}
					else
					{
						$stockKurang = $minStok - $StockBarangRecord->stok;
						$StockBarangRecord->stok = 0;
						$StockBarangRecord->save(); 
					}
				}
				
				$StockInOutRecord = new StockInOutRecord();
				$StockInOutRecord->id_barang = $row->IdBarang;
				$StockInOutRecord->stok_awal = $currentStok;
				$StockInOutRecord->stok_in = 0;
				$StockInOutRecord->nilai_in = 0;
				$StockInOutRecord->stok_out = $minStok;
				$StockInOutRecord->nilai_out = $row->Jumlah * $hargaReal;
				$StockInOutRecord->stok_akhir = $currentStok - $minStok;
				$StockInOutRecord->keterangan = '';
				$StockInOutRecord->id_transaksi = $MutasiBarangDetailRecord->id;
				$StockInOutRecord->jns_transaksi = $row->jenisPengeluaran;
				$StockInOutRecord->tgl = date("Y-m-d");
				$StockInOutRecord->wkt= date("G:i:s");
				$StockInOutRecord->username = $this->User->IsUser;
				$StockInOutRecord->save();
			}
			$tblBody = $this->BindGrid();
			
			$url = 'index.php?page=Inventory.cetakKwtPemakaianBarang&id='.$MutasiBarangRecord->id;
		
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("Mutasi Barang Telah Diproses !");
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						BindGrid();
						jQuery("#cetakFrame").attr("src","'.$url.'")
						jQuery("#modal-3").modal("show");');	
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.error("Barang Belum Dimasukkan !");');	
		}
	}
	
	public function cetakClicked($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$url = "index.php?page=Inventory.cetakKwtPemakaianBarang&id=".$id;
		$this->getPage()->getClientScript()->registerEndScript('',"
		jQuery('#cetakFrame').attr('src','".$url."')
		jQuery('#modal-3').modal('show');
		unloadContent();
		");
	}
	
}
?>
