<?PHP
class cetakLaporanBPJSKaryawanPdf extends MainConf
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
		$jnsBpjs = $this->Request['jnsBpjs'];
		
		$month = $this->Request['bulan'];//date("m");
		$year = $this->Request['tahun'];//date("Y");
		
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
			
		$pdf=new reportKwitansi('P','mm','legal');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',8,4,12);	
		$pdf->SetFont('Arial','B',12);
		
		if($jnsBpjs == '0' )
			$pdf->Cell(0,5,'LAPORAN BPJS KESEHATAN','0',0,'C');
	    else
			$pdf->Cell(0,5,'LAPORAN BPJS KETENAGAKERJAAN','0',0,'C');
			
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
		$pdf->Ln(10);
		$pdf->SetWidths(array(10,30,60,30,30,30));
		$pdf->SetAligns(array('C','C','C','C','C','C'));
		$pdf->Row(array("NO","NIK","NAMA","PERUSAHAAN","KARYAWAN","TOTAL"));
		
		$sqlTrans = "SELECT
						tbm_karyawan.id,
						tbm_karyawan.nik,
						tbm_karyawan.nama,
						tbt_rekap_gaji_detail.gaji_pokok,
						tbt_rekap_gaji_detail.tunjangan_natura,
						tbt_rekap_gaji_detail.incentive,
						tbt_rekap_gaji_detail.tunjangan_jabatan,
						tbt_rekap_gaji_detail.tunjangan_komunikasi,
						tbt_rekap_gaji_detail.premi_karyawan,
						tbt_rekap_gaji_detail.total_gaji,
						tbt_rekap_gaji_detail.lembur_lpp_jam,
						tbt_rekap_gaji_detail.lembur_lpp_tarif,
						tbt_rekap_gaji_detail.lembur_lpp_total,
						tbt_rekap_gaji_detail.lembur_lppml_jam,
						tbt_rekap_gaji_detail.lembur_lppml_tarif,
						tbt_rekap_gaji_detail.lembur_lppml_total,
						tbt_rekap_gaji_detail.lembur_lpplk_jam,
						tbt_rekap_gaji_detail.lembur_lpplk_tarif,
						tbt_rekap_gaji_detail.lembur_lpplk_total,
						tbt_rekap_gaji_detail.total_lembur,
						tbt_rekap_gaji_detail.mangkir,
						tbt_rekap_gaji_detail.terlambat_masuk_kerja,
						tbt_rekap_gaji_detail.total_mangkir_terlambat,
						tbt_rekap_gaji_detail.total_gaji_kotor,
						tbt_rekap_gaji_detail.bpjs_kesehatan,
						tbt_rekap_gaji_detail.bpjs_ketenagakerjaan,
						tbt_rekap_gaji_detail.bpjs_kesehatan_perusahaan,
						tbt_rekap_gaji_detail.bpjs_ketenagakerjaan_perusahaan,
						tbt_rekap_gaji_detail.pinjaman,
						tbt_rekap_gaji_detail.kantin,
						tbt_rekap_gaji_detail.koperasi,
						tbt_rekap_gaji_detail.total_potongan,
						tbt_rekap_gaji_detail.jml_gaji_dibayarkan
					FROM
						tbt_rekap_gaji_detail
					INNER JOIN tbt_rekap_gaji ON tbt_rekap_gaji.id = tbt_rekap_gaji_detail.id_rekap
					INNER JOIN tbm_karyawan ON tbm_karyawan.id = tbt_rekap_gaji_detail.id_karyawan
					INNER JOIN tbm_jabatan ON tbm_jabatan.id = tbm_karyawan.id_jabatan
					WHERE
						tbm_karyawan.deleted = '0'
					AND tbt_rekap_gaji_detail.deleted = '0'
					AND tbm_jabatan.deleted ='0'
					AND tbt_rekap_gaji.bulan = '".$bln."' AND tbt_rekap_gaji.tahun = '".$thn."' ORDER BY tbm_karyawan.nama ASC";
		$arrTrans = $this->queryAction($sqlTrans,'S');		
		$pdf->SetAligns(array('C','L','L','R','R','R'));
		$pdf->SetFont('Arial','',6);
		$no = 1;
		$totalPerusahaan = 0;
		$totalKaryawan = 0;
		$totalGrand = 0;
		foreach($arrTrans as $rowTrans)
		{	
			if($jnsBpjs == '0')
			{
				$perusahaan = number_format($rowTrans['bpjs_kesehatan_perusahaan'],0,'.',',');
				$karyawan = number_format($rowTrans['bpjs_kesehatan'],0,'.',',');	
				$total = number_format($rowTrans['bpjs_kesehatan_perusahaan'] + $rowTrans['bpjs_kesehatan'],0,'.',',');
				$totalPerusahaan += $rowTrans['bpjs_kesehatan_perusahaan'];
				$totalKaryawan += $rowTrans['bpjs_kesehatan'];
				$totalGrand += $rowTrans['bpjs_kesehatan_perusahaan'] + $rowTrans['bpjs_kesehatan'];
		
			}
			elseif($jnsBpjs == '1')
			{
				$perusahaan = number_format($rowTrans['bpjs_ketenagakerjaan_perusahaan'],0,'.',',');
				$karyawan = number_format($rowTrans['bpjs_ketenagakerjaan'],0,'.',',');	
				$total = number_format($rowTrans['bpjs_ketenagakerjaan_perusahaan'] + $rowTrans['bpjs_ketenagakerjaan'],0,'.',',');
				
				$totalPerusahaan += $rowTrans['bpjs_ketenagakerjaan_perusahaan'];
				$totalKaryawan += $rowTrans['bpjs_ketenagakerjaan'];
				$totalGrand += $rowTrans['bpjs_ketenagakerjaan_perusahaan'] + $rowTrans['bpjs_ketenagakerjaan'];
			}
			
			$pdf->Row(array($no,$rowTrans['nik'],$rowTrans['nama'],$perusahaan,$karyawan,$total));
			$no++;
		}
		$pdf->SetFont('Arial','B',6);
		$pdf->Row(array("","","JUMLAH",number_format($totalPerusahaan,0,'.',','),number_format($totalKaryawan,0,'.',','),number_format($totalGrand,0,'.',',')));
			
		$pdf->Output();	
	}
}
?>
