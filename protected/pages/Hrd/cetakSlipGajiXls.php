<?php
class cetakSlipGajiXls extends XlsGen
{
	public function onLoad($param)
	{		
		$month = $this->Request['bulan'];//date("m");
		$year = $this->Request['tahun'];//date("Y");
		$nik = $this->Request['nik'];
		$idK = $this->Request['id'];
		
		if($month == '1')
			$nmBulan = "Januari";
		elseif($month == '2')
			$nmBulan = "Februari";
		elseif($month == '3')
			$nmBulan = "Maret";
		elseif($month == '4')
			$nmBulan = "April";
		elseif($month == '5')
			$nmBulan = "Mei";
		elseif($month == '6')
			$nmBulan = "Juni";
		elseif($month == '7')
			$nmBulan = "Juli";
		elseif($month == '8')
			$nmBulan = "Agustus";
		elseif($month == '9')
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
		$this->AddWS($worksheet1,'c','25',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','5',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','20',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','25',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','5',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','20',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','5',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','25',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','5',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','20',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		
		$frmtTitleLeft =  & $workbook->add_format();
		$left= $this->AddFormat($frmtTitleLeft,'b','1','12');
		$left= $this->AddFormat($frmtTitleLeft,'bd','0','');
		$left= $this->AddFormat($frmtTitleLeft,'HA','left','');
		
		$frmtTitleLeft10 =  & $workbook->add_format();
		$left= $this->AddFormat($frmtTitleLeft10,'b','1','10');
		$left= $this->AddFormat($frmtTitleLeft10,'bd','0','');
		$left= $this->AddFormat($frmtTitleLeft10,'HA','left','');
		
		$frmtLeft =  & $workbook->add_format();
		$left= $this->AddFormat($frmtLeft,'b','1','10');
		$left= $this->AddFormat($frmtLeft,'bd','0','');
		$left= $this->AddFormat($frmtLeft,'HA','left','');		
		
		$frmtCenter =  & $workbook->add_format();
		$center= $this->AddFormat($frmtCenter,'b','1','10');
		$center= $this->AddFormat($frmtCenter,'bd','1','');
		$center= $this->AddFormat($frmtCenter,'HA','center','');
		
		$frmtWrap =  & $workbook->add_format();
		$wrap= $this->AddFormat($frmtWrap,'b','1','10');
		$wrap= $this->AddFormat($frmtWrap,'bd','1','');
		$wrap= $this->AddFormat($frmtWrap,'HA','center','');
		$wrap= $this->AddFormat($frmtWrap,'WR','1','');
		
		
		$baris=0;
		$kolom=0;
		
		$frmtLeft =  & $workbook->add_format();
		$left= $this->AddFormat($frmtLeft,'','1','10');
		$left= $this->AddFormat($frmtLeft,'bd','1','');
		$left= $this->AddFormat($frmtLeft,'HA','left','');
		$left= $this->AddFormat($frmtLeft,'WR','1','');
		
		$frmtCenterHeader =  & $workbook->add_format();
		$centerHeader= $this->AddFormat($frmtCenterHeader,'b','1','10');
		$centerHeader= $this->AddFormat($frmtCenterHeader,'bd','1','');
		$centerHeader= $this->AddFormat($frmtCenterHeader,'HA','center','');
		$centerHeader= $this->AddFormat($frmtCenterHeader,'WR','1','');
		
		$frmtCenter =  & $workbook->add_format();
		$center= $this->AddFormat($frmtCenter,'','1','10');
		$center= $this->AddFormat($frmtCenter,'bd','1','');
		$center= $this->AddFormat($frmtCenter,'HA','center','');
		$center= $this->AddFormat($frmtCenter,'WR','1','');
		
		$frmtRight =  & $workbook->add_format();
		$right= $this->AddFormat($frmtRight,'','1','10');
		$right= $this->AddFormat($frmtRight,'bd','1','');
		$right= $this->AddFormat($frmtRight,'HA','right','');
		
		$KaryawanRecord = KaryawanRecord::finder()->findByPk($idK);
		$JabatanRecord = JabatanRecord::finder()->findByPk($KaryawanRecord->id_jabatan);
		$DepartmentRecord = DepartmentRecord::finder()->findByPk($JabatanRecord->id_department);
		$SubDepartmentRecord = DepartmentRecord::finder()->findByPk($JabatanRecord->id_subdepartment);
		$KantorCabangRecord = KantorCabangRecord::finder()->findByPk($KaryawanRecord->id_cabang);
		$LevelDistribusiRecord = LevelDistribusiRecord::finder()->findByPk($JabatanRecord->id_level_distribusi);
		
		$date1 = $KaryawanRecord->tglawalkerja;
		$date2 = date('Y-m-d');
		$diff = abs(strtotime($date2) - strtotime($date1));
		$years = floor($diff / (365*60*60*24));
		$loyalty = $years;
		
		$queryAbsen = "SELECT
										count(tbm_jadwal.id) AS hadir
									FROM
										tbm_jadwal
									WHERE
										idkaryawan = '$idK'
									AND st_hadir = '0'
									AND MONTH(tanggal) = '$month'
									AND YEAR(tanggal) = '$year' ";
		$fetchAbsen = $this->queryAction($queryAbsen,'S');
		$hadir = $fetchAbsen[0]['hadir'];
		
		$queryKerja = "SELECT
							count(tbm_jadwal.id) AS hari_kerja
						FROM
							tbm_jadwal
						WHERE
							idkaryawan = '$idK'
						AND MONTH(tanggal) = '$month'
						AND YEAR(tanggal) = '$year' ";
						
		$fetchKerja = $this->queryAction($queryKerja,'S');
		$hariKerja = $fetchKerja[0]['hari_kerja'];
		
		$worksheet1->write_string($baris,$kolom,"IDENTITAS KARYAWAN",$frmtTitleLeft);
		$worksheet1->write_string($baris,$kolom+2,"",$frmtLeft);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+1);
		
		$baris++;
		$kolom=0;
		$worksheet1->write_string($baris,$kolom,"NIK",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,$KaryawanRecord->nik,$frmtRight);
		
		$baris++;
		$kolom=0;
		$worksheet1->write_string($baris,$kolom,"Nama",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,$KaryawanRecord->nama,$frmtRight);
		
		$baris++;
		$kolom=0;
		$worksheet1->write_string($baris,$kolom,"Jabatan",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,$JabatanRecord->nama,$frmtRight);
		
		$baris++;
		$kolom=0;
		$worksheet1->write_string($baris,$kolom,"Department",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,$DepartmentRecord->nama,$frmtRight);
		
		$baris++;
		$kolom=0;
		$worksheet1->write_string($baris,$kolom,"Sub Department",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,$SubDepartmentRecord->nama,$frmtRight);
		
		$baris++;
		$kolom=0;
		$worksheet1->write_string($baris,$kolom,"Hari Kerja",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,$hariKerja,$frmtRight);
		
		$baris++;
		$kolom=0;
		$worksheet1->write_string($baris,$kolom,"Level",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,$LevelDistribusiRecord->nilai,$frmtRight);
		
		
		$baris=0;
		$kolom=4;
		$worksheet1->write_string($baris,$kolom,"MASA KERJA",$frmtTitleLeft);
		$worksheet1->write_string($baris,$kolom+2,"",$frmtLeft);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+1);
		
