<?PHP
class cetakLapLabaRugiPdf extends MainConf
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
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',8,4,12);	
		$pdf->SetFont('Arial','B',12);
		
		$pdf->Cell(0,5,'LAPORAN LABA RUGI','0',0,'C');
		$pdf->Ln(4);
		$pdf->Cell(0,5,strtoupper($profilPerusahaan->nama),'0',0,'C');
		
		$pdf->Ln(4);			
		$pdf->SetFont('Arial','',8);
		$pdf->Cell(10,5,'','0',0,'C');
		$pdf->Cell(0,5,''.$profilPerusahaan->alamat.' TELP :' .$profilPerusahaan->telepon.'','0',0,'C');	
		$pdf->Ln(1);
		$pdf->Cell(0,4,'','B',1,'C');
		$pdf->Ln(1);		
		$pdf->SetFont('Arial','BU',10);
		
		$pdf->SetFont('Arial','B',10);
		$pdf->Cell(0,5,'PERIODE : '.$nmPeriode,'0',0,'C');
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C'));
		$pdf->SetWidths(array(50,40,65,40));
		$pdf->Row(array('JENIS TRANSAKSI','TGL TRANSAKSI','KETERANGAN', 'SALDO'));
		//$pdf->Ln(1);
		//$pdf->SetFont('Arial','',8);
		//$pdf->SetAligns(array('C','L','L','L','L','R','R','R','R','R'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapLabaRugiSql'];
		$arrData=$this->queryAction($sql,'S');
		$totalPendapatan = 0;
		$pdf->SetAligns(array('C'));
		$pdf->SetWidths(array(50));
		$pdf->SetFont('Arial','B',8);
		$pdf->RowNoBorder(array('PENDAPATAN'));
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('C','L','L','R'));
		$pdf->SetWidths(array(50,40,65,40));
		foreach($arrData as $row)
		{
			if($row['jns_transaksi'] == '0')
			{
				$pdf->RowNoBorder(array('',$this->ConvertDate($row['tgl_transaksi'],'3'),$row['keterangan'],number_format($row['jumlah_transaksi'],2,".",",")));
				$totalPendapatan += $row['jumlah_transaksi'];
			}
		}
		$pdf->SetAligns(array('C','L','R','R'));
		$pdf->SetFont('Arial','B',8);
		$pdf->RowNoBorder(array('','','Total Pendapatan',number_format($totalPendapatan,2,".",",")));
		
		$totalBeban = 0;
		$pdf->SetAligns(array('C'));
		$pdf->SetWidths(array(50));
		$pdf->SetFont('Arial','B',8);
		$pdf->RowNoBorder(array('BEBAN'));
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('C','L','L','R'));
		$pdf->SetWidths(array(50,40,65,40));
		foreach($arrData as $row)
		{
			if($row['jns_transaksi'] == '1')
			{
				$pdf->RowNoBorder(array('',$this->ConvertDate($row['tgl_transaksi'],'3'),$row['keterangan'],number_format($row['jumlah_transaksi'],2,".",",")));
				$totalBeban += $row['jumlah_transaksi'];
			}
		}
		$pdf->SetAligns(array('C','L','R','R'));
		$pdf->SetFont('Arial','B',8);
		
		$pdf->RowNoBorder(array('','','Total Beban',number_format($totalBeban,2,".",",")));
		
		$pdf->Ln(5);
		
		$labaRugi = $totalPendapatan - $totalBeban;
		if($labaRugi < 0)
			$pdf->SetTextColor(255,0,0);
			
		$pdf->RowNoBorder(array('','','Laba / Rugi',number_format($labaRugi,2,".",",")));
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
