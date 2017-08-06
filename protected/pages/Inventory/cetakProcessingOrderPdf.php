<?php
Prado::using('Application.modules.tcpdf.tcpdf');
Prado::using('Application.modules.tcpdf.htmlcolors');

class cetakProcessingOrderPdf extends MainConf
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
		$idProcessing=$this->Request['idProcessing'];	
		$profilPerusahaan = $this->profilPerusahaan();		
		$record = ProcessingTbsRecord::finder()->findByPk($idProcessing);
		$recordReporting = ProcessingTbsReportingRecord::finder()->find('id_processing = ? ',$idProcessing);
		
			
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

$pdf->SetHeaderMargin(5);
$pdf->SetFooterMargin(5);

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
$pdf->AddPage( 'P', 'LEGAL' );

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

$header = '';


$html = $style.$header;
// output the HTML content
$pdf->writeHTML($html, true, false, true, false, '');
$pdf->Ln(2);


if($record->bst1_cpo_isi > 0)
	$Oil_Recovered_Total_isi_BST1 = $record->bst1_cpo_isi * $record->etc_bst1_kg_cm * $this->getTempVariable($record->temp_bst1) + $record->etc_bst1_kg * $this->getTempVariable($record->temp_bst1);
else
	$Oil_Recovered_Total_isi_BST1 = 0;
	
if($Oil_Recovered_Total_isi_BST2 > 0)
	$Oil_Recovered_Total_isi_BST2 = $record->bst2_cpo_isi * $record->etc_bst2_kg_cm * $this->getTempVariable($record->temp_bst2) + $record->etc_bst2_kg * $this->getTempVariable($record->temp_bst2);
else
	$Oil_Recovered_Total_isi_BST2 = 0;
	
$Oil_In_Process_CST1_Kg = $record->cst_1 * $record->etc_cst1_kg_cm * $this->getTempVariable($record->cst_1_temp);
$Oil_In_Process_CST2_Kg = $record->cst_2 * $record->etc_cst2_kg_cm * $this->getTempVariable($record->cst_2_temp);
$Oil_In_Process_CST3_Kg = $record->cst_3 * $record->etc_cst3_kg_cm * $this->getTempVariable($record->cst_3_temp);

$Oil_In_Process_OT1_Kg = $record->ot_1 * $record->etc_ot1_kg_cm  * $this->getTempVariable($record->ot_1_temp) + $record->etc_ot1_kg * $this->getTempVariable($record->ot_1_temp);
$Oil_In_Process_OT2_Kg = $record->ot_2 * $record->etc_ot2_kg_cm  * $this->getTempVariable($record->ot_2_temp) + $record->etc_ot2_kg * $this->getTempVariable($record->ot_2_temp);

$Oil_In_Process_RCV1_Kg = $record->rcv_1 * $record->etc_rcv1_kg_cm * $this->getTempVariable($record->rcv_1_temp);
$Oil_In_Process_RCV2_Kg = $record->rcv_2 * $record->etc_rcv2_kg_cm * $this->getTempVariable($record->rcv_2_temp);
$Oil_In_Process_RCV3_Kg = $record->rcv_3 * $record->etc_rcv3_kg_cm * $this->getTempVariable($record->rcv_3_temp);

$COT_Kg = $record->cot * $record->etc_cot_kg_cm;

$NS1_Kg = ($record->nut_silo_no_1 > 0 ? $record->nut_silo_no_1 * $record->etc_ns1_kg_cm + $record->etc_ns1_kg : 0);
$NS2_Kg = ($record->nut_silo_no_2 > 0 ? $record->nut_silo_no_2 * $record->etc_ns2_kg_cm + $record->etc_ns2_kg : 0);
$NS3_Kg = ($record->nut_silo_no_3 > 0 ? $record->nut_silo_no_3 * $record->etc_ns3_kg_cm + $record->etc_ns3_kg : 0);
$NS4_Kg = ($record->nut_silo_no_4 > 0 ? $record->nut_silo_no_4 * $record->etc_ns4_kg_cm + $record->etc_ns4_kg : 0);

