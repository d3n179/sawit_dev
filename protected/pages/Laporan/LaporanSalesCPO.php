<?PHP
class LaporanSalesCPO extends MainConf
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
			$this->DDTahun->DataSource = $arrThn;
			$this->DDTahun->DataBind();
			$this->DDTahun->SelectedValue = date("Y");
			$this->DDBulan->SelectedValue = date("m");
			
			$this->periodeChanged();
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
		$periode = $this->Periode->SelectedValue;
		if($periode == '0')
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#panelHarian").hide();
					jQuery("#panelMingguan").hide();
					jQuery("#panelTahunan").show();
					jQuery("#panelBulanan").show();
					');
		}
		elseif($periode == '1')
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#panelHarian").hide();
					jQuery("#panelMingguan").hide();
					jQuery("#panelTahunan").show();
					jQuery("#panelBulanan").hide();
					');
		}
		elseif($periode == '2')
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#panelHarian").hide();
					jQuery("#panelMingguan").show();
					jQuery("#panelTahunan").hide();
					jQuery("#panelBulanan").hide();
					');
		}
		elseif($periode == '3')
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#panelHarian").show();
					jQuery("#panelMingguan").hide();
					jQuery("#panelTahunan").hide();
					jQuery("#panelBulanan").hide();
					');
		}
	}
	
	public function BindGrid()
	{
		$periode = $this->Periode->SelectedValue;
		
		$sqlTrans = "SELECT
						tbt_contract_sales.id,
						tbt_contract_sales.sales_no,
						tbt_contract_sales.no_do,
						tbt_contract_sales.commodity_type,
						tbt_contract_sales.id_pembeli,
						tbt_contract_sales.quantity,
						tbt_commodity_transaction.tgl_transaksi,
						tbt_commodity_transaction.no_kendaraan,
						tbt_commodity_transaction.bruto,
						tbt_commodity_transaction.tarra,
						tbt_commodity_transaction.netto_2,
						tbt_commodity_transaction.ffa,
						tbt_commodity_transaction.moist,
						tbt_commodity_transaction.dirt,
						tbt_penerimaan_penjualan.tgl_penerimaan,
						tbt_penerimaan_penjualan.bruto_diterima,
						tbt_penerimaan_penjualan.tarra_diterima,
						tbt_penerimaan_penjualan.netto_diterima,
						tbt_penerimaan_penjualan.ffa_diterima,
						tbt_penerimaan_penjualan.dobi_diterima,
						tbt_penerimaan_penjualan.mi_diterima,
						tbt_penerimaan_penjualan.jumlah_susut
					FROM
						tbt_contract_sales
					INNER JOIN tbt_commodity_transaction ON tbt_commodity_transaction.id_kontrak = tbt_contract_sales.id
					INNER JOIN tbt_penerimaan_penjualan ON tbt_penerimaan_penjualan.id_penjualan = tbt_commodity_transaction.id
					WHERE
						tbt_contract_sales.deleted = '0'
					AND tbt_commodity_transaction.deleted = '0'
					AND tbt_penerimaan_penjualan.deleted = '0' ";
						
		if($this->noKontrak->Text != '')
		{
			$sqlTrans .=" AND tbt_contract_sales.sales_no = '".$this->noKontrak->Text."' ";
		}
		
		if($this->nmPembeli->Text != '')
		{
			$sqlTrans .=" AND tbt_contract_sales.id_pembeli = '".$this->nmPembeli->Text."' ";
		}
		
		if($this->commodity_type->SelectedValue != '')
		{
			$sqlTrans .=" AND tbt_contract_sales.commodity_type = '".$this->commodity_type->SelectedValue."' ";
		}
		
		if($periode == '0')
		{
			$bulan = $this->DDBulan->SelectedValue;
			$tahun = $this->DDTahun->SelectedValue;
			if($bulan != '' && $tahun != '')
			{
				$sqlTrans .="AND MONTH(tbt_commodity_transaction.tgl_transaksi) = '$bulan' AND YEAR(tbt_commodity_transaction.tgl_transaksi) = '$tahun' ";
			}
		}
		elseif($periode == '1')
		{
			$tahun = $this->DDTahun->SelectedValue;
			if($tahun != '')
			{
				$sqlTrans .="AND YEAR(tbt_commodity_transaction.tgl_transaksi) = '$tahun' ";
			}
		}				
		elseif($periode == '2')
		{
			$mingguan = $this->mingguan->Text;
			if($mingguan != '')
			{
				$mingguan = explode("-",$mingguan);
				$tgl1 = trim(str_replace("/","-",$mingguan[0]));
				$tgl2 = trim(str_replace("/","-",$mingguan[1]));
				$tgl1 = explode("-",$tgl1);
				$tgl2 = explode("-",$tgl2);
				
				$tgl1 = $tgl1[1]."-".$tgl1[0]."-".$tgl1[2];
				$tgl2 = $tgl2[1]."-".$tgl2[0]."-".$tgl2[2];
				
				$tgl1 = $this->ConvertDate($tgl1,'2');
				$tgl2 = $this->ConvertDate($tgl2,'2');
				$sqlTrans .="AND tbt_commodity_transaction.tgl_transaksi BETWEEN '$tgl1' AND '$tgl2' ";
			}
		}	
		elseif($periode == '3')
		{
			$harian = $this->harian->Text;
			if($harian != '')
			{
				$tgl = $this->ConvertDate($harian,'2');
				$sqlTrans .="AND tbt_commodity_transaction.tgl_transaksi = '$tgl' ";
			}
		}	
		
		$this->setViewState('sql',$sqlTrans);	
		$sqlTrans .= " ORDER BY
						tbt_contract_sales.id , tbt_commodity_transaction.tgl_transaksi ASC";
		var_dump($sqlTrans);
		//$this->setViewState('sql',$sqlTrans);
		
		$arrTrans = $this->queryAction($sqlTrans,'S');
		$tblBody = '';
		if($arrTrans)
		{
			foreach($arrTrans as $row)
			{
				
				if($row['commodity_type'] == '0')
					$commodity_type = 'CPO - Crude Palm Oil';
				elseif($row['commodity_type'] == '1')
					$commodity_type = 'PK - Palm Kernel';
				elseif($row['commodity_type'] == '2')
					$commodity_type = 'FIBRE';
				elseif($row['commodity_type'] == '3')
					$commodity_type = 'CANGKANG';
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['sales_no'].'</td>';
				$tblBody .= '<td>'.$row['no_do'].'</td>';
				$tblBody .= '<td>'.$row['no_kendaraan'].'</td>';
				$tblBody .= '<td>'.$row['id_pembeli'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_transaksi'],'3').'</td>';
				$tblBody .= '<td>'.number_format($row['bruto'],2,'.',',').'</td>';		
				$tblBody .= '<td>'.number_format($row['tarra'],2,'.',',').'</td>';		
				$tblBody .= '<td>'.number_format($row['netto_2'],2,'.',',').'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_penerimaan'],'3').'</td>';		
				$tblBody .= '<td>'.number_format($row['bruto_diterima'],2,'.',',').'</td>';		
				$tblBody .= '<td>'.number_format($row['tarra_diterima'],2,'.',',').'</td>';		
				$tblBody .= '<td>'.number_format($row['netto_diterima'],2,'.',',').'</td>';
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = '';
		}
		
		return $tblBody;
	}
	
	public function cariBtnClicked($sender,$param)
	{
		
		$tblBody = $this->BindGrid();
		$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#table-1").dataTable().fnDestroy();
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					BindGrid();
					unloadContent();
					');
	}
	
	
	public function cetakLaporanTimbangan($sender,$param)
	{
		$session=new THttpSession;
		$session->open();
		$session['cetakLapSalesCPOSql'] = $this->getViewState('sql');

				
				$url = "index.php?page=Laporan.cetakLaporanSalesCPOPdf&periode=".$this->Periode->SelectedValue."&bln=".$this->DDBulan->SelectedValue."&thn=".$this->DDTahun->SelectedValue."&mingguan=".$this->mingguan->Text."&harian=".$this->harian->Text;
		
		$folderApp = explode("/",$_SERVER['REQUEST_URI']);
		$urlTemp="http://".$_SERVER['HTTP_HOST']."/".$folderApp[1]."/".$url;
		
		$this->getPage()->getClientScript()->registerEndScript
							('','
							var url = "'.$urlTemp.'";
							window.open(url, "_blank");
							unloadContent();');	
	}
	
}
?>
