<?PHP
class IncentiveTransaction extends MainConf
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
					tbt_incentive.id,
					tbm_karyawan.nama AS karyawan,
					tbt_incentive.bulan ,
					tbt_incentive.tahun,
					tbt_incentive.jml_incentive
				FROM
					tbt_incentive
				INNER JOIN tbm_karyawan ON tbm_karyawan.id = tbt_incentive.id_karyawan
				WHERE
					tbt_incentive.deleted = '0'
				ORDER BY 
					tbt_incentive.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['karyawan'].'</td>';
				$tblBody .= '<td>'.$this->namaBulan($row['bulan']).'</td>';
				$tblBody .= '<td>'.$row['tahun'].'</td>';
				$tblBody .= '<td>'.number_format($row['jml_incentive'],2,'.','.').'</td>';
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
		$Record = IncentiveRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Incentive';
			$this->idIncentive->Value = $id;
			$this->DDKaryawan->SelectedValue = $Record->id_karyawan;
			$this->DDBulan->SelectedValue = $Record->bulan;
			$this->DDTahun->SelectedValue = $Record->tahun;
			$this->jml_incentive->Text = $Record->jml_incentive;
			
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
		$Record = IncentiveRecord::finder()->findByPk($id);
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
		if($this->idIncentive->Value == '')
		{
			$Record = IncentiveRecord::finder()->find('id_karyawan = ? AND bulan = ? AND tahun = ? ',$this->DDKaryawan->SelectedValue,$this->DDBulan->SelectedValue,$this->DDTahun->SelectedValue);
			if($Record)
				$stFind = '1';
			else
				$stFind = '0';
		}
		else
			$stFind = '0';
		
		if($stFind == '0')
		{
			if($this->idIncentive->Value != '')
			{
				$Record = IncentiveRecord::finder()->findByPk($this->idIncentive->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new IncentiveRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$Record->id_karyawan = $this->DDKaryawan->SelectedValue;
			$Record->bulan = $this->DDBulan->SelectedValue;
			$Record->tahun = $this->DDTahun->SelectedValue;
			$Record->jml_incentive = $this->jml_incentive->Text;
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
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.error("Incentive Untuk Karyawan ini pada bulan dan tahun yang sama sudah dimasukkan sebelumnya !");');	
		}
		
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
