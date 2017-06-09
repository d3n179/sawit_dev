<?PHP
class ShiftSetting extends MainConf
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
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#table-1 tbody").append("'.$tblBody.'");');	
		}
	}
	
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbm_shift_setting.id,
					tbm_shift_setting.shif,
					tbm_shift_setting.datang,
					tbm_shift_setting.pulang,
					tbm_shift_setting.lama,
					tbm_shift_setting.waktumakan,
					tbm_shift_setting.waktumakanselesai
				FROM
					tbm_shift_setting
				WHERE
					tbm_shift_setting.deleted = '0'
				ORDER BY 
					tbm_shift_setting.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['shif'].'</td>';
				$tblBody .= '<td>'.$row['datang'].'</td>';
				$tblBody .= '<td>'.$row['pulang'].'</td>';
				$tblBody .= '<td>'.$row['lama'].'</td>';
				$tblBody .= '<td>'.$row['waktumakan'].' - '.$row['waktumakanselesai'].'</td>';
				$tblBody .= '<td>';
				$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
				$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';	
				$tblBody .=	'</td>';			
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = '';
		}
		
		return 	$tblBody;
	}
	
	public function editForm($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$Record = ShiftSettingRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Shift Setting';
			$this->idShift->Value = $id;
			$this->shift->Text = $Record->shif;
			$this->datang->Text = $Record->datang;
			$this->pulang->Text = $Record->pulang;
			$this->waktumakan->Text = $Record->waktumakan;
			$this->waktumakanselesai->Text = $Record->waktumakanselesai;
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					jQuery("#modal-1").modal("show");
					');	
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					toastr.error("Data Tidak Ditemukan");
					');	
		}
	}
	
	public function deleteData($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$Record = ShiftSettingRecord::finder()->findByPk($id);
		if($Record)
		{
			$Record->deleted = '1';
			$Record->save();
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
					('','
					toastr.info("Data Telah Dihapus");
					jQuery("#table-1").dataTable().fnDestroy();
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					BindGrid();
					unloadContent();
					');
		}
		else
		{
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					toastr.error("Data gagal Dihapus");
					');
		}
	}
	
	public function submitBtnClicked($sender,$param)
	{
			if($this->idShift->Value != '')
			{
				$Record = ShiftSettingRecord::finder()->findByPk($this->idShift->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new ShiftSettingRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$Record->shif = $this->shift->Text;
			$Record->datang = $this->datang->Text;
			$Record->pulang = $this->pulang->Text;
			$Record->waktumakan = $this->waktumakan->Text;
			$Record->waktumakanselesai = $this->waktumakanselesai->Text;
			$lamaMakan = $this->get_time_difference($this->waktumakan->Text.":00",$this->waktumakanselesai->Text.":00");
			$Record->lama = ($this->get_time_difference($this->datang->Text.":00",$this->pulang->Text.":00")) - $lamaMakan;
			$Record->save(); 
			
			$tblBody = $this->BindGrid();
			
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("'.$msg.'");
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						clearForm();
						BindGrid();');	
		
	}
	
	public function clearForm()
	{
	}
	
}
?>
