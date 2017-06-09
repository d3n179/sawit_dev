<?PHP
class ContractSales extends MainConf
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
	
	public function commodityChanged()
	{
		$idCommodity = $this->commodity_type->SelectedValue;
		
		if($idCommodity != '')
		{
			/*if($idCommodity == '0')
				$idBarang = '10';
			else
				$idBarang = '11';*/
				
			$sqlSatuan = "SELECT
							tbm_satuan.id,
							tbm_satuan.nama
						FROM
							tbm_satuan
						WHERE
							tbm_satuan.deleted = '0'
							AND tbm_satuan.id = '12' ";
						//AND tbm_satuan_barang.deleted = '0'
						//AND tbm_satuan_barang.id_barang = '$idBarang' ";
						
			$arrSatuan = $this->queryAction($sqlSatuan,'S');
			$this->DDSatuan->DataSource = $arrSatuan;
			$this->DDSatuan->DataBind();
			
			if($this->idKontrak->Value == '')
				$this->DDSatuan->Enabled = true;
			else
				$this->DDSatuan->Enabled = false;
				
		}
		else
		{
			$this->DDSatuan->SelectedValue = 'empty';
			$this->DDSatuan->Enabled = false;
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
					tbt_contract_sales.id_pembeli AS pembeli,
					tbt_contract_sales.sales_no,
					tbt_contract_sales.tgl_kontrak,
					tbt_contract_sales.commodity_type,
					tbt_contract_sales.quantity AS jumlah,
					tbm_satuan.nama AS satuan,
					tbt_contract_sales.pricing AS harga
				FROM
					tbt_contract_sales
				LEFT JOIN tbm_satuan ON tbm_satuan.id = tbt_contract_sales.satuan_commodity
				WHERE
					tbt_contract_sales.deleted = '0'
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
				if($row['status'] == '0')
				{
					$status = '<div class=\"label label-secondary\">NEW</div>';
					$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-info btn-sm btn-icon icon-left\" OnClick=\"cetakClicked('.$row['id'].')\"><i class=\"entypo-print\" ></i>Cetak Kontrak</a>&nbsp;&nbsp;</br>';
					$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-primary btn-sm btn-icon icon-left\" OnClick=\"prosesClicked('.$row['id'].')\"><i class=\"entypo-check\" ></i>Proses</a>&nbsp;&nbsp;</br>';
					$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;</br>';
					$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';	
				}
				elseif($row['status'] == '1' || $row['status'] == '3')
				{
					$status = '<div class=\"label label-success\">APPROVED</div>';
					$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-info btn-sm btn-icon icon-left\" OnClick=\"cetakClicked('.$row['id'].')\"><i class=\"entypo-print\" ></i>Cetak Kontrak</a>&nbsp;&nbsp;</br>';
					//$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-orange btn-sm btn-icon icon-left\" OnClick=\"cetakClicked('.$row['id'].')\"><i class=\"entypo-print\" ></i>Cetak DO</a>&nbsp;&nbsp;</br>';
					$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-gold btn-sm btn-icon icon-left\" OnClick=\"cetakClicked('.$row['id'].')\"><i class=\"entypo-print\" ></i>Cetak Surat Kuasa</a>&nbsp;&nbsp;';
				}
				elseif($row['status'] == '2')
				{
					$status = '<div class=\"label label-danger\">CANCELLED</div>';
					$actionBtn .= '';
				}
				elseif($row['status'] == '4')
				{
					$status = '<div class=\"label label-primary\">DELIVERED</div>';
					$actionBtn .= '';
				}
				
				if($row['commodity_type'] == '0')
					$commodity_type = 'CPO - Crude Palm Oil';
				elseif($row['commodity_type'] == '1')
					$commodity_type = 'PK - Palm Kernel';
				elseif($row['commodity_type'] == '2')
					$commodity_type = 'FIBRE';
				elseif($row['commodity_type'] == '3')
					$commodity_type = 'CANGKANG';
				
				$totalHarga = $row['jumlah'] * $row['harga'];
				
				
				
				$tglKontrak = $this->ConvertDate($row['tgl_kontrak'],'3');
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"center\">'.$status.'</td>';
				$tblBody .= '<td>'.$row['sales_no'].'</td>';
				$tblBody .= '<td>'.$tglKontrak.'</td>';
				$tblBody .= '<td>'.$row['pembeli'].'</td>';
				$tblBody .= '<td>'.$commodity_type.'</td>';
				$tblBody .= '<td>'.$row['jumlah'].' '.$row['satuan'].'</td>';
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
			$this->modalJudul->Text = 'Proses Kontrak Penjualan';
			$this->idKontrak->Value = $id;
			$this->commodity_type->SelectedValue = $Record->commodity_type;
			$this->commodityChanged();
			$this->id_pembeli->Text = $Record->id_pembeli;
			$this->alamat_pembeli->text = $Record->alamat_pembeli;
			$this->npwp->text = $Record->npwp;
			$this->tgl_kontrak->Text = $this->ConvertDate($Record->tgl_kontrak,'1');
			$this->quantity->Text = $Record->quantity;
			$this->DDSatuan->SelectedValue = $Record->satuan_commodity;
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
	
	public function editForm($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$Record = ContractSalesRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Kontrak Penjualan';
			$this->idKontrak->Value = $id;
			
			$this->commodity_type->SelectedValue = $Record->commodity_type;
			$this->commodityChanged();
			$this->id_pembeli->Text = $Record->id_pembeli;
			$this->alamat_pembeli->text = $Record->alamat_pembeli;
			$this->npwp->text = $Record->npwp;
			$this->tgl_kontrak->Text = $this->ConvertDate($Record->tgl_kontrak,'1');
			$this->quantity->Text = $Record->quantity;
			$this->DDSatuan->SelectedValue = $Record->satuan_commodity;
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
			
			/*$commodityType = $Record->commodity_type;
			
			if($commodityType == '0')
				$idBarang = '10';
			else
				$idBarang = '11';
			
			$Qty = $this->getTargetUom($idBarang,$Record->quantity,$Record->satuan_commodity,'1','0');
			
			$urutan = BarangSatuanRecord::finder()->find('id_barang = ? AND id_satuan = ? ',$idBarang,$Record->satuan_commodity)->urutan;
			$hrgSatuanBesar = $this->GetPriceUom($idBarang,$urutan,$Record->pricing);
			
			$BarangHargaRecord = new BarangHargaRecord();
			$BarangHargaRecord->id_barang = $idBarang;
			$BarangHargaRecord->tgl = date("Y-m-d");
			$BarangHargaRecord->harga = $hrgSatuanBesar;
			$BarangHargaRecord->deleted = '0';
			$BarangHargaRecord->save();
					
			$this->InsertJurnalUmum($Record->id,
								'4',
								'0',
								date("Y-m-d"),
								date("G:i:s"),
								'Piutang',
								$Record->quantity * $Record->pricing,
								$Record->sales_no);
									
			$this->InsertJurnalUmum($Record->id,
									'4',
									'1',
									date("Y-m-d"),
									date("G:i:s"),
									'Pendapatan',
									$Record->quantity * $Record->pricing,
									$Record->sales_no);
									
			$satuanNama = SatuanRecord::finder()->findByPk($Record->satuan_commodity)->nama;
			$StockBarangRecord = StockBarangRecord::finder()->find('id_barang = ? AND expired_date = ?',$idBarang,"0000-00-00");
			if($StockBarangRecord)
			{
				$currentQty = $this->getTargetUom($idBarang,$StockBarangRecord->stok,'0','1',$Record->satuan_commodity);
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
					$StockInOutRecord->nilai_out = $Record->quantity * $Record->pricing;
					$StockInOutRecord->stok_akhir = $stokAkhir;
					$StockInOutRecord->keterangan = "Penjualan Commodity CPO & PK";
					$StockInOutRecord->id_transaksi = $Record->id;
					$StockInOutRecord->jns_transaksi = '7';
					$StockInOutRecord->tgl = date("Y-m-d");
					$StockInOutRecord->wkt = date("G:i:s");
					$StockInOutRecord->username = $this->User->IsUser;
					$StockInOutRecord->save();
				
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
			}*/
					
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
		if($this->idKontrak->Value != '')
		{
			$Record = ContractSalesRecord::finder()->findByPk($this->idKontrak->Value);
			$msg = "Data Berhasil Diedit";
		}
		else
		{
			$Record = new ContractSalesRecord();
			$msg = "Data Berhasil Disimpan";
			
			$bln = substr($this->tgl_kontrak->Text,3,2);
			$thn = substr($this->tgl_kontrak->Text,6,4);
			$tipeCommodity = $this->commodity_type->SelectedValue;
			
			$Record->sales_no = $this->GenerateNoSales($bln,$thn,$tipeCommodity);
		}
		
		
		$Record->tgl_kontrak = $this->ConvertDate($this->tgl_kontrak->Text,'2');
		$Record->id_pembeli = strtoupper($this->id_pembeli->Text);
		$Record->alamat_pembeli = $this->alamat_pembeli->text;
		$Record->npwp = $this->npwp->text;
		$Record->commodity_type = $this->commodity_type->SelectedValue;
		$Record->quantity = $this->quantity->text;
		$Record->satuan_commodity = $this->DDSatuan->SelectedValue;
		$Record->quality = $this->quality->text;
		$Record->pricing = $this->pricing->text;
		$Record->delivery = $this->delivery->text;
		$Record->term_of_payment = $this->term_of_payment->text;
		$Record->remark = $this->remark->text;
		$Record->status = '0';
		$Record->save();
				
		$tblBody = $this->BindGrid();
			
		$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("'.$msg.'");
						clearForm();
						enabledForm();
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						BindGrid();');	
		
		
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
