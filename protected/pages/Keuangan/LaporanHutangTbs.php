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
				
				
				$sqlDiff30 = "SELECT
									COUNT(tbt_tbs_order.id) AS umur
								FROM
									tbt_tbs_order
								WHERE
									tbt_tbs_order.`status` = '1'
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."'
								AND DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) <= 30 ";
				$arrDiff30 = $this->queryAction($sqlDiff30,'S');
				$diff30 = $arrDiff30[0]['umur'];
				
				$sqlDiff60 = "SELECT
									COUNT(tbt_tbs_order.id) AS umur
								FROM
									tbt_tbs_order
								WHERE
									tbt_tbs_order.`status` = '1'
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."'
								AND DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 30 AND 60 ";
				$arrDiff60 = $this->queryAction($sqlDiff60,'S');
				$diff60 = $arrDiff60[0]['umur'];
				
				$sqlDiff90 = "SELECT
									COUNT(tbt_tbs_order.id) AS umur
								FROM
									tbt_tbs_order
								WHERE
									tbt_tbs_order.`status` = '1'
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."'
								AND DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 60 AND 90 ";
				$arrDiff90 = $this->queryAction($sqlDiff90,'S');
				$diff90 = $arrDiff90[0]['umur'];
				
				$sqlDiff120 = "SELECT
									COUNT(tbt_tbs_order.id) AS umur
								FROM
									tbt_tbs_order
								WHERE
									tbt_tbs_order.`status` = '1'
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."'
								AND (DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 90 AND 120  OR  DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
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
				$tblBody .= '<td>'.$row['jml_order'].'</td>';
				$tblBody .= '<td>'.number_format($ttlTbsOrder,2,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($ttlByrOrder,2,'.',',').'</td>';	
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
