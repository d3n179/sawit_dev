<?PHP
class cetakLapJurnalUmumPdf extends MainConf
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
		$pdf->Cell(0,5,'LAPORAN JURNAL UMUM','0',0,'C');
		$pdf->Ln(5);
		$pdf->Cell(0,5,'PERIODE : '.$nmPeriode,'0',0,'C');
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C','C'));
		$pdf->SetWidths(array(35,40,60,30,30));
		$pdf->Row(array('TGL TRANSAKSI','No. BUKTI TRANSAKSI','KETERANGAN', 'DEBET','KREDIT'));
		//$pdf->Ln(1);
		//$pdf->SetFont('Arial','',8);
		//$pdf->SetAligns(array('C','L','L','L','L','R','R','R','R','R'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapJurnalUmumSql'];
		$arrData=$this->queryAction($sql,'S');
		$totalDebet= 0;
		$totalKredit= 0;
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('C','L','L','R','R'));
		foreach($arrData as $row)
		{
			if($row['jns_transaksi'] == '0')
			{
				$pdf->Row(array($this->ConvertDate($row['tgl_transaksi'],'3'),$row['no_transaksi'],$row['keterangan'],number_format($row['jumlah_saldo'],2,".",","),''));
				$totalDebet += $row['jumlah_saldo'];
			}
			elseif($row['jns_transaksi'] == '1')
			{
				$pdf->Row(array($this->ConvertDate($row['tgl_transaksi'],'3'),$row['no_transaksi'],chr(32).chr(32).chr(32).chr(32).chr(32).chr(32).chr(32).$row['keterangan'],'',number_format($row['jumlah_saldo'],2,".",",")));
				$totalKredit += $row['jumlah_saldo'];
			}
				
				
		}
		$pdf->SetFont('Arial','B',8);
		$pdf->SetWidths(array(135,30,30));
		$pdf->SetAligns(array('C','R','R'));
		
		$pdf->Row(array('JUMLAH TOTAL',number_format($totalDebet,2,".",","),number_format($totalKredit,2,".",",")));
		
		$pdf->Output();	
	}
	
	public function getDetailPO($idPo)
	{
		$sql = "SELECT
					tbt_purchase_order_detail.id,
					tbt_purchase_order_detail.id_barang,
					tbm_barang.nama,
					tbt_purchase_order_detail.id_satuan,
					tbm_satuan.nama AS satuan,
					tbt_purchase_order_detail.harga_satuan_besar,
					tbt_purchase_order_detail.harga_satuan,
					tbt_purchase_order_detail.jumlah,
					tbt_purchase_order_detail.discount,
					tbt_purchase_order_detail.subtotal
				FROM
					tbt_purchase_order_detail
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_purchase_order_detail.id_barang
				INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_purchase_order_detail.id_satuan
				WHERE
					tbt_purchase_order_detail.deleted = '0'
				AND tbt_purchase_order_detail.id_po = '$idPo'
				ORDER BY
					tbt_purchase_order_detail.id ASC ";
		$arr = $this->queryAction($sql,'S');
		
		return $arr;
	}
}
?>
