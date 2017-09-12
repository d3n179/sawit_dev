<?php
Prado::using('Application.modules.tcpdf.tcpdf');
Prado::using('Application.modules.tcpdf.htmlcolors');

class cetakSlipGajiPdf extends MainConf
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
		$month = $this->Request['bulan'];//date("m");
		$year = $this->Request['tahun'];//date("Y");
		$nik = $this->Request['nik'];
		$idK = $this->Request['id'];
		
		if($month == '01')
			$nmBulan = "Januari";
		elseif($month == '02')
			$nmBulan = "Februari";
		elseif($month == '03')
			$nmBulan = "Maret";
		elseif($month == '04')
			$nmBulan = "April";
		elseif($month == '05')
			$nmBulan = "Mei";
		elseif($month == '06')
			$nmBulan = "Juni";
		elseif($month == '07')
			$nmBulan = "Juli";
		elseif($month == '08')
			$nmBulan = "Agustus";
		elseif($month == '09')
			$nmBulan = "September";
		elseif($month == '10')
			$nmBulan = "Oktober";
		elseif($month == '11')
			$nmBulan = "Novemver";
		elseif($month == '12')
			$nmBulan = "Desember";
			
		$profilPerusahaan = $this->profilPerusahaan();		
		$KaryawanRecord = KaryawanRecord::finder()->findByPk($idK);
		$JabatanRecord = JabatanRecord::finder()->findByPk($KaryawanRecord->id_jabatan);
		$DepartmentRecord = DepartmentRecord::finder()->findByPk($JabatanRecord->id_department);
		$SubDepartmentRecord = DepartmentRecord::finder()->findByPk($JabatanRecord->id_subdepartment);
		$KantorCabangRecord = KantorCabangRecord::finder()->findByPk($KaryawanRecord->id_cabang);
		$LevelDistribusiRecord = LevelDistribusiRecord::finder()->findByPk($JabatanRecord->id_level_distribusi);
		$GolonganKaryawanRecord = GolonganKaryawanRecord::finder()->findByPk($KaryawanRecord->id_golongan);
		$IncentiveRecord = IncentiveRecord::finder()->find('id_karyawan = ? AND bulan = ? AND tahun = ? ',$idK,$month,$year);
		if($KaryawanRecord->id_ptkp == '0')
			$snk = 'S';
		if($KaryawanRecord->id_ptkp == '1')
			$snk = 'K-0';
		if($KaryawanRecord->id_ptkp == '2')
			$snk = 'K-1';
		if($KaryawanRecord->id_ptkp == '3')
			$snk = 'K-2';
		if($KaryawanRecord->id_ptkp == '4')
			$snk = 'K-3';
			
		$tglMasukKerja = $this->ConvertDate($KaryawanRecord->tglawalkerja,'3');	
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
$pdf->AddPage('L', 'A4' );

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

$gajiKotor = $GolonganKaryawanRecord->gaji_pokok;
$gajiKotor += $KaryawanRecord->tunjangan_natura;
$gajiKotor += $IncentiveRecord->jml_incentive;
$gajiKotor += $JabatanRecord->tunjangan_jabatan;
$gajiKotor += $JabatanRecord->tunjangan_komunikasi;
$gajiKotor += $JabatanRecord->premi_karyawan;

$totalLembur = 0;
		$sqlLpp = "SELECT
						SUM(
							tbt_lembur_karyawan.lama_lembur
						) AS lama_lembur
					FROM
						tbt_lembur_karyawan
					WHERE
						tbt_lembur_karyawan.id_karyawan = '$idK'
					AND MONTH(tbt_lembur_karyawan.tgl) = '$month'
					AND YEAR(tbt_lembur_karyawan.tgl) = '$year'
					AND tbt_lembur_karyawan.jns_lembur = '1'
					AND tbt_lembur_karyawan.deleted != '1' ";
		$arrLpp = $this->queryAction($sqlLpp,'S');
		$tarifLpp = (1/173) * $GolonganKaryawanRecord->gaji_pokok;
		$jmlLpp = $arrLpp[0]['lama_lembur'] * $tarifLpp;
		$totalLembur += $jmlLpp;

