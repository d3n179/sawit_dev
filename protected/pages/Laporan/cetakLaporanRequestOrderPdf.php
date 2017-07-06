<?PHP
class cetakLaporanRequestOrderPdf extends MainConf
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
		
		if($bln == '1')
			$nmBulan = "Januari";
		elseif($bln == '2')
			$nmBulan = "Februari";
		elseif($bln == '3')
			$nmBulan = "Maret";
		elseif($bln == '4')
			$nmBulan = "April";
		elseif($bln == '5')
			$nmBulan = "Mei";
		elseif($bln == '6')
			$nmBulan = "Juni";
		elseif($bln == '7')
			$nmBulan = "Juli";
		elseif($bln == '8')
			$nmBulan = "Agustus";
		elseif($bln == '9')
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
			
		$pdf=new reportKwitansi('L','mm','legal');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		$profilPerusahaan = $this->profilPerusahaan();	
			
		$pdf=new reportKwitansi('L','mm','legal');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',8,4,12);	
		$pdf->SetFont('Arial','B',12);
	    $pdf->Cell(0,5,'LAPORAN REQUEST ORDER','0',0,'C');
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
		$pdf->Cell(0,5,'PERIODE : '.$nmPeriode,'0',0,'L');
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C','C','C','C','C'));
		$pdf->SetWidths(array(10,50,30,115,28,28,35,40));
		$pdf->Row(array('NO','NO. RO','Tgl RO','NAMA BARANG','SATUAN','JUMLAH','HARGA','SUBTOTAL'));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('C','L','L','L','R','R','R','R'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapRequestOrderSql'];
		$arrData=$this->queryAction($sql,'S');
		$i = 1;
		$idRo = '';
		foreach($arrData as $row)
		{
			$arrDetail = $this->getDetailRO($row['id']);
			foreach($arrDetail as $rowDetail)
			{
				if($idRo != $row['id'])
				{
					$no = $i;
					$noRO = $row['no_ro'];
					$tglRO = $this->ConvertDate($row['tgl_ro'],'3');
					$idRo = $row['id'];
				}
				else
				{
					$no = '';
					$noRO = '';
					$tglRO = '';
				}
				
				$pdf->Row(array($no,$noRO,$tglRO,$rowDetail['nama'],$rowDetail['satuan'],number_format($rowDetail['jumlah'],2,'.',','),number_format($rowDetail['harga_satuan'],2,'.',','),number_format($rowDetail['subtotal'],2,'.',',')));
				
				$Jumlah   +=$rowDetail['jumlah'];
				$Harga    +=$rowDetail['harga_satuan'];
				$Subtotal +=$rowDetail['subtotal'];
			}
			$i++;
		}
		$pdf->SetFont('Arial','B',9);
		
		$pdf->SetAligns(array('C','R','R','R','R'));
		$pdf->SetWidths(array(233,28,35,40));
		$pdf->Row(array('TOTAL',''.number_format($Jumlah,2,'.',',').'',
		''.number_format($Harga,2,'.',',').'',
		''.number_format($Subtotal,2,'.',',').''));
		$pdf->Output();	
	}
	
	
	public function getDetailRO($idRo)
	{
		$sql = "SELECT
					tbt_request_order_detail.id,
					tbt_request_order_detail.id_barang,
					tbm_barang.nama,
					tbt_request_order_detail.id_satuan,
					tbm_satuan.nama AS satuan,
					tbt_request_order_detail.harga_satuan_besar,
					tbt_request_order_detail.harga_satuan,
					tbt_request_order_detail.jumlah,
					tbt_request_order_detail.subtotal
				FROM
					tbt_request_order_detail
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_request_order_detail.id_barang
				INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_request_order_detail.id_satuan
				WHERE
					tbt_request_order_detail.deleted = '0'
				AND tbt_request_order_detail.id_ro = '$idRo'
				ORDER BY
					tbt_request_order_detail.id ASC ";
		$arr = $this->queryAction($sql,'S');
		
		return $arr;
	}
}
?>
