<?PHP
class cetakKartuStokPdf extends MainConf
{
	public function onPreInit($param)
	{
		parent::onPreInit($param);	
		$this->getResponse()->setContentType("application/pdf");
	}
	public function onLoad($param)
	{
		$stLap = $this->Request['stLap'];
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
		
		if($stLap == '0')
			$pdf->Cell(0,5,'KARTU STOK','0',0,'C');
		else
			$pdf->Cell(0,5,'KARTU STOK TBS','0',0,'C');
			
		$pdf->Ln(5);
		$pdf->Cell(0,5,'PERIODE : '.$nmPeriode,'0',0,'C');
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C','C','C','C','C','C','C'));
		$pdf->SetWidths(array(30,30,35,35,25,25,30,27,30,30));
		$pdf->Row(array('Tgl. Transaksi','Wkt. Transaksi','Jenis Transaksi','Nama Barang','Stok Awal','Stok In','Nilai In','Stok Out','Nilai Out','Stok Akhir'));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('L','L','L','L','R','R','R','R','R'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakKartuStokSql'];
		$arrData=$this->queryAction($sql,'S');
		$i = 1;
		$idPo = '';
		foreach($arrData as $row)
		{	
			$stokAwalList = '';
				$stokInList = '';
				$stokOutList = '';
				$stokAkhirList = '';
				
				if($row['jns_transaksi'] == '0')
					$jnsTrans = "Penjualan";
				elseif($row['jns_transaksi'] == '1')
					$jnsTrans = "Pembelian";
				elseif($row['jns_transaksi'] == '2')
					$jnsTrans = "Pembelian Kelapa Sawit";
				elseif($row['jns_transaksi'] == '3')
					$jnsTrans = "Pemakaian Produksi";
				elseif($row['jns_transaksi'] == '4')
					$jnsTrans = "Barang Rusak";
				elseif($row['jns_transaksi'] == '5')
					$jnsTrans = "Expired";
				elseif($row['jns_transaksi'] == '6')
					$jnsTrans = "Produksi Barang";
				elseif($row['jns_transaksi'] == '7')
					$jnsTrans = "Penjualan Commodity";
				
				$stokAwal = $this->getTargetUom($row['id_barang'],$row['stok_awal']); 
				foreach($stokAwal as $rowQty)
				{
					$stokAwalList .= $rowQty['qty']." ".$rowQty['name'].chr(10);
				}
				
				$stokIn = $this->getTargetUom($row['id_barang'],$row['stok_in']); 
				foreach($stokIn as $rowQty)
				{
					$stokInList .= $rowQty['qty']." ".$rowQty['name'].chr(10);
				}
				
				$stokOut = $this->getTargetUom($row['id_barang'],$row['stok_out']); 
				foreach($stokOut as $rowQty)
				{
					$stokOutList .= $rowQty['qty']." ".$rowQty['name'].chr(10);
				}
				
				$stokAkhir = $this->getTargetUom($row['id_barang'],$row['stok_akhir']); 
				foreach($stokAkhir as $rowQty)
				{
					$stokAkhirList .= $rowQty['qty']." ".$rowQty['name'].chr(10);
				}
				
			$pdf->Row(array($row['tgl'],
							$row['wkt'],
							$jnsTrans,
							$row['nama'],
							$stokAwalList,
							$stokInList,
							number_format($row['nilai_in'],2,'.',','),
							$stokOutList,
							number_format($row['nilai_out'],2,'.',','),
							$stokAkhirList));
			$i++;
		}
		
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