$KS1_Kg = ($record->kernel_silo_no_1 > 0 ? $record->kernel_silo_no_1 * $record->etc_ks1_kg_cm - 0 * 0 + $record->etc_ks1_kg : 0);
$KS2_Kg = ($record->kernel_silo_no_2 > 0 ? $record->kernel_silo_no_2 * $record->etc_ks2_kg_cm - 0 * 0 + $record->etc_ks2_kg : 0);
$KS3_Kg = ($record->kernel_silo_no_3 > 0 ? $record->kernel_silo_no_3 * $record->etc_ks3_kg_cm - 0 * 0 + $record->etc_ks3_kg : 0);

$BSK1_Kg = ($record->bsk_no_1 > 0 ? $record->bsk_no_1 * $record->etc_bsk1_kg_cm + $record->etc_bsk1_kg : 0);
$BSK2_Kg = ($record->bsk_no_2 > 0 ? $record->bsk_no_2 * $record->etc_bsk2_kg_cm + $record->etc_bsk2_kg : 0);
$BSK3_Kg = ($record->bsk_no_3 > 0 ? $record->bsk_no_3 * $record->etc_bsk3_kg_cm + $record->etc_bsk3_kg : 0);

$BSS1_Kg = ($record->bss_no_1 > 0 ? $record->bss_no_1 * $record->etc_bss1_kg_cm + $record->etc_bss1_kg : 0);
$BSS2_Kg = ($record->bss_no_2 > 0 ? $record->bss_no_2 * $record->etc_bss2_kg_cm + $record->etc_bss2_kg : 0);
$BSS3_Kg = ($record->bss_no_3 > 0 ? $record->bss_no_3 * $record->etc_bss3_kg_cm + $record->etc_bss3_kg : 0);

$cpo_bst1 = $Oil_Recovered_Total_isi_BST1 -  $record->etc_cot_kg;
$cpo_cut_bst1 = $record->etc_cot_kg;
$cpo_bst2 = $Oil_Recovered_Total_isi_BST2;
$cpo_cut_bst2 = $record->etc_bst1_kg;
$cpo_in_process = $Oil_In_Process_CST1_Kg + $Oil_In_Process_CST2_Kg + $Oil_In_Process_CST2_Kg + $Oil_In_Process_OT1_Kg + $Oil_In_Process_OT2_Kg + $Oil_In_Process_RCV1_Kg + $Oil_In_Process_RCV2_Kg + $Oil_In_Process_RCV3_Kg;
$cpo_total = $cpo_bst1 + $cpo_cut_bst1 + $cpo_bst2 + $cpo_cut_bst2 + $cpo_in_process;

$pk_bsk = $BSK1_Kg + $BSK2_Kg + $BSK3_Kg + $record->bsk_lantai;
$pk_ks = $KS1_Kg + $KS2_Kg + $KS3_Kg + $record->kernel_silo_lantai;

$nut_silo = $NS1_Kg + $NS2_Kg + $NS3_Kg + $NS4_Kg + $record->nut_silo_lantai;

$shell_bss = $BSS1_Kg + $BSS2_Kg + $BSS3_Kg + $record->bss_lantai;

$Persediaan_Today = round($record->tbs_awal + $record->tbs_kebun + $record->tbs_luar +  $record->tbs_potongan);

$Cap_Rebusan = ($record->tbs_proses_shift_1 == 0 && $record->tbs_proses_shift_2 == 0 ? 0 : floor($Persediaan_Today / ($record->tbs_proses_shift_1 + $record->tbs_proses_shift_2 + $record->tbs_rbs_mentah + $record->tbs_rbs_masak + $record->tbs_restan_ramp + $record->tbs_restan_lantai)));

$Olah_Brutto_today = round(($record->tbs_proses_shift_1 + $record->tbs_proses_shift_2) * $Cap_Rebusan);

