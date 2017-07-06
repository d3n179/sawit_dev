<?PHP
class cetakLapLemburKaryawanPdf extends MainConf
{
	public function onPreInit($param)
	{
		parent::onPreInit($param);	
		$this->getResponse()->setContentType("application/pdf");
	}
	public function onLoad($param)
	{
		$periode = $this->Request['periode'];
		$bln = $this->Request['bln'];
		$thn =$this->Request['thn'];
		$mingguan =$this->Request['mingguan'];
		$harian =$this->Request['harian'];
		
		if($bln == '01')
			$nmBulan = "Januari";
		elseif($bln == '02')
			$nmBulan = "Februari";
		elseif($bln == '03')
			$nmBulan = "Maret";
		elseif($bln == '04')
			$nmBulan = "April";
		elseif($bln == '05')
			$nmBulan = "Mei";
		elseif($bln == '06')
			$nmBulan = "Juni";
		elseif($bln == '07')
			$nmBulan = "Juli";
		elseif($bln == '08')
			$nmBulan = "Agustus";
		elseif($bln == '09')
			$nmBulan = "September";
		elseif($bln == '10')
			$nmBulan = "Oktober";
		elseif($bln == '11')
			$nmBulan = "Novemver";
		elseif($bln == '12')
			$nmBulan = "Desember";
		
		$thnBln = $thn."-".$bln."-";	
		
		if($periode == '0')
			$nmPeriode = $nmBulan." ".$thn;
		elseif($periode == '1')
			$nmPeriode = $thn;
		elseif($periode == '3')
			$nmPeriode = $mingguan;
		
		$profilPerusahaan = $this->profilPerusahaan();	
			
		$pdf=new reportKwitansi('L','mm','legal');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',8,4,12);	
		$pdf->SetFont('Arial','B',12);
	    $pdf->Cell(0,5,'LAPORAN LEMBUR KARYAWAN','0',0,'C');
		$pdf->Ln(4);
		$pdf->Cell(0,5,strtoupper($profilPerusahaan->nama),'0',0,'C');
		
		$pdf->Ln(4);			
		$pdf->SetFont('Arial','',8);
		$pdf->Cell(10,5,'','0',0,'C');
		$pdf->Cell(0,5,''.$profilPerusahaan->alamat.' TELP : ' .$profilPerusahaan->telepon.'','0',0,'C');	
		$pdf->Ln(1);
		$pdf->Cell(0,5,'','B',1,'C');
		$pdf->Ln(1);		
		$pdf->SetFont('Arial','BU',10);
		
		$pdf->SetFont('Arial','B',10);
		$pdf->Cell(0,5,'PERIODE : '.$nmPeriode,'0',0,'L');
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C','C','C','C','C','C','C','C','C'));
		$pdf->SetWidths(array(50,35,25,25,25,25,25,25,25,25,25,25));
		$pdf->Row(array('Nama Karyawan','Jabatan','Golongan','Lembur LPP (Jam)','Lembur LPP (Tarif)','Lembur LPP (Total)','Lembur LPPML (Jam)','Lembur LPPML (Tarif)','Lembur LPPML (Total)','Lembur LPPLK (Jam)','Lembur LPPLK (Tarif)','Lembur LPPLK (Total)'));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('L','L','L','R','R','R','R','R','R','R','R','R'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapLemburKaryawanSql'];
		$arrData=$this->queryAction($sql,'S');
		$i = 1;
		$idPo = '';
		foreach($arrData as $row)
		{		
			$arrDetail = $this->getDetailLembur($row['id'],$row['gaji_pokok'],$bln,$thn);
			$pdf->Row(array($row['nama'],
							$row['jabatan'],
							$row['golongan'],
							$arrDetail['LemburLPP'],
							number_format($arrDetail['tarifLemburLPP']),
							number_format($arrDetail['totalLemburLPP']),
							$arrDetail['LemburLPPML'],
							number_format($arrDetail['tarifLemburLPPML']),
							number_format($arrDetail['totalLemburLPPML']),
							$arrDetail['LemburLPPLK'],
							number_format($arrDetail['tarifLemburLPPLK']),
							number_format($arrDetail['totalLemburLPPLK'])));
			$i++;
		}
		
		$pdf->Output();	
	}
	
	public function getDetailLembur($idKaryawan,$gajiPokok,$month,$year)
	{	
		$sql = "SELECT
					SUM(
						tbt_lembur_karyawan.lama_lembur
					) AS lama_lembur
				FROM
					tbt_lembur_karyawan
				WHERE
					MONTH (tbt_lembur_karyawan.tgl) = '$month'
				AND YEAR (tbt_lembur_karyawan.tgl) = '$year'
				AND tbt_lembur_karyawan.id_karyawan = '$idKaryawan'
				AND tbt_lembur_karyawan.jns_lembur = '1'";
				
		$arr = $this->queryAction($sql,'S');
		$LemburLPP = $arr[0]['lama_lembur'];
		$tarifLemburLPP = (1/173) * $gajiPokok;
		$totalLemburLPP = $tarifLemburLPP * $LemburLPP;
		
		$sql = "SELECT
					SUM(
						tbt_lembur_karyawan.lama_lembur
					) AS lama_lembur
				FROM
					tbt_lembur_karyawan
				WHERE
					MONTH (tbt_lembur_karyawan.tgl) = '$month'
				AND YEAR (tbt_lembur_karyawan.tgl) = '$year'
				AND tbt_lembur_karyawan.id_karyawan = '$idKaryawan'
				AND tbt_lembur_karyawan.jns_lembur = '2'";
				
		$arr = $this->queryAction($sql,'S');
		$LemburLPPML = $arr[0]['lama_lembur'];
		$tarifLemburLPPML = ((1/173) * $gajiPokok) * 1.5;
		$totalLemburLPPML = $tarifLemburLPPML * $LemburLPPML;
		
		$sql = "SELECT
					SUM(
						tbt_lembur_karyawan.lama_lembur
					) AS lama_lembur
				FROM
					tbt_lembur_karyawan
				WHERE
					MONTH (tbt_lembur_karyawan.tgl) = '$month'
				AND YEAR (tbt_lembur_karyawan.tgl) = '$year'
				AND tbt_lembur_karyawan.id_karyawan = '$idKaryawan'
				AND tbt_lembur_karyawan.jns_lembur = '3'";
				
		$arr = $this->queryAction($sql,'S');
		$LemburLPPLK = $arr[0]['lama_lembur'];
		$tarifLemburLPPLK = ((1/173) * $gajiPokok) * 2;
		$totalLemburLPPLK = $tarifLemburLPPLK * $LemburLPPLK;
		
		
		return array("LemburLPP"=>$LemburLPP,"tarifLemburLPP"=>$tarifLemburLPP,"totalLemburLPP"=>$totalLemburLPP,
						"LemburLPPML"=>$LemburLPPML,"tarifLemburLPPML"=>$tarifLemburLPPML,"totalLemburLPPML"=>$totalLemburLPPML,
						"LemburLPPLK"=>$LemburLPPLK,"tarifLemburLPPLK"=>$tarifLemburLPPLK,"totalLemburLPPLK"=>$totalLemburLPPLK);
	}
	
}
?>
