<?PHP
class LaporanPembayaranTbs extends MainConf
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
					jQuery("#panelMingguan").hide();
					jQuery("#panelTahunan").show();
					jQuery("#panelBulanan").show();
					');
		}
		elseif($periode == '1')
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#panelMingguan").hide();
					jQuery("#panelTahunan").show();
					jQuery("#panelBulanan").hide();
					');
		}
		elseif($periode == '2')
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#panelMingguan").show();
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
						tbm_kendaraan_pemasok.no_polisi,
						tbm_barang.nama AS barang,
						tbm_pemasok.nama AS pemasok,
						tbt_tbs_order.bruto,
						tbt_tbs_order.tarra,
						tbt_tbs_order.netto_1,
						tbt_tbs_order.potongan,
						tbt_tbs_order.hasil_potongan,
						tbt_tbs_order.netto_2,
						tbt_tbs_order.jml_tandan,
						tbt_tbs_order.komidel,
						tbm_setting_komidel.nama AS kategori_tbs
					FROM
						tbt_tbs_order
					INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
					INNER JOIN tbm_kendaraan_pemasok ON tbm_kendaraan_pemasok.id = tbt_tbs_order.id_kendaraan
					INNER JOIN tbm_barang ON tbm_barang.id = tbt_tbs_order.id_barang
					INNER JOIN tbm_setting_komidel ON tbm_setting_komidel.id = tbt_tbs_order.id_komidel
					WHERE
						tbt_tbs_order.deleted = '0' ";
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
		$this->Response->redirect($this->Service->constructUrl('Laporan.cetakLaporanTimbanganXls',
			array(
				'periode'=>$this->Periode->SelectedValue,
				'bln'=>$this->DDBulan->SelectedValue,
				'thn'=>$this->DDTahun->SelectedValue,
				'mingguan'=>$this->mingguan->Text)));
	}
	
}
?>
