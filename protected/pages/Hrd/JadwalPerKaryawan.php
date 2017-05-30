<?PHP
class JadwalPerKaryawan extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			
		}
		
	}
	
	public function onPreRender($param)
	{
		parent::onPreRender($param);
		
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$tahun = date("Y");
			$arrThn[] = array("id"=>$tahun,'nama'=>$tahun);
			 
			$a = 20;
			$i = 1;
			while($i < $a)
			{
				$arrThn[] = array("id"=>$tahun-$i,'nama'=>$tahun-$i); 
				$i++;
			}
			$this->DDTahun->DataSource = $arrThn;
			$this->DDTahun->DataBind();
			
			$sqlKaryawan = "SELECT id, nama FROM tbm_karyawan WHERE deleted ='0' ";
			$arrKaryawan = $this->queryAction($sqlKaryawan,'S');
			$this->DDKaryawan->DataSource = $arrKaryawan;
			$this->DDKaryawan->DataBind();	
			/*$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#table-1 tbody").append("'.$tblBody.'");');	*/
		}
	}
	
	public function jadwalChanged()
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
	public function BindGrid()
	{
		if($this->DDKaryawan->SelectedValue != '' && $this->DDBulan->SelectedValue != '' && $this->DDTahun->SelectedValue != '')
		{
			$sql = "SELECT
						tbm_jadwal.id,
						tbm_karyawan.nik,
						tbm_karyawan.nama,
						tbm_jadwal.tanggal,
						tbm_jadwal.awal,
						tbm_jadwal.ahir,
						tbm_jadwal.lama,
						tbm_jadwal.datang,
						tbm_jadwal.pulang,
						IF(tbm_jadwal.st = '0','BELUM ABSEN',IF(tbm_jadwal.st_hadir = '0','HADIR',tbm_payrol.globaldistribusi)) AS st_hadir,
						tbm_jadwal.st
					FROM
						tbm_jadwal
					INNER JOIN tbm_karyawan ON tbm_karyawan.id = tbm_jadwal.idkaryawan
					LEFT JOIN tbm_payrol ON tbm_payrol.id = tbm_jadwal.st_hadir
					WHERE
						MONTH(tbm_jadwal.tanggal) = '".$this->DDBulan->SelectedValue."'
						AND YEAR(tbm_jadwal.tanggal) = '".$this->DDTahun->SelectedValue."'
						AND tbm_karyawan.id = '".$this->DDKaryawan->SelectedValue."'
					ORDER BY 
						tbm_jadwal.tanggal ASC ";
						
			$Record = $this->queryAction($sql,'S');
			
			$count = count($Record);
			$tblBody = '';
			if($count > 0)
			{
				foreach($Record as $row)
				{
								
					$tblBody .= '<tr>';
					$tblBody .= '<td>'.$this->ConvertDate($row['tanggal'],'3').'</td>';
					$tblBody .= '<td>'.$row['awal'].'</td>';
					$tblBody .= '<td>'.$row['ahir'].'</td>';
					$tblBody .= '<td>'.$row['lama'].'</td>';	
					$tblBody .= '<td>'.$row['st_hadir'].'</td>';	
					$tblBody .= '<td>'.$row['datang'].'</td>';
					$tblBody .= '<td>'.$row['pulang'].'</td>';
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
				if($row->stHadir != '0')
				{
					$JadwalRecord = JadwalRecord::finder()->findByPk($row->jadwalId);
					$JadwalRecord->st = '2';
					$JadwalRecord->st_hadir = $row->stHadir;
					$JadwalRecord->save();
					
					$JadwalPenaltyRecord = new JadwalPenaltyRecord();
					$JadwalPenaltyRecord->idjadwal = $JadwalRecord->id;
					$JadwalPenaltyRecord->payroll_id = $row->stHadir;
					$JadwalPenaltyRecord->save();
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
								$interval  = abs($datetime2 - $datetime1);
								$minutes   = round($interval / 60);
								$sqlSub = "SELECT * FROM tbm_payrol WHERE attendance_id = '4' AND $minutes BETWEEN time1 AND time2 ORDER BY globaldistribusi ASC ";
								$sub=$this->queryAction($sqlSub,'S');
								foreach($sub as $s)
								{
									$idPayroll = $s['id'];
									$JadwalPenaltyRecord = new JadwalPenaltyRecord();
									$JadwalPenaltyRecord->idjadwal = $JadwalRecord->id;
									$JadwalPenaltyRecord->payroll_id = $idPayroll;
									$JadwalPenaltyRecord->save();
								}
							}
						}
								
						if($row->wktOut != '')
						{
							$JadwalRecord->st = '2';
							$JadwalRecord->pulang = $row->wktOut;
							
							$jadwalPulangAbsen = $JadwalRecord->tanggal.' '.$JadwalRecord->ahir;
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
							}
							
						}
					
						$JadwalRecord->save();
					}
				}
			}
			
			$tblBody = $this->BindGrid();
			
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("Absensi Karyawan Telah Disimpan");
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						unloadContent();
						BindGrid();');	
		
	}
	
	public function clearForm()
	{
	}
	
	public function cetakClicked()
	{
		$this->Response->redirect($this->Service->constructUrl('Hrd.cetakJadwalPerKaryawanPdf',array(
					"id"=>$this->DDKaryawan->SelectedValue,
					"bulan"=>$this->DDBulan->SelectedValue,
					"tahun"=>$this->DDTahun->SelectedValue)));
	}
}
?>
