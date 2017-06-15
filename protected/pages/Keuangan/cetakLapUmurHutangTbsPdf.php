<?PHP
class cetakLapUmurHutangTbsPdf extends MainConf
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
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',8,4,12);	
		$pdf->SetFont('Arial','B',12);
	    $pdf->Cell(0,5,'LAPORAN UMUR HUTANG TBS','0',0,'C');
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
		
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C','C','C'));
		$pdf->SetWidths(array(70,30,50,50,50,23,23,23,23));
		$pdf->Row(array('Nama Supplier','Jumlah Order','Total Order','Total Pembayaran Hutang','Sisa Hutang','30 Hari','60 Hari','90 Hari','120 Hari'));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('L','L','R','R','R','C','C','C','C'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakLapUmurHutangTbsSql'];
		$arrData=$this->queryAction($sql,'S');
		$i = 1;
		$idPo = '';
		foreach($arrData as $row)
		{	
			$ttlTbsOrder = 0;
				$idPemasok = $row['id_pemasok'];
				$sqlOrder ="SELECT
						tbt_tbs_order.id
					FROM
						tbt_tbs_order
					WHERE
						tbt_tbs_order.`status` = '1' 
						AND tbt_tbs_order.id_pemasok = '".$idPemasok."' 
						AND tbt_tbs_order.deleted ='0' ";
				$arrOrder = $this->queryAction($sqlOrder,'S');
				foreach($arrOrder as $rowOrder)
				{
					$idTbsOrder = $rowOrder['id'];
					
					$sqlTtlOrder = "SELECT
									SUM(
										tbt_tbs_order_detail.total_tbs_order
									) AS total_tbs_order
								FROM
									tbt_tbs_order_detail
								INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_tbs_order_detail.id_tbs_order
								WHERE
									tbt_tbs_order.id = '".$idTbsOrder."'
									AND tbt_tbs_order.deleted = '0' 
									AND tbt_tbs_order_detail.deleted = '0' 
								GROUP BY
									tbt_tbs_order.id ";
					$arrTtlOrder = $this->queryAction($sqlTtlOrder,'S');
					$ttlTbsOrder += $arrTtlOrder[0]['total_tbs_order'];
					
				}
				
				$sqlBayar = "SELECT
								SUM(
									tbt_pembayaran_tbs.jumlah_pembayaran
								) AS total_pembayaran
							FROM
								tbt_pembayaran_tbs
							INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_pembayaran_tbs.id_tbs_order
							WHERE
								tbt_tbs_order.id_pemasok = '".$idPemasok."'
							AND tbt_pembayaran_tbs.deleted = '0'
							AND tbt_tbs_order.`status` = '1'
							AND tbt_tbs_order.deleted = '0'
							GROUP BY
								tbt_tbs_order.id ";
				$arrttlByrOrder = $this->queryAction($sqlBayar,'S');
				$ttlByrOrder = $arrttlByrOrder[0]['total_pembayaran'];
				$sisaBayar = $ttlTbsOrder - $ttlByrOrder;
				
				
				$sqlDiff30 = "SELECT
									COUNT(tbt_tbs_order.id) AS umur
								FROM
									tbt_tbs_order
								WHERE
									tbt_tbs_order.`status` = '1'
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."'
								AND DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) <= 30 ";
				$arrDiff30 = $this->queryAction($sqlDiff30,'S');
				$diff30 = $arrDiff30[0]['umur'];
				
				$sqlDiff60 = "SELECT
									COUNT(tbt_tbs_order.id) AS umur
								FROM
									tbt_tbs_order
								WHERE
									tbt_tbs_order.`status` = '1'
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."'
								AND DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 30 AND 60 ";
				$arrDiff60 = $this->queryAction($sqlDiff60,'S');
				$diff60 = $arrDiff60[0]['umur'];
				
				$sqlDiff90 = "SELECT
									COUNT(tbt_tbs_order.id) AS umur
								FROM
									tbt_tbs_order
								WHERE
									tbt_tbs_order.`status` = '1'
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."'
								AND DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 60 AND 90 ";
				$arrDiff90 = $this->queryAction($sqlDiff90,'S');
				$diff90 = $arrDiff90[0]['umur'];
				
				$sqlDiff120 = "SELECT
									COUNT(tbt_tbs_order.id) AS umur
								FROM
									tbt_tbs_order
								WHERE
									tbt_tbs_order.`status` = '1'
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."'
								AND (DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 90 AND 120  OR  DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) > 120 )";
				$arrDiff120 = $this->queryAction($sqlDiff120,'S');
				$diff120 = $arrDiff120[0]['umur'];
				
			$pdf->Row(array($row['pemasok'],
							$row['jml_order'],
							number_format($ttlTbsOrder,2,'.',','),
							number_format($ttlByrOrder,2,'.',','),
							number_format($sisaBayar,2,'.',','),
							$diff30,
							$diff60,
							$diff90,
							$diff120));
			$i++;
		}
		
		$pdf->Output();	
	}
}
?>
