<?PHP
class cetakLaporanKertasKerjaPdf extends MainConf
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
		
		if($pemasok != '')
		{
			$nmPemasok = PemasokRecord::finder()->findByPk($pemasok)->nama;
		}
		else
		{
			$nmPemasok = "SEMUA";
		}
		
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
		$nmPeriode = $nmBulan." ".$thn;
				
		
		$profilPerusahaan = $this->profilPerusahaan();	
			
		$pdf=new reportKwitansi('L','mm','legal');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',8,4,12);	
		$pdf->SetFont('Arial','B',12);
	    $pdf->Cell(0,5,'LAPORAN KERTAS KERJA BULANAN','0',0,'C');
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
		
		$sql = "SELECT 
					*
				FROM 
					tbt_rekap_neraca_detail
				INNER JOIN tbt_rekap_neraca ON tbt_rekap_neraca.id = tbt_rekap_neraca_detail.id_rekap 
				WHERE 
					tbt_rekap_neraca_detail.deleted = '0'
					AND tbt_rekap_neraca.tahun = '$thn'
					AND tbt_rekap_neraca.bulan = '$bln'
				ORDER BY tbt_rekap_neraca_detail.id ASC ";
		$arrAkun = $this->queryAction($sql,'S');
		$pdf->SetFont('Arial','B',8);
		
			$pdf->Cell(58,10,'Nama Akun','1',0,'C');
			$pdf->Cell(56,5,'Neraca Saldo','1',0,'C');
			$pdf->Cell(56,5,'Penyesuaian','1',0,'C');
			$pdf->Cell(56,5,'Neraca Saldo Disesuaikan','1',0,'C');
			$pdf->Cell(56,5,'Laba Rugi','1',0,'C');
			$pdf->Cell(56,5,'Neraca','1',0,'C');
			$pdf->Ln(5);
			$pdf->Cell(58,10,'','0',0,'C');
			$pdf->Cell(28,5,'Debet','1',0,'C');
			$pdf->Cell(28,5,'Kredit','1',0,'C');
			$pdf->Cell(28,5,'Debet','1',0,'C');
			$pdf->Cell(28,5,'Kredit','1',0,'C');
			$pdf->Cell(28,5,'Debet','1',0,'C');
			$pdf->Cell(28,5,'Kredit','1',0,'C');
			$pdf->Cell(28,5,'Debet','1',0,'C');
			$pdf->Cell(28,5,'Kredit','1',0,'C');
			$pdf->Cell(28,5,'Debet','1',0,'C');
			$pdf->Cell(28,5,'Kredit','1',0,'C');
			$pdf->Ln(5);
			$pdf->SetWidths(array(58,28,28,28,28,28,28,28,28,28,28));
			$pdf->SetAligns(array('L','R','R','R','R','R','R','R','R','R','R'));
		$pdf->SetFont('Arial','',8);
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
		foreach($arrAkun as $row)
		{	
			
			$neracaSaldoDebet += $row['neraca_saldo_debet'];
			$neracaSaldoKredit += $row['neraca_saldo_kredit'];
			$penyesuaianDebet += $row['penyesuaian_debet'];
			$penyesuaianKredit += $row['penyesuaian_kredit'];
			$nsdDebet += $row['ns_disesuaikan_debet'];
			$nsdKredit += $row['ns_disesuaikan_kredit'];
			$labarugiDebet += $row['laba_rugi_debet'];
			$labarugiKredit += $row['laba_rugi_kredit'];
			$neracaDebet += $row['neraca_debet'];
			$neracaKredit += $row['neraca_kredit'];
			
			$pdf->Row(array($row['nama_akun'],
						number_format($row['neraca_saldo_debet'],0,'.',','),
						number_format($row['neraca_saldo_kredit'],0,'.',','),
						number_format($row['penyesuaian_debet'],0,'.',','),
						number_format($row['penyesuaian_kredit'],0,'.',','),
						number_format($row['ns_disesuaikan_debet'],0,'.',','),
						number_format($row['ns_disesuaikan_kredit'],0,'.',','),
						number_format($row['laba_rugi_debet'],0,'.',','),
						number_format($row['laba_rugi_kredit'],0,'.',','),
						number_format($row['neraca_debet'],0,'.',','),
						number_format($row['neraca_kredit'],0,'.',',')));
						
		}
		$pdf->SetFont('Arial','B',8);
		$pdf->SetAligns(array('C','R','R','R','R','R','R','R','R','R','R'));
		$pdf->Row(array('Jumlah',
						number_format($neracaSaldoDebet,0,'.',','),
						number_format($neracaSaldoKredit,0,'.',','),
						number_format($penyesuaianDebet,0,'.',','),
						number_format($penyesuaianKredit,0,'.',','),
						number_format($nsdDebet,0,'.',','),
						number_format($nsdKredit,0,'.',','),
						number_format($labarugiDebet,0,'.',','),
						number_format($labarugiKredit,0,'.',','),
						number_format($neracaDebet,0,'.',','),
						number_format($neracaKredit,0,'.',',')));
		$pdf->Output();	
	}
}
?>
