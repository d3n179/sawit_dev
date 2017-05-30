<?PHP
class MenuAdmin extends MainConf
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
			$sql = "SELECT id,nama FROM tbm_menu WHERE deleted = '0' AND (link = '' OR link IS NULL)";
			$this->parent_id->DataSource = $this->queryAction($sql,'S');
			$this->parent_id->DataBind();
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','jQuery("#table-1 tbody").append("'.$tblBody.'");');
		}
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbm_menu.id,
					a.nama AS parent_name,
					tbm_menu.`nama`,
					tbm_menu.link,
					tbm_menu.deleted
				FROM
					tbm_menu
				LEFT JOIN tbm_menu a ON a.id = tbm_menu.parent_id
				WHERE
					tbm_menu.deleted = '0'
				ORDER BY
					tbm_menu.parent_id ASC ";
		$arr = $this->queryAction($sql,'S');
		
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($arr as $row)
			{
				if($row['parent_name'] == '')
					$parentName = "ROOT DIRECTORY";
				else
					$parentName = $row['parent_name'];
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$parentName.'</td>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$row['link'].'</td>';
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
		$Record = MenuRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->idMenu->Value = $id;
			$this->parent_id->SelectedValue = $Record->parent_id;
			$this->nama->text = $Record->nama;
			$this->link->text = $Record->link;
			$this->icon->Value = $Record->icon;
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					jQuery("#iconPreview").find("i").removeClass().addClass("'.$Record->icon.'");
					jQuery("a[href=\"#formTab\"]").tab("show").empty().append("<i class=\"fa fa-pencil\"></i> Edit");
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
		$Record = MenuRecord::finder()->findByPk($id);
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
		if($this->idMenu->Value != '')
			$Record = MenuRecord::finder()->findByPk($this->idMenu->Value);
		else
			$Record = new MenuRecord();
		
		$Record->parent_id = $this->parent_id->SelectedValue;
		$Record->nama = $this->nama->text;
		$Record->link = $this->link->text;
		$Record->icon = $this->icon->value;
		$Record->save();
		
		$tblBody = $this->BindGrid();
			
		$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("Data Berhasil Disimpan");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						jQuery("a[href=\"#listTab\"]").tab("show");
						BindGrid();');	
		
		
	}
	
}
?>
