<?PHP
class cetakResignFormPdf extends MainConf
{
	public function onPreInit($param)
	{
		parent::onPreInit($param);	
		$this->getResponse()->setContentType("application/pdf");
	}
	public function onLoad($param)
	{	
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
		$pdf->Cell(0,5,'RESIGN REPORT','0',0,'C');
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C'));
		$pdf->SetWidths(array(40,35,60,60));
		$pdf->Row(array('Nama Karyawan','Tgl. Resign','Kategori Resign','Keterangan'));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('L','L','L','L'));
		$sql = "SELECT
					tbt_resign_employee.id,
					tbt_resign_employee.tgl_resign,
					tbt_resign_employee.kategori_resign,
					tbt_resign_employee.keterangan,
					tbm_karyawan.nama
				FROM
					tbt_resign_employee
				INNER JOIN tbm_karyawan ON tbm_karyawan.id = tbt_resign_employee.id_karyawan
				WHERE
					tbt_resign_employee.deleted = '0'
				ORDER BY 
					tbt_resign_employee.id ASC ";
		$arrData=$this->queryAction($sql,'S');
		$i = 1;
		$idPo = '';
		foreach($arrData as $row)
		{		
			$pdf->Row(array($row['nama'],
							$this->ConvertDate($row['tgl_resign'],'3'),
							$row['kategori_resign'],
							$row['keterangan']));
			$i++;
		}
		
		$pdf->Output();	
	}
}
?>
