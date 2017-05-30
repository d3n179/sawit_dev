<?PHP
class PenerimaanJual extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			
			$sql = "SELECT
							tbm_pelanggan.id,
							tbm_pelanggan.nama
						FROM
							tbm_pelanggan
						WHERE
							tbm_pelanggan.deleted = '0' ";
					
			$arr = $this->queryAction($sql,'S');
			$this->id_pembeli->DataSource = $arr;
			$this->id_pembeli->DataBind();
			
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
					tbt_contract_sales.id,
					tbt_contract_sales.`status`,
					tbt_contract_sales.sales_no,
					tbt_contract_sales.tgl_kontrak,
					tbt_contract_sales.commodity_type,
					tbm_pelanggan.nama AS pembeli,
					tbt_contract_sales.quantity AS jumlah,
					tbt_contract_sales.pricing AS harga
				FROM
					tbt_contract_sales
				INNER JOIN tbm_pelanggan ON tbm_pelanggan.id = tbt_contract_sales.id_pembeli
				WHERE
					tbt_contract_sales.deleted = '0'
					AND tbt_contract_sales.status = '1'
				ORDER BY 
					tbt_contract_sales.id ASC ";
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
				else
					$commodity_type = 'PK - Palm Kernel';
				
				$totalHarga = $row['jumlah'] * $row['harga'];
				
				
				
				$tglKontrak = $this->ConvertDate($row['tgl_kontrak'],'3');
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['sales_no'].'</td>';
				$tblBody .= '<td>'.$tglKontrak.'</td>';
				$tblBody .= '<td>'.$row['pembeli'].'</td>';
				$tblBody .= '<td>'.$commodity_type.'</td>';
				$tblBody .= '<td>'.$row['jumlah'].'</td>';
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
		$Record = ContractSalesRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Proses Penerimaan Penjualan';
			$this->idKontrak->Value = $id;
			$this->commodity_type->SelectedValue = $Record->commodity_type;
			$this->id_pembeli->SelectedValue = $Record->id_pembeli;
			$this->tgl_kontrak->Text = $this->ConvertDate($Record->tgl_kontrak,'1');
			$this->quantity->Text = $Record->quantity;
			$this->pricing->Text = $Record->pricing;
			$totalJual = $Record->pricing * $Record->quantity;
			$this->total_jual->Text = $totalJual;
			
			$sql = "SELECT SUM(tbt_penerimaan_penjualan.total_penerimaan) AS total_penerimaan FROM tbt_penerimaan_penjualan WHERE id_kontrak = '".$id."' ";
			$arr = $this->queryAction($sql,'S');
			
			$this->total_terima->Text = $arr[0]['total_penerimaan'];
			$this->sisa_terima->Text = $totalJual- $arr[0]['total_penerimaan'];
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
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
	
	public function editForm($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$Record = ContractSalesRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Kontrak Penjualan';
			$this->idKontrak->Value = $id;
			
			$this->commodity_type->SelectedValue = $Record->commodity_type;
			$this->id_pembeli->SelectedValue = $Record->id_pembeli;
			$this->tgl_kontrak->Text = $this->ConvertDate($Record->tgl_kontrak,'1');
			$this->quantity->Text = $Record->quantity;
			$this->quality->Text = $Record->quality;
			$this->pricing->Text = $Record->pricing;
			$this->delivery->Text = $Record->delivery;
			$this->term_of_payment->Text = $Record->term_of_payment;
			$this->remark->Text = $Record->remark;
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
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
	
	public function approveBtnClicked($sender,$param)
	{
		$id = $this->idKontrak->Value;
		$Record = ContractSalesRecord::finder()->findByPk($id);
		if($Record)
		{
			$Record->status = '1';
			$Record->save();
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
					('','
					toastr.info("Data Telah Disetujui");
					clearForm();
					enabledForm();
					jQuery("#modal-1").modal("hide");
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
					toastr.error("Data gagal Disetujui");
					');
		}
	}
	
	public function cancelBtnClicked($sender,$param)
	{
		$id = $this->idKontrak->Value;
		$Record = ContractSalesRecord::finder()->findByPk($id);
		if($Record)
		{
			$Record->status = '2';
			$Record->save();
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
					('','
					toastr.info("Data Telah Ditolak");
					clearForm();
					enabledForm();
					jQuery("#modal-1").modal("hide");
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
					toastr.error("Data gagal Ditolak");
					');
		}
	}
	
	public function deleteData($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$Record = ContractSalesRecord::finder()->findByPk($id);
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
		$Record = new PenerimaanPenjualanRecord();
		$msg = "Penerimaan Berhasil Diproses !";
		
		$sisa_terima = str_replace(",","",$this->sisa_terima->Text);
		$totalTerima = str_replace(",","",$this->penerimaan->Text);
		
		$Record->id_kontrak = $this->idKontrak->Value;
		$Record->tgl_penerimaan = date("Y-m-d");
		$Record->wkt_penerimaan = date("G:i:s");
		$Record->total_penjualan = $sisa_terima;
		
		if($totalTerima >= $sisa_terima)
			$Record->total_penerimaan = $sisa_terima;
		else
			$Record->total_penerimaan = $totalTerima;
			
		$Record->id_coa = $this->DDCoa->text;
		$Record->jns_bayar = $this->DDJnsBayar->SelectedValue;
		if($this->DDJnsBayar->SelectedValue == '1')
			$Record->id_bank = $this->DDBank->SelectedValue;
		else
			$Record->id_bank = '8';
			
		$Record->no_ref = $this->noRef->text;
		$Record->save();
		
		if($totalTerima >= $sisa_terima)
		{
			$ContractSalesRecord = ContractSalesRecord::finder()->findByPk($this->idKontrak->Value);
			$ContractSalesRecord->status = '3';
			$ContractSalesRecord->save();
		}
		
		$ContractSalesRecord = ContractSalesRecord::finder()->findByPk($this->idKontrak->Value);
		$customerName = PelangganRecord::finder()->findByPk($ContractSalesRecord->id_pembeli)->nama;
		
		$this->InsertJurnalBukuBesar($Record->id,
									'3',
									'0',
									$ContractSalesRecord->sales_no,
									$Record->tgl_penerimaan,
									date("G:i:s"),
									$Record->id_coa,
									$Record->id_bank,
									'Penerimaan Pembayaran Kontrak Penjualan Dari '.$customerName,
									$Record->total_penerimaan);
		
		$this->InsertLabaRugi($Record->id,
								'3',
								'0',
								$Record->tgl_penerimaan,
								date("G:i:s"),
								'Penerimaan Pembayaran Kontrak Penjualan Dari '.$customerName,
								$Record->total_penerimaan,
								$ContractSalesRecord->sales_no);
		
		$this->InsertJurnalUmum($Record->id,
								'5',
								'0',
								$Record->tgl_penerimaan,
								date("G:i:s"),
								'Kas',
								$Record->total_penerimaan,
								$ContractSalesRecord->sales_no);
									
		$this->InsertJurnalUmum($Record->id,
									'5',
									'1',
									$Record->tgl_penerimaan,
									date("G:i:s"),
									'Piutang',
									$Record->total_penerimaan,
									$ContractSalesRecord->sales_no);
															
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