$sqlLppml = "SELECT
						SUM(
							tbt_lembur_karyawan.lama_lembur
						) AS lama_lembur
					FROM
						tbt_lembur_karyawan
					WHERE
						tbt_lembur_karyawan.id_karyawan = '$idK'
					AND MONTH(tbt_lembur_karyawan.tgl) = '$month'
					AND YEAR(tbt_lembur_karyawan.tgl) = '$year'
					AND tbt_lembur_karyawan.jns_lembur = '2'
					AND tbt_lembur_karyawan.deleted != '1' ";
		$arrLppml = $this->queryAction($sqlLppml,'S');
		$tarifLppml = ((1/173) * $GolonganKaryawanRecord->gaji_pokok) * 1.5;
		$jmlLppml = $arrLppml[0]['lama_lembur'] * $tarifLppml;
		$totalLembur += $jmlLppml;


$sqlLpplk = "SELECT
						SUM(
							tbt_lembur_karyawan.lama_lembur
						) AS lama_lembur
					FROM
						tbt_lembur_karyawan
					WHERE
						tbt_lembur_karyawan.id_karyawan = '$idK'
					AND MONTH(tbt_lembur_karyawan.tgl) = '$month'
					AND YEAR(tbt_lembur_karyawan.tgl) = '$year'
					AND tbt_lembur_karyawan.jns_lembur = '3'
					AND tbt_lembur_karyawan.deleted != '1' ";
		$arrLpplk = $this->queryAction($sqlLpplk,'S');
		$tarifLpplk = ((1/173) * $GolonganKaryawanRecord->gaji_pokok) * 2;
		$jmlLpplk = $arrLpplk[0]['lama_lembur'] * $tarifLpplk;
		$totalLembur += $jmlLpplk;
//$gajiKotor += ;

$totalPotongan = 0;				
if($KaryawanRecord->st_bpjs_ketenagakerjaan == '1')
{
	//$bpjsTenagaKerja = $GolonganKaryawanRecord->gaji_pokok * (2/100);
	$BpjsKaryawanRecord = BpjsKaryawanRecord::finder()->find('id_karyawan = ? AND jns_bpjs = ? AND deleted = ?',$KaryawanRecord->id,'1','0');
					
	if($BpjsKaryawanRecord)	
	{
		$bpjsTenagaKerja = $BpjsKaryawanRecord->karyawan;
		$bpjsTenagaKerjaPerusahaan = $BpjsKaryawanRecord->perusahaan;
	}
	else
	{
		$bpjsTenagaKerja = 0;
		$bpjsTenagaKerjaPerusahaan = 0;
	}
}
else
	$bpjsTenagaKerja = 0;

$totalPotongan += $bpjsTenagaKerja;

if($KaryawanRecord->st_bpjs_kesehatan == '1')
{
	$BpjsKaryawanRecord = BpjsKaryawanRecord::finder()->find('id_karyawan = ? AND jns_bpjs = ? AND deleted = ?',$KaryawanRecord->id,'0','0');
	
	if($BpjsKaryawanRecord)	
	{
		$Pengali = 1 + $BpjsKaryawanRecord->tambahan_keluarga;
		$bpjsKesehatan = $BpjsKaryawanRecord->karyawan * $Pengali;
		$bpjsKesehatanPerusahaan = $BpjsKaryawanRecord->perusahaan;
	}
	else
	{
		$bpjsKesehatan = 0;
		$bpjsKesehatanPerusahaan = 0;
	}
					
	/*if($KaryawanRecord->tambahan_keluarga > 0)
		$multiplyBpjs = $KaryawanRecord->tambahan_keluarga + 1;
	else
		$multiplyBpjs = 1;
				
	$bpjsKesehatan = ($GolonganKaryawanRecord->gaji_pokok * (1/100)) * $multiplyBpjs;*/
}
else
	$bpjsKesehatan = 0;

$totalPotongan += $bpjsKesehatan;

$sqlPinjaman = "SELECT
							SUM(
								tbt_expense_karyawan.jml_expense
							) AS jml_expense
						FROM
							tbt_expense_karyawan
						WHERE
							tbt_expense_karyawan.id_karyawan = '$idK'
						AND tbt_expense_karyawan.jns_expense = '1'
						AND MONTH(tbt_expense_karyawan.tgl) = '$month'
						AND YEAR(tbt_expense_karyawan.tgl) = '$year'
						AND tbt_expense_karyawan.deleted != '1' ";
		$arrPinjaman = $this->queryAction($sqlPinjaman,'S');
		$jmlPinjaman = $arrPinjaman[0]['jml_expense'];			
