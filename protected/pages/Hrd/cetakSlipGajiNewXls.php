<?php
class cetakSlipGajiNewXls extends XlsGen
{
	public function onLoad($param)
	{		
		$month = $this->Request['bulan'];//date("m");
		$year = $this->Request['tahun'];//date("Y");
		$nik = $this->Request['nik'];
		$idK = $this->Request['id'];
		
		if($month == '01')
			$nmBulan = "Januari";
		elseif($month == '02')
			$nmBulan = "Februari";
		elseif($month == '03')
			$nmBulan = "Maret";
		elseif($month == '04')
			$nmBulan = "April";
		elseif($month == '05')
			$nmBulan = "Mei";
		elseif($month == '06')
			$nmBulan = "Juni";
		elseif($month == '07')
			$nmBulan = "Juli";
		elseif($month == '08')
			$nmBulan = "Agustus";
		elseif($month == '09')
			$nmBulan = "September";
		elseif($month == '10')
			$nmBulan = "Oktober";
		elseif($month == '11')
			$nmBulan = "Novemver";
		elseif($month == '12')
			$nmBulan = "Desember";
		
		$file = 'SlipGajiKaryawan.xls';
		
		//http headers	
		$this->HeaderingExcel($file);
		
		//membuat workbook
		$workbook=new Workbook("-");
		
		//membuat worksheet pertama
		$worksheet1= & $workbook->add_worksheet('Slip Gaji Karyawan');
		
		$baris=0;
		$kolom=0;
		
		//set lebar tiap kolom
		$this->AddWS($worksheet1,'c','5',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','2',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','20',$baris,$kolom); $baris++; $kolom++;
		
		$this->AddWS($worksheet1,'c','5',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','18',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','2',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','5',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		
		$this->AddWS($worksheet1,'c','5',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','20',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','2',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		
		$frmtTitleLeft =  & $workbook->add_format();
		$left= $this->AddFormat($frmtTitleLeft,'b','1','12');
		$left= $this->AddFormat($frmtTitleLeft,'bd','0','');
		$left= $this->AddFormat($frmtTitleLeft,'HA','left','');
		
		$frmtTitleLeft10 =  & $workbook->add_format();
		$left= $this->AddFormat($frmtTitleLeft10,'b','1','10');
		$left= $this->AddFormat($frmtTitleLeft10,'bd','0','');
		$left= $this->AddFormat($frmtTitleLeft10,'HA','left','');
		$left= $this->AddFormat($frmtTitleLeft10,'WR','1','');
		
		$frmtTitleRight10 =  & $workbook->add_format();
		$right= $this->AddFormat($frmtTitleRight10,'b','1','10');
		$right= $this->AddFormat($frmtTitleRight10,'bd','0','');
		$right= $this->AddFormat($frmtTitleRight10,'HA','right','');
		$right= $this->AddFormat($frmtTitleRight10,'WR','1','');
		
		$frmtLeft =  & $workbook->add_format();
		$left= $this->AddFormat($frmtLeft,'b','1','10');
		$left= $this->AddFormat($frmtLeft,'bd','0','');
		$left= $this->AddFormat($frmtLeft,'HA','left','');		
		
		$frmtCenter =  & $workbook->add_format();
		$center= $this->AddFormat($frmtCenter,'b','1','10');
		$center= $this->AddFormat($frmtCenter,'bd','0','');
		$center= $this->AddFormat($frmtCenter,'HA','center','');
		
		$frmtWrap =  & $workbook->add_format();
		$wrap= $this->AddFormat($frmtWrap,'b','1','10');
		$wrap= $this->AddFormat($frmtWrap,'bd','0','');
		$wrap= $this->AddFormat($frmtWrap,'HA','center','');
		$wrap= $this->AddFormat($frmtWrap,'WR','1','');
		
		
		$baris=0;
		$kolom=0;
		
		$frmtLeft =  & $workbook->add_format();
		$left= $this->AddFormat($frmtLeft,'','1','10');
		$left= $this->AddFormat($frmtLeft,'bd','0','');
		$left= $this->AddFormat($frmtLeft,'HA','left','');
		$left= $this->AddFormat($frmtLeft,'WR','1','');
		
		$frmtCenterHeader =  & $workbook->add_format();
		$centerHeader= $this->AddFormat($frmtCenterHeader,'b','1','10');
		$centerHeader= $this->AddFormat($frmtCenterHeader,'bd','0','');
		$centerHeader= $this->AddFormat($frmtCenterHeader,'HA','center','');
		$centerHeader= $this->AddFormat($frmtCenterHeader,'WR','1','');
		
		$frmtCenter =  & $workbook->add_format();
		$center= $this->AddFormat($frmtCenter,'','1','10');
		$center= $this->AddFormat($frmtCenter,'bd','0','');
		$center= $this->AddFormat($frmtCenter,'HA','center','');
		$center= $this->AddFormat($frmtCenter,'WR','1','');
		
		$frmtRight =  & $workbook->add_format();
		$right= $this->AddFormat($frmtRight,'','1','10');
		$right= $this->AddFormat($frmtRight,'bd','0','');
		$right= $this->AddFormat($frmtRight,'HA','right','');
		
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
		
		$worksheet1->write_string($baris,$kolom,"PT SINAR HALOMOAN",$frmtCenterHeader);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+14);
		
		$baris++;
		$worksheet1->write_string($baris,$kolom,"KANTOR DIREKSI PASIR JAE",$frmtCenterHeader);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+14);	
		
		$baris++;
		$worksheet1->write_string($baris,$kolom,"DEPARTEMEN ADMINISTRASI, KEUANGAN DAN SDM",$frmtCenterHeader);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+14);
		
