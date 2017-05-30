<?PHP
class MasterRevenue extends MainConf
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
			$sql = "SELECT id,nama FROM tbm_revenue_category WHERE deleted = '0' ";
			$this->DDCategory->DataSource = $this->queryAction($sql,'S');
			$this->DDCategory->DataBind();
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','jQuery("#table-1 tbody").append("'.$tblBody.'");');
		}
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbm_revenue.id,
					tbm_revenue_category.nama AS kategori,
					tbm_revenue.`nama`,
					tbm_revenue.deleted
				FROM
					tbm_revenue
				INNER JOIN tbm_revenue_category ON tbm_revenue_category.id = tbm_revenue.revenue_category_id
				WHERE
					tbm_revenue.deleted = '0'
				ORDER BY 
					tbm_revenue.id ASC ";
		$arr = $this->queryAction($sql,'S');
		
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($arr as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['kategori'].'</td>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
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
		$Record = RevenueRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->idRevenue->Value = $id;
			$this->DDCategory->SelectedValue = $Record->revenue_category_id;
			$this->nama->text = $Record->nama;
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
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
		$Record = RevenueRecord::finder()->findByPk($id);
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
		if($this->idRevenue->Value != '')
			$Record = RevenueRecord::finder()->findByPk($this->idRevenue->Value);
		else
			$Record = new RevenueRecord();
		
		$Record->revenue_category_id = $this->DDCategory->SelectedValue;
		$Record->nama = strtoupper($this->nama->text);
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