$totalPotongan += $jmlPinjaman;
$sqlKantin = "SELECT
							SUM(
								tbt_expense_karyawan.jml_expense
							) AS jml_expense
						FROM
							tbt_expense_karyawan
						WHERE
							tbt_expense_karyawan.id_karyawan = '$idK'
						AND tbt_expense_karyawan.jns_expense = '2'
						AND MONTH(tbt_expense_karyawan.tgl) = '$month'
						AND YEAR(tbt_expense_karyawan.tgl) = '$year'
						AND tbt_expense_karyawan.deleted != '1' ";
		$arrKantin = $this->queryAction($sqlKantin,'S');
		$jmlKantin = $arrKantin[0]['jml_expense'];
$totalPotongan += $jmlKantin;
$sqlKoperasi = "SELECT
							SUM(
								tbt_expense_karyawan.jml_expense
							) AS jml_expense
						FROM
							tbt_expense_karyawan
						WHERE
							tbt_expense_karyawan.id_karyawan = '$idK'
						AND tbt_expense_karyawan.jns_expense = '3'
						AND MONTH(tbt_expense_karyawan.tgl) = '$month'
						AND YEAR(tbt_expense_karyawan.tgl) = '$year'
						AND tbt_expense_karyawan.deleted != '1' ";
		$arrKoperasi = $this->queryAction($sqlKoperasi,'S');
		$jmlKoperasi = $arrKoperasi[0]['jml_expense'];
$totalPotongan += $jmlKoperasi;
$sqlMangkir = "SELECT
							COUNT(
								tbm_jadwal.id
							) AS mangkir
						FROM
							tbm_jadwal
						WHERE
							tbm_jadwal.idkaryawan = '$idK'
						AND tbm_jadwal.st_hadir = '1'
						AND MONTH(tbm_jadwal.tanggal) = '$month'
						AND YEAR(tbm_jadwal.tanggal) = '$year' ";
		$arrMangkir = $this->queryAction($sqlMangkir,'S');
		$jmlMangkir = $arrMangkir[0]['mangkir'];
		$totalMangkir = ($GolonganKaryawanRecord->gaji_pokok / 25 / 7) * $jmlMangkir;
$totalPotongan += $totalMangkir;
$sqlTelat = "SELECT
							COUNT(
								tbm_jadwal.id
							) AS telat
						FROM
							tbm_jadwal
						WHERE
							tbm_jadwal.idkaryawan = '$idK'
						AND tbm_jadwal.st_hadir = '0'
						AND tbm_jadwal.st_telat = '1'
						AND MONTH(tbm_jadwal.tanggal) = '$month'
						AND YEAR(tbm_jadwal.tanggal) = '$year' ";
		$arrTelat = $this->queryAction($sqlTelat,'S');
		$jmlTelat = $arrTelat[0]['telat'];
		$totalTelat = ($GolonganKaryawanRecord->gaji_pokok / 25 / 7) * $jmlTelat;
$totalPotongan += $totalTelat;
		
if(($gajiKotor + $totalLembur) >= $totalPotongan)
		$gajiBersih =  ($gajiKotor + $totalLembur) - $totalPotongan;
	else
		$gajiBersih = 0 ;
												
