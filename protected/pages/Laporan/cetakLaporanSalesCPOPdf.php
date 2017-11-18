<?PHP
class cetakLaporanSalesCPOPdf extends MainConf
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
	    $pdf->Cell(0,5,'LAPORAN SALES CPO','0',0,'C');
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
		$pdf->Ln(7);
		
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapSalesCPOSql'];
		$sqlParent = $sql.' GROUP BY tbt_contract_sales.id';
		$arrData=$this->queryAction($sqlParent,'S');
		
		
		
		foreach($arrData as $rowParent)
		{
			$pdf->SetFont('Arial','B',8);
			$pdf->SetAligns(array('R','L','L','R','L'));
			$pdf->SetWidths(array(30,40,196,30,40));
		
			$pdf->Row(array('CONTRACT',$rowParent['sales_no'],'','DELIVERY ORDER',$rowParent['no_do']));
			$idContract = $rowParent['id'];
			$sqlDetail = $sql.' AND tbt_contract_sales.id = "'.$idContract.'" ORDER BY tbt_contract_sales.id , tbt_commodity_transaction.tgl_transaksi ASC';
			$arrDetail = $this->queryAction($sqlDetail,'S');
			
			$pdf->SetFont('Arial','B',6);
			$pdf->SetAligns(array('C','C'));
			$pdf->SetWidths(array(176,160));
			$pdf->Row(array('KIRIM','BULKING BUYER'));
			
			$pdf->SetAligns(array('C','C','C','C','C','C','C','C','C','C','C','C','C','C','C','C','C','C','C','C','C'));
			$pdf->SetWidths(array(16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16,16));
				
			$pdf->Row(array('TGL','NO.POLISI','BRUTO','TARRA','NETTO','FFA','M','I','TODAY','TODATE','SISA','TGL','BRUTO','TARRA','NETTO','FFA','DOBI','M&i','TODAY','TODATE','SELISIH'));
			$pdf->SetAligns(array('L','L','R','R','R','R','R','R','R','R','R','L','R','R','R','R','R','R','R','R','R'));
			
			$sisa = $rowParent['quantity'];
			$todate = 0;
			$todateterima = 0;
			
			$totalffa = 0;
			$totalmoist= 0;
			$totaldirt = 0;
			$totaltodate = 0;
			
			$totalffaterima = 0;
			$totaldobiterima= 0;
			$totalmiterima = 0;
			$totaltodateterima = 0;
			$totalsusut = 0;
			
			$pdf->Row(array('',
								'',
								'',
								'',
								'',
								'',
								'',
								'',
								'',
								'',
								number_format($sisa,2,'.',','),
								'',
								'',
								'',
								'',
								'',
								'',
								'',
								'',
								'',
								''));
								
			$pdf->SetFont('Arial','',6);	
			$jmlRow = 0;
			foreach($arrDetail as $row)
			{	
				$jmlRow++;
				$todate += $row['netto_2'];
				$sisa -= $row['netto_2'];
				$todateterima += $row['netto_diterima'];
				
				$totalffa += $row['ffa'];
				$totalmoist += $row['moist'];
				$totaldirt += $row['dirt'];
				$totaltodate += $row['netto_2'];
				
				$totalffaterima += $row['ffa_diterima'];
				$totaldobiterima += $row['dobi_diterima'];
				$totalmiterima += $row['mi_diterima'];
				$totaltodateterima += $row['netto_diterima'];
				$totalsusut += $row['jumlah_susut'];
			
				$pdf->Row(array($this->ConvertDate($row['tgl_transaksi'],'3'),
								$row['no_kendaraan'],
								number_format($row['bruto'],2,'.',','),
								number_format($row['tarra'],2,'.',','),
								number_format($row['netto_2'],2,'.',','),
								number_format($row['ffa'],2,'.',','),
								number_format($row['moist'],2,'.',','),
								number_format($row['dirt'],2,'.',','),
								number_format($row['netto_2'],2,'.',','),
								number_format($todate,2,'.',','),
								number_format($sisa,2,'.',','),
								$this->ConvertDate($row['tgl_penerimaan'],'3'),
								number_format($row['bruto_diterima'],2,'.',','),
								number_format($row['tarra_diterima'],2,'.',','),
								number_format($row['netto_diterima'],2,'.',','),
								number_format($row['ffa_diterima'],2,'.',','),
								number_format($row['dobi_diterima'],2,'.',','),
								number_format($row['mi_diterima'],2,'.',','),
								number_format($row['netto_diterima'],2,'.',','),
								number_format($todateterima,2,'.',','),
								number_format($row['jumlah_susut'],2,'.',',')));
			}
			$pdf->SetFont('Arial','B',6);	
			$pdf->Row(array('TOTAL',
								'',
								'',
								'',
								'',
								number_format($totalffa,2,'.',','),
								number_format($totalmoist,2,'.',','),
								number_format($totaldirt,2,'.',','),
								'',
								number_format($totaltodate,2,'.',','),
								'',
								'',
								'',
								'',
								'',
								number_format($totalffaterima,2,'.',','),
								number_format($totaldobiterima,2,'.',','),
								number_format($totalmiterima,2,'.',','),
								'',
								number_format($totaltodateterima,2,'.',','),
								number_format($totalsusut,2,'.',',')));
			
			$pdf->Row(array('AVERAGE',
								'',
								'',
								'',
								'',
								number_format($totalffa/$jmlRow,2,'.',','),
								number_format($totalmoist/$jmlRow,2,'.',','),
								number_format($totaldirt/$jmlRow,2,'.',','),
								'',
								'',
								'',
								'',
								'',
								'',
								'',
								number_format($totalffaterima/$jmlRow,2,'.',','),
								number_format($totaldobiterima/$jmlRow,2,'.',','),
								number_format($totalmiterima/$jmlRow,2,'.',','),
								'',
								'',
								''));
			$pdf->Ln(5);					
		}
		//$pdf->SetAligns(array('C','C','C','C','C','C','C','C','C','C'));
		//$pdf->SetWidths(array(10,60,30,64,45,20,20,30,27,30,20,20,20,35));
		//$pdf->Row(array('NO','NO. KONTRAK','TGL. KONTRAK','PEMBELI','COMMODITY','JUMLAH KONTRAK','JUMLAH DIKIRIM','TOTAL PENGIRIMAN','JUMLAH DITERIMA','TOTAL PEMBAYARAN'));
		//$pdf->Ln(1);
		//$pdf->SetFont('Arial','',8);
		//$pdf->SetAligns(array('C','L','L','L','L','R','R','R','R','R'));
		
		/*$no = 0;
		$ttlKontrak = 0;
		$ttlKirim = 0;
		$ttlPengiriman = 0;
		$ttlTerima = 0;
		$ttlPembayaran = 0;
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
							$row['sales_no'],
							$this->ConvertDate($row['tgl_kontrak'],'3'),
							$row['id_pembeli'],
							$commodity_type,
							$row['jumlah_kontrak'],
							$row['jumlah_kirim'],
							number_format($row['total_pengiriman'],2,'.',','),
							$row['jumlah_diterima'],
							number_format($row['total_pembayaran'],2,'.',',')));
			
			
			$ttlKontrak = $row['jumlah_kontrak'];
			$ttlKirim = $row['jumlah_kirim'];
			$ttlPengiriman = $row['total_pengiriman'];
			$ttlTerima = $row['jumlah_diterima'];
			$ttlPembayaran = $row['total_pembayaran'];
		}
		$pdf->SetAligns(array('C','R','R','R','R','R'));
		$pdf->SetWidths(array(209,20,20,30,27,30));
		$pdf->SetFont('Arial','B',8);
		$pdf->Row(array("Total",$ttlKontrak,$ttlKirim,number_format($ttlPengiriman,2,'.',','),$ttlTerima,number_format($ttlPembayaran,2,'.',',')));
			*/
		$pdf->Output();	
	}
}
?>
