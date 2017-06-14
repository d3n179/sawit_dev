<?PHP
class PurchaseOrder extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			
			$sql = "SELECT
							tbm_pemasok.id,
							tbm_pemasok.nama
						FROM
							tbm_pemasok
							INNER JOIN tbm_kategori_pemasok ON tbm_kategori_pemasok.id = tbm_pemasok.kategori_id
						WHERE
							tbm_pemasok.deleted = '0' 
							AND tbm_kategori_pemasok.jenis_kategori = '1' ";
					
			$arr = $this->queryAction($sql,'S');
			$this->DDSupplier->DataSource = $arr;
			$this->DDSupplier->DataBind();
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
					tbt_purchase_order.id,
					tbt_purchase_order.`status`,
					tbt_purchase_order.no_po,
					tbt_purchase_order.tgl_po,
					tbm_pemasok.nama AS supplier,
					tbt_purchase_order.catatan,
					COUNT(
						tbt_purchase_order_detail.id
					) AS jml_item,
					SUM(
						tbt_purchase_order_detail.subtotal
					) AS total_biaya
				FROM
					tbt_purchase_order
				INNER JOIN tbt_purchase_order_detail ON tbt_purchase_order_detail.id_po = tbt_purchase_order.id
				INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_purchase_order.id_supplier
				WHERE
					tbt_purchase_order.deleted = '0'
				AND tbt_purchase_order_detail.deleted = '0'
				GROUP BY
					tbt_purchase_order.id
				ORDER BY 
					tbt_purchase_order.id ASC ";
		$arr = $this->queryAction($sql,'S');
		
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($arr as $row)
			{
				
				if($row['status'] == '0')
				{
					$status = '<div class=\"label label-secondary\">NEW</div>';
					$actionBtn = '';
				}
				elseif($row['status'] == '1')
				{
					$status = '<div class=\"label label-danger\">PARSIAL</div>';
					$actionBtn = '';
				}
				elseif($row['status'] == '2')
				{
					$status = '<div class=\"label label-success\">DITERIMA</div>';
					$actionBtn = '';
				}
				elseif($row['status'] == '3')
				{
					$status = '<div class=\"label label-warning\">DIBAYAR</div>';
					$actionBtn = '';
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

				$actionBtn = '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"cetakClicked('.$row['id'].')\"><i class=\"entypo-print\" ></i>Cetak</a>&nbsp;&nbsp;';
				$tglPo = $this->ConvertDate($row['tgl_po'],'3');
				$tblBody .= '<tr>';
				$tblBody .= '<td class=\"details-control dont_shown\"><input type=\"hidden\" value=\"'.$row['id'].'\"></td>';
				$tblBody .= '<td align=\"center\">'.$status.'</td>';
				$tblBody .= '<td>'.$row['no_po'].'</td>';
				$tblBody .= '<td>'.$tglPo.'</td>';
				$tblBody .= '<td>'.$row['supplier'].'</td>';
				$tblBody .= '<td>'.$row['jml_item'].'</td>';
				$tblBody .= '<td>'.number_format($row['total_biaya']+$BiayaLain,2,'.',',').'</td>';
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
		$id = $param->CallbackParameter->id;
		$RequestOrderRecord = RequestOrderRecord::finder()->findByPk($id);
		if($RequestOrderRecord)
		{
			$this->modalJudul->Text = 'Edit Request Order';
			$this->idRo->Value = $id;
			$this->tglRo->Text = $this->ConvertDate($RequestOrderRecord->tgl_ro,'1');
			
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
					AND tbt_request_order_detail.id_ro = '$id'
					ORDER BY
						tbt_request_order_detail.id ASC ";
			$arr = $this->queryAction($sql,'S');
			$arrJson = json_encode($arr,true);
			var_dump($arrJson);
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					RenderTempTable('.$arrJson.');
					jQuery("#modal-1").modal("show");');
					
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
		$RequestOrderRecord = RequestOrderRecord::finder()->findByPk($id);
		if($RequestOrderRecord)
		{
			$RequestOrderRecord->deleted = '1';
			$RequestOrderRecord->save();
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
		$tglPo = $this->tglPo->Text;
		$detailRO = $param->CallBackParameter->PurchaseOrderTable;
		$BiayaTable = $param->CallBackParameter->BiayaTable;
		var_dump($detailRO);
		$msg = "Purchase Order Telah Dibuat";
		
		if(count($detailRO) > 0)
		{
			$PurchaseOrderRecord = new PurchaseOrderRecord();
			$PurchaseOrderRecord->no_po = $this->GenerateNoDocument('PO');
			$PurchaseOrderRecord->tgl_po = $this->ConvertDate($tglPo,'2');
			$PurchaseOrderRecord->id_ro = $this->DDRequestOrder->SelectedValue;
			$PurchaseOrderRecord->id_supplier = $this->DDSupplier->SelectedValue;
			$PurchaseOrderRecord->ppn = $this->ppn->text;
			$PurchaseOrderRecord->dp = str_replace(",","",$this->dp->text);
			$PurchaseOrderRecord->status = '0';
			
			$PurchaseOrderRecord->save();
			foreach($detailRO as $row)
			{
				$PurchaseOrderDetailRecord = new PurchaseOrderDetailRecord();
				$PurchaseOrderDetailRecord->status = '0'; 
				
				$PurchaseOrderDetailRecord->id_ro_detail = $row->id_edit;
				$PurchaseOrderDetailRecord->id_po = $PurchaseOrderRecord->id;
				$PurchaseOrderDetailRecord->id_barang = $row->IdBarang;
				$PurchaseOrderDetailRecord->id_satuan = $row->IdSatuan;
				$PurchaseOrderDetailRecord->jumlah = $row->Jumlah;
				$PurchaseOrderDetailRecord->jumlah_diterima = 0;
				$PurchaseOrderDetailRecord->harga_satuan_besar = $row->hargaSatuanBesar;
				$PurchaseOrderDetailRecord->harga_satuan = $row->harga;
				$PurchaseOrderDetailRecord->discount = $row->discount;
				$PurchaseOrderDetailRecord->subtotal = $row->subtotal;
				$PurchaseOrderDetailRecord->deleted = $row->deleted;
				$PurchaseOrderDetailRecord->save();
				
				$RequestOrderDetailRecord = RequestOrderDetailRecord::finder()->findByPk($row->id_edit);
				$RequestOrderDetailRecord->status = '1';
				$RequestOrderDetailRecord->save();
			}
			
			foreach($BiayaTable as $rowBiaya)
			{
				$PurchaseOrderBiayaLainRecord = new PurchaseOrderBiayaLainRecord();
				$PurchaseOrderBiayaLainRecord->id_po = $PurchaseOrderRecord->id;
				$PurchaseOrderBiayaLainRecord->nama_biaya = $rowBiaya->nama_biaya;
				$PurchaseOrderBiayaLainRecord->biaya = $rowBiaya->biaya;
				$PurchaseOrderBiayaLainRecord->save();
			}
			
			if($PurchaseOrderRecord->dp > 0)
			{
				$this->InsertJurnalUmum($PurchaseOrderRecord->id,
									'8',
									'0',
									$PurchaseOrderRecord->tgl_po,
									date("G:i:s"),
									'Uang Muka Pembelian',
									$PurchaseOrderRecord->dp,
									$PurchaseOrderRecord->no_po);
										
				$this->InsertJurnalUmum($PurchaseOrderRecord->id,
										'8',
										'1',
										$PurchaseOrderRecord->tgl_po,
										date("G:i:s"),
										'Kas',
										$PurchaseOrderRecord->dp,
										$PurchaseOrderRecord->no_po);
			}
									
			$tblBody = $this->BindGrid();
			
		$url = "index.php?page=Transaksi.cetakPurchaseOrder&idPo=".$PurchaseOrderRecord->id;
			
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("'.$msg.'");
						clearForm();
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						jQuery("#cetakPOFrame").attr("src","'.$url.'")
						jQuery("#modal-2").modal("show");');	
		}
		
	}
	
	
	public function generateDetailCallback($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		
		$sql = "SELECT
					tbt_purchase_order_detail.id,
					tbt_purchase_order_detail.id_barang,
					tbm_barang.nama,
					tbt_purchase_order_detail.id_satuan,
					tbm_satuan.nama AS satuan,
					tbt_purchase_order_detail.harga_satuan_besar,
					tbt_purchase_order_detail.harga_satuan,
					tbt_purchase_order_detail.jumlah,
					tbt_purchase_order_detail.discount,
					tbt_purchase_order_detail.subtotal
				FROM
					tbt_purchase_order_detail
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_purchase_order_detail.id_barang
				INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_purchase_order_detail.id_satuan
				WHERE
					tbt_purchase_order_detail.deleted = '0'
				AND tbt_purchase_order_detail.id_po = '$id'
				ORDER BY
					tbt_purchase_order_detail.id ASC ";
					
		$arr = $this->queryAction($sql,'S');
		var_dump($sql);
		if(count($arr) > 0)
		{
			foreach($arr as $row)
			{
					$tblBody .= '<tr>';
					$tblBody .= '<td>'.$row['nama'].'</td>';
					$tblBody .= '<td>'.$row['satuan'].'</td>';
					$tblBody .= '<td>'.number_format($row['harga_satuan'],2,'.',',').'</td>';
					$tblBody .= '<td>'.$row['jumlah'].'</td>';	
					$tblBody .= '<td>'.$row['discount'].'</td>';	
					$tblBody .= '<td>'.number_format($row['subtotal'],2,'.',',').'</td>';			
					$tblBody .= '</tr>';
			}
		}
		
		$sqlBiaya = "SELECT
									tbt_purchase_order_biaya_lain.nama_biaya,
									tbt_purchase_order_biaya_lain.biaya
								FROM
									tbt_purchase_order_biaya_lain
								WHERE
									tbt_purchase_order_biaya_lain.deleted = '0'
								AND tbt_purchase_order_biaya_lain.id_po = '".$id."' ";

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
	
	public function cetakClicked($sender,$param)
	{
		$idPo = $param->CallbackParameter->id;
		$url = "index.php?page=Transaksi.cetakPurchaseOrder&idPo=".$idPo;
		$folderApp = explode("/",$_SERVER['REQUEST_URI']);
		$urlTemp="http://".$_SERVER['HTTP_HOST']."/".$folderApp[1]."/".$url;
		
		$this->getPage()->getClientScript()->registerEndScript('',"
					var url = '".$urlTemp."';
					window.open(url, '_blank');
					unloadContent();
		");
	}
}
?>
