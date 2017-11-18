<?php
Prado::using('Application.modules.tcpdf.tcpdf');
Prado::using('Application.modules.tcpdf.htmlcolors');

class cetakPurchaseOrder extends MainConf
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
		$idPo=$this->Request['idPo'];	
		$PurchaseOrderRecord = PurchaseOrderRecord::finder()->findByPk($idPo);
		$supplier= $PurchaseOrderRecord->id_supplier;
		$profilPerusahaan = $this->profilPerusahaan();		
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
$pdf->AddPage();

// writeHTML($html, $ln=true, $fill=false, $reseth=false, $cell=false, $align='')
// writeHTMLCell($w, $h, $x, $y, $html='', $border=0, $ln=0, $fill=0, $reseth=true, $align='', $autopadding=true)

$urlImg = $this->Page->Theme->BaseUrl.'/assets/images/logo-01.png';
$url = $this->Service->constructUrl('Transaksi.PurchaseOrder');
//$pdf->ImageEps('/home/sonny/web-server/www/simak_garuda/protected/modules/tcpdf/images/logo-gsm.eps', 15, 70, 180);

// create some HTML content
$html = '
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
	
</style>
<table width="100%" class="txt9">
  <tr>
    <td width="25%"><img height="100px"  style="position:absolute;" src="'.$urlImg.'"/></td>
	<td align="center">
		<div><span class="title">SURAT PESANAN<br/></span>PURCHASE ORDER</div></td>
  </tr>
  <tr>
    <td width="30%" class="txt8">'.$profilPerusahaan->alamat.'<br/>Telp.: '.$profilPerusahaan->telepon.'</td>
	<td>&nbsp;</td>
  </tr>
</table>

<table width="100%" class="txt9">
  <tr class="border">
<td width="25%" rowspan="3" valign="top" class="txt8">
		<strong>Kepada</strong><br />
		TO : <br />
		'.PemasokRecord::finder()->findByPk($supplier)->nama.'<br />
		'.PemasokRecord::finder()->findByPk($supplier)->alamat.'
	</td>
    <td width="50%" valign="top" class="txt8"><strong>SURAT PESANAN NO :</strong><br />
      PURCHASE ORDER NO :
      <div align="center" class="txt8a"><strong>'.$PurchaseOrderRecord->no_po.'</strong></div></td>
    <td width="25%" valign="top" class="txt7" colspan="2"><strong>Tanggal Dikeluarkan</strong><br />
      Date of Issued<br />
      '.$PurchaseOrderRecord->tgl_po.'</td>
  </tr>
  <tr class="border">
    <td valign="top" class="txt7"><strong>Nomor Pesanan ini harus dicantumkan pada pembungkus faktur, kwitansi dan surat-menyurat</strong><br />
    this order number must be shown on all package invoices, shipping documentand correspondence</td>
    <td valign="top" class="txt7" colspan="2">
		<strong>Ref. RO no :</strong> ';
	
	$RequestOrderNo = RequestOrderRecord::finder()->findByPk($PurchaseOrderRecord->id_ro)->no_ro;
	$html .= $RequestOrderNo;		
		
	
$html .= '
	</td>
  </tr>
  <tr class="border">
    <td colspan="3" valign="top" class="txt7"><strong>Dikirim ke</strong><br />
      Ship to
      <div align="left" ><strong>'.$profilPerusahaan->alamat.'</strong></div>
      </td>
  </tr>
</table>

<table width="100%" border="0" class="txt7" > 
  <tr style="text-align:center;" class="border">
    <td width="5%"><strong>NO.</strong></td>
		<td width="30%"><strong>NAMA BARANG</strong></td>
		<td width="10%"><strong>JUMLAH</strong></td>
		<td width="10%"><strong>SATUAN</strong></td>
		<td width="12%"><strong>HARGA (Rp)</strong></td>
		<td width="12%"><strong>Discount (%)</strong></td>
		<td width="21%"><strong>SUBTOTAL (Rp)</strong></td>
	</tr>
	<tr style="text-align:center;" class="border">
    <td width="5%"><strong>1</strong></td>
		<td width="30%"><strong>2</strong></td>
		<td width="10%"><strong>3</strong></td>
		<td width="10%"><strong>4</strong></td>
		<td width="12%"><strong>5</strong></td>
		<td width="12%"><strong>6</strong></td>
		<td width="21%"><strong>7</strong></td>
	</tr>
</table>
<table width="100%" border="0" class="txt7a" > 	
  ';
  		
		$sql="SELECT
					tbt_purchase_order_detail.id,
					tbt_purchase_order_detail.id_barang,
					tbm_barang.nama,
					tbt_purchase_order_detail.id_satuan,
					tbm_satuan.nama AS satuan,
					tbt_purchase_order_detail.harga_satuan_besar,
					tbt_purchase_order_detail.harga_satuan,
					tbt_purchase_order_detail.jumlah,
					tbt_purchase_order_detail.discount,
					tbt_purchase_order_detail.subtotal
				FROM
					tbt_purchase_order_detail
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_purchase_order_detail.id_barang
				INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_purchase_order_detail.id_satuan
				WHERE
					tbt_purchase_order_detail.deleted = '0'
				AND tbt_purchase_order_detail.id_po = '$idPo'
				ORDER BY
					tbt_purchase_order_detail.id ASC ";
						
		$arrData=$this->queryAction($sql,'S');//Select row in tabel bro...				
		$j=1;
		$heightTmp = 260;
		$totalPo = 0;
		$total = 0;
		foreach($arrData as $row)
		{
					$html .=' 
						<tr style="vertical-align:top;" class="borderLR" >
							<td width="5%" height="20" align="center">'.$j.'</td>
							<td width="30%" align="left">'.$row['nama'].'</td>
							<td width="10%" align="right">'.$row['jumlah'].'</td>
							<td width="10%" align="center">'.$row['satuan'].'</td>
							<td width="12%" align="right">'.number_format($row['harga_satuan'],'2',',','.').'</td>
							<td width="12%" align="right">'.$row['discount'].'</td>
							<td width="21%" align="right">'.number_format($row['subtotal'],'2',',','.').'</td>
						</tr> ';
				
				
				$totalPo += $row['subtotal'];
				$total += $row['subtotal'];
				$j++;
				$heightTmp = $heightTmp - 22;
		}
  		
