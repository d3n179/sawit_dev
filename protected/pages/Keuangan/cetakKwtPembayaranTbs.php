<?php
class cetakKwtPembayaranTbs extends MainConf
{
	public function onInit($param)
	{		
		parent::onInit($param);
		$this->getResponse()->setContentType("application/pdf");
	}		 
	
	public function onPreInit ($param)
	{
		parent::onPreInit($param);
		//$this->setMasterClass('Application.layouts.PdfLayout');
	}
	
	public function onLoad($param)
	{	
		$id = $this->Request['id'];
		$BayarTbsOrderRecord = BayarTbsOrderRecord::finder()->findByPk($id);
		$TbsOrderRecord = TbsOrderRecord::finder()->findByPk($BayarTbsOrderRecord->id_tbs_order);
		$PemasokRecord = PemasokRecord::finder()->findByPk($TbsOrderRecord->id_pemasok);
		$profilPerusahaan = $this->profilPerusahaan();
		//$pdf=new reportKwitansiGsm();
		$pdf=new reportKwitansiGsm('L','mm','kwt_rsp');
		$pdf->AliasNbPages();
		
		$pdf->SetLeftMargin(10);
		$pdf->SetRightMargin(10);
		$pdf->SetTopMargin(5);
		$pdf->SetLn(5);	
		$pdf->SetAutoPageBreak(true, $bottomMargin - 5 );
		
		$pdf->AddPage();	
		$pdf->SetFooterTxt('');
		
		
		$pdf->SetFont('Courier','BU',11);
		$pdf->SetFont('Courier','B',11);
				
		//$url = $this->Service->constructUrl('Pendaftaran.DataPasDetail').'&cm='.$cm.'&tipeRawat='.$jnsPasien.'&purge=1';
		$url = 'index.php?page=Pendaftaran.DataPasDetail&cm='.$cm.'&tipeRawat='.$jnsPasien;
		
		$pdf->SetFont('Courier','B',9);
		$pdf->SetAutoPageBreak(true,0);
		$pdf->SetFooterTxt('');
		//$pdf->Image('protected/pages/Tarif/logo1.jpg',3,5,20);	
		
		$pdf->SetFont('Courier','B',9);
		$pdf->SetWidths(array(195));
		$pdf->SetAligns(array('L'));
		$pdf->RowNoBorder(array($profilPerusahaan->nama));
		
		$pdf->SetFont('Courier','',8.5);
		$pdf->SetWidths(array(195));
		$pdf->SetAligns(array('L'));
		$pdf->RowNoBorder(array($profilPerusahaan->alamat));
		$pdf->RowNoBorder(array($profilPerusahaan->telepon));
		
		$pdf->RowNoBorder(array('...........................................................................................................'));
		$pdf->SetFont('Courier','B',12);
		$pdf->SetAligns(array('C'));
		$pdf->RowNoBorder(array('KWITANSI'));
		$pdf->RowNoBorder(array('NO. '.$BayarTbsOrderRecord->no_pembayaran));
		$pdf->SetFont('Courier','',8.5);
		$pdf->SetLn(4);	
		$pdf->SetWidths(array(195));
		$pdf->RowNoBorder(array('...........................................................................................................'));
		$pdf->SetFont('Courier','',8.5);
				
		$pdf->SetWidths(array(45,5,150));
		$pdf->SetAligns(array('L','C','L'));
		$pdf->RowNoBorder(array('Dibayar Kepada',':',$PemasokRecord->nama));
		$pdf->RowNoBorder(array('Uang Sebesar',':',ucwords($this->terbilang($BayarTbsOrderRecord->jumlah_pembayaran,true)). ' Rupiah'));
		$pdf->RowNoBorder(array('Untuk Pembayaran',':','Pembelian Kelapa Sawit'));
		$pdf->SetWidths(array(195));
		$pdf->SetAligns(array('L'));
		$pdf->Ln(10);
		$pdf->RowNoBorder(array('...........................................................................................................'));
		
		$pdf->SetFont('Courier','B',12);
		$pdf->SetWidths(array(45,5,150));
		$pdf->SetAligns(array('L','C','L'));
		
		$pdf->RowNoBorder(array('Jumlah',':',number_format($BayarTbsOrderRecord->jumlah_pembayaran,2,'.',',')));
		$pdf->SetFont('Courier','',8.5);
		$pdf->SetWidths(array(195));
		$pdf->SetAligns(array('L'));
		$pdf->RowNoBorder(array('...........................................................................................................'));
		$pdf->Ln(5);
		/*$pdf->SetWidths(array(55,40,50,40));
		$pdf->SetAligns(array('L','R','C','L'));
		$sql = "SELECT
					tbm_barang.nama,
					tbt_mutasi_barang_detail.jml,
					tbm_satuan.nama AS satuan,
					tbt_mutasi_barang_detail.jns_keluar
				FROM
					tbt_mutasi_barang_detail
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_mutasi_barang_detail.id_barang
				INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_mutasi_barang_detail.id_satuan
				WHERE
					tbt_mutasi_barang_detail.id_transaksi = '$id'
				AND tbt_mutasi_barang_detail.deleted = '0'";
		$arr = $this->queryAction($sql,'S');
		foreach($arr as $row)
		{
			if($row['jns_keluar'] == '3')
				$jnsKeluar = "Pemakaian Produksi";
			elseif($row['jns_keluar'] == '4')
				$jnsKeluar = "Barang Rusak";
			elseif($row['jns_keluar'] == '5')
				$jnsKeluar = "Barang Expired";
				
			$pdf->RowNoBorder(array($row['nama'],$row['jml'],$row['satuan'],$jnsKeluar));	
		}
		
		$pdf->SetWidths(array(195));
		
		
		$pdf->RowNoBorder(array('...........................................................................................................'));*/
		
		$pdf->SetFont('Courier','',9);		
		$pdf->Cell(30,5,'Dicetak oleh : '.$this->User->IsUser.', '.$this->ConvertDate(date("Y-m-d"),'3').', '.date("G:i:s"),0,0,'L');
		
		$pdf->SetFont('Courier','',9);	
		$pdf->Ln(7);			
		$pdf->Cell(40,5,'Penerima',0,0,'C');
		$pdf->Cell(90,5,'',0,0,'L');	
		$pdf->Cell(40,5,'YG Mengesahkan',0,0,'C');
		
		$pdf->Ln(13);
		$pdf->SetFont('Courier','B',7);		
		$pdf->Cell(40,5,'(....................)',0,0,'C','',$url);		
		$pdf->Cell(90,5,'',0,0,'L');
		$pdf->Cell(40,5,'(....................)',0,0,'C','',$url);	
			
		$pdf->Output();
	}
	
}
?>
