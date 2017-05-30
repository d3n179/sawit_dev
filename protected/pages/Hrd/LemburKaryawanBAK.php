<?PHP
class LemburKaryawan extends MainConf
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
					$JadwalRecord = JadwalRecord::finder()->find('idkaryawan = ? AND tanggal = ? AND st_hadir = ? AND st = ?',$row['id'],$date,'0','2');
					if($JadwalRecord)
					{
						$idJadwal = $JadwalRecord->id;
						$disabled = '';
						$LemburRecord = LemburRecord::finder()->find('id_karyawan = ? AND id_jadwal = ? AND deleted = ? ',$row['id'],$idJadwal,'0');
						if($LemburRecord)
							$lamaLembur = $LemburRecord->lama_lembur;
						else
							$lamaLembur = '';
					}
					else
					{
						$idJadwal = '';
						$disabled = 'disabled';
						$lamaLembur = '';
					}
						
					$tblBody .= '<td>';
					$tblBody .= '<input size=\"3\" id=\"lembur-column-ID-'.$i.'-'.$row['id'].'\" tglJadwal=\"'.$date .'\" idKaryawan = \"'.$row['id'].'\" idjadwal = \"'.$idJadwal.'\" class=\"form-control input-xsmall input-xs lembur_column\" type=\"text\" value=\"'.$lamaLembur.'\" '.$disabled.'>';	
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
		$arrLembur = $param->CallbackParameter->arrLembur;
		foreach($arrLembur as $row)
		{
			$LemburRecord = LemburRecord::finder()->find('id_karyawan = ? AND id_jadwal = ?',$row->idKaryawan,$row->idJadwal);
			if(!$LemburRecord)
				$LemburRecord = new LemburRecord();
			
			$LemburRecord->id_karyawan = $row->idKaryawan;
			$LemburRecord->id_jadwal = $row->idJadwal;
			$LemburRecord->lama_lembur = $row->lamaLembur;
			$LemburRecord->tgl_lembur = $row->tglJadwal;
			$LemburRecord->save();
		}
			
		$tblArr = $this->BindGrid();
		$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("Lembur Karyawan Telah Disimpan !");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 thead").empty();
						jQuery("#table-1 thead").append("'.$tblArr[0].'");
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblArr[1].'");
						BindGrid();');
		
	}
	
	public function cetakClicked()
	{
		$this->Response->redirect($this->Service->constructUrl('Hrd.cetakLemburKaryawanXls',array(
					"bulan"=>$this->DDBulan->SelectedValue,
					"tahun"=>$this->DDTahun->SelectedValue)));
	}
	
}
?>
