<?PHP
class cetakJadwalPerKaryawanPdf extends MainConf
{
	public function onPreInit($param)
	{
		parent::onPreInit($param);	
		$this->getResponse()->setContentType("application/pdf");
	}
	public function onLoad($param)
	{	
		$id = $this->Request['id'];
		$bln = $this->Request['bulan'];
		$thn =$this->Request['tahun'];
		
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
		
		
		$profilPerusahaan = $this->profilPerusahaan();	
			
		$pdf=new reportKwitansi('P','mm','legal');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',5,8,25);	
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
		$pdf->Cell(0,5,'JADWAL PER KARYAWAN','0',0,'C');
		$pdf->Ln(10);
		$pdf->SetAligns(array('L','L','L','L','L','L','L'));
		$pdf->SetWidths(array(35,5,50,35,35,5,50));
		
		$sqlKaryawan = "SELECT
					tbm_karyawan.id,
					a.nama AS cabang,
					tbm_karyawan.nik,
					tbm_karyawan.nama,
					c.nama AS department,
					d.nama AS subdepartment,
					tbm_jabatan.nama AS jabatan,
					tbm_karyawan.tglawalkerja,
					tbm_karyawan.tgllahir,
					tbm_status_karyawan.nama AS status_karyawan,
					b.nama AS posisi_dinas
				FROM
					tbm_karyawan
				INNER JOIN tbm_cabang a ON a.id = tbm_karyawan.id_cabang
				INNER JOIN tbm_cabang b ON b.id = tbm_karyawan.posisi_dinas
				INNER JOIN tbm_jabatan ON tbm_jabatan.id = tbm_karyawan.id_jabatan
				INNER JOIN tbm_department c ON c.id = tbm_jabatan.id_department
				INNER JOIN tbm_department d ON d.id = tbm_jabatan.id_subdepartment
				INNER JOIN tbm_status_karyawan ON tbm_status_karyawan.id = tbm_karyawan.status_karyawan
				WHERE
					tbm_karyawan.id = '$id'
				ORDER BY 
					tbm_karyawan.id ASC ";
		$arrKaryawan = $this->queryAction($sqlKaryawan,'S');
		
		$date1 = $arrKaryawan[0]['tglawalkerja'];
				$date2 = date('Y-m-d');
				$diff = abs(strtotime($date2) - strtotime($date1));
				$years = floor($diff / (365*60*60*24));
				$masaKerja = $years." Tahun";
				
				$date1 = $arrKaryawan[0]['tgllahir'];
				$date2 = date('Y-m-d');
				$diff = abs(strtotime($date2) - strtotime($date1));
				$years = floor($diff / (365*60*60*24));
				$umur = $years." Tahun";
				
		$pdf->RowNoBorder(array('NIK',':',$arrKaryawan[0]['nik'],'','Nama',':',$arrKaryawan[0]['nama']));
		$pdf->RowNoBorder(array('Department',':',$arrKaryawan[0]['department'],'','SubDepartment',':',$arrKaryawan[0]['subdepartment']));
		$pdf->RowNoBorder(array('Jabatan',':',$arrKaryawan[0]['jabatan'],'','Masa Kerja',':',$masaKerja));
		$pdf->RowNoBorder(array('Umur',':',$umur ,'','Status',':',$arrKaryawan[0]['status_karyawan']));
		$pdf->RowNoBorder(array('Kantor',':',$arrKaryawan[0]['posisi_dinas'],'','','',''));
		
		$sql = "SELECT
						tbm_jadwal.id,
						tbm_karyawan.nik,
						tbm_karyawan.nama,
						tbm_jadwal.tanggal,
						tbm_jadwal.awal,
						tbm_jadwal.ahir,
						tbm_jadwal.lama,
						tbm_jadwal.datang,
						tbm_jadwal.pulang,
						IF(tbm_jadwal.st = '0','BELUM ABSEN',IF(tbm_jadwal.st_hadir = '0','HADIR',tbm_payrol.globaldistribusi)) AS st_hadir,
						tbm_jadwal.st
					FROM
						tbm_jadwal
					INNER JOIN tbm_karyawan ON tbm_karyawan.id = tbm_jadwal.idkaryawan
					LEFT JOIN tbm_payrol ON tbm_payrol.id = tbm_jadwal.st_hadir
					WHERE
						MONTH(tbm_jadwal.tanggal) = '".$bln."'
						AND YEAR(tbm_jadwal.tanggal) = '".$thn."'
						AND tbm_karyawan.id = '".$id."'
					ORDER BY 
						tbm_jadwal.tanggal ASC ";
		$arrData=$this->queryAction($sql,'S');
		
		//$pdf->SetWidths(array(35,5,70,5,5,5));
		$pdf->RowNoBorder(array('Jadwal Bulan',':',$nmBulan.' '.$thn,'','Hari Kerja',':',count($arrData)));
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C','C','C','C'));
		$pdf->SetWidths(array(35,35,35,20,30,20,20));
		$pdf->Row(array('Tanggal Jadwal','Jadwal Masuk','Jadwal Pulang','Lama','Status','Masuk','Pulang'));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('L','L','L','L','L','L','L'));
		
		$i = 1;
		$idPo = '';
		foreach($arrData as $row)
		{		
			$pdf->Row(array($this->ConvertDate($row['tanggal'],'3'),
							$row['awal'],
							$row['ahir'],
							$row['lama'],
							$row['st_hadir'],
							$row['datang'],
							$row['pulang']));
			$i++;
		}
		
		$pdf->Output();	
	}
}
?>
