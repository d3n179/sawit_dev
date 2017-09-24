<?PHP
class cetakDataKaryawanPdf extends MainConf
{
	public function onPreInit($param)
	{
		parent::onPreInit($param);	
		$this->getResponse()->setContentType("application/pdf");
	}
	public function onLoad($param)
	{
		$profilPerusahaan = $this->profilPerusahaan();	
			
		$pdf=new reportKwitansi('L','mm','legal');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',8,4,12);	
		$pdf->SetFont('Arial','B',12);
	    $pdf->Cell(0,5,'DATA KARYAWAN','0',0,'C');
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
							AND tbm_department.id_parent = '0' 
							GROUP BY tbm_department.id ";
							
		$arrDepartment = $this->queryAction($sqlDepartment,'S');
		
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
			$pdf->SetWidths(array(5,25,40,30,30,30,45));
			$pdf->SetAligns(array('C','C','C','C','C','C','C'));
			
			$pdf->Row(array("NO","NIK","NAMA","JABATAN","PENDIDIKAN","STATUS KARYAWAN""KETERANGAN"));
									
			
			$pdf->Ln(5);
			$pdf->SetLn(2);
			
			$pdf->SetFont('Arial','',3);
			
			$sqlTrans = "SELECT 
							tbm_karyawan.id,
							tbm_karyawan.nik,
							tbm_karyawan.nama
						FROM 
							tbm_karyawan
							INNER JOIN tbm_jabatan ON tbm_jabatan.id = tbm_karyawan.id_jabatan
						WHERE
							tbm_karyawan.deleted = '0' 
							AND tbm_jabatan.deleted ='0'
							AND tbm_jabatan.id_department = '".$idDeparment."' ";
			$arrTrans = $this->queryAction($sqlTrans,'S');
			$no = 1;
			
										
			foreach($arrTrans as $row)
			{	
				$idK = $row['id'];
					$KaryawanRecord = KaryawanRecord::finder()->findByPk($idK);
					$JabatanRecord = JabatanRecord::finder()->findByPk($KaryawanRecord->id_jabatan);
					$DepartmentRecord = DepartmentRecord::finder()->findByPk($JabatanRecord->id_department);
					$SubDepartmentRecord = DepartmentRecord::finder()->findByPk($JabatanRecord->id_subdepartment);
					$KantorCabangRecord = KantorCabangRecord::finder()->findByPk($KaryawanRecord->id_cabang);
					$LevelDistribusiRecord = LevelDistribusiRecord::finder()->findByPk($JabatanRecord->id_level_distribusi);
					$GolonganKaryawanRecord = GolonganKaryawanRecord::finder()->findByPk($KaryawanRecord->id_golongan);
					$PendidikanRecord = PendidikanRecord::finder()->findByPk($KaryawanRecord->id_pendidikan);
					$StatusKaryawanRecord = StatusKaryawanRecord::finder()->findByPk($KaryawanRecord->status_karyawan);
					$pdf->Row(array($no,
									$row['nik'],
									$row['nama'],
									$JabatanRecord->nama,
									$PendidikanRecord->nama,
									$StatusKaryawanRecord->nama,
									""));
									
					
					$no++;				
				
			}
			
			
		
			
		}
					
			
		$pdf->Output();	
	}
}
?>
