<?PHP
class MasterCoa extends MainConf
{

	public function onLoadComplete($param)
	{
		parent::onLoadComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			//$this->cariBtnClicked($sender,$param);
			if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
			{
				
			}
		}
		
	}
	
	public function onPreRender($param)
	{
		parent::onPreRender($param);
		
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			
			$this->bindGroupCoa();
			$this->bindTreeList();
		}
	}
	
	public function bindTreeList()
	{
		$sql = "SELECT
						b.id AS id_table,
						b.kode_coa AS id,
						b.id_group_coa AS pId,
					IF(b.id_group_coa = '0','0',a.id) AS id_parent_table,
						CONCAT(
							b.kode_coa,
							' - ',
							b.nama
						) AS `name`,
						b.nama,

					IF (
						b.id_group_coa = '0',
						'true',
						'false'
					) AS OPEN
					FROM
						tbm_coa b
					LEFT JOIN tbm_coa a ON a.kode_coa = b.id_group_coa
					WHERE
						b.deleted = '0'";
			$arrMenu = array();
			$arrMenu[] = array("id_table"=>"0","id"=>"0","id_parent_table"=>"0","pId"=>"-1","name"=>"ROOT","nama"=>"ROOT","open"=>true);
			foreach($this->queryAction($sql,'S') as $row)
			{
				$arrMenu[] = array("id_table"=>$row['id_table'],"id"=>$row['id'],"id_parent_table"=>$row['id_parent_table'],"pId"=>$row['pId'],"name"=>utf8_encode($row['name']),"nama"=>utf8_encode($row['nama']),"open"=>$row['OPEN']);
			}
		
			$this->menuList->Value = json_encode($arrMenu,true);
	}
	
	public function bindGroupCoa($sender,$param)
	{
		$sqlGroup = "SELECT id,CONCAT(kode_coa,' - ',nama) AS nama FROM tbm_coa WHERE deleted ='0' ";
			
			$arrGroup[] = array("id"=>"0","nama"=>"--ROOT--"); 
			foreach($this->queryAction($sqlGroup,'S') as $row)
			{
				$arrGroup[] = array("id"=>$row['id'],"nama"=>utf8_encode($row['nama'])); 	
			}
			//$arrGroup = $this->queryAction($sqlGroup,'S');
			
			$this->DDGroup->DataSource = $arrGroup;
			$this->DDGroup->DataBind();
	}
	
	public function selectGroupCoa($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$this->DDGroup->SelectedValue = $id;
	}
	
	public function submitBtnClicked()
	{
		
		$nama = trim($this->nama->Text);
		$kodeCoa = trim($this->kodeCoa->Text);
		$groupCoa = $this->DDGroup->SelectedValue;
			if($this->idCoa->Value != '')
			{
				$Record = CoaRecord::finder()->findByPk($this->idCoa->Value);
				$msg = "Data Berhasil Diedit";
				$st = '1';
			}
			else
			{
				$Record = new CoaRecord();
				$msg = "Data Berhasil Disimpan";
				$st = '0';
			}
			
			$Record->nama = $nama;
			
			if($groupCoa != '0')
				$id_group_coa = CoaRecord::finder()->findByPk($groupCoa)->kode_coa;
			else
				$id_group_coa = '0';
				
			$Record->id_group_coa = $id_group_coa;
			$Record->kode_coa = $kodeCoa;
			$Record->save(); 
			$id = $Record->kode_coa;
			$id_table = $Record->id;
			$pId = $Record->id_group_coa;
			$id_parent_table = $groupCoa;
			var_dump($id_parent_table);
			$this->idCoa->Value = '';
			$this->nama->Text = '';
			$this->kodeCoa->Text = '';
			$this->DDGroup->SelectedValue = 'empty';
			$this->bindTreeList();
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("'.$msg.'");
						jQuery("#modal-1").modal("hide");
						BindTreeView(); ');	
	}
	
	public function DeleteData($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$Record = CoaRecord::finder()->findByPk($id);
		$Record->deleted = '1';
		$Record->save();
		
		$this->bindTreeList();
		$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("Data Berhasil Dihapus !");
						BindTreeView(); ');	
	}
}
?>
