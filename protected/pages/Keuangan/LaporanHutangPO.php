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
					//$ttlPo += $arrTtlBiaya[0]['Total_Biaya'];
					
					$ppnCurrency = $ttlPo * ($rowPo['ppn'] / 100);
					$ttlPo += $ppnCurrency + $arrTtlBiaya[0]['Total_Biaya'];
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
									tbt_purchase_order.id,
									tbt_purchase_order.dp,
									tbt_purchase_order.ppn
								FROM
									tbt_purchase_order
								WHERE
									tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.id_supplier = '".$idSupplier."'
								AND tbt_purchase_order.deleted = '0' 
								AND DATEDIFF(
									tbt_purchase_order.tgl_jatuh_tempo,
									CURDATE()
								) <= 30 ";
				$arrDiff30 = $this->queryAction($sqlDiff30,'S');
				$ttlPo30 = 0;
				$ttlByrPo30 = 0;
				foreach($arrDiff30 as $rowPo30)
				{
					$idPo = $rowPo30['id'];
					$ppn = $rowPo30['ppn'];
					
					$sqlTtlPO30 = "SELECT
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
					$arrTtlPO30 = $this->queryAction($sqlTtlPO30,'S');
					$ttlPo30 += $arrTtlPO30[0]['total_po'];
					
					$sqlBiaya30 = "SELECT
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
									
					$arrTtlBiaya30 = $this->queryAction($sqlBiaya30,'S');
					//$ttlPo += $arrTtlBiaya[0]['Total_Biaya'];
					
					$ppnCurrency = $ttlPo30 * ($rowPo30['ppn'] / 100);
					$ttlPo30 += $ppnCurrency + $arrTtlBiaya30[0]['Total_Biaya'];
					$ttlPo30 -= $rowPo30['dp'];
					
					$sqlBayar30 = "SELECT
									SUM(
										tbt_pembayaran_po.total_pembayaran
									) AS total_pembayaran
								FROM
									tbt_pembayaran_po
								INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_pembayaran_po.id_po
								WHERE
									tbt_purchase_order.id = '".$idPo."'
								AND tbt_pembayaran_po.deleted = '0'
								AND tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.deleted = '0'
								GROUP BY
									tbt_purchase_order.id ";
					$arrttlByrPo30 = $this->queryAction($sqlBayar30,'S');
					$ttlByrPo30 += $arrttlByrPo30[0]['total_pembayaran'];
					
				}
				$sisaBayar30 = $ttlPo30 - $ttlByrPo30;
				$diff30 = $sisaBayar30;
				
				
				$sqlDiff60 = "SELECT
									tbt_purchase_order.id,
									tbt_purchase_order.dp,
									tbt_purchase_order.ppn
								FROM
									tbt_purchase_order
								WHERE
									tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.id_supplier = '".$idSupplier."'
								AND tbt_purchase_order.deleted = '0' 
								AND DATEDIFF(
									tbt_purchase_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 30 AND 60 ";
				$arrDiff60 = $this->queryAction($sqlDiff60,'S');
				$ttlPo60 = 0;
				$ttlByrPo60 = 0;
				foreach($arrDiff60 as $rowPo60)
				{
					$idPo = $rowPo60['id'];
					$ppn = $rowPo60['ppn'];
					
					$sqlTtlPO60 = "SELECT
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
					$arrTtlPO60 = $this->queryAction($sqlTtlPO60,'S');
					$ttlPo60 += $arrTtlPO60[0]['total_po'];
					
					$sqlBiaya60 = "SELECT
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
									
					$arrTtlBiaya60 = $this->queryAction($sqlBiaya60,'S');
					//$ttlPo += $arrTtlBiaya[0]['Total_Biaya'];
					
					$ppnCurrency = $ttlPo60 * ($rowPo60['ppn'] / 100);
					$ttlPo60 += $ppnCurrency + $arrTtlBiaya60[0]['Total_Biaya'];
					$ttlPo60 -= $rowPo60['dp'];
					
					$sqlBayar60 = "SELECT
									SUM(
										tbt_pembayaran_po.total_pembayaran
									) AS total_pembayaran
								FROM
									tbt_pembayaran_po
								INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_pembayaran_po.id_po
								WHERE
									tbt_purchase_order.id = '".$idPo."'
								AND tbt_pembayaran_po.deleted = '0'
								AND tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.deleted = '0'
								GROUP BY
									tbt_purchase_order.id ";
					$arrttlByrPo60 = $this->queryAction($sqlBayar60,'S');
					$ttlByrPo60 += $arrttlByrPo60[0]['total_pembayaran'];
					
				}
				$sisaBayar60 = $ttlPo60 - $ttlByrPo60;
				$diff60 = $sisaBayar60;
				
				
				$sqlDiff90 = "SELECT
									tbt_purchase_order.id,
									tbt_purchase_order.dp,
									tbt_purchase_order.ppn
								FROM
									tbt_purchase_order
								WHERE
									tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.id_supplier = '".$idSupplier."'
								AND tbt_purchase_order.deleted = '0' 
								AND DATEDIFF(
									tbt_purchase_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 60 AND 90 ";
				$arrDiff90 = $this->queryAction($sqlDiff90,'S');
				$ttlPo90 = 0;
				$ttlByrPo90 = 0;
				foreach($arrDiff90 as $rowPo90)
				{
					$idPo = $rowPo90['id'];
					$ppn = $rowPo90['ppn'];
					
					$sqlTtlPO90 = "SELECT
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
					$arrTtlPO90 = $this->queryAction($sqlTtlPO90,'S');
					$ttlPo90 += $arrTtlPO90[0]['total_po'];
					
					$sqlBiaya90 = "SELECT
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
									
					$arrTtlBiaya90 = $this->queryAction($sqlBiaya90,'S');
					//$ttlPo += $arrTtlBiaya[0]['Total_Biaya'];
					
					$ppnCurrency = $ttlPo90 * ($rowPo90['ppn'] / 100);
					$ttlPo90 += $ppnCurrency + $arrTtlBiaya90[0]['Total_Biaya'];
					$ttlPo90 -= $rowPo90['dp'];
					
					$sqlBayar90 = "SELECT
									SUM(
										tbt_pembayaran_po.total_pembayaran
									) AS total_pembayaran
								FROM
									tbt_pembayaran_po
								INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_pembayaran_po.id_po
								WHERE
									tbt_purchase_order.id = '".$idPo."'
								AND tbt_pembayaran_po.deleted = '0'
								AND tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.deleted = '0'
								GROUP BY
									tbt_purchase_order.id ";
					$arrttlByrPo90 = $this->queryAction($sqlBayar90,'S');
					$ttlByrPo90 += $arrttlByrPo90[0]['total_pembayaran'];
					
				}
				$sisaBayar90 = $ttlPo90 - $ttlByrPo90;
				$diff90 = $sisaBayar90;
				
				$sqlDiff120 = "SELECT
									tbt_purchase_order.id,
									tbt_purchase_order.dp,
									tbt_purchase_order.ppn
								FROM
									tbt_purchase_order
								WHERE
									tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.id_supplier = '".$idSupplier."'
								AND tbt_purchase_order.deleted = '0' 
								AND (DATEDIFF(
									tbt_purchase_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 90 AND 120  OR  DATEDIFF(
									tbt_purchase_order.tgl_jatuh_tempo,
									CURDATE()
								) > 120 )";
				$arrDiff120 = $this->queryAction($sqlDiff120,'S');
				$ttlPo120 = 0;
				$ttlByrPo120 = 0;
				foreach($arrDiff120 as $rowPo120)
				{
					$idPo = $rowPo120['id'];
					$ppn = $rowPo120['ppn'];
					
					$sqlTtlPO120 = "SELECT
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
					$arrTtlPO120 = $this->queryAction($sqlTtlPO120,'S');
					$ttlPo120 += $arrTtlPO90[0]['total_po'];
					
					$sqlBiaya120 = "SELECT
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
									
					$arrTtlBiaya120 = $this->queryAction($sqlBiaya120,'S');
					//$ttlPo += $arrTtlBiaya[0]['Total_Biaya'];
					
					$ppnCurrency = $ttlPo120 * ($rowPo120['ppn'] / 100);
					$ttlPo120 += $ppnCurrency + $arrTtlBiaya120[0]['Total_Biaya'];
					$ttlPo120 -= $rowPo90['dp'];
					
					$sqlBayar120 = "SELECT
									SUM(
										tbt_pembayaran_po.total_pembayaran
									) AS total_pembayaran
								FROM
									tbt_pembayaran_po
								INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_pembayaran_po.id_po
								WHERE
									tbt_purchase_order.id = '".$idPo."'
								AND tbt_pembayaran_po.deleted = '0'
								AND tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.deleted = '0'
								GROUP BY
									tbt_purchase_order.id ";
					$arrttlByrPo120 = $this->queryAction($sqlBayar120,'S');
					$ttlByrPo120 += $arrttlByrPo120[0]['total_pembayaran'];
					
				}
				$sisaBayar120 = $ttlPo120 - $ttlByrPo120;
				$diff120 = $sisaBayar120;
				
				
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
				
				$tblBody .= '<td>'.number_format($diff30,2,'.',',').'</td>';
				$tblBody .= '<td>'.number_format($diff60,2,'.',',').'</td>';
				$tblBody .= '<td>'.number_format($diff90,2,'.',',').'</td>';
				$tblBody .= '<td>'.number_format($diff120,2,'.',',').'</td>';
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
