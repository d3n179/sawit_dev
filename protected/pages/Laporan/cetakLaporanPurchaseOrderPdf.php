<?PHP
class cetakLaporanPurchaseOrderPdf extends MainConf
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
			
		$pdf=new reportKwitansi('L','mm','legal');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',8,4,12);	
		$pdf->SetFont('Arial','B',12);
	    $pdf->Cell(0,5,'LAPORAN PURCHASE ORDER','0',0,'C');
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
		$pdf->SetAligns(array('C','C','C','C','C','C','C','C','C','C'));
		$pdf->SetWidths(array(10,30,20,65,75,25,25,30,27,30));
		$pdf->Row(array('NO','NO. PO','Tgl PO','SUPPLIER','N. BARANG','SATUAN','JUMLAH','HARGA','DISCOUNT','SUBTOTAL'));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('C','L','L','L','L','R','R','R','R','R'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapPurchaseOrderSql'];
		$arrData=$this->queryAction($sql,'S');
		$i = 1;
		$idPo = '';
		foreach($arrData as $row)
		{
			$arrDetail = $this->getDetailPO($row['id']);
			$totalSubPO = 0;
			$pdf->SetFont('Arial','',8);
			foreach($arrDetail as $rowDetail)
			{
				if($idPo != $row['id'])
				{
					$no = $i;
					$noPO = $row['no_po'];
					$tglPO = $this->ConvertDate($row['tgl_po'],'3');
					$nmSupplier = $row['supplier'];
					$idPo = $row['id'];
					
						
						
					
				}
				else
				{
					
					$no = '';
					$noPO = '';
					$tglPO = '';
					$nmSupplier = '';
				}
				
				$pdf->Row(array($no,$noPO,$tglPO,$nmSupplier,$rowDetail['nama'],$rowDetail['satuan'],number_format($rowDetail['jumlah'],2,'.',','),number_format($rowDetail['harga_satuan'],2,'.',','),number_format($rowDetail['discount'],2,'.',','),number_format($rowDetail['subtotal'],2,'.',',')));
				
				
				$Jumlah   +=$rowDetail['jumlah'];
				$Harga    +=$rowDetail['harga_satuan'];
				$Discount +=$rowDetail['discount'];
				$Subtotal +=$rowDetail['subtotal'];
				$totalSubPO += $rowDetail['subtotal'];
			}
			$pdf->SetFont('Arial','B',8);
			$pdf->Row(array('','','','','','','','','',number_format($totalSubPO ,2,'.',',')));
			
			
			$i++;
		}
		
		$pdf->SetFont('Arial','B',9);
		
		$pdf->SetAligns(array('C','R','R','R','R'));
		$pdf->SetWidths(array(225,25,30,27,30));
		$pdf->Row(array('TOTAL',''.number_format($Jumlah,2,'.',',').'',
		''.number_format($Harga,2,'.',',').'',
		''.number_format($Discount,2,'.',',').'',
		''.number_format($Subtotal,2,'.',',').''));
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
