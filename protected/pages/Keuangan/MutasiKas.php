<?PHP
class MutasiKas extends MainConf
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
			
			$sql = "SELECT id,nama FROM tbm_bank WHERE deleted !='1' ";
			$this->id_bank_asal->DataSource = $this->queryAction($sql,'S');
			$this->id_bank_asal->DataBind();
			
			$sql = "SELECT id,nama FROM tbm_bank WHERE deleted !='1' ";
			$this->id_bank_tujuan->DataSource = $this->queryAction($sql,'S');
			$this->id_bank_tujuan->DataBind();
			
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','jQuery("#table-1 tbody").append("'.$tblBody.'");');
		}
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_mutasi_kas.id,
					tbt_mutasi_kas.tgl_transaksi,
					tbt_mutasi_kas.no_referensi,
					a.nama AS nama_bank_asal,
					b.nama AS nama_bank_tujuan,
					tbt_mutasi_kas.deskripsi,
					tbt_mutasi_kas.jumlah_mutasi,
					tbt_mutasi_kas.biaya_admin,
					tbt_mutasi_kas.total_mutasi,
					tbt_mutasi_kas.deleted
				FROM
					tbt_mutasi_kas
				INNER JOIN tbm_bank a ON a.id = tbt_mutasi_kas.id_bank_asal
				INNER JOIN tbm_bank b ON b.id = tbt_mutasi_kas.id_bank_tujuan
				WHERE
					tbt_mutasi_kas.deleted = '0'
				ORDER BY 
					tbt_mutasi_kas.id ASC ";
		$arr = $this->queryAction($sql,'S');
		
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($arr as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_transaksi'],'3').'</td>';
				$tblBody .= '<td>'.$row['no_referensi'].'</td>';
				$tblBody .= '<td>'.$row['nama_bank_asal'].'</td>';
				$tblBody .= '<td>'.$row['nama_bank_tujuan'].'</td>';
				$tblBody .= '<td>'.number_format($row['jumlah_mutasi'],2,".",",").'</td>';
				$tblBody .= '<td>'.number_format($row['biaya_admin'],2,".",",").'</td>';
				$tblBody .= '<td>'.number_format($row['total_mutasi'],2,".",",").'</td>';
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
		if($this->idMutasi->Value != '')
			$Record = MutasiKasRecord::finder()->findByPk($this->idMutasi->Value);
		else
		{
			$Record = new MutasiKasRecord();
		}
		
		$Record->tgl_transaksi = $this->ConvertDate($this->tgl_transaksi->Text,'2');
		$Record->no_referensi = $this->no_referensi->text;
		$Record->id_bank_asal = $this->id_bank_asal->SelectedValue;
		$Record->id_bank_tujuan = $this->id_bank_tujuan->SelectedValue;
		$Record->deskripsi = $this->deskripsi->text;
		$Record->jumlah_mutasi = str_replace(",","",$this->jumlah_mutasi->Text);
		$Record->biaya_admin = str_replace(",","",$this->biaya_admin->Text);
		$Record->total_mutasi = str_replace(",","",$this->total_mutasi->Text);
		$Record->save();
		
		$this->InsertJurnalBukuBesar($Record->id,
										'6',
										'0',
										$Record->id,
										$Record->tgl_transaksi,
										date("G:i:s"),
										'2',
										$Record->id_bank_tujuan,
										$Record->deskripsi,
										$Record->total_mutasi);
		
		$this->InsertJurnalBukuBesar($Record->id,
										'6',
										'1',
										$Record->id,
										$Record->tgl_transaksi,
										date("G:i:s"),
										'2',
										$Record->id_bank_asal,
										$Record->deskripsi,
										$Record->total_mutasi);
										
		/*$this->InsertLabaRugi($Record->id,
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
								$Record->transaction_no);
									
		$this->InsertJurnalUmum($Record->id,
									'6',
									'1',
									$Record->tgl_transaksi,
									date("G:i:s"),
									$Record->deskripsi,
									$Record->total_revenue,
									$Record->transaction_no);*/
															
		$tblBody = $this->BindGrid();
		$this->idMutasi->Value = "";	
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
