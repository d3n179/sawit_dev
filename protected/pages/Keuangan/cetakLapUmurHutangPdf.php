<?PHP
class cetakLapUmurHutangPdf extends MainConf
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
		$pdf->Cell(0,5,'LAPORAN UMUR HUTANG PO','0',0,'C');
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C','C','C','C'));
		$pdf->SetWidths(array(10,70,30,50,50,50,20,20,20,20));
		$pdf->Row(array('No','Nama Supplier','Jumlah PO','Total PO','Total Pembayaran Hutang','Sisa Hutang','30 Hari','60 Hari','90 Hari','120 Hari'));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('C','L','R','R','R','R','C','C','C','C'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapUmurHutangSql'];
		$arrData=$this->queryAction($sql,'S');
		$i = 1;
		$idPo = '';
		foreach($arrData as $row)
		{	
			$ttlPo = 0;
				$idSupplier = $row['id_supplier'];
				$sqlPO ="SELECT
						tbt_purchase_order.id,
						tbt_purchase_order.dp,
						tbt_purchase_order.ppn
					FROM
						tbt_purchase_order
					WHERE
						tbt_purchase_order.`status` = '2' 
						AND tbt_purchase_order.id_supplier = '".$idSupplier."' 
						AND tbt_purchase_order.deleted ='0' ";
				$arrPo = $this->queryAction($sqlPO,'S');
				foreach($arrPo as $rowPo)
				{
					$idPo = $rowPo['id'];
					$ppn = $rowPo['ppn'];
					
					$sqlTtlPO = "SELECT
									SUM(
										tbt_receiving_order_detail.subtotal
									) AS total_po
								FROM
									tbt_receiving_order_detail
								INNER JOIN tbt_receiving_order ON tbt_receiving_order.id = tbt_receiving_order_detail.id_parent
								INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_receiving_order.id_po
								WHERE
									tbt_purchase_order.id = '".$idPo."'
									AND tbt_receiving_order.deleted = '0' 
									AND tbt_receiving_order_detail.deleted = '0' 
								GROUP BY
									tbt_purchase_order.id ";
					$arrTtlPO = $this->queryAction($sqlTtlPO,'S');
					$ttlPo += $arrTtlPO[0]['total_po'];
					
					$sqlBiaya = "SELECT
									SUM(
										tbt_purchase_order_biaya_lain.biaya
									) AS Total_Biaya
								FROM
									tbt_purchase_order_biaya_lain
								INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_purchase_order_biaya_lain.id_po
								WHERE
									tbt_purchase_order.id = '".$idPo."'
								AND tbt_purchase_order_biaya_lain.deleted = '0'
								GROUP BY
									tbt_purchase_order.id";
									
					$arrTtlBiaya = $this->queryAction($sqlBiaya,'S');
					$ttlPo += $arrTtlBiaya[0]['Total_Biaya'];
					
					$ppnCurrency = $ttlPo * ($rowPo['ppn'] / 100);
					$ttlPo += $ppnCurrency;
					$ttlPo -= $rowPo['dp'];
				}
				
				$sqlBayar = "SELECT
								SUM(
									tbt_pembayaran_po.total_pembayaran
								) AS total_pembayaran
							FROM
								tbt_pembayaran_po
							INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_pembayaran_po.id_po
							WHERE
								tbt_purchase_order.id_supplier = '".$idSupplier."'
							AND tbt_pembayaran_po.deleted = '0'
							AND tbt_purchase_order.`status` = '2'
							AND tbt_purchase_order.deleted = '0'
							GROUP BY
								tbt_purchase_order.id ";
				$arrttlByrPo = $this->queryAction($sqlBayar,'S');
				$ttlByrPo = $arrttlByrPo[0]['total_pembayaran'];
				$sisaBayar = $ttlPo - $ttlByrPo;
				
				
				$sqlDiff30 = "SELECT
									COUNT(tbt_purchase_order.id) AS umur
								FROM
									tbt_purchase_order
								WHERE
									tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.id_supplier = '".$idSupplier."'
								AND DATEDIFF(
									tbt_purchase_order.tgl_jatuh_tempo,
									CURDATE()
								) <= 30 ";
				$arrDiff30 = $this->queryAction($sqlDiff30,'S');
				$diff30 = $arrDiff30[0]['umur'];
				
				$sqlDiff60 = "SELECT
									COUNT(tbt_purchase_order.id) AS umur
								FROM
									tbt_purchase_order
								WHERE
									tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.id_supplier = '".$idSupplier."'
								AND DATEDIFF(
									tbt_purchase_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 30 AND 60 ";
				$arrDiff60 = $this->queryAction($sqlDiff60,'S');
				$diff60 = $arrDiff60[0]['umur'];
				
				$sqlDiff90 = "SELECT
									COUNT(tbt_purchase_order.id) AS umur
								FROM
									tbt_purchase_order
								WHERE
									tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.id_supplier = '".$idSupplier."'
								AND DATEDIFF(
									tbt_purchase_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 60 AND 90 ";
				$arrDiff90 = $this->queryAction($sqlDiff90,'S');
				$diff90 = $arrDiff90[0]['umur'];
				
				$sqlDiff120 = "SELECT
									COUNT(tbt_purchase_order.id) AS umur
								FROM
									tbt_purchase_order
								WHERE
									tbt_purchase_order.`status` = '2'
								AND tbt_purchase_order.id_supplier = '".$idSupplier."'
								AND (DATEDIFF(
									tbt_purchase_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 90 AND 120  OR  DATEDIFF(
									tbt_purchase_order.tgl_jatuh_tempo,
									CURDATE()
								) > 120 )";
				$arrDiff120 = $this->queryAction($sqlDiff120,'S');
				$diff120 = $arrDiff120[0]['umur'];
				
			$pdf->Row(array($i,$row['pemasok'],
							$row['jml_po'],
							number_format($ttlPo,2,'.',','),
							number_format($ttlByrPo,2,'.',','),
							number_format($sisaBayar,2,'.',','),
							$diff30,
							$diff60,
							$diff90,
							$diff120));
			$i++;
			$barisPo +=$row['jml_po'];
			$SubttlPo +=$ttlPo;
			$SubttlByrPo +=$ttlByrPo;
			$SubSisa +=$sisaBayar;
			$H30 +=$diff30;
			$H60 +=$diff60;
			$H90 +=$diff90;
			$H120 +$diff120;
		}
		$pdf->SetFont('Arial','B',10);
		$pdf->SetAligns(array('C','R','R','R','R','R','R'));
		$pdf->SetWidths(array(80,30,50,50,50,20,20,20,20));
		$pdf->Row(array('Total',''.number_format($barisPo,2,'.',',').'',''.number_format($SubttlPo,2,'.',',').'',
		''.number_format($SubttlByrPo,2,'.',',').'',''.number_format($SubSisa,2,'.',',').'',
		''.number_format($H30,2,'.',',').'',''.number_format($H60,2,'.',',').'',
		''.number_format($H90,2,'.',',').'',''.number_format($H120,2,'.',',').''));
		$pdf->Output();	
	}
}
?>