$html = '</br></br><table width="100%" cellpadding="2">
		  <tr>
			<td align="center" style="font-size:35px"><b>PT. SINAR HALOMOAN</b></td>
		  </tr>
		  <tr>
			<td align="center" style="font-size:30px"><b>KANTOR DIREKSI PASIR JAE</b></td>
		  </tr>
		  <tr>
			<td align="center" style="font-size:30px"><b>DEPARTEMEN ADMINISTRASI, KEUANGAN DAN SDM</b></td>
		  </tr>
		  <tr>
			<td align="center" style="font-size:30px"><b>Desa Pasir Jae, Kecamatan Sosa, Kabupaten Padang Lawas</b></td>
		  </tr>
		   <tr>
			<td align="center" style="font-size:25px"><b>SLIP GAJI KARYAWAN</b></td>
		  </tr>
		</table></br></br>
		<table width="100%" border="0" cellpadding="1"  cellspacing="0" style="font-family:Courier;font-size:8pt;">
		  <tr>
			<th width="15%">NIK</th>
			<th width="1%">:</th>
			<th width="15%">'.$KaryawanRecord->nik.'</th>
			<th width="3%" rowspan="8"></th>
			<th width="15%">Gaji Pokok</th>
			<th width="1%">:</th>
			<th width="15%" align="right">'.number_format($GolonganKaryawanRecord->gaji_pokok,0,".",",").'</th>
			<th width="3%" colspan="2" rowspan="8"></th>
			<th width="15%"><Strong>Potongan</Strong></th>
			<th width="1%"></th>
			<th width="15%"></th>
		  </tr>
		  <tr>
			<td class="tg-yw4l">Nama</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l">'.$KaryawanRecord->nama.'</td>
			<td class="tg-yw4l">Tunjangan Natura</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l" align="right">'.number_format($KaryawanRecord->tunjangan_natura,0,".",",").'</td>
			<td class="tg-yw4l">Bpjs Ketenagakerjaan</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l">'.number_format($bpjsTenagaKerja,0,'.',',').'</td>
		  </tr>
		  <tr>
			<td class="tg-yw4l">Jabatan</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l">'.$JabatanRecord->nama.'</td>
			<td class="tg-yw4l">Incentive</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l" align="right">'.number_format($IncentiveRecord->jml_incentive,0,".",",").'</td>
			<td class="tg-yw4l">Bpjs Kesehatan</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l">'.number_format($bpjsKesehatan,0,'.',',').'</td>
		  </tr>
		  <tr>
			<td class="tg-yw4l">Golongan</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l">'.$GolonganKaryawanRecord->nama.'</td>
			<td class="tg-yw4l">Tunjangan Jabatan</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l" align="right">'.number_format($JabatanRecord->tunjangan_jabatan,0,".",",").'</td>
			<td class="tg-yw4l">Pinjaman</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l">'.number_format($jmlPinjaman,0,'.',',').'</td>
		  </tr>
		  <tr>
			<td class="tg-yw4l">SNK</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l">'.$snk.'</td>
			<td class="tg-yw4l">Tunjangan Komunikasi</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l" align="right">'.number_format($JabatanRecord->tunjangan_komunikasi,0,".",",").'</td>
			<td class="tg-yw4l">Kantin</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l">'.number_format($jmlKantin,0,'.',',').'</td>
		  </tr>
		  <tr>
			<td class="tg-yw4l">TMK</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l">'.$tglMasukKerja.'</td>
			<td class="tg-yw4l">Premi Karyawan</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l" align="right">'.number_format($JabatanRecord->premi_karyawan,0,".",",").'</td>
			<td class="tg-yw4l">Koperasi</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l">'.number_format($jmlKoperasi,0,'.',',').'</td>
		  </tr>
		  <tr>
			<td class="tg-yw4l">Periode</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l">'.$nmBulan.' '.$year.'</td>
			<td class="tg-9hbo"><strong>Jumlah</strong></td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l" align="right"><strong>'.number_format($gajiKotor,0,".",",").'</strong></td>
			<td class="tg-yw4l">Mangkir (M)</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l">'.number_format($totalMangkir,0,'.',',').'</td>
		  </tr>
		  <tr>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l">Terlambat Masuk Kerja</td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l">'.number_format($totalTelat,0,'.',',').'</td>
		  </tr>
		  <tr>
			<td colspan="4" rowspan="7"></td>
			<td colspan="3" rowspan="7">
				<table border="0" width="100%">
				  <tr>
					<th width="25%"><strong>Lembur</strong></th>
					<th width="4%"></th>
					<th width="20%" align="center"><strong>Jam</strong></th>
					<th width="25%" align="center"><strong>Tarif</strong></th>
					<th width="30%" align="center"><strong>Jumlah Bayar</strong></th>
				  </tr>
				  <tr>
					<td class="tg-031e">LPP</td>
					<td class="tg-031e">:</td>
					<td class="tg-031e" align="center">'.$arrLpp[0]['lama_lembur'].'</td>
					<td class="tg-031e" align="right">'.number_format($tarifLpp,0,'.',',').'</td>
					<td class="tg-yw4l" align="right">'.number_format($jmlLpp,0,'.',',').'</td>
				  </tr>
				  <tr>
					<td class="tg-031e">LPPML</td>
					<td class="tg-031e">:</td>
					<td class="tg-031e" align="center">'.$arrLppml[0]['lama_lembur'].'</td>
					<td class="tg-031e" align="right">'.number_format($tarifLppml,0,'.',',').'</td>
					<td class="tg-yw4l" align="right">'.number_format($jmlLppml,0,'.',',').'</td>
				  </tr>
				  <tr>
					<td class="tg-yw4l">LPPLK</td>
					<td class="tg-yw4l">:</td>
					<td class="tg-yw4l" align="center">'.$arrLpplk[0]['lama_lembur'].'</td>
					<td class="tg-yw4l" align="right">'.number_format($tarifLpplk,0,'.',',').'</td>
					<td class="tg-yw4l" align="right">'.number_format($jmlLpplk,0,'.',',').'</td>
				  </tr>
				  <tr>
					<td class="tg-yw4l"><strong>Total Lembur</strong></td>
					<td class="tg-yw4l">:</td>
					<td class="tg-yw4l"></td>
					<td class="tg-yw4l"></td>
					<td class="tg-yw4l" align="right">'.number_format($totalLembur,0,'.',',').'</td>
				  </tr>
				</table>
			</td>
			<td class="tg-9hbo"></td>
			<td class="tg-9hbo"></td>
			<td class="tg-9hbo"><Strong>Total Potongan</Strong></td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l">'.number_format($totalPotongan,0,'.',',').'</td>
		  </tr>
		  <tr>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
		  </tr>
		  <tr>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"><Strong>Total Gaji</Strong></td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l"><Strong>'.number_format($gajiKotor + $totalLembur,0,'.',',').'</Strong></td>
		  </tr>
		  <tr>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
		  </tr>
		  <tr>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-9hbo"><Strong>Sisa Gaji</Strong></td>
			<td class="tg-yw4l">:</td>
			<td class="tg-yw4l"><Strong>'.number_format($gajiBersih,0,'.',',').'</Strong></td>
		  </tr>
		  <tr>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
		  </tr>
		  <tr>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
			<td class="tg-yw4l"></td>
		  </tr>
		</table><br />';
		
		/*"<table border="1" >
				  <tr>
					<th width="12%"><strong>Lembur</strong></th>
					<th width="1%"></th>
					<th width="10%" align="center">Jam</th>
					<th width="12%" align="center">Tarif</th>
					<th width="12%" align="center">Jumlah Bayar<br></th>
				  </tr>
				  <tr>
					<td class="tg-031e">LPP</td>
					<td class="tg-031e">:</td>
					<td class="tg-031e"></td>
					<td class="tg-031e"></td>
					<td class="tg-yw4l"></td>
				  </tr>
				  <tr>
					<td class="tg-031e">LPPML</td>
					<td class="tg-031e">:</td>
					<td class="tg-031e"></td>
					<td class="tg-031e"></td>
					<td class="tg-yw4l"></td>
				  </tr>
				  <tr>
					<td class="tg-yw4l">LPPLK</td>
					<td class="tg-yw4l">:</td>
					<td class="tg-yw4l"></td>
					<td class="tg-yw4l"></td>
					<td class="tg-yw4l"></td>
				  </tr>
				  <tr>
					<td class="tg-yw4l">Total Lembur<br></td>
					<td class="tg-yw4l">:</td>
					<td class="tg-yw4l"></td>
					<td class="tg-yw4l"></td>
					<td class="tg-yw4l"></td>
				  </tr>
				</table>"*/
