<?PHP
class LemburKaryawan extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$sqlKaryawan = "SELECT id, nama FROM tbm_karyawan WHERE deleted ='0' ";
			$arrKaryawan = $this->queryAction($sqlKaryawan,'S');
			$this->DDKaryawan->DataSource = $arrKaryawan;
			$this->DDKaryawan->DataBind();
			
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
					tbt_lembur_karyawan.id,
					tbm_karyawan.nama AS karyawan,
					tbt_lembur_karyawan.tgl ,
					tbt_lembur_karyawan.jns_lembur,
					tbt_lembur_karyawan.lama_lembur
				FROM
					tbt_lembur_karyawan
				INNER JOIN tbm_karyawan ON tbm_karyawan.id = tbt_lembur_karyawan.id_karyawan
				WHERE
					tbt_lembur_karyawan.deleted = '0'
				ORDER BY 
					tbt_lembur_karyawan.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
				if($row['jns_lembur'] == '1')
					$jnsLembur = 'LPP';
				elseif($row['jns_lembur'] == '2')
					$jnsLembur = 'LPPML';
				elseif($row['jns_lembur'] == '3')
					$jnsLembur = 'LPPLK';
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['karyawan'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl'],'3').'</td>';
				$tblBody .= '<td>'.$jnsLembur.'</td>';
				$tblBody .= '<td>'.$row['lama_lembur'].' Jam</td>';
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
		$Record = LemburKaryawanRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Lembur Karyawan';
			$this->idLemburKaryawan->Value = $id;
			$this->DDKaryawan->SelectedValue = $Record->id_karyawan;
			$this->tgl_lembur->Text = $this->ConvertDate($Record->tgl,'1');
			$this->DDJenisLembur->SelectedValue = $Record->jns_lembur;
			$this->lama_lembur->Text = $Record->lama_lembur;
			
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
		$Record = LemburKaryawanRecord::finder()->findByPk($id);
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
			if($this->idLemburKaryawan->Value != '')
			{
				$Record = LemburKaryawanRecord::finder()->findByPk($this->idLemburKaryawan->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new LemburKaryawanRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$Record->id_karyawan = $this->DDKaryawan->SelectedValue;
			$Record->tgl = $this->ConvertDate($this->tgl_lembur->Text,'2');
			$Record->jns_lembur = $this->DDJenisLembur->SelectedValue;
			$Record->lama_lembur = $this->lama_lembur->Text;
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
	
	public function cetakClicked()
	{
		$this->Response->redirect($this->Service->constructUrl('Hrd.cetakSanksiTransactionPdf'));
	}
}
?>
