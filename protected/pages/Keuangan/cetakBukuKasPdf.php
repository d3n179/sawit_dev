<?PHP
class cetakBukuKasPdf extends MainConf
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
		$idBank = $this->Request['idBank'];
		$nmBank = BankRecord::finder()->findByPk($idBank)->nama;
		
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
		
		$datestring= $thn.'-'.$bln.'-01 first day of last month';
		$dt=date_create($datestring);
		$lastYear = $dt->format('Y');
		$lastMonth = $dt->format('m');
		
		$sql = "SELECT
					tbt_jurnal_buku_besar.id,
					tbt_jurnal_buku_besar.saldo_akhir
				FROM
					tbt_jurnal_buku_besar
				WHERE
					tbt_jurnal_buku_besar.id_bank = '$idBank'
					AND YEAR(tbt_jurnal_buku_besar.tgl_transaksi) = '$lastYear'
					AND MONTH(tbt_jurnal_buku_besar.tgl_transaksi) = '$lastMonth'
				ORDER BY
					tbt_jurnal_buku_besar.id DESC
				LIMIT 1 ";
		$arrLastMonth = $this->queryAction($sql,'S');
		if($arrLastMonth)
			$saldoBulanLalu = $arrLastMonth[0]['saldo_akhir'];
		else
			$saldoBulanLalu = 0;
			
		$pdf=new reportKwitansi('L','mm','legal');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		$pdf->SetFont('Arial','B',10);
		$pdf->Cell(0,5,'BUKU KAS','0',0,'C');
		$pdf->Ln(5);
		$pdf->Cell(0,5,'PERIODE : '.$nmPeriode,'0',0,'C');
		$pdf->Ln(5);
		$pdf->Cell(0,5,'ASAL KAS : '.$nmBank,'0',0,'C');
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C','C','C','C'));
		$pdf->SetWidths(array(30,40,120,30,35,35,35));
		$pdf->Row(array('TGL','NO. TRANSAKSI','URAIAN','KODE COA','DEBET','KREDIT','SALDO'));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('L','L','L','L','R','R','R'));
		$session=new THttpSession;
		$session->open();
		$sql = $session['cetakBukuKasSql'];
		$arrData=$this->queryAction($sql,'S');
			
		$i = 1;
		$idPo = '';
		$pdf->Row(array('',
							'',
							'Saldo Bulan Lalu',
							'',
							'',
							'',
							number_format($saldoBulanLalu,2,'.',',')));
		foreach($arrData as $row)
		{
			if($row['jns_transaksi'] == '0')//DEBET
			{
				$debet = number_format($row['saldo_transaksi'],2,'.',',');
				$kredit = number_format(0,2,'.',',');
			}
			else
			{
				$debet = number_format(0,2,'.',',');
				$kredit = number_format($row['saldo_transaksi'],2,'.',',');
			}
			
			$pdf->Row(array($this->ConvertDate($row['tgl_transaksi'],'3'),
							$row['no_transaksi'],
							$row['keterangan'],
							$row['kode_coa'],
							$debet,
							$kredit,
							number_format($row['saldo_akhir'],2,'.',',')));
			
		}
		
		$pdf->Output();	
	}
	
}
?>
