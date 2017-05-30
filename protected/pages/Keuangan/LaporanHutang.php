<?PHP
class LaporanHutang extends MainConf
{

	public function onLoadComplete($param)
	{
		parent::onLoadComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			//$this->cariBtnClicked($sender,$param);
			if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
			{	
				$sql="SELECT
							tbm_pemasok.id,
							tbm_pemasok.nama
						FROM
							tbm_pemasok
						WHERE
							tbm_pemasok.deleted = '0'";
				$arrKateg = $this->queryAction($sql,'S');
				$this->DDSupplier->DataSource = $arrKateg;
				$this->DDSupplier->DataBind();
				
			}
		}
		
	}
	
	public function onPreRender($param)
	{
		parent::onPreRender($param);
		
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
		}
	}
	
	public function periodeChanged()
	{
	}
	
	public function cariBtnClicked($sender,$param)
	{
		$sqlTrans = "SELECT
					tbt_purchase_order.id,
					tbt_purchase_order.id_supplier,
					tbt_purchase_order.tgl_po,
					tbt_purchase_order.no_po,
					tbt_purchase_order.ppn,
					tbt_purchase_order.dp,
					tbt_purchase_order.tgl_jatuh_tempo,
					tbm_pemasok.nama AS pemasok,
					SUM(tbt_purchase_order_detail.subtotal) AS Total_PO
				FROM
					tbt_purchase_order
				INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_purchase_order.id_supplier
				INNER JOIN tbt_purchase_order_detail ON tbt_purchase_order_detail.id_po = tbt_purchase_order.id
				WHERE
					tbt_purchase_order.deleted = '0'
				AND tbt_purchase_order.`status` = '2' ";
		
		
		if($this->DDSupplier->SelectedValue != '')
			$sqlTrans .= " AND tbt_purchase_order.id_supplier = '".$this->DDSupplier->SelectedValue."' ";
		
		$sqlTrans .= " GROUP BY
							tbt_purchase_order.id
						ORDER BY
							tbt_purchase_order.id ASC ";
			
		$this->setViewState('sql',$sqlTrans);
		$arrTrans = $this->queryAction($sqlTrans,'S');
		$tblBody = '';
		if($arrTrans)
		{
			foreach($arrTrans as $row)
			{
				$ttlPo = 0;
				
				$sqlRO = "SELECT
							tbt_receiving_order_detail.jumlah,
							tbt_receiving_order_detail.harga_satuan,
							tbt_receiving_order_detail.discount,
							tbt_receiving_order_detail.subtotal
						FROM
							tbt_receiving_order
						INNER JOIN tbt_receiving_order_detail ON tbt_receiving_order_detail.id_parent = tbt_receiving_order.id
						INNER JOIN tbm_barang ON tbm_barang.id = tbt_receiving_order_detail.id_barang
						INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_receiving_order_detail.id_satuan 
						WHERE
							tbt_receiving_order.id_po = '".$row['id']."' ";
							
				$arrRO = $this->queryAction($sqlRO,'S');
				
				foreach($arrRO as $rowRO)
				{
					$ttlPo += $rowRO['subtotal'];
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
							$ttlPo += $rowBiaya['biaya'];
					}
				}
				
				$ppnCurrency = $ttlPo * ($row['ppn'] / 100);
				$ttlPo += $ppnCurrency;
				$ttlPo -= $row['dp'];
				
				$ttlByrPo = 0;
				$sqlRecord = "SELECT total_pembayaran FROM tbt_pembayaran_po WHERE id_po = '".$row['id']."' AND deleted = '0' ";
				$arrRecord = $this->queryAction($sqlRecord,'S');
				
				if(count($arrRecord) > 0)
				{
					foreach($arrRecord as $rowRecord)
					{
						$ttlByrPo +=  $rowRecord['total_pembayaran'];
					}
				}
				
				$sisaBayar = $ttlPo - $ttlByrPo;
				
				$date1 = date("Y-m-d");
				$date2 = $row['tgl_jatuh_tempo'];

				$diff = abs(strtotime($date2) - strtotime($date1));

				$years = floor($diff / (365*60*60*24));
				$months = floor(($diff - $years * 365*60*60*24) / (30*60*60*24));
				$days = floor(($diff - $years * 365*60*60*24 - $months*30*60*60*24)/ (60*60*24));
					
				//var_dump($arrTot[0]['total_item']);
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['no_po'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_po'],'3').'</td>';
				$tblBody .= '<td>'.$row['pemasok'].'</td>';
				$tblBody .= '<td>'.number_format($ttlPo,2,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($sisaBayar,2,'.',',').'</td>';	
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_jatuh_tempo'],'3').'</td>';
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = '';
		}
		
		
		$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#table-1").dataTable().fnDestroy();
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					BindGrid();
					unloadContent();
					');
	}
	
	public function detailClicked($sender,$param)
	{
		$idTrans = $param->CallbackParameter->id;
		$sqlDetail = "SELECT
						tbt_penjualan_detail.id,
						tbt_penjualan_detail.id_barang,
						tbm_barang.nama AS barang,
						tbt_penjualan_detail.jml,
						tbt_penjualan_detail.harga,
						tbt_penjualan_detail.total
					FROM
						tbt_penjualan_detail
					INNER JOIN tbm_barang ON tbm_barang.id = tbt_penjualan_detail.id_barang
					WHERE
						tbt_penjualan_detail.deleted ='0'
						AND tbt_penjualan_detail.id_transaksi = '$idTrans' ";
		$arrDetail = $this->queryAction($sqlDetail,'S');
		
		$tblBody = '';
		if($arrDetail > 0)
		{
			foreach($arrDetail as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['barang'].'</td>';
				$tblBody .= '<td>'.$row['jml'].'</td>';
				$tblBody .= '<td>'.$row['harga'].'</td>';
				$tblBody .= '<td>'.$row['total'].'</td>';			
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = '';
		}
		
		$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#tableDetail").dataTable().fnDestroy();
					jQuery("#tableDetail tbody").empty();
					jQuery("#tableDetail tbody").append("'.$tblBody.'");
					BindGridDetail();
					jQuery("#modal-2").modal("show");
					unloadContent();
					');
		
	}
	
	
	public function cetakLapKartuStok()
	{
		//if($this->DDBulan->SelectedValue != '' && $this->DDTahun->SelectedValue != '')
		//{
			$session=new THttpSession;
			$session->open();
			$session['cetakLapHutangSql'] = $this->getViewState('sql');
		
			$this->Response->redirect($this->Service->constructUrl('Keuangan.cetakLapHutangPdf'));
		/*}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					toastr.error("Pilih Bulan Dan Tahun !");
					');
		}*/
	}
	
}
?>
