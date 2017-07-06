<?PHP
class SaldoAwalBank extends MainConf
{

	public function onLoadComplete($param)
	{
		parent::onLoadComplete($param);
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
					tbm_bank.nama,
					tbm_bank.nama_pemilik,
					tbm_bank.no_rek,
					tbm_bank.saldo
				FROM
					tbm_bank
				WHERE
					tbm_bank.deleted != '1' ";
		$tblBody = '';
		$arr = $this->queryAction($sql,'S');
		if($arr)
		{
			foreach($arr as $row)
			{
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$row['no_rek'].'</td>';
				$tblBody .= '<td>'.$row['nama_pemilik'].'</td>';	
				$tblBody .= '<td><input size=\"16\" class=\"form-control input-xsmall input-xs saldo-column-ID-'.$row['id'].' saldo_column\" data-id=\"'.$row['id'].'\" type=\"text\" value=\"'.$row['saldo'].'\" ></td>';	
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = '';
		}
		
		return $tblBody;
	}
	
	public function postingClicked($sender,$param)
	{
		$ModalTransaksiRecord = ModalTransaksiRecord::finder()->findByPk('1');
		
		if(!$ModalTransaksiRecord)
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					toastr.error("Saldo Awal Bank Belum Dimasukkan !");
					unloadContent();
					');
		}
		else
		{
			if($ModalTransaksiRecord->st_modal == '1')
			{
				$this->getPage()->getClientScript()->registerEndScript
					('','
					toastr.error("Modal Awal Sudah Diposting Sebelumnya !");
					unloadContent();
					');
			}
			else
			{
					$ModalTransaksiRecord->st_modal = '1';
					$ModalTransaksiRecord->save();
					
					$sql = "SELECT
							tbm_bank.id,
							tbm_bank.nama,
							tbm_bank.nama_pemilik,
							tbm_bank.no_rek,
							tbm_bank.saldo
						FROM
							tbm_bank
						WHERE
							tbm_bank.deleted != '1' ";
					$arr = $this->queryAction($sql,'S');
					foreach($arr as $row)
					{
						$this->InsertJurnalBukuBesar($row['id'],
												'0',
												'0',
												$row['id'],
												date("Y-m-d"),
												date("G:i:s"),
												'2',
												$row['id'],
												'Saldo Awal',
												$row['saldo']);
					}
				
				$this->InsertLabaRugi($ModalTransaksiRecord->id,
										'0',
										'0',
										date("Y-m-d"),
										date("G:i:s"),
										"Saldo Awal",
										$ModalTransaksiRecord->modal,
										$ModalTransaksiRecord->id);
				
				$this->InsertJurnalUmum($ModalTransaksiRecord->id,
										'0',
										'0',
										date("Y-m-d"),
										date("G:i:s"),
										'Kas',
										$ModalTransaksiRecord->modal,
										$ModalTransaksiRecord->id);
											
				$this->InsertJurnalUmum($ModalTransaksiRecord->id,
											'0',
											'1',
											date("Y-m-d"),
											date("G:i:s"),
											'Modal Awal',
											$ModalTransaksiRecord->modal,
											$ModalTransaksiRecord->id);
											
					$this->getPage()->getClientScript()->registerEndScript
							('','
							toastr.info("Modal Awal Berhasil Diposting !");
							unloadContent();
							');
			}
		}
			
		
	}
	
	public function simpanBtnClicked($sender,$param)
	{
		$arr = $param->CallbackParameter->arr;
		$modalAwal = 0;
		
		$ModalTransaksiRecord = ModalTransaksiRecord::finder()->findByPk('1');
		if($ModalTransaksiRecord)
			$stPosting = $ModalTransaksiRecord->st_modal;
		else
			$stPosting = '0';
			
		if($stPosting == '0')
		{
			foreach($arr as $row)
			{
				$BankRecord = BankRecord::finder()->findByPk($row->id);
				if($BankRecord)
				{
					$BankRecord->saldo = $row->saldo;
					$BankRecord->save();
					$modalAwal +=  $row->saldo;
				}
			}
			
			$ModalTransaksiRecord = ModalTransaksiRecord::finder()->findByPk('1');
			
			if(!$ModalTransaksiRecord)
				$ModalTransaksiRecord = new ModalTransaksiRecord();
				
			$ModalTransaksiRecord->modal = $modalAwal;
			$ModalTransaksiRecord->save();
			
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("Saldo Awal Bank Berhasil Disimpan !");
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
						toastr.error("Saldo Awal Bank Tidak Bisa Disimpan karena modal awal sudah diposting !");
						unloadContent();
						');
		}
	}
	
	
}
?>
