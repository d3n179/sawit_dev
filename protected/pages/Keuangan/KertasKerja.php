<?PHP
class KertasKerja extends MainConf
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
				$tahun = 2017;
				$bulan = $this->namaBulan('01');
				
				$this->Periode->Text = $bulan." ".$tahun;
				
				$sql = "SELECT id,nama AS nama FROM tbm_bank WHERE deleted !='1' ";
				$arr = $this->queryAction($sql,'S');
				$this->DDAsalSaldo->DataSource = $arr;
				$this->DDAsalSaldo->DataBind();
				
				$tblBody = $this->BindGridPenyesuaian();
				$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#tablePenyesuaian tbody").append("'.$tblBody.'");');	
				
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
	
	public function cariBtnClicked($sender,$param)
	{
		$sqlBukuBesar = "SELECT
							id,
							nama_akun
						FROM
							tbt_jurnal_buku_besar
						WHERE
							deleted != '1'
						GROUP BY
							nama_akun ";
		$arrBukuBesar = $this->queryAction($sqlBukuBesar,'S');
		
		$arrRekapKertasKerja = array();
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
		
		foreach($arrBukuBesar as $row)
		{
			if($row['nama_akun'] == 'Kas')
			{
				
				
				$sqlSaldoAkhir = "SELECT * FROM tbt_jurnal_buku_besar WHERE nama_akun = '".$row['nama_akun']."' ORDER BY id DESC LIMIT 1";
				$arrSaldoAkhir = $this->queryAction($sqlSaldoAkhir,'S');
				$saldoAkhir = $arrSaldoAkhir[0]['saldo_akhir'];
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">Kas</td>';
				
				$neracasaldoDebetTemp = 0;
				$neracasaldoKreditTemp = 0;
				$penyesuaianDebetTemp = 0;
				$penyesuaianKreditTemp = 0;
				$nsdDebetTemp = 0;
				$nsdKreditTemp = 0;
				$labarugiDebetTemp = 0;
				$labarugiKreditTemp = 0;
				$neracaDebetTemp = 0;
				$neracaKreditTemp = 0;
				//Neraca Saldo
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaSaldoDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracasaldoDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaSaldoKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracasaldoKreditTemp = $saldoAkhir;
				}
				
				//Penyesuaian
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianKreditTemp = 0;
				
				//NSD
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$nsdDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$nsdDebetTemp = $saldoAkhir;
				}
				else
				{
					$nsdKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$nsdKreditTemp = $saldoAkhir;
				}
				
				//Laba Rugi
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiKreditTemp = 0;
				
				//Neraca
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracaDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracaKreditTemp = $saldoAkhir;
				}
				
				$tblBody .= '</tr>';
				
				$arrRekapKertasKerja[] = array("namaAkun"=>"Kas",
												"neracasaldoDebetTemp"=>$neracasaldoDebetTemp,
												"neracasaldoKreditTemp"=>$neracasaldoKreditTemp,
												"penyesuaianDebetTemp"=>$penyesuaianDebetTemp,
												"penyesuaianKreditTemp"=>$penyesuaianKreditTemp,
												"nsdDebetTemp"=>$nsdDebetTemp,
												"nsdKreditTemp"=>$nsdKreditTemp,
												"labarugiDebetTemp"=>$labarugiDebetTemp,
												"labarugiKreditTemp"=>$labarugiKreditTemp,
												"neracaDebetTemp"=>$neracaDebetTemp,
												"neracaKreditTemp"=>$neracaKreditTemp
												);
				
			}
		}
		
		foreach($arrBukuBesar as $row)
		{
			if($row['nama_akun'] == 'Kas Bank')
			{
				$sqlSaldoAkhir = "SELECT * FROM tbt_jurnal_buku_besar WHERE nama_akun = '".$row['nama_akun']."' ORDER BY id DESC LIMIT 1";
				$arrSaldoAkhir = $this->queryAction($sqlSaldoAkhir,'S');
				$saldoAkhir = $arrSaldoAkhir[0]['saldo_akhir'];
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">Kas Bank</td>';
				
				$neracasaldoDebetTemp = 0;
				$neracasaldoKreditTemp = 0;
				$penyesuaianDebetTemp = 0;
				$penyesuaianKreditTemp = 0;
				$nsdDebetTemp = 0;
				$nsdKreditTemp = 0;
				$labarugiDebetTemp = 0;
				$labarugiKreditTemp = 0;
				$neracaDebetTemp = 0;
				$neracaKreditTemp = 0;
				
				//Neraca Saldo
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaSaldoDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracasaldoDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaSaldoKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracasaldoKreditTemp = $saldoAkhir;
				}
				
				//Penyesuaian
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianKreditTemp = 0;
				
				//NSD
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$nsdDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$nsdDebetTemp = $saldoAkhir;
				}
				else
				{
					$nsdKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$nsdKreditTemp = $saldoAkhir;
				}
				
				//Laba Rugi
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiKreditTemp = 0;
				
				//Neraca
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracaDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracaKreditTemp = $saldoAkhir;
				}
				
				$tblBody .= '</tr>';
				
				$arrRekapKertasKerja[] = array("namaAkun"=>"Kas Bank",
												"neracasaldoDebetTemp"=>$neracasaldoDebetTemp,
												"neracasaldoKreditTemp"=>$neracasaldoKreditTemp,
												"penyesuaianDebetTemp"=>$penyesuaianDebetTemp,
												"penyesuaianKreditTemp"=>$penyesuaianKreditTemp,
												"nsdDebetTemp"=>$nsdDebetTemp,
												"nsdKreditTemp"=>$nsdKreditTemp,
												"labarugiDebetTemp"=>$labarugiDebetTemp,
												"labarugiKreditTemp"=>$labarugiKreditTemp,
												"neracaDebetTemp"=>$neracaDebetTemp,
												"neracaKreditTemp"=>$neracaKreditTemp
												);
			}
		}
		
		foreach($arrBukuBesar as $row)
		{
			if($row['nama_akun'] == 'Piutang')
			{
				$sqlSaldoAkhir = "SELECT * FROM tbt_jurnal_buku_besar WHERE nama_akun = '".$row['nama_akun']."' ORDER BY id DESC LIMIT 1";
				$arrSaldoAkhir = $this->queryAction($sqlSaldoAkhir,'S');
				$saldoAkhir = $arrSaldoAkhir[0]['saldo_akhir'];
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">Piutang</td>';
				
				$neracasaldoDebetTemp = 0;
				$neracasaldoKreditTemp = 0;
				$penyesuaianDebetTemp = 0;
				$penyesuaianKreditTemp = 0;
				$nsdDebetTemp = 0;
				$nsdKreditTemp = 0;
				$labarugiDebetTemp = 0;
				$labarugiKreditTemp = 0;
				$neracaDebetTemp = 0;
				$neracaKreditTemp = 0;
				//Neraca Saldo
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaSaldoDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracasaldoDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaSaldoKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracasaldoKreditTemp = $saldoAkhir;
				}
				
				//Penyesuaian
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianKreditTemp = 0;
				
				//NSD
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$nsdDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$nsdDebetTemp = $saldoAkhir;
				}
				else
				{
					$nsdKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$nsdKreditTemp = $saldoAkhir;
				}
				
				//Laba Rugi
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiKreditTemp = 0;
				
				//Neraca
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracaDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracaKreditTemp = $saldoAkhir;
				}
				
				$tblBody .= '</tr>';
				
				$arrRekapKertasKerja[] = array("namaAkun"=>"Piutang",
												"neracasaldoDebetTemp"=>$neracasaldoDebetTemp,
												"neracasaldoKreditTemp"=>$neracasaldoKreditTemp,
												"penyesuaianDebetTemp"=>$penyesuaianDebetTemp,
												"penyesuaianKreditTemp"=>$penyesuaianKreditTemp,
												"nsdDebetTemp"=>$nsdDebetTemp,
												"nsdKreditTemp"=>$nsdKreditTemp,
												"labarugiDebetTemp"=>$labarugiDebetTemp,
												"labarugiKreditTemp"=>$labarugiKreditTemp,
												"neracaDebetTemp"=>$neracaDebetTemp,
												"neracaKreditTemp"=>$neracaKreditTemp
												);
			}
		}
		
		foreach($arrBukuBesar as $row)
		{
			if($row['nama_akun'] == 'Persediaan Barang Dagangan')
			{
				$sqlSaldoAkhir = "SELECT * FROM tbt_jurnal_buku_besar WHERE nama_akun = '".$row['nama_akun']."' ORDER BY id DESC LIMIT 1";
				$arrSaldoAkhir = $this->queryAction($sqlSaldoAkhir,'S');
				$saldoAkhir = $arrSaldoAkhir[0]['saldo_akhir'];
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">Persediaan Barang Dagangan</td>';
				
				$neracasaldoDebetTemp = 0;
				$neracasaldoKreditTemp = 0;
				$penyesuaianDebetTemp = 0;
				$penyesuaianKreditTemp = 0;
				$nsdDebetTemp = 0;
				$nsdKreditTemp = 0;
				$labarugiDebetTemp = 0;
				$labarugiKreditTemp = 0;
				$neracaDebetTemp = 0;
				$neracaKreditTemp = 0;
				//Neraca Saldo
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaSaldoDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracasaldoDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaSaldoKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracasaldoKreditTemp = $saldoAkhir;
				}
				
				//Penyesuaian
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianKreditTemp = 0;
				
				//NSD
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$nsdDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$nsdDebetTemp = $saldoAkhir;
				}
				else
				{
					$nsdKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$nsdKreditTemp = $saldoAkhir;
				}
				
				//Laba Rugi
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiKreditTemp = 0;
				
				//Neraca
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracaDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracaKreditTemp = $saldoAkhir;
				}
				
				$tblBody .= '</tr>';
				
				$arrRekapKertasKerja[] = array("namaAkun"=>"Persediaan Barang Dagangan",
												"neracasaldoDebetTemp"=>$neracasaldoDebetTemp,
												"neracasaldoKreditTemp"=>$neracasaldoKreditTemp,
												"penyesuaianDebetTemp"=>$penyesuaianDebetTemp,
												"penyesuaianKreditTemp"=>$penyesuaianKreditTemp,
												"nsdDebetTemp"=>$nsdDebetTemp,
												"nsdKreditTemp"=>$nsdKreditTemp,
												"labarugiDebetTemp"=>$labarugiDebetTemp,
												"labarugiKreditTemp"=>$labarugiKreditTemp,
												"neracaDebetTemp"=>$neracaDebetTemp,
												"neracaKreditTemp"=>$neracaKreditTemp
												);
			}
		}
		
		foreach($arrBukuBesar as $row)
		{
			if($row['nama_akun'] == 'Persediaan Bahan Baku')
			{
				$sqlSaldoAkhir = "SELECT * FROM tbt_jurnal_buku_besar WHERE nama_akun = '".$row['nama_akun']."' ORDER BY id DESC LIMIT 1";
				$arrSaldoAkhir = $this->queryAction($sqlSaldoAkhir,'S');
				$saldoAkhir = $arrSaldoAkhir[0]['saldo_akhir'];
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">Persediaan Bahan Baku</td>';
				
				$neracasaldoDebetTemp = 0;
				$neracasaldoKreditTemp = 0;
				$penyesuaianDebetTemp = 0;
				$penyesuaianKreditTemp = 0;
				$nsdDebetTemp = 0;
				$nsdKreditTemp = 0;
				$labarugiDebetTemp = 0;
				$labarugiKreditTemp = 0;
				$neracaDebetTemp = 0;
				$neracaKreditTemp = 0;
				//Neraca Saldo
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaSaldoDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracasaldoDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaSaldoKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracasaldoKreditTemp = $saldoAkhir;
				}
				
				//Penyesuaian
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianKreditTemp = 0;
				
				//NSD
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$nsdDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$nsdDebetTemp = $saldoAkhir;
				}
				else
				{
					$nsdKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$nsdKreditTemp = $saldoAkhir;
				}
				
				//Laba Rugi
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiKreditTemp = 0;
				
				//Neraca
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracaDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracaKreditTemp = $saldoAkhir;
				}
				
				$tblBody .= '</tr>';
				
				$arrRekapKertasKerja[] = array("namaAkun"=>"Persediaan Bahan Baku",
												"neracasaldoDebetTemp"=>$neracasaldoDebetTemp,
												"neracasaldoKreditTemp"=>$neracasaldoKreditTemp,
												"penyesuaianDebetTemp"=>$penyesuaianDebetTemp,
												"penyesuaianKreditTemp"=>$penyesuaianKreditTemp,
												"nsdDebetTemp"=>$nsdDebetTemp,
												"nsdKreditTemp"=>$nsdKreditTemp,
												"labarugiDebetTemp"=>$labarugiDebetTemp,
												"labarugiKreditTemp"=>$labarugiKreditTemp,
												"neracaDebetTemp"=>$neracaDebetTemp,
												"neracaKreditTemp"=>$neracaKreditTemp
												);
			}
		}
		
		foreach($arrBukuBesar as $row)
		{
			if($row['nama_akun'] == 'Perlengkapan')
			{
				$sqlSaldoAkhir = "SELECT * FROM tbt_jurnal_buku_besar WHERE nama_akun = '".$row['nama_akun']."' ORDER BY id DESC LIMIT 1";
				$arrSaldoAkhir = $this->queryAction($sqlSaldoAkhir,'S');
				$saldoAkhir = $arrSaldoAkhir[0]['saldo_akhir'];
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">Perlengkapan</td>';
				$neracasaldoDebetTemp = 0;
				$neracasaldoKreditTemp = 0;
				$penyesuaianDebetTemp = 0;
				$penyesuaianKreditTemp = 0;
				$nsdDebetTemp = 0;
				$nsdKreditTemp = 0;
				$labarugiDebetTemp = 0;
				$labarugiKreditTemp = 0;
				$neracaDebetTemp = 0;
				$neracaKreditTemp = 0;
				//Neraca Saldo
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaSaldoDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracasaldoDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaSaldoKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracasaldoKreditTemp = $saldoAkhir;
				}
				
				//Penyesuaian
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianKreditTemp = 0;
				
				//NSD
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$nsdDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$nsdDebetTemp = $saldoAkhir;
				}
				else
				{
					$nsdKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$nsdKreditTemp = $saldoAkhir;
				}
				
				//Laba Rugi
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiKreditTemp = 0;
				
				//Neraca
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracaDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracaKreditTemp = $saldoAkhir;
				}
				
				$tblBody .= '</tr>';
				
				$arrRekapKertasKerja[] = array("namaAkun"=>"Perlengkapan",
												"neracasaldoDebetTemp"=>$neracasaldoDebetTemp,
												"neracasaldoKreditTemp"=>$neracasaldoKreditTemp,
												"penyesuaianDebetTemp"=>$penyesuaianDebetTemp,
												"penyesuaianKreditTemp"=>$penyesuaianKreditTemp,
												"nsdDebetTemp"=>$nsdDebetTemp,
												"nsdKreditTemp"=>$nsdKreditTemp,
												"labarugiDebetTemp"=>$labarugiDebetTemp,
												"labarugiKreditTemp"=>$labarugiKreditTemp,
												"neracaDebetTemp"=>$neracaDebetTemp,
												"neracaKreditTemp"=>$neracaKreditTemp
												);
			}
		}
		
		foreach($arrBukuBesar as $row)
		{
			if($row['nama_akun'] == 'Hutang')
			{
				$sqlSaldoAkhir = "SELECT * FROM tbt_jurnal_buku_besar WHERE nama_akun = '".$row['nama_akun']."' ORDER BY id DESC LIMIT 1";
				$arrSaldoAkhir = $this->queryAction($sqlSaldoAkhir,'S');
				$saldoAkhir = $arrSaldoAkhir[0]['saldo_akhir'];
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">Hutang</td>';
				$neracasaldoDebetTemp = 0;
				$neracasaldoKreditTemp = 0;
				$penyesuaianDebetTemp = 0;
				$penyesuaianKreditTemp = 0;
				$nsdDebetTemp = 0;
				$nsdKreditTemp = 0;
				$labarugiDebetTemp = 0;
				$labarugiKreditTemp = 0;
				$neracaDebetTemp = 0;
				$neracaKreditTemp = 0;
				//Neraca Saldo
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaSaldoDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracasaldoDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaSaldoKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracasaldoKreditTemp = $saldoAkhir;
				}
				
				//Penyesuaian
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianKreditTemp = 0;
				
				//NSD
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$nsdDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$nsdDebetTemp = $saldoAkhir;
				}
				else
				{
					$nsdKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$nsdKreditTemp = $saldoAkhir;
				}
				
				//Laba Rugi
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiKreditTemp = 0;
				
				//Neraca
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracaDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracaKreditTemp = $saldoAkhir;
				}
				
				$tblBody .= '</tr>';
				
				$arrRekapKertasKerja[] = array("namaAkun"=>"Hutang",
												"neracasaldoDebetTemp"=>$neracasaldoDebetTemp,
												"neracasaldoKreditTemp"=>$neracasaldoKreditTemp,
												"penyesuaianDebetTemp"=>$penyesuaianDebetTemp,
												"penyesuaianKreditTemp"=>$penyesuaianKreditTemp,
												"nsdDebetTemp"=>$nsdDebetTemp,
												"nsdKreditTemp"=>$nsdKreditTemp,
												"labarugiDebetTemp"=>$labarugiDebetTemp,
												"labarugiKreditTemp"=>$labarugiKreditTemp,
												"neracaDebetTemp"=>$neracaDebetTemp,
												"neracaKreditTemp"=>$neracaKreditTemp
												);
			}
		}
		
		foreach($arrBukuBesar as $row)
		{
			if($row['nama_akun'] == 'Hutang Gaji')
			{
				$sqlSaldoAkhir = "SELECT * FROM tbt_jurnal_buku_besar WHERE nama_akun = '".$row['nama_akun']."' ORDER BY id DESC LIMIT 1";
				$arrSaldoAkhir = $this->queryAction($sqlSaldoAkhir,'S');
				$saldoAkhir = $arrSaldoAkhir[0]['saldo_akhir'];
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">Hutang Gaji</td>';
				$neracasaldoDebetTemp = 0;
				$neracasaldoKreditTemp = 0;
				$penyesuaianDebetTemp = 0;
				$penyesuaianKreditTemp = 0;
				$nsdDebetTemp = 0;
				$nsdKreditTemp = 0;
				$labarugiDebetTemp = 0;
				$labarugiKreditTemp = 0;
				$neracaDebetTemp = 0;
				$neracaKreditTemp = 0;
				//Neraca Saldo
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaSaldoDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracasaldoDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaSaldoKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracasaldoKreditTemp = $saldoAkhir;
				}
				
				//Penyesuaian
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianKreditTemp = 0;
				
				//NSD
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$nsdDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$nsdDebetTemp = $saldoAkhir;
				}
				else
				{
					$nsdKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$nsdKreditTemp = $saldoAkhir;
				}
				
				//Laba Rugi
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiKreditTemp = 0;
				
				//Neraca
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracaDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracaKreditTemp = $saldoAkhir;
				}
				
				$tblBody .= '</tr>';
				
				$arrRekapKertasKerja[] = array("namaAkun"=>"Hutang Gaji",
												"neracasaldoDebetTemp"=>$neracasaldoDebetTemp,
												"neracasaldoKreditTemp"=>$neracasaldoKreditTemp,
												"penyesuaianDebetTemp"=>$penyesuaianDebetTemp,
												"penyesuaianKreditTemp"=>$penyesuaianKreditTemp,
												"nsdDebetTemp"=>$nsdDebetTemp,
												"nsdKreditTemp"=>$nsdKreditTemp,
												"labarugiDebetTemp"=>$labarugiDebetTemp,
												"labarugiKreditTemp"=>$labarugiKreditTemp,
												"neracaDebetTemp"=>$neracaDebetTemp,
												"neracaKreditTemp"=>$neracaKreditTemp
												);
			}
		}
		
		foreach($arrBukuBesar as $row)
		{
			if($row['nama_akun'] == 'Modal')
			{
				$sqlSaldoAkhir = "SELECT * FROM tbt_jurnal_buku_besar WHERE nama_akun = '".$row['nama_akun']."' ORDER BY id DESC LIMIT 1";
				$arrSaldoAkhir = $this->queryAction($sqlSaldoAkhir,'S');
				$saldoAkhir = $arrSaldoAkhir[0]['saldo_akhir'];
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">Modal</td>';
				$neracasaldoDebetTemp = 0;
				$neracasaldoKreditTemp = 0;
				$penyesuaianDebetTemp = 0;
				$penyesuaianKreditTemp = 0;
				$nsdDebetTemp = 0;
				$nsdKreditTemp = 0;
				$labarugiDebetTemp = 0;
				$labarugiKreditTemp = 0;
				$neracaDebetTemp = 0;
				$neracaKreditTemp = 0;
				//Neraca Saldo
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaSaldoDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracasaldoDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaSaldoKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracasaldoKreditTemp = $saldoAkhir;
				}
				
				//Penyesuaian
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianKreditTemp = 0;
				
				//NSD
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$nsdDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$nsdDebetTemp = $saldoAkhir;
				}
				else
				{
					$nsdKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$nsdKreditTemp = $saldoAkhir;
				}
				
				//Laba Rugi
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$labarugiKreditTemp = 0;
				
				//Neraca
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracaDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracaKreditTemp = $saldoAkhir;
				}
				
				$tblBody .= '</tr>';
				
				$arrRekapKertasKerja[] = array("namaAkun"=>"Modal",
												"neracasaldoDebetTemp"=>$neracasaldoDebetTemp,
												"neracasaldoKreditTemp"=>$neracasaldoKreditTemp,
												"penyesuaianDebetTemp"=>$penyesuaianDebetTemp,
												"penyesuaianKreditTemp"=>$penyesuaianKreditTemp,
												"nsdDebetTemp"=>$nsdDebetTemp,
												"nsdKreditTemp"=>$nsdKreditTemp,
												"labarugiDebetTemp"=>$labarugiDebetTemp,
												"labarugiKreditTemp"=>$labarugiKreditTemp,
												"neracaDebetTemp"=>$neracaDebetTemp,
												"neracaKreditTemp"=>$neracaKreditTemp
												);
			}
		}
		
		foreach($arrBukuBesar as $row)
		{
			if($row['nama_akun'] == 'Pendapatan')
			{
				$sqlSaldoAkhir = "SELECT * FROM tbt_jurnal_buku_besar WHERE nama_akun = '".$row['nama_akun']."' AND status = '0' ORDER BY id DESC LIMIT 1";
				$arrSaldoAkhir = $this->queryAction($sqlSaldoAkhir,'S');
				$saldoAkhir = $arrSaldoAkhir[0]['saldo_akhir'];
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">Pendapatan</td>';
				$neracasaldoDebetTemp = 0;
				$neracasaldoKreditTemp = 0;
				$penyesuaianDebetTemp = 0;
				$penyesuaianKreditTemp = 0;
				$nsdDebetTemp = 0;
				$nsdKreditTemp = 0;
				$labarugiDebetTemp = 0;
				$labarugiKreditTemp = 0;
				$neracaDebetTemp = 0;
				$neracaKreditTemp = 0;
				//Neraca Saldo
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaSaldoDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracasaldoDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaSaldoKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracasaldoKreditTemp = $saldoAkhir;
				}
				
				//Penyesuaian
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianKreditTemp = 0;
				
				//NSD
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$nsdDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$nsdDebetTemp = $saldoAkhir;
				}
				else
				{
					$nsdKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$nsdKreditTemp = $saldoAkhir;
				}
				
				//Laba Rugi
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$labarugiDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$labarugiDebetTemp = $saldoAkhir;
				}
				else
				{
					$labarugiKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$labarugiKreditTemp = $saldoAkhir;
				}
				
				//Neraca
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracaDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracaKreditTemp = $saldoAkhir;
				}
				
				$tblBody .= '</tr>';
				
				$arrRekapKertasKerja[] = array("namaAkun"=>"Pendapatan",
												"neracasaldoDebetTemp"=>$neracasaldoDebetTemp,
												"neracasaldoKreditTemp"=>$neracasaldoKreditTemp,
												"penyesuaianDebetTemp"=>$penyesuaianDebetTemp,
												"penyesuaianKreditTemp"=>$penyesuaianKreditTemp,
												"nsdDebetTemp"=>$nsdDebetTemp,
												"nsdKreditTemp"=>$nsdKreditTemp,
												"labarugiDebetTemp"=>$labarugiDebetTemp,
												"labarugiKreditTemp"=>$labarugiKreditTemp,
												"neracaDebetTemp"=>$neracaDebetTemp,
												"neracaKreditTemp"=>$neracaKreditTemp
												);
			}
		}
		
		foreach($arrBukuBesar as $row)
		{
			if($row['nama_akun'] == 'Pendapatan Lain-lain')
			{
				$sqlSaldoAkhir = "SELECT * FROM tbt_jurnal_buku_besar WHERE nama_akun = '".$row['nama_akun']."' AND status = '0' ORDER BY id DESC LIMIT 1";
				$arrSaldoAkhir = $this->queryAction($sqlSaldoAkhir,'S');
				$saldoAkhir = $arrSaldoAkhir[0]['saldo_akhir'];
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">Pendapatan Lain-lain</td>';
				$neracasaldoDebetTemp = 0;
				$neracasaldoKreditTemp = 0;
				$penyesuaianDebetTemp = 0;
				$penyesuaianKreditTemp = 0;
				$nsdDebetTemp = 0;
				$nsdKreditTemp = 0;
				$labarugiDebetTemp = 0;
				$labarugiKreditTemp = 0;
				$neracaDebetTemp = 0;
				$neracaKreditTemp = 0;
				//Neraca Saldo
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaSaldoDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracasaldoDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaSaldoKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracasaldoKreditTemp = $saldoAkhir;
				}
				
				//Penyesuaian
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianKreditTemp = 0;
				
				//NSD
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$nsdDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$nsdDebetTemp = $saldoAkhir;
				}
				else
				{
					$nsdKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$nsdKreditTemp = $saldoAkhir;
				}
				
				//Laba Rugi
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$labarugiDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$labarugiDebetTemp = $saldoAkhir;
				}
				else
				{
					$labarugiKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$labarugiKreditTemp = $saldoAkhir;
				}
				
				//Neraca
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracaDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracaKreditTemp = $saldoAkhir;
				}
				
				$tblBody .= '</tr>';
				
				$arrRekapKertasKerja[] = array("namaAkun"=>"Pendapatan Lain-lain",
												"neracasaldoDebetTemp"=>$neracasaldoDebetTemp,
												"neracasaldoKreditTemp"=>$neracasaldoKreditTemp,
												"penyesuaianDebetTemp"=>$penyesuaianDebetTemp,
												"penyesuaianKreditTemp"=>$penyesuaianKreditTemp,
												"nsdDebetTemp"=>$nsdDebetTemp,
												"nsdKreditTemp"=>$nsdKreditTemp,
												"labarugiDebetTemp"=>$labarugiDebetTemp,
												"labarugiKreditTemp"=>$labarugiKreditTemp,
												"neracaDebetTemp"=>$neracaDebetTemp,
												"neracaKreditTemp"=>$neracaKreditTemp
												);
			}
		}
		
		foreach($arrBukuBesar as $row)
		{
			if($row['nama_akun'] == 'Beban Gaji')
			{
				$sqlSaldoAkhir = "SELECT * FROM tbt_jurnal_buku_besar WHERE nama_akun = '".$row['nama_akun']."' AND status = '0' ORDER BY id DESC LIMIT 1";
				$arrSaldoAkhir = $this->queryAction($sqlSaldoAkhir,'S');
				$saldoAkhir = $arrSaldoAkhir[0]['saldo_akhir'];
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">Beban Gaji</td>';
				$neracasaldoDebetTemp = 0;
				$neracasaldoKreditTemp = 0;
				$penyesuaianDebetTemp = 0;
				$penyesuaianKreditTemp = 0;
				$nsdDebetTemp = 0;
				$nsdKreditTemp = 0;
				$labarugiDebetTemp = 0;
				$labarugiKreditTemp = 0;
				$neracaDebetTemp = 0;
				$neracaKreditTemp = 0;
				//Neraca Saldo
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaSaldoDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracasaldoDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaSaldoKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracasaldoKreditTemp = $saldoAkhir;
				}
				
				//Penyesuaian
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianKreditTemp = 0;
				
				//NSD
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$nsdDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$nsdDebetTemp = $saldoAkhir;
				}
				else
				{
					$nsdKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$nsdKreditTemp = $saldoAkhir;
				}
				
				//Laba Rugi
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$labarugiDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$labarugiDebetTemp = $saldoAkhir;
				}
				else
				{
					$labarugiKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$labarugiKreditTemp = $saldoAkhir;
				}
				
				//Neraca
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracaDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracaKreditTemp = $saldoAkhir;
				}
				
				$tblBody .= '</tr>';
				
				$arrRekapKertasKerja[] = array("namaAkun"=>"Beban Gaji",
												"neracasaldoDebetTemp"=>$neracasaldoDebetTemp,
												"neracasaldoKreditTemp"=>$neracasaldoKreditTemp,
												"penyesuaianDebetTemp"=>$penyesuaianDebetTemp,
												"penyesuaianKreditTemp"=>$penyesuaianKreditTemp,
												"nsdDebetTemp"=>$nsdDebetTemp,
												"nsdKreditTemp"=>$nsdKreditTemp,
												"labarugiDebetTemp"=>$labarugiDebetTemp,
												"labarugiKreditTemp"=>$labarugiKreditTemp,
												"neracaDebetTemp"=>$neracaDebetTemp,
												"neracaKreditTemp"=>$neracaKreditTemp
												);
			}
		}
		
		foreach($arrBukuBesar as $row)
		{
			if($row['nama_akun'] == 'Beban Perlengkapan')
			{
				$sqlSaldoAkhir = "SELECT * FROM tbt_jurnal_buku_besar WHERE nama_akun = '".$row['nama_akun']."' AND status = '0' ORDER BY id DESC LIMIT 1";
				$arrSaldoAkhir = $this->queryAction($sqlSaldoAkhir,'S');
				$saldoAkhir = $arrSaldoAkhir[0]['saldo_akhir'];
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">Beban Perlengkapan</td>';
				$neracasaldoDebetTemp = 0;
				$neracasaldoKreditTemp = 0;
				$penyesuaianDebetTemp = 0;
				$penyesuaianKreditTemp = 0;
				$nsdDebetTemp = 0;
				$nsdKreditTemp = 0;
				$labarugiDebetTemp = 0;
				$labarugiKreditTemp = 0;
				$neracaDebetTemp = 0;
				$neracaKreditTemp = 0;
				//Neraca Saldo
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaSaldoDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracasaldoDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaSaldoKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracasaldoKreditTemp = $saldoAkhir;
				}
				
				//Penyesuaian
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianKreditTemp = 0;
				
				//NSD
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$nsdDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$nsdDebetTemp = $saldoAkhir;
				}
				else
				{
					$nsdKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$nsdKreditTemp = $saldoAkhir;
				}
				
				//Laba Rugi
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$labarugiDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$labarugiDebetTemp = $saldoAkhir;
				}
				else
				{
					$labarugiKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$labarugiKreditTemp = $saldoAkhir;
				}
				
				//Neraca
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracaDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracaKreditTemp = $saldoAkhir;
				}
				
				$tblBody .= '</tr>';
				
				$arrRekapKertasKerja[] = array("namaAkun"=>"Beban Perlengkapan",
												"neracasaldoDebetTemp"=>$neracasaldoDebetTemp,
												"neracasaldoKreditTemp"=>$neracasaldoKreditTemp,
												"penyesuaianDebetTemp"=>$penyesuaianDebetTemp,
												"penyesuaianKreditTemp"=>$penyesuaianKreditTemp,
												"nsdDebetTemp"=>$nsdDebetTemp,
												"nsdKreditTemp"=>$nsdKreditTemp,
												"labarugiDebetTemp"=>$labarugiDebetTemp,
												"labarugiKreditTemp"=>$labarugiKreditTemp,
												"neracaDebetTemp"=>$neracaDebetTemp,
												"neracaKreditTemp"=>$neracaKreditTemp
												);
			}
		}
		
		foreach($arrBukuBesar as $row)
		{
			if($row['nama_akun'] == 'Beban Lain-lain')
			{
				$sqlSaldoAkhir = "SELECT * FROM tbt_jurnal_buku_besar WHERE nama_akun = '".$row['nama_akun']."' AND status = '0' ORDER BY id DESC LIMIT 1";
				$arrSaldoAkhir = $this->queryAction($sqlSaldoAkhir,'S');
				$saldoAkhir = $arrSaldoAkhir[0]['saldo_akhir'];
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">Beban Lain-lain</td>';
				$neracasaldoDebetTemp = 0;
				$neracasaldoKreditTemp = 0;
				$penyesuaianDebetTemp = 0;
				$penyesuaianKreditTemp = 0;
				$nsdDebetTemp = 0;
				$nsdKreditTemp = 0;
				$labarugiDebetTemp = 0;
				$labarugiKreditTemp = 0;
				$neracaDebetTemp = 0;
				$neracaKreditTemp = 0;
				//Neraca Saldo
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaSaldoDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracasaldoDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaSaldoKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracasaldoKreditTemp = $saldoAkhir;
				}
				
				//Penyesuaian
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianDebetTemp = 0;
				$tblBody .= '<td align=\"right\"></td>';
				$penyesuaianKreditTemp = 0;
				
				//NSD
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$nsdDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$nsdDebetTemp = $saldoAkhir;
				}
				else
				{
					$nsdKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$nsdKreditTemp = $saldoAkhir;
				}
				
				//Laba Rugi
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$labarugiDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$labarugiDebetTemp = $saldoAkhir;
				}
				else
				{
					$labarugiKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$labarugiKreditTemp = $saldoAkhir;
				}
				
				//Neraca
				if($arrSaldoAkhir[0]['posisi_saldo_akhir'] == '0')
				{
					$neracaDebet += $saldoAkhir;
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$tblBody .= '<td align=\"right\"></td>';
					$neracaDebetTemp = $saldoAkhir;
				}
				else
				{
					$neracaKredit += $saldoAkhir;
					$tblBody .= '<td align=\"right\"></td>';
					$tblBody .= '<td align=\"right\">'.number_format($saldoAkhir,2,".",",").'</td>';
					$neracaKreditTemp = $saldoAkhir;
				}
				
				$tblBody .= '</tr>';
				
				$arrRekapKertasKerja[] = array("namaAkun"=>"Beban Lain-lain",
												"neracasaldoDebetTemp"=>$neracasaldoDebetTemp,
												"neracasaldoKreditTemp"=>$neracasaldoKreditTemp,
												"penyesuaianDebetTemp"=>$penyesuaianDebetTemp,
												"penyesuaianKreditTemp"=>$penyesuaianKreditTemp,
												"nsdDebetTemp"=>$nsdDebetTemp,
												"nsdKreditTemp"=>$nsdKreditTemp,
												"labarugiDebetTemp"=>$labarugiDebetTemp,
												"labarugiKreditTemp"=>$labarugiKreditTemp,
												"neracaDebetTemp"=>$neracaDebetTemp,
												"neracaKreditTemp"=>$neracaKreditTemp
												);
			}
		}
		
		$tblBody .= '<tr>';
		$tblBody .= '<td align=\"center\"><strong>Jumlah</strong></td>';
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
		
		$this->setViewState('arrRekapKertasKerja',$arrRekapKertasKerja);
				
		$this->getPage()->getClientScript()->registerEndScript
					('','
					console.log("'.$tblBody.'");
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					unloadContent();
					');
	}
	
	public function cariBtnClickedBAK2($sender,$param)
	{
		$sqlJurnalUmum = "SELECT * FROM tbt_jurnal_umum WHERE deleted != '1' ";
		$arrJurnalUmum = $this->queryAction($sqlJurnalUmum,'S');
		
		$neracaSaldoDebet = 0;
		$neracaSaldoKredit = 0;
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
		
		/*$kas = BankRecord::finder()->findByPk('8');
		if($kas)
		{
			if($kas->saldo > 0 )
				$kasSaldo = $kas->saldo;
			else
				$kasSaldo = 0;
		}
		else*/
			
		$kasSaldo = 0;
		if($arrJurnalUmum)
		{
			foreach($arrJurnalUmum as $row)
			{
				if($row['id_bank'] == '8' && $row['keterangan'] == 'Kas')
				{
					if($row['jns_transaksi'] == '0')
						$kasSaldo += $row['jumlah_saldo'];
					elseif($row['jns_transaksi'] == '1')
						$kasSaldo -= $row['jumlah_saldo'];
				}
			}	
		}
		$tblBody .= '<tr>';
		$tblBody .= '<td align=\"left\">Kas</td>';
		$tblBody .= '<td align=\"right\">'.number_format($kasSaldo,2,".",",").'</td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '</tr>';
		$neracaSaldoDebet += $kasSaldo;
		
		
		$sqlKasBank = "SELECT SUM(tbm_bank.saldo) AS saldo_bank FROM tbm_bank WHERE tbm_bank.deleted = '0' AND tbm_bank.id != '8' ";
		$arrKasBank = $this->queryAction($sqlKasBank,'S');
		
		/*if($arrKasBank)
		{
			if($arrKasBank[0]['saldo_bank'] > 0 )
				$kasBank = $arrKasBank[0]['saldo_bank'];
			else
				$kasBank = 0;
		}
		else
			$kasBank = 0;*/
		
		$kasBank = 0;
		if($arrJurnalUmum)
		{
			foreach($arrJurnalUmum as $row)
			{
				if($row['id_bank'] != '8' && $row['id_bank'] != '0' && $row['keterangan'] == 'Kas')
				{
					if($row['jns_transaksi'] == '0')
						$kasBank += $row['jumlah_saldo'];
					elseif($row['jns_transaksi'] == '1')
						$kasBank -= $row['jumlah_saldo'];
				}
			}	
		}
		
		$tblBody .= '<tr>';
		$tblBody .= '<td align=\"left\">Kas Di Bank</td>';
		$tblBody .= '<td align=\"right\">'.number_format($kasBank,2,".",",").'</td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '</tr>';
		$neracaSaldoDebet += $kasBank;
		
		$sqlJual= "SELECT SUM(tbt_penerimaan_penjualan.total_penjualan) AS total_penjualan FROM tbt_penerimaan_penjualan WHERE tbt_penerimaan_penjualan.deleted = '0' ";
		$arrJual = $this->queryAction($sqlJual,'S');
		
		if($arrJual)
		{
			if($arrJual[0]['total_penjualan'] > 0 )
				$piutang = $arrJual[0]['total_penjualan'];
			else
				$piutang = 0;
				
			if($piutang > 0)
			{
				$sqlBayarJual= "SELECT SUM(tbt_penerimaan_penjualan_detail.total_pembayaran) AS total_pembayaran FROM tbt_penerimaan_penjualan_detail WHERE tbt_penerimaan_penjualan_detail.deleted = '0' ";
				$arrBayar = $this->queryAction($sqlBayarJual,'S');
				
				if($arrBayar)
				{
					$piutang -= $arrBayar[0]['total_pembayaran'];
				}
			}
		}
		else
			$piutang = 0;
		$tblBody .= '<tr>';
		$tblBody .= '<td align=\"left\">Piutang Dagang</td>';
		$tblBody .= '<td align=\"right\">'.number_format($piutang,2,".",",").'</td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '</tr>';
		$neracaSaldoDebet += $piutang;
		
		$barangDagangan = 0;	
		
		$sqlCpoStok = "SELECT SUM(tbd_stok_barang.stok) AS stok FROM tbd_stok_barang WHERE tbd_stok_barang.deleted = '0' AND tbd_stok_barang.id_barang = '10' ";
		$arrCpoStok = $this->queryAction($sqlCpoStok,'S');
		$stokCpo = $arrCpoStok[0]['stok'];
		
		$sqlCpoHarga = "SELECT tbm_barang_harga.harga FROM tbm_barang_harga WHERE tbm_barang_harga.deleted = '0' AND tbm_barang_harga.id_barang = '10' ORDER BY tbm_barang_harga.id DESC LIMIT 1";
		$arrCpoHarga = $this->queryAction($sqlCpoHarga,'S');
		$hargaCpo = $arrCpoHarga[0]['harga'];
		
		$barangDagangan += ($stokCpo * $hargaCpo);	
		
		$sqlPkStok = "SELECT SUM(tbd_stok_barang.stok) AS stok FROM tbd_stok_barang WHERE tbd_stok_barang.deleted = '0' AND tbd_stok_barang.id_barang = '11' ";
		$arrPkStok = $this->queryAction($sqlPkStok,'S');
		$stokPk = $arrPkStok[0]['stok'];
		
		$sqlPkHarga = "SELECT tbm_barang_harga.harga FROM tbm_barang_harga WHERE tbm_barang_harga.deleted = '0' AND tbm_barang_harga.id_barang = '11' ORDER BY tbm_barang_harga.id DESC LIMIT 1";
		$arrPkHarga = $this->queryAction($sqlPkHarga,'S');
		$hargaPk = $arrPkHarga[0]['harga'];
		
		$barangDagangan += ($stokPk * $hargaPk);	
		
		$tblBody .= '<tr>';
		$tblBody .= '<td align=\"left\">Persediaan Barang Dagangan</td>';
		$tblBody .= '<td align=\"right\">'.number_format($barangDagangan,2,".",",").'</td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '</tr>';
		$neracaSaldoDebet += $barangDagangan;
		
		
		$perlengkapan = 0;		
		
		if($arrJurnalUmum)
		{
			foreach($arrJurnalUmum as $row)
			{
				if($row['keterangan'] == 'Perlengkapan')
				{
					if($row['jns_transaksi'] == '0')
					{
						$perlengkapan += $row['jumlah_saldo'];
					}
					elseif($row['jns_transaksi'] == '1')
					{
						$perlengkapan -= $row['jumlah_saldo'];
					}
				}
			}
		}
		$tblBody .= '<tr>';
		$tblBody .= '<td align=\"left\">Perlengkapan</td>';
		$tblBody .= '<td align=\"right\">'.number_format($perlengkapan,2,".",",").'</td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '</tr>';
		$neracaSaldoDebet += $perlengkapan;
		
		$currentDate = date("Y-m-d");
		$currentYear = intval(date("Y"));
		$currentMonth = intval(date("m"));
		$AktivaTetapList = array();
		$sqlAktivaTetap = "SELECT
							tbm_aktiva_tetap.id,
							tbm_aktiva_tetap.nama,
							tbm_aktiva_tetap.harga_perolehan,
							tbm_aktiva_tetap.jumlah_aktiva
						FROM
							tbm_aktiva_tetap
						WHERE
							tbm_aktiva_tetap.deleted = '0'
						AND tbm_aktiva_tetap.jumlah_aktiva > 0
						AND CURDATE() > tbm_aktiva_tetap.tgl_perolehan
						AND CURDATE() < tbm_aktiva_tetap.tgl_akhir_peggunaan ";		
		$arrAktivaTetap = $this->queryAction($sqlAktivaTetap,'S');
		foreach($arrAktivaTetap as $rowAktivaTetap)
		{
			$jumlah_aktiva = $rowAktivaTetap['jumlah_aktiva'];
			$akumulasiSusut = 0;
			$sqlSusut = "SELECT
							tbd_penyusutan_aktiva.id
						FROM
							tbd_penyusutan_aktiva
						WHERE
							tbd_penyusutan_aktiva.deleted = '0'
						AND tbd_penyusutan_aktiva.id_aktiva = '".$rowAktivaTetap['id']."'
						AND tbd_penyusutan_aktiva.tahun <= ".$currentYear." 
						ORDER BY 
							tbd_penyusutan_aktiva.tahun ASC ";
			$arrSusut = $this->queryAction($sqlSusut,'S');
			foreach($arrSusut as $rowSusut)
			{
				$sqlSusutDetail = "SELECT
										tbd_penyusutan_aktiva_detail.id,
										tbd_penyusutan_aktiva_detail.tahun,
										tbd_penyusutan_aktiva_detail.bulan,
										tbd_penyusutan_aktiva_detail.nilai_penyusutan_bulanan
									FROM
										tbd_penyusutan_aktiva_detail
									WHERE
										tbd_penyusutan_aktiva_detail.deleted = '0'
									AND tbd_penyusutan_aktiva_detail.id_penyusutan = '".$rowSusut['id']."'
									ORDER BY 
										tbd_penyusutan_aktiva_detail.tahun,bulan ";
										
				$arrSusutDetail = $this->queryAction($sqlSusutDetail,'S');
				foreach($arrSusutDetail as $rowSusutDetail)
				{
					$akumulasiSusut += $rowSusutDetail['nilai_penyusutan_bulanan'] * $jumlah_aktiva;
					
					if($rowSusutDetail['tahun'] == $currentYear && $rowSusutDetail['bulan'] == $currentMonth)
						break;
				}
			}
			
			$AktivaTetapList[] = array("nama_aktiva"=>$rowAktivaTetap['nama'],"nilai_aktiva"=>$rowAktivaTetap['harga_perolehan'] * $jumlah_aktiva,"akumulasi_penyusutan"=>$akumulasiSusut);
		}	
		if($AktivaTetapList)
		{
			foreach($AktivaTetapList as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td align=\"left\">'.$row['nama_aktiva'].'</td>';
				$tblBody .= '<td align=\"right\">'.number_format($row['nilai_aktiva'],2,".",",").'</td>';
				$tblBody .= '<td align=\"right\"></td>';
				$tblBody .= '<td align=\"right\"></td>';
				$tblBody .= '<td align=\"right\"></td>';
				$tblBody .= '<td align=\"right\"></td>';
				$tblBody .= '<td align=\"right\"></td>';
				$tblBody .= '<td align=\"right\"></td>';
				$tblBody .= '<td align=\"right\"></td>';
				$tblBody .= '<td align=\"right\"></td>';
				$tblBody .= '<td align=\"right\"></td>';
				$tblBody .= '</tr>';
				$neracaSaldoDebet += $row['nilai_aktiva'];
			}
		}
		
		$jmlUtangDagang = 0;
		$sqlTtlTbsOrder = "SELECT
							SUM(
								tbt_tbs_order_detail.total_tbs_order
							) AS total_tbs_order
								FROM
									tbt_tbs_order_detail
								INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_tbs_order_detail.id_tbs_order
								WHERE
									tbt_tbs_order.status = '1'
									AND tbt_tbs_order.deleted = '0' 
									AND tbt_tbs_order_detail.deleted = '0' ";
		$arrTtlTbsOrder = $this->queryAction($sqlTtlTbsOrder,'S');
		$ttlTbsOrder = $arrTtlTbsOrder[0]['total_tbs_order'];
		if($ttlTbsOrder > 0)
		{
			$sqlBayar = "SELECT
								SUM(
									tbt_pembayaran_tbs.jumlah_pembayaran
								) AS total_pembayaran
							FROM
								tbt_pembayaran_tbs
							INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_pembayaran_tbs.id_tbs_order
							WHERE
							 tbt_pembayaran_tbs.deleted = '0'
							AND tbt_tbs_order.`status` = '1'
							AND tbt_tbs_order.deleted = '0' ";
				$arrttlByrOrder = $this->queryAction($sqlBayar,'S');
				$ttlByrOrder = $arrttlByrOrder[0]['total_pembayaran'];
				$ttlTbsOrder -= $ttlByrOrder;
		}
		$jmlUtangDagang += $ttlTbsOrder;		
		
		$ttlPo = 0;
		$sqlPO ="SELECT
						tbt_purchase_order.id,
						tbt_purchase_order.dp,
						tbt_purchase_order.ppn
					FROM
						tbt_purchase_order
					WHERE
						tbt_purchase_order.`status` = '2' 
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
		
		if($ttlPo > 0)
		{
			$sqlBayar = "SELECT
								SUM(
									tbt_pembayaran_po.total_pembayaran
								) AS total_pembayaran
							FROM
								tbt_pembayaran_po
							INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_pembayaran_po.id_po
							WHERE
								tbt_pembayaran_po.deleted = '0'
							AND tbt_purchase_order.`status` = '2'
							AND tbt_purchase_order.deleted = '0' ";
				$arrttlByrPo = $this->queryAction($sqlBayar,'S');
				$ttlByrPo = $arrttlByrPo[0]['total_pembayaran'];
				$ttlPo -= $ttlByrPo;
		}
		$jmlUtangDagang += $ttlPo;	
		
		$tblBody .= '<tr>';
		$tblBody .= '<td align=\"left\">Utang Usaha</td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\">'.number_format($jmlUtangDagang,2,".",",").'</td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '</tr>';
		$neracaSaldoKredit += $jmlUtangDagang;
		
		$jmlUtangGaji = 0;
		$sqlUtangGaji = "SELECT
					SUM(tbt_rekap_gaji.total_gaji_dibayarkan) AS total_gaji_dibayarkan
				FROM
					tbt_rekap_gaji
				WHERE
					tbt_rekap_gaji.deleted = '0'
					AND tbt_rekap_gaji.status != '2'";
		$arrUtangGaji = $this->queryAction($sqlUtangGaji,'S');
		$jmlUtangGaji += $arrUtangGaji[0]['total_gaji_dibayarkan'];
		
		if($jmlUtangGaji > 0)
		{
			$sqlBayar = "SELECT SUM(tbt_bayar_rekap_gaji.total_gaji_dibayarkan) AS total_gaji_dibayarkan FROM tbt_bayar_rekap_gaji INNER JOIN tbt_rekap_gaji ON tbt_rekap_gaji.id = tbt_bayar_rekap_gaji.id_rekap WHERE tbt_rekap_gaji.status != '2' ";
			$arrBayar = $this->queryAction($sqlBayar,'S');
			$jmlUtangGaji -= $arrBayar[0]['total_gaji_dibayarkan'];
		}
		$tblBody .= '<tr>';
		$tblBody .= '<td align=\"left\">Utang Gaji</td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\">'.number_format($jmlUtangGaji,2,".",",").'</td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '</tr>';
		$neracaSaldoKredit += $jmlUtangGaji;
		
		$sqlModal = "SELECT 
						tbt_modal_transaksi.modal
					FROM 
						tbt_modal_transaksi
					WHERE
						tbt_modal_transaksi.deleted ='0' 
					ORDER BY id DESC
					LIMIT 1 ";
		
		$arrModal = $this->queryAction($sqlModal,'S');
		$tblBody .= '<tr>';
		$tblBody .= '<td align=\"left\">Modal Usaha</td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\">'.number_format($arrModal[0]['modal'],2,".",",").'</td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '</tr>';
		$neracaSaldoKredit += $arrModal[0]['modal'];
		
		$sqlLaba = "SELECT 
						SUM(tbt_laba_rugi.jumlah_transaksi) AS jumlah_transaksi
					FROM 
						tbt_laba_rugi
					WHERE
						tbt_laba_rugi.deleted ='0' 
						AND tbt_laba_rugi.jns_transaksi ='0' 
						AND tbt_laba_rugi.sumber_transaksi !='0' 
						AND MONTH(tbt_laba_rugi.tgl_transaksi) = '$currentMonth' AND YEAR(tbt_laba_rugi.tgl_transaksi) = '$currentYear' ";
		
		$arrLaba = $this->queryAction($sqlLaba,'S');
		$tblBody .= '<tr>';
		$tblBody .= '<td align=\"left\">Pendapatan Usaha Dagang</td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\">'.number_format($arrLaba[0]['jumlah_transaksi'],2,".",",").'</td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '</tr>';
		$neracaSaldoKredit += $arrLaba[0]['jumlah_transaksi'];
		
		$sqlBebanGaji = "SELECT 
						SUM(tbt_laba_rugi.jumlah_transaksi) AS jumlah_transaksi
					FROM 
						tbt_laba_rugi
					WHERE
						tbt_laba_rugi.deleted ='0' 
						AND tbt_laba_rugi.jns_transaksi = '1' 
						AND tbt_laba_rugi.sumber_transaksi = '7' 
						AND MONTH(tbt_laba_rugi.tgl_transaksi) = '$currentMonth' AND YEAR(tbt_laba_rugi.tgl_transaksi) = '$currentYear' ";
		
		$arrBebanGaji = $this->queryAction($sqlBebanGaji,'S');
		$tblBody .= '<tr>';
		$tblBody .= '<td align=\"left\">Beban Gaji</td>';
		$tblBody .= '<td align=\"right\">'.number_format($arrBebanGaji[0]['jumlah_transaksi'],2,".",",").'</td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '</tr>';
		$neracaSaldoDebet += $arrBebanGaji[0]['jumlah_transaksi'];
		
		$sqlBebanLain = "SELECT 
						SUM(tbt_laba_rugi.jumlah_transaksi) AS jumlah_transaksi
					FROM 
						tbt_laba_rugi
					WHERE
						tbt_laba_rugi.deleted ='0' 
						AND tbt_laba_rugi.jns_transaksi = '1' 
						AND tbt_laba_rugi.sumber_transaksi != '7' 
						AND MONTH(tbt_laba_rugi.tgl_transaksi) = '$currentMonth' AND YEAR(tbt_laba_rugi.tgl_transaksi) = '$currentYear' ";
		
		$arrBebanLain = $this->queryAction($sqlBebanLain,'S');
		$tblBody .= '<tr>';
		$tblBody .= '<td align=\"left\">Beban Umum Lain-lain</td>';
		$tblBody .= '<td align=\"right\">'.number_format($arrBebanLain[0]['jumlah_transaksi'],2,".",",").'</td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '</tr>';
		$neracaSaldoDebet += $arrBebanLain[0]['jumlah_transaksi'];
		
		$tblBody .= '<tr>';
		$tblBody .= '<td align=\"left\"><strong>Total Saldo</strong></td>';
		$tblBody .= '<td align=\"right\"><strong>'.number_format($neracaSaldoDebet,2,".",",").'</strong></td>';
		$tblBody .= '<td align=\"right\"><strong>'.number_format($neracaSaldoKredit,2,".",",").'</strong></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '<td align=\"right\"></td>';
		$tblBody .= '</tr>';
		
		$this->getPage()->getClientScript()->registerEndScript
					('','
					console.log("'.$tblBody.'");
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					unloadContent();
					');
	}
	
	public function cariBtnClickedBak($sender,$param)
	{
		$arrRekapNeraca = array();
		$tahun = date("Y");
		$bulan = date("m");
		$jmlAktivaLancar = 0;
		$jmlAktivaTetap = 0;
		$jmlAktiva = 0;
		$kas = BankRecord::finder()->findByPk('8');
		if($kas)
		{
			if($kas->saldo > 0 )
				$kasSaldo = $kas->saldo;
			else
				$kasSaldo = 0;
		}
		else
			$kasSaldo = 0;
			
		$jmlAktivaLancar += $kasSaldo;	
		
		$sqlKasBank = "SELECT SUM(tbm_bank.saldo) AS saldo_bank FROM tbm_bank WHERE tbm_bank.deleted = '0' AND tbm_bank.id != '8' ";
		$arrKasBank = $this->queryAction($sqlKasBank,'S');
		
		if($arrKasBank)
		{
			if($arrKasBank[0]['saldo_bank'] > 0 )
				$kasBank = $arrKasBank[0]['saldo_bank'];
			else
				$kasBank = 0;
		}
		else
			$kasBank = 0;
		
		$jmlAktivaLancar += $kasBank;	
		
		$sqlJual= "SELECT SUM(tbt_penerimaan_penjualan.total_penjualan) AS total_penjualan FROM tbt_penerimaan_penjualan WHERE tbt_penerimaan_penjualan.deleted = '0' ";
		$arrJual = $this->queryAction($sqlJual,'S');
		
		if($arrJual)
		{
			if($arrJual[0]['total_penjualan'] > 0 )
				$piutang = $arrJual[0]['total_penjualan'];
			else
				$piutang = 0;
				
			if($piutang > 0)
			{
				$sqlBayarJual= "SELECT SUM(tbt_penerimaan_penjualan_detail.total_pembayaran) AS total_pembayaran FROM tbt_penerimaan_penjualan_detail WHERE tbt_penerimaan_penjualan_detail.deleted = '0' ";
				$arrBayar = $this->queryAction($sqlBayarJual,'S');
				
				if($arrBayar)
				{
					$piutang -= $arrBayar[0]['total_pembayaran'];
				}
			}
		}
		else
			$piutang = 0;
		
		$jmlAktivaLancar += $piutang;	
		
		$barangDagangan = 0;	
		
		$sqlCpoStok = "SELECT SUM(tbd_stok_barang.stok) AS stok FROM tbd_stok_barang WHERE tbd_stok_barang.deleted = '0' AND tbd_stok_barang.id_barang = '10' ";
		$arrCpoStok = $this->queryAction($sqlCpoStok,'S');
		$stokCpo = $arrCpoStok[0]['stok'];
		
		$sqlCpoHarga = "SELECT tbm_barang_harga.harga FROM tbm_barang_harga WHERE tbm_barang_harga.deleted = '0' AND tbm_barang_harga.id_barang = '10' ORDER BY tbm_barang_harga.id DESC LIMIT 1";
		$arrCpoHarga = $this->queryAction($sqlCpoHarga,'S');
		$hargaCpo = $arrCpoHarga[0]['harga'];
		
		$barangDagangan += ($stokCpo * $hargaCpo);	
		
		$sqlPkStok = "SELECT SUM(tbd_stok_barang.stok) AS stok FROM tbd_stok_barang WHERE tbd_stok_barang.deleted = '0' AND tbd_stok_barang.id_barang = '11' ";
		$arrPkStok = $this->queryAction($sqlPkStok,'S');
		$stokPk = $arrPkStok[0]['stok'];
		
		$sqlPkHarga = "SELECT tbm_barang_harga.harga FROM tbm_barang_harga WHERE tbm_barang_harga.deleted = '0' AND tbm_barang_harga.id_barang = '11' ORDER BY tbm_barang_harga.id DESC LIMIT 1";
		$arrPkHarga = $this->queryAction($sqlPkHarga,'S');
		$hargaPk = $arrPkHarga[0]['harga'];
		
		$barangDagangan += ($stokPk * $hargaPk);	
		
		$jmlAktivaLancar += $barangDagangan;	
		
		$jmlAktiva += $jmlAktivaLancar;
		
		$jmlUtangDagang = 0;
		$sqlTtlTbsOrder = "SELECT
							SUM(
								tbt_tbs_order_detail.total_tbs_order
							) AS total_tbs_order
								FROM
									tbt_tbs_order_detail
								INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_tbs_order_detail.id_tbs_order
								WHERE
									tbt_tbs_order.status = '1'
									AND tbt_tbs_order.deleted = '0' 
									AND tbt_tbs_order_detail.deleted = '0' ";
		$arrTtlTbsOrder = $this->queryAction($sqlTtlTbsOrder,'S');
		$ttlTbsOrder = $arrTtlTbsOrder[0]['total_tbs_order'];
		if($ttlTbsOrder > 0)
		{
			$sqlBayar = "SELECT
								SUM(
									tbt_pembayaran_tbs.jumlah_pembayaran
								) AS total_pembayaran
							FROM
								tbt_pembayaran_tbs
							INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_pembayaran_tbs.id_tbs_order
							WHERE
							 tbt_pembayaran_tbs.deleted = '0'
							AND tbt_tbs_order.`status` = '1'
							AND tbt_tbs_order.deleted = '0' ";
				$arrttlByrOrder = $this->queryAction($sqlBayar,'S');
				$ttlByrOrder = $arrttlByrOrder[0]['total_pembayaran'];
				$ttlTbsOrder -= $ttlByrOrder;
		}
		$jmlUtangDagang += $ttlTbsOrder;		
		
		$ttlPo = 0;
		$sqlPO ="SELECT
						tbt_purchase_order.id,
						tbt_purchase_order.dp,
						tbt_purchase_order.ppn
					FROM
						tbt_purchase_order
					WHERE
						tbt_purchase_order.`status` = '2' 
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
		
		if($ttlPo > 0)
		{
			$sqlBayar = "SELECT
								SUM(
									tbt_pembayaran_po.total_pembayaran
								) AS total_pembayaran
							FROM
								tbt_pembayaran_po
							INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_pembayaran_po.id_po
							WHERE
								tbt_pembayaran_po.deleted = '0'
							AND tbt_purchase_order.`status` = '2'
							AND tbt_purchase_order.deleted = '0' ";
				$arrttlByrPo = $this->queryAction($sqlBayar,'S');
				$ttlByrPo = $arrttlByrPo[0]['total_pembayaran'];
				$ttlPo -= $ttlByrPo;
		}
		$jmlUtangDagang += $ttlPo;	
		
		$jmlUtangGaji = 0;
		$sqlUtangGaji = "SELECT
					SUM(tbt_rekap_gaji.total_gaji_dibayarkan) AS total_gaji_dibayarkan
				FROM
					tbt_rekap_gaji
				WHERE
					tbt_rekap_gaji.deleted = '0'
					AND tbt_rekap_gaji.status != '2'";
		$arrUtangGaji = $this->queryAction($sqlUtangGaji,'S');
		$jmlUtangGaji += $arrUtangGaji[0]['total_gaji_dibayarkan'];
		
		if($jmlUtangGaji > 0)
		{
			$sqlBayar = "SELECT SUM(tbt_bayar_rekap_gaji.total_gaji_dibayarkan) AS total_gaji_dibayarkan FROM tbt_bayar_rekap_gaji INNER JOIN tbt_rekap_gaji ON tbt_rekap_gaji.id = tbt_bayar_rekap_gaji.id_rekap WHERE tbt_rekap_gaji.status != '2' ";
			$arrBayar = $this->queryAction($sqlBayar,'S');
			$jmlUtangGaji -= $arrBayar[0]['total_gaji_dibayarkan'];
		}
		
		$jmlUtang =	$jmlUtangDagang + $jmlUtangGaji;	
		
		$currentDate = date("Y-m-d");
		$currentYear = intval(date("Y"));
		$currentMonth = intval(date("m"));
		$AktivaTetapList = array();
		$sqlAktivaTetap = "SELECT
							tbm_aktiva_tetap.id,
							tbm_aktiva_tetap.nama,
							tbm_aktiva_tetap.harga_perolehan,
							tbm_aktiva_tetap.jumlah_aktiva
						FROM
							tbm_aktiva_tetap
						WHERE
							tbm_aktiva_tetap.deleted = '0'
						AND tbm_aktiva_tetap.jumlah_aktiva > 0
						AND CURDATE() > tbm_aktiva_tetap.tgl_perolehan
						AND CURDATE() < tbm_aktiva_tetap.tgl_akhir_peggunaan ";		
		$arrAktivaTetap = $this->queryAction($sqlAktivaTetap,'S');
		foreach($arrAktivaTetap as $rowAktivaTetap)
		{
			$jumlah_aktiva = $rowAktivaTetap['jumlah_aktiva'];
			$akumulasiSusut = 0;
			$sqlSusut = "SELECT
							tbd_penyusutan_aktiva.id
						FROM
							tbd_penyusutan_aktiva
						WHERE
							tbd_penyusutan_aktiva.deleted = '0'
						AND tbd_penyusutan_aktiva.id_aktiva = '".$rowAktivaTetap['id']."'
						AND tbd_penyusutan_aktiva.tahun <= ".$currentYear." 
						ORDER BY 
							tbd_penyusutan_aktiva.tahun ASC ";
			$arrSusut = $this->queryAction($sqlSusut,'S');
			foreach($arrSusut as $rowSusut)
			{
				$sqlSusutDetail = "SELECT
										tbd_penyusutan_aktiva_detail.id,
										tbd_penyusutan_aktiva_detail.tahun,
										tbd_penyusutan_aktiva_detail.bulan,
										tbd_penyusutan_aktiva_detail.nilai_penyusutan_bulanan
									FROM
										tbd_penyusutan_aktiva_detail
									WHERE
										tbd_penyusutan_aktiva_detail.deleted = '0'
									AND tbd_penyusutan_aktiva_detail.id_penyusutan = '".$rowSusut['id']."'
									ORDER BY 
										tbd_penyusutan_aktiva_detail.tahun,bulan ";
										
				$arrSusutDetail = $this->queryAction($sqlSusutDetail,'S');
				foreach($arrSusutDetail as $rowSusutDetail)
				{
					$akumulasiSusut += $rowSusutDetail['nilai_penyusutan_bulanan'] * $jumlah_aktiva;
					
					if($rowSusutDetail['tahun'] == $currentYear && $rowSusutDetail['bulan'] == $currentMonth)
						break;
				}
			}
			
			$AktivaTetapList[] = array("nama_aktiva"=>$rowAktivaTetap['nama'],"nilai_aktiva"=>$rowAktivaTetap['harga_perolehan'] * $jumlah_aktiva,"akumulasi_penyusutan"=>$akumulasiSusut);
		}	
		
		$sqlPenyesuaian = "SELECT 
					tbt_penyesuaian_detail.id,
					tbt_penyesuaian_detail.kelompok_akun,
					tbt_penyesuaian_detail.nama_akun,
					tbt_penyesuaian_detail.nilai_akun
				FROM 
					tbt_penyesuaian_detail
					INNER JOIN tbt_penyesuaian ON tbt_penyesuaian.id = tbt_penyesuaian_detail.id_penyesuaian
				WHERE 
					tbt_penyesuaian.deleted = '0' 
					AND tbt_penyesuaian_detail.deleted = '0'
					AND tbt_penyesuaian.bulan = '".$bulan."'
					AND tbt_penyesuaian.tahun = '".$tahun."'
				ORDER BY 
					tbt_penyesuaian_detail.id ASC ";
		$arrPenyesuaian = $this->queryAction($sqlPenyesuaian,'S');
		
		$tblBody = '';
		$tblBody .= '<tr>';
		$tblBody .= '<td colspan=\"5\"><strong>Aktiva</strong></td>';
		$tblBody .= '</tr>';
		$tblBody .= '<tr>';
		$tblBody .= '<td colspan=\"5\"><strong>Aktiva Lancar</strong></td>';
		$tblBody .= '</tr>';	
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\">Kas</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($kasSaldo,2,".",",").'</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '</tr>';
		$arrRekapNeraca[] = array("kelompok_neraca"=>"1","nama_akun"=>"Kas","nilai_akun"=>$kasSaldo);
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\">Kas di Bank</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($kasBank,2,".",",").'</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '</tr>';
		$arrRekapNeraca[] = array("kelompok_neraca"=>"1","nama_akun"=>"Kas di Bank","nilai_akun"=>$kasBank);
		
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\">Piutang Dagang </td>';
		$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($piutang,2,".",",").'</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '</tr>';	
		$arrRekapNeraca[] = array("kelompok_neraca"=>"1","nama_akun"=>"Piutang Dagang","nilai_akun"=>$piutang);
		
		if($arrPenyesuaian)
		{
			foreach($arrPenyesuaian as $rowPenyesuaian)
			{
				if($rowPenyesuaian['kelompok_akun'] == '2' && $rowPenyesuaian['nilai_akun'] > 0)
				{
					$tblBody .= '<tr>';
					$tblBody .= '<td width=\"5%\"></td>';
					$tblBody .= '<td width=\"40%\">Piutang '.$rowPenyesuaian['nama_akun'].' </td>';
					$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($rowPenyesuaian['nilai_akun'],2,".",",").'</td>';
					$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
					$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
					$tblBody .= '</tr>';	
					$arrRekapNeraca[] = array("kelompok_neraca"=>"1","nama_akun"=>"Piutang ".$rowPenyesuaian['nama_akun'],"nilai_akun"=>$rowPenyesuaian['nilai_akun']);
					$jmlAktivaLancar += $rowPenyesuaian['nilai_akun'];
					$jmlAktiva += $rowPenyesuaian['nilai_akun'];
				}
			}
			
		}
		
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\">Persediaan Barang Dagangan </td>';
		$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($barangDagangan,2,".",",").'</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '</tr>';	
		$arrRekapNeraca[] = array("kelompok_neraca"=>"1","nama_akun"=>"Persediaan Barang Dagangan","nilai_akun"=>$barangDagangan);
		
		if($arrPenyesuaian)
		{
			$nilaiAkun = 0;
			foreach($arrPenyesuaian as $rowPenyesuaian)
			{
				if($rowPenyesuaian['kelompok_akun'] == '0' && $rowPenyesuaian['jenis_saldo'] == '0')
				{
					$nilaiAkun += $rowPenyesuaian['nilai_akun'];
					$jmlAktivaLancar += $rowPenyesuaian['nilai_akun'];
					$jmlAktiva += $rowPenyesuaian['nilai_akun'];
				}
			}
			
			if($nilaiAkun > 0)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td width=\"5%\"></td>';
				$tblBody .= '<td width=\"40%\">Pendapatan Usaha Lain-lain </td>';
				$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($nilaiAkun,2,".",",").'</td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '</tr>';	
				$arrRekapNeraca[] = array("kelompok_neraca"=>"1","nama_akun"=>"Pendapatan Usaha Lain-lain","nilai_akun"=>$nilaiAkun);
			}
		}
		
		if($arrPenyesuaian)
		{
			$bebanDibayarDimuka = 0;
			foreach($arrPenyesuaian as $rowPenyesuaian)
			{
				if($rowPenyesuaian['kelompok_akun'] == '5' && $rowPenyesuaian['nilai_akun'] > 0)
				{
					$bebanDibayarDimuka += $rowPenyesuaian['nilai_akun'];
					$jmlAktivaLancar += $rowPenyesuaian['nilai_akun'];
					$jmlAktiva += $rowPenyesuaian['nilai_akun'];
				}
			}
			
			if($bebanDibayarDimuka > 0)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td width=\"5%\"></td>';
				$tblBody .= '<td width=\"40%\">Beban Dibayar Dimuka</td>';
				$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($bebanDibayarDimuka,2,".",",").'</td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '</tr>';	
				$arrRekapNeraca[] = array("kelompok_neraca"=>"1","nama_akun"=>"Beban Dibayar Dimuka","nilai_akun"=>$bebanDibayarDimuka);
			}
			
		}
		
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\" align=\"right\">Jumlah Aktiva Lancar</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"><strong>'.number_format($jmlAktivaLancar,2,".",",").'</strong></td>';
		$tblBody .= '</tr>';
		$tblBody .= '<tr>';
		$tblBody .= '<td colspan=\"5\"><strong>Aktiva Tetap</strong></td>';
		$tblBody .= '</tr>';	
		
		foreach($AktivaTetapList as $rowAktivaTetap)
		{
			$tblBody .= '<tr>';
			$tblBody .= '<td width=\"5%\"></td>';
			$tblBody .= '<td width=\"40%\">'.$rowAktivaTetap['nama_aktiva'].' </td>';
			$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($rowAktivaTetap['nilai_aktiva'],2,".",",").'</td>';
			$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
			$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
			$tblBody .= '</tr>';
			$arrRekapNeraca[] = array("kelompok_neraca"=>"2","nama_akun"=>$rowAktivaTetap['nama_aktiva'],"nilai_akun"=>$rowAktivaTetap['nilai_aktiva']);
			$tblBody .= '<tr>';
			$tblBody .= '<td width=\"5%\"></td>';
			$tblBody .= '<td width=\"40%\">Akumulasi Penyusutan '.ucwords($rowAktivaTetap['nama_aktiva']).' </td>';
			$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($rowAktivaTetap['akumulasi_penyusutan'],2,".",",").'</td>';
			$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
			$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
			$tblBody .= '</tr>';
			$arrRekapNeraca[] = array("kelompok_neraca"=>"3","nama_akun"=>"Akumulasi Penyusutan ".ucwords($rowAktivaTetap['nama_aktiva']),"nilai_akun"=>$rowAktivaTetap['akumulasi_penyusutan']);
			$tblBody .= '<tr>';
			$tblBody .= '<td width=\"5%\"></td>';
			$tblBody .= '<td width=\"40%\"></td>';
			$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
			$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($rowAktivaTetap['nilai_aktiva']-$rowAktivaTetap['akumulasi_penyusutan'],2,".",",").'</td>';
			$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
			$tblBody .= '</tr>';
			
			$jmlAktivaTetap += ($rowAktivaTetap['nilai_aktiva']-$rowAktivaTetap['akumulasi_penyusutan']);
			
		
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
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\">Utang Dagang</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($jmlUtangDagang,2,".",",").'</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '</tr>';
		$arrRekapNeraca[] = array("kelompok_neraca"=>"4","nama_akun"=>"Utang Dagang","nilai_akun"=>$jmlUtangDagang);
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\">Utang Gaji</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($jmlUtangGaji,2,".",",").'</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '</tr>';
		$arrRekapNeraca[] = array("kelompok_neraca"=>"4","nama_akun"=>"Utang Gaji","nilai_akun"=>$jmlUtangGaji);
		
		if($arrPenyesuaian)
		{
			$nilaiAkun = 0;
			foreach($arrPenyesuaian as $rowPenyesuaian)
			{
				if($rowPenyesuaian['kelompok_akun'] == '0' && $rowPenyesuaian['jenis_saldo'] == '1')
				{
					$nilaiAkun += $rowPenyesuaian['nilai_akun'];
				}
			}
			
			if($nilaiAkun > 0)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td width=\"5%\"></td>';
				$tblBody .= '<td width=\"40%\">Beban Kas Lain-lain </td>';
				$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($nilaiAkun,2,".",",").'</td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '</tr>';	
				$arrRekapNeraca[] = array("kelompok_neraca"=>"4","nama_akun"=>"Beban Kas Lain-lain","nilai_akun"=>$nilaiAkun);
				$jmlUtang += $nilaiAkun;
			}
		}
		
		if($arrPenyesuaian)
		{
			$nilaiAkun = 0;
			foreach($arrPenyesuaian as $rowPenyesuaian)
			{
				if($rowPenyesuaian['kelompok_akun'] == '1')
				{
					$nilaiAkun += $rowPenyesuaian['nilai_akun'];
				}
			}
			
			if($nilaiAkun > 0)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td width=\"5%\"></td>';
				$tblBody .= '<td width=\"40%\">Beban Persediaan Barang Dagangan </td>';
				$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($nilaiAkun,2,".",",").'</td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '</tr>';	
				$arrRekapNeraca[] = array("kelompok_neraca"=>"4","nama_akun"=>"Beban Persediaan Barang Dagangan","nilai_akun"=>$nilaiAkun);
				$jmlUtang += $nilaiAkun;
			}
		}
		
		if($arrPenyesuaian)
		{
			$hutangHarusDibayar = 0;
			$gajiHarusDibayar = 0;
			foreach($arrPenyesuaian as $rowPenyesuaian)
			{
				if($rowPenyesuaian['kelompok_akun'] == '3' && $rowPenyesuaian['nilai_akun'] > 0)
				{
					$hutangHarusDibayar += $rowPenyesuaian['nilai_akun'];
					$jmlUtang += $rowPenyesuaian['nilai_akun'];
				}
				
				if($rowPenyesuaian['kelompok_akun'] == '6' && $rowPenyesuaian['nilai_akun'] > 0)
				{
					$gajiHarusDibayar += $rowPenyesuaian['nilai_akun'];
					$jmlUtang += $rowPenyesuaian['nilai_akun'];
				}
			}
			
			if($hutangHarusDibayar > 0)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td width=\"5%\"></td>';
				$tblBody .= '<td width=\"40%\">Hutang Yang Masih Harus Dibayar</td>';
				$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($hutangHarusDibayar,2,".",",").'</td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '</tr>';
				$arrRekapNeraca[] = array("kelompok_neraca"=>"4","nama_akun"=>"Hutang Yang Masih Harus Dibayar","nilai_akun"=>$hutangHarusDibayar);
			}
			
			if($gajiHarusDibayar > 0)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td width=\"5%\"></td>';
				$tblBody .= '<td width=\"40%\">Gaji Yang Masih Harus Dibayar</td>';
				$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($gajiHarusDibayar,2,".",",").'</td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
				$tblBody .= '</tr>';
				$arrRekapNeraca[] = array("kelompok_neraca"=>"4","nama_akun"=>"Gaji Yang Masih Harus Dibayar","nilai_akun"=>$gajiHarusDibayar);
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
		
		$this->setViewState('arrRekapNeraca',$arrRekapNeraca);
		
		$this->getPage()->getClientScript()->registerEndScript
					('','
					console.log("'.$tblBody.'");
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					unloadContent();
					');
		
	}
	
	public function kelompokChanged()
	{
		if($this->DDKelompokPenyesuaian->SelectedValue == '0')
		{
			$this->DDJnsSaldo->Enabled = true;
			$this->DDAsalSaldo->Enabled = true;
			$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery(".saldoPanel1").show();
						jQuery(".saldoPanel2").show();
						');	
		}
		else
		{
			$this->DDJnsSaldo->Enabled = false;
			if($this->DDKelompokPenyesuaian->SelectedValue == '4')
			{
				$this->DDAsalSaldo->Enabled = true;
				$this->getPage()->getClientScript()->registerEndScript
							('','
							jQuery(".saldoPanel1").hide();
							jQuery(".saldoPanel2").show();
							');	
			}
			else
			{
				$this->DDAsalSaldo->Enabled = false;
				$this->getPage()->getClientScript()->registerEndScript
							('','
							jQuery(".saldoPanel1").hide();
							jQuery(".saldoPanel2").hide();
							');	
			}
		}
		
	}
	
	public function BindGridPenyesuaian()
	{
		$bulan = date("m");
		$tahun = date("Y");
		
		$sql = "SELECT 
					tbt_penyesuaian_detail.id,
					tbt_penyesuaian_detail.kelompok_akun,
					tbt_penyesuaian_detail.nama_akun,
					tbt_penyesuaian_detail.nilai_akun
				FROM 
					tbt_penyesuaian_detail
					INNER JOIN tbt_penyesuaian ON tbt_penyesuaian.id = tbt_penyesuaian_detail.id_penyesuaian
				WHERE 
					tbt_penyesuaian.deleted = '0' 
					AND tbt_penyesuaian_detail.deleted = '0'
					AND tbt_penyesuaian.bulan = '".$bulan."'
					AND tbt_penyesuaian.tahun = '".$tahun."'
				ORDER BY 
					tbt_penyesuaian_detail.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
				if($row['kelompok_akun'] == '0')
					$kelompokAkun = "Penyesuaian Saldo Kas";
				elseif($row['kelompok_akun'] == '1')
					$kelompokAkun = "Pemakaian Perlengkapan";
				elseif($row['kelompok_akun'] == '2')
					$kelompokAkun = "Piutang Yang Masih Harus Diterima";
				elseif($row['kelompok_akun'] == '3')
					$kelompokAkun = "Hutang Yang Masih Harus Dibayar";
				elseif($row['kelompok_akun'] == '4')
					$kelompokAkun = "Pendapatan Diterima Dimuka";
				elseif($row['kelompok_akun'] == '5')
					$kelompokAkun = "Beban Dibayar Dimuka";
				elseif($row['kelompok_akun'] == '6')
					$kelompokAkun = "Gaji Yang Masih Harus Dibayar";
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$kelompokAkun.'</td>';
				$tblBody .= '<td>'.$row['nama_akun'].'</td>';
				$tblBody .= '<td>'.number_format($row['nilai_akun'],2,".",",").'</td>';
				$tblBody .= '<td>';
				$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
				$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';	
				$tblBody .=	'</td>';			
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = '';
		}
		
		return 	$tblBody;
	}
	
	public function editClicked($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$this->idPenyesuaian->Value = $id;
		$PenyesuaianDetailRecord = PenyesuaianDetailRecord::finder()->findByPk($id);
		$this->DDKelompokPenyesuaian->SelectedValue = $PenyesuaianDetailRecord->kelompok_akun;
		if($PenyesuaianDetailRecord->kelompok_akun == '0')
		{
			$this->DDJnsSaldo->SelectedValue = $PenyesuaianDetailRecord->jenis_saldo;
			$this->DDAsalSaldo->SelectedValue = $PenyesuaianDetailRecord->asal_saldo;
			$this->DDJnsSaldo->Enabled = true;
			$this->DDAsalSaldo->Enabled = true;
		}
		elseif($PenyesuaianDetailRecord->kelompok_akun == '4')
		{
			$this->DDJnsSaldo->SelectedValue = 'empty';
			$this->DDAsalSaldo->SelectedValue = $PenyesuaianDetailRecord->asal_saldo;
			$this->DDJnsSaldo->Enabled = false;
			$this->DDAsalSaldo->Enabled = true;
		}
		else
		{
			$this->DDJnsSaldo->SelectedValue = 'empty';
			$this->DDAsalSaldo->SelectedValue = 'empty';
			$this->DDJnsSaldo->Enabled = false;
			$this->DDAsalSaldo->Enabled = false;
		}
		
		$this->nama_akun->Text = $PenyesuaianDetailRecord->nama_akun;
		$this->nilai_akun->Text = $PenyesuaianDetailRecord->nilai_akun;
		$this->keterangan->Text = $PenyesuaianDetailRecord->keterangan;
		
		if($PenyesuaianDetailRecord->kelompok_akun == '0')
		{
			$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery(".saldoPanel1").show();
						jQuery(".saldoPanel2").show();
						');	
		}
		elseif($PenyesuaianDetailRecord->kelompok_akun == '4')
		{
			$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery(".saldoPanel1").hide();
						jQuery(".saldoPanel2").show();
						');	
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery(".saldoPanel1").hide();
						jQuery(".saldoPanel2").hide();
						');	
		}
	}
	
	public function deleteClicked($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$PenyesuaianDetailRecord = PenyesuaianDetailRecord::finder()->findByPk($id);
		$PenyesuaianDetailRecord->deleted = '1';
		$PenyesuaianDetailRecord->save();
	/*	if($PenyesuaianDetailRecord->kelompok_akun == '0')
		{
			$BankRecord = BankRecord::finder()->findByPk($PenyesuaianDetailRecord->asal_saldo);
			
			if($PenyesuaianDetailRecord->jenis_saldo == '0')
			{
				$BankRecord->saldo -= $PenyesuaianDetailRecord->nilai_akun;
			}
			else
			{
				$BankRecord->saldo += $PenyesuaianDetailRecord->nilai_akun;
			}
			
			$BankRecord->save();
		}
		elseif($PenyesuaianDetailRecord->kelompok_akun == '4')
		{
			$BankRecord = BankRecord::finder()->findByPk($PenyesuaianDetailRecord->asal_saldo);
			$BankRecord->saldo -= $PenyesuaianDetailRecord->nilai_akun;
			$BankRecord->save();
		}*/
		
		$sql = "UPDATE tbt_jurnal_penyesuaian SET deleted = '1' WHERE tbt_jurnal_penyesuaian.id_penyesuaian = '".$id."' ";
		$this->queryAction($sql,'C');
		
		$tblBody = $this->BindGridPenyesuaian();
		$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#tablePenyesuaian").dataTable().fnDestroy();
						jQuery("#tablePenyesuaian tbody").empty();
						jQuery("#tablePenyesuaian tbody").append("'.$tblBody.'");
						BindGridPenyesuaian();');	
	}
	
	public function tambahBtnClicked()
	{
		$bulan = date("m");
		$tahun = date("Y");
		$PenyesuaianRecord = PenyesuaianRecord::finder()->find('bulan = ? AND tahun = ? AND deleted = ?',$bulan,$tahun,'0');
		if(!$PenyesuaianRecord)
		{
			$PenyesuaianRecord  = new PenyesuaianRecord(); 
			$PenyesuaianRecord->bulan = $bulan ;
			$PenyesuaianRecord->tahun = $tahun;
			$PenyesuaianRecord->status = '0';
			$PenyesuaianRecord->save();
		}
			
		if($this->idPenyesuaian->Value != '')
		{
			$PenyesuaianDetailRecord = PenyesuaianDetailRecord::finder()->findByPk($this->idPenyesuaian->Value);
			$prevNilaiAkun = $PenyesuaianDetailRecord->nilai_akun;
		}
		else
		{
			$PenyesuaianDetailRecord = new PenyesuaianDetailRecord();
			$PenyesuaianDetailRecord->id_penyesuaian = $PenyesuaianRecord->id;
			$prevNilaiAkun = 0;
		}
			
		$PenyesuaianDetailRecord->kelompok_akun = $this->DDKelompokPenyesuaian->SelectedValue;
		if($this->DDKelompokPenyesuaian->SelectedValue == '0')
		{
			$PenyesuaianDetailRecord->jenis_saldo = $this->DDJnsSaldo->SelectedValue;
			$PenyesuaianDetailRecord->asal_saldo = $this->DDAsalSaldo->SelectedValue;
		}
		elseif($this->DDKelompokPenyesuaian->SelectedValue == '4')
		{
			$PenyesuaianDetailRecord->asal_saldo = $this->DDAsalSaldo->SelectedValue;
		}
		
		$PenyesuaianDetailRecord->nama_akun = ucwords($this->nama_akun->Text);
		$PenyesuaianDetailRecord->nilai_akun = str_replace(",","",$this->nilai_akun->Text);
		$PenyesuaianDetailRecord->keterangan = $this->keterangan->Text;
		$PenyesuaianDetailRecord->save();
		
		if($this->DDKelompokPenyesuaian->SelectedValue == '0')
		{
			$BankRecord = BankRecord::finder()->findByPk($PenyesuaianDetailRecord->asal_saldo);
			if($this->DDJnsSaldo->SelectedValue == '0')
			{
				$debet = "Kas";
				$kredit = $PenyesuaianDetailRecord->nama_akun;
				
				/*if($this->idPenyesuaian->Value != '')
					$BankRecord->saldo = ($BankRecord->saldo - $prevNilaiAkun) + $PenyesuaianDetailRecord->nilai_akun;
				else
					$BankRecord->saldo += $PenyesuaianDetailRecord->nilai_akun;*/
			}
			else
			{
				$debet = $PenyesuaianDetailRecord->nama_akun;
				$kredit = "Kas";
				
				/*if($this->idPenyesuaian->Value != '')
					$BankRecord->saldo = ($BankRecord->saldo + $prevNilaiAkun) - $PenyesuaianDetailRecord->nilai_akun;
				else
					$BankRecord->saldo -= $PenyesuaianDetailRecord->nilai_akun;*/
			}
			//$BankRecord->save();
		}
		elseif($this->DDKelompokPenyesuaian->SelectedValue == '1')
		{
			$debet = "Beban Persediaan Barang Dagangan";
			$kredit = "Persediaan Barang Dagangan";
		}	
		elseif($this->DDKelompokPenyesuaian->SelectedValue == '2')
		{
			$debet = "Piutang ".$PenyesuaianDetailRecord->nama_akun;
			$kredit = "Pendapatan ".$PenyesuaianDetailRecord->nama_akun;
		}	
		elseif($this->DDKelompokPenyesuaian->SelectedValue == '3')
		{
			$debet = "Beban ".$PenyesuaianDetailRecord->nama_akun;
			$kredit = "Hutang ".$PenyesuaianDetailRecord->nama_akun;
		}	
		elseif($this->DDKelompokPenyesuaian->SelectedValue == '4')
		{
			$debet = $PenyesuaianDetailRecord->nama_akun." Diterima Dimuka";
			$kredit = "Pendapatan ".$PenyesuaianDetailRecord->nama_akun;
			
			/*$BankRecord = BankRecord::finder()->findByPk($PenyesuaianDetailRecord->asal_saldo);
			
			if($this->idPenyesuaian->Value != '')
				$BankRecord->saldo = ($BankRecord->saldo - $prevNilaiAkun) + $PenyesuaianDetailRecord->nilai_akun;
			else
				$BankRecord->saldo += $PenyesuaianDetailRecord->nilai_akun;*/
					
			//$BankRecord->save();
			
		}	
		elseif($this->DDKelompokPenyesuaian->SelectedValue == '5')
		{
			$debet = "Beban ".$PenyesuaianDetailRecord->nama_akun;
			$kredit = $PenyesuaianDetailRecord->nama_akun." Dibayar Dimuka";
		}	
		elseif($this->DDKelompokPenyesuaian->SelectedValue == '6')
		{
			$debet = "Beban ".$PenyesuaianDetailRecord->nama_akun;
			$kredit = "Hutang ".$PenyesuaianDetailRecord->nama_akun;
		}	
		
		$JurnalPenyesuaianRecord = JurnalPenyesuaianRecord::finder()->find('id_penyesuaian = ? AND jns_transaksi = ? AND deleted = ?',$PenyesuaianDetailRecord->id,'0','0');	
		if(!$JurnalPenyesuaianRecord)
		{
			$JurnalPenyesuaianRecord = new JurnalPenyesuaianRecord();
			$JurnalPenyesuaianRecord->id_penyesuaian = $PenyesuaianDetailRecord->id;
		}
		
		$JurnalPenyesuaianRecord->jns_transaksi = '0';
		$JurnalPenyesuaianRecord->tgl_transaksi = date("Y-m-d");
		$JurnalPenyesuaianRecord->wkt_transaksi = date("G:i:s");
		$JurnalPenyesuaianRecord->keterangan = $debet;
		$JurnalPenyesuaianRecord->jumlah_saldo = $PenyesuaianDetailRecord->nilai_akun;
		$JurnalPenyesuaianRecord->deleted = '0';
		$JurnalPenyesuaianRecord->save();
		
		$JurnalPenyesuaianRecord = JurnalPenyesuaianRecord::finder()->find('id_penyesuaian = ? AND jns_transaksi = ? AND deleted = ?',$PenyesuaianDetailRecord->id,'1','0');	
		if(!$JurnalPenyesuaianRecord)
		{
			$JurnalPenyesuaianRecord = new JurnalPenyesuaianRecord();
			$JurnalPenyesuaianRecord->id_penyesuaian = $PenyesuaianDetailRecord->id;
		}
		
		$JurnalPenyesuaianRecord->jns_transaksi = '1';
		$JurnalPenyesuaianRecord->tgl_transaksi = date("Y-m-d");
		$JurnalPenyesuaianRecord->wkt_transaksi = date("G:i:s");
		$JurnalPenyesuaianRecord->keterangan = $kredit;
		$JurnalPenyesuaianRecord->jumlah_saldo = $PenyesuaianDetailRecord->nilai_akun;
		$JurnalPenyesuaianRecord->deleted = '0';
		$JurnalPenyesuaianRecord->save();
		
		$this->idPenyesuaian->Value = '';
		$this->DDKelompokPenyesuaian->SelectedValue = 'empty';
		$this->DDJnsSaldo->SelectedValue = 'empty';
		$this->DDAsalSaldo->SelectedValue = 'empty';
		$this->DDJnsSaldo->Enabled = false;
		$this->DDAsalSaldo->Enabled = false;
		$this->nama_akun->Text = '';
		$this->nilai_akun->Text = '';
		$this->keterangan->Text = '';
		
		$tblBody = $this->BindGridPenyesuaian();
		$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery(".saldoPanel1").hide();
						jQuery(".saldoPanel2").hide();
						jQuery("#tablePenyesuaian").dataTable().fnDestroy();
						jQuery("#tablePenyesuaian tbody").empty();
						jQuery("#tablePenyesuaian tbody").append("'.$tblBody.'");
						BindGridPenyesuaian();');	
	}
	
	public function closingClicked()
	{
		
												
		$bulan = date("m");
		$tahun = date("Y");
		$arrRekapKertasKerja = $this->getViewState('arrRekapKertasKerja');
		
		if(count($arrRekapKertasKerja) > 0)
		{
			$RekapNeracaRecord = RekapNeracaRecord::finder()->find('bulan = ? AND tahun = ? AND deleted = ?',$bulan,$tahun,'0');
			if(!$RekapNeracaRecord)
			{
				$RekapNeracaRecord = new RekapNeracaRecord();
				$RekapNeracaRecord->bulan = $bulan;
				$RekapNeracaRecord->tahun = $tahun;
				$RekapNeracaRecord->deleted = '0';
				$RekapNeracaRecord->save();
				
				foreach($arrRekapKertasKerja as $row)
				{
					$RekapNeracaDetailRecord = new RekapNeracaDetailRecord();
											
					$RekapNeracaDetailRecord->id_rekap = $RekapNeracaRecord->id;
					$RekapNeracaDetailRecord->nama_akun = $row['namaAkun'];
					$RekapNeracaDetailRecord->neraca_saldo_debet = $row['neracasaldoDebetTemp'];
					$RekapNeracaDetailRecord->neraca_saldo_kredit = $row['neracasaldoKreditTemp'];
					$RekapNeracaDetailRecord->penyesuaian_debet = $row['penyesuaianDebetTemp'];
					$RekapNeracaDetailRecord->penyesuaian_kredit = $row['penyesuaianKreditTemp'];
					$RekapNeracaDetailRecord->ns_disesuaikan_debet = $row['nsdDebetTemp'];
					$RekapNeracaDetailRecord->ns_disesuaikan_kredit = $row['nsdKreditTemp'];
					$RekapNeracaDetailRecord->laba_rugi_debet = $row['labarugiDebetTemp'];
					$RekapNeracaDetailRecord->laba_rugi_kredit = $row['labarugiKreditTemp'];
					$RekapNeracaDetailRecord->neraca_debet = $row['neracaDebetTemp'];
					$RekapNeracaDetailRecord->neraca_kredit = $row['neracaKreditTemp'];
					$RekapNeracaDetailRecord->deleted = '0';
					$RekapNeracaDetailRecord->save();
					
				}
				
				$sqlUpdateBukuBesar = "UPDATE tbt_jurnal_buku_besar SET status = '1' WHERE 
										nama_akun LIKE 'Beban Perlengkapan' 
										OR  nama_akun LIKE 'Beban Gaji'
										OR  nama_akun LIKE 'Beban Lain-lain'
										OR  nama_akun LIKE 'Pendapatan'
										OR  nama_akun LIKE 'Pendapatan Lain-lain' ";
				$this->queryAction($sqlUpdateBukuBesar,'C');
				
				$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						toastr.info("Laporan Keuangan Bulan Ini Berhasil Diclosing !");
						');	
			}
			else
			{
				$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						toastr.error("Laporan Keuangan Bulan Ini Sudah Diclosing Sebelumnya !");
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
	
	public function cekClosingClicked()
	{
		$bulan = date("m");
		$tahun = date("Y");
		$RekapNeracaRecord = RekapNeracaRecord::finder()->find('bulan = ? AND tahun = ? AND deleted = ?',$bulan,$tahun,'0');
		if($RekapNeracaRecord)
		{
			$this->tambahBtn->Enabled = false;	
			$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						toastr.error("Penyesuaian/Adjustment Tidak Bisa Diinput Lagi, Karena Laporan Keungan Sudah Diclosing!");
						');	
		}
		else
		{
			$this->tambahBtn->Enabled = true;	
		}
	} 
}
?>
