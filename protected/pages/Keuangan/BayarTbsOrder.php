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
				AND tbt_tbs_order.`status` = '0'
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
		
		$this->idBarang->Value = $idBarang;
		$this->idPemasok->Value = $idPemasok;
		
		$this->Pemasok->Text = $nmPemasok;
		$this->jnsKelapaSawit->Text = $nmbarang;
		
			$this->modalJudul->Text = 'Proses Pembayaran';
			
			$sql = "SELECT
						tbt_tbs_order.id AS idTransaksi,
						tbt_tbs_order.no_polisi,
						tbm_jenis_kendaraan.jenis_kendaraan,
						tbt_tbs_order.netto_1,
						tbt_tbs_order.netto_2,
						tbt_harga_tbs_order.harga,
						tbm_jenis_kendaraan.jenis_bongkar,
						tbm_jenis_kendaraan.jumlah_bongkar,
						IF(tbm_pemasok.fee > 0,tbm_pemasok.fee,0) as fee,
						tbm_kategori_pemasok.ppn,
						tbm_kategori_pemasok.pph,
						tbm_setting_komidel.nama AS kategori_tbs
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
					WHERE
						tbt_tbs_order.deleted = '0'
						AND tbt_tbs_order.tgl_transaksi = '$tglTransaksi'
						AND tbt_tbs_order.id_pemasok = '$idPemasok'
						AND tbt_tbs_order.id_barang = '$idBarang'
					AND tbt_tbs_order.`status` = '0'
					ORDER BY
						tbt_tbs_order.id ASC ";
			$arr = $this->queryAction($sql,'S');
			$arrJson = json_encode($arr,true);	
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
		$IdSatuan = BarangSatuanRecord::finder()->find('id_barang = ?  AND urutan = ? ',$idBarang,1)->id_satuan;
		$DetailBayar = $param->CallbackParameter->BayarTbsTable;
		foreach($DetailBayar as $row)
		{		
			$Record = new BayarTbsOrderRecord();
			$msg = "Pembayaran TBS Telah Diproses";
			$Record->no_pembayaran = $this->GenerateNoDocument('PAY');
			$Record->id_tbs_order = $row->idTransaksi;
			$Record->tgl_pembayaran  = date("Y-m-d");
			$Record->wkt_pembayaran = date("G:i:s");
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
			$Record->id_coa = $this->DDCoa->Text;	
			$Record->jns_bayar = $this->DDJnsBayar->SelectedValue;	
			
			if($this->DDJnsBayar->SelectedValue == '1')
				$Record->id_bank =$this->DDBank->SelectedValue; 
			else
				$Record->id_bank = '8';
			
			$Record->no_ref = $this->noRef->Text;	
			$Record->deleted = '0';
			$Record->save(); 
				
			$TbsOrderRecord = TbsOrderRecord::finder()->findByPk($row->idTransaksi);
			$TbsOrderRecord->status = '1';
			$TbsOrderRecord->save();
			
			$supplierName = PemasokRecord::finder()->findByPk($TbsOrderRecord->id_pemasok)->nama;
			$this->InsertJurnalBukuBesar($Record->id,
									'2',
									'1',
									$Record->no_pembayaran,
									$Record->tgl_pembayaran,
									date("G:i:s"),
									$Record->id_coa,
									$Record->id_bank,
									'Pembayaran Pembelian Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
									$Record->total_tbs_order);
			
			$this->InsertLabaRugi($Record->id,
								'2',
								'1',
								$Record->tgl_pembayaran,
								date("G:i:s"),
								'Pembayaran Pembelian Kelapa Sawit No '.$TbsOrderRecord->no_tbs_order.' Kepada '.$supplierName,
								$Record->total_tbs_order,
								$Record->no_pembayaran);
			
			$this->InsertJurnalUmum($Record->id,
								'3',
								'0',
								$Record->tgl_pembayaran,
								date("G:i:s"),
								'Perlengkapan',
								$Record->total_tbs_order,
								$Record->no_pembayaran);
									
			$this->InsertJurnalUmum($Record->id,
									'3',
									'1',
									$Record->tgl_pembayaran,
									date("G:i:s"),
									'Kas',
									$Record->total_tbs_order,
									$Record->no_pembayaran);
																			
			$BarangHargaRecord = new BarangHargaRecord();
			$BarangHargaRecord->id_barang = $idBarang;
			$BarangHargaRecord->tgl = date("Y-m-d");
			$BarangHargaRecord->harga = $row->harga;
			$BarangHargaRecord->deleted = '0';
			$BarangHargaRecord->save();
			
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
							
			$qtyConversion = $this->getTargetUom($idBarang,$row->netto_2,$IdSatuan,'1','0');
					
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
			$StockInOutRecord->nilai_in = $row->subtotal_tbs;
			$StockInOutRecord->stok_out = 0;
			$StockInOutRecord->nilai_out = 0;
			$StockInOutRecord->stok_akhir = $stokAwal + $qtyConversion;
			$StockInOutRecord->keterangan = '';
			$StockInOutRecord->id_transaksi = $Record->id;
			$StockInOutRecord->jns_transaksi = "2";
			$StockInOutRecord->tgl = date("Y-m-d");
			$StockInOutRecord->wkt= date("G:i:s");
			$StockInOutRecord->username = $this->User->IsUser;
			$StockInOutRecord->save();
		}
						
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
