<?PHP
/** Include PHPExcel */
class cetakExcel extends PHPExcel
{
	public function onLoad($param)
	{
		$month = $_GET['bulan'];//date("m");
		$year = $_GET['tahun'];//date("Y");
		$nik = $_GET['nik'];
		$idK = $_GET['id'];

		if($month == '01')
			$nmBulan = 'Januari';
		elseif($month == '02')
			$nmBulan = 'Februari';
		elseif($month == '03')
			$nmBulan = 'Maret';
		elseif($month == '04')
			$nmBulan = 'April';
		elseif($month == '05')
			$nmBulan = 'Mei';
		elseif($month == '06')
			$nmBulan = 'Juni';
		elseif($month == '07')
			$nmBulan = 'Juli';
		elseif($month == '08')
			$nmBulan = 'Agustus';
		elseif($month == '09')
			$nmBulan = 'September';
		elseif($month == '10')
			$nmBulan = 'Oktober';
		elseif($month == '11')
			$nmBulan = 'November';
		elseif($month == '12')
			$nmBulan = 'Desember';

		if($idK != '')
			$cariKaryawan = " tbm_karyawan.id = '$idK' ";
		elseif($idK == '' && $nik != '')
			$cariKaryawan = " tbm_karyawan.nik = '$nik' ";
			
		$queryKaryawan = "SELECT
							tbm_karyawan.id,
							tbm_karyawan.nik,
							tbm_karyawan.nama,
							tbm_karyawan.tglawalkerja,
							tbm_karyawan.statuskaryawan,
							tbm_jabatan.department,
							tbm_jabatan.subdepartment,
							tbm_jabatan.jabatan,
							tbm_jabatan.`level`,
							tbm_jabatan.jatah_cuti,
							tbm_level_distribusi.bpjs_distribusi,
							tbm_level_distribusi.dinas_distribusi,
							tbm_cabang.namacabang,
							tbm_cabang.pendapatan,
							tbm_cabang.umk,
							tbm_cabang.ump
						FROM
							tbm_karyawan
						INNER JOIN tbm_jabatan ON tbm_jabatan.idjabatan = tbm_karyawan.idjabatan
						INNER JOIN tbm_cabang ON tbm_cabang.idcabang = tbm_karyawan.idcabang
						INNER JOIN tbm_level_distribusi ON tbm_level_distribusi.nilai = tbm_jabatan.`level`
						WHERE
							".$cariKaryawan;
							
		$fetchKaryawan = MainConf::queryAction($queryKaryawan,'S');

		if($idK == '')
			$idK = $fetchKaryawan[0]['id'];
			
		$date1 = $fetchKaryawan[0]['tglawalkerja'];
		$date2 = date('Y-m-d');
		$diff = abs(strtotime($date2) - strtotime($date1));
		$years = floor($diff / (365*60*60*24));
		$loyalty = $years;

		$queryAbsen = "SELECT
										count(tbm_jadwal.idjadwal) AS hadir
									FROM
										tbm_jadwal
									WHERE
										idkaryawan = '$idK'
									AND st_hadir = '0'
									AND MONTH(tanggal) = '$month'
									AND YEAR(tanggal) = '$year' ";
		$fetchAbsen = MainConf::queryAction($queryAbsen,'S');
		$hadir = $fetchAbsen[0]['hadir'];

		$queryKerja = "SELECT
										count(tbm_jadwal.idjadwal) AS hari_kerja
									FROM
										tbm_jadwal
									WHERE
										idkaryawan = '$idK'
									AND MONTH(tanggal) = '$month'
									AND YEAR(tanggal) = '$year' ";
		$fetchKerja = MainConf::queryAction($queryKerja,'S');
		$hariKerja = $fetchKerja[0]['hari_kerja'];
		 
		// Create new PHPExcel object
		$objPHPExcel = new PHPExcel();
		 
		// Set document properties
		$objPHPExcel->getProperties()->setCreator("Deni Andriansah")
		 ->setLastModifiedBy("Slip Gaji ********")
		 ->setTitle("Slip Gaji ********")
		 ->setSubject("Slip Gaji ********")
		 ->setDescription("Slip Gaji")
		 ->setKeywords("Slip Gaji")
		 ->setCategory("Slip Gaji");
		 
		// Create the worksheet
		$objPHPExcel->setActiveSheetIndex(0);

		// Set Column Width
		$objPHPExcel->getActiveSheet()->getColumnDimension('A')->setWidth(20);
		$objPHPExcel->getActiveSheet()->getColumnDimension('B')->setWidth(1);
		$objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(15);
		//$objPHPExcel->getActiveSheet()->getColumnDimension('D')->setWidth(21);
		$objPHPExcel->getActiveSheet()->getColumnDimension('E')->setWidth(20);
		$objPHPExcel->getActiveSheet()->getColumnDimension('F')->setWidth(1);
		$objPHPExcel->getActiveSheet()->getColumnDimension('G')->setWidth(15);
		//$objPHPExcel->getActiveSheet()->getColumnDimension('H')->setWidth(11);
		$objPHPExcel->getActiveSheet()->getColumnDimension('I')->setWidth(20);
		$objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(1);
		$objPHPExcel->getActiveSheet()->getColumnDimension('K')->setWidth(15);

		$kolom=0;
		$baris=1;

		$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom,$baris)->getFont()->setBold(true);
		$objPHPExcel->getActiveSheet()
									->mergeCellsByColumnAndRow($kolom,$baris,$kolom + 2,$baris)
									->setCellValueByColumnAndRow($kolom,$baris, "Identitas Karyawan")
									->getStyleByColumnAndRow($kolom,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);
		$baris++;
		$objPHPExcel->getActiveSheet()->getStyle('A2:A8')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_RIGHT);
		$objPHPExcel->getActiveSheet()->getStyle('C2:C8')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);

		$objPHPExcel->getActiveSheet()
									->setCellValueByColumnAndRow($kolom,$baris,"NIK") 
									->setCellValueByColumnAndRow($kolom + 1,$baris,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris,$fetchKaryawan[0]['nik'])
									->setCellValueByColumnAndRow($kolom,$baris + 1,"Nama") 
									->setCellValueByColumnAndRow($kolom + 1,$baris + 1,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris + 1,$fetchKaryawan[0]['nama'])
									->setCellValueByColumnAndRow($kolom,$baris + 2,"Jabatan") 
									->setCellValueByColumnAndRow($kolom + 1,$baris + 2,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris + 2,$fetchKaryawan[0]['jabatan'])
									->setCellValueByColumnAndRow($kolom,$baris + 3,"Department") 
									->setCellValueByColumnAndRow($kolom + 1,$baris + 3,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris + 3,$fetchKaryawan[0]['department'])
									->setCellValueByColumnAndRow($kolom,$baris + 4,"Sub Department") 
									->setCellValueByColumnAndRow($kolom + 1,$baris + 4,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris + 4,$fetchKaryawan[0]['subdepartment'])
									->setCellValueByColumnAndRow($kolom,$baris + 5,"Hari Kerja") 
									->setCellValueByColumnAndRow($kolom + 1,$baris + 5,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris + 5,$hariKerja)
									->setCellValueByColumnAndRow($kolom,$baris + 6,"Level") 
									->setCellValueByColumnAndRow($kolom + 1,$baris + 6,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris + 6,$fetchKaryawan[0]['level']);

		$kolom=$kolom + 4;
		$baris = 1;
		$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom,$baris)->getFont()->setBold(true);
		$objPHPExcel->getActiveSheet()
									->mergeCellsByColumnAndRow($kolom,$baris,$kolom + 2,$baris)
									->setCellValueByColumnAndRow($kolom,$baris, "Masa kerja")
									->getStyleByColumnAndRow($kolom,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);
									
		$baris++;
		$objPHPExcel->getActiveSheet()->getStyle('E2:E3')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_RIGHT);
		$objPHPExcel->getActiveSheet()->getStyle('G2:G3')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);
		$objPHPExcel->getActiveSheet()
									->setCellValueByColumnAndRow($kolom,$baris,"Loyalty") 
									->setCellValueByColumnAndRow($kolom + 1,$baris,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris,$loyalty.' Tahun')
									->setCellValueByColumnAndRow($kolom,$baris + 1,"Mulai kerja") 
									->setCellValueByColumnAndRow($kolom + 1,$baris + 1,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris + 1,$fetchKaryawan[0]['tglawalkerja']);
									
		$baris = 5;
		$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom,$baris)->getFont()->setBold(true);
		$objPHPExcel->getActiveSheet()
									->mergeCellsByColumnAndRow($kolom,$baris,$kolom + 2,$baris)
									->setCellValueByColumnAndRow($kolom,$baris, "Periode")
									->getStyleByColumnAndRow($kolom,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);
		$baris++;
		$objPHPExcel->getActiveSheet()->getStyle('E6:E7')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_RIGHT);
		$objPHPExcel->getActiveSheet()->getStyle('G6:G7')->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);
		$objPHPExcel->getActiveSheet()
									->setCellValueByColumnAndRow($kolom,$baris,"Bulan") 
									->setCellValueByColumnAndRow($kolom + 1,$baris,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris,$nmBulan)
									->setCellValueByColumnAndRow($kolom,$baris + 1,"Tahun") 
									->setCellValueByColumnAndRow($kolom + 1,$baris + 1,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris + 1,$year);

		$baris=10;
		$kolom=0;
		$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom,$baris)->getFont()->setBold(true);
		$objPHPExcel->getActiveSheet()
									->mergeCellsByColumnAndRow($kolom,$baris,$kolom + 2,$baris)
									->setCellValueByColumnAndRow($kolom,$baris, "Data Absensi")
									->getStyleByColumnAndRow($kolom,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
		$baris++;

		$querylembur = "SELECT
										SUM(tbm_lembur.lama_lembur) AS lembur
									FROM
										tbm_lembur
									WHERE
										id_karyawan = '$idK' 
										AND MONTH(tbm_lembur.tgl_lembur) = '$month' 
										AND YEAR(tbm_lembur.tgl_lembur) = '$year'";
		$rowLembur = MainConf::queryAction($querylembur,'S');
		if(count($rowLembur) > 0)
		{
			$lemburFetch = MainConf::queryAction($querylembur,'S');
			$lembur = $lemburFetch[0]['lembur'].' Jam';
		}
		else
		{
			$lembur = '0';
		}
		$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_RIGHT);
		$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom + 2,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);

		$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom,$baris + 1)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_RIGHT);
		$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom + 2,$baris + 1)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);

		$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom,$baris + 2)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_RIGHT);
		$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom + 2,$baris + 2)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);

		$objPHPExcel->getActiveSheet()
									->setCellValueByColumnAndRow($kolom,$baris,"Hari Kerja") 
									->setCellValueByColumnAndRow($kolom + 1,$baris,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris,$hariKerja.' Hari')
									->setCellValueByColumnAndRow($kolom,$baris + 1,"Kehadiran") 
									->setCellValueByColumnAndRow($kolom + 1,$baris + 1,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris + 1,$hadir.' Hari')
									->setCellValueByColumnAndRow($kolom,$baris + 2,"Lembur") 
									->setCellValueByColumnAndRow($kolom + 1,$baris + 2,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris + 2,$lembur);
		$baris = $baris + 3;

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
		$queryAbsen = MainConf::queryAction($sqlAbsensi,'S');
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
												INNER JOIN tbm_jadwal_penalty ON tbm_jadwal_penalty.idjadwal = tbm_jadwal.idjadwal
												WHERE
													tbm_jadwal_penalty.payroll_id = '$idpayroll' 
													AND tbm_jadwal.idkaryawan = '$idK' 
													AND MONTH(tbm_jadwal.tglbuat) = '$month' 
													AND YEAR(tbm_jadwal.tglbuat) = '$year' ";
				$rowPenalty = MainConf::queryAction($queryPenaltyCek,'S');
				if(count($rowPenalty) > 0)
					$jmlPenalty = $rowPenalty;
				else
					$jmlPenalty = 0;
				
				$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_RIGHT);
				$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom + 2,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);

				$objPHPExcel->getActiveSheet()
									->setCellValueByColumnAndRow($kolom,$baris,$fetchAbsen['globaldistribusi']) 
									->setCellValueByColumnAndRow($kolom + 1,$baris,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris,$jmlPenalty);
									
				$baris++;								
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
		$querySanksi = MainConf::queryAction($sqlSanksi,'S');
		$rowSanksi = count($querySanksi);
		if($rowSanksi > 0)
		{
			foreach($querySanksi as $fetchSanksi)
			{
				$idSanksi = $fetchSanksi['id'];
				$querySanksiCek = "SELECT
													tbm_sanksi.id_karyawan,
													tbm_sanksi.payroll_id,
													tbm_sanksi.tgl_sanksi
												FROM
													tbm_sanksi
												WHERE
													tbm_sanksi.payroll_id = '$idSanksi' 
													AND tbm_sanksi.id_karyawan = '$idK' 
													AND MONTH(tbm_sanksi.tgl_sanksi) = '$month'
													AND YEAR(tbm_sanksi.tgl_sanksi) = '$year' ";
				$rowSanksi = MainConf::queryAction($querySanksiCek,'S');
				if(count($rowSanksi) > 0)
					$jmlSanksi = $rowSanksi;
				else
					$jmlSanksi = 0;
				
				$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_RIGHT);
				$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom + 2,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);
					
				$objPHPExcel->getActiveSheet()
									->setCellValueByColumnAndRow($kolom,$baris,$fetchSanksi['globaldistribusi']) 
									->setCellValueByColumnAndRow($kolom + 1,$baris,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris,$jmlSanksi);
									
				$baris++;	
							
			}
		}

		$kolom=$kolom + 4;
		$baris=10;
		$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom,$baris)->getFont()->setBold(true);
		$objPHPExcel->getActiveSheet()
									->mergeCellsByColumnAndRow($kolom,$baris,$kolom + 2,$baris)
									->setCellValueByColumnAndRow($kolom,$baris, "Pendapatan")
									->getStyleByColumnAndRow($kolom,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
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
		$query = MainConf::queryAction($sqlPayrol,'S');
		$rowCount = count($query);
		if($rowCount > 0)
		{
			foreach($query as $rows)
			{	$baris++;
				$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom,$baris)->getFont()->setBold(true);
				$objPHPExcel->getActiveSheet()
									->mergeCellsByColumnAndRow($kolom,$baris,$kolom + 2,$baris)
									->setCellValueByColumnAndRow($kolom,$baris, $rows['nama'])
									->getStyleByColumnAndRow($kolom,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);
									
				$subKategId = $rows['subkategori'];
				$sqlSub =  "SELECT 
							tbm_payrol.id,
							tbm_payrol.globaldistribusi
						FROM 
							tbm_payrol
						WHERE 
							tbm_payrol.subkategori = '$subKategId' AND tbm_payrol.kategori = '1' ";
				$querySub = MainConf::queryAction($sqlSub,'S');
				$rowsCountSub = count($querySub);
				if($rowsCountSub > 0)
				{ 
					foreach($querySub as $rowsSub)
					{
						$baris++;
							
						$nominal = $this->cekFormula($rowsSub['id'],$monthlyRevenue,$fetchKaryawan[0]['umk'],$loyalty,$hariKerja,$hadir,$fetchKaryawan[0]['level'],$month,$year,$idK,$fetchKaryawan[0]['ump'],$fetchKaryawan[0]['bpjs_distribusi'],$fetchKaryawan[0]['dinas_distribusi'],$fetchKaryawan[0]['jatah_cuti']);
						$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_RIGHT);
						$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom + 2,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);
						$objPHPExcel->getActiveSheet()
									->setCellValueByColumnAndRow($kolom,$baris,$rowsSub['globaldistribusi']) 
									->setCellValueByColumnAndRow($kolom + 1,$baris,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris,'Rp.'.number_format($nominal,2,',','.'));
									
					}
				}
				
			}
		}

		$kolom=$kolom + 4;
		$baris=10;
		$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom,$baris)->getFont()->setBold(true);
		$objPHPExcel->getActiveSheet()
									->mergeCellsByColumnAndRow($kolom,$baris,$kolom + 2,$baris)
									->setCellValueByColumnAndRow($kolom,$baris, "Potongan")
									->getStyleByColumnAndRow($kolom,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_CENTER);
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
		$query = MainConf::queryAction($sqlPayrol,'S');
		$rowCount = count($query);
		if($rowCount > 0)
		{
			foreach($query as $rows)
			{	
				$baris++;
				$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom,$baris)->getFont()->setBold(true);
				$objPHPExcel->getActiveSheet()
									->mergeCellsByColumnAndRow($kolom,$baris,$kolom + 2,$baris)
									->setCellValueByColumnAndRow($kolom,$baris, $rows['nama'])
									->getStyleByColumnAndRow($kolom,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);
				
				$subKategId = $rows['subkategori'];
				$sqlSub =  "SELECT 
							tbm_payrol.id,
							tbm_payrol.globaldistribusi
						FROM 
							tbm_payrol
						WHERE 
							tbm_payrol.subkategori = '$subKategId' AND tbm_payrol.kategori = '2' ";
				$querySub = MainConf::queryAction($sqlSub,'S');
				$rowsCountSub = count($querySub);
				if($rowsCountSub > 0)
				{ 
					foreach($querySub as $rowsSub)
					{
						$baris++;
						$nominal = $this->cekFormula($rowsSub['id'],$monthlyRevenue,$fetchKaryawan[0]['umk'],$loyalty,$hariKerja,$hadir,$fetchKaryawan[0]['level'],$month,$year,$idK,$fetchKaryawan[0]['ump'],$fetchKaryawan[0]['bpjs_distribusi'],$fetchKaryawan[0]['dinas_distribusi'],$fetchKaryawan[0]['jatah_cuti']);
						
						$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_RIGHT);
						$objPHPExcel->getActiveSheet()->getStyleByColumnAndRow($kolom + 2,$baris)->getAlignment()->setHorizontal(PHPExcel_Style_Alignment::HORIZONTAL_LEFT);
						
						$objPHPExcel->getActiveSheet()
									->setCellValueByColumnAndRow($kolom,$baris,$rowsSub['globaldistribusi']) 
									->setCellValueByColumnAndRow($kolom + 1,$baris,":")
									->setCellValueByColumnAndRow($kolom + 2,$baris,'Rp.'.number_format($nominal,2,',','.'));
					}
				}
			}
		}	
		// Redirect output to a client’s web browser (Excel2007)
		header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
		header('Content-Disposition: attachment;filename="SlipGaji"'.date("d-F-Y").'".xlsx"');
		header('Cache-Control: max-age=0');
		 
		$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
		$objWriter->save('php://output');
		exit;
		 
		// Save Excel 2007 file
		$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007');
		$objWriter->save(str_replace('.php', '.xlsx', __FILE__));
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
		$queryRows =  MainConf::queryAction($queryFormula,'S');
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
										COUNT(tbm_jadwal.idjadwal) AS jml_cuti
												FROM
													tbm_jadwal
												INNER JOIN tbm_payrol ON tbm_payrol.id = tbm_jadwal.st_hadir
												WHERE
													tbm_payrol.subkategori = '4'
												AND tbm_payrol.attendance_id = '2'
												AND tbm_jadwal.idkaryawan = '$idKaryawan' 
												AND YEAR(tbm_jadwal.tanggal) = '$year' ";
					
					$rowCuti = MainConf::queryAction($queryCuti,'S');
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
					$rowLembur = MainConf::queryAction($querylembur,'S');
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
					$rowPayroll = MainConf::queryAction($queryPayroll,'S');
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
							$rowSantunan =  MainConf::queryAction($querySantunanCek,'S');
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
																INNER JOIN tbm_jadwal_penalty ON tbm_jadwal_penalty.idjadwal = tbm_jadwal.idjadwal
																WHERE
																	tbm_jadwal_penalty.payroll_id = '$parameterId' 
																	AND tbm_jadwal.idkaryawan = '$idKaryawan' 
																	AND MONTH(tbm_jadwal.tglbuat) = '$month' 
																	AND YEAR(tbm_jadwal.tglbuat) = '$year' ";
								$rowPenalty = MainConf::queryAction($queryPenaltyCek,'S');
								if(count($rowPenalty) > 0)
								{
									$newParameter = count($rowPenalty);
								}
							}
						}
						elseif($subType == '7')
						{
							$querySanksiCek = "SELECT
																	tbm_sanksi.id_karyawan,
																	tbm_sanksi.payroll_id,
																	tbm_sanksi.tgl_sanksi
																FROM
																	tbm_sanksi
																WHERE
																	tbm_sanksi.payroll_id = '$parameterId' 
																	AND tbm_sanksi.id_karyawan = '$idKaryawan' 
																	AND MONTH(tbm_sanksi.tgl_sanksi) = '$month'
																	AND YEAR(tbm_sanksi.tgl_sanksi) = '$year' ";
							$rowSanksi = MainConf::queryAction($querySanksiCek,'S');
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
