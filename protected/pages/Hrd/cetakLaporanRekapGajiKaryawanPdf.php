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
		$pdf->Ln(10);
		
		
		$sqlDepartment = "SELECT
							tbm_department.id,
							tbm_department.nama
						FROM
							tbm_department
							INNER JOIN tbm_jabatan ON tbm_jabatan.id_department = tbm_department.id
							INNER JOIN tbm_karyawan ON tbm_karyawan.id_jabatan = tbm_jabatan.id
						WHERE
							tbm_department.deleted = '0'
							AND tbm_jabatan.deleted ='0'
							AND tbm_karyawan.deleted ='0'
							AND tbm_karyawan.aktif ='0'
							AND tbm_department.id_parent = '0' 
							GROUP BY tbm_department.id ";
							
		$arrDepartment = $this->queryAction($sqlDepartment,'S');
		
		$GrandKaryawan = 0;
		$GrandtotalGajiPokokCol = 0;
		$GrandtotalTunjanganNaturaCol = 0;
		$GrandtotalJmlIncentiveCol = 0;
		$GrandtotalTunjanganJabatanCol = 0;
		$GrandtotalTunjanganKomunikasiCol = 0;
		$GrandtotalPremiKaryawanCol = 0;
		$GrandtotalGajiKotorCol = 0;
		$GrandtotalLamaLemburLppCol = 0;
		$GrandtotalJmlLemburLppCol = 0;
		$GrandtotalLamaLemburLppmlCol = 0;
		$GrandtotalJmlLemburLppmlCol = 0;
		$GrandtotalLamaLemburLpplkCol = 0;
		$GrandtotalJmlLemburLpplkCol = 0;
		$GrandtotalLemburCol = 0;
		$GrandtotalMangkirCol = 0;
		$GrandtotalTelatCol = 0;
		$GrandtotalTelatMangkirCol = 0;
		$GrandtotalGajiKotorLemburCol = 0;
		$GrandtotalBpjsKesehatanCol = 0;
		$GrandtotalBpjsTenagaKerjaCol = 0;
		$GrandtotalJmlPinjamanCol = 0;
		$GrandtotalJmlKantinCol = 0;
		$GrandtotalJmlKoperasiCol = 0;
		$GrandtotalPotonganCol = 0;
		$GrandtotalGajiDibayarkanCol = 0;
		$row = 0;	
		foreach($arrDepartment as $rowDepartment)
		{
			if($row != 0)
				$pdf->Ln(15);
				
			$row++;
			$idDeparment = $rowDepartment['id'];
			$pdf->SetFont('Arial','B',6);
			$pdf->Cell(0,5,'Department : '.$rowDepartment['nama'],'0',0,'L');
			$pdf->Ln(5);
			$pdf->SetFont('Arial','B',3);
		
			$pdf->Cell(5,15,'No.','1',0,'C');
			$pdf->Cell(15,15,'Employee ID','1',0,'C');
			$pdf->Cell(15,15,'Nama','1',0,'C');
			$pdf->Cell(10,15,'Posisi','1',0,'C');
			$pdf->Cell(6,15,'Gol','1',0,'C');
			$pdf->Cell(6,15,'PTKP','1',0,'C');
			$pdf->Cell(15,15,'TMK','1',0,'C');
			$pdf->Cell(10,15,'Gaji','1',0,'C');
			$pdf->Cell(10,15,'Tunjangan','1',0,'C');
			$pdf->Cell(10,15,'Incentive','1',0,'C');
			$pdf->Cell(10,15,'Tunjangan','1',0,'C');
			$pdf->Cell(10,15,'Tunjangan','1',0,'C');
			$pdf->Cell(10,15,'Premi','1',0,'C');
			$pdf->Cell(10,15,'Total Gaji','1',0,'C');
			$pdf->Cell(72,5,'Lembur','1',0,'C');
			$pdf->Cell(10,15,'Total','1',0,'C');
			$pdf->Cell(10,15,'Mangkir','1',0,'C');
			$pdf->Cell(9,15,'Terlambat','1',0,'C');
			$pdf->Cell(15,15,'Total Mangkir &','1',0,'C');
			$pdf->Cell(15,15,'Total Gaji Kotor','1',0,'C');
			$pdf->Cell(40,5,'Potongan','1',0,'C');
			$pdf->Cell(8,15,'Total','1',0,'C');
			$pdf->Cell(15,15,'Gaji Dibayarkan','1',0,'C');
			$pdf->Ln(5);
			$pdf->Cell(5,10,'','0',0,'C');
			$pdf->Cell(15,10,'','0',0,'C');
			$pdf->Cell(15,10,'','0',0,'C');
			$pdf->Cell(10,10,'','0',0,'C');
			$pdf->Cell(6,10,'','0',0,'C');
			$pdf->Cell(6,10,'','0',0,'C');
			$pdf->Cell(15,10,'','',0,'C');
			$pdf->Cell(10,10,'Pokok','0',0,'C');
			$pdf->Cell(10,10,'Natura','0',0,'C');
			$pdf->Cell(10,10,'','0',0,'C');
			$pdf->Cell(10,10,'Jabatan','0',0,'C');
			$pdf->Cell(10,10,'Komunikasi','0',0,'C');
			$pdf->Cell(10,10,'Karyawan','0',0,'C');
			$pdf->Cell(10,10,'','0',0,'C');
			$pdf->Cell(24,5,'Tarif LPP','1',0,'C');
			$pdf->Cell(24,5,'Tarif LPPML','1',0,'C');
			$pdf->Cell(24,5,'Tarif LPPLK','1',0,'C');
			$pdf->Cell(10,10,'Lembur','0',0,'C');
			$pdf->Cell(10,10,'','0',0,'C');
			$pdf->Cell(9,10,'Masuk Kerja','0',0,'C');
			$pdf->Cell(15,10,'Terlambat Masuk','0',0,'C');
			$pdf->Cell(15,15,'','0',0,'C');
			$pdf->Cell(8,10,'BPJS Kesehatan','1',0,'C');
			$pdf->Cell(8,10,'BPJS','1',0,'C');
			$pdf->Cell(8,10,'Pinjaman','1',0,'C');
			$pdf->Cell(8,10,'Kantin','1',0,'C');
			$pdf->Cell(8,10,'Koperasi','1',0,'C');
			$pdf->Cell(8,10,'Potongan','0',0,'C');
			$pdf->Cell(15,15,'','0',0,'C');
			$pdf->Ln(5);
			$pdf->Cell(142,10,'','0',0,'C');
			$pdf->Cell(8,5,'Jam','1',0,'C');
			$pdf->Cell(8,5,'Rp/Tarif','1',0,'C');
			$pdf->Cell(8,5,'Total','1',0,'C');
			$pdf->Cell(8,5,'Jam','1',0,'C');
			$pdf->Cell(8,5,'Rp/Tarif','1',0,'C');
			$pdf->Cell(8,5,'Total','1',0,'C');
			$pdf->Cell(8,5,'Jam','1',0,'C');
			$pdf->Cell(8,5,'Rp/Tarif','1',0,'C');
			$pdf->Cell(8,5,'Total','1',0,'C');
			$pdf->Cell(59,10,'','0',0,'C');
			$pdf->Cell(8,15,'','0',0,'C');
			$pdf->Cell(8,5,'Ketenagakerjaan','0',0,'C');
			$pdf->Cell(8,10,'','0',0,'C');
			$pdf->Cell(8,10,'','0',0,'C');
			$pdf->Cell(8,10,'','0',0,'C');
			$pdf->Cell(8,10,'','0',0,'C');
			$pdf->Cell(15,15,'','0',0,'C');
			$pdf->Ln(5);
			$pdf->SetLn(2);
			$pdf->SetWidths(array(5,15,15,10,6,6,15,10,10,10,10,10,10,10,8,8,8,8,8,8,8,8,8,10,10,9,15,15,8,8,8,8,8,8,15));
			$pdf->SetAligns(array('C','L','L','L','C','C','L','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R'));
			$pdf->SetFont('Arial','',3);
			
			
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
				    AND tbm_karyawan.aktif = '0'
					AND tbm_jabatan.id_department = '".$idDeparment."' 
					AND tbt_rekap_gaji.bulan = '".$bln."' AND tbt_rekap_gaji.tahun = '".$thn."'";
							
			/*$sqlTrans = "SELECT 
							tbm_karyawan.id,
							tbm_karyawan.nik,
							tbm_karyawan.nama
						FROM 
							tbm_karyawan
							INNER JOIN tbm_jabatan ON tbm_jabatan.id = tbm_karyawan.id_jabatan
						WHERE
							tbm_karyawan.deleted = '0' 
							AND tbm_jabatan.deleted ='0'
							AND tbm_jabatan.id_department = '".$idDeparment."' ";*/
			$arrTrans = $this->queryAction($sqlTrans,'S');
			$no = 1;
			
			$totalGajiPokokCol = 0;
			$totalTunjanganNaturaCol = 0;
			$totalJmlIncentiveCol = 0;
			$totalTunjanganJabatanCol = 0;
			$totalTunjanganKomunikasiCol = 0;
			$totalPremiKaryawanCol = 0;
			$totalGajiKotorCol = 0;
			$totalLamaLemburLppCol = 0;
			$totalJmlLemburLppCol = 0;
			$totalLamaLemburLppmlCol = 0;
			$totalJmlLemburLppmlCol = 0;
			$totalLamaLemburLpplkCol = 0;
			$totalJmlLemburLpplkCol = 0;
			$totalLemburCol = 0;
			$totalMangkirCol = 0;
			$totalTelatCol = 0;
			$totalTelatMangkirCol = 0;
			$totalGajiKotorLemburCol = 0;
			$totalBpjsKesehatanCol = 0;
			$totalBpjsTenagaKerjaCol = 0;
			$totalJmlPinjamanCol = 0;
			$totalJmlKantinCol = 0;
			$totalJmlKoperasiCol = 0;
			$totalPotonganCol = 0;
			$totalGajiDibayarkanCol = 0;
										
			foreach($arrTrans as $row)
			{	
				
				$totalGajiKotor = 0;
				$totalTelatMangkir = 0;
				$totalPotongan = 0;
				$totalLembur = 0;
				$totalGajiKotorLembur = 0;
					$idK = $row['id'];
					$KaryawanRecord = KaryawanRecord::finder()->findByPk($idK);
					$JabatanRecord = JabatanRecord::finder()->findByPk($KaryawanRecord->id_jabatan);
					$DepartmentRecord = DepartmentRecord::finder()->findByPk($JabatanRecord->id_department);
					$SubDepartmentRecord = DepartmentRecord::finder()->findByPk($JabatanRecord->id_subdepartment);
					$KantorCabangRecord = KantorCabangRecord::finder()->findByPk($KaryawanRecord->id_cabang);
					$LevelDistribusiRecord = LevelDistribusiRecord::finder()->findByPk($JabatanRecord->id_level_distribusi);
					$GolonganKaryawanRecord = GolonganKaryawanRecord::finder()->findByPk($KaryawanRecord->id_golongan);
					
					$IncentiveRecord = IncentiveRecord::finder()->find('id_karyawan = ? AND bulan = ? AND tahun = ? ',$idK,$month,$year);
					
					if($KaryawanRecord->id_ptkp == '0')
						$snk = 'S';
					if($KaryawanRecord->id_ptkp == '1')
						$snk = 'K-0';
					if($KaryawanRecord->id_ptkp == '2')
						$snk = 'K-1';
					if($KaryawanRecord->id_ptkp == '3')
						$snk = 'K-2';
					if($KaryawanRecord->id_ptkp == '4')
						$snk = 'K-3';
				
					
					$totalGajiPokokCol += $row['gaji_pokok'];
					$totalTunjanganNaturaCol += $row['tunjangan_natura'];
					$totalJmlIncentiveCol += $row['incentive'];
					$totalTunjanganJabatanCol += $row['tunjangan_jabatan'];
					$totalTunjanganKomunikasiCol += $row['tunjangan_komunikasi'];
					$totalPremiKaryawanCol += $row['premi_karyawan'];
					$totalGajiKotorCol += $row['total_gaji'];
					$totalLamaLemburLppCol += $row['lembur_lpp_jam'];
					$totalJmlLemburLppCol += $row['lembur_lpp_total'];
					$totalLamaLemburLppmlCol += $row['lembur_lppml_jam'];
					$totalJmlLemburLppmlCol += $row['lembur_lppml_total'];
					$totalLamaLemburLpplkCol += $row['lembur_lpplk_jam'];
					$totalJmlLemburLpplkCol += $row['lembur_lpplk_total'];
					$totalLemburCol += $row['total_lembur'];
					$totalMangkirCol += $row['mangkir'];
					$totalTelatCol += $row['terlambat_masuk_kerja'];
					$totalTelatMangkirCol += $row['total_mangkir_terlambat'];
					$totalGajiKotorLemburCol += $row['total_gaji_kotor'];
					$totalBpjsKesehatanCol += $row['bpjs_kesehatan'];
					$totalBpjsTenagaKerjaCol += $row['bpjs_ketenagakerjaan'];
					$totalJmlPinjamanCol += $row['pinjaman'];
					$totalJmlKantinCol += $row['kantin'];
					$totalJmlKoperasiCol += $row['koperasi'];
					$totalPotonganCol += $row['total_potongan'];
					$totalGajiDibayarkanCol += $row['jml_gaji_dibayarkan'];
			
					$pdf->Row(array($no,
									$row['nik'],
									$row['nama'],
									$JabatanRecord->nama,
									$GolonganKaryawanRecord->nama,
									$snk,
									$this->ConvertDate($KaryawanRecord->tglawalkerja,'3'),
									number_format($row['gaji_pokok'],0,'.',','),
									number_format($row['tunjangan_natura'],0,'.',','),
									number_format($row['incentive'],0,'.',','),
									number_format($row['tunjangan_jabatan'],0,'.',','),
									number_format($row['tunjangan_komunikasi'],0,'.',','),
									number_format($row['premi_karyawan'],0,'.',','),
									number_format($row['total_gaji'],0,'.',','),
									$row['lembur_lpp_jam'],
									number_format($row['lembur_lpp_tarif'],0,'.',','),
									number_format($row['lembur_lpp_total'],0,'.',','),
									$row['lembur_lppml_jam'],
									number_format($row['lembur_lppml_tarif'],0,'.',','),
									number_format($row['lembur_lppml_total'],0,'.',','),
									$row['lembur_lpplk_jam'],
									number_format($row['lembur_lpplk_tarif'],0,'.',','),
									number_format($row['lembur_lpplk_total'],0,'.',','),
									number_format($row['total_lembur'],0,'.',','),
									number_format($row['mangkir'],0,'.',','),
									number_format($row['terlambat_masuk_kerja'],0,'.',','),
									number_format($row['total_mangkir_terlambat'],0,'.',','),
									number_format($row['total_gaji_kotor'],0,'.',','),
									number_format($row['bpjs_kesehatan'],0,'.',','),
									number_format($row['bpjs_ketenagakerjaan'],0,'.',','),
									number_format($row['pinjaman'],0,'.',','),
									number_format($row['kantin'],0,'.',','),
									number_format($row['koperasi'],0,'.',','),
									number_format($row['total_potongan'],0,'.',','),
									number_format($row['jml_gaji_dibayarkan'],0,'.',',')));
									
					
					$no++;				
				
			}
			
			$pdf->SetWidths(array(72,10,10,10,10,10,10,10,8,8,8,8,8,8,8,8,8,10,10,9,15,15,8,8,8,8,8,8,15));
					$pdf->SetAligns(array('C','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R'));
					$pdf->SetFont('Arial','B',3);
					$no--;
					$pdf->Row(array("Subtotal Karyawan : ". $no,
									number_format($totalGajiPokokCol,0,'.',','),
									number_format($totalTunjanganNaturaCol,0,'.',','),
									number_format($totalJmlIncentiveCol,0,'.',','),
									number_format($totalTunjanganJabatanCol,0,'.',','),
									number_format($totalTunjanganKomunikasiCol,0,'.',','),
									number_format($totalPremiKaryawanCol,0,'.',','),
									number_format($totalGajiKotorCol,0,'.',','),
									$totalLamaLemburLppCol,
									'',
									number_format($totalJmlLemburLppCol,0,'.',','),
									$totalLamaLemburLppmlCol,
									'',
									number_format($totalJmlLemburLppmlCol,0,'.',','),
									$totalLamaLemburLpplkCol,
									'',
									number_format($totalJmlLemburLpplkCol,0,'.',','),
									number_format($totalLemburCol,0,'.',','),
									number_format($totalMangkirCol,0,'.',','),
									number_format($totalTelatCol,0,'.',','),
									number_format($totalTelatMangkirCol,0,'.',','),
									number_format($totalGajiKotorLemburCol,0,'.',','),
									number_format($totalBpjsKesehatanCol,0,'.',','),
									number_format($totalBpjsTenagaKerjaCol,0,'.',','),
									number_format($totalJmlPinjamanCol,0,'.',','),
									number_format($totalJmlKantinCol,0,'.',','),
									number_format($totalJmlKoperasiCol,0,'.',','),
									number_format($totalPotonganCol,0,'.',','),
									number_format($totalGajiDibayarkanCol,0,'.',',')));
										
			$GrandKaryawan += $no;
			$GrandtotalGajiPokokCol += $totalGajiPokokCol;
			$GrandtotalTunjanganNaturaCol += $totalTunjanganNaturaCol;
			$GrandtotalJmlIncentiveCol += $totalJmlIncentiveCol;
			$GrandtotalTunjanganJabatanCol += $totalTunjanganJabatanCol;
			$GrandtotalTunjanganKomunikasiCol += $totalTunjanganKomunikasiCol;
			$GrandtotalPremiKaryawanCol += $totalPremiKaryawanCol;
			$GrandtotalGajiKotorCol += $totalGajiKotorCol;
			$GrandtotalLamaLemburLppCol += $totalLamaLemburLppCol;
			$GrandtotalJmlLemburLppCol += $totalJmlLemburLppCol;
			$GrandtotalLamaLemburLppmlCol += $totalLamaLemburLppmlCol;
			$GrandtotalJmlLemburLppmlCol += $totalJmlLemburLppmlCol;
			$GrandtotalLamaLemburLpplkCol += $totalLamaLemburLpplkCol;
			$GrandtotalJmlLemburLpplkCol += $totalJmlLemburLpplkCol;
			$GrandtotalLemburCol += $totalLemburCol;
			$GrandtotalMangkirCol += $totalMangkirCol;
			$GrandtotalTelatCol += $totalTelatCol;
			$GrandtotalTelatMangkirCol += $totalTelatMangkirCol;
			$GrandtotalGajiKotorLemburCol += $totalGajiKotorLemburCol;
			$GrandtotalBpjsKesehatanCol += $totalBpjsKesehatanCol;
			$GrandtotalBpjsTenagaKerjaCol += $totalBpjsTenagaKerjaCol;
			$GrandtotalJmlPinjamanCol += $totalJmlPinjamanCol;
			$GrandtotalJmlKantinCol += $totalJmlKantinCol;
			$GrandtotalJmlKoperasiCol += $totalJmlKoperasiCol;
			$GrandtotalPotonganCol += $totalPotonganCol;
			$GrandtotalGajiDibayarkanCol += $totalGajiDibayarkanCol;
		
			
		}
		$pdf->SetWidths(array(72,10,10,10,10,10,10,10,8,8,8,8,8,8,8,8,8,10,10,9,15,15,8,8,8,8,8,8,15));
					$pdf->SetAligns(array('C','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R','R'));
					$pdf->SetFont('Arial','B',3);
					$no--;
					$pdf->Row(array("Grandtotal Karyawan : ". $GrandKaryawan,
									number_format($GrandtotalGajiPokokCol,0,'.',','),
									number_format($GrandtotalTunjanganNaturaCol,0,'.',','),
									number_format($GrandtotalJmlIncentiveCol,0,'.',','),
									number_format($GrandtotalTunjanganJabatanCol,0,'.',','),
									number_format($GrandtotalTunjanganKomunikasiCol,0,'.',','),
									number_format($GrandtotalPremiKaryawanCol,0,'.',','),
									number_format($GrandtotalGajiKotorCol,0,'.',','),
									$GrandtotalLamaLemburLppCol,
									'',
									number_format($GrandtotalJmlLemburLppCol,0,'.',','),
									$GrandtotalLamaLemburLppmlCol,
									'',
									number_format($GrandtotalJmlLemburLppmlCol,0,'.',','),
									$GrandtotalLamaLemburLpplkCol,
									'',
									number_format($GrandtotalJmlLemburLpplkCol,0,'.',','),
									number_format($GrandtotalLemburCol,0,'.',','),
									number_format($GrandtotalMangkirCol,0,'.',','),
									number_format($GrandtotalTelatCol,0,'.',','),
									number_format($GrandtotalTelatMangkirCol,0,'.',','),
									number_format($GrandtotalGajiKotorLemburCol,0,'.',','),
									number_format($GrandtotalBpjsKesehatanCol,0,'.',','),
									number_format($GrandtotalBpjsTenagaKerjaCol,0,'.',','),
									number_format($GrandtotalJmlPinjamanCol,0,'.',','),
									number_format($GrandtotalJmlKantinCol,0,'.',','),
									number_format($GrandtotalJmlKoperasiCol,0,'.',','),
									number_format($GrandtotalPotonganCol,0,'.',','),
									number_format($GrandtotalGajiDibayarkanCol,0,'.',',')));
		
		
		//$sql = $session['cetakLapPembelianTbsSql'];
		//$arrData=$this->queryAction($sql,'S');
		//foreach($arrData as $row)
		//{
		//}
			
		$pdf->Output();	
	}
}
?>
