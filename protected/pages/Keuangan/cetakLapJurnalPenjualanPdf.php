<?PHP
class cetakLapJurnalPenjualanPdf extends MainConf
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
		elseif($periode == '3')
			$nmPeriode = $mingguan;
		
		$profilPerusahaan = $this->profilPerusahaan();	
			
		$pdf=new reportKwitansi('P','mm','legal');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',8,4,12);	
		$pdf->SetFont('Arial','B',12);
		
		$pdf->Cell(0,5,'LAPORAN JURNAL PENJUALAN','0',0,'C');
		$pdf->Ln(4);
		$pdf->Cell(0,5,strtoupper($profilPerusahaan->nama),'0',0,'C');
		
		$pdf->Ln(4);			
		$pdf->SetFont('Arial','',8);
		$pdf->Cell(10,5,'','0',0,'C');
		$pdf->Cell(0,5,''.$profilPerusahaan->alamat.' TELP : ' .$profilPerusahaan->telepon.'','0',0,'C');	
		$pdf->Ln(1);
		$pdf->Cell(0,4,'','B',1,'C');
		$pdf->Ln(1);		
		$pdf->SetFont('Arial','BU',10);
		
		$pdf->SetFont('Arial','B',6);
		$pdf->Cell(0,5,'PERIODE : '.$nmPeriode,'0',0,'L');
		$pdf->Ln(5);
		//$pdf->SetFont('Arial','',8);
		//$pdf->SetAligns(array('C','L','L','L','L','R','R','R','R','R'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapJurnalPenjualanSql'];
		$arrData=$this->queryAction($sql,'S');
		$pdf->SetFont('Arial','B',6);
		$pdf->SetWidths(array(20,30,50,30,20,40));
		$pdf->SetAligns(array('C','C','C','C','C','C'));
		$pdf->Row(array("Tgl. Transaksi",
								"No. Transaksi",
								"Keterangan",
								"Syarat",
								"Ref",
								"D : Piutang Dagang, K : Penjualan"));
		$total = 0;
		$pdf->SetFont('Arial','',6);
		$pdf->SetAligns(array('C','L','L','L','L','R'));
		foreach($arrData as $row)
		{
				$pdf->Row(array($this->ConvertDate($row['tgl_transaksi'],'3'),
								$row['no_transaksi'],
								$row['keterangan'],
								$row['syarat'],
								$row['ref'],
								number_format($row['jumlah'],2,".",",")));
								
				$total += $row['jumlah'];
		}
		$pdf->SetFont('Arial','B',6);
		$pdf->SetWidths(array(150,40));
		$pdf->SetAligns(array('C','R','R','R','R','R'));
		
		$pdf->Row(array('Jumlah',
						number_format($total,2,".",",")
						));
		
		$pdf->Output();	
	}
}
?>
