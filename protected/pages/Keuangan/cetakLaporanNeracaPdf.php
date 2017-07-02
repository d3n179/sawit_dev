<?PHP
class cetakLaporanNeracaPdf extends MainConf
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
			
		$pdf=new reportKwitansi('P','mm','legal');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',8,4,12);	
		$pdf->SetFont('Arial','B',12);
	    $pdf->Cell(0,5,'LAPORAN NERACA BULANAN','0',0,'C');
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
					tbt_rekap_neraca_detail.kelompok_akun,
					tbt_rekap_neraca_detail.nama_akun,
					tbt_rekap_neraca_detail.nilai_akun
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
		$jmlAktivaLancar = 0;
		$pdf->SetWidths(array(190));
		$pdf->SetAligns(array('L'));
		$pdf->RowNoBorder(array("Aktiva"));
		$pdf->SetWidths(array(190));
		$pdf->SetAligns(array('L'));
		$pdf->RowNoBorder(array("Aktiva Lancar"));
		
		$pdf->SetFont('Arial','',8);
		$pdf->SetWidths(array(10,60,40,40,40));
		$pdf->SetAligns(array('L','L','R','R','R'));
		foreach($arrAkun as $row)
		{
			if($row['kelompok_akun'] == '1')
			{
				$pdf->RowNoBorder(array("",$row['nama_akun'],number_format($row['nilai_akun'],2,".",","),"",""));
				$jmlAktivaLancar += $row['nilai_akun'];
			}
			
		}
		$pdf->SetAligns(array('L','R','R','R','R'));
		$pdf->RowNoBorder(array("","Jumlah Aktiva Lancar","","",number_format($jmlAktivaLancar,2,".",",")));
		
		$jmlAktivaTetap = 0;
		$pdf->SetFont('Arial','B',8);
		$pdf->SetWidths(array(190));
		$pdf->SetAligns(array('L'));
		$pdf->RowNoBorder(array("Aktiva Tetap"));
		
		$pdf->SetFont('Arial','',8);
		$pdf->SetWidths(array(10,60,40,40,40));
		$pdf->SetAligns(array('L','L','R','R','R'));
		$prevAkun = '';
		$nilaiAktiva = 0;
		foreach($arrAkun as $row)
		{
			if($row['kelompok_akun'] == '2' || $row['kelompok_akun'] == '3')
			{
				if($row['kelompok_akun'] == '2')
				{
					$pdf->RowNoBorder(array("",$row['nama_akun'],number_format($row['nilai_akun'],2,".",","),"",""));
					$nilaiAktiva += $row['nilai_akun'];
					$jmlAktivaTetap += $row['nilai_akun'];
				
				}
				
				if($row['kelompok_akun'] == '3')
				{
					$pdf->RowNoBorder(array("",$row['nama_akun'],"(".number_format($row['nilai_akun'],2,".",",").")","",""));
					
					$nilaiAktiva -= $row['nilai_akun'];
					$jmlAktivaTetap -= $row['nilai_akun'];
				}
				
				if($prevAkun == '2')
				{
					$pdf->RowNoBorder(array("","","",number_format($nilaiAktiva,2,".",","),""));
					$nilaiAktiva = 0;
				}
				
				$prevAkun = $row['kelompok_akun'];
				
			}
			
		
		}
		
		$pdf->SetAligns(array('L','R','R','R','R'));
		$pdf->RowNoBorder(array("","Jumlah Aktiva Tetap","","",number_format($jmlAktivaTetap,2,".",",")));
		
		$pdf->SetFont('Arial','B',8);
		$pdf->SetAligns(array('L','R','R','R','R'));
		$pdf->RowNoBorder(array("","Jumlah Aktiva","","",number_format($jmlAktivaTetap + $jmlAktivaLancar,2,".",",")));
		
		$pdf->SetFont('Arial','B',8);
		$pdf->SetWidths(array(190));
		$pdf->SetAligns(array('L'));
		$pdf->RowNoBorder(array("Kewajiban"));
		$pdf->RowNoBorder(array("Utang Lancar"));
		$jmlUtang =0;
		$pdf->SetFont('Arial','',8);
		$pdf->SetWidths(array(10,60,40,40,40));
		$pdf->SetAligns(array('L','L','R','R','R'));
		foreach($arrAkun as $row)
		{
			if($row['kelompok_akun'] == '4')
			{
				$pdf->RowNoBorder(array("",$row['nama_akun'],number_format($row['nilai_akun'],2,".",","),"",""));
				$jmlUtang += $row['nilai_akun'];
			}
			
		}
		
		$pdf->SetAligns(array('L','R','R','R','R'));
		$pdf->RowNoBorder(array("","Jumlah Utang Lancar","","",number_format($jmlUtang,2,".",",")));
		
		$pdf->SetFont('Arial','B',8);
		$pdf->SetAligns(array('L','R','R','R','R'));
		$pdf->RowNoBorder(array("","Jumlah Kewajiban","","",number_format($jmlUtang,2,".",",")));
		
		/*foreach($arrData as $row)
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
			*/
		$pdf->Output();	
	}
}
?>
