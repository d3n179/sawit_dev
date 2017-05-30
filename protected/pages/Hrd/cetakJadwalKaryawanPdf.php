<?php
Prado::using('Application.modules.tcpdf.tcpdf');
Prado::using('Application.modules.tcpdf.htmlcolors');

class cetakJadwalKaryawanPdf extends MainConf
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
		$pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, 'F4A', true, 'UTF-8', false);

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
$pdf->AddPage( 'L', 'LEGAL' );

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
$profilPerusahaan = $this->profilPerusahaan();		
$bulan = $this->Request['bulan'];
$tahun = $this->Request['tahun'];
$header = '
<table width="100%" cellpadding="0">
  <tr>
    <td width="25%" rowspan="3"><img  style="position:absolute;" src="'.$urlImg.'" height="75"/></td>
	<td align="center" style="font-size:50px"><b>'.strtoupper($profilPerusahaan->nama).'</b></td>
  </tr>
  <tr>
    <td align="center" style="font-size:40px"><b>'.$profilPerusahaan->alamat.'</b></td>
  </tr>
</table><br><br>
<hr>';


$html = $style.$header;
// output the HTML content
$pdf->writeHTML($html, true, false, true, false, '');
$pdf->Ln(2);

$html = '
<table width="100%" cellpadding="0" border="1">';

$days = cal_days_in_month(CAL_GREGORIAN, $bulan, $tahun);
			
$sqlKaryawan = "SELECT id,nama FROM tbm_karyawan WHERE deleted = '0' ";
$arr = $this->queryAction($sqlKaryawan,'S');
foreach($arr as $row)
{
	$html .= '<tr>';
	$html .= '<td colspan="'.$days.'">'.$row['nama'].'</td>';
	$html .= '</tr>';
	
	$i = 1;
	$html .= '<tr>';
	while($i <= $days)
	{
		$html .= '<th>'.$i.'</th>';
		$i++;
	}
	$html .= '</tr>';
}
			
$html .= '</table>';
$pdf->writeHTML($html, true, false, true, false, '');
// reset pointer to the last page
$pdf->lastPage();

// ---------------------------------------------------------

//Close and output PDF document
//$pdf->Output($noPO.'.pdf', 'I');
	
		//$po = str_replace('/','-',$record->no_processing);
		//$pdf->Output('gallery/po/'.$po.'.pdf', "F");			
				
		$pdf->Output();		
		
	}
	
}
?>