$Olah_Netto_today  = ($Olah_Brutto_today == 0 ? 0 : round($Olah_Brutto_today - $record->tbs_potongan));
	
$Olah_Akhir = ($Olah_Brutto_today == 0 ? round($Persediaan_Today - $record->tbs_potongan) : round($Persediaan_Today - $Olah_Brutto_today));

$Jam_Olah_Tbs_Today = $this->AddPlayTime(array($record->jam_olah_tbs_1,$record->jam_olah_tbs_2));
$Jam_Olah_Tbs_Today = $Jam_Olah_Tbs_Today.":00";
$Jam_Olah_Nut_Today = $this->AddPlayTime(array($record->jam_olah_nut_1,$record->jam_olah_nut_2));
$Jam_Olah_Nut_Today = $Jam_Olah_Nut_Today.":00";
$Jam_Main_Today = $this->AddPlayTime(array($record->jam_main_1,$record->jam_main_2));
$Jam_Main_Today = $Jam_Main_Today.":00";
$Jam_Down_Today = $this->AddPlayTime(array($record->jam_down_1,$record->jam_down_2));
$Jam_Down_Today = $Jam_Down_Today.":00";

$Cap_Olah_Tbs_Today = round($Olah_Brutto_today / $this->decimalHours($Jam_Olah_Tbs_Today));	

$rbs_mentah_kg = $record->tbs_rbs_mentah * $Cap_Rebusan;
$rbs_masak_kg = $record->tbs_rbs_masak * $Cap_Rebusan;
$rbs_ramp_kg = $record->tbs_restan_ramp * $Cap_Rebusan;
$rbs_lantai_kg = $record->tbs_restan_lantai * $Cap_Rebusan;

$CPO_Today = ceil($cpo_in_process + $record->pengiriman_cpo + $record->pengiriman_cpo_pagi_ini + $Oil_Recovered_Total_isi_BST1 + $Oil_Recovered_Total_isi_BST2 + 0 + $record->oil_dalam_mobil_cpo - ($record->oil_in_process + $record->pengiriman_cpo_pagi_malam ) - $record->reject_cpo - $record->oil_dalam_mobil_cpo_malam - $record->bst_kemarin);
$PK_Today = round($pk_bsk + $record->pengiriman_kernel)-($record->pk_bsk + $record->reject_kernel);
$OER_Today = round($CPO_Today / ($Olah_Netto_today * 0.01),2);
$KER_Today = round($PK_Today / ($Olah_Netto_today * 0.01),2);

$OER_SUM = round($recordReporting->cpo_sum / ($recordReporting->tbs_olah_netto_sum * 0.01),2);
$KER_SUM = round($recordReporting->pk_sum / ($recordReporting->tbs_olah_netto_sum * 0.01),2);

