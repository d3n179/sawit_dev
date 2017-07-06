<?PHP
class cetakLaporanPengirimanCommodityPdf extends MainConf
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
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',5,8,25);	
		$pdf->SetFont('Arial','B',12);
		$pdf->Cell(10,10,'','0',0,'C');
		$pdf->Cell(0,10,strtoupper($profilPerusahaan->nama),'0',0,'C');
		
		$pdf->Ln(8);			
		$pdf->SetFont('Arial','',9);
		$pdf->Cell(10,10,'','0',0,'C');
		$pdf->Cell(0,10,$profilPerusahaan->alamat,'0',0,'C');	
		$pdf->Ln(4);
		$pdf->Cell(0,10,'           '.$profilPerusahaan->telepon,'0',0,'C');	
		$pdf->Ln(3);
		$pdf->Cell(0,5,'','B',1,'C');
		$pdf->Ln(3);		
		$pdf->SetFont('Arial','BU',10);
		
		$pdf->SetFont('Arial','B',10);
		$pdf->Cell(0,5,'LAPORAN PENJUALAN COMMODITY','0',0,'C');
		$pdf->Ln(5);
		$pdf->Cell(0,5,'PERIODE : '.$nmPeriode,'0',0,'C');
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C','C','C','C','C'));
		$pdf->SetWidths(array(10,40,40,30,50,35,35,35));
		$pdf->Row(array('NO','NO. TIKET','NO. DO','TGL. KIRIM','PEMBELI','COMMODITY','JUMLAH KIRIM','TOTAL PENGIRIMAN'));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('C','L','L','L','L','R','R','R'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapPengirimanCommoditySql'];
		$arrData=$this->queryAction($sql,'S');
		$no = 0;
		$ttlKirim = 0;
		$ttlPengiriman = 0;
		foreach($arrData as $row)
		{
			if($row['commodity_type'] == '0')
				$commodity_type = 'CPO - Crude Palm Oil';
			elseif($row['commodity_type'] == '1')
				$commodity_type = 'PK - Palm Kernel';
			elseif($row['commodity_type'] == '2')
				$commodity_type = 'FIBRE';
			elseif($row['commodity_type'] == '3')
				$commodity_type = 'CANGKANG';
					
			$no++;
			$pdf->Row(array($no,
							$row['transaction_no'],
							$row['no_do'],
							$this->ConvertDate($row['tgl_do'],'3'),
							$row['pembeli'],
							$commodity_type,
							$row['jumlah_kirim'],
							number_format($row['total_pengiriman'],2,'.',',')));
			
			
			$ttlKirim = $row['jumlah_kirim'];
			$ttlPengiriman = $row['total_pengiriman'];
		}
		$pdf->SetAligns(array('C','R','R','R','R','R'));
		$pdf->SetWidths(array(205,35,35));
		$pdf->SetFont('Arial','B',8);
		$pdf->Row(array("Total",$ttlKirim,number_format($ttlPengiriman,2,'.',',')));
			
		$pdf->Output();	
	}
}
?>
