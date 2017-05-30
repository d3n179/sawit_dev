<?PHP
class ProductionProduct extends MainConf
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
			$sql = "SELECT id,nama FROM tbm_barang WHERE deleted = '0' AND kategori_id ='1' ";
			$this->DDTbs->DataSource = $this->queryAction($sql,'S');
			$this->DDTbs->DataBind();
			
			$sqlSatuanCPO = "SELECT
							tbm_satuan.id,
							tbm_satuan.nama
						FROM
							tbm_satuan
						INNER JOIN tbm_satuan_barang ON tbm_satuan_barang.id_satuan = tbm_satuan.id
						WHERE
							tbm_satuan.deleted = '0'
						AND tbm_satuan_barang.deleted = '0'
						AND tbm_satuan_barang.id_barang = '10' ";
						
			$arrSatuan = $this->queryAction($sqlSatuanCPO,'S');
			$this->DDSatuanCPO->DataSource = $arrSatuan;
			$this->DDSatuanCPO->DataBind();
			
			$sqlSatuanPK = "SELECT
							tbm_satuan.id,
							tbm_satuan.nama
						FROM
							tbm_satuan
						INNER JOIN tbm_satuan_barang ON tbm_satuan_barang.id_satuan = tbm_satuan.id
						WHERE
							tbm_satuan.deleted = '0'
						AND tbm_satuan_barang.deleted = '0'
						AND tbm_satuan_barang.id_barang = '11' ";
						
			$arrSatuan = $this->queryAction($sqlSatuanPK,'S');
			$this->DDSatuanPK->DataSource = $arrSatuan;
			$this->DDSatuanPK->DataBind();
			
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','jQuery("#table-1 tbody").append("'.$tblBody.'");');
		}
	}
	
	public function productSelected()
	{
		$idBarang = $this->DDTbs->SelectedValue;
		
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
			$this->DDSatuanTbs->DataSource = $arrSatuan;
			$this->DDSatuanTbs->DataBind();
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_processing_product.processing_no,
					tbt_processing_product.tgl_processing,
					tbt_processing_product.processing_qty,
					tbt_processing_product.id_tbs,
					tbm_barang.nama AS jenis_kelapa_sawit,
					tbt_processing_product.id_satuan_tbs,
					a.nama AS satuan_kelapa,
					tbt_processing_product.cpo_qty,
					tbt_processing_product.id_satuan_cpo,
					b.nama AS satuan_cpo,
					tbt_processing_product.pk_qty,
					tbt_processing_product.id_satuan_pk,
					c.nama AS satuan_pk
				FROM
					tbt_processing_product
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_processing_product.id_tbs
				INNER JOIN tbm_satuan a ON a.id = tbt_processing_product.id_satuan_tbs
				INNER JOIN tbm_satuan b ON b.id = tbt_processing_product.id_satuan_cpo
				INNER JOIN tbm_satuan c ON c.id = tbt_processing_product.id_satuan_pk
				WHERE
					tbt_processing_product.deleted = '0'
				ORDER BY tbt_processing_product.tgl_processing ASC ";
		$arr = $this->queryAction($sql,'S');
		
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($arr as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['processing_no'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_processing'],'3').'</td>';
				$tblBody .= '<td>'.$row['jenis_kelapa_sawit'].'</td>';
				$tblBody .= '<td>'.$row['processing_qty'].' '.$row['satuan_kelapa'].'</td>';
				$tblBody .= '<td>'.$row['cpo_qty'].' '.$row['satuan_cpo'].'</td>';
				$tblBody .= '<td>'.$row['pk_qty'].' '.$row['satuan_pk'].'</td>';	
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
		$Record = ExpenseRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->idExpense->Value = $id;
			$this->DDCategory->SelectedValue = $Record->expense_category_id;
			$this->nama->text = $Record->nama;
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
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
		$Record = ExpenseRecord::finder()->findByPk($id);
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
		$qty = $this->jml_kelapa->Text;
		$idTbs = $this->DDTbs->SelectedValue;
		$satuanId = $this->DDSatuanTbs->SelectedValue;
		$SatuanRecord = SatuanRecord::finder()->findByPk($satuanId)->nama;
		$sql = "SELECT 
					SUM(tbd_stok_barang.stok) AS stok 
				FROM 
					tbd_stok_barang 
				WHERE 
					tbd_stok_barang.id_barang = '$idTbs' ";
		$arrStok = $this->queryAction($sql,'S');
		$stok = $arrStok[0]['stok'];
		$currentStok = $this->getTargetUom($idTbs,$stok,'0','1',$satuanId);
		$minStok = $this->getTargetUom($idTbs,$qty,$satuanId,'1','0');
		var_dump($currentStok);
		if($currentStok >= $qty)
		{
			$Record = new ProduksiBarangRecord();
		
			$Record->processing_no = $this->GenerateNoDocument('PROC');
			$Record->tgl_processing = date("Y-m-d");
			$Record->id_tbs = $this->DDTbs->SelectedValue;
			$Record->id_satuan_tbs = $this->DDSatuanTbs->SelectedValue;
			$Record->processing_qty = $this->jml_kelapa->Text;
			$Record->cpo_qty = $this->jml_hasil_cpo->Text;
			$Record->id_satuan_cpo = $this->DDSatuanCPO->SelectedValue;
			$Record->pk_qty = $this->jml_hasil_pk->Text;
			$Record->id_satuan_pk = $this->DDSatuanPK->SelectedValue;
			$Record->save();
			
			$StockBarangRecord = StockBarangRecord::finder()->find('id_barang = ? AND expired_date = ?',$idTbs,"0000-00-00");
			if($StockBarangRecord)
			{
				$stokAwal = $StockBarangRecord->stok;
				$stokAkhir = $stokAwal - $minStok;
				$stokIn = 0;
				$stokOut = $minStok;
				
				$StockBarangRecord->stok = $stokAkhir;
				$StockBarangRecord->save();
				
				$StockInOutRecord = new StockInOutRecord();
				$StockInOutRecord->id_barang = $idTbs;
				$StockInOutRecord->stok_awal = $stokAwal;
				$StockInOutRecord->stok_in = $stokIn;
				$StockInOutRecord->stok_out = $stokOut;
				$StockInOutRecord->stok_akhir = $stokAkhir;
				$StockInOutRecord->keterangan = "Produksi Commodity CPO & PK";
				$StockInOutRecord->id_transaksi = $Record->id;
				$StockInOutRecord->jns_transaksi = '6';
				$StockInOutRecord->tgl = date("Y-m-d");
				$StockInOutRecord->wkt = date("G:i:s");
				$StockInOutRecord->username = $this->User->IsUser;
				$StockInOutRecord->save();
				
				if($this->jml_hasil_cpo->Text > 0)
				{
					$cpoQty = $this->getTargetUom('10',$this->jml_hasil_cpo->Text,$this->DDSatuanCPO->SelectedValue,'1','0');
					//----------CPO------------//
					$StockBarangCPORecord = StockBarangRecord::finder()->find('id_barang = ? AND expired_date = ?','10',"0000-00-00");
					if(!$StockBarangCPORecord)
					{
						$stokAwalCPO = 0;
						$stokInCPO = $cpoQty;
						$stokOutCPO = 0;
						$stokAkhirCPO = $cpoQty;
						
						$StockBarangCPORecord = new StockBarangRecord();
						$StockBarangCPORecord->id_barang = '10';
						$StockBarangCPORecord->stok = $cpoQty;
						$StockBarangCPORecord->expired_date = "0000-00-00";
						
					}
					else
					{
						$stokAwalCPO = $StockBarangCPORecord->stok;
						$stokInCPO = $cpoQty;
						$stokOutCPO = 0;
						$stokAkhirCPO = $stokAwalCPO + $cpoQty;
						
						$StockBarangCPORecord->stok = $stokAkhirCPO;
					}
					
					$StockBarangCPORecord->save();
					
					$StockInOutCPORecord = new StockInOutRecord();
					$StockInOutCPORecord->id_barang = '10';
					$StockInOutCPORecord->stok_awal = $stokAwalCPO;
					$StockInOutCPORecord->stok_in = $stokInCPO;
					$StockInOutCPORecord->stok_out = $stokOutCPO;
					$StockInOutCPORecord->stok_akhir = $stokAkhirCPO;
					$StockInOutCPORecord->keterangan = "Produksi Commodity CPO & PK";
					$StockInOutCPORecord->id_transaksi = $Record->id;
					$StockInOutCPORecord->jns_transaksi = '6';
					$StockInOutCPORecord->tgl = date("Y-m-d");
					$StockInOutCPORecord->wkt = date("G:i:s");
					$StockInOutCPORecord->username = $this->User->IsUser;
					$StockInOutCPORecord->save();
					//----------CPO------------//
				}
				
				if($this->jml_hasil_cpo->Text > 0)
				{
					$pkQty = $this->getTargetUom('10',$this->jml_hasil_pk->Text,$this->DDSatuanPK->SelectedValue,'1','0');
					//----------PK------------//
					$StockBarangPKRecord = StockBarangRecord::finder()->find('id_barang = ? AND expired_date = ?','11',"0000-00-00");
					if(!$StockBarangPKRecord)
					{
						$stokAwalPK = 0;
						$stokInPK = $cpoQty;
						$stokOutPK = 0;
						$stokAkhirPK = $pkQty;
						
						$StockBarangPKRecord = new StockBarangRecord();
						$StockBarangPKRecord->id_barang = '11';
						$StockBarangPKRecord->stok = $pkQty;
						$StockBarangPKRecord->expired_date = "0000-00-00";
						
					}
					else
					{
						$stokAwalPK = $StockBarangPKRecord->stok;
						$stokInPK = $pkQty;
						$stokOutPK = 0;
						$stokAkhirPK = $stokAwalPK + $pkQty;
						
						$StockBarangPKRecord->stok = $stokAkhirPK;
					}
					
					$StockBarangPKRecord->save();
					
					$StockInOutPKRecord = new StockInOutRecord();
					$StockInOutPKRecord->id_barang = '11';
					$StockInOutPKRecord->stok_awal = $stokAwalPK;
					$StockInOutPKRecord->stok_in = $stokInPK;
					$StockInOutPKRecord->stok_out = $stokOutPK;
					$StockInOutPKRecord->stok_akhir = $stokAkhirPK;
					$StockInOutPKRecord->keterangan = "Produksi Commodity CPO & PK";
					$StockInOutPKRecord->id_transaksi = $Record->id;
					$StockInOutPKRecord->jns_transaksi = '6';
					$StockInOutPKRecord->tgl = date("Y-m-d");
					$StockInOutPKRecord->wkt = date("G:i:s");
					$StockInOutPKRecord->username = $this->User->IsUser;
					$StockInOutPKRecord->save();
					//----------PK------------//
				}
				
				
				
			}
			$tblBody = $this->BindGrid();
				
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
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.error("Stok Kelapa Sawit Kurang ! <br> Stok Yang Ada : <strong>'.$currentStok.' '.$SatuanRecord.'</strong>");');
		}
		
		
		
	}
	
}
?>
