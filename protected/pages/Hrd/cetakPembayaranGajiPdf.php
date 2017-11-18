<?PHP
class cetakPembayaranGajiPdf extends MainConf
{
	public function onPreInit($param)
	{
		parent::onPreInit($param);	
		$this->getResponse()->setContentType("application/pdf");
	}
	
	public function onLoad($param)
	{
		$id = $this->Request['id'];
		$jnsBayar = $this->Request['jnsBayar'];
		$BayarRekapGajiRecord = BayarRekapGajiRecord::finder()->findByPk($id);
		$tglBayar = $this->ConvertDate($BayarRekapGajiRecord->tgl_pembayaran,'3');
		
		$profilPerusahaan = $this->profilPerusahaan();	
			
		$pdf=new reportKwitansi('P','mm','A4');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',8,4,12);	
		$pdf->SetFont('Arial','B',12);
	    $pdf->Cell(0,5,'PEMBAYARAN GAJI KARYAWAN','0',0,'C');
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
		
		$pdf->SetFont('Arial','B',10);
		$pdf->Cell(0,5,'Tanggal Bayar : '.$tglBayar,'0',0,'L');
		
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C','C','C'));
		$pdf->SetWidths(array(30,45,25,25,25,35));
		$pdf->Row(array('NIK','Nama Karyawan','Jenis Bayar','Bank','No Rekening','Total Gaji'));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('C','L','L','L','L','R'));
		$sql = "SELECT
						tbt_rekap_gaji_detail.id,
						tbt_rekap_gaji_detail.id_karyawan,
						tbm_karyawan.nik,
						tbm_karyawan.nama,
						tbt_rekap_gaji_detail.jml_gaji_dibayarkan,
						tbt_rekap_gaji_detail.jns_bayar,
						tbm_bank.nama AS bank,
						tbm_karyawan.norek
					FROM
						tbt_rekap_gaji_detail
					INNER JOIN tbm_karyawan ON tbm_karyawan.id = tbt_rekap_gaji_detail.id_karyawan
					LEFT JOIN tbm_bank ON tbm_bank.id = tbt_rekap_gaji_detail.id_bank
					WHERE
						tbt_rekap_gaji_detail.id_bayar = '$id' ";
						
		if($jnsBayar != '')
		{
			$sql .= " AND tbt_rekap_gaji_detail.jns_bayar = '$jnsBayar' ";
		}
		
		$arrData=$this->queryAction($sql,'S');
		$Jumlah = 0;
		foreach($arrData as $row)
		{
			if($row['jns_bayar'] == '0')
			{
				$jnsBayar = 'Cash';
				$bank = '';
			}
			else
			{
				$jnsBayar = 'Transfer';
				$bank = $row['bank'];
			}
				
			$pdf->Row(array($row['nik'],
							$row['nama'],
							$jnsBayar,
							$bank,
							$row['norek'],
							number_format($row['jml_gaji_dibayarkan'],2,'.',',')));
				
			$Jumlah   += $rowDetail['jml_gaji_dibayarkan'];
			
		}
		
		$pdf->SetFont('Arial','B',9);
		
		/*$pdf->SetAligns(array('C','R','R','R','R'));
		$pdf->SetWidths(array(225,25,30,27,30));
		$pdf->Row(array('TOTAL',number_format($Jumlah,2,'.',','));*/
		$pdf->Output();	
	}
	
}
?>
