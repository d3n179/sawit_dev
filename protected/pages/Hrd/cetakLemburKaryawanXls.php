<?php
class cetakLemburKaryawanXls extends XlsGen
{
	public function onLoad($param)
	{		
		$periode = $this->Request['periode'];
		$bln = $this->Request['bulan'];
		$thn =$this->Request['tahun'];
		
		if($bln == '01')
			$nmBulan = "Januari";
		elseif($bln == '02')
			$nmBulan = "Februari";
		elseif($bln == '03')
			$nmBulan = "Maret";
		elseif($bln == '04')
			$nmBulan = "April";
		elseif($bln == '05')
			$nmBulan = "Mei";
		elseif($bln == '06')
			$nmBulan = "Juni";
		elseif($bln == '07')
			$nmBulan = "Juli";
		elseif($bln == '08')
			$nmBulan = "Agustus";
		elseif($bln == '09')
			$nmBulan = "September";
		elseif($bln == '10')
			$nmBulan = "Oktober";
		elseif($bln == '11')
			$nmBulan = "Novemver";
		elseif($bln == '12')
			$nmBulan = "Desember";
		
		$thnBln = $thn."-".$bln."-";	
		
		$file = 'JadwalKaryawan.xls';
		
		//http headers	
		$this->HeaderingExcel($file);
		
		//membuat workbook
		$workbook=new Workbook("-");
		
		//membuat worksheet pertama
		$worksheet1= & $workbook->add_worksheet('Jadwal Karyawan');
		
		$baris=0;
		$kolom=0;
		
		//set lebar tiap kolom
		$this->AddWS($worksheet1,'c','8',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','30',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		$this->AddWS($worksheet1,'c','10',$baris,$kolom); $baris++; $kolom++;
		
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
		$worksheet1->write_string($baris,0,'LEMBUR KARYAWAN' ,$frmtTitleLeft);
			
		$baris++;
		$worksheet1->write_string($baris,0,"Periode : ".$nmBulan." ".$thn ,$frmtTitleLeft10);
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
		$days = cal_days_in_month(CAL_GREGORIAN, $bln, $thn);
		$worksheet1->write_string($baris,$kolom,"NO",$centerHeader);	$kolom++;
		$worksheet1->write_string($baris,$kolom,"NAMA KARYAWAN",$centerHeader);	$kolom++;
		
		$i =1;
		while($i <= $days)
		{
			$worksheet1->write_string($baris,$kolom,$i,$centerHeader);	$kolom++;
			$i++;
		}
		$baris++;
		$kolom = 0;
		$no = 1;
		$sqlKaryawan = "SELECT id,nama FROM tbm_karyawan WHERE deleted ='0' ";
		$arrKaryawan = $this->queryAction($sqlKaryawan,'S');
		foreach($arrKaryawan as $rowKaryawan)
		{
			$worksheet1->write_string($baris,$kolom,$no,$centerHeader);	$kolom++;
			$worksheet1->write_string($baris,$kolom,$rowKaryawan['nama'],$frmtLeft);$kolom++;
			
			$i =1;
			while($i <= $days)
			{
				$date = $thn."-".$bln."-".$i;
				$JadwalRecord = JadwalRecord::finder()->find('idkaryawan = ? AND tanggal = ? AND st_hadir = ? AND st = ?',$rowKaryawan['id'],$date,'0','2');
				if($JadwalRecord)
				{
					$idJadwal = $JadwalRecord->id;
					$LemburRecord = LemburRecord::finder()->find('id_karyawan = ? AND id_jadwal = ? AND deleted = ? ',$rowKaryawan['id'],$idJadwal,'0');
					if($LemburRecord)
						$lamaLembur = $LemburRecord->lama_lembur." Jam";
					else
						$lamaLembur = '';
				}
				else
					$lamaLembur = '';
						
				$worksheet1->write_string($baris,$kolom,$lamaLembur,$center);$kolom++;
				$i++;
			}
		
			$no++;	
			$baris++;
			$kolom = 0;
		}
		
		
		$baris++;
		$kolom = 0;
		
		$workbook->close(); 
	}
	
	
}
?>
