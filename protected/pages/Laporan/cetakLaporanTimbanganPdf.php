<?PHP
class cetakLaporanTimbanganPdf extends MainConf
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
		
		if($bln == '1')
			$nmBulan = "Januari";
		elseif($bln == '2')
			$nmBulan = "Februari";
		elseif($bln == '3')
			$nmBulan = "Maret";
		elseif($bln == '4')
			$nmBulan = "April";
		elseif($bln == '5')
			$nmBulan = "Mei";
		elseif($bln == '6')
			$nmBulan = "Juni";
		elseif($bln == '7')
			$nmBulan = "Juli";
		elseif($bln == '8')
			$nmBulan = "Agustus";
		elseif($bln == '9')
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
		elseif($periode == '2')
			$nmPeriode = $mingguan;
		elseif($periode == '3')
			$nmPeriode = $harian;
				
		$pdf=new reportKwitansi('L','mm','legal');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		$profilPerusahaan = $this->profilPerusahaan();	
			
		$pdf=new reportKwitansi('L','mm','legal');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',8,4,12);	
		$pdf->SetFont('Arial','B',12);
	    $pdf->Cell(0,5,'LAPORAN TIMBANGAN TBS','0',0,'C');
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
		$pdf->SetAligns(array('C','C','C','C','C','C','C','C','C','C','C','C','C','C'));
		$pdf->SetWidths(array(10,20,25,25,50,20,20,20,27,30,20,20,20,30));
		$pdf->Row(array('NO','NO. SP','NO. POLISI','JENIS TBS','SUPPLIER','BRUTTO','TARRA','NETTO I','POTONGAN (%)','HSIL. POTONGAN','NETTO II','JLH TANDAN','KOMIDEL',"KATEGORI TBS"));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('C','L','L','L','L','R','R','R','R','R','R','R','R','L'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapTimbanganSql'];
		$arrData=$this->queryAction($sql,'S');
		$no = 0;
		$ttlBruto = 0;
		$ttlTarra = 0;
		$ttlNetto1 = 0;
		$ttlPotongan = 0;
		$ttlHslPotongan = 0;
		$ttlNetto2 = 0;
		$ttlTandan = 0;
		foreach($arrData as $row)
		{
			$no++;
			$pdf->Row(array($no,$row['no_sp'],$row['no_polisi'],$row['barang'],$row['pemasok'],
			number_format($row['bruto'],2,'.',','),
			number_format($row['tarra'],2,'.',','),
			number_format($row['netto_1'],2,'.',','),
			number_format($row['potongan'],2,'.',','),
			number_format($row['hasil_potongan'],2,'.',','),
			number_format($row['netto_2'],2,'.',','),
			number_format($row['jml_tandan'],2,'.',','),
			number_format($row['komidel'],2,'.',','),
			$row['kategori_tbs']));
			
			
			$ttlBruto += $row['bruto'];
			$ttlTarra += $row['tarra'];
			$ttlNetto1 += $row['netto_1'];
			$ttlPotongan += $row['potongan'];
			$ttlHslPotongan += $row['hasil_potongan'];
			$ttlNetto2 += $row['netto_2'];
			$ttlTandan += $row['jml_tandan'];
		}
		$pdf->SetAligns(array('C','R','R','R','R','R','R','R','R','L'));
		$pdf->SetWidths(array(130,20,20,20,27,30,20,20,20,30));
		$pdf->SetFont('Arial','B',8);
		$pdf->Row(array("Total",
		number_format($ttlBruto,2,'.',','),
			number_format($ttlTarra,2,'.',','),
			number_format($ttlNetto1,2,'.',','),
			number_format($ttlPotongan / $no,2,'.',','),
			number_format($ttlHslPotongan,2,'.',','),
			number_format($ttlNetto2,2,'.',','),
			number_format($ttlTandan,2,'.',','),
		"",""));
			
		$pdf->Output();	
	}
}
?>
