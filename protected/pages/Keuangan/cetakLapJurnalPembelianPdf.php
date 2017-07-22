<?PHP
class cetakLapJurnalPembelianPdf extends MainConf
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
		
		$pdf->Cell(0,5,'LAPORAN JURNAL PEMBELIAN','0',0,'C');
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
		$pdf->Cell(20,15,'Tgl. Transaksi','1',0,'C');
		$pdf->Cell(23,15,'No. Transaksi','1',0,'C');
		$pdf->Cell(40,15,'Keterangan','1',0,'C');
		$pdf->Cell(10,15,'Ref','1',0,'C');
		$pdf->Cell(75,5,'DEBET','1',0,'C');
		$pdf->Cell(30,5,'KREDIT','1',0,'C');
		$pdf->Ln(5);
		$pdf->Cell(93,10,'','0',0,'C');
		$pdf->Cell(20,10,'Pembelian','1',0,'C');
		$pdf->Cell(55,5,'Serba - serbi','1',0,'C');
		$pdf->Cell(30,10,'Utang Dagang','1',0,'C');
		$pdf->Ln(5);
		$pdf->Cell(113,10,'','0',0,'C');
		$pdf->Cell(20,5,'Nama Akun','1',0,'C');
		$pdf->Cell(10,5,'Ref','1',0,'C');
		$pdf->Cell(25,5,'Jumlah','1',0,'C');
		$pdf->Ln(5);
		//$pdf->SetFont('Arial','',8);
		//$pdf->SetAligns(array('C','L','L','L','L','R','R','R','R','R'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapJurnalPembelianSql'];
		$arrData=$this->queryAction($sql,'S');
		$pdf->SetFont('Arial','',6);
		$pdf->SetWidths(array(20,23,40,10,20,20,10,25,30));
		$pdf->SetAligns(array('C','L','L','C','R','L','C','R','R'));
		$totalPembelian = 0;
		$totalSerbaserbi = 0;
		$totalUtangdagang = 0;
		foreach($arrData as $row)
		{
			if($row['jns_transaksi'] == '1')
			{
				$pdf->Row(array($this->ConvertDate($row['tgl_transaksi'],'3'),
								$row['no_transaksi'],
								$row['keterangan'],
								$row['ref'],
								number_format($row['jumlah'],2,".",","),
								'',
								'',
								'',
								number_format($row['jumlah'],2,".",",")));
				$totalPembelian += $row['jumlah'];
					
				
			}
			elseif($row['jns_transaksi'] == '2')
			{
				$pdf->Row(array($this->ConvertDate($row['tgl_transaksi'],'3'),
								$row['no_transaksi'],
								$row['keterangan'],
								'',
								'',
								$row['nama_akun'],
								$row['ref'],
								number_format($row['jumlah'],2,".",","),
								number_format($row['jumlah'],2,".",",")));
				$totalSerbaserbi += $row['jumlah'];
			}
				
			$totalUtangdagang += $row['jumlah'];	
		}
		$pdf->SetFont('Arial','B',6);
		$pdf->SetWidths(array(93,20,30,25,30));
		$pdf->SetAligns(array('C','R','R','R','R'));
		
		$pdf->Row(array('Jumlah',
						number_format($totalPembelian,2,".",","),
						'',
						number_format($totalSerbaserbi,2,".",","),
						number_format($totalUtangdagang,2,".",",")));
		
		$pdf->Output();	
	}
}
?>
