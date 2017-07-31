<?PHP
class PenerimaanJual extends MainConf
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
					tbt_commodity_transaction.id,
					tbt_commodity_transaction.`status`,
					tbt_commodity_transaction.transaction_no,
					tbt_commodity_transaction.tgl_transaksi,
					tbt_commodity_transaction.commodity_type,
					tbt_commodity_transaction.pembeli,
					tbt_commodity_transaction.netto_2 AS jumlah_commodity,
					tbt_commodity_transaction.harga
				FROM
					tbt_commodity_transaction
				WHERE
					tbt_commodity_transaction.deleted = '0'
					AND tbt_commodity_transaction.status = '1'
				ORDER BY 
					tbt_commodity_transaction.id ASC ";
		$arr = $this->queryAction($sql,'S');
		
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($arr as $row)
			{
				$actionBtn = '';
				$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-info btn-sm btn-icon icon-left\" OnClick=\"prosesClicked('.$row['id'].')\"><i class=\"fa fa-money\"></i>Proses</a>&nbsp;&nbsp;</br>';
					
				
				if($row['commodity_type'] == '0')
					$commodity_type = 'CPO - Crude Palm Oil';
				elseif($row['commodity_type'] == '1')
					$commodity_type = 'PK - Palm Kernel';
				elseif($row['commodity_type'] == '2')
					$commodity_type = 'FIBRE';
				elseif($row['commodity_type'] == '3')
					$commodity_type = 'CANGKANG';
				
				$totalHarga = $row['jumlah_commodity'] * $row['harga'];
				
				
				
				$tglTransaksi = $this->ConvertDate($row['tgl_transaksi'],'3');
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['transaction_no'].'</td>';
				$tblBody .= '<td>'.$tglTransaksi.'</td>';
				$tblBody .= '<td>'.$row['pembeli'].'</td>';
				$tblBody .= '<td>'.$commodity_type.'</td>';
				$tblBody .= '<td>'.$row['jumlah_commodity'].'</td>';
				$tblBody .= '<td>'.number_format($row['harga'],2,'.',',').'</td>';
				$tblBody .= '<td>'.number_format($totalHarga,2,'.',',').'</td>';
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
			$this->modalJudul->Text = 'Proses Penerimaan Penjualan';
			$this->idPenjualan->Value = $id;
			$this->commodity_type->SelectedValue = $Record->commodity_type;
			$this->pembeli->Text = $Record->pembeli;
			$this->tgl_transaksi->Text = $this->ConvertDate($Record->tgl_transaksi,'1');
			$this->jumlah_kirim->Text = $Record->netto_2;
			$this->jumlah_diterima->Text = $Record->netto_2;
			$this->jumlah_susut->Text = 0;
			$this->harga->Text = $Record->harga;
			$totalJual = $Record->harga * $Record->netto_2;
			$this->total_penjualan->Text = $totalJual;
			$this->sisa_bayar->Text = $totalJual;
			
			$RecordBayar = PenerimaanPenjualanRecord::finder()->find('id_penjualan = ?',$id);
			if($RecordBayar)
			{
				$this->idPenerimaan->Value = $RecordBayar->id;
				$this->tgl_penerimaan->Text = $this->ConvertDate($RecordBayar->tgl_penerimaan,'1');
				$this->tgl_penerimaan->Enabled = false;
				$this->jumlah_diterima->Enabled = false;
				$this->harga->Enabled = false;
				$this->jumlah_diterima->Text = $RecordBayar->jumlah_diterima;
				$this->jumlah_susut->Text = $RecordBayar->jumlah_susut;
				$this->harga->Text = $RecordBayar->harga;
				$totalJual = $RecordBayar->total_penjualan;
				$this->total_penjualan->Text = $totalJual;
			
				$sql = "SELECT SUM(tbt_penerimaan_penjualan_detail.total_pembayaran) AS total_pembayaran FROM tbt_penerimaan_penjualan_detail WHERE id_parent = '".$RecordBayar->id."' ";
				$arr = $this->queryAction($sql,'S');
				
				$this->total_bayar_sebelumnya->Text = $arr[0]['total_pembayaran'];
				
				$this->sisa_bayar->Text = $totalJual- $arr[0]['total_pembayaran'];
			
			}
			
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					var idPenerimaan = jQuery("#'.$this->tgl_penerimaan->getClientID().'").val();
					if(idPenerimaan != "")
					{
						jQuery("#'.$this->tgl_penerimaan->getClientID().'").prop("disabled",true);
						jQuery("#'.$this->jumlah_diterima->getClientID().'").prop("disabled",true);
						jQuery("#'.$this->harga->getClientID().'").prop("disabled",true);
					
					}
					
					jQuery("#modal-1").modal("show");
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
	
	
	public function submitBtnClicked($sender,$param)
	{
		if($this->idPenerimaan->Value != '')
			$Record = PenerimaanPenjualanRecord::finder()->findByPk($this->idPenerimaan->Value);
		else
		{
			$Record = new PenerimaanPenjualanRecord();
			$Record->id_penjualan = $this->idPenjualan->Value;
			$Record->tgl_penerimaan = $this->ConvertDate($this->tgl_penerimaan->Text,'2');
			$Record->jumlah_dikirim = $this->jumlah_kirim->Text;
			$Record->jumlah_diterima = $this->jumlah_diterima->Text;
			$Record->jumlah_susut = $this->jumlah_susut->Text;
			$Record->harga = str_replace(",","",$this->harga->Text);
			$Record->total_penjualan = str_replace(",","",$this->total_penjualan->Text) ;
			$Record->save();
		}
		
		$msg = "Penerimaan Berhasil Diproses !";
		
		$sisa_bayar = str_replace(",","",$this->sisa_bayar->Text);
		$total_pembayaran = str_replace(",","",$this->total_pembayaran->Text);
		
		$RecordDetail = new PenerimaanPenjualanDetailRecord();	
		$RecordDetail->id_parent = $Record->id;
		$RecordDetail->tgl_pembayaran = date("Y-m-d");
		$RecordDetail->wkt_pembayaran = date("G:i:s");
		
		if($total_pembayaran >= $sisa_bayar)
			$RecordDetail->total_pembayaran = $sisa_bayar;
		else
			$RecordDetail->total_pembayaran = $total_pembayaran;
			
		$RecordDetail->id_coa = $this->DDCoa->text;
		$RecordDetail->jns_bayar = $this->DDJnsBayar->SelectedValue;
		if($this->DDJnsBayar->SelectedValue == '1')
			$RecordDetail->id_bank = $this->DDBank->SelectedValue;
		else
			$RecordDetail->id_bank = '8';
			
		$RecordDetail->no_ref = $this->noRef->text;
		$RecordDetail->save();
		
		if($total_pembayaran >= $sisa_bayar)
		{
			$CommodityTransactionRecord = CommodityTransactionRecord::finder()->findByPk($this->idPenjualan->Value);
			$CommodityTransactionRecord->status = '2';
			$CommodityTransactionRecord->save();
		}
		
		$CommodityTransactionRecord = CommodityTransactionRecord::finder()->findByPk($this->idPenjualan->Value);
		$customerName = $CommodityTransactionRecord->pembeli;
		
		if($RecordDetail->id_bank != '8')
			$namaAkun = 'Kas Bank';
		else
			$namaAkun = 'Kas';
		
		$this->UbahSaldoKas('0',$RecordDetail->id_bank,$RecordDetail->total_pembayaran);
		
		$this->InsertJurnalUmum($RecordDetail->id,
								'11',
								'0',
								$RecordDetail->tgl_pembayaran,
								date("G:i:s"),
								$namaAkun,
								$RecordDetail->total_pembayaran,
								$CommodityTransactionRecord->transaction_no,
								$RecordDetail->id_bank);
							
		$this->InsertJurnalUmum($RecordDetail->id,
								'11',
								'1',
								$RecordDetail->tgl_pembayaran,
								date("G:i:s"),
								'Piutang',
								$RecordDetail->total_pembayaran,
								$CommodityTransactionRecord->transaction_no,
								$RecordDetail->id_bank);
		
		
		$this->InsertJurnalBukuBesar($RecordDetail->id,
										'11',
										'0',
										$CommodityTransactionRecord->transaction_no,
										$RecordDetail->tgl_pembayaran,
										date("G:i:s"),
										$RecordDetail->id_coa,
										$RecordDetail->id_bank,
										$namaAkun,
										'Penerimaan Pembayaran Piutang Untuk Commodity No '.$CommodityTransactionRecord->transaction_no,
										$RecordDetail->total_pembayaran);
		
		$this->InsertJurnalBukuBesar($RecordDetail->id,
										'11',
										'1',
										$CommodityTransactionRecord->transaction_no,
										$RecordDetail->tgl_pembayaran,
										date("G:i:s"),
										$RecordDetail->id_coa,
										$RecordDetail->id_bank,
										'Piutang',
										'Penerimaan Pembayaran Piutang Untuk Commodity No '.$CommodityTransactionRecord->transaction_no,
										$RecordDetail->total_pembayaran);
										
		$this->InsertJurnalPenerimaanKas($RecordDetail->id,
										$CommodityTransactionRecord->transaction_no,
										'1',
										$RecordDetail->tgl_pembayaran,
										date("G:i:s"),
										$customerName,
										'',
										'',
										$RecordDetail->total_pembayaran,
										0);
														
		$tblBody = $this->BindGrid();
			
		$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("'.$msg.'");
						clearForm();
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						BindGrid();');	
		
		
	}
	
	public function GenerateNoSales($bln,$thn,$tipeCommodity)
	{
		$query = "SELECT 
						id 
					FROM 
						tbt_contract_sales
					WHERE
					MONTH(tbt_contract_sales.tgl_kontrak) = '$bln'
					AND YEAR(tbt_contract_sales.tgl_kontrak) = '$thn' 
					AND commodity_type = '$tipeCommodity' ";
		$arr = $this->queryAction($query,'S');
		
		$count = count($arr) + 1;
		
		if($count < 10)
			$tmp = "0000";
		elseif($count < 100)
			$tmp = "000";	
		elseif($count < 1000)
			$tmp = "00";
		elseif($count < 10000)
			$tmp = "0";
		else
			$tmp = "";
		
		$blnrmw = $this->bulanRomawi($bln);
		
		if($tipeCommodity == '0')
			$noDoc = "CPO";
		else
			$noDoc = "PK";
					
		$noTrans = $tmp.$count."/PT.SH/".$noDoc."/".$blnrmw."/".$thn;
		
		return $noTrans;
	}
	
	public function cetakClicked($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$url = "index.php?page=Transaksi.cetakKontrakPenjualanPdf&idKontrak=".$id;
		$this->getPage()->getClientScript()->registerEndScript('',"
		jQuery('#cetakFrame').attr('src','".$url."')
		jQuery('#modal-2').modal('show');
		unloadContent();
		");
	}
}
?>
