<?PHP
class LaporanTimbanganCPO extends MainConf
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
						tbt_commodity_transaction.transaction_no,
						tbt_commodity_transaction.jns_kontrak,
						tbt_contract_sales.sales_no,
						tbt_commodity_transaction.no_do AS no_do_manual,
						tbt_contract_sales.no_do,
						tbt_commodity_transaction.tgl_do,
						tbt_commodity_transaction.commodity_type,
						tbt_commodity_transaction.no_kendaraan,
						tbt_commodity_transaction.nama_supir,
						tbt_commodity_transaction.pembeli,
						tbt_commodity_transaction.bruto,
						tbt_commodity_transaction.tarra,
						tbt_commodity_transaction.potongan,
						tbt_commodity_transaction.netto_2
					FROM
						tbt_commodity_transaction
						LEFT JOIN tbt_contract_sales ON tbt_contract_sales.id = tbt_commodity_transaction.id_kontrak
					WHERE
						tbt_commodity_transaction.deleted = '0' ";
						
		if($this->noKontrak->Text != '')
		{
			$sqlTrans .=" AND tbt_contract_sales.sales_no = '".$this->noKontrak->Text."' ";
		}
		
		if($this->noDO->Text != '')
		{
			$sqlTrans .=" AND (tbt_commodity_transaction.no_do = '".$this->noDO->Text."' OR tbt_contract_sales.no_do = '".$this->noDO->Text."') ";
		}
		if($this->nmPembeli->Text != '')
		{
			$sqlTrans .=" AND tbt_commodity_transaction.pembeli = '".$this->nmPembeli->Text."' ";
		}
		
		if($this->commodity_type->SelectedValue != '')
		{
			$sqlTrans .=" AND tbt_commodity_transaction.commodity_type = '".$this->commodity_type->SelectedValue."' ";
		}
		
		if($periode == '0')
		{
			$bulan = $this->DDBulan->SelectedValue;
			$tahun = $this->DDTahun->SelectedValue;
			if($bulan != '' && $tahun != '')
			{
				$sqlTrans .="AND MONTH(tbt_commodity_transaction.tgl_do) = '$bulan' AND YEAR(tbt_commodity_transaction.tgl_do) = '$tahun' ";
			}
		}
		elseif($periode == '1')
		{
			$tahun = $this->DDTahun->SelectedValue;
			if($tahun != '')
			{
				$sqlTrans .="AND YEAR(tbt_commodity_transaction.tgl_do) = '$tahun' ";
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
				$sqlTrans .="AND tbt_commodity_transaction.tgl_do BETWEEN '$tgl1' AND '$tgl2' ";
			}
		}	
		elseif($periode == '3')
		{
			$harian = $this->harian->Text;
			if($harian != '')
			{
				$tgl = $this->ConvertDate($harian,'2');
				$sqlTrans .="AND tbt_commodity_transaction.tgl_do = '$tgl' ";
			}
		}		
		printf($sqlTrans);
		$this->setViewState('sql',$sqlTrans);
		
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
				
				if($row['jns_kontrak'] == '0')
					$tblBody .= '<td>'.$row['no_do_manual'].'</td>';
				else
					$tblBody .= '<td>'.$row['no_do'].'</td>';
					
				$tblBody .= '<td>'.$row['sales_no'].'</td>';
				$tblBody .= '<td>'.$row['no_kendaraan'].'</td>';
				$tblBody .= '<td>'.$row['nama_supir'].'</td>';
				$tblBody .= '<td>'.$commodity_type.'</td>';		
				$tblBody .= '<td>'.$row['pembeli'].'</td>';
				$tblBody .= '<td>'.number_format($row['bruto'],2,'.',',').'</td>';		
				$tblBody .= '<td>'.number_format($row['tarra'],2,'.',',').'</td>';
				$tblBody .= '<td>'.number_format($row['potongan'],2,'.',',').'</td>';
				$tblBody .= '<td>'.number_format($row['netto_2'],2,'.',',').'</td>';	
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
		$session['cetakLapharianTimbanganCpoSql'] = $this->getViewState('sql');
		
		$url = "index.php?page=Laporan.cetakLaporanHarianTimbanganCPOPdf&periode=".$this->Periode->SelectedValue."&bln=".$this->DDBulan->SelectedValue."&thn=".$this->DDTahun->SelectedValue."&mingguan=".$this->mingguan->Text."&harian=".$this->harian->Text;
		
		$folderApp = explode("/",$_SERVER['REQUEST_URI']);
		$urlTemp="http://".$_SERVER['HTTP_HOST']."/".$folderApp[1]."/".$url;
		
		$this->getPage()->getClientScript()->registerEndScript
							('','
							var url = "'.$urlTemp.'";
							window.open(url, "_blank");
							unloadContent();');	
							
		/*$this->Response->redirect($this->Service->constructUrl('Laporan.cetakLaporanHarianTimbanganCPOPdf',
			array(
				'periode'=>$this->Periode->SelectedValue,
				'bln'=>$this->DDBulan->SelectedValue,
				'thn'=>$this->DDTahun->SelectedValue,
				'mingguan'=>$this->mingguan->Text,
				'harian'=>$this->harian->Text)));*/
	}
	
}
?>
