<?php
class loadCoa extends MainConf
{ 
	public function onPreInit ($param)
	{
		parent::onPreInit($param);
			
	}	
	
	public function onLoad($param)
	{
		parent::onLoad($param);
		
		if(!$this->IsPostBack && !$this->IsCallBack)  
		{
			
			$data = array();
			
			$kelompokCoa = $this->Request['kelompokCoa'];
			
			$sqlData = "SELECT
								tbm_coa.id,
								tbm_coa.id_group_coa,
								tbm_coa.kode_coa,
								tbm_coa.nama
							FROM
								tbm_coa
							WHERE
								tbm_coa.deleted = '0' ";
								
			if($kelompokCoa == 'EXPENSE')
			{
				$sqlData .= "AND (tbm_coa.kode_coa LIKE '5%' OR tbm_coa.kode_coa LIKE '6%' OR tbm_coa.kode_coa LIKE '7%') ";
			}
			elseif($kelompokCoa == 'REVENUE')
			{
				$sqlData .= "AND tbm_coa.kode_coa LIKE '4%' ";
			}
			$arrData = $this->queryAction($sqlData,'S');
			//var_dump($sqlData);
			/*$arrData = $this->queryAction($sqlData,'S');
			foreach($arrData as $row)
			{
				
				if($row['id_group_coa'] == '0')
				{
					$idParent = $row['kode_coa'];
					$data[] = array("id"=>$row['id'],"text"=>utf8_encode($row['nama']),"state"=>"closed","children"=>$this->buildCoa($arrData,$idParent));
				}
			}*/
			//$data = $this->buildCoa($arrData);
			//print_r($data);
			echo json_encode($this->buildCoa($arrData,0));
			exit();
		}
	}
	

	public function buildCoa($arrData,$idParent=0)
	{
		$data = array();
		
		foreach($arrData as $row)
		{
			if($row['id_group_coa'] == $idParent)
			{
				$search =  $this->arr_search($arrData,'id_group_coa',$row['kode_coa']);
				
				if(count($search) > 0 )
					$state = "closed";
				else
					$state = "open";
				
				$data[] = array("id"=>$row['id'],"text"=>utf8_encode($row['nama']),"state"=>$state,"children"=>$this->buildCoa($arrData,$row['kode_coa']));
			}
		}	
		
		return $data;
	}
	

	public function arr_search($array,$filterField,$filterValue)
	{
		$arr = array();
		foreach($array as $row)
		{
			if($row[$filterField] == $filterValue)
				$arr[] = array('id'=>$row['id']);
		}
		
		return $arr;
	}
}
?>