		$baris++;
		$worksheet1->write_string($baris,$kolom,"Desa Pasir Jae, Kecamatan Sosa, Kabupaten Padang Lawas",$frmtCenter);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+14);
		
		$baris++;
		$baris++;
		$worksheet1->write_string($baris,$kolom,"Slip gaji Karyawan",$frmtCenterHeader);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+14);
		
		$tglMasukKerja = $this->ConvertDate($KaryawanRecord->tglawalkerja,'3');
		$baris = 7;
		$kolom = 1;
		
		$worksheet1->write_string($baris,$kolom,"NIK",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,$KaryawanRecord->nik,$frmtLeft);$kolom++;
		
		$baris++;
		$kolom = 1;
		$worksheet1->write_string($baris,$kolom,"Nama",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,$KaryawanRecord->nama,$frmtTitleLeft10);$kolom++;
		
		$baris++;
		$kolom = 1;
		$worksheet1->write_string($baris,$kolom,"Jabatan",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,$JabatanRecord->nama,$frmtLeft);$kolom++;
		
		$baris++;
		$kolom = 1;
		$worksheet1->write_string($baris,$kolom,"Golongan",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,$GolonganKaryawanRecord->nama,$frmtLeft);$kolom++;
		
		$baris++;
		$kolom = 1;
		$worksheet1->write_string($baris,$kolom,"SNK",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,$snk,$frmtLeft);$kolom++;
		
		$baris++;
		$kolom = 1;
		$worksheet1->write_string($baris,$kolom,"TMK",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,$tglMasukKerja,$frmtLeft);$kolom++;
		
		$baris++;
		$kolom = 1;
		$worksheet1->write_string($baris,$kolom,"Periode",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,$nmBulan.' '.$year,$frmtTitleLeft10);$kolom++;
		
		$gajiKotor = 0;
		$baris = 7;
		$kolom = 5;
		$worksheet1->write_string($baris,$kolom,"Gaji Pokok",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($GolonganKaryawanRecord->gaji_pokok,0,'.',','),$frmtRight);
		$worksheet1->write_string($baris,$kolom+1,"",$frmtRight);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+1);$kolom++;
		$gajiKotor += $GolonganKaryawanRecord->gaji_pokok;
		
		$baris++;
		$kolom = 5;
		$worksheet1->write_string($baris,$kolom,"Tunjangan Natura",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($KaryawanRecord->tunjangan_natura,0,'.',','),$frmtRight);
		$worksheet1->write_string($baris,$kolom+1,"",$frmtRight);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+1);$kolom++;
		$gajiKotor += $KaryawanRecord->tunjangan_natura;
		
		$baris++;
		$kolom = 5;
		$worksheet1->write_string($baris,$kolom,"Incentive",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($IncentiveRecord->jml_incentive,0,'.',','),$frmtRight);
		$worksheet1->write_string($baris,$kolom+1,"",$frmtRight);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+1);$kolom++;
		$gajiKotor += $IncentiveRecord->jml_incentive;
		
		$baris++;
		$kolom = 5;
		$worksheet1->write_string($baris,$kolom,"Tunjangan Jabatan",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($JabatanRecord->tunjangan_jabatan,0,'.',','),$frmtRight);
		$worksheet1->write_string($baris,$kolom+1,"",$frmtRight);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+1);$kolom++;
		$gajiKotor += $JabatanRecord->tunjangan_jabatan;
		
		$baris++;
		$kolom = 5;
		$worksheet1->write_string($baris,$kolom,"Tunjangan Komunikasi",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($JabatanRecord->tunjangan_komunikasi,0,'.',','),$frmtRight);
		$worksheet1->write_string($baris,$kolom+1,"",$frmtRight);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+1);$kolom++;
		$gajiKotor += $JabatanRecord->tunjangan_komunikasi;
		
		$baris++;
		$kolom = 5;
		$worksheet1->write_string($baris,$kolom,"Premi Karyawan",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($JabatanRecord->premi_karyawan,0,'.',','),$frmtRight);
		$worksheet1->write_string($baris,$kolom+1,"",$frmtRight);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+1);$kolom++;
		$gajiKotor += $JabatanRecord->premi_karyawan;
		
		$baris++;
		$kolom = 5;
		$worksheet1->write_string($baris,$kolom,"Jumlah",$frmtTitleLeft10);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($gajiKotor,0,'.',','),$frmtTitleRight10);
		$worksheet1->write_string($baris,$kolom+1,"",$frmtTitleRight10);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+1);$kolom++;
		
		$baris++;
		$baris++;
		$kolom = 5;
		$worksheet1->write_string($baris,$kolom,"Lembur",$frmtTitleLeft10);$kolom++;
		$worksheet1->write_string($baris,$kolom,"",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,"Jam",$frmtCenterHeader);$kolom++;
		$worksheet1->write_string($baris,$kolom,"Tarif",$frmtCenterHeader);$kolom++;
		$worksheet1->write_string($baris,$kolom,"Jumlah Bayar",$frmtCenterHeader);$kolom++;
		
		$totalLembur = 0;
		$sqlLpp = "SELECT
						SUM(
							tbt_lembur_karyawan.lama_lembur
						) AS lama_lembur
					FROM
						tbt_lembur_karyawan
					WHERE
						tbt_lembur_karyawan.id_karyawan = '$idK'
					AND MONTH(tbt_lembur_karyawan.tgl) = '$month'
					AND YEAR(tbt_lembur_karyawan.tgl) = '$year'
					AND tbt_lembur_karyawan.jns_lembur = '1'
					AND tbt_lembur_karyawan.deleted != '1' ";
		$arrLpp = $this->queryAction($sqlLpp,'S');
		$tarifLpp = (1/173) * $GolonganKaryawanRecord->gaji_pokok;
		$jmlLpp = $arrLpp[0]['lama_lembur'] * $tarifLpp;
		$totalLembur += $jmlLpp;
		
		$baris++;
		$kolom = 5;
		$worksheet1->write_string($baris,$kolom,"LPP",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,$arrLpp[0]['lama_lembur'],$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($tarifLpp,0,'.',','),$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($jmlLpp,0,'.',','),$frmtRight);$kolom++;
		
		$sqlLppml = "SELECT
						SUM(
							tbt_lembur_karyawan.lama_lembur
						) AS lama_lembur
					FROM
						tbt_lembur_karyawan
					WHERE
						tbt_lembur_karyawan.id_karyawan = '$idK'
					AND MONTH(tbt_lembur_karyawan.tgl) = '$month'
					AND YEAR(tbt_lembur_karyawan.tgl) = '$year'
					AND tbt_lembur_karyawan.jns_lembur = '2'
					AND tbt_lembur_karyawan.deleted != '1' ";
		$arrLppml = $this->queryAction($sqlLppml,'S');
		$tarifLppml = ((1/173) * $GolonganKaryawanRecord->gaji_pokok) * 1.5;
		$jmlLppml = $arrLppml[0]['lama_lembur'] * $tarifLppml;
		$totalLembur += $jmlLppml;
		$baris++;
		$kolom = 5;
		$worksheet1->write_string($baris,$kolom,"LPPML",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,$arrLppml[0]['lama_lembur'],$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($tarifLppml,0,'.',','),$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($jmlLppml,0,'.',','),$frmtRight);$kolom++;
		
		$sqlLpplk = "SELECT
						SUM(
							tbt_lembur_karyawan.lama_lembur
						) AS lama_lembur
					FROM
						tbt_lembur_karyawan
					WHERE
						tbt_lembur_karyawan.id_karyawan = '$idK'
					AND MONTH(tbt_lembur_karyawan.tgl) = '$month'
					AND YEAR(tbt_lembur_karyawan.tgl) = '$year'
					AND tbt_lembur_karyawan.jns_lembur = '3'
					AND tbt_lembur_karyawan.deleted != '1' ";
		$arrLpplk = $this->queryAction($sqlLpplk,'S');
		$tarifLpplk = ((1/173) * $GolonganKaryawanRecord->gaji_pokok) * 2;
		$jmlLpplk = $arrLpplk[0]['lama_lembur'] * $tarifLpplk;
		$totalLembur += $jmlLpplk;
		$baris++;
		$kolom = 5;
		$worksheet1->write_string($baris,$kolom,"LPPLK",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,$arrLpplk[0]['lama_lembur'],$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($tarifLpplk,0,'.',','),$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($jmlLpplk,0,'.',','),$frmtRight);$kolom++;
		
		$baris++;
		$kolom = 5;
		$worksheet1->write_string($baris,$kolom,"Total Lembur",$frmtTitleLeft10);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,"",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,"",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($totalLembur,0,'.',','),$frmtTitleRight10);$kolom++;
		$gajiKotor += $totalLembur;
		
		$baris++;
		$baris++;
		$kolom = 5;
		$worksheet1->write_string($baris,$kolom,"Total Gaji",$frmtTitleLeft10);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($gajiKotor,0,'.',','),$frmtTitleRight10);
		$worksheet1->write_string($baris,$kolom+1,"",$frmtRight);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+1);$kolom++;
		
		
		$totalPotongan = 0;
		$baris = 7;
		$kolom = 11;
		$worksheet1->write_string($baris,$kolom,"Potongan",$frmtTitleLeft10);$kolom++;
		
		if($KaryawanRecord->st_bpjs_ketenagakerjaan == '1')
			$bpjsTenagaKerja = $GolonganKaryawanRecord->gaji_pokok * (2/100);
		else
			$bpjsTenagaKerja = 0;
		$baris++;
		$kolom = 11;
		$worksheet1->write_string($baris,$kolom,"Bpjs Ketenagakerjaan",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($bpjsTenagaKerja,0,'.',','),$frmtTitleRight10);$kolom++;
		$totalPotongan += $bpjsTenagaKerja;
		
		if($KaryawanRecord->st_bpjs_kesehatan == '1')
		{
			if($KaryawanRecord->tambahan_keluarga > 0)
				$multiplyBpjs = $KaryawanRecord->tambahan_keluarga + 1;
			else
				$multiplyBpjs = 1;
				
			$bpjsKesehatan = ($GolonganKaryawanRecord->gaji_pokok * (1/100)) * $multiplyBpjs;
		}
		else
			$bpjsKesehatan = 0;
			
		$baris++;
		$kolom = 11;
		$worksheet1->write_string($baris,$kolom,"Bpjs Kesehatan",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($bpjsKesehatan,0,'.',','),$frmtTitleRight10);$kolom++;
		$totalPotongan += $bpjsKesehatan;
		
		$sqlPinjaman = "SELECT
							SUM(
								tbt_expense_karyawan.jml_expense
							) AS jml_expense
						FROM
							tbt_expense_karyawan
						WHERE
							tbt_expense_karyawan.id_karyawan = '$idK'
						AND tbt_expense_karyawan.jns_expense = '1'
						AND MONTH(tbt_expense_karyawan.tgl) = '$month'
						AND YEAR(tbt_expense_karyawan.tgl) = '$year'
						AND tbt_expense_karyawan.deleted != '1' ";
		$arrPinjaman = $this->queryAction($sqlPinjaman,'S');
		$jmlPinjaman = $arrPinjaman[0]['jml_expense'];
		$baris++;
		$kolom = 11;
		$worksheet1->write_string($baris,$kolom,"Pinjaman",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($jmlPinjaman,0,'.',','),$frmtRight);$kolom++;
		$totalPotongan += $jmlPinjaman;
		
		$sqlKantin = "SELECT
							SUM(
								tbt_expense_karyawan.jml_expense
							) AS jml_expense
						FROM
							tbt_expense_karyawan
						WHERE
							tbt_expense_karyawan.id_karyawan = '$idK'
						AND tbt_expense_karyawan.jns_expense = '2'
						AND MONTH(tbt_expense_karyawan.tgl) = '$month'
						AND YEAR(tbt_expense_karyawan.tgl) = '$year'
						AND tbt_expense_karyawan.deleted != '1' ";
		$arrKantin = $this->queryAction($sqlKantin,'S');
		$jmlKantin = $arrKantin[0]['jml_expense'];
		$baris++;
		$kolom = 11;
		$worksheet1->write_string($baris,$kolom,"Kantin",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($jmlKantin,0,'.',','),$frmtRight);$kolom++;
		$totalPotongan += $jmlKantin;
		
		$sqlKoperasi = "SELECT
							SUM(
								tbt_expense_karyawan.jml_expense
							) AS jml_expense
						FROM
							tbt_expense_karyawan
						WHERE
							tbt_expense_karyawan.id_karyawan = '$idK'
						AND tbt_expense_karyawan.jns_expense = '3'
						AND MONTH(tbt_expense_karyawan.tgl) = '$month'
						AND YEAR(tbt_expense_karyawan.tgl) = '$year'
						AND tbt_expense_karyawan.deleted != '1' ";
		$arrKoperasi = $this->queryAction($sqlKoperasi,'S');
		$jmlKoperasi = $arrKoperasi[0]['jml_expense'];
		$baris++;
		$kolom = 11;
		$worksheet1->write_string($baris,$kolom,"Koperasi",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($jmlKoperasi,0,'.',','),$frmtRight);$kolom++;
		$totalPotongan += $jmlKoperasi;
		
		$sqlMangkir = "SELECT
							COUNT(
								tbm_jadwal.id
							) AS mangkir
						FROM
							tbm_jadwal
						WHERE
							tbm_jadwal.idkaryawan = '$idK'
						AND tbm_jadwal.st_hadir = '1'
						AND MONTH(tbm_jadwal.tanggal) = '$month'
						AND YEAR(tbm_jadwal.tanggal) = '$year' ";
		$arrMangkir = $this->queryAction($sqlMangkir,'S');
		$jmlMangkir = $arrMangkir[0]['mangkir'];
		$totalMangkir = ($GolonganKaryawanRecord->gaji_pokok / 25 / 7) * $jmlMangkir;
		$baris++;
		$kolom = 11;
		$worksheet1->write_string($baris,$kolom,"Mangkir (M)",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($totalMangkir,0,'.',','),$frmtRight);$kolom++;
		$totalPotongan += $totalMangkir;
		
		$sqlTelat = "SELECT
							COUNT(
								tbm_jadwal.id
							) AS telat
						FROM
							tbm_jadwal
						WHERE
							tbm_jadwal.idkaryawan = '$idK'
						AND tbm_jadwal.st_hadir = '0'
						AND tbm_jadwal.st_telat = '1'
						AND MONTH(tbm_jadwal.tanggal) = '$month'
						AND YEAR(tbm_jadwal.tanggal) = '$year' ";
		$arrTelat = $this->queryAction($sqlTelat,'S');
		$jmlTelat = $arrTelat[0]['telat'];
		$totalTelat = ($GolonganKaryawanRecord->gaji_pokok / 25 / 7) * $jmlTelat;
		$baris++;
		$kolom = 11;
		$worksheet1->write_string($baris,$kolom,"Terlambat Masuk Kerja",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtLeft);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($totalTelat,0,'.',','),$frmtRight);$kolom++;
		$totalPotongan += $totalTelat;
		
		$baris++;
		$kolom = 11;
		$worksheet1->write_string($baris,$kolom,"Total Potongan",$frmtTitleLeft10);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtTitleLeft10);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($totalPotongan,0,'.',','),$frmtTitleRight10);$kolom++;
		
		if($gajiKotor >= $totalPotongan)
			$gajiBersih =  $gajiKotor - $totalPotongan;
		else
			$gajiBersih = 0 ;
			
		$baris += 4;
		$kolom = 11;
		$worksheet1->write_string($baris,$kolom,"Sisa Gaji",$frmtTitleLeft10);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtTitleLeft10);$kolom++;
		$worksheet1->write_string($baris,$kolom,number_format($gajiBersih,0,'.',','),$frmtTitleRight10);$kolom++;
		//$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+1);
		
		$tglNow = $this->ConvertDate(date("Y-m-d"),'3');
		$baris=22;
		$kolom = 1;
		$worksheet1->write_string($baris,$kolom,"Pasir Jae : ".$tglNow,$frmtCenterHeader);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+3);
		$baris++;
		$worksheet1->write_string($baris,$kolom,"PT SINAR HALOMOAN",$frmtCenterHeader);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+3);
		
		$baris += 4;	
		
		$worksheet1->write_string($baris,$kolom,"PUTRA MAHKOTA ALAM HASIBUAN, SE",$frmtCenter);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+3);
		$baris++;
		$worksheet1->write_string($baris,$kolom,"DIREKTUR UTAMA",$frmtCenterHeader);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+3);
		
		$baris=22;
		$kolom = 5;
		$worksheet1->write_string($baris,$kolom,"Catatan",$frmtTitleLeft10);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtTitleLeft10);
		
		$baris=23;
		$kolom = 11;
		$worksheet1->write_string($baris,$kolom,"Diterima Oleh,-",$frmtCenterHeader);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+2);
		
		$baris += 4;
		$worksheet1->write_string($baris,$kolom,"--------------------------------------------------------------------",$frmtCenterHeader);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+2);
		
		$baris++;
		$worksheet1->write_string($baris,$kolom,"Nama : ",$frmtTitleLeft10);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+2);
		$workbook->close(); 
	}
	
	
	public function cekFormula($idPayroll,$pendapatan,$umk,$loyalty,$hariKerja,$kehadiran,$level,$month,$year,$idKaryawan,$ump,$bpjs,$dinas,$jatahCuti)
	{
		$queryFormula = "SELECT
										tbm_payroll_formula.id,
										tbm_payroll_formula.payroll_id,
										tbm_payroll_formula.parameter_id,
										tbm_payroll_formula.operator_id,
										tbm_payroll_formula.order_id
									FROM 
										tbm_payroll_formula
									WHERE
										tbm_payroll_formula.payroll_id = '$idPayroll' 
									ORDER BY order_id ASC ";
		$queryRows =  $this->queryAction($queryFormula,'S');
		if(count($queryRows) > 1)
		{
			$rumus = '';
			foreach($queryRows as $queryData)
			{
				$newParameter = 0;
				$orderId = $queryData['order_id'];
				$payrollId = $queryData['payroll_id'];
				$parameterId = $queryData['parameter_id'];
				$operatorId = $queryData['operator_id'];
				
				if($parameterId == '-2')
					$parameter = $loyalty;
				elseif($parameterId == '-3')
					$parameter = $hariKerja;
				elseif($parameterId == '-4')
					$parameter = $kehadiran;
				elseif($parameterId == '-5')
					$parameter = $level / 100;
				elseif($parameterId == '-6')
					$parameter = $umk;
				elseif($parameterId == '-7')
					$parameter = $pendapatan;
				elseif($parameterId == '-9')
					$parameter = $ump;
				elseif($parameterId == '-10')
					$parameter = $bpjs;
				elseif($parameterId == '-11')
					$parameter = $dinas;
				elseif($parameterId == '-12')
				{
					$queryCuti ="SELECT
										COUNT(tbm_jadwal.id) AS jml_cuti
												FROM
													tbm_jadwal
												INNER JOIN tbm_payrol ON tbm_payrol.id = tbm_jadwal.st_hadir
												WHERE
													tbm_payrol.subkategori = '4'
												AND tbm_payrol.attendance_id = '2'
												AND tbm_jadwal.idkaryawan = '$idKaryawan' 
												AND YEAR(tbm_jadwal.tanggal) = '$year' ";
					
					$rowCuti = $this->queryAction($queryCuti,'S');
					$jmlCuti = $rowCuti[0]['jml_cuti'];
					
					if($jmlCuti < $jatahCuti && $jatahCuti > 0)
					{
						$sisaCuti = $jatahCuti - $jmlCuti;
						$parameter = $sisaCuti;
					}
					else
					{
						$parameter = 0;
					}
				}
				elseif($parameterId == '-8')
				{
					$querylembur = "SELECT
													SUM(tbm_lembur.lama_lembur) AS lembur
												FROM
													tbm_lembur
												WHERE
													id_karyawan = '$idKaryawan' 
													AND MONTH(tbm_lembur.tgl_lembur) = '$month' 
													AND YEAR(tbm_lembur.tgl_lembur) = '$year'";
					$rowLembur = $this->queryAction($querylembur,'S');
					if(count($rowLembur) > 0)
					{
						$parameter = $rowLembur[0]['lembur'];
					}
					else
					{
						$parameter = 0;
					}
				}
				else
				{
					$queryPayroll = "SELECT
										tbm_payrol.id,
										tbm_payrol.distribusi,
										tbm_payrol.subkategori,
										tbm_payrol.attendance_id
									FROM 
										tbm_payrol
									WHERE
										tbm_payrol.id = '$parameterId' ";
					$rowPayroll = $this->queryAction($queryPayroll,'S');
					if(count($rowPayroll) > 0)
					{
						$subType = $rowPayroll[0]['subkategori'];
						$attendid = $rowPayroll[0]['attendance_id'];
						if($subType == '3')
						{
							$querySantunanCek = "SELECT
																	tbm_santunan.id_karyawan,
																	tbm_santunan.id_payroll,
																	tbm_santunan.tgl_santunan
																FROM
																	tbm_santunan
																WHERE
																	tbm_santunan.id_payroll = '$parameterId' 
																	AND tbm_santunan.id_karyawan = '$idKaryawan' 
																	AND MONTH(tbm_santunan.tgl_santunan) = '$month'
																	AND YEAR(tbm_santunan.tgl_santunan) = '$year' ";
							$rowSantunan =  $this->queryAction($querySantunanCek,'S');
								if(count($rowSantunan) > 0)
								{
									$newParameter = count($rowSantunan);
								}
							
						}
						elseif($subType == '4')
						{
							if($attendid == '1' || $attendid == '2' || $attendid == '3' || $attendid == '4' || $attendid == '5')
							{
								$queryPenaltyCek = "SELECT
																	tbm_jadwal.tglbuat,
																	tbm_jadwal.idkaryawan,
																	tbm_jadwal_penalty.id
																FROM
																	tbm_jadwal
																INNER JOIN tbm_jadwal_penalty ON tbm_jadwal_penalty.idjadwal = tbm_jadwal.id
																WHERE
																	tbm_jadwal_penalty.payroll_id = '$parameterId' 
																	AND tbm_jadwal.idkaryawan = '$idKaryawan' 
																	AND MONTH(tbm_jadwal.tglbuat) = '$month' 
																	AND YEAR(tbm_jadwal.tglbuat) = '$year' ";
								$rowPenalty = $this->queryAction($queryPenaltyCek,'S');
								if(count($rowPenalty) > 0)
								{
									$newParameter = count($rowPenalty);
								}
							}
						}
						elseif($subType == '7')
						{
							$querySanksiCek = "SELECT
																	tbt_sanksi.id_karyawan,
																	tbt_sanksi.payroll_id,
																	tbt_sanksi.tgl_sanksi
																FROM
																	tbt_sanksi
																WHERE
																	tbt_sanksi.payroll_id = '$parameterId' 
																	AND tbt_sanksi.id_karyawan = '$idKaryawan' 
																	AND MONTH(tbt_sanksi.tgl_sanksi) = '$month'
																	AND YEAR(tbt_sanksi.tgl_sanksi) = '$year' ";
							$rowSanksi = $this->queryAction($querySanksiCek,'S');
							if(count($rowSanksi) > 0)
							{
								$newParameter = count($rowSanksi);
							}
							
						}
						else
						{
							$newParameter = 0;
						}
							
							$parameter = $rowPayroll[0]['distribusi'] / 100;
						
					}
					else
					{
						$parameter = 0;
					}
				}
				
				if($orderId == '0')
				{
					$rumus = $parameter;
					
					if($newParameter > 0)
						$rumus = $rumus * $newParameter;
				}
				else
				{
					if($operatorId == '+')
						$rumus = $rumus + $parameter;
					elseif($operatorId == '*')
						$rumus = $rumus * $parameter;
					elseif($operatorId == '/')
						$rumus = $rumus / $parameter;
					elseif($operatorId == '-')
						$rumus = $rumus - $parameter;
						
					if($newParameter > 0)
						$rumus = $rumus * $newParameter;
				}
			}
		}
		else
			$rumus=0;
			
		return $rumus;
	}
	
}
?>
