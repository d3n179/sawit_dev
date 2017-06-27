<?php
Prado::using('Application.modules.tcpdf.tcpdf');
Prado::using('Application.modules.tcpdf.htmlcolors');

class cetakSuratKuasaAngkutPdf extends MainConf
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
		$id=$this->Request['id'];	
		$profilPerusahaan = $this->profilPerusahaan();		
		$record = ContractSalesRecord::finder()->findByPk($id);
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
		
		$satuanNama = "Kg";	
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
    <td width="25%" rowspan="3"><img  style="position:absolute;" src="'.$urlImg.'"/></td>
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

$html = '</br><table width="100%" cellpadding="2">
		  <tr>
			<td align="center" style="font-size:35px;text-decoration: underline;"><b>SURAT KUASA PENGANGKUTAN</b></td>
		  </tr>
		</table>
		<br>
		<table width="100%" cellpadding="2" style="font-size:9pt;">
		   <tr>
			<td align="left" width="15%"><b>Nomor</b></td>
			<td align="left" width="5%">:</td>
			<td align="left" width="60%">'.$record->no_surat_kuasa.'</td>
		  </tr>
		   <tr>
			<td align="left"></td>
			<td align="left"></td>
			<td align="left"></td>
		  </tr>
		  <tr>
			<td align="left"><b>Kepada Yth.</b></td>
			<td align="left">:</td>
			<td align="left"><b>'.$record->id_pembeli.'</b></td>
		  </tr>
		  <tr>
			<td align="left"><b>Dari</b></td>
			<td align="left">:</td>
			<td align="left"><b>PT. SINAR HALOMOAN</b></td>
		  </tr>
		  <tr>
			<td align="left"><b>Tanggal</b></td>
			<td align="left">:</td>
			<td align="left"><b>'.$this->ConvertDate(date("Y-m-d"),'3').'</b></td>
		  </tr>
		  <tr>
			<td align="left"><b>Hal</b></td>
			<td align="left">:</td>
			<td align="left"><b>Pengangkutan D.O No.  '.$record->no_do.'</b></td>
		  </tr>
		</table>
		<br>
		<table width="100%" cellpadding="2" style="font-size:9pt;">
		   <tr>
			<td align="left"><b>Berdasarkan SPK No. : . '.$record->no_surat_kuasa.' harap dilaksanakan pengiriman  '.$commodityName.' sbb :</b></td>
		  </tr>
		</table>
		<table width="100%" cellpadding="10" style="font-size:9pt;">
		   <tr>
			<td align="left" width="15%">Kepada</td>
			<td align="left" width="5%">:</td>
			<td align="left" width="60%">'.$record->id_pembeli.'</td>
		  </tr>
		   <tr>
			<td align="left" width="15%"><b>Alamat</b></td>
			<td align="left" width="5%">:</td>
			<td align="left" width="60%"><b>'.$record->alamat_pembeli.'</b></td>
		  </tr>
		  <tr>
			<td align="left" width="15%">Banyaknya</td>
			<td align="left" width="5%">:</td>
			<td align="left" width="60%"><b>'.$record->quantity.' Kg</b></td>
		  </tr>
		  <tr>
			<td align="left" width="15%">Mutu</td>
			<td align="left" width="5%">:</td>
			<td align="left" width="60%">'.$record->quality.'</td>
		  </tr>
		   <tr>
			<td align="left" width="15%">Pengiriman</td>
			<td align="left" width="5%">:</td>
			<td align="left" width="60%">'.$record->delivery.' </td>
		  </tr>
		  <tr>
			<td align="left" width="15%">Pembayaran</td>
			<td align="left" width="5%">:</td>
			<td align="left" width="60%">'.$record->term_of_payment.' </td>
		  </tr>
		 </table>
		 <br>
		<table width="100%" cellpadding="2" style="font-size:9pt;">
		   <tr>
			<td align="left">Demikian disampaikan atas perhatian dan kerjasamanya kami ucapkan terima kasih.</td>
		  </tr>
		</table>
		<br>
		<table width="100%" cellpadding="2" style="font-size:9pt;">
		   <tr>
			<td align="left"><b>PT. SINAR HALOMOAN</b></td>
		  </tr>
		  <tr>
			<td align="left"></td>
		  </tr>
		  <tr>
			<td align="left"></td>
		  </tr>
		   <tr>
			<td align="left"></td>
		  </tr>
		  <tr>
			<td align="left" style="text-decoration: underline;"><b>H. RAJAMIN HASIBUAN</b></td>
		  </tr>
		   <tr>
			<td align="left"><b>DIREKTUR UTAMA</b></td>
		  </tr>
		</table>
		<br>
		<table width="100%" cellpadding="2" style="font-size:9pt;">
		   <tr>
			<td align="left" width="10%">Cc :</td>
			<td align="left">- Buyer <br>- Finance Department <br>- Mill Manager</td>
		  </tr>
		 </table>';
$pdf->writeHTML($html, true, false, true, false, '');
$pdf->Ln(1);
// reset pointer to the last page
$pdf->lastPage();

// ---------------------------------------------------------

//Close and output PDF document
//$pdf->Output($noPO.'.pdf', 'I');
		$pdf->Output();		
		
	}
	
}
?>