		$baris++;
		$kolom=4;
		$worksheet1->write_string($baris,$kolom,"Loyalty",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,$loyalty,$frmtRight);
		
		$baris++;
		$kolom=4;
		$worksheet1->write_string($baris,$kolom,"Mulai Kerja",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,$this->ConvertDate($KaryawanRecord->tglawalkerja,'3'),$frmtRight);
		
		$baris++;
		$baris++;
		$kolom=4;
		$worksheet1->write_string($baris,$kolom,"PERIODE",$frmtTitleLeft);
		$worksheet1->write_string($baris,$kolom+2,"",$frmtLeft);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+1);
		
		$baris++;
		$kolom=4;
		$worksheet1->write_string($baris,$kolom,"Bulan",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,$nmBulan,$frmtRight);
		
		$baris++;
		$kolom=4;
		$worksheet1->write_string($baris,$kolom,"Tahun",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,$year,$frmtRight);
		
		
		$baris=9;
		$kolom=0;
		$worksheet1->write_string($baris,$kolom,"DATA ABSENSI",$frmtCenterHeader);
		$worksheet1->write_string($baris,$kolom+2,"",$frmtLeft);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+2);
		
		$baris++;
		$kolom=0;
		$worksheet1->write_string($baris,$kolom,"Hari Kerja",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,$hariKerja,$frmtRight);
		
		$baris++;
		$kolom=0;
		$worksheet1->write_string($baris,$kolom,"Hadir",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,$hadir,$frmtRight);
		
		$querylembur = "SELECT
										SUM(tbm_lembur.lama_lembur) AS lembur
									FROM
										tbm_lembur
									WHERE
										id_karyawan = '$idK' 
										AND MONTH(tbm_lembur.tgl_lembur) = '$month' 
										AND YEAR(tbm_lembur.tgl_lembur) = '$year'";
		$rowLembur = $this->queryAction($querylembur,'S');
		if($rowLembur > 0)
		{
			$lembur = $rowLembur[0]['lembur'].' Jam';
		}
		else
		{
			$lembur = '0';
		}
		
		$baris++;
		$kolom=0;
		$worksheet1->write_string($baris,$kolom,"Lembur",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
		$worksheet1->write_string($baris,$kolom,$lembur,$frmtRight);
		
		$sqlAbsensi = "SELECT 
							tbm_payrol.id,
							tbm_payrol.subkategori,
							tbm_payrol.globaldistribusi
						FROM 
							tbm_payrol
						WHERE 
							tbm_payrol.subkategori = '4'
							AND tbm_payrol.attendance_id != '6'
							
						ORDER BY tbm_payrol.attendance_id ASC";
		$queryAbsen = $this->queryAction($sqlAbsensi,'S');
		$rowAbsen = count($queryAbsen);
		if($rowAbsen > 0)
		{
			foreach($queryAbsen AS $fetchAbsen)
			{
				$idpayroll = $fetchAbsen['id'];
				$queryPenaltyCek = "SELECT
													tbm_jadwal.tglbuat,
													tbm_jadwal.idkaryawan,
													tbm_jadwal_penalty.id
												FROM
													tbm_jadwal
												INNER JOIN tbm_jadwal_penalty ON tbm_jadwal_penalty.idjadwal = tbm_jadwal.id
												WHERE
													tbm_jadwal_penalty.payroll_id = '$idpayroll' 
													AND tbm_jadwal.idkaryawan = '$idK' 
													AND MONTH(tbm_jadwal.tglbuat) = '$month' 
													AND YEAR(tbm_jadwal.tglbuat) = '$year' ";
				$rowPenalty = $this->queryAction($queryPenaltyCek,'S');
				if(count($rowPenalty) > 0)
					$jmlPenalty = $rowPenalty;
				else
					$jmlPenalty = 0;
				
				$baris++;
				$kolom=0;
				$worksheet1->write_string($baris,$kolom,$fetchAbsen['globaldistribusi'],$frmtRight);$kolom++;
				$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
				$worksheet1->write_string($baris,$kolom,$jmlPenalty,$frmtRight);
														
			}
		}
		
		$sqlSanksi = "SELECT 
							tbm_payrol.id,
							tbm_payrol.subkategori,
							tbm_payrol.globaldistribusi
						FROM 
							tbm_payrol
						WHERE 
							tbm_payrol.subkategori = '7'
						ORDER BY tbm_payrol.globaldistribusi ASC";
		$querySanksi = $this->queryAction($sqlSanksi,'S');
		$rowSanksi = count($querySanksi);
		if($rowSanksi > 0)
		{
			foreach($querySanksi as $fetchSanksi)
			{
				$idSanksi = $fetchSanksi['id'];
				$querySanksiCek = "SELECT
													tbt_sanksi.id_karyawan,
													tbt_sanksi.payroll_id,
													tbt_sanksi.tgl_sanksi
												FROM
													tbt_sanksi
												WHERE
													tbt_sanksi.payroll_id = '$idSanksi' 
													AND tbt_sanksi.id_karyawan = '$idK' 
													AND MONTH(tbt_sanksi.tgl_sanksi) = '$month'
													AND YEAR(tbt_sanksi.tgl_sanksi) = '$year' ";
				$rowSanksi = $this->queryAction($querySanksiCek,'S');
				if(count($rowSanksi) > 0)
					$jmlSanksi = $rowSanksi;
				else
					$jmlSanksi = 0;
				
				$baris++;
				$kolom=0;
				$worksheet1->write_string($baris,$kolom,$fetchSanksi['globaldistribusi'],$frmtRight);$kolom++;
				$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
				$worksheet1->write_string($baris,$kolom,$jmlSanksi,$frmtRight);
							
			}
		}
		
		$baris=9;
		$kolom=4;
		$worksheet1->write_string($baris,$kolom,"PENDAPATAN",$frmtCenterHeader);
		$worksheet1->write_string($baris,$kolom+2,"",$frmtLeft);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+2);
		
		$sqlPayrol = "SELECT 
							tbm_payrol.id,
							tbm_payrol.subkategori,
							tbm_kategori_payroll.nama
						FROM 
							tbm_payrol
							INNER JOIN tbm_kategori_payroll ON tbm_kategori_payroll.id = tbm_payrol.subkategori 
						WHERE 
							tbm_payrol.kategori = '1'
						GROUP BY tbm_payrol.subkategori";
		$query = $this->queryAction($sqlPayrol,'S');
		$rowCount = count($query);
		if($rowCount > 0)
		{
			foreach($query as $rows)
			{	
				$baris++;
				$kolom=4;
				$worksheet1->write_string($baris,$kolom,$rows['nama'],$frmtTitleLeft10);
				$worksheet1->write_string($baris,$kolom,"",$frmtTitleLeft10);
				$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+2);
				
				$subKategId = $rows['subkategori'];
				$sqlSub =  "SELECT 
							tbm_payrol.id,
							tbm_payrol.globaldistribusi
						FROM 
							tbm_payrol
						WHERE 
							tbm_payrol.subkategori = '$subKategId' AND tbm_payrol.kategori = '1' ";
				$querySub = $this->queryAction($sqlSub,'S');
				$rowsCountSub = count($querySub);
				if($rowsCountSub > 0)
				{ 
					foreach($querySub as $rowsSub)
					{
						$nominal = $this->cekFormula($rowsSub['id'],
													$KantorCabangRecord->pendapatan,
													$KantorCabangRecord->umk,
													$loyalty,
													$hariKerja,
													$hadir,
													$LevelDistribusiRecord->nilai,
													$month,
													$year,
													$idK,
													$KantorCabangRecord->ump,
													$LevelDistribusiRecord->bpjs_distribusi,
													$LevelDistribusiRecord->dinas_distribusi,
													$JabatanRecord->jatah_cuti);
						
						$baris++;
						$kolom=4;
						$worksheet1->write_string($baris,$kolom,$rowsSub['globaldistribusi'],$frmtRight);$kolom++;
						$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
						$worksheet1->write_string($baris,$kolom,'Rp.'.number_format($nominal,2,',','.'),$frmtRight);			
					}
				}
				
			}
		}
		
		$baris=9;
		$kolom=8;
		$worksheet1->write_string($baris,$kolom,"POTONGAN",$frmtCenterHeader);
		$worksheet1->write_string($baris,$kolom+2,"",$frmtLeft);
		$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+2);
		
		$sqlPayrol = "SELECT 
							tbm_payrol.id,
							tbm_payrol.subkategori,
							tbm_kategori_payroll.nama
						FROM 
							tbm_payrol
							INNER JOIN tbm_kategori_payroll ON tbm_kategori_payroll.id = tbm_payrol.subkategori 
						WHERE 
							tbm_payrol.kategori = '2'
						GROUP BY tbm_payrol.subkategori";
		$query = $this->queryAction($sqlPayrol,'S');
		$rowCount = count($query);
		if($rowCount > 0)
		{
			foreach($query as $rows)
			{	
				$baris++;
				$kolom=8;
				$worksheet1->write_string($baris,$kolom,$rows['nama'],$frmtTitleLeft10);
				$worksheet1->write_string($baris,$kolom,"",$frmtTitleLeft10);
				$worksheet1->merge_cells($baris, $kolom, $baris, $kolom+2);
				
				
				$subKategId = $rows['subkategori'];
				$sqlSub =  "SELECT 
							tbm_payrol.id,
							tbm_payrol.globaldistribusi
						FROM 
							tbm_payrol
						WHERE 
							tbm_payrol.subkategori = '$subKategId' AND tbm_payrol.kategori = '2' ";
				$querySub = $this->queryAction($sqlSub,'S');
				$rowsCountSub = count($querySub);
				if($rowsCountSub > 0)
				{ 
					foreach($querySub as $rowsSub)
					{
						$nominal = $this->cekFormula($rowsSub['id'],
													$KantorCabangRecord->pendapatan,
													$KantorCabangRecord->umk,
													$loyalty,
													$hariKerja,
													$hadir,
													$LevelDistribusiRecord->nilai,
													$month,
													$year,
													$idK,
													$KantorCabangRecord->ump,
													$LevelDistribusiRecord->bpjs_distribusi,
													$LevelDistribusiRecord->dinas_distribusi,
													$JabatanRecord->jatah_cuti);
						
						$baris++;
						$kolom=8;
						$worksheet1->write_string($baris,$kolom,$rowsSub['globaldistribusi'],$frmtRight);$kolom++;
						$worksheet1->write_string($baris,$kolom,":",$frmtRight);$kolom++;
						$worksheet1->write_string($baris,$kolom,'Rp.'.number_format($nominal,2,',','.'),$frmtRight);
						
					}
				}
			}
		}	
		
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
