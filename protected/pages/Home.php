<?PHP
class Home extends MainConf
{
	public function onLoadComplete($param)
	{
		parent::onLoadComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			//$this->cariBtnClicked($sender,$param);
			$tahun = date("Y");
			$arrThn[] = array("id"=>$tahun,'nama'=>$tahun);
			 
			$a = 20;
			$i = 1;
			while($i < $a)
			{
				$arrThn[] = array("id"=>$tahun-$i,'nama'=>$tahun-$i); 
				$i++;
			}
			$this->DDTahunPendapatan->DataSource = $arrThn;
			$this->DDTahunPendapatan->DataBind();
			$this->DDTahunPendapatan->SelectedValue = date('Y');
			
			$this->DDTahunPengeluaran->DataSource = $arrThn;
			$this->DDTahunPengeluaran->DataBind();
			$this->DDTahunPengeluaran->SelectedValue = date('Y');
			
			$this->DDTahunSupplier->DataSource = $arrThn;
			$this->DDTahunSupplier->DataBind();
			$this->DDTahunSupplier->SelectedValue = date('Y');
			
			$this->DDTahunSupplierBuah->DataSource = $arrThn;
			$this->DDTahunSupplierBuah->DataBind();
			$this->DDTahunSupplierBuah->SelectedValue = date('Y');
			
			$sql = "SELECT tbm_pemasok.id,tbm_pemasok.nama FROM tbm_pemasok WHERE tbm_pemasok.deleted ='0' ";
			$arrPemasok = $this->queryAction($sql,'S');
			$this->DDSupplier->DataSource = $arrPemasok;
			$this->DDSupplier->DataBind();
			$this->DDSupplier->SelectedIndex = 0;
			
			$this->DDSupplierBuah->DataSource = $arrPemasok;
			$this->DDSupplierBuah->DataBind();
			$this->DDSupplierBuah->SelectedIndex = 0;
			
			$arrPendapatan = $this->RenderPendapatanChart();
			$arrPengeluaran = $this->RenderPengeluaranChart();
			$arrPembelian = $this->RenderPembelianChart();
			$arrBuah = $this->RenderBuahChart();	
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					renderPendapatan('.$arrPendapatan .');
					renderPengeluaran('.$arrPengeluaran .');
					renderPembelian('.$arrPembelian .');
					renderBuah('.$arrBuah.');
					');
			
			$PerusahaanRecord = PerusahaanRecord::finder()->findByPk(1);
			
			if(strtolower($this->User->IsUser) == strtolower($PerusahaanRecord->username_pemilik))
				$this->GrafikAdmin->Visible = true;
			else
				$this->GrafikAdmin->Visible = false;
		}
	}
	
	public function getRenderPendapatanChart()
	{
		$arr = $this->RenderPendapatanChart();
		$this->getPage()->getClientScript()->registerEndScript
					('','
					renderPendapatan('.$arr .');
					');
	}
	
	public function RenderPendapatanChart()
	{
		$i = 1;
		$tahunPendapatan = $this->DDTahunPendapatan->SelectedValue;
		$dataList = array();
		while($i <= 12)
		{
			$sql = "SELECT
						SUM(
							tbt_penerimaan_penjualan_detail.total_pembayaran
						) AS total_penerimaan
					FROM
						tbt_penerimaan_penjualan_detail
					WHERE
						MONTH (
							tbt_penerimaan_penjualan_detail.tgl_pembayaran
						) = '$i'
					AND YEAR (
						tbt_penerimaan_penjualan_detail.tgl_pembayaran
					) = '$tahunPendapatan'
					AND tbt_penerimaan_penjualan_detail.deleted = '0' ";
			$sqlPendapatan = $this->queryAction($sql,'S');
			
			$sql = "SELECT
						SUM(
							tbt_revenue_transaction.total_revenue
						) AS total_revenue
					FROM
						tbt_revenue_transaction
					WHERE
						MONTH (
							tbt_revenue_transaction.tgl_transaksi
						) = '$i'
					AND YEAR (
						tbt_revenue_transaction.tgl_transaksi
					) = '$tahunPendapatan'
					AND tbt_revenue_transaction.deleted = '0'";
			$sqlRevenue = $this->queryAction($sql,'S');
			
			$totalPendapatan = $sqlPendapatan[0]['total_penerimaan'] + $sqlRevenue[0]['total_revenue'];
			array_push($dataList,intval($totalPendapatan));
			$i++;
		}
		$arr = array();
		$arr[] = array("name"=>"Pendapatan","data"=>$dataList);
		$arrJson = json_encode($arr);
		
		return $arrJson;
	}
	
	public function getRenderPengeluaranChart()
	{
		$arr = $this->RenderPengeluaranChart();
		$this->getPage()->getClientScript()->registerEndScript
					('','
					renderPengeluaran('.$arr .');
					');
	}
	
	public function RenderPengeluaranChart()
	{
		$i = 1;
		$tahunPengeluaran = $this->DDTahunPengeluaran->SelectedValue;
		$dataList = array();
		while($i <= 12)
		{
			$sql = "SELECT
						SUM(
							tbt_expense_transaction.total_expense
						) AS total_expense
					FROM
						tbt_expense_transaction
					WHERE
						MONTH (
							tbt_expense_transaction.tgl_transaksi
						) = '$i'
					AND YEAR (
						tbt_expense_transaction.tgl_transaksi
					) = '$tahunPengeluaran'
					AND tbt_expense_transaction.deleted = '0' ";
			$sqlExpense = $this->queryAction($sql,'S');
			
			$sql = "SELECT
						SUM(
							tbt_pembayaran_po.total_pembayaran
						) AS total_pembayaran
					FROM
						tbt_pembayaran_po
					WHERE
						MONTH (
							tbt_pembayaran_po.tgl_pembayaran
						) = '$i'
					AND YEAR (
						tbt_pembayaran_po.tgl_pembayaran
					) = '$tahunPengeluaran'
					AND tbt_pembayaran_po.deleted = '0'";
			$sqlBayarPo = $this->queryAction($sql,'S');
			
			$sql = "SELECT
						SUM(
							tbt_pembayaran_tbs.jumlah_pembayaran
						) AS total_tbs_order
					FROM
						tbt_pembayaran_tbs
					WHERE
						MONTH (
							tbt_pembayaran_tbs.tgl_pembayaran
						) = '$i'
					AND YEAR (
						tbt_pembayaran_tbs.tgl_pembayaran
					) = '$tahunPengeluaran'
					AND tbt_pembayaran_tbs.deleted = '0'";
			$sqlTbsOrder = $this->queryAction($sql,'S');
			
			
			$totalPengeluaran = $sqlExpense[0]['total_expense'] + $sqlBayarPo[0]['total_pembayaran'] + $sqlTbsOrder[0]['total_tbs_order'];
			array_push($dataList,intval($totalPengeluaran));
			$i++;
		}
		$arr = array();
		$arr[] = array("name"=>"Pengeluaran","data"=>$dataList);
		$arrJson = json_encode($arr);
		
		return $arrJson;
	}
		
	public function getRenderPembelianChart()
	{
		$arr = $this->RenderPembelianChart();
		$this->getPage()->getClientScript()->registerEndScript
					('','
					renderPembelian('.$arr .');
					');
	}
	
	public function RenderPembelianChart()
	{
		$i = 1;
		$tahunPembelian = $this->DDTahunSupplier->SelectedValue;
		$idPemasok = $this->DDSupplier->SelectedValue;
		$dataList = array();
		while($i <= 12)
		{
			$sql = "SELECT
						SUM(
							tbt_purchase_order_detail.subtotal
						) AS subtotal
					FROM
						tbt_purchase_order_detail
					INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_purchase_order_detail.id_po
					WHERE
						tbt_purchase_order.deleted = '0'
					AND tbt_purchase_order_detail.deleted = '0'
					AND tbt_purchase_order.id_supplier = '$idPemasok'
					AND MONTH (tbt_purchase_order.tgl_po) = '$i'
					AND YEAR (tbt_purchase_order.tgl_po) = '$tahunPembelian' ";
			$sqlPO = $this->queryAction($sql,'S');
			
			$sql = "SELECT
						SUM(
							tbt_purchase_order_biaya_lain.biaya
						) AS biaya
					FROM
						tbt_purchase_order_biaya_lain
					INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_purchase_order_biaya_lain.id_po
					WHERE
						tbt_purchase_order.deleted = '0'
					AND tbt_purchase_order_biaya_lain.deleted = '0'
					AND tbt_purchase_order.id_supplier = '$idPemasok'
					AND MONTH (tbt_purchase_order.tgl_po) = '$i'
					AND YEAR (tbt_purchase_order.tgl_po) = '$tahunPembelian'  ";
			$sqlBiayaPO = $this->queryAction($sql,'S');
			
			$sql = "SELECT
						SUM(
							tbt_pembayaran_tbs_detail.total_tbs_order
						) AS total_tbs_order
					FROM
						tbt_pembayaran_tbs_detail
					INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_pembayaran_tbs_detail.id_tbs_order
					WHERE
						tbt_tbs_order.deleted = '0'
					AND tbt_pembayaran_tbs_detail.deleted = '0'
					AND tbt_tbs_order.id_pemasok = '$idPemasok'
					AND MONTH (tbt_tbs_order.tgl_transaksi) = '$i'
					AND YEAR (tbt_tbs_order.tgl_transaksi) = '$tahunPembelian'";
			$sqlTbsOrder = $this->queryAction($sql,'S');
			
			
			$totalPembelian = $sqlPO[0]['subtotal'] + $sqlBiayaPO[0]['biaya'] + $sqlTbsOrder[0]['total_tbs_order'];
			array_push($dataList,intval($totalPembelian));
			$i++;
		}
		$arr = array();
		$arr[] = array("name"=>"Pembelian","data"=>$dataList);
		$arrJson = json_encode($arr);
		
		return $arrJson;
	}	
	
	
	public function getRenderPieChartBuah()
	{
		$arr = $this->RenderBuahChart();
		$this->getPage()->getClientScript()->registerEndScript
					('','
					renderBuah('.$arr .');
					');
	}
	
	
	public function RenderBuahChart()
	{
		$i = 1;
		$tahun = $this->DDTahunSupplierBuah->SelectedValue;
		$idPemasok = $this->DDSupplierBuah->SelectedValue;
		$dataList = array();
		
		
		$sql = "SELECT
					tbm_barang.nama,
					SUM(tbt_tbs_order_detail.netto_2) AS jml_masuk,
					tbm_setting_komidel.nama AS kategori_tbs
				FROM
					tbt_tbs_order
				INNER JOIN tbt_tbs_order_detail ON tbt_tbs_order_detail.id_tbs_order = tbt_tbs_order.id
				INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_tbs_order.id_barang
				INNER JOIN tbm_setting_komidel ON tbm_setting_komidel.id = tbt_tbs_order_detail.id_komidel
				WHERE
					tbt_tbs_order.deleted = '0' ";
					
		if($idPemasok != '')
		{
			$sql .=  " AND tbt_tbs_order.id_pemasok = ".$idPemasok." ";
		}
		
		if($tahun != '')
		{
			$sql .=  " AND YEAR(tbt_tbs_order.tgl_transaksi) = ".$tahun." ";
		}
		else
		{
			$sql .=  " AND tbt_tbs_order.tgl_transaksi = CURDATE() ";
		}
		
		$sql .=  " GROUP BY
					tbm_barang.id
				ORDER BY
					tbt_tbs_order.id ASC ";
		
		//var_dump($sql);
		$Record = $this->queryAction($sql,'S');
		foreach($Record as $row)
		{
			$dataList[] = array("name"=>$row['nama'],"y"=>floatval($row['jml_masuk'])); 
		}
		$arr[] = array("name"=>"Buah","colorByPoint"=>true,"data"=>$dataList);
		$arrJson = json_encode($dataList);
		
		return $arrJson;
	}
}
?>
