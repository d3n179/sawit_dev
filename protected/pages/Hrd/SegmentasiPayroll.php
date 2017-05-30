<?PHP
class SegmentasiPayroll extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$sql = "SELECT id,
							nama 
					FROM 
							tbm_kategori_payroll ";
			$arr = $this->queryAction($sql,'S');
			$this->DDSubKategoriPayroll->DataSource = $arr;
			$this->DDSubKategoriPayroll->DataBind();
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
	
	public function subkategoriChanged()
	{
		$DDSubKategoriPayroll = $this->DDSubKategoriPayroll->SelectedValue;
				
		$this->keterangan->Enabled = false;
		$this->time_limit1->Enabled = false;
		$this->time_limit2->Enabled = false;
									
		if($DDSubKategoriPayroll == '4')
		{
			$this->DDDistribusi->SelectedValue = 'empty';
			$this->DDDistribusi->Enabled = true;
			$this->keterangan->Enabled = false;	
			$this->time_limit1->Enabled = false;
			$this->time_limit2->Enabled = false;
					
		}
		else
		{
			
			$this->keterangan->Enabled = true;		
			$this->DDDistribusi->Enabled = false;
			$this->time_limit1->Enabled = false;
			$this->time_limit2->Enabled = false;
		}
	}
	
	public function distribusiChanged()
	{
		$DDDistribusi = $this->DDDistribusi->SelectedValue;
				
		$this->keterangan->Enabled = false;
		$this->time_limit1->Enabled = false;
		$this->time_limit2->Enabled = false;
									
		if($DDDistribusi == '2' || $DDDistribusi == '3')
		{
			$this->keterangan->Enabled = true;
			$this->time_limit1->Enabled = false;
			$this->time_limit2->Enabled = false;
					
		}
		elseif($DDDistribusi == '4' || $DDDistribusi == '5')
		{
					
			$this->keterangan->Enabled = false;
			$this->time_limit1->Enabled = true;
			$this->time_limit2->Enabled = true;
		}
	}
	
	public function getPayrollData()
	{					
		$arr = array();
		$arr[] = array("id"=>"-1","text"=>"Self");
		$arr[] = array("id"=>"-2","text"=>"Loyalty");
		$arr[] = array("id"=>"-3","text"=>"Hari Kerja");
		$arr[] = array("id"=>"-4","text"=>"Kehadiran");
		$arr[] = array("id"=>"-5","text"=>"Level Distribusi");
		$arr[] = array("id"=>"-6","text"=>"UMK");
		$arr[] = array("id"=>"-7","text"=>"Office Revenue");
		$arr[] = array("id"=>"-8","text"=>"Jam Lembur");
		$arr[] = array("id"=>"-9","text"=>"UMP");
		$arr[] = array("id"=>"-10","text"=>"BPJS Distribusi");
		$arr[] = array("id"=>"-11","text"=>"Dinas Distribusi");
		$arr[] = array("id"=>"-12","text"=>"Sisa Cuti");
		
		$sql = "SELECT * FROM tbm_payrol WHERE deleted = '0' ";
		$arrSql = $this->queryAction($sql,'S');
		foreach($arrSql as $row)
		{
			$arr[] = array("id"=>$row['id'],"text"=>$row['globaldistribusi']);
		}
		
		$this->arrParameter->Value = json_encode($arr);
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
						tbm_payrol.id,

					IF (
						tbm_payrol.kategori = '1',
						'Pendapatan',
						'Potongan'
					) AS kategori,
					 tbm_kategori_payroll.nama AS subkategori,
					 tbm_payrol.globaldistribusi,
					 tbm_payrol.distribusi,
					 tbm_payrol.ket
					FROM
						tbm_payrol
					INNER JOIN tbm_kategori_payroll ON tbm_kategori_payroll.id = tbm_payrol.subkategori
					WHERE
						tbm_payrol.deleted = '0'
					ORDER BY
						tbm_payrol.id ASC";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
			
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['kategori'].'</td>';
				$tblBody .= '<td>'.$row['subkategori'].'</td>';
				$tblBody .= '<td>'.$row['globaldistribusi'].'</td>';
				$tblBody .= '<td>'.$row['distribusi'].'</td>';
				$tblBody .= '<td>'.$row['ket'].'</td>';
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
		$Record = PayrollRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Segementasi Payroll';
			$this->idPayroll->Value = $id;
			$this->DDKategoriPayroll->SelectedValue = $Record->kategori;
			$this->DDSubKategoriPayroll->SelectedValue = $Record->subkategori;
			$this->DistribusiLevel->Text = $Record->distribusi;
			$this->keterangan_global->Text = $Record->ket;
			$this->subkategoriChanged();
			
			if($Record->subkategori != '4')
			{
				$this->keterangan->text = $Record->globaldistribusi;
			}
			else
			{
				$this->DDDistribusi->SelectedValue = $Record->attendance_id;
				$this->distribusiChanged();
				
				if($Record->attendance_id == '2' || $Record->attendance_id == '3')
				{
					$this->keterangan->Text = $Record->globaldistribusi;
				}
				elseif($Record->attendance_id == '4' || $Record->attendance_id == '5')
				{
					$this->time_limit1->Text = $Record->time1;
					$this->time_limit2->Text = $Record->time2;
				}
			}
			
			$this->getPayrollData();
			$sqlDetail = "SELECT * FROM tbm_payroll_formula WHERE payroll_id ='".$Record->id."' AND deleted ='0' ORDER BY order_id";
			$arr = $this->queryAction($sqlDetail,'S');
			$arrJson = json_encode($arr,true);
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					subkategoriChanged();
					distribusiChanged();
					RenderTempTable('.$arrJson.');
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
		$Record = PayrollRecord::finder()->findByPk($id);
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
		$arrParameter = $param->CallbackParameter->PayrollParameterTable;
		
		if($this->idPayroll->Value != '')
		{
			$Record = PayrollRecord::finder()->findByPk($this->idPayroll->Value);
			$msg = "Data Berhasil Diedit";
		}
		else
		{
			$Record = new PayrollRecord();
			$msg = "Data Berhasil Disimpan";
		}
			
		$Record->kategori = $this->DDKategoriPayroll->SelectedValue;
		$Record->subkategori = $this->DDSubKategoriPayroll->SelectedValue;
		if($this->DDSubKategoriPayroll->SelectedValue == '4')
		{
			$Record->attendance_id = $this->DDDistribusi->SelectedValue;
			if($this->DDDistribusi->SelectedValue == '2' || $this->DDDistribusi->SelectedValue == '3')
			{
				$Record->globaldistribusi = $this->keterangan->Text;
			}
			elseif($this->DDDistribusi->SelectedValue == '4' || $this->DDDistribusi->SelectedValue == '5')
			{
				$Record->time1 = $this->time_limit1->Text;
				$Record->time2 = $this->time_limit2->Text;
				$Record->globaldistribusi = ($this->DDDistribusi->SelectedValue == '4' ? 'Terlambat' : 'Pulang Lebih Awal').' '.$this->time_limit1->Text.' - '.$this->time_limit2->Text.' Menit';
			}
			else
			{
				$Record->globaldistribusi = ($this->DDDistribusi->SelectedValue == '1' ? 'Alfa' : 'Lembur');
			}
		}
		else
		{
			$Record->globaldistribusi = $this->keterangan->Text;
		}
		
		$Record->distribusi = $this->DistribusiLevel->Text;
		$Record->ket = $this->keterangan_global->Text;
		$Record->save(); 
		$urutan = 1;
		foreach($arrParameter as $row)
		{
			if($row->id_edit != '')
				$RecordDetail = PayrollFormulaRecord::finder()->findByPk($row->id_edit);
			else
				$RecordDetail = new PayrollFormulaRecord();
				
			if($row->deleted != '1')
			{
				$RecordDetail->payroll_id = $Record->id;
				
				if($row->parameterId == '-1')
					$RecordDetail->parameter_id = $Record->id;
				else
					$RecordDetail->parameter_id = $row->parameterId;
					
				$RecordDetail->operator_id = $row->operatorId;
				$RecordDetail->order_id = $urutan;
				$urutan++;
			}
			else
			{
				$RecordDetail->deleted = '1';
			}
			
			$RecordDetail->save();
		}
		
		$tblBody = $this->BindGrid();
			
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("'.$msg.'");
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						BindGrid();
						clearForm();');	
		
	}
	
	public function clearForm()
	{
	}
	
}
?>
