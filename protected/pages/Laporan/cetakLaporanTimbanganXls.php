<?php
class cetakLaporanTimbanganXls extends XlsGen
{
	public function onLoad($param)
	{		
		$periode = $this->Request['periode'];
		$bln = $this->Request['bln'];
		$thn =$this->Request['thn'];
		$mingguan =$this->Request['mingguan'];
		
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
			
		$file = 'LaporanTimbangan.xls';
		
		//http headers	
		$this->HeaderingExcel($file);
		
		//membuat workbook
		$workbook=new Workbook("-");
		
		//membuat worksheet pertama
		$worksheet1= & $workbook->add_worksheet('Laporan Timbangan');
		
		$baris=0;
		$kolom=0;
		
		//set lebar tiap kolom
		$this->AddWS($worksheet1,'c','8',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','25',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','15',$baris,$kolom); $baris++; $kolom++;
		
		$frmtTitleLeft =  & $workbook->add_format();
		$left= $this->AddFormat($frmtTitleLeft,'b','1','12');
		$left= $this->AddFormat($frmtTitleLeft,'bd','0','');
		$left= $this->AddFormat($frmtTitleLeft,'HA','left','');
		
		$frmtTitleLeft10 =  & $workbook->add_format();
		$left= $this->AddFormat($frmtTitleLeft10,'b','1','10');
		$left= $this->AddFormat($frmtTitleLeft10,'bd','0','');
		$left= $this->AddFormat($frmtTitleLeft10,'HA','left','');
		
		$frmtLeft =  & $workbook->add_format();
		$left= $this->AddFormat($frmtLeft,'b','1','10');
		$left= $this->AddFormat($frmtLeft,'bd','0','');
		$left= $this->AddFormat($frmtLeft,'HA','left','');		
		
		$frmtCenter =  & $workbook->add_format();
		$center= $this->AddFormat($frmtCenter,'b','1','10');
		$center= $this->AddFormat($frmtCenter,'bd','1','');
		$center= $this->AddFormat($frmtCenter,'HA','center','');
		
		$frmtWrap =  & $workbook->add_format();
		$wrap= $this->AddFormat($frmtWrap,'b','1','10');
		$wrap= $this->AddFormat($frmtWrap,'bd','1','');
		$wrap= $this->AddFormat($frmtWrap,'HA','center','');
		$wrap= $this->AddFormat($frmtWrap,'WR','1','');
		
		
		$baris=0;
		$kolom=0;
		$worksheet1->write_string($baris,0,'Laporan Timbangan' ,$frmtTitleLeft);
			
		$baris++;
		$worksheet1->write_string($baris,0,"Periode : ".$nmPeriode,$frmtTitleLeft10);
		$baris++;
		
		$frmtLeft =  & $workbook->add_format();
		$left= $this->AddFormat($frmtLeft,'','1','10');
		$left= $this->AddFormat($frmtLeft,'bd','1','');
		$left= $this->AddFormat($frmtLeft,'HA','left','');
		$left= $this->AddFormat($frmtLeft,'WR','1','');
		
		$frmtCenterHeader =  & $workbook->add_format();
		$centerHeader= $this->AddFormat($frmtCenterHeader,'b','1','10');
		$centerHeader= $this->AddFormat($frmtCenterHeader,'bd','1','');
		$centerHeader= $this->AddFormat($frmtCenterHeader,'HA','center','');
		$centerHeader= $this->AddFormat($frmtCenterHeader,'WR','1','');
		
		$frmtCenter =  & $workbook->add_format();
		$center= $this->AddFormat($frmtCenter,'','1','10');
		$center= $this->AddFormat($frmtCenter,'bd','1','');
		$center= $this->AddFormat($frmtCenter,'HA','center','');
		$center= $this->AddFormat($frmtCenter,'WR','1','');
		
		$frmtRight =  & $workbook->add_format();
		$right= $this->AddFormat($frmtRight,'','1','10');
		$right= $this->AddFormat($frmtRight,'bd','1','');
		$right= $this->AddFormat($frmtRight,'HA','right','');
		
		$baris++;
		$kolom = 0;
		//$worksheet1->set_row(6, 150,0); //set tinngi row ke-7
			
		$worksheet1->write_string($baris,$kolom,"NO",$centerHeader);$kolom++;
		$worksheet1->write_string($baris,$kolom,"NO. SP",$centerHeader);$kolom++;
		$worksheet1->write_string($baris,$kolom,"NO. POLISI",$centerHeader);$kolom++;
		$worksheet1->write_string($baris,$kolom,"N. BARANG",$centerHeader);$kolom++;
		$worksheet1->write_string($baris,$kolom,"SUPPLIER",$centerHeader);$kolom++;
		$worksheet1->write_string($baris,$kolom,"BRUTTO",$centerHeader);$kolom++;
		$worksheet1->write_string($baris,$kolom,"TARRA",$centerHeader);$kolom++;
		$worksheet1->write_string($baris,$kolom,"NETTO I",$centerHeader);$kolom++;
		$worksheet1->write_string($baris,$kolom,"POTONGAN (%)",$centerHeader);$kolom++;
		$worksheet1->write_string($baris,$kolom,"HSIL. POTONGAN",$centerHeader);$kolom++;
		$worksheet1->write_string($baris,$kolom,"NETTO II",$centerHeader);$kolom++;
		$worksheet1->write_string($baris,$kolom,"JLH TANDAN",$centerHeader);$kolom++;
		$worksheet1->write_string($baris,$kolom,"KOMIDEL",$centerHeader);$kolom++;
		$worksheet1->write_string($baris,$kolom,"KATEGORI TBS",$centerHeader);$kolom++;
		
		$baris++;
		$kolom = 0;
		$sql = "SELECT
						tbt_tbs_order.no_tbs_order,
						tbt_tbs_order.tgl_transaksi,
						tbm_pemasok.no_sp,
						tbt_tbs_order.no_polisi,
						tbm_barang.nama AS barang,
						tbm_pemasok.nama AS pemasok,
						tbt_tbs_order.bruto,
						tbt_tbs_order.tarra,
						tbt_tbs_order.netto_1,
						tbt_tbs_order.potongan,
						tbt_tbs_order.hasil_potongan,
						tbt_tbs_order.netto_2,
						tbt_tbs_order.jml_tandan,
						tbt_tbs_order.komidel,
						tbm_setting_komidel.nama AS kategori_tbs
					FROM
						tbt_tbs_order
					INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
					INNER JOIN tbm_barang ON tbm_barang.id = tbt_tbs_order.id_barang
					INNER JOIN tbm_setting_komidel ON tbm_setting_komidel.id = tbt_tbs_order.id_komidel
					WHERE
						tbt_tbs_order.deleted = '0' ";
		if($periode == '0')
		{
			if($bln != '' && $thn != '')
			{
				$sqlTrans .="AND MONTH(tbt_tbs_order.tgl_transaksi) = '$bln' AND YEAR(tbt_tbs_order.tgl_transaksi) = '$thn' ";
			}
		}
		elseif($periode == '1')
		{
			if($thn != '')
			{
				$sqlTrans .="AND YEAR(tbt_tbs_order.tgl_transaksi) = '$thn' ";
			}
		}				
		elseif($periode == '2')
		{
			if($mingguan != '')
			{
				$mingguan = explode("-",$mingguan);
				$tgl1 = trim(str_replace("/","-",$mingguan[0]));
				$tgl2 = trim(str_replace("/","-",$mingguan[1]));
				$tgl1 = explode("-",$tgl1);
				$tgl2 = explode("-",$tgl2);
				
				$tgl1 = $tgl1[1]."-".$tgl1[0]."-".$tgl1[2];
				$tgl2 = $tgl2[1]."-".$tgl2[0]."-".$tgl2[2];
				
				$tgl1 = $this->ConvertDate($tgl1,'2');
				$tgl2 = $this->ConvertDate($tgl2,'2');
				$sqlTrans .="AND tbt_tbs_order.tgl_transaksi BETWEEN '$tgl1' AND '$tgl2' ";
			}
		}
		$arr = $this->queryAction($sql,'S');
		$no = 1;
		foreach($arr as $row)
		{
			
			$worksheet1->write_string($baris,$kolom,$no,$centerHeader);$kolom++;
			$worksheet1->write_string($baris,$kolom,$row['no_sp'],$centerHeader);$kolom++;
			$worksheet1->write_string($baris,$kolom,$row['no_polisi'],$frmtLeft);$kolom++;
			$worksheet1->write_string($baris,$kolom,$row['barang'],$frmtLeft);$kolom++;
			$worksheet1->write_string($baris,$kolom,$row['pemasok'],$frmtLeft);$kolom++;
			$worksheet1->write_string($baris,$kolom,$row['bruto'],$frmtRight);$kolom++;
			$worksheet1->write_string($baris,$kolom,$row['tarra'],$frmtRight);$kolom++;
			$worksheet1->write_string($baris,$kolom,$row['netto_1'],$frmtRight);$kolom++;
			$worksheet1->write_string($baris,$kolom,$row['potongan'],$frmtRight);$kolom++;
			$worksheet1->write_string($baris,$kolom,$row['hasil_potongan'],$frmtRight);$kolom++;
			$worksheet1->write_string($baris,$kolom,$row['netto_2'],$frmtRight);$kolom++;
			$worksheet1->write_string($baris,$kolom,$row['jml_tandan'],$frmtRight);$kolom++;
			$worksheet1->write_string($baris,$kolom,$row['komidel'],$frmtRight);$kolom++;
			$worksheet1->write_string($baris,$kolom,$row['kategori_tbs'],$frmtLeft);$kolom++;
			
			$no++;
			$baris++;
			$kolom = 0;
		}
		$workbook->close(); 
	}
	
	
}
?>
