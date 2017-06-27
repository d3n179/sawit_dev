<?PHP
class cetakLaporanPembelianTbsPdf extends MainConf
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
		$pemasok =$this->Request['pemasok'];
		
		if($pemasok != '')
		{
			$nmPemasok = PemasokRecord::finder()->findByPk($pemasok)->nama;
		}
		else
		{
			$nmPemasok = "SEMUA";
		}
		
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
	    $pdf->Cell(0,5,'LAPORAN PEMBELIAN TBS','0',0,'C');
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
		$pdf->Cell(0,5,'NAMA SUPPLIER : '.$nmPemasok,'0',0,'L');
		$pdf->Ln(8);
		$pdf->Cell(10,10,'No.','1',0,'C');
		$pdf->Cell(60,5,'Tbs Diterima','1',0,'C');
		$pdf->Cell(40,5,'Harga','1',0,'C');
		$pdf->Cell(60,5,'Bongkar SPSI','1',0,'C');
		$pdf->Cell(25,10,'Jumlah','1',0,'C');
		$pdf->Cell(30,5,'Fee','1',0,'C');
		$pdf->Cell(30,10,'Jumlah','1',0,'C');
		$pdf->Cell(50,5,'Pajak','1',0,'C');
		$pdf->Cell(30,10,'Jumlah','1',0,'C');
		$pdf->Ln(5);
		
		$pdf->Cell(10,5,'','0',0,'C');
		$pdf->Cell(30,5,'Truk','1',0,'C');
		$pdf->Cell(15,5,'Jenis','1',0,'C');
		$pdf->Cell(15,5,'Kg','1',0,'C');
		$pdf->Cell(15,5,'@','1',0,'C');
		$pdf->Cell(25,5,'Jumlah','1',0,'C');
		$pdf->Cell(15,5,'Kg','1',0,'C');
		$pdf->Cell(15,5,'@','1',0,'C');
		$pdf->Cell(30,5,'Jumlah','1',0,'C');
		$pdf->Cell(25,5,'','0',0,'C');
		$pdf->Cell(10,5,'@','1',0,'C');
		$pdf->Cell(20,5,'Jumlah','1',0,'C');
		$pdf->Cell(30,5,'','0',0,'C');
		$pdf->Cell(25,5,'PPN','1',0,'C');
		$pdf->Cell(25,5,'PPH','1',0,'C');
		$pdf->Cell(30,5,'','0',0,'C');
		$pdf->Ln(5);
		$pdf->SetWidths(array(10,30,15,15,15,25,15,15,30,25,10,20,30,25,25,30));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('C','L','L','L','L','R','R','R','R','R','R','R','R','R','R','R'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapPembelianTbsSql'];
		$arrData=$this->queryAction($sql,'S');
		$no = 0;
		$ttlNetto2 = 0;
		$ttlSubtotalTbs = 0;
		$ttlNetto1 = 0;
		$ttlSubtotalSpsi = 0;
		$ttlJml1 = 0;
		$ttlSubtotalFee = 0;
		$ttlJml2 = 0;
		$ttlPpn = 0;
		$ttlPph = 0;
		$ttlTbsOrder = 0;
		foreach($arrData as $row)
		{
			$jml1 = $row['subtotal_tbs'] - $row['subtotal_spsi'];
			$jml2 = $row['subtotal_tbs'] - $row['subtotal_spsi'] + $row['subtotal_fee'];
			$ppn = $row['subtotal_tbs'] * ($row['ppn'] / 100);
			$pph = $row['subtotal_tbs'] * ($row['pph'] / 100);
				
			$no++;
			$pdf->Row(array($no,
			$row['jenis_kendaraan'],
			$row['kategori_tbs'],
			$row['netto_2'],
			number_format($row['harga'],2,'.',','),
			number_format($row['subtotal_tbs'],2,'.',','),
			$row['netto_1'],
			$row['jumlah_bongkar'],
			number_format($row['subtotal_spsi'],2,'.',','),
			number_format($jml1,2,'.',','),
			$row['fee'],
			number_format($row['subtotal_fee'],2,'.',','),
			number_format($jml2,2,'.',','),
			number_format($ppn,2,'.',','),
			number_format($pph,2,'.',','),
			number_format($row['total_tbs_order'],2,'.',',')));
			
			
			$ttlNetto2 += $row['netto_2'];
			$ttlSubtotalTbs += $row['subtotal_tbs'];
			$ttlNetto1 += $row['netto_1'];
			$ttlSubtotalSpsi += $row['subtotal_spsi'];
			$ttlJml1 += $jml1;
			$ttlSubtotalFee += $row['subtotal_fee'];
			$ttlJml2 += $jml2;
			$ttlPpn += $ppn;
			$ttlPph += $pph;
			$ttlTbsOrder += $row['total_tbs_order'];
		}
		$pdf->SetFont('Arial','B',8);
		$pdf->Row(array("Total",
			"",
			"",
			$ttlNetto2,
			"",
			number_format($ttlSubtotalTbs,2,'.',','),
			$ttlNetto1,
			"",
			number_format($ttlSubtotalSpsi,2,'.',','),
			number_format($ttlJml1,2,'.',','),
			"",
			number_format($ttlSubtotalFee,2,'.',','),
			number_format($ttlJml2,2,'.',','),
			number_format($ttlPpn,2,'.',','),
			number_format($ttlPph,2,'.',','),
			number_format($ttlTbsOrder,2,'.',',')));
			
		$pdf->Output();	
	}
}
?>
