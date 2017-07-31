<?PHP
class NeracaBulanan extends MainConf
{

	public function onLoadComplete($param)
	{
		parent::onLoadComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			//$this->cariBtnClicked($sender,$param);
			if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
			{
				//$this->cariBtnClicked($sender,$param);
				$sqlTahun = "SELECT tahun AS id,tahun AS nama FROM tbt_rekap_neraca WHERE deleted = '0' GROUP BY tbt_rekap_neraca.tahun ";
				$arrTahun = $this->queryAction($sqlTahun,'S');
				$this->DDTahun->DataSource = $arrTahun;
				$this->DDTahun->DataBind();
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
	

	public function tahunChanged()
	{
		$sqlBulan = "SELECT bulan AS id,bulan AS nama FROM tbt_rekap_neraca WHERE deleted = '0' AND tahun = '".$this->DDTahun->SelectedValue."' GROUP BY tbt_rekap_neraca.bulan ";
		$arrBulan = array();
		foreach($this->queryAction($sqlBulan,'S') as $row)
		{
			$arrBulan[] = array("id"=>$row['id'],"nama"=>$this->namaBulan($row['nama']));
		}
		
		$this->DDBulan->DataSource = $arrBulan;
		$this->DDBulan->DataBind();
	}
	
	public function cariBtnClicked($sender,$param)
	{
		$tahun = $this->DDTahun->SelectedValue;
		$bulan = $this->DDBulan->SelectedValue;
		
		$sql = "SELECT 
					*
				FROM 
					tbt_rekap_neraca_detail
				INNER JOIN tbt_rekap_neraca ON tbt_rekap_neraca.id = tbt_rekap_neraca_detail.id_rekap 
				WHERE 
					tbt_rekap_neraca_detail.deleted = '0'
					AND tbt_rekap_neraca.tahun = '$tahun'
					AND tbt_rekap_neraca.bulan = '$bulan'
				ORDER BY tbt_rekap_neraca_detail.id ASC ";
		$arrAkun = $this->queryAction($sql,'S');		
		$neracaSaldoDebet = 0;
		$neracaSaldoKredit = 0;
		$penyesuaianDebet = 0;
		$penyesuaianKredit = 0;
		$nsdDebet = 0;
		$nsdKredit = 0;
		$labarugiDebet = 0;
		$labarugiKredit = 0;
		$neracaDebet = 0;
		$neracaKredit = 0;
		$tblBody = '';
		$tblBody .= '<tr>';
		$tblBody .= '<td Rowspan=\"2\" align=\"center\"><strong>Nama Akun</strong></td>';
		$tblBody .= '<td Colspan=\"2\" align=\"center\"><strong>Neraca Saldo</strong></td>';
		$tblBody .= '<td Colspan=\"2\" align=\"center\"><strong>Penyesuaian</strong></td>';
		$tblBody .= '<td Colspan=\"2\" align=\"center\"><strong>Neraca Saldo Disesuaikan</strong></td>';
		$tblBody .= '<td Colspan=\"2\" align=\"center\"><strong>Laba / Rugi</strong></td>';
		$tblBody .= '<td Colspan=\"2\" align=\"center\"><strong>Neraca</strong></td>';
		$tblBody .= '</tr>';
		$tblBody .= '<tr>';
		$tblBody .= '<td align=\"center\"><strong>Debet</strong></td>';
		$tblBody .= '<td align=\"center\"><strong>Kredit</strong></td>';
		$tblBody .= '<td align=\"center\"><strong>Debet</strong></td>';
		$tblBody .= '<td align=\"center\"><strong>Kredit</strong></td>';
		$tblBody .= '<td align=\"center\"><strong>Debet</strong></td>';
		$tblBody .= '<td align=\"center\"><strong>Kredit</strong></td>';
		$tblBody .= '<td align=\"center\"><strong>Debet</strong></td>';
		$tblBody .= '<td align=\"center\"><strong>Kredit</strong></td>';
		$tblBody .= '<td align=\"center\"><strong>Debet</strong></td>';
		$tblBody .= '<td align=\"center\"><strong>Kredit</strong></td>';
		$tblBody .= '</tr>';
		
		foreach($arrAkun as $row)
		{
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">'.$row['nama_akun'].'</td>';
				
				//Neraca Saldo
				$neracaSaldoDebet += $row['neraca_saldo_debet'];
				$neracaSaldoKredit += $row['neraca_saldo_kredit'];
				$tblBody .= '<td align=\"right\">'.number_format($row['neraca_saldo_debet'],2,".",",").'</td>';
				$tblBody .= '<td align=\"right\">'.number_format($row['neraca_saldo_kredit'],2,".",",").'</td>';
				
				
				//Penyesuaian
				$penyesuaianDebet += $row['penyesuaian_debet'];
				$penyesuaianKredit += $row['penyesuaian_kredit'];
				$tblBody .= '<td align=\"right\">'.number_format($row['penyesuaian_debet'],2,".",",").'</td>';
				$tblBody .= '<td align=\"right\">'.number_format($row['penyesuaian_kredit'],2,".",",").'</td>';
				
				//NSD
				$nsdDebet += $row['ns_disesuaikan_debet'];
				$nsdKredit += $row['ns_disesuaikan_kredit'];
				$tblBody .= '<td align=\"right\">'.number_format($row['ns_disesuaikan_debet'],2,".",",").'</td>';
				$tblBody .= '<td align=\"right\">'.number_format($row['ns_disesuaikan_kredit'],2,".",",").'</td>';
				
				//Laba Rugi
				$labarugiDebet += $row['laba_rugi_debet'];
				$labarugiKredit += $row['laba_rugi_kredit'];
				$tblBody .= '<td align=\"right\">'.number_format($row['laba_rugi_debet'],2,".",",").'</td>';
				$tblBody .= '<td align=\"right\">'.number_format($row['laba_rugi_kredit'],2,".",",").'</td>';
				
				//Neraca
				$neracaDebet += $row['neraca_debet'];
				$neracaKredit += $row['neraca_kredit'];
				$tblBody .= '<td align=\"right\">'.number_format($row['neraca_debet'],2,".",",").'</td>';
				$tblBody .= '<td align=\"right\">'.number_format($row['neraca_kredit'],2,".",",").'</td>';
				
				$tblBody .= '</tr>';
				
			
		}
		
		$tblBody .= '<tr>';
		$tblBody .= '<td align=\"center\"><strong>Jumlah</strong></td>';
		
		//Neraca Saldo
		$tblBody .= '<td align=\"right\">'.number_format($neracaSaldoDebet,2,".",",").'</td>';
		$tblBody .= '<td align=\"right\">'.number_format($neracaSaldoKredit,2,".",",").'</td>';
		
		//Penyesuaian
		$tblBody .= '<td align=\"right\">'.number_format($penyesuaianDebet,2,".",",").'</td>';
		$tblBody .= '<td align=\"right\">'.number_format($penyesuaianKredit,2,".",",").'</td>';
				
		//NSD
		$tblBody .= '<td align=\"right\">'.number_format($nsdDebet,2,".",",").'</td>';
		$tblBody .= '<td align=\"right\">'.number_format($nsdKredit,2,".",",").'</td>';
				
		//Laba Rugi
		$tblBody .= '<td align=\"right\">'.number_format($labarugiDebet,2,".",",").'</td>';
		$tblBody .= '<td align=\"right\">'.number_format($labarugiKredit,2,".",",").'</td>';
				
		//Neraca
		$tblBody .= '<td align=\"right\">'.number_format($neracaDebet,2,".",",").'</td>';
		$tblBody .= '<td align=\"right\">'.number_format($neracaKredit,2,".",",").'</td>';
		
		$tblBody .= '</tr>';
		
		$this->getPage()->getClientScript()->registerEndScript
					('','
					console.log("'.$tblBody.'");
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					unloadContent();
					');
		
	}
	
	public function closingClicked()
	{
		$bulan = date("m");
		$tahun = date("Y");
		$arrRekapNeraca = $this->getViewState('arrRekapNeraca');
		
		if(count($arrRekapNeraca) > 0)
		{
			$RekapNeracaRecord = RekapNeracaRecord::finder()->find('bulan = ? AND tahun = ? AND deleted = ?',$bulan,$tahun,'0');
			if(!$RekapNeracaRecord)
			{
				$RekapNeracaRecord = new RekapNeracaRecord();
				$RekapNeracaRecord->bulan = $bulan;
				$RekapNeracaRecord->tahun = $tahun;
				$RekapNeracaRecord->deleted = '0';
				$RekapNeracaRecord->save();
				
				foreach($arrRekapNeraca as $row)
				{
					$RekapNeracaDetailRecord = new RekapNeracaDetailRecord();
						
					$RekapNeracaDetailRecord->id_rekap = $RekapNeracaRecord->id;
					$RekapNeracaDetailRecord->kelompok_akun = $row['kelompok_neraca'];
					$RekapNeracaDetailRecord->nama_akun = $row['nama_akun'];
					$RekapNeracaDetailRecord->nilai_akun = $row['nilai_akun'];
					$RekapNeracaDetailRecord->deleted = '0';
					$RekapNeracaDetailRecord->save();
					
				}
				
				$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						toastr.info("Neraca Bulan Ini Berhasil Diclosing !");
						');	
			}
			else
			{
				$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						toastr.error("Neraca Bulan Ini Sudah Diclosing Sebelumnya !");
						');	
			}
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						toastr.error("Rekap Neraca Belum Diproses !");
						');	
		}
	}
	
	public function cetakLapKartuStok()
	{
		if($this->DDBulan->SelectedValue != '' && $this->DDTahun->SelectedValue != '')
		{
		$url = "index.php?page=Keuangan.cetakLaporanKertasKerjaPdf&bln=".$this->DDBulan->SelectedValue."&thn=".$this->DDTahun->SelectedValue;
		
		$folderApp = explode("/",$_SERVER['REQUEST_URI']);
		$urlTemp="http://".$_SERVER['HTTP_HOST']."/".$folderApp[1]."/".$url;
		
		$this->getPage()->getClientScript()->registerEndScript
							('','
							var url = "'.$urlTemp.'";
							window.open(url, "_blank");
							unloadContent();');	
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					toastr.error("Pilih Bulan Dan Tahun !");
					');
		}
	}
}
?>
