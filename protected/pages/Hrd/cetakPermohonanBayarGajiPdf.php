<?PHP
class cetakPermohonanBayarGajiPdf extends MainConf
{
	public function onPreInit($param)
	{
		parent::onPreInit($param);	
		$this->getResponse()->setContentType("application/pdf");
	}
	
	public function onLoad($param)
	{
		$profilPerusahaan = $this->profilPerusahaan();	
		$id = $this->Request['id'];	
		$RekapGajiRecord = RekapGajiRecord::finder()->findByPk($id);
		$bln = $RekapGajiRecord->bulan;
		$thn = $RekapGajiRecord->tahun;
		
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
			
		$thnBln = $nmBulan." ".$thn;
			
		$pdf=new reportKwitansi('P','mm','legal');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',8,4,12);	
		$pdf->SetFont('Arial','B',12);
	    $pdf->Cell(0,5,'PERMOHONAN PEMBAYARAN GAJI KARYAWAN','0',0,'C');
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
		
		
		$pdf->Cell(0,5,'GAJI BULAN : '.$thnBln,'0',0,'L');
		$pdf->Ln(5);
		
		
		$sqlDepartment = "SELECT
							tbm_department.id,
							tbm_department.nama
						FROM
							tbm_department
							INNER JOIN tbm_jabatan ON tbm_jabatan.id_department = tbm_department.id
							INNER JOIN tbm_karyawan ON tbm_karyawan.id_jabatan = tbm_jabatan.id
							INNER JOIN tbt_rekap_gaji_detail ON tbt_rekap_gaji_detail.id_karyawan = tbm_karyawan.id
						WHERE
							tbm_department.deleted = '0'
							AND tbm_jabatan.deleted ='0'
							AND tbm_karyawan.deleted ='0'
							AND tbt_rekap_gaji_detail.deleted = '0'
							AND tbm_department.id_parent = '0' 
							AND tbt_rekap_gaji_detail.status = '0' 
							GROUP BY tbm_department.id ";
							
		$arrDepartment = $this->queryAction($sqlDepartment,'S');
		
		$pdf->SetFont('Arial','B',6);
		$pdf->SetWidths(array(10,40,35,35,35,35));
		$pdf->SetAligns(array('C','C','C','C','C','C'));
			
		$pdf->Row(array("NO","PENERIMA","BANK","NOMOR REKENING","TRANSFER","NON TRANSFER"));
		
		$totalTransfer = 0;
		$totalNonTransfer = 0;	
		foreach($arrDepartment as $rowDepartment)
		{
			$row++;
			$idDeparment = $rowDepartment['id'];
			$pdf->SetFont('Arial','B',6);
			$pdf->SetAligns(array('C','C','L','L','R','R'));
			$pdf->Row(array("",
									$rowDepartment['nama'],
									"",
									"",
									"",
									""));		
			
			$pdf->SetFont('Arial','',6);
			
			$sqlTrans = "SELECT 
							tbm_karyawan.id,
							tbm_karyawan.nik,
							tbm_karyawan.nama,
							tbt_rekap_gaji_detail.jml_gaji_dibayarkan
						FROM 
							tbm_karyawan
							INNER JOIN tbm_jabatan ON tbm_jabatan.id = tbm_karyawan.id_jabatan
							INNER JOIN tbt_rekap_gaji_detail ON tbt_rekap_gaji_detail.id = tbm_karyawan.id
						WHERE
							tbm_karyawan.deleted = '0' 
							AND tbm_jabatan.deleted ='0'
							AND tbm_jabatan.id_department = '".$idDeparment."' ";
			$arrTrans = $this->queryAction($sqlTrans,'S');
			$no = 1;
			
			$pdf->SetAligns(array('C','L','L','L','R','R'));							
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
					
				$idBank = $KaryawanRecord->id_bank;
				
				if($idBank != '0')
				{
					$namaBank = BankRecord::finder()->findByPk($idBank)->nama;
					$noRek = $KaryawanRecord->norek;
					$transfer = number_format($row['jml_gaji_dibayarkan'],0,'.',',');
					$nontransfer = "";
					$totalTransfer += $row['jml_gaji_dibayarkan'];
					
				}
				else
				{
					$namaBank = "";
					$noRek = "";
					$transfer = "";
					$nontransfer = number_format($row['jml_gaji_dibayarkan'],0,'.',',');
					$totalNonTransfer += $row['jml_gaji_dibayarkan'];	
				}
				
					$pdf->Row(array($no,
									$row['nama'],
									$namaBank,
									$noRek,
									$transfer,
									$nontransfer));
									
					
					$no++;				
				
			}
		}
			$pdf->SetFont('Arial','B',6);
			$pdf->SetAligns(array('C','C','L','L','R','R'));
			$pdf->Row(array("",
									"TOTAL",
									"",
									"",
									number_format($totalTransfer,0,'.',','),
									number_format($totalNonTransfer,0,'.',',')));			
		
		$pdf->Ln(10);	
		
		$pdf->SetWidths(array(60,60,60));
		$pdf->SetAligns(array('C','C','C'));
		$pdf->SetFont('Arial','',6);	
		$pdf->RowNoBorder(array("Dibuat Oleh,",
									"Diverifikasi Oleh,",
									"Disetujui Oleh,"));	
		$pdf->Ln(10);	
		$pdf->SetFont('Arial','U',8);	
		$pdf->RowNoBorder(array("Adil Habib Daulay",
									"Mahzalena, SE",
									"Putra Mahkota Alam Hasibuan, SE"));
		$pdf->SetFont('Arial','B',8);	
		$pdf->RowNoBorder(array("Pengawas Timbangan & Payroll",
									"Asst. Accounting & SDM",
									"Direktur Utama"));
		$pdf->Output();	
	}
}
?>
