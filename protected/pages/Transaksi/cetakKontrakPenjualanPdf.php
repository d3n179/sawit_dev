<?php
Prado::using('Application.modules.tcpdf.tcpdf');
Prado::using('Application.modules.tcpdf.htmlcolors');

class cetakKontrakPenjualanPdf extends MainConf
{
	public function onPreInit ($param)
	{
		parent::onPreInit($param);
		$this->setMasterClass('Application.layouts.PdfLayout');
	}
	
	public function onInit($param)
	 {		
		parent::onInit($param);
		//$this->prosesPageAllow();
	 }
	 
	public function onLoad($param)
	{	
		$idKontrak=$this->Request['idKontrak'];	
		$profilPerusahaan = $this->profilPerusahaan();		
		$record = ContractSalesRecord::finder()->findByPk($idKontrak);
		$jmlCommodity = number_format($record->quantity,0,',','.');
		$hrgCommodity = number_format($record->pricing,0,',','.');
		$totalHarga = $record->quantity * $record->pricing;
		$totalHarga = number_format($totalHarga,0,',','.');
		//$pelangganRecord = PelangganRecord::finder()->findByPk($record->id_pembeli);
		
		if($record->commodity_type == '0')
		{
			$contractName = 'CRUDE PALM OIL CONTRACT';
			$commodityName = 'CRUDE PALM OIL (CPO)';
		}
		elseif($record->commodity_type == '1')
		{
			$contractName = 'PALM KERNEL CONTRACT';
			$commodityName = 'PALM KERNEL (PK)';
		}
		elseif($record->commodity_type == '2')
		{
			$contractName = 'FIBRE CONTRACT';
			$commodityName = 'FIBRE';
		}
		elseif($record->commodity_type == '3')
		{
			$contractName = 'CANGKANG CONTRACT';
			$commodityName = 'CANGKANG';
		}
		
		$satuanNama = SatuanRecord::finder()->findByPk($record->satuan_commodity)->singkatan;	
		$pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, 'A4', true, 'UTF-8', false);

// set document information
//$pdf->SetCreator(PDF_CREATOR);
//$pdf->SetAuthor('Nicola Asuni');
//$pdf->SetTitle('TCPDF Example 006');
//$pdf->SetSubject('TCPDF Tutorial');
//$pdf->SetKeywords('TCPDF, PDF, example, test, guide');

// set default header data
//$pdf->SetHeaderData(PDF_HEADER_LOGO, PDF_HEADER_LOGO_WIDTH, PDF_HEADER_TITLE.' 006', PDF_HEADER_STRING);

// set header and footer fonts
//$pdf->setHeaderFont(Array(PDF_FONT_NAME_MAIN, '', PDF_FONT_SIZE_MAIN));
//$pdf->setFooterFont(Array(PDF_FONT_NAME_DATA, '', PDF_FONT_SIZE_DATA));

// set default monospaced font
$pdf->SetDefaultMonospacedFont(PDF_FONT_MONOSPACED);

//set margins
//$pdf->SetMargins(PDF_MARGIN_LEFT, PDF_MARGIN_TOP, PDF_MARGIN_RIGHT);
$pdf->SetMargins(PDF_MARGIN_LEFT, 10, PDF_MARGIN_RIGHT);

$pdf->SetHeaderMargin(PDF_MARGIN_HEADER);
$pdf->SetFooterMargin(PDF_MARGIN_FOOTER);

//set auto page breaks
$pdf->SetAutoPageBreak(TRUE, PDF_MARGIN_BOTTOM);

//set image scale factor
$pdf->setImageScale(PDF_IMAGE_SCALE_RATIO);

//set some language-dependent strings
$pdf->setLanguageArray($l);

// ---------------------------------------------------------

// set font
//$pdf->SetFont('helvetica', '', 10);

$pdf->setPrintHeader(false);
$pdf->setPrintFooter(false); 
				
// add a page
$pdf->AddPage();

// writeHTML($html, $ln=true, $fill=false, $reseth=false, $cell=false, $align='')
// writeHTMLCell($w, $h, $x, $y, $html='', $border=0, $ln=0, $fill=0, $reseth=true, $align='', $autopadding=true)

$urlImg = $this->Page->Theme->BaseUrl.'/assets/images/logo-01.png';
$url = $this->Service->constructUrl('Transaksi.PurchaseOrder');
//$pdf->ImageEps('/home/sonny/web-server/www/simak_garuda/protected/modules/tcpdf/images/logo-gsm.eps', 15, 70, 180);

// create some HTML content
$style = '
<style>
	html,body{
      margin:0;
      padding:0;
      height:100%;
      border:none
   }
	 
	a{
		color:#000;
		text-decoration:none;
	}
		
	.title{
			font-size:14pt;
			font-weight:bold;
		}
	
	.subtitle{font-size:11pt;}
	
	.txt9{
		font-size:11pt;
	}
	
