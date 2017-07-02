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
					tbt_rekap_neraca_detail.kelompok_akun,
					tbt_rekap_neraca_detail.nama_akun,
					tbt_rekap_neraca_detail.nilai_akun
				FROM 
					tbt_rekap_neraca_detail
				INNER JOIN tbt_rekap_neraca ON tbt_rekap_neraca.id = tbt_rekap_neraca_detail.id_rekap 
				WHERE 
					tbt_rekap_neraca_detail.deleted = '0'
					AND tbt_rekap_neraca.tahun = '$tahun'
					AND tbt_rekap_neraca.bulan = '$bulan'
				ORDER BY tbt_rekap_neraca_detail.id ASC ";
		$arrAkun = $this->queryAction($sql,'S');		
		$jmlAktivaLancar = 0;
		$jmlAktivaTetap = 0;
		$jmlAktiva = 0;
		$jmlUtang = 0;
		$jmlKewajiban = 0;
		
		$tblBody = '';
		$tblBody .= '<tr>';
		$tblBody .= '<td colspan=\"5\"><strong>Aktiva</strong></td>';
		$tblBody .= '</tr>';
		$tblBody .= '<tr>';
		$tblBody .= '<td colspan=\"5\"><strong>Aktiva Lancar</strong></td>';
		$tblBody .= '</tr>';	
		foreach($arrAkun as $row)
		{
			if($row['kelompok_akun'] == '1')
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td width=\"5%\"></td>';
				$tblBody .= '<td width=\"40%\">'.$row['nama_akun'].'</td>';
				$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($row['nilai_akun'],2,".",",").'</td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '</tr>';
				$jmlAktivaLancar += $row['nilai_akun'];
			}
			
		}
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\" align=\"right\">Jumlah Aktiva Lancar</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"><strong>'.number_format($jmlAktivaLancar,2,".",",").'</strong></td>';
		$tblBody .= '</tr>';
		$jmlAktiva += $jmlAktivaLancar;
		$tblBody .= '<tr>';
		$tblBody .= '<td colspan=\"5\"><strong>Aktiva Tetap</strong></td>';
		$tblBody .= '</tr>';	
		
		$prevAkun = '';
		$nilaiAktiva = 0;
		foreach($arrAkun as $row)
		{
			if($row['kelompok_akun'] == '2' || $row['kelompok_akun'] == '3')
			{
				if($row['kelompok_akun'] == '2')
				{
					$tblBody .= '<tr>';
					$tblBody .= '<td width=\"5%\"></td>';
					$tblBody .= '<td width=\"40%\">'.$row['nama_akun'].' </td>';
					$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($row['nilai_akun'],2,".",",").'</td>';
					$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
					$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
					$tblBody .= '</tr>';
					$nilaiAktiva += $row['nilai_akun'];
					$jmlAktivaTetap += $row['nilai_akun'];
				}
				
				if($row['kelompok_akun'] == '3')
				{
					$tblBody .= '<tr>';
					$tblBody .= '<td width=\"5%\"></td>';
					$tblBody .= '<td width=\"40%\">'.$row['nama_akun'].' </td>';
					$tblBody .= '<td width=\"20%\" align=\"right\">('.number_format($row['nilai_akun'],2,".",",").')</td>';
					$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
					$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
					$tblBody .= '</tr>';
					$nilaiAktiva -= $row['nilai_akun'];
					$jmlAktivaTetap -= $row['nilai_akun'];
				}
				
				if($prevAkun == '2')
				{
					$tblBody .= '<tr>';
					$tblBody .= '<td width=\"5%\"></td>';
					$tblBody .= '<td width=\"40%\"></td>';
					$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
					$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($nilaiAktiva,2,".",",").'</td>';
					$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
					$tblBody .= '</tr>';
					$nilaiAktiva = 0;
				}
				
				$prevAkun = $row['kelompok_akun'];
				
			}
			
		
		}
		
		$jmlAktiva += $jmlAktivaTetap;	
		
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\" align=\"right\">Jumlah Aktiva Tetap</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"><strong>'.number_format($jmlAktivaTetap,2,".",",").'</strong></td>';
		$tblBody .= '</tr>';
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\" align=\"right\"><strong>Jumlah Aktiva</strong></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"><strong>'.number_format($jmlAktiva,2,".",",").'</strong></td>';
		$tblBody .= '</tr>';
		
		$tblBody .= '<tr>';
		$tblBody .= '<td colspan=\"5\"><strong>Kewajiban</strong></td>';
		$tblBody .= '</tr>';
		$tblBody .= '<tr>';
		$tblBody .= '<td colspan=\"5\"><strong>Utang Lancar</strong></td>';
		$tblBody .= '</tr>';
		foreach($arrAkun as $row)
		{
			if($row['kelompok_akun'] == '4')
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td width=\"5%\"></td>';
				$tblBody .= '<td width=\"40%\">'.$row['nama_akun'].'</td>';
				$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($row['nilai_akun'],2,".",",").'</td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '</tr>';
				$jmlUtang += $row['nilai_akun'];
			}
			
		}
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\" align=\"right\">Jumlah Utang</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"><strong>'.number_format($jmlUtang,2,".",",").'</strong></td>';
		$tblBody .= '</tr>';
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\" align=\"right\"><strong>Jumlah Kewajiban</strong></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"><strong>'.number_format($jmlUtang,2,".",",").'</strong></td>';
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
		$url = "index.php?page=Keuangan.cetakLaporanNeracaPdf&bln=".$this->DDBulan->SelectedValue."&thn=".$this->DDTahun->SelectedValue;
		
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
