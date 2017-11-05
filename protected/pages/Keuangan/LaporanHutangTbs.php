<?PHP
class LaporanHutangTbs extends MainConf
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
						tbt_tbs_order.id_pemasok,
						tbm_pemasok.nama AS pemasok,
						COUNT(tbt_tbs_order.id) AS jml_order
					FROM
						tbt_tbs_order
					INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
					WHERE
						tbt_tbs_order.`status` = '1' 
						AND tbt_tbs_order.deleted = '0' ";
		
		
		if($this->DDSupplier->SelectedValue != '')
			$sqlTrans .= " AND tbt_tbs_order.id_pemasok = '".$this->DDSupplier->SelectedValue."' ";
		
		$sqlTrans .= " GROUP BY
							tbt_tbs_order.id_pemasok
						ORDER BY
							tbt_tbs_order.id_pemasok ASC ";
			
		$this->setViewState('sql',$sqlTrans);
		$arrTrans = $this->queryAction($sqlTrans,'S');
		$tblBody = '';
		if($arrTrans)
		{
			foreach($arrTrans as $row)
			{
				$ttlTbsOrder = 0;
				$idPemasok = $row['id_pemasok'];
				$sqlOrder ="SELECT
						tbt_tbs_order.id
					FROM
						tbt_tbs_order
					WHERE
						tbt_tbs_order.`status` = '1' 
						AND tbt_tbs_order.id_pemasok = '".$idPemasok."' 
						AND tbt_tbs_order.deleted ='0' ";
				$arrOrder = $this->queryAction($sqlOrder,'S');
				foreach($arrOrder as $rowOrder)
				{
					$idTbsOrder = $rowOrder['id'];
					
					$sqlTtlOrder = "SELECT
									SUM(
										tbt_tbs_order_detail.total_tbs_order
									) AS total_tbs_order
								FROM
									tbt_tbs_order_detail
								INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_tbs_order_detail.id_tbs_order
								WHERE
									tbt_tbs_order.id = '".$idTbsOrder."'
									AND tbt_tbs_order.deleted = '0' 
									AND tbt_tbs_order_detail.deleted = '0' 
								GROUP BY
									tbt_tbs_order.id ";
					$arrTtlOrder = $this->queryAction($sqlTtlOrder,'S');
					$ttlTbsOrder += $arrTtlOrder[0]['total_tbs_order'];
					
				}
				
				$sqlBayar = "SELECT
								SUM(
									tbt_pembayaran_tbs.jumlah_pembayaran
								) AS total_pembayaran
							FROM
								tbt_pembayaran_tbs
							INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_pembayaran_tbs.id_tbs_order
							WHERE
								tbt_tbs_order.id_pemasok = '".$idPemasok."'
							AND tbt_pembayaran_tbs.deleted = '0'
							AND tbt_tbs_order.`status` = '1'
							AND tbt_tbs_order.deleted = '0'
							GROUP BY
								tbt_tbs_order.id ";
				$arrttlByrOrder = $this->queryAction($sqlBayar,'S');
				$ttlByrOrder = $arrttlByrOrder[0]['total_pembayaran'];
				$sisaBayar = $ttlTbsOrder - $ttlByrOrder;
				
				$sqlOrder30 ="SELECT
								tbt_tbs_order.id
							FROM
								tbt_tbs_order
							WHERE
								tbt_tbs_order.`status` = '1' 
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."' 
								AND tbt_tbs_order.deleted ='0' 
								AND DATEDIFF(
											tbt_tbs_order.tgl_jatuh_tempo,
											CURDATE()
										) <= 30 ";
				$arrOrder30 = $this->queryAction($sqlOrder30,'S');
				$ttlTbsOrder30 = 0;
				$ttlByrOrder30 = 0;
				foreach($arrOrder30 as $rowOrder30)
				{
					$idTbsOrder = $rowOrder30['id'];
					
					$sqlTtlOrder30 = "SELECT
									SUM(
										tbt_tbs_order_detail.total_tbs_order
									) AS total_tbs_order
								FROM
									tbt_tbs_order_detail
								INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_tbs_order_detail.id_tbs_order
								WHERE
									tbt_tbs_order.id = '".$idTbsOrder."'
									AND tbt_tbs_order.deleted = '0' 
									AND tbt_tbs_order_detail.deleted = '0' 
								GROUP BY
									tbt_tbs_order.id ";
					$arrTtlOrder30 = $this->queryAction($sqlTtlOrder30,'S');
					$ttlTbsOrder30 += $arrTtlOrder30[0]['total_tbs_order'];
					
					$sqlBayar30 = "SELECT
									SUM(
										tbt_pembayaran_tbs.jumlah_pembayaran
									) AS total_pembayaran
								FROM
									tbt_pembayaran_tbs
								INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_pembayaran_tbs.id_tbs_order
								WHERE
									tbt_tbs_order.id_pemasok = '".$idPemasok."'
								AND tbt_pembayaran_tbs.deleted = '0'
								AND tbt_tbs_order.`status` = '1'
								AND tbt_tbs_order.deleted = '0'
								GROUP BY
									tbt_tbs_order.id ";
					$arrttlByrOrder30 = $this->queryAction($sqlBayar30,'S');
					$ttlByrOrder30 += $arrttlByrOrder30[0]['total_pembayaran'];
				}
				$diff30 = $ttlTbsOrder30 - $ttlByrOrder30;
				
				
				$sqlOrder60 ="SELECT
								tbt_tbs_order.id
							FROM
								tbt_tbs_order
							WHERE
								tbt_tbs_order.`status` = '1' 
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."' 
								AND tbt_tbs_order.deleted ='0' 
								AND DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 30 AND 60 ";
				$arrOrder60 = $this->queryAction($sqlOrder60,'S');
				$ttlTbsOrder60 = 0;
				$ttlByrOrder60 = 0;
				foreach($arrOrder60 as $rowOrder60)
				{
					$idTbsOrder = $rowOrder60['id'];
					
					$sqlTtlOrder60 = "SELECT
									SUM(
										tbt_tbs_order_detail.total_tbs_order
									) AS total_tbs_order
								FROM
									tbt_tbs_order_detail
								INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_tbs_order_detail.id_tbs_order
								WHERE
									tbt_tbs_order.id = '".$idTbsOrder."'
									AND tbt_tbs_order.deleted = '0' 
									AND tbt_tbs_order_detail.deleted = '0' 
								GROUP BY
									tbt_tbs_order.id ";
					$arrTtlOrder60 = $this->queryAction($sqlTtlOrder60,'S');
					$ttlTbsOrder60 += $arrTtlOrder60[0]['total_tbs_order'];
					
					$sqlBayar60 = "SELECT
									SUM(
										tbt_pembayaran_tbs.jumlah_pembayaran
									) AS total_pembayaran
								FROM
									tbt_pembayaran_tbs
								INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_pembayaran_tbs.id_tbs_order
								WHERE
									tbt_tbs_order.id_pemasok = '".$idPemasok."'
								AND tbt_pembayaran_tbs.deleted = '0'
								AND tbt_tbs_order.`status` = '1'
								AND tbt_tbs_order.deleted = '0'
								GROUP BY
									tbt_tbs_order.id ";
					$arrttlByrOrder60 = $this->queryAction($sqlBayar60,'S');
					$ttlByrOrder60 += $arrttlByrOrder60[0]['total_pembayaran'];
				}
				$diff60 = $ttlTbsOrder60 - $ttlByrOrder60;
				
				$sqlOrder90 ="SELECT
								tbt_tbs_order.id
							FROM
								tbt_tbs_order
							WHERE
								tbt_tbs_order.`status` = '1' 
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."' 
								AND tbt_tbs_order.deleted ='0' 
								AND DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 60 AND 90 ";
				$arrOrder90 = $this->queryAction($sqlOrder90,'S');
				$ttlTbsOrder90 = 0;
				$ttlByrOrder90 = 0;
				foreach($arrOrder90 as $rowOrder90)
				{
					$idTbsOrder = $rowOrder90['id'];
					
					$sqlTtlOrder90 = "SELECT
									SUM(
										tbt_tbs_order_detail.total_tbs_order
									) AS total_tbs_order
								FROM
									tbt_tbs_order_detail
								INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_tbs_order_detail.id_tbs_order
								WHERE
									tbt_tbs_order.id = '".$idTbsOrder."'
									AND tbt_tbs_order.deleted = '0' 
									AND tbt_tbs_order_detail.deleted = '0' 
								GROUP BY
									tbt_tbs_order.id ";
					$arrTtlOrder90 = $this->queryAction($sqlTtlOrder90,'S');
					$ttlTbsOrder90 += $arrTtlOrder90[0]['total_tbs_order'];
					
					$sqlBayar90 = "SELECT
									SUM(
										tbt_pembayaran_tbs.jumlah_pembayaran
									) AS total_pembayaran
								FROM
									tbt_pembayaran_tbs
								INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_pembayaran_tbs.id_tbs_order
								WHERE
									tbt_tbs_order.id_pemasok = '".$idPemasok."'
								AND tbt_pembayaran_tbs.deleted = '0'
								AND tbt_tbs_order.`status` = '1'
								AND tbt_tbs_order.deleted = '0'
								GROUP BY
									tbt_tbs_order.id ";
					$arrttlByrOrder90 = $this->queryAction($sqlBayar90,'S');
					$ttlByrOrder90 += $arrttlByrOrder90[0]['total_pembayaran'];
				}
				$diff90 = $ttlTbsOrder90 - $ttlByrOrder90;
				
				$sqlOrder120 ="SELECT
								tbt_tbs_order.id
							FROM
								tbt_tbs_order
							WHERE
								tbt_tbs_order.`status` = '1' 
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."' 
								AND tbt_tbs_order.deleted ='0' 
								AND (DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 90 AND 120  OR  DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) > 120 )";
				$arrOrder120 = $this->queryAction($sqlOrder120,'S');
				$ttlTbsOrder120 = 0;
				$ttlByrOrder120 = 0;
				foreach($arrOrder120 as $rowOrder120)
				{
					$idTbsOrder = $rowOrder120['id'];
					
					$sqlTtlOrder120 = "SELECT
									SUM(
										tbt_tbs_order_detail.total_tbs_order
									) AS total_tbs_order
								FROM
									tbt_tbs_order_detail
								INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_tbs_order_detail.id_tbs_order
								WHERE
									tbt_tbs_order.id = '".$idTbsOrder."'
									AND tbt_tbs_order.deleted = '0' 
									AND tbt_tbs_order_detail.deleted = '0' 
								GROUP BY
									tbt_tbs_order.id ";
					$arrTtlOrder120 = $this->queryAction($sqlTtlOrder120,'S');
					$ttlTbsOrder120 += $arrTtlOrder120[0]['total_tbs_order'];
					
					$sqlBayar120 = "SELECT
									SUM(
										tbt_pembayaran_tbs.jumlah_pembayaran
									) AS total_pembayaran
								FROM
									tbt_pembayaran_tbs
								INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_pembayaran_tbs.id_tbs_order
								WHERE
									tbt_tbs_order.id_pemasok = '".$idPemasok."'
								AND tbt_pembayaran_tbs.deleted = '0'
								AND tbt_tbs_order.`status` = '1'
								AND tbt_tbs_order.deleted = '0'
								GROUP BY
									tbt_tbs_order.id ";
					$arrttlByrOrder120 = $this->queryAction($sqlBayar120,'S');
					$ttlByrOrder120 += $arrttlByrOrder120[0]['total_pembayaran'];
				}
				$diff120 = $ttlTbsOrder120 - $ttlByrOrder120;
				
				
				/*$years = floor($diff / (365*60*60*24));
				$months = floor(($diff - $years * 365*60*60*24) / (30*60*60*24));
				$days = floor(($diff - $years * 365*60*60*24 - $months*30*60*60*24)/ (60*60*24));*/
					
				//var_dump($arrTot[0]['total_item']);
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['pemasok'].'</td>';
				$tblBody .= '<td>'.$row['jml_order'].'</td>';
				$tblBody .= '<td>'.number_format($ttlTbsOrder,2,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($ttlByrOrder,2,'.',',').'</td>';	
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
			$session['cetakLapUmurHutangTbsSql'] = $this->getViewState('sql');
		
			$this->Response->redirect($this->Service->constructUrl('Keuangan.cetakLapUmurHutangTbsPdf'));
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
