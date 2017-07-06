<?PHP
class cetakLapHutangPdf extends MainConf
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
		$pdf->Cell(0,5,'LAPORAN HUTANG','0',0,'C');
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C','C','C'));
		$pdf->SetWidths(array(30,30,50,30,30,25));
		$pdf->Row(array('No. PO','Tgl. PO','Nama Supplier','Total PO','Hutang','Jatuh Tempo'));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('L','L','L','R','R','R'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapHutangSql'];
		$arrData=$this->queryAction($sql,'S');
		$i = 1;
		$idPo = '';
		foreach($arrData as $row)
		{	
			$ttlPo = 0;
				
				$sqlRO = "SELECT
							tbt_receiving_order_detail.jumlah,
							tbt_receiving_order_detail.harga_satuan,
							tbt_receiving_order_detail.discount,
							tbt_receiving_order_detail.subtotal
						FROM
							tbt_receiving_order
						INNER JOIN tbt_receiving_order_detail ON tbt_receiving_order_detail.id_parent = tbt_receiving_order.id
						INNER JOIN tbm_barang ON tbm_barang.id = tbt_receiving_order_detail.id_barang
						INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_receiving_order_detail.id_satuan 
						WHERE
							tbt_receiving_order.id_po = '".$row['id']."' ";
							
				$arrRO = $this->queryAction($sqlRO,'S');
				
				foreach($arrRO as $rowRO)
				{
					$ttlPo += $rowRO['subtotal'];
				}
				
				$sqlBiaya = "SELECT
									tbt_purchase_order_biaya_lain.nama_biaya,
									tbt_purchase_order_biaya_lain.biaya
								FROM
									tbt_purchase_order_biaya_lain
								WHERE
									tbt_purchase_order_biaya_lain.deleted = '0'
								AND tbt_purchase_order_biaya_lain.id_po = '".$row['id']."' ";

				$arrBiaya = $this->queryAction($sqlBiaya,'S');
				$BiayaLain = 0;
				if($arrBiaya)
				{
					foreach($arrBiaya as $rowBiaya)
					{
							$ttlPo += $rowBiaya['biaya'];
					}
				}
				
				$ppnCurrency = $ttlPo * ($row['ppn'] / 100);
				$ttlPo += $ppnCurrency;
				$ttlPo -= $row['dp'];
				
				$ttlByrPo = 0;
				$sqlRecord = "SELECT total_pembayaran FROM tbt_pembayaran_po WHERE id_po = '".$row['id']."' AND deleted = '0' ";
				$arrRecord = $this->queryAction($sqlRecord,'S');
				
				if(count($arrRecord) > 0)
				{
					foreach($arrRecord as $rowRecord)
					{
						$ttlByrPo +=  $rowRecord['total_pembayaran'];
					}
				}
				
				$sisaBayar = $ttlPo - $ttlByrPo;
				
			$pdf->Row(array($row['no_po'],
							$this->ConvertDate($row['tgl_po'],'3'),
							$row['pemasok'],
							number_format($ttlPo,2,'.',','),
							number_format($sisaBayar,2,'.',','),
							$this->ConvertDate($row['tgl_jatuh_tempo'],'3')));
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