$pdf->writeHTML($html, true, false, true, false, '');
$pdf->Ln(1);
$html = '<table width="100%" cellpadding="0" border="0">
		  <tr>
			<td width="35%" align="center" style="font-size:28px; text-decoration: underline;"><b>PT SINAR HALOMOAN</b></td>
			<td width="30%"></td>
			<td width="35%" align="center" style="font-size:28px; text-decoration: underline;"><b>Diterima Oleh,</b></td>
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
			<td align="center" style="font-size:30px;"><b style="text-decoration: underline;">PUTRA MAHKOTA ALAM HASIBUAN, SE </b><br/><i><strong>DIREKTUR UTAMA</strong></i></td>
			<td></td>
			<td align="center" style="font-size:30px;"><b style="text-decoration: underline;">......................................................</b><br/><b>Nama : '.$KaryawanRecord->nama.'</b></td>
		  </tr>
		</table>';
$pdf->writeHTML($html, true, false, true, false, '');
// reset pointer to the last page
$pdf->lastPage();

// ---------------------------------------------------------

//Close and output PDF document
//$pdf->Output($noPO.'.pdf', 'I');
	
		//$po = str_replace('/','-',$PurchaseOrderRecord->no_po);
		$pdf->Output();			
				
		//$pdf->Output($PurchaseOrderRecord->no_po.'.pdf', 'I');		
		
	}
	
}
?>
