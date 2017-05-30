<?PHP
class JadwalShiftKaryawan extends MainConf
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
			$sqlShift = "SELECT
								tbm_shift_setting.id,

							IF (
								tbm_shift_setting.datang != '00:00:00',
								CONCAT(
									tbm_shift_setting.datang,
									'-',
									tbm_shift_setting.pulang
								),
								tbm_shift_setting.ket
							) AS text
							FROM
								tbm_shift_setting
							WHERE
								tbm_shift_setting.deleted = '0' 
							ORDER BY tbm_shift_setting.id ASC";
			$arrShift = $this->queryAction($sqlShift,'S');
			$this->arrShift->Value = json_encode($arrShift,true);
			
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
			
			$this->DDBulan->SelectedValue = date('m');
			$this->DDTahun->SelectedValue = date('Y');
			
			$tblArr = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#table-1 thead").empty();
						jQuery("#table-1 thead").append("'.$tblArr[0].'");
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblArr[1].'");');
		}
	}
	
	public function jadwalChanged()
	{
		$tblArr = $this->BindGrid();
		$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 thead").empty();
						jQuery("#table-1 thead").append("'.$tblArr[0].'");
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblArr[1].'");
						BindGrid();
						unloadContent();');
	}
	
	public function BindGrid()
	{
		if($this->DDBulan->SelectedValue != 'empty' && $this->DDTahun->SelectedValue != 'empty')
		{
			$days = cal_days_in_month(CAL_GREGORIAN, $this->DDBulan->SelectedValue, $this->DDTahun->SelectedValue);
			$tblHeader = '';
			$tblHeader .= '<tr>';
			$i = 1;
			$tblHeader .= '<th style=\"width:300px\">Karyawan</th>';
			while($i <= $days)
			{
				$tblHeader .= '<th>'.$i.'</th>';
				$i++;
			}
			$tblHeader .= '</tr>';
			
			$sqlKaryawan = "SELECT id,nama FROM tbm_karyawan WHERE deleted = '0' ";
			$arr = $this->queryAction($sqlKaryawan,'S');
			$tblBody = '';
			foreach($arr as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$i = 1;
				
				while($i <= $days)
				{
					$date = $this->DDTahun->SelectedValue."-".$this->DDBulan->SelectedValue."-".$i;
					$JadwalRecord = JadwalRecord::finder()->find('idkaryawan = ? AND tanggal = ?',$row['id'],$date);
					if($JadwalRecord)
						$idShif = $JadwalRecord->shif;
					else
						$idShif = '';
						
					$tblBody .= '<td>';
					$tblBody .= '<input id=\"shift-column-ID-'.$i.'-'.$row['id'].'\" tglJadwal=\"'.$date .'\" idKaryawan = \"'.$row['id'].'\" class=\"form-control input-xsmall input-xs shift_column\" type=\"text\" value=\"'.$idShif.'\">';	
					$tblBody .=	'</td>';
					$i++;
				}
							
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblHeader = '<tr><th></th></tr>';
			$tblBody = '<tr><td></td></tr>';
		}
		
		return 	array($tblHeader,$tblBody);
	}
	
	
	public function submitBtnClicked($sender,$param)
	{
		$arrShift = $param->CallbackParameter->arrShif;
		foreach($arrShift as $row)
		{
			$JadwalRecord = JadwalRecord::finder()->find('idkaryawan = ? AND tanggal = ?',$row->idKaryawan,$row->tglJadwal);
			if(!$JadwalRecord)
				$JadwalRecord = new JadwalRecord();
			
			$ShiftSettingRecord = ShiftSettingRecord::finder()->findByPk($row->idShift);
			$JadwalRecord->idcab = 0;
			$JadwalRecord->idkaryawan = $row->idKaryawan;
			$JadwalRecord->tanggal = $row->tglJadwal;
			$JadwalRecord->shif = $row->idShift;
			$JadwalRecord->istirahat = $ShiftSettingRecord->waktumakan;
			$JadwalRecord->awal = $ShiftSettingRecord->datang;
			$JadwalRecord->ahir = $ShiftSettingRecord->pulang;
			$JadwalRecord->lama = $ShiftSettingRecord->lama; 
			$JadwalRecord->tglbuat = date('Y-m-d');
			$JadwalRecord->jambuat = date('G:i:s');
			$JadwalRecord->operator = $this->User->IsUser;
			$JadwalRecord->save();
		}
			
		$tblArr = $this->BindGrid();
		$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("Jadwal Shif Karyawan Telah Disimpan !");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 thead").empty();
						jQuery("#table-1 thead").append("'.$tblArr[0].'");
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblArr[1].'");
						BindGrid();');
		
	}
	
	public function cetakClicked()
	{
		$this->Response->redirect($this->Service->constructUrl('Hrd.cetakJadwalKaryawanXls',array(
					"bulan"=>$this->DDBulan->SelectedValue,
					"tahun"=>$this->DDTahun->SelectedValue)));
	}
	
}
?>
