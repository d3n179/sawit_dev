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
		$pdf->SetAligns(array('L','L','R','R','R','R','R','R','R'));
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
				
				
				$sqlOrder30 ="SELECT
								tbt_tbs_order.id
							FROM
								tbt_tbs_order
							WHERE
								tbt_tbs_order.`status` = '1' 
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."' 
								AND tbt_tbs_order.deleted ='0' 
								AND DATEDIFF(
											tbt_tbs_order.tgl_jatuh_tempo,
											CURDATE()
										) <= 30 ";
				$arrOrder30 = $this->queryAction($sqlOrder30,'S');
				$ttlTbsOrder30 = 0;
				$ttlByrOrder30 = 0;
				foreach($arrOrder30 as $rowOrder30)
				{
					$idTbsOrder = $rowOrder30['id'];
					
					$sqlTtlOrder30 = "SELECT
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
					$arrTtlOrder30 = $this->queryAction($sqlTtlOrder30,'S');
					$ttlTbsOrder30 += $arrTtlOrder30[0]['total_tbs_order'];
					
					$sqlBayar30 = "SELECT
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
					$arrttlByrOrder30 = $this->queryAction($sqlBayar30,'S');
					$ttlByrOrder30 += $arrttlByrOrder30[0]['total_pembayaran'];
				}
				$diff30 = $ttlTbsOrder30 - $ttlByrOrder30;
				
				
				$sqlOrder60 ="SELECT
								tbt_tbs_order.id
							FROM
								tbt_tbs_order
							WHERE
								tbt_tbs_order.`status` = '1' 
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."' 
								AND tbt_tbs_order.deleted ='0' 
								AND DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 30 AND 60 ";
				$arrOrder60 = $this->queryAction($sqlOrder60,'S');
				$ttlTbsOrder60 = 0;
				$ttlByrOrder60 = 0;
				foreach($arrOrder60 as $rowOrder60)
				{
					$idTbsOrder = $rowOrder60['id'];
					
					$sqlTtlOrder60 = "SELECT
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
					$arrTtlOrder60 = $this->queryAction($sqlTtlOrder60,'S');
					$ttlTbsOrder60 += $arrTtlOrder60[0]['total_tbs_order'];
					
					$sqlBayar60 = "SELECT
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
					$arrttlByrOrder60 = $this->queryAction($sqlBayar60,'S');
					$ttlByrOrder60 += $arrttlByrOrder60[0]['total_pembayaran'];
				}
				$diff60 = $ttlTbsOrder60 - $ttlByrOrder60;
				
				$sqlOrder90 ="SELECT
								tbt_tbs_order.id
							FROM
								tbt_tbs_order
							WHERE
								tbt_tbs_order.`status` = '1' 
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."' 
								AND tbt_tbs_order.deleted ='0' 
								AND DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 60 AND 90 ";
				$arrOrder90 = $this->queryAction($sqlOrder90,'S');
				$ttlTbsOrder90 = 0;
				$ttlByrOrder90 = 0;
				foreach($arrOrder90 as $rowOrder90)
				{
					$idTbsOrder = $rowOrder90['id'];
					
					$sqlTtlOrder90 = "SELECT
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
					$arrTtlOrder90 = $this->queryAction($sqlTtlOrder90,'S');
					$ttlTbsOrder90 += $arrTtlOrder90[0]['total_tbs_order'];
					
					$sqlBayar90 = "SELECT
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
					$arrttlByrOrder90 = $this->queryAction($sqlBayar90,'S');
					$ttlByrOrder90 += $arrttlByrOrder90[0]['total_pembayaran'];
				}
				$diff90 = $ttlTbsOrder90 - $ttlByrOrder90;
				
				$sqlOrder120 ="SELECT
								tbt_tbs_order.id
							FROM
								tbt_tbs_order
							WHERE
								tbt_tbs_order.`status` = '1' 
								AND tbt_tbs_order.id_pemasok = '".$idPemasok."' 
								AND tbt_tbs_order.deleted ='0' 
								AND (DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) BETWEEN 90 AND 120  OR  DATEDIFF(
									tbt_tbs_order.tgl_jatuh_tempo,
									CURDATE()
								) > 120 )";
				$arrOrder120 = $this->queryAction($sqlOrder120,'S');
				$ttlTbsOrder120 = 0;
				$ttlByrOrder120 = 0;
				foreach($arrOrder120 as $rowOrder120)
				{
					$idTbsOrder = $rowOrder120['id'];
					
					$sqlTtlOrder120 = "SELECT
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
					$arrTtlOrder120 = $this->queryAction($sqlTtlOrder120,'S');
					$ttlTbsOrder120 += $arrTtlOrder120[0]['total_tbs_order'];
					
					$sqlBayar120 = "SELECT
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
					$arrttlByrOrder120 = $this->queryAction($sqlBayar120,'S');
					$ttlByrOrder120 += $arrttlByrOrder120[0]['total_pembayaran'];
				}
				$diff120 = $ttlTbsOrder120 - $ttlByrOrder120;
				
			$pdf->Row(array($row['pemasok'],
							$row['jml_order'],
							number_format($ttlTbsOrder,2,'.',','),
							number_format($ttlByrOrder,2,'.',','),
							number_format($sisaBayar,2,'.',','),
							number_format($diff30,2,'.',','),
							number_format($diff60,2,'.',','),
							number_format($diff90,2,'.',','),
							number_format($diff120,2,'.',',')));
			$i++;
		}
		
		$pdf->Output();	
	}
}
?>