$html .='
</table>
<table width="100%" border="0" class="txt7" >	
  <tr style="vertical-align:top;" class="borderT">
  <td align="left" width="67%" colspan="5"></td>
	<td align="right" width="12%"><strong>JUMLAH</strong></td>
	<td align="right" width="21%" class="border"><strong>'.number_format($totalPo,'2',',','.').'</strong></td>
  </tr>';
$sqlBiaya = "SELECT
					tbt_purchase_order_biaya_lain.nama_biaya,
					tbt_purchase_order_biaya_lain.biaya
				FROM
					tbt_purchase_order_biaya_lain
				WHERE
					tbt_purchase_order_biaya_lain.deleted = '0'
				AND tbt_purchase_order_biaya_lain.id_po = '$idPo' ";

$arrBiaya = $this->queryAction($sqlBiaya,'S');
if($arrBiaya)
{
	foreach($arrBiaya as $rowBiaya)
	{
		$html .='<tr style="vertical-align:top;" >
					<td align="left" colspan="5"></td>
					<td align="right"><strong>'.$rowBiaya['nama_biaya'].'</strong></td>
					<td align="right" class="border"><strong>'.number_format($rowBiaya['biaya'] ,'2',',','.').'</strong></td>
				  </tr>';
		$total += $rowBiaya['biaya'];
	}
}

$ppnPercent = PurchaseOrderRecord::finder()->findByPk($idPo)->ppn;
		$ppn = $totalPo * ($ppnPercent / 100);
		$dp = PurchaseOrderRecord::finder()->findByPk($idPo)->dp;
		$totalSesudahPpn = ($total + $ppn) - $dp;
$html .='<tr style="vertical-align:top;" >
    <td align="left" colspan="5"></td>
	<td align="right"><strong>PPN ('.$ppnPercent.' %)</strong></td>
	<td align="right" class="border"><strong>'.number_format($ppn ,'2',',','.').'</strong></td>
  </tr>
   <tr style="vertical-align:top;" >
    <td align="left" colspan="5"></td>
	<td align="right"><strong>DP</strong></td>
	<td align="right" class="border"><strong>'.number_format($dp ,'2',',','.').'</strong></td>
  </tr>
  <tr style="vertical-align:top;" >
    <td align="left" colspan="5"></td>
	<td align="right"><strong>TOTAL</strong></td>
	<td align="right" class="border"><strong>'.number_format($totalSesudahPpn ,'2',',','.').'</strong></td>
  </tr>
  <tr style="vertical-align:top;" >
    <td align="right"><strong>TERBILANG</strong></td>
    <td align="right" colspan="6"><h3><strong>'.$this->terbilang($totalSesudahPpn).'</strong></h3></td>
  </tr>
</table>

<table width="100%" border="0" class="txt7 nopadding">
	  <tr>
	    <td width="10%">Distribusi</td>
			<td width="1%" align="center">&nbsp;</td>
			<td width="22%">&nbsp;</td>
	    <td width="8%">&nbsp;</td>
	    <td width="64%" rowspan="6" valign="top">Setuju dan Sanggup melaksanakan dengan syarat-syarat dan kondisi sesuai tertera di surat pesanan ini.<br />
	      Agree and quality to execute the terms and conditions mentioned in this PO.</td>
  </tr>
	  <tr>
	    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Asli</td>
	    <td align="center">:</td>
	    <td>Supplier</td>
	    <td></td>
  </tr>
	  <tr>
	    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Copy 1</td>
	    <td align="center">:</td>
	    <td>Gudang</td>
	    <td></td>
  </tr>
	  <tr>
	    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Copy 2</td>
	    <td align="center">:</td>
	    <td>Finance</td>
	    <td></td>
  </tr>
	  <tr>
	    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Copy 3</td>
	    <td align="center">:</td>
	    <td>P & L</td>
	    <td></td>
  </tr>
  <tr>
	    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Copy 4</td>
	    <td align="center">:</td>
	    <td>Regional Office</td>
	    <td></td>
  </tr>
</table>
<br />
<br />
<table width="100%" border="0" class="txt7 nopadding">
	  <tr>
	    <td width="30%"align="center" valign="top">Dipersiapkan / Dibuat Oleh,-<br />
				<br />
				<br />
				<br />
				<br />
				<u>Ahmad Gustami</u><br/>Staff Pengadaan & Logistik
      </td>
      <td width="30%" align="center" valign="top">Diverifikasi Oleh,-<br />
        <br />
        <br />
        <br />
          <br />
	      <u>Muhammad Adil Hasibuan, SE</u><br/>Manager Pemasaran
      </td>
	    <td width="30%" rowspan="6" align="center" valign="top">Diketahui / Disetujui Oleh,-
	      <br />
	      <br />
				<br />
				<br />
				<br />
				<u>Putra Mahkota Alam Hasibuan, SE</u><br/>Direktur Utama
        </td>
  </tr>
</table>
  <br />
<table width="100%" border="0" class="txt6 nopadding">
	<tr>
		<td valign="top"><strong><em>Catatan: "Harap cantumkan NO. PO pada Faktur yang dikirim!" </em></strong></td>
  </tr>
</table>

';

// output the HTML content
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
