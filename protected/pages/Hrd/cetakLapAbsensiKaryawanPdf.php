<?PHP
class cetakLapAbsensiKaryawanPdf extends MainConf
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
		
		if($periode == '0')
			$nmPeriode = $nmBulan." ".$thn;
		elseif($periode == '1')
			$nmPeriode = $thn;
		elseif($periode == '3')
			$nmPeriode = $mingguan;
		
		$profilPerusahaan = $this->profilPerusahaan();	
			
		$pdf=new reportKwitansi('L','mm','legal');
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
		$pdf->Cell(0,5,'LAPORAN ABSENSI KARYAWAN','0',0,'C');
		$pdf->Ln(5);
		$pdf->Cell(0,5,'PERIODE : '.$nmPeriode,'0',0,'C');
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C','C','C','C','C','C','C'));
		$pdf->SetWidths(array(60,50,50,25,25,25,25,25,25,25));
		$pdf->Row(array('Nama Karyawan','Jabatan','Golongan','Hari Kerja','Hadir','Terlambat','Mangkir','Lembur LPP (Jam)','Lembur LPPML (Jam)','Lembur LPPLK (Jam)'));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('L','L','L','R','R','R','R','R','R','R'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapAbsensiKaryawanSql'];
		$arrData=$this->queryAction($sql,'S');
		$i = 1;
		$idPo = '';
		foreach($arrData as $row)
		{		
			$arrDetail = $this->getDetailAbsensi($row['id'],$bln,$thn);
			$pdf->Row(array($row['nama'],
							$row['jabatan'],
							$row['golongan'],
							$arrDetail['HariKerja'],
							$arrDetail['Hadir'],
							$arrDetail['Terlambat'],
							$arrDetail['Mangkir'],
							$arrDetail['LemburLPP'],
							$arrDetail['LemburLPPML'],
							$arrDetail['LemburLPPLK']));
			$i++;
		}
		
		$pdf->Output();	
	}
	
	public function getDetailAbsensi($idKaryawan,$month,$year)
	{
		$sql = "SELECT
					COUNT(tbm_jadwal.id) AS hari_kerja
				FROM
					tbm_jadwal
				WHERE
					MONTH (tbm_jadwal.tanggal) = '$month'
				AND YEAR (tbm_jadwal.tanggal) = '$year'
				AND tbm_jadwal.idkaryawan = '$idKaryawan' ";
		$arr = $this->queryAction($sql,'S');
		$HariKerja = $arr[0]['hari_kerja'];
		
		$sql = "SELECT
					COUNT(tbm_jadwal.id) AS hadir
				FROM
					tbm_jadwal
				WHERE
					MONTH (tbm_jadwal.tanggal) = '$month'
				AND YEAR (tbm_jadwal.tanggal) = '$year'
				AND tbm_jadwal.idkaryawan = '$idKaryawan' 
				AND tbm_jadwal.st_hadir = '0'";
		$arr = $this->queryAction($sql,'S');
		$Hadir = $arr[0]['hadir'];
		
		$sql = "SELECT
					COUNT(tbm_jadwal.id) AS terlambat
				FROM
					tbm_jadwal
				WHERE
					MONTH (tbm_jadwal.tanggal) = '$month'
				AND YEAR (tbm_jadwal.tanggal) = '$year'
				AND tbm_jadwal.idkaryawan = '$idKaryawan' 
				AND tbm_jadwal.st_hadir = '0'
				AND tbm_jadwal.st_telat = '1' ";
		$arr = $this->queryAction($sql,'S');
		$Terlambat = $arr[0]['terlambat'];
		
		$sql = "SELECT
					COUNT(tbm_jadwal.id) AS mangkir
				FROM
					tbm_jadwal
				WHERE
					MONTH (tbm_jadwal.tanggal) = '$month'
				AND YEAR (tbm_jadwal.tanggal) = '$year'
				AND tbm_jadwal.idkaryawan = '$idKaryawan' 
				AND tbm_jadwal.st_hadir = '1'";
		$arr = $this->queryAction($sql,'S');
		$Mangkir = $arr[0]['mangkir'];
		
		$sql = "SELECT
					SUM(
						tbt_lembur_karyawan.lama_lembur
					) AS lama_lembur
				FROM
					tbt_lembur_karyawan
				WHERE
					MONTH (tbt_lembur_karyawan.tgl) = '$month'
				AND YEAR (tbt_lembur_karyawan.tgl) = '$year'
				AND tbt_lembur_karyawan.id_karyawan = '$idKaryawan'
				AND tbt_lembur_karyawan.jns_lembur = '1'";
				
		$arr = $this->queryAction($sql,'S');
		$LemburLPP = $arr[0]['lama_lembur'];
		
		$sql = "SELECT
					SUM(
						tbt_lembur_karyawan.lama_lembur
					) AS lama_lembur
				FROM
					tbt_lembur_karyawan
				WHERE
					MONTH (tbt_lembur_karyawan.tgl) = '$month'
				AND YEAR (tbt_lembur_karyawan.tgl) = '$year'
				AND tbt_lembur_karyawan.id_karyawan = '$idKaryawan'
				AND tbt_lembur_karyawan.jns_lembur = '2'";
				
		$arr = $this->queryAction($sql,'S');
		$LemburLPPML = $arr[0]['lama_lembur'];
		
		$sql = "SELECT
					SUM(
						tbt_lembur_karyawan.lama_lembur
					) AS lama_lembur
				FROM
					tbt_lembur_karyawan
				WHERE
					MONTH (tbt_lembur_karyawan.tgl) = '$month'
				AND YEAR (tbt_lembur_karyawan.tgl) = '$year'
				AND tbt_lembur_karyawan.id_karyawan = '$idKaryawan'
				AND tbt_lembur_karyawan.jns_lembur = '3'";
				
		$arr = $this->queryAction($sql,'S');
		$LemburLPPLK = $arr[0]['lama_lembur'];
		
		return array("HariKerja"=>$HariKerja,"Hadir"=>$Hadir,"Mangkir"=>$Mangkir,"Terlambat"=>$Terlambat,"LemburLPP"=>$LemburLPP,"LemburLPPML"=>$LemburLPPML,"LemburLPPLK"=>$LemburLPPLK);
	}
	
}
?>