$html = '</br></br><table width="100%" cellpadding="2">
		  <tr>
			<td align="center" style="font-size:35px"><b>PMKS PT. SINAR HALOMOAN</b></td>
		  </tr>
		   <tr>
			<td align="center" style="font-size:35px"><b>LAPORAN HARIAN PABRIK '.$record->no_processing.'</b></td>
		  </tr>
		</table></br>
		<table width="100%" cellpadding="1" style="font-family:arial;font-size:6pt;">
		<tr>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="2%"></td>
			<td width="8%" align="center">Today</td>
			<td width="8%" align="center">MTD</td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="2%"></td>
			<td width="8%" align="center">Today</td>
			<td width="8%" align="center">MTD</td>
		  </tr>
		  <tr>
			<td>TBS</td>
			<td>Awal</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($record->tbs_awal,0,'',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>KIRIM</td>
			<td>CPO</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($record->pengiriman_cpo,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($recordReporting->kirim_cpo_sum,0,'',',').'</td>
		  </tr>
		  <tr>
			<td>TERIMA</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>PK</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($record->pengiriman_kernel,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($recordReporting->kirim_pk_sum,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>Kebun</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($record->tbs_kebun,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($recordReporting->tbs_kebun_sum,0,'',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>Cangkang</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($record->pengiriman_cangkang,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($recordReporting->kirim_cangkang_sum,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>Luar</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($record->tbs_luar,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($recordReporting->tbs_luar_sum,0,'',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>Fibre</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($record->pengiriman_fibre,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($recordReporting->kirim_fibre_sum,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>Potongan</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($record->tbs_potongan,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($recordReporting->tbs_potongan_sum,0,'',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>Limbah</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($record->pengiriman_limbah,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($recordReporting->kirim_limbah_sum,0,'',',').'</td>
		  </tr>
		  <tr>
			<td>PERSEDIAAN</td>
			<td></td>
			<td></td>
			<td style="border:1px solid black;">'.number_format($Persediaan_Today,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($recordReporting->tbs_persediaan_sum,0,'',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>Jangkos</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($record->pengiriman_jangkos,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($recordReporting->kirim_jangkos_sum,0,'',',').'</td>
		  </tr>
		  <tr>
			<td>OLAH</td>
			<td>Netto</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($Olah_Netto_today,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($recordReporting->tbs_olah_netto_sum,0,'',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>Kg</td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td>Brutto</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($Olah_Brutto_today,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($recordReporting->tbs_olah_brutto_sum,0,'',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		   <tr>
			<td>TBS</td>
			<td>Akhir</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($Olah_Akhir,0,'',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td align="center">Siap Kirim</td>
			<td align="center">Actual</td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>CPO</td>
			<td>BST 1</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($cpo_bst1,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($cpo_bst1,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>Cut BST 1</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($cpo_cut_bst1,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($cpo_cut_bst1,0,'',',').'</td>
		  </tr>
		   <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>BST 2</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($cpo_bst2,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($cpo_bst2,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>Cut BST 2</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($cpo_cut_bst2,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($cpo_cut_bst2,0,'',',').'</td>
		  </tr>
		  <tr>
			<td>OLAH / SHIFF</td>
			<td></td>
			<td></td>
			<td align="center">Rebusan</td>
			<td align="center">Jam</td>
			<td></td>
			<td></td>
			<td></td>
			<td>In Process</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($cpo_in_process,0,'',',').'</td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td>Shift I</td>
			<td></td>
			<td style="border:1px solid black;">'.number_format($record->tbs_proses_shift_1,0,'',',').'</td>
			<td style="border:1px solid black;">'.$record->jam_olah_tbs_1.'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>Total</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($cpo_total,0,'',',').'</td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td>Shift II</td>
			<td></td>
			<td style="border:1px solid black;">'.number_format($record->tbs_proses_shift_2,0,'',',').'</td>
			<td style="border:1px solid black;">'.$record->jam_olah_tbs_2.'</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td>CAP REBUSAN</td>
			<td></td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($Cap_Rebusan,0,'',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>PK</td>
			<td>BSK</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($pk_bsk,0,'',',').'</td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>KS (Dryer)</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($pk_ks,0,'',',').'</td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td align="center">Today</td>
			<td align="center">MTD</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td>JAM OLAH TBS</td>
			<td></td>
			<td>hr</td>
			<td style="border:1px solid black;">'.$Jam_Olah_Tbs_Today.'</td>
			<td style="border:1px solid black;">'.$recordReporting->jam_olah_tbs_sum.'</td>
			<td></td>
			<td></td>
			<td>NUT</td>
			<td>Silo</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($nut_silo,0,'',',').'</td>
			<td></td>
		  </tr>
		  <tr>
			<td>CAP OLAH TBS</td>
			<td></td>
			<td></td>
			<td style="border:1px solid black;">'.number_format($Cap_Olah_Tbs_Today,0,'',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td>JAM OLAH NUT I/II</td>
			<td></td>
			<td>hr</td>
			<td style="border:1px solid black;">'.$Jam_Olah_Nut_Today.'</td>
			<td style="border:1px solid black;">'.$recordReporting->jam_olah_nut_sum.'</td>
			<td></td>
			<td></td>
			<td>SHELL</td>
			<td>BSS</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($shell_bss,0,'',',').'</td>
			<td></td>
		  </tr>
		  <tr>
			<td>CAP OLAH NUT</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td align="center">Today</td>
			<td align="center">MTD</td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td align="center">Today</td>
			<td align="center">MTD</td>
			<td></td>
			<td></td>
			<td></td>
			<td>Reject CPO</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($record->reject_cpo,0,'',',').'</td>
			<td></td>
		  </tr>
		  <tr>
			<td>CPO</td>
			<td></td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($CPO_Today,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($recordReporting->cpo_sum,0,'',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>Reject Kernel</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($record->reject_kernel,0,'',',').'</td>
			<td></td>
		  </tr>
		  <tr>
			<td>PK</td>
			<td></td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($PK_Today,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($recordReporting->pk_sum,0,'',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td>OER</td>
			<td></td>
			<td>%</td>
			<td style="border:1px solid black;">'.$OER_Today.'</td>
			<td style="border:1px solid black;">'.$OER_SUM.'</td>
			<td></td>
			<td></td>
			<td>MUTU</td>
			<td></td>
			<td></td>
			<td align="center">CPO</td>
			<td align="center">PK</td>
		  </tr>
		  <tr>
			<td>KER</td>
			<td></td>
			<td>%</td>
			<td style="border:1px solid black;">'.$KER_Today.'</td>
			<td style="border:1px solid black;">'.$KER_SUM.'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>FFA</td>
			<td>%</td>
			<td style="border:1px solid black;">'.number_format($record->mutu_cpo_ffa,2,'.',',').'</td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>Moisture</td>
			<td>%</td>
			<td style="border:1px solid black;">'.number_format($record->mutu_cpo_moisture,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->mutu_pk_moisture,2,'.',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>Impurities</td>
			<td>%</td>
			<td style="border:1px solid black;">'.number_format($record->mutu_cpo_impurities,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->mutu_pk_impurities,2,'.',',').'</td>
		  </tr>
		</table></br>
		
		<table width="100%" cellpadding="1" style="font-family:arial;font-size:6pt;">
		 <tr>
			<td width="10%">OIL RECOVERED</td>
			<td width="10%"></td>
			<td width="2%"></td>
			<td width="8%" align="center">Today</td>
			<td width="8%" align="center">MTD</td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%">TBS RESTAN</td>
			<td width="10%"></td>
			<td width="2%"></td>
			<td width="8%" align="center">Rbsan</td>
			<td width="8%" align="center">Kg</td>
		  </tr>
		  <tr>
			<td></td>
			<td>Stock</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->pengutipan_minyak.'</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>Rbs mentah</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->tbs_rbs_mentah.'</td>
			<td style="border:1px solid black;">'.number_format($rbs_mentah_kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>Pengiriman</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->kolam_tanah.'</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>Rbs masak</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->tbs_rbs_masak.'</td>
			<td style="border:1px solid black;">'.number_format($rbs_masak_kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>Ramp</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->tbs_restan_ramp.'</td>
			<td style="border:1px solid black;">'.number_format($rbs_ramp_kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td align="center">BST 1</td>
			<td align="center">BST 2</td>
			<td></td>
			<td></td>
			<td></td>
			<td>Lantai</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->tbs_restan_lantai.'</td>
			<td style="border:1px solid black;">'.number_format($rbs_lantai_kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>Isi</td>
			<td>cm</td>
			<td style="border:1px solid black;">'.number_format($record->bst1_cpo_isi,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->bst2_cpo_isi,2,'.',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td>Temp.</td>
			<td>°C</td>
			<td style="border:1px solid black;">'.number_format($record->temp_bst1,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->temp_bst2,2,'.',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>NS 1</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->nut_silo_no_1.'</td>
			<td style="border:1px solid black;">'.number_format($NS1_Kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>Total Isi</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($Oil_Recovered_Total_isi_BST1,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($Oil_Recovered_Total_isi_BST2,0,'',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>NS 2</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->nut_silo_no_2.'</td>
			<td style="border:1px solid black;">'.number_format($NS2_Kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>FFA</td>
			<td>%</td>
			<td style="border:1px solid black;">'.number_format($record->bst1_cpo_ffa,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->bst2_cpo_ffa,2,'.',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>NS 3</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->nut_silo_no_3.'</td>
			<td style="border:1px solid black;">'.number_format($NS3_Kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>Moist</td>
			<td>%</td>
			<td style="border:1px solid black;">'.number_format($record->bst1_cpo_moist,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->bst2_cpo_moist,2,'.',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>NS 4</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->nut_silo_no_4.'</td>
			<td style="border:1px solid black;">'.number_format($NS4_Kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>Impurities</td>
			<td>%</td>
			<td style="border:1px solid black;">'.number_format($record->bst1_cpo_impurities,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->bst2_cpo_impurities,2,'.',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>Lantai</td>
			<td></td>
			<td></td>
			<td style="border:1px solid black;">'.$record->nut_silo_lantai.'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>Drain</td>
			<td>Kg</td>
			<td style="border:1px solid black;">'.number_format($record->drain_minyak,0,'',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td>OIL IN PROCESS</td>
			<td></td>
			<td></td>
			<td align="center">Cm</td>
			<td align="center">Kg</td>
			<td align="center">FFA</td>
			<td align="center">Temp °C</td>
			<td></td>
			<td>KS 1</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->kernel_silo_no_1.'</td>
			<td style="border:1px solid black;">'.number_format($KS1_Kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>CST 1</td>
			<td></td>
			<td style="border:1px solid black;">'.number_format($record->cst_1,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($Oil_In_Process_CST1_Kg,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->ffa_cst_1,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->cst_1_temp,2,'.',',').'</td>
			<td></td>
			<td>KS 2</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->kernel_silo_no_2.'</td>
			<td style="border:1px solid black;">'.number_format($KS2_Kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>CST 2</td>
			<td></td>
			<td style="border:1px solid black;">'.number_format($record->cst_2,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($Oil_In_Process_CST2_Kg,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->ffa_cst_2,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->cst_2_temp,2,'.',',').'</td>
			<td></td>
			<td>KS 3</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->kernel_silo_no_3.'</td>
			<td style="border:1px solid black;">'.number_format($KS3_Kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>CST 3</td>
			<td></td>
			<td style="border:1px solid black;">'.number_format($record->cst_3,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($Oil_In_Process_CST3_Kg,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->ffa_cst_3,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->cst_3_temp,2,'.',',').'</td>
			<td></td>
			<td>Lantai</td>
			<td></td>
			<td></td>
			<td style="border:1px solid black;">'.$record->kernel_silo_lantai.'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>OT 1</td>
			<td></td>
			<td style="border:1px solid black;">'.number_format($record->ot_1,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($Oil_In_Process_OT1_Kg,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->ffa_ot_1,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->ot_1_temp,2,'.',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td>OT 2</td>
			<td></td>
			<td style="border:1px solid black;">'.number_format($record->ot_2,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($Oil_In_Process_OT2_Kg,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->ffa_ot_2,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->ot_2_temp,2,'.',',').'</td>
			<td></td>
			<td>BSK 1</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->bsk_no_1.'</td>
			<td style="border:1px solid black;">'.number_format($BSK1_Kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>RCV 1</td>
			<td></td>
			<td style="border:1px solid black;">'.number_format($record->rcv_1,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($Oil_In_Process_RCV1_Kg,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->ffa_rcv_1,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->rcv_1_temp,2,'.',',').'</td>
			<td></td>
			<td>BSK 2</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->bsk_no_2.'</td>
			<td style="border:1px solid black;">'.number_format($BSK2_Kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>RCV 2</td>
			<td></td>
			<td style="border:1px solid black;">'.number_format($record->rcv_2,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($Oil_In_Process_RCV2_Kg,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->ffa_rcv_2,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->rcv_2_temp,2,'.',',').'</td>
			<td></td>
			<td>BSK 3</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->bsk_no_3.'</td>
			<td style="border:1px solid black;">'.number_format($BSK3_Kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>RCV 3</td>
			<td></td>
			<td style="border:1px solid black;">'.number_format($record->rcv_3,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($Oil_In_Process_RCV3_Kg,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->ffa_rcv_3,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->rcv_3_temp,2,'.',',').'</td>
			<td></td>
			<td>Lantai</td>
			<td></td>
			<td></td>
			<td style="border:1px solid black;">'.$record->bsk_lantai.'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>COT</td>
			<td></td>
			<td style="border:1px solid black;">'.number_format($record->cot,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($COT_Kg,0,'',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->ffa_cot,2,'.',',').'</td>
			<td style="border:1px solid black;">'.number_format($record->cot_temp,2,'.',',').'</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td align="center">Total</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>BSS 1</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->bss_no_1.'</td>
			<td style="border:1px solid black;">'.number_format($BSS1_Kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>BSS 2</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->bss_no_2.'</td>
			<td style="border:1px solid black;">'.number_format($BSS2_Kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>BSS 3</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->bss_no_3.'</td>
			<td style="border:1px solid black;">'.number_format($BSS3_Kg,0,'',',').'</td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>Lantai</td>
			<td></td>
			<td></td>
			<td style="border:1px solid black;">'.$record->bss_lantai.'</td>
		  </tr>
		  <tr>
			<td>FIBRE</td>
			<td></td>
			<td></td>
			<td align="center">Today</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td align="center">Kg</td>
			<td align="center">Kg</td>
			<td></td>
			<td></td>
			<td></td>
			<td align="center">MTD</td>
			<td></td>
			<td align="center">Goni</td>
			<td align="center">Kg</td>
		  </tr>
		  <tr>
			<td></td>
			<td>Produksi</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->produksi_abu_janjang_goni.'</td>
			<td style="border:1px solid black;">'.$record->produksi_abu_janjang_kg.'</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td style="border:1px solid black;">'.$record->produksi_abu_janjang_goni.'</td>
			<td style="border:1px solid black;">'.$record->produksi_abu_janjang_kg.'</td>
		  </tr>
		  <tr>
			<td></td>
			<td>Kirim</td>
			<td></td>
			<td style="border:1px solid black;">'.$record->pengiriman_fibre.'</td>
			<td style="border:1px solid black;">'.$record->pengiriman_fibre.'</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>0</td>
			<td style="border:1px solid black;">'.$record->pengiriman_fibre.'</td>
		  </tr>
		 </table>
		 <table width="100%" cellpadding="1" style="font-family:arial;font-size:6pt;">
		 <tr>
			<td width="10%">Catatan</td>
			<td width="10%"></td>
			<td width="2%"></td>
			<td width="8%"></td>
			<td width="8%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="10%"></td>
			<td width="2%"></td>
			<td align="center" width="8%">Disounding</td>
			<td align="center" width="8%">Diverifikasi</td>
		  </tr>
		  <tr>
			<td></td>
			<td align="center">Shift</td>
			<td></td>
			<td align="center">I</td>
			<td align="center">II</td>
			<td align="center">Today</td>
			<td align="center">MTD</td>
			<td></td>
			<td></td>
			<td></td>
			<td rowspan="8"></td>
			<td rowspan="8"></td>
		  </tr>
		   <tr>
			<td>Jam Olah TBS</td>
			<td></td>
			<td></td>
			<td style="border:1px solid black;">'.$record->jam_olah_tbs_1.'</td>
			<td style="border:1px solid black;">'.$record->jam_olah_tbs_2.'</td>
			<td style="border:1px solid black;">'.$Jam_Olah_Tbs_Today.'</td>
			<td style="border:1px solid black;">'.$recordReporting->jam_olah_tbs_sum.'</td>
			<td></td>
			<td>Jam</td>
			<td></td>
		  </tr>
		  <tr>
			<td>Jam Olah Nut</td>
			<td></td>
			<td></td>
			<td style="border:1px solid black;">'.$record->jam_olah_nut_1.'</td>
			<td style="border:1px solid black;">'.$record->jam_olah_nut_2.'</td>
			<td style="border:1px solid black;">'.$Jam_Olah_Nut_Today.'</td>
			<td style="border:1px solid black;">'.$recordReporting->jam_olah_nut_sum.'</td>
			<td></td>
			<td>Jam</td>
			<td></td>
		  </tr>
		  <tr>
			<td>Jam Start Shift</td>
			<td></td>
			<td></td>
			<td style="border:1px solid black;">'.$record->jam_start_1.'</td>
			<td style="border:1px solid black;">'.$record->jam_start_2.'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>Jam</td>
			<td></td>
		  </tr>
		  <tr>
			<td>Jam Stop Shift</td>
			<td></td>
			<td></td>
			<td style="border:1px solid black;">'.$record->jam_stop_1.'</td>
			<td style="border:1px solid black;">'.$record->jam_stop_2.'</td>
			<td></td>
			<td></td>
			<td></td>
			<td>Jam</td>
			<td></td>
		  </tr>
		  <tr>
			<td>Maint/Cleaning/Fire Up</td>
			<td></td>
			<td></td>
			<td style="border:1px solid black;">'.$record->jam_main_1.'</td>
			<td style="border:1px solid black;">'.$record->jam_main_2.'</td>
			<td style="border:1px solid black;">'.$Jam_Main_Today.'</td>
			<td style="border:1px solid black;">'.$recordReporting->jam_main_sum.'</td>
			<td></td>
			<td>Jam</td>
			<td></td>
		  </tr>
		  <tr>
			<td>Down Time/Stagnasi</td>
			<td></td>
			<td></td>
			<td style="border:1px solid black;">'.$record->jam_down_1.'</td>
			<td style="border:1px solid black;">'.$record->jam_down_2.'</td>
			<td style="border:1px solid black;">'.$Jam_Down_Today.'</td>
			<td style="border:1px solid black;">'.$recordReporting->jam_down_sum.'</td>
			<td></td>
			<td>Jam</td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td align="center">Rahmat Ritonga</td>
			<td align="center">Iga Harry Rebawa</td>
		  </tr>
		  <tr>
			<td>Catatan :</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td align="center">Kepala Lab</td>
			<td align="center">Asst. Proses Shift I</td>
		  </tr>
		  <tr>
			<td rowspan="9" colspan="9"></td>
			<td></td>
			<td align="center">Diverifkasi</td>
			<td align="center">Diketahui</td>
		  </tr>
		  <tr>
			<td></td>
			<td rowspan="8"></td>
			<td rowspan="8"></td>
		  </tr>
		  <tr>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
		  </tr>
		  <tr>
			<td></td>
		  </tr>
		   <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td align="center">Hamdan Wijaya</td>
			<td align="center">Gusna Diandi Hsb</td>
		  </tr>
		  <tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td align="center">Asst. Proses Shift II</td>
			<td align="center">Mill Manager</td>
		  </tr>
		 </table>';
$pdf->writeHTML($html, true, false, true, false, '');

// reset pointer to the last page
$pdf->lastPage();

// ---------------------------------------------------------

//Close and output PDF document
//$pdf->Output($noPO.'.pdf', 'I');
	
		$po = str_replace('/','-',$record->no_processing);
		$pdf->Output('gallery/po/'.$po.'.pdf', "F");			
				
		$pdf->Output($record->no_processing.'.pdf', 'I');		
		
	}
	
}
?>
