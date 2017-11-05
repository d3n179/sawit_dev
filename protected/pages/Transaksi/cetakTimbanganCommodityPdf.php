<?php
class cetakTimbanganCommodityPdf extends MainConf
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
		$CommodityTransactionRecord = CommodityTransactionRecord::finder()->findByPk($id);
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
		$pdf->RowNoBorder(array('TIKET TIMBANGAN'));
		$pdf->RowNoBorder(array('NO. '.$CommodityTransactionRecord->transaction_no));
		$pdf->SetFont('Courier','',8.5);
		$pdf->SetLn(4);	
		$pdf->SetWidths(array(195));
		$pdf->RowNoBorder(array('...........................................................................................................'));
		$pdf->SetFont('Courier','',8.5);
		
		if($CommodityTransactionRecord->commodity_type == '0')
			$commodity_type = 'CPO - Crude Palm Oil';
		elseif($CommodityTransactionRecord->commodity_type == '1')
			$commodity_type = 'PK - Palm Kernel';
		elseif($CommodityTransactionRecord->commodity_type == '2')
			$commodity_type = 'FIBRE';
		elseif($CommodityTransactionRecord->commodity_type == '3')
			$commodity_type = 'CANGKANG';
					
		$pdf->SetWidths(array(35,5,50,15,35,5,50));
		$pdf->SetAligns(array('L','C','L','L','L','C','L'));
		$pdf->RowNoBorder(array('No Kendaraan',':',$CommodityTransactionRecord->no_kendaraan,"","SPESIFIKASI","",""));
		$pdf->RowNoBorder(array('Nama Barang',':',$commodity_type,"","FFA %",":",$CommodityTransactionRecord->ffa));
		$pdf->RowNoBorder(array('Customer/Supplier',':',$CommodityTransactionRecord->pembeli,"","Moist %",":",$CommodityTransactionRecord->moist));
		$pdf->RowNoBorder(array('Transporter',':',$CommodityTransactionRecord->transporter,"","Dirt %",":",$CommodityTransactionRecord->dirt));
		$pdf->RowNoBorder(array('No DO/PO',':',$CommodityTransactionRecord->no_do,"","No Segel/Locis %",":",$CommodityTransactionRecord->no_segel));
		$pdf->Ln(5);
		$pdf->SetAligns(array('L','C','R','L','L','C','L'));	
		$pdf->RowNoBorder(array('Bruto',':',number_format($CommodityTransactionRecord->bruto,2,'.',',').' KG',"",'TIMBANGAN','',"TANGGAL - JAM"));
		$pdf->RowNoBorder(array('Tarra',':',number_format($CommodityTransactionRecord->tarra,2,'.',',').' KG',"",'MASUK','',$this->ConvertDate($CommodityTransactionRecord->tgl_masuk,'1').' - '.$CommodityTransactionRecord->wkt_masuk));
		$pdf->RowNoBorder(array('Netto I',':',number_format($CommodityTransactionRecord->netto_1,2,'.',',').' KG',"",'KELUAR','',$this->ConvertDate($CommodityTransactionRecord->tgl_keluar,'1').' - '.$CommodityTransactionRecord->wkt_keluar));
		if($CommodityTransactionRecord->potongan > 0)
		{
			$potongan = $CommodityTransactionRecord->potongan / 100;
			$hsilPotongan = $potongan * $CommodityTransactionRecord->netto_1;
		}
		else
		{
			$hsilPotongan = '';
		}
		$pdf->RowNoBorder(array('Potongan',':',number_format($CommodityTransactionRecord->potongan,2,'.',',').' %',"",'Hasil Potongan',':',$hsilPotongan.' KG'));
		$pdf->RowNoBorder(array('Netto II',':',number_format($CommodityTransactionRecord->netto_2,2,'.',',').' KG',"",'','',''));
		$pdf->SetWidths(array(195));
		$pdf->SetAligns(array('L'));
		$pdf->Ln(5);
		$pdf->RowNoBorder(array('...........................................................................................................'));
		
		$pdf->SetFont('Courier','',9);	
		$pdf->Ln(5);			
		$pdf->Cell(40,5,'Penimbang',0,0,'C');
		$pdf->Cell(90,5,'',0,0,'L');	
		$pdf->Cell(40,5,'Pengemudi',0,0,'C');
		
		$pdf->Ln(13);
		$pdf->SetFont('Courier','B',7);		
		$pdf->Cell(40,5,'(....................)',0,0,'C','',$url);		
		$pdf->Cell(90,5,'',0,0,'L');
		$pdf->Cell(40,5,'(....................)',0,0,'C','',$url);	
			
		$pdf->Output();
	}
	
}
?>
