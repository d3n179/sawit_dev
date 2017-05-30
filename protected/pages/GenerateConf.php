<?php
class GenerateConf extends MainConf
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
			$result = $this->select2DataList();
				
			echo json_encode($result);
			exit();
		}
	}
	
	public function select2DataList()
	{
        $Tablename = $this->Request['table_name'];
        $DataProvider = new DataProvider();

        if(isset($this->Request['page_limit']))
        {
            $DataProvider->LimitStatus = true;
            $DataProvider->PageSize = $this->Request['page_limit'];
        }

        if(isset($this->Request['page_number']))
            $DataProvider->PageNum = $this->Request['page_number']-1;

        if(isset($this->Request['field_id']) && trim($this->Request['field_id'])!='')
            $fieldId = $this->Request['field_id'];
        else
            $fieldId = $Tablename.'.id';

        if(isset($this->Request['field_name']) && trim($this->Request['field_name'])!='')
            $fieldName = $this->Request['field_name'];
        else
            $fieldName = $Tablename.'.name';

        if(isset($this->Request['field_groupby']) && trim($this->Request['field_groupby'])!='')
        {
            $exp = explode('.',$this->Request['field_groupby']);
            $GroupBy = (count($exp)>1)?$this->Request['field_groupby']:$Tablename.'.'.$this->Request['field_groupby'];
        }
        else
            $GroupBy = $fieldId;

        if(isset($this->Request['field_sortby']) && trim($this->Request['field_sortby'])!='')
            $SortExpression = $this->Request['field_sortby'];
        else
            $SortExpression = $Tablename.'.name ASC';

        $DataProvider->Tablename = $Tablename;

        if(isset($this->Request['field_id']) && trim($this->Request['field_id'])!='')
            $DataProvider->SelectField = $this->Request['field_id']." AS id, $fieldName AS text";
        else
        {
            $DataProvider->SelectField = "$Tablename.id, $fieldName AS text";
            $DataProvider->Filter[] = array('filterdatafield'=>$Tablename.'.deleted','filtercondition'=>'EQUAL','filtervalue'=>"0",'filteroperator'=>'0');
        }

        if(is_array($this->Request['field_additional']) && count($this->Request['field_additional'])>0)
        {
            foreach($this->Request['field_additional'] as $row)
            {
                $field_additional[]= $row;
            }

            $DataProvider->SelectField .= ",".implode(",",$field_additional);
        }

        if($this->Request['field_join'])
            $DataProvider->SelectJoinField = $this->Request['field_join'];
        else
            $DataProvider->SelectJoinField = "";

        if($this->Request['table_join'])
            $DataProvider->ClauseJoinField = $this->Request['table_join'];
        else
            $DataProvider->ClauseJoinField = "";

        if($this->Request['field_having'])
            $DataProvider->Having = $this->Request['field_having'];
        else
            $DataProvider->Having = "";

        $DataProvider->GroupBy = "$GroupBy";
        $DataProvider->SortExpression = "$SortExpression";


        //$DataProvider->Filter[] = array('filterdatafield'=>$Tablename.'.deleted','filtercondition'=>'EQUAL','filtervalue'=>"0",'filteroperator'=>'0');

        if(isset($this->Request['id']) && trim($this->Request['id'])!='' && $this->Request['multiple']=="false")
            $DataProvider->Filter[] = array('filterdatafield'=>$fieldId,'filtercondition'=>'EQUAL','filtervalue'=>$this->Request['id'],'filteroperator'=>'0');
        elseif(isset($this->Request['id']) && trim($this->Request['id'])!='' && $this->Request['multiple']=="true")
            $DataProvider->Filter[] = array('filterdatafield'=>$fieldId,'filtercondition'=>'IN','filtervalue'=>$this->Request['id'],'filteroperator'=>'0');

        if(isset($this->Request['q']) && trim($this->Request['q'])!='')
            $DataProvider->Filter[] = array('filterdatafield'=>$fieldName,'filtercondition'=>'CONTAINS','filtervalue'=>$this->Request['q'],'filteroperator'=>'0');

        if(is_array($this->Request['custom_query']) && count($this->Request['custom_query'])>0)
        {
            foreach($this->Request['custom_query'] as $row)
            {
                if($row[3])
                    $filteroperator = $row[3];
                else
                    $filteroperator = '0';

                if($row[4])
                    $filtermysqlescapedisable = $row[4];
                else
                    $filtermysqlescapedisable = '0';

                if($row[5])
                    $filtervaluestring = $row[5];
                else
                    $filtervaluestring = '0';

                $DataProvider->Filter[] = array('filterdatafield'=>$row[0],'filtercondition'=>$row[1],'filtervalue'=>$row[2],'filteroperator'=>$filteroperator,'filtermysqlescapedisable'=>$filtermysqlescapedisable,'filtervaluestring'=>$filtervaluestring);
            }
        }

        if($this->Request['sql_union']!='false' && $this->Request['sql_union']!='')
            $DataProvider->UnionSql = $this->Request['sql_union'];

        $data = $DataProvider->getDataArr();

        return $data;
        die();
	}
	
			
}
?>