	.txt8{
		font-size:9pt;
	}
	
	.txt8a{
		font-size:15pt;
	}
	
	.txt7{
		font-size:8pt;
	}
	
	.txt7a{
		font-size:9pt;
	}
	
	.txt6{
		font-size:7pt;
	}
	
	tr.noborder td{
		border:none;
	}
	
	tr.border td{
		border:solid #000 1px;
	}
	
	tr.borderLR td{
		border-left:solid #000 1px;
		border-right:solid #000 1px;
	}
	
	tr.borderLRB td{
		border-left:solid #000 1px;
		border-right:solid #000 1px;
		border-bottom:solid #000 1px;
	}
	
	tr.borderT td{
		border-top:solid #000 1px;
	}
	
	.border{
		border-left:solid #000 1px;
		border-right:solid #000 1px;
		border-bottom:solid #000 1px;
		border-top:solid #000 1px;
	}
	
	table, tr, td{
		padding:5px;	
	}
	
	table.nopadding{
		padding:0px;	
	}
	
</style>';

$header = '
<table width="100%" cellpadding="0">
  <tr>
    <td width="25%" rowspan="3"><img height="100px" style="position:absolute;" src="'.$urlImg.'"/></td>
	<td align="center" style="font-size:50px"><b>'.strtoupper($profilPerusahaan->nama).'</b></td>
  </tr>
  <tr>
    <td align="center" style="font-size:50px"><b>KANTOR DIREKSI</b></td>
  </tr>
  <tr>
    <td align="center" style="font-size:40px"><b>'.$profilPerusahaan->alamat.'</b></td>
  </tr>
</table>
<hr>';


$html = $style.$header;
// output the HTML content
$pdf->writeHTML($html, true, false, true, false, '');
$pdf->Ln(5);

$html = '</br></br><table width="100%" cellpadding="2">
		  <tr>
			<td align="center" style="font-size:35px"><b>'.$contractName.'</b></td>
		  </tr>
		   <tr>
			<td align="center" style="font-size:35px"><b>'.$record->sales_no.'</b></td>
		  </tr>
		</table>';
$pdf->writeHTML($html, true, false, true, false, '');
$pdf->Ln(1);

$html = '<table width="100%" cellpadding="0">
		  <tr>
			<td align="left" style="font-size:30px">Kepada : '.$record->id_pembeli.'</td>
			<td align="right" style="font-size:30px">Tanggal : '.$this->ConvertDate($record->tgl_kontrak,'3').'</td>
		  </tr>
		</table><br />
		<table width="100%" cellpadding="0">
		  <tr>
			<td align="left" style="font-size:30px">Kami sampaikan ketentuan Perjanjian Kontrak Penjualan '.$commodityName.' sebesar '.$jmlCommodity.' '.$satuanNama.', Sebagai berikut :</td>
		  </tr>
		</table><br />
		<table width="100%" cellpadding="0">
		  <tr>
			<td width="20%" align="left" style="font-size:30px; text-decoration: underline;">PENJUAL</td>
			<td width="1%" align="center" style="font-size:30px">:</td>
			<td align="left" width="84%" style="font-size:30px; text-decoration: underline;">'.strtoupper($profilPerusahaan->nama).'</td>
		  </tr>
		   <tr>
			<td width="20%" align="left" style="font-size:30px"></td>
			<td width="1%" align="center" style="font-size:30px"></td>
			<td align="left" width="84%" style="font-size:30px">Desa Pasir Jae Kec. Sosa Kab. Padang Lawas Sumatra Utara</td>
		  </tr>
		</table><br />
		<table width="100%" cellpadding="0">
		  <tr>
			<td width="20%" align="left" style="font-size:30px; text-decoration: underline;">PEMBELI</td>
			<td width="1%" align="center" style="font-size:30px">:</td>
			<td align="left" width="84%" style="font-size:30px; text-decoration: underline;">'.strtoupper($record->id_pembeli).'</td>
		  </tr>
		   <tr>
			<td width="20%" align="left" style="font-size:30px"></td>
			<td width="1%" align="center" style="font-size:30px"></td>
			<td align="left" width="84%" style="font-size:30px">'.$record->alamat_pembeli.'</td>
		  </tr>
		  <tr>
			<td width="20%" align="left" style="font-size:30px"></td>
			<td width="1%" align="center" style="font-size:30px"></td>
			<td align="left" width="84%" style="font-size:30px">NPWP : '.$record->npwp.'</td>
		  </tr>
		</table><br />
		<table width="100%" cellpadding="0">
		  <tr>
			<td width="20%" align="left" style="font-size:30px; text-decoration: underline;">COMMODITY</td>
			<td width="1%" align="center" style="font-size:30px">:</td>
			<td align="left" width="84%" style="font-size:30px; text-decoration: underline;">'.$commodityName.'</td>
		  </tr>
		</table><br />
		<table width="100%" cellpadding="0">
		  <tr>
			<td width="20%" align="left" style="font-size:30px; text-decoration: underline;">QUANTITY</td>
			<td width="1%" align="center" style="font-size:30px">:</td>
			<td align="left" width="84%" style="font-size:30px; text-decoration: underline;">'.$jmlCommodity.' '.$satuanNama.'</td>
		  </tr>
		</table><br />
		<table width="100%" cellpadding="0">
		  <tr>
			<td width="20%" align="left" style="font-size:30px; text-decoration: underline;">QUALITY</td>
			<td width="1%" align="center" style="font-size:30px">:</td>
			<td align="left" width="84%" style="font-size:30px; text-decoration: underline;">'.$record->quality.'</td>
		  </tr>
		</table><br />
		<table width="100%" cellpadding="0">
		  <tr>
			<td width="20%" align="left" style="font-size:30px; text-decoration: underline;">PRICING</td>
			<td width="1%" align="center" style="font-size:30px">:</td>
			<td align="left" width="84%" style="font-size:30px; text-decoration: underline;">Rp. '.$hrgCommodity.' /'.$satuanNama.' Exclude PPN</td>
		  </tr>
		  <tr>
			<td width="20%" align="left" style="font-size:30px;"></td>
			<td width="1%" align="center" style="font-size:30px"></td>
			<td align="left" width="84%" style="font-size:30px;">
					Franco to Factory '.$record->id_pembeli.'<br /> 
					Barang Berasal dari  PMKS '.$profilPerusahaan->nama.'<br />
					Desa Pasir Jae Kec. Sosa Kab. Padang Lawas Sumatra Utara, 22765 <br />
					<table width="100%" cellpadding="0">
					<tr>
						<td width="15%">'.$jmlCommodity.' '.$satuanNama.'</td>
						<td width="5%">X</td>
						<td width="10%">Rp. '.$hrgCommodity.'</td>
						<td width="5%">=</td>
						<td width="30%">Rp. '.$totalHarga.'</td>
					</tr>
					<tr>
						<td>Plus PPN 10 %</td>
						<td></td>
						<td></td>
						<td>=</td>
						<td>Rp. -</td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td><hr></td>
					</tr>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td>Rp. '.$totalHarga.'</td>
					</tr>
					</table>
			</td>
		  </tr>
		</table><br/>
		<table width="100%" cellpadding="0">
		  <tr>
			<td width="20%" align="left" style="font-size:30px; text-decoration: underline;">DELIVERY</td>
			<td width="1%" align="center" style="font-size:30px">:</td>
			<td align="left" width="84%" style="font-size:30px; text-decoration: underline;">'.$record->delivery.'</td>
		  </tr>
		</table><br />
		<table width="100%" cellpadding="0">
		  <tr>
			<td width="20%" align="left" style="font-size:30px; text-decoration: underline;">TERM OF PAYMENT</td>
			<td width="1%" align="center" style="font-size:30px">:</td>
			<td align="left" width="84%" style="font-size:30px; text-decoration: underline;">'.$record->term_of_payment.'</td>
		  </tr>
		</table><br />
		<table width="100%" cellpadding="0">
		  <tr>
			<td width="100%" align="left" style="font-size:30px; text-decoration: underline;">REMARK</td>
		  </tr>
		  <tr>
			<td width="100%" align="left" style="font-size:30px;">'.$record->remark.'</td>
		  </tr>
		</table><br /><hr><br />';
$pdf->writeHTML($html, true, false, true, false, '');
$pdf->Ln(1);
$html = '<table width="100%" cellpadding="0" border="0">
		  <tr>
			<td width="35%" align="center" style="font-size:30px; text-decoration: underline;"><b>We Confirm<br/>(Buyer)</b></td>
			<td width="30%"></td>
			<td width="35%" align="center" style="font-size:30px; text-decoration: underline;"><b>Yours Faitfully<br/>(Seller)</b></td>
		  </tr>
		   <tr>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td align="left" style="font-size:30px;">Materai</td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td align="center" style="font-size:30px;"><b style="text-decoration: underline;">..................................................................</b><br/><i><strong>Please Sign and Return Original</strong></i></td>
			<td></td>
			<td align="center" style="font-size:30px;"><b style="text-decoration: underline;">H. Rajamin Hasibuan</b><br/><b>Direktur Utama</b></td>
		  </tr>
		</table>';
$pdf->writeHTML($html, true, false, true, false, '');
// reset pointer to the last page
$pdf->lastPage();

// ---------------------------------------------------------

//Close and output PDF document
//$pdf->Output($noPO.'.pdf', 'I');
	
		$po = str_replace('/','-',$PurchaseOrderRecord->no_po);
		$pdf->Output('gallery/po/'.$po.'.pdf', "F");			
				
		$pdf->Output($PurchaseOrderRecord->no_po.'.pdf', 'I');		
		
	}
	
}
?>
