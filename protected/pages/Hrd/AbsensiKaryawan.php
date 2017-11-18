<?PHP
class AbsensiKaryawan extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$sqlJabatan = "SELECT id, nama FROM tbm_jabatan WHERE deleted ='0' ";
			$arrJabatan = $this->queryAction($sqlJabatan,'S');
			$this->DDJabatan->DataSource = $arrJabatan;
			$this->DDJabatan->DataBind();
		}
		
	}
	
	public function onPreRender($param)
	{
		parent::onPreRender($param);
		
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$this->getStatusAbsensi();
			/*$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#table-1 tbody").append("'.$tblBody.'");');	*/
		}
	}
	
	public function dateChanged()
	{
		$tblBody = $this->BindGrid();
		$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#table-1").dataTable().fnDestroy();
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					BindGrid();
					unloadContent();
					');
	}
	
	public function getStatusAbsensi()
	{
		$arr = array();
		//$sqlAbsen = "SELECT id,globaldistribusi AS text FROM tbm_payrol WHERE (attendance_id = '1' OR attendance_id = '2' OR attendance_id = '3') AND deleted = '0'  ORDER BY globaldistribusi asc ";
		//$arrAbsen  = $this->queryAction($sqlAbsen,'S');
		$arr[] = array("id"=>0,"text"=>"Hadir");
		$arr[] = array("id"=>1,"text"=>"Mangkir");
		$arr[] = array("id"=>2,"text"=>"Cuti");
		/*foreach($arrAbsen as $row)
		{
			$arr[] = array("id"=>$row['id'],"text"=>$row['text']);
		}*/
		//var_dump($arrAbsen);
		$this->arrStatus->Value = json_encode($arr,true);
	}
	
	public function BindGrid()
	{
		if($this->tglAbsensi->Text != '')
		{
			$tglAbsen = $this->ConvertDate($this->tglAbsensi->Text,'2');
			$sql = "SELECT
						tbm_jadwal.id,
						tbm_karyawan.nik,
						tbm_karyawan.nama,
						tbm_jadwal.awal,
						tbm_jadwal.ahir,
						tbm_jadwal.lama,
						tbm_jadwal.datang,
						tbm_jadwal.pulang,
						tbm_jadwal.st_hadir,
						tbm_jadwal.st
					FROM
						tbm_jadwal
					INNER JOIN tbm_karyawan ON tbm_karyawan.id = tbm_jadwal.idkaryawan
					WHERE
						tbm_jadwal.tanggal = '$tglAbsen'  ";
						
			if($this->DDJabatan->SelectedValue != 'empty')
				$sql .= " AND tbm_karyawan.id_jabatan = '".$this->DDJabatan->SelectedValue."'";
			
			$sql .= " ORDER BY 
						tbm_karyawan.id ASC ";
						
			$Record = $this->queryAction($sql,'S');
			
			$count = count($Record);
			$tblBody = '';
			if($count > 0)
			{
				foreach($Record as $row)
				{
					
					if($row['st'] == '2')
					{
						$disabledIn = 'disabled';
						$disabledOut = 'disabled';
						$disabled = 'disabled';
					}
					elseif($row['st'] == '0')
					{
						$disabledIn = 'disabled';
						$disabledOut = 'disabled';
						$disabled = '';
					}
					elseif($row['st'] == '1')
					{
						$disabledIn = 'disabled';
						$disabledOut = '';
						$disabled = 'disabled';
					}
								
					$tblBody .= '<tr>';
					$tblBody .= '<td>'.$row['nik'].'</td>';
					$tblBody .= '<td>'.$row['nama'].'</td>';
					$tblBody .= '<td>'.$row['awal'].'</td>';
					$tblBody .= '<td>'.$row['ahir'].'</td>';
					$tblBody .= '<td>'.$row['lama'].'</td>';	
					$tblBody .= '<td><input id=\"status-ID-'.$row['id'].'\" idJadwal=\"'.$row['id'].'\" class=\"form-control input-xsmall input-xs status_column\" type=\"text\" value=\"'.$row['st_hadir'].'\" '.$disabled.'><label ID=\"msg-column-'.$row['id'].'\" class=\"msg_column\" style=\"color: #B4886B;font-weight: bold; Display:None;\">Jatah Cuti Habis !</label></td>';
					$tblBody .= '<td><input size=\"5\" id=\"in-ID-'.$row['id'].'\" idJadwal=\"'.$row['id'].'\" class=\"form-control input-xsmall input-xs in_column\" type=\"text\" value=\"'.$row['datang'].'\" '.$disabledIn.'></td>';		
					$tblBody .= '<td><input size=\"5\" id=\"out-ID-'.$row['id'].'\" idJadwal=\"'.$row['id'].'\" class=\"form-control input-xsmall input-xs out_column\" type=\"text\" value=\"'.$row['pulang'].'\" '.$disabledOut.'></td>';		
					$tblBody .= '</tr>';
				}
			}
			else
			{
				$tblBody = '';
			}
			
			return 	$tblBody;
		}
	}
	
	public function submitBtnClicked($sender,$param)
	{
			$arrAbsen = $param->CallbackParameter->arrAbsen;
			foreach($arrAbsen as $row)
			{
				$arrCutiHabis = array();
				
				if($row->stHadir != '0')
				{
					$JadwalRecord = JadwalRecord::finder()->findByPk($row->jadwalId);
					$tglJadwal = $JadwalRecord->tanggal;
				
					if($row->stHadir == '2')
					{
						$KaryawanRecord = KaryawanRecord::finder()->findByPk($JadwalRecord->idkaryawan);
						$JabatanRecord = JabatanRecord::finder()->findByPk($KaryawanRecord->id_jabatan);
						$jatahCuti = $JabatanRecord->jatah_cuti;
						$sqlCuti = "SELECT count(id) as jml_cuti FROM tbm_jadwal WHERE idkaryawan = '".$JadwalRecord->idkaryawan."' AND YEAR(tanggal) = YEAR(".$tglJadwal.") ";
						$arrCuti = $this->queryAction($sqlCuti,'S');
						$jmlCuti = $arrCuti[0]['jml_cuti'];
						
						if($jatahCuti > $jmlCuti)
						{
							$JadwalRecord->st = '2';
							$JadwalRecord->st_hadir = $row->stHadir;
							$JadwalRecord->save();
						}
						else
						{
							$arrCutiHabis[] = array("id"=>$JadwalRecord->id);
						}
					}
					else
					{
						$JadwalRecord->st = '2';
						$JadwalRecord->st_hadir = $row->stHadir;
						$JadwalRecord->save();
					}
					
					/*$JadwalPenaltyRecord = new JadwalPenaltyRecord();
					$JadwalPenaltyRecord->idjadwal = $JadwalRecord->id;
					$JadwalPenaltyRecord->payroll_id = $row->stHadir;
					$JadwalPenaltyRecord->save();*/
				}
				else
				{
					if($row->wktIn != '')
					{
						$JadwalRecord = JadwalRecord::finder()->findByPk($row->jadwalId);
						$JadwalRecord->st_hadir = $row->stHadir;
						if($JadwalRecord->st == '0')
						{
							$JadwalRecord->st = '1';
							$JadwalRecord->datang = $row->wktIn;
							
							$jadwalMasukAbsen = $JadwalRecord->tanggal.' '.$JadwalRecord->awal;
							$masukAbsen = $JadwalRecord->tanggal.' '.$row->wktIn.":00";
							$datetime1 = strtotime($jadwalMasukAbsen);
							$datetime2 = strtotime($masukAbsen);
							if($datetime2 > $datetime1)
							{
								$JadwalRecord->st_telat = '1';
							}
						}
								
						if($row->wktOut != '')
						{
							$JadwalRecord->st = '2';
							$JadwalRecord->pulang = $row->wktOut;
							
							/*$jadwalPulangAbsen = $JadwalRecord->tanggal.' '.$JadwalRecord->ahir;
							$pulangAbsen = $JadwalRecord->tanggal.' '.$row->wktOut.":00";
							$datetime1 = strtotime($jadwalPulangAbsen);
							$datetime2 = strtotime($pulangAbsen);
							if($datetime2 > $datetime1)
							{
								$interval  = abs($datetime2 - $datetime1);
								$minutes   = round($interval / 60);
								$sqlSub = "SELECT * FROM tbm_payrol WHERE attendance_id = '5' AND $minutes BETWEEN time1 AND time2 ORDER BY globaldistribusi ASC ";
								$sub=$this->queryAction($sqlSub,'S');
								foreach($sub as $s)
								{
									$idPayroll = $s['id'];
									$JadwalPenaltyRecord = new JadwalPenaltyRecord();
									$JadwalPenaltyRecord->idjadwal = $JadwalRecord->id;
									$JadwalPenaltyRecord->payroll_id = $idPayroll;
									$JadwalPenaltyRecord->save();
								}
							}*/
							
						}
					
						$JadwalRecord->save();
					}
				}
			}
			
			$arrJson = json_encode($arrCutiHabis,true);
			$tblBody = $this->BindGrid();
			
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("Absensi Karyawan Telah Disimpan");
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						BindGrid();
						RenderMsg('.$arrJson.');
						unloadContent();');	
		
	}
	
	public function clearForm()
	{
	}
	
}
?>
