<?php
class cetakKwtPemakaianBarang extends MainConf
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
		$MutasiBarangRecord = MutasiBarangRecord::finder()->findByPk($id);
						
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
		$pdf->SetFont('Courier','B',8.5);
		$pdf->SetAligns(array('C'));
		$pdf->RowNoBorder(array('RINCIAN'));
		
		$pdf->SetFont('Courier','',8.5);
		
		$pdf->SetWidths(array(30,5,80));
		$pdf->SetAligns(array('L','C','L'));
		$pdf->RowNoBorder(array('Tgl. Pemakaian',':',$this->ConvertDate($MutasiBarangRecord->tgl_transaksi,'3')));
		$pdf->SetLn(4);	
		$pdf->SetWidths(array(195));
		$pdf->RowNoBorder(array('...........................................................................................................'));
		$pdf->SetFont('Courier','',8.5);
				
		$pdf->SetWidths(array(55,40,50,40));
		$pdf->SetAligns(array('C','C','C','C'));
		$pdf->RowNoBorder(array('NAMA BARANG','JUMLAH','SATUAN','JENIS PENGELUARAN'));
		$pdf->SetWidths(array(195));
		$pdf->SetAligns(array('L'));
		$pdf->RowNoBorder(array('...........................................................................................................'));
		$pdf->SetWidths(array(55,40,50,40));
		$pdf->SetAligns(array('L','R','C','L'));
		$sql = "SELECT
					tbt_mutasi_barang_detail.id_barang,
					tbt_mutasi_barang_detail.jml,
					tbt_mutasi_barang_detail.id_satuan,
					tbt_mutasi_barang_detail.jns_keluar,
					tbt_mutasi_barang_detail.st_asset
				FROM
					tbt_mutasi_barang_detail
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
			
			if($row['st_asset'] == '0')
				$nmBarang = BarangRecord::finder()->findByPk($row['id_barang'])->nama;	
			else
				$nmBarang = AktivaTetapRecord::finder()->findByPk($row['id_barang'])->nama;	
				
			$nmSatuan = SatuanRecord::finder()->findByPk($row['id_satuan'])->nama;	
			$pdf->RowNoBorder(array($nmBarang,$row['jml'],$nmSatuan,$jnsKeluar));	
		}
		
		$pdf->SetWidths(array(195));
		
		
		$pdf->RowNoBorder(array('...........................................................................................................'));
		
		$pdf->SetFont('Courier','',9);		
		$pdf->Cell(30,5,'Dicetak oleh : '.$this->User->IsUser.', '.$this->ConvertDate(date("Y-m-d"),'3').', '.date("G:i:s"),0,0,'L');
		
		$pdf->SetFont('Courier','',9);	
		$pdf->Ln(7);			
		$pdf->Cell(40,5,'Bag. Gudang',0,0,'C');
		$pdf->Cell(30,5,'',0,0,'L');
		$pdf->Cell(40,5,'Penerima',0,0,'C');
		$pdf->Cell(30,5,'',0,0,'L');	
		$pdf->Cell(40,5,'YG Mengesahkan',0,0,'C');
		
		$pdf->Ln(13);
		$pdf->SetFont('Courier','B',7);		
		$pdf->Cell(40,5,'(....................)',0,0,'C','',$url);	
		$pdf->Cell(30,5,'',0,0,'L');
		$pdf->Cell(40,5,'(....................)',0,0,'C','',$url);	
		$pdf->Cell(30,5,'',0,0,'L');
		$pdf->Cell(40,5,'(....................)',0,0,'C','',$url);	
			
		$pdf->Output();
	}
	
}
?>
