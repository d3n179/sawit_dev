<?PHP
class LaporanHutangPO extends MainConf
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
							INNER JOIN tbm_kategori_pemasok 
						WHERE
							tbm_pemasok.deleted = '0' ";
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
						tbt_purchase_order.id_supplier,
						tbm_pemasok.nama AS pemasok,
						COUNT(tbt_purchase_order.id) AS jml_po
					FROM
						tbt_purchase_order
					INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_purchase_order.id_supplier
					WHERE
						tbt_purchase_order.`status` = '2' 
						AND tbt_purchase_order.deleted = '0' ";
		
		
		if($this->DDSupplier->SelectedValue != '')
			$sqlTrans .= " AND tbt_purchase_order.id_supplier = '".$this->DDSupplier->SelectedValue."' ";
		
		$sqlTrans .= " GROUP BY
							tbt_purchase_order.id_supplier
						ORDER BY
							tbt_purchase_order.id_supplier ASC ";
			
		$this->setViewState('sql',$sqlTrans);
		$arrTrans = $this->queryAction($sqlTrans,'S');
		$tblBody = '';
		if($arrTrans)
		{
			foreach($arrTrans as $row)
			{
				$ttlPo = 0;
				$idSupplier = $row['id_supplier'];
				$sqlPO ="SELECT
						tbt_purchase_order.id,
						tbt_purchase_order.dp,
						tbt_purchase_order.ppn
					FROM
						tbt_purchase_order
					WHERE
						tbt_purchase_order.`status` = '2' 
						AND tbt_purchase_order.id_supplier = '".$idSupplier."' 
						AND tbt_purchase_order.deleted ='0' ";
				$arrPo = $this->queryAction($sqlPO,'S');
				foreach($arrPo as $rowPo)
				{
					$idPo = $rowPo['id'];
					$ppn = $rowPo['ppn'];
					
					$sqlTtlPO = "SELECT
									SUM(
										tbt_receiving_order_detail.subtotal
									) AS total_po
								FROM
									tbt_receiving_order_detail
								INNER JOIN tbt_receiving_order ON tbt_receiving_order.id = tbt_receiving_order_detail.id_parent
								INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_receiving_order.id_po
								WHERE
									tbt_purchase_order.id = '".$idPo."'
									AND tbt_receiving_order.deleted = '0' 
									AND tbt_receiving_order_detail.deleted = '0' 
								GROUP BY
									tbt_purchase_order.id ";
					$arrTtlPO = $this->queryAction($sqlTtlPO,'S');
					$ttlPo += $arrTtlPO[0]['total_po'];
					
					$sqlBiaya = "SELECT
									SUM(
										tbt_purchase_order_biaya_lain.biaya
									) AS Total_Biaya
								FROM
									tbt_purchase_order_biaya_lain
								INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_purchase_order_biaya_lain.id_po
								WHERE
									tbt_purchase_order.id = '".$idPo."'
								AND tbt_purchase_order_biaya_lain.deleted = '0'
								GROUP BY
									tbt_purchase_order.id";
									
					$arrTtlBiaya = $this->queryAction($sqlBiaya,'S');
					$ttlPo += $arrTtlBiaya[0]['Total_Biaya'];
					
					$ppnCurrency = $ttlPo * ($rowPo['ppn'] / 100);
					$ttlPo += $ppnCurrency;
					$ttlPo -= $rowPo['dp'];
				}
				
				$sqlBayar = "SELECT
								SUM(
									tbt_pembayaran_po.total_pembayaran
								) AS total_pembayaran
							FROM
								tbt_pembayaran_po
							INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_pembayaran_po.id_po
							WHERE
								tbt_purchase_order.id_supplier = '".$idSupplier."'
							AND tbt_pembayaran_po.deleted = '0'
							AND tbt_purchase_order.`status` = '2'
							AND tbt_purchase_order.deleted = '0'
							GROUP BY
								tbt_purchase_order.id ";
				$arrttlByrPo = $this->queryAction($sqlBayar,'S');
				$ttlByrPo = $arrttlByrPo[0]['total_pembayaran'];
				$sisaBayar = $ttlPo - $ttlByrPo;
				
				
				$sqlDiff30 = "SELECT
									COUNT(tbt_purchase_order.id) AS umur
								FROM
									tbt_purchase_order
								WHERE
									tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.id_supplier = '".$idSupplier."'
								AND DATEDIFF(
									tbt_purchase_order.tgl_jatuh_tempo,
									CURDATE()
								) <= 30 ";
				$arrDiff30 = $this->queryAction($sqlDiff30,'S');
				$diff30 = $arrDiff30[0]['umur'];
				
				$sqlDiff60 = "SELECT
									COUNT(tbt_purchase_order.id) AS umur
								FROM
									tbt_purchase_order
								WHERE
									tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.id_supplier = '".$idSupplier."'
								AND DATEDIFF(
									tbt_purchase_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 30 AND 60 ";
				$arrDiff60 = $this->queryAction($sqlDiff60,'S');
				$diff60 = $arrDiff60[0]['umur'];
				
				$sqlDiff90 = "SELECT
									COUNT(tbt_purchase_order.id) AS umur
								FROM
									tbt_purchase_order
								WHERE
									tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.id_supplier = '".$idSupplier."'
								AND DATEDIFF(
									tbt_purchase_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 60 AND 90 ";
				$arrDiff90 = $this->queryAction($sqlDiff90,'S');
				$diff90 = $arrDiff90[0]['umur'];
				
				$sqlDiff120 = "SELECT
									COUNT(tbt_purchase_order.id) AS umur
								FROM
									tbt_purchase_order
								WHERE
									tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.id_supplier = '".$idSupplier."'
								AND (DATEDIFF(
									tbt_purchase_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 90 AND 120  OR  DATEDIFF(
									tbt_purchase_order.tgl_jatuh_tempo,
									CURDATE()
								) > 120 )";
				$arrDiff120 = $this->queryAction($sqlDiff120,'S');
				$diff120 = $arrDiff120[0]['umur'];
				
				/*$years = floor($diff / (365*60*60*24));
				$months = floor(($diff - $years * 365*60*60*24) / (30*60*60*24));
				$days = floor(($diff - $years * 365*60*60*24 - $months*30*60*60*24)/ (60*60*24));*/
					
				//var_dump($arrTot[0]['total_item']);
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['pemasok'].'</td>';
				$tblBody .= '<td>'.$row['jml_po'].'</td>';
				$tblBody .= '<td>'.number_format($ttlPo,2,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($ttlByrPo,2,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($sisaBayar,2,'.',',').'</td>';	
				
				$tblBody .= '<td>'.$diff30 .'</td>';
				$tblBody .= '<td>'.$diff60 .'</td>';
				$tblBody .= '<td>'.$diff90 .'</td>';
				$tblBody .= '<td>'.$diff120 .'</td>';
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
			$session['cetakLapUmurHutangSql'] = $this->getViewState('sql');
		
			$this->Response->redirect($this->Service->constructUrl('Keuangan.cetakLapUmurHutangPdf'));
			
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
