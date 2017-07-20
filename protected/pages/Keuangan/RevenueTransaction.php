<?PHP
class RevenueTransaction extends MainConf
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
			
			$sql = "SELECT id,nama FROM tbm_bank WHERE deleted !='1' ";
			$this->DDBank->DataSource = $this->queryAction($sql,'S');
			$this->DDBank->DataBind();
			
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','jQuery("#table-1 tbody").append("'.$tblBody.'");');
		}
	}
	
	public function revenueCategoryChanged()
	{
		$idCategoryRevenue = $this->DDCategory->SelectedValue;
		
		if($idCategoryRevenue != '')
		{
			$sql = "SELECT id,nama FROM tbm_revenue WHERE deleted = '0' AND revenue_category_id = '$idCategoryRevenue' ";
			$this->DDRevenue->DataSource = $this->queryAction($sql,'S');
			$this->DDRevenue->DataBind();
			$this->DDRevenue->Enabled = true;
		}
		else
		{
			$this->DDRevenue->SelectedValue = 'empty';
			$this->DDRevenue->Enabled = false;
		}
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_revenue_transaction.id,
					tbt_revenue_transaction.transaction_no,
					tbt_revenue_transaction.tgl_transaksi,
					tbt_revenue_transaction.no_referensi,
					tbm_revenue.nama AS nama_revenue,
					tbt_revenue_transaction.deskripsi,
					tbm_bank.nama AS nama_bank,
					tbt_revenue_transaction.total_revenue,
					tbt_revenue_transaction.deleted
				FROM
					tbt_revenue_transaction
				INNER JOIN tbm_revenue ON tbm_revenue.id = tbt_revenue_transaction.revenue_id
				INNER JOIN tbm_bank ON tbm_bank.id = tbt_revenue_transaction.bank_id
				WHERE
					tbt_revenue_transaction.deleted = '0'
				ORDER BY 
					tbt_revenue_transaction.id ASC ";
		$arr = $this->queryAction($sql,'S');
		
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($arr as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['transaction_no'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_transaksi'],'3').'</td>';
				$tblBody .= '<td>'.$row['no_referensi'].'</td>';
				$tblBody .= '<td>'.$row['nama_revenue'].'</td>';
				$tblBody .= '<td>'.$row['nama_bank'].'</td>';
				$tblBody .= '<td>'.number_format($row['total_revenue'],2,".",",").'</td>';
				/*$tblBody .= '<td>';
				$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
				$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';	
				$tblBody .=	'</td>';	*/	
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
		$Record = RevenueTransactionRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->idRevenueTransaction->Value = $id;
			$this->tgl_transaksi->Text = $this->ConvertDate($Record->tgl_transaksi,'1');
			$this->no_referensi->text = $Record->no_referensi;
			$this->DDCategory->SelectedValue = $Record->revenue_category_id;
			$this->revenueCategoryChanged();
			$this->DDRevenue->SelectedValue = $Record->revenue_id;
			$this->deskripsi->Text = $Record->deskripsi;
			$this->DDBank->SelectedValue = $Record->bank_id;
			$this->total_revenue->text = $Record->total_revenue;
			$this->DDCoa->text = $Record->coa_id;
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					bindSelect2();
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
		$Record = RevenueTransactionRecord::finder()->findByPk($id);
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
		if($this->idRevenueTransaction->Value != '')
			$Record = RevenueTransactionRecord::finder()->findByPk($this->idRevenueTransaction->Value);
		else
		{
			$Record = new RevenueTransactionRecord();
			$Record->transaction_no = $this->GenerateNoDocument('REV');
		}
		
		$Record->tgl_transaksi = $this->ConvertDate($this->tgl_transaksi->Text,'2');
		$Record->no_referensi = $this->no_referensi->text;
		$Record->revenue_category_id = $this->DDCategory->SelectedValue;
		$Record->revenue_id = $this->DDRevenue->SelectedValue;
		$Record->deskripsi = $this->deskripsi->text;
		$Record->bank_id = $this->DDBank->SelectedValue;
		$Record->total_revenue = str_replace(",","",$this->total_revenue->text);
		$Record->coa_id = $this->DDCoa->text;
		$Record->save();
		
		$this->InsertJurnalBukuBesar($Record->id,
										'5',
										'0',
										$Record->transaction_no,
										$Record->tgl_transaksi,
										date("G:i:s"),
										$Record->coa_id,
										$Record->bank_id,
										$Record->deskripsi,
										$Record->total_revenue);
		
		$this->InsertLabaRugi($Record->id,
								'5',
								'0',
								$Record->tgl_transaksi,
								date("G:i:s"),
								$Record->deskripsi,
								$Record->total_revenue,
								$Record->transaction_no);
		
		$this->InsertJurnalUmum($Record->id,
								'6',
								'0',
								$Record->tgl_transaksi,
								date("G:i:s"),
								'Kas',
								$Record->total_revenue,
								$Record->transaction_no,
								$Record->bank_id);
									
		$this->InsertJurnalUmum($Record->id,
									'6',
									'1',
									$Record->tgl_transaksi,
									date("G:i:s"),
									$Record->deskripsi,
									$Record->total_revenue,
									$Record->transaction_no);
															
		$tblBody = $this->BindGrid();
		$this->idRevenueTransaction->Value = "";	
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
