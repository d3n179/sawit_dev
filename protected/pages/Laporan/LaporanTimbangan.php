<?PHP
class LaporanTimbangan extends MainConf
{

	public function onLoadComplete($param)
	{
		parent::onLoadComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$sql = "SELECT
						tbm_setting_komidel.id,
						tbm_setting_komidel.nama
					FROM
						tbm_setting_komidel
					WHERE
						tbm_setting_komidel.deleted = '0' ";
			$arr = $this->queryAction($sql,'S');
			$this->DDTbs->DataSource = $arr;
			$this->DDTbs->DataBind();
			
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
						tbt_tbs_order.no_tbs_order,
						tbt_tbs_order.tgl_transaksi,
						tbm_pemasok.no_sp,
						tbt_tbs_order_detail.no_polisi,
						tbm_barang.nama AS barang,
						tbm_pemasok.nama AS pemasok,
						tbt_tbs_order_detail.bruto,
						tbt_tbs_order_detail.tarra,
						tbt_tbs_order_detail.netto_1,
						tbt_tbs_order_detail.potongan,
						tbt_tbs_order_detail.hasil_potongan,
						tbt_tbs_order_detail.netto_2,
						tbt_tbs_order_detail.jml_tandan,
						tbt_tbs_order_detail.komidel,
						tbm_setting_komidel.nama AS kategori_tbs
					FROM
						tbt_tbs_order
					INNER JOIN tbt_tbs_order_detail ON tbt_tbs_order_detail.id_tbs_order = tbt_tbs_order.id
					INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
					INNER JOIN tbm_barang ON tbm_barang.id = tbt_tbs_order.id_barang
					INNER JOIN tbm_setting_komidel ON tbm_setting_komidel.id = tbt_tbs_order_detail.id_komidel
					WHERE
						tbt_tbs_order.deleted = '0' 
						AND tbt_tbs_order_detail.deleted = '0' ";
						
		if($this->noSp->Text != '')
		{
			$sqlTrans .=" AND tbm_pemasok.no_sp = '".$this->noSp->Text."' ";
		}
		
		if($this->nmPemasok->Text != '')
		{
			$sqlTrans .=" AND tbm_pemasok.nama = '".$this->nmPemasok->Text."' ";
		}
		
		if($this->nmBarang->Text != '')
		{
			$sqlTrans .=" AND tbm_barang.nama = '".$this->nmBarang->Text."' ";
		}
		
		if($this->komidelTbs->Text != '')
		{
			$sqlTrans .=" AND tbt_tbs_order_detail.komidel = '".$this->komidelTbs->Text."' ";
		}
		
		if($this->DDTbs->SelectedValue != '')
		{
			$sqlTrans .=" AND tbm_setting_komidel.id = '".$this->DDTbs->SelectedValue."' ";
		}
		
		if($periode == '0')
		{
			$bulan = $this->DDBulan->SelectedValue;
			$tahun = $this->DDTahun->SelectedValue;
			if($bulan != '' && $tahun != '')
			{
				$sqlTrans .="AND MONTH(tbt_tbs_order.tgl_transaksi) = '$bulan' AND YEAR(tbt_tbs_order.tgl_transaksi) = '$tahun' ";
			}
		}
		elseif($periode == '1')
		{
			$tahun = $this->DDTahun->SelectedValue;
			if($tahun != '')
			{
				$sqlTrans .="AND YEAR(tbt_tbs_order.tgl_transaksi) = '$tahun' ";
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
				$sqlTrans .="AND tbt_tbs_order.tgl_transaksi BETWEEN '$tgl1' AND '$tgl2' ";
			}
		}	
		elseif($periode == '3')
		{
			$harian = $this->harian->Text;
			if($harian != '')
			{
				$tgl = $this->ConvertDate($harian,'2');
				$sqlTrans .="AND tbt_tbs_order.tgl_transaksi = '$tgl' ";
			}
		}		
		var_dump($sqlTrans);
		$this->setViewState('sql',$sqlTrans);
		
		$arrTrans = $this->queryAction($sqlTrans,'S');
		$tblBody = '';
		if($arrTrans)
		{
			foreach($arrTrans as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['no_tbs_order'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_transaksi'],'3').'</td>';
				$tblBody .= '<td>'.$row['no_sp'].'</td>';
				$tblBody .= '<td>'.$row['no_polisi'].'</td>';		
				$tblBody .= '<td>'.$row['barang'].'</td>';		
				$tblBody .= '<td>'.$row['pemasok'].'</td>';		
				$tblBody .= '<td>'.$row['bruto'].'</td>';	
				$tblBody .= '<td>'.$row['tarra'].'</td>';	
				$tblBody .= '<td>'.$row['netto_1'].'</td>';		
				$tblBody .= '<td>'.$row['potongan'].'</td>';	
				$tblBody .= '<td>'.$row['hasil_potongan'].'</td>';	
				$tblBody .= '<td>'.$row['netto_2'].'</td>';		
				$tblBody .= '<td>'.$row['jml_tandan'].'</td>';	
				$tblBody .= '<td>'.$row['komidel'].'</td>';		
				$tblBody .= '<td>'.$row['kategori_tbs'].'</td>';		
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
		$session['cetakLapTimbanganSql'] = $this->getViewState('sql');
		
		$this->Response->redirect($this->Service->constructUrl('Laporan.cetakLaporanTimbanganPdf',
			array(
				'periode'=>$this->Periode->SelectedValue,
				'bln'=>$this->DDBulan->SelectedValue,
				'thn'=>$this->DDTahun->SelectedValue,
				'mingguan'=>$this->mingguan->Text,
				'harian'=>$this->harian->Text)));
	}
	
}
?>
