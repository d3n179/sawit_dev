<?PHP
class RequestOrder extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			
			/*$sqlBarang = "SELECT
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
			$this->DDBarang->DataSource = $arrBarang;
			$this->DDBarang->DataBind();*/
			
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
	
	public function barangChanged()
	{
		$idBarang = $this->DDBarang->Text;
		if($idBarang != '')
		{
			
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
			$this->DDSatuan->SelectedValue = '';
			$this->Jumlah->Text = '';
		}
	}
	
	public function satuanChanged()
	{
		$idBarang = $this->DDBarang->Text;
		$idSatuan = $this->DDSatuan->SelectedValue;
		var_dump($idBarang);
		var_dump($idSatuan);	
		$hargaSatuanBesar = $this->GetLastProductPrice($idBarang);
		
		if($hargaSatuanBesar > 0)
		{
			$hargaPerSatuan = $this->checkConversionPrice($idBarang,$idSatuan,$hargaSatuanBesar);
		}
		else
		{
			$hargaPerSatuan = 0;
		}
		
		$this->hargaSatuanBesar->Value = $hargaSatuanBesar;
		$this->harga->Text = $hargaPerSatuan;
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_request_order.id,
					tbt_request_order.`status`,
					tbt_request_order.no_ro,
					tbt_request_order.tgl_ro,
					tbt_request_order.catatan,
					COUNT(
						tbt_request_order_detail.id
					) AS jml_item,
					SUM(
						tbt_request_order_detail.subtotal
					) AS total_biaya
				FROM
					tbt_request_order
				INNER JOIN tbt_request_order_detail ON tbt_request_order_detail.id_ro = tbt_request_order.id
				WHERE
					tbt_request_order.deleted = '0'
				AND tbt_request_order_detail.deleted = '0'
				GROUP BY
					tbt_request_order.id
				ORDER BY 
					tbt_request_order.id ASC ";
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
					$actionBtn = '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
					$actionBtn .= '<a href=\"javascript:void(0)\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';
				}
				elseif($row['status'] == '1')
				{
					$status = '<div class=\"label label-success\">DITERIMA</div>';
					$actionBtn = '';
				}
				elseif($row['status'] == '2')
				{
					$status = '<div class=\"label label-danger\">DITOLAK</div>';
					$actionBtn = '';
				}
				
				$tglRo = $this->ConvertDate($row['tgl_ro'],'3');
				$tblBody .= '<tr>';
				$tblBody .= '<td class=\"details-control dont_shown\"><input type=\"hidden\" value=\"'.$row['id'].'\"></td>';
				$tblBody .= '<td align=\"center\">'.$status.'</td>';
				$tblBody .= '<td>'.$row['no_ro'].'</td>';
				$tblBody .= '<td>'.$tglRo.'</td>';
				$tblBody .= '<td>'.$row['jml_item'].'</td>';
				$tblBody .= '<td>'.number_format($row['total_biaya'],2,'.',',').'</td>';
				$tblBody .= '<td>'.$row['catatan'].'</td>';
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
		$tglRO = $this->tglRo->Text;
		$detailRO = $param->CallBackParameter->RequestOrderTable;
		var_dump($detailRO);
		if($this->idRo->Value != '')
		{
			$RequestOrderRecord = RequestOrderRecord::finder()->findByPk($this->idRo->Value);
			$msg = "Data Berhasil Diedit";
		}
		else
		{
			$RequestOrderRecord = new RequestOrderRecord();
			$msg = "Data Berhasil Disimpan";
			$RequestOrderRecord->no_ro = $this->GenerateNoDocument('RO');
			$RequestOrderRecord->status = '0';
		}
			
			$RequestOrderRecord->tgl_ro = $this->ConvertDate($tglRO,'2');
			$RequestOrderRecord->save();
				
			foreach($detailRO as $row)
			{
				if($row->id_edit != '')
				{
					$RequestOrderDetailRecord =  RequestOrderDetailRecord::finder()->findByPk($row->id_edit);
				}
				else
				{
					$RequestOrderDetailRecord = new RequestOrderDetailRecord();
					$RequestOrderDetailRecord->status = '0'; 
				}
				
				$RequestOrderDetailRecord->id_ro = $RequestOrderRecord->id;
				$RequestOrderDetailRecord->id_barang = $row->IdBarang;
				$RequestOrderDetailRecord->id_satuan = $row->IdSatuan;
				$RequestOrderDetailRecord->jumlah = $row->Jumlah;
				$RequestOrderDetailRecord->harga_satuan_besar = $row->hargaSatuanBesar;
				$RequestOrderDetailRecord->harga_satuan = $row->harga;
				$RequestOrderDetailRecord->subtotal = $row->subtotal;
				$RequestOrderDetailRecord->deleted = $row->deleted;
				$RequestOrderDetailRecord->save();
			}
			
			$this->idRo->Value = '';
			$this->tglRo->Text = '';
			$tblBody = $this->BindGrid();
			
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("'.$msg.'");
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");');	
		
	}
	
	public function checkMaxBeli()
	{
		$Barang = $this->DDBarang->Text;
		$Satuan = $this->DDSatuan->SelectedValue;
		$Jumlah = $this->Jumlah->Text;
		
		$idMaxSatuan = BarangSatuanRecord::finder()->find('urutan = ? AND id_barang = ? AND deleted = ?','1',$Barang,'0')->id_satuan;
		$MaxBeliBulanan = BarangRecord::finder()->findByPk($Barang)->max_beli_bulanan;
		$sqlStock = "SELECT
							SUM(tbd_stok_barang.stok) AS stok
						FROM
							tbd_stok_barang
						WHERE
							tbd_stok_barang.expired_date > CURDATE()
						AND id_barang = '$Barang'
						AND deleted != '1' ";
		$arrStock = $this->queryAction($sqlStock,'S');
		$CurrentStock = $arrStock[0]['stok'];
		$CurrentStock = $this->getTargetUom($Barang,$CurrentStock,'0','1',$idMaxSatuan);
		
		$AddStock = $Jumlah;
		$AddStock = $this->getTargetUom($Barang,$AddStock,$Satuan,'1',$idMaxSatuan);
		
		$TotalStock = $CurrentStock + $AddStock;
		
		var_dump($CurrentStock);
		var_dump($AddStock);
		var_dump($TotalStock);
		if($TotalStock > $MaxBeliBulanan)
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					toastr.error("Jumlah Pembelian Bulanan telah melebihi maksimum pembelian bulanan !");
					');
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					addBarang();
					');
		}
	}
	
	public function generateDetailCallback($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		
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
					$tblBody .= '<td>'.number_format($row['subtotal'],2,'.',',').'</td>';			
					$tblBody .= '</tr>';
			}
		}
		$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#tableDetail-'.$id.' tbody").empty();
					jQuery("#tableDetail-'.$id.' tbody").append("'.$tblBody.'");
					unloadContent();');
	}
	
}
?>
