<?PHP
class MasterBank extends MainConf
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
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','jQuery("#table-1 tbody").append("'.$tblBody.'");');
		}
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbm_bank.id,
					tbm_bank.`nama`,
					tbm_bank.no_rek,
					tbm_bank.nama_pemilik,
					tbm_bank.deleted
				FROM
					tbm_bank
				WHERE
					tbm_bank.deleted = '0'
				ORDER BY 
					tbm_bank.id ASC ";
		$arr = $this->queryAction($sql,'S');
		
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($arr as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$row['no_rek'].'</td>';
				$tblBody .= '<td>'.$row['nama_pemilik'].'</td>';
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
		$Record = BankRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->idBank->Value = $id;
			
			$this->nama->text = $Record->nama;
			$this->no_rek->text = $Record->no_rek;
			$this->nama_pemilik->Text = $Record->nama_pemilik;
			
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
		$Record = BankRecord::finder()->findByPk($id);
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
		if($this->idBank->Value != '')
			$Record = BankRecord::finder()->findByPk($this->idBank->Value);
		else
			$Record = new BankRecord();
		
		$Record->nama = strtoupper($this->nama->text);
		$Record->no_rek = $this->no_rek->text;
		$Record->nama_pemilik = ucwords($this->nama_pemilik->text);
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
	
	public function GenerateNoSales($bln,$thn,$tipeCommodity)
	{
		$query = "SELECT 
						id 
					FROM 
						tbt_contract_sales
					WHERE
					MONTH(tbt_contract_sales.tgl_kontrak) = '$bln'
					AND YEAR(tbt_contract_sales.tgl_kontrak) = '$thn' 
					AND commodity_type = '$tipeCommodity' ";
		$arr = $this->queryAction($query,'S');
		
		$count = count($arr) + 1;
		
		if($count < 10)
			$tmp = "0000";
		elseif($count < 100)
			$tmp = "000";	
		elseif($count < 1000)
			$tmp = "00";
		elseif($count < 10000)
			$tmp = "0";
		else
			$tmp = "";
		
		$blnrmw = $this->bulanRomawi($bln);
		
		if($tipeCommodity == '0')
			$noDoc = "CPO";
		else
			$noDoc = "PK";
					
		$noTrans = $tmp.$count."/PT.SH/".$noDoc."/".$blnrmw."/".$thn;
		
		return $noTrans;
	}
	
	public function cetakClicked($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$url = "index.php?page=Transaksi.cetakKontrakPenjualanPdf&idKontrak=".$id;
		$this->getPage()->getClientScript()->registerEndScript('',"
		jQuery('#cetakFrame').attr('src','".$url."')
		jQuery('#modal-2').modal('show');
		unloadContent();
		");
	}
}
?>
