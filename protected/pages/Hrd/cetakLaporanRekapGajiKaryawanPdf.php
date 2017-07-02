<?PHP
class cetakLaporanRekapGajiKaryawanPdf extends MainConf
{
	public function onPreInit($param)
	{
		parent::onPreInit($param);	
		$this->getResponse()->setContentType("application/pdf");
	}
	public function onLoad($param)
	{
		$bln = $this->Request['bulan'];
		$thn =$this->Request['tahun'];
		
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
		elseif($bln == '6')
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
	    $pdf->Cell(0,5,'LAPORAN REKAP GAJI KARYAWAN','0',0,'C');
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
		
		$pdf->SetFont('Arial','B',6);
		$pdf->Cell(0,5,'PERIODE : '.$nmPeriode,'0',0,'L');
		$pdf->Ln(5);
		$pdf->Cell(10,15,'No.','1',0,'C');
		$pdf->Cell(30,15,'Employee ID','1',0,'C');
		$pdf->Cell(30,15,'Nama','1',0,'C');
		$pdf->Cell(30,15,'Posisi','1',0,'C');
		$pdf->Cell(30,15,'Gol','1',0,'C');
		$pdf->Cell(30,15,'PTKP','1',0,'C');
		$pdf->Cell(30,15,'TMK','1',0,'C');
		$pdf->Cell(30,15,'Gaji Pokok','1',0,'C');
		$pdf->Cell(30,15,'Tunjangan Natura','1',0,'C');
		$pdf->Cell(30,15,'Incentive','1',0,'C');
		$pdf->MultiCell(30,15,'Tunjangan Jabatan','1');
		$pdf->Cell(30,15,'Tunjangan Komunikasi','1',0,'C');
		$pdf->Cell(30,15,'Premi Karyawan','1',0,'C');
		$pdf->Cell(30,15,'Total Gaji','1',0,'C');
		$pdf->Ln(5);
		
		$pdf->Ln(5);
		$pdf->SetWidths(array(10,30,15,15,15,25,15,15,30,25,10,20,30,25,25,30));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('C','L','L','L','L','R','R','R','R','R','R','R','R','R','R','R'));
		$session=new THttpSession;
		$session->open();
		//$sql = $session['cetakLapPembelianTbsSql'];
		//$arrData=$this->queryAction($sql,'S');
		//foreach($arrData as $row)
		//{
		//}
			
		$pdf->Output();	
	}
}
?>
