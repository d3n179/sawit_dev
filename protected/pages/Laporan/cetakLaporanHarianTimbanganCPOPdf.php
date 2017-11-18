<?PHP
class cetakLaporanHarianTimbanganCPOPdf extends MainConf
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
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',5,8,12);	
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
		$pdf->Cell(0,5,'LAPORAN HARIAN TIMBANGAN CPO','0',0,'C');
		$pdf->Ln(5);
		$pdf->Cell(0,5,'PERIODE : '.$nmPeriode,'0',0,'C');
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C','C','C','C','C','C','C','C'));
		$pdf->SetWidths(array(10,35,35,35,35,35,35,25,25,25,25));
		$pdf->Row(array('NO','NO. DO','NO. KONTRAK','NO. POLISI','NAMA SUPIR','NAMA BARANG','BUYER','BRUTTO','TARRA','POTONGAN (%)','NETTO'));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('C','L','L','L','L','L','L','R','R','R','R'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapharianTimbanganCpoSql'];
		$arrData=$this->queryAction($sql,'S');
		$no = 0;
		$ttlBruto = 0;
		$ttlTarra = 0;
		$ttlPotongan = 0;
		$ttlNetto = 0;
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
			
			if($row['jns_kontrak'] == '0')
				$noDo .= $row['no_do_manual'];
			else
				$noDo .= $row['no_do'];
				
			$pdf->Row(array($no,
							$noDo,
							$row['sales_no'],
							$row['no_kendaraan'],
							$row['nama_supir'],
							$commodity_type,
							$row['pembeli'],
							number_format($row['bruto'],2,'.',','),
							number_format($row['tarra'],2,'.',','),
							number_format($row['potongan'],2,'.',','),
							number_format($row['netto_2'],2,'.',',')));
			
			
			$ttlBruto += $row['bruto'];
			$ttlTarra += $row['tarra'];
			$ttlPotongan += $row['potongan'];
			$ttlNetto += $row['netto_2'];
		}
		$pdf->SetAligns(array('C','R','R','R','R'));
		$pdf->SetWidths(array(220,25,25,25,25));
		$pdf->SetFont('Arial','B',8);
		$pdf->Row(array("Total",
						number_format($ttlBruto,2,'.',','),
						number_format($ttlTarra,2,'.',','),
						number_format($ttlPotongan,2,'.',','),
						number_format($ttlNetto,2,'.',',')));
			
		$pdf->Output();	
	}
}
?>