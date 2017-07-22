<?PHP
class PembayaranGajiKaryawan extends MainConf
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
			$sql = "SELECT id, nama AS text FROM tbm_bank WHERE deleted != '1' ";
			$this->DDBank->DataSource = $this->queryAction($sql,'S');
			$this->DDBank->DataBind();
			
			$this->arrBank->Value = json_encode($this->queryAction($sql,'S'),true);
			
			$tblBody = $this->BindGrid();
			$tblBodyHistory = $this->BindGridHistory();
			$this->getPage()->getClientScript()->registerEndScript
						('','jQuery("#table-1 tbody").append("'.$tblBody.'");
							jQuery("#table-history tbody").append("'.$tblBodyHistory.'");');
		}
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_rekap_gaji.id,
					tbt_rekap_gaji.`status`,
					tbt_rekap_gaji.bulan,
					tbt_rekap_gaji.tahun,
					tbt_rekap_gaji.total_gaji_dibayarkan
				FROM
					tbt_rekap_gaji
				WHERE
					tbt_rekap_gaji.deleted = '0'
				ORDER BY
					tbt_rekap_gaji.bulan,
					tbt_rekap_gaji.tahun ASC";
		$arr = $this->queryAction($sql,'S');
		
		$count = count($arr);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($arr as $row)
			{
				
				$sqlBayar = "SELECT SUM(total_gaji_dibayarkan) AS total_gaji_dibayarkan FROM tbt_bayar_rekap_gaji WHERE tbt_bayar_rekap_gaji.id_rekap = '".$row['id']."' ";
				$arrBayar = $this->queryAction($sqlBayar,'S');
				if($row['bulan'] == '01')
					$nmBulan = "Januari";
				elseif($row['bulan'] == '02')
					$nmBulan = "Februari";
				elseif($row['bulan'] == '03')
					$nmBulan = "Maret";
				elseif($row['bulan'] == '04')
					$nmBulan = "April";
				elseif($row['bulan'] == '05')
					$nmBulan = "Mei";
				elseif($row['bulan'] == '06')
					$nmBulan = "Juni";
				elseif($row['bulan'] == '07')
					$nmBulan = "Juli";
				elseif($row['bulan'] == '08')
					$nmBulan = "Agustus";
				elseif($row['bulan'] == '09')
					$nmBulan = "September";
				elseif($row['bulan'] == '10')
					$nmBulan = "Oktober";
				elseif($row['bulan'] == '11')
					$nmBulan = "Novemver";
				elseif($row['bulan'] == '12')
					$nmBulan = "Desember";
			
				if($row['status'] == '0')
				{
					$status = '<div class=\"label label-secondary\">NEW</div>';
					$actionBtn = '<a href=\"javascript:void(0)\" class=\"btn btn-primary btn-sm btn-icon icon-left\" OnClick=\"prosesClicked('.$row['id'].')\"><i class=\"entypo-check\" ></i>Proses</a>&nbsp;&nbsp;';
				}
				elseif($row['status'] == '1')
				{
					$status = '<div class=\"label label-warning\">PARSIAL</div>';
					$actionBtn = '<a href=\"javascript:void(0)\" class=\"btn btn-primary btn-sm btn-icon icon-left\" OnClick=\"prosesClicked('.$row['id'].')\"><i class=\"entypo-check\" ></i>Proses</a>&nbsp;&nbsp;';
				}
				elseif($row['status'] == '2')
				{
					$status = '<div class=\"label label-warning\">DIBAYAR</div>';
					$actionBtn = '';
				}
				
				$sisaBayar = $row['total_gaji_dibayarkan'] - $arrBayar[0]['total_gaji_dibayarkan'];
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$status.'</td>';
				$tblBody .= '<td>'.$nmBulan.'</td>';
				$tblBody .= '<td>'.$row['tahun'].'</td>';
				$tblBody .= '<td>'.number_format($sisaBayar,2,".",",").'</td>';
				$tblBody .= '<td>'.$actionBtn.'</td>';		
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = '';
		}
		return 	$tblBody;
	}
	
	public function BindGridHistory()
	{
		$sql = "SELECT
					tbt_bayar_rekap_gaji.id,
					tbt_bayar_rekap_gaji.no_pembayaran,
					tbt_bayar_rekap_gaji.tgl_pembayaran,
					tbt_bayar_rekap_gaji.total_gaji_dibayarkan,
					tbt_bayar_rekap_gaji.user
				FROM
					tbt_bayar_rekap_gaji";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
				$actionBtn = '<a href=\"javascript:void(0)\" class=\"btn btn-primary btn-sm btn-icon icon-left\" OnClick=\"cetakClicked('.$row['id'].')\"><i class=\"entypo-print\" ></i>Cetak</a>&nbsp;&nbsp;';
				
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['no_pembayaran'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_pembayaran'],'3').'</td>';
				$tblBody .= '<td>'.number_format($row['total_gaji_dibayarkan'],2,'.',',').'</td>';	
				$tblBody .= '<td>'.$row['user'].'</td>';	
				$tblBody .= '<td>'.$actionBtn.'</td>';	
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
		$Record = RekapGajiRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->idRekapGaji->Value = $id;
			$sql = "SELECT
						tbt_rekap_gaji_detail.id,
						tbt_rekap_gaji_detail.id_karyawan,
						tbm_karyawan.nik,
						tbm_karyawan.nama,
						tbt_rekap_gaji_detail.jml_gaji_dibayarkan,

					IF (
						tbm_karyawan.norek = '',
						'0',
						'1'
					) AS jns_bayar,
					 tbm_karyawan.norek
					FROM
						tbt_rekap_gaji_detail
					INNER JOIN tbm_karyawan ON tbm_karyawan.id = tbt_rekap_gaji_detail.id_karyawan
					WHERE
						tbt_rekap_gaji_detail.`status` = '0'
					AND tbm_karyawan.deleted = '0'
					AND tbt_rekap_gaji_detail.id_rekap = '$id' ";
			
			$arr = $this->queryAction($sql,'S');
			
			$arrJson = json_encode($arr);
			$this->getPage()->getClientScript()->registerEndScript
					('','
						unloadContent();
						jQuery("a[href=\"#formTab\"]").tab("show").empty().append("<i class=\"fa fa-check\"></i> Proses Bayar : '.$Record->bulan.' - '.$Record->tahun.'");
						RenderTempTable('.$arrJson.');
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
	
	public function submitBtnClickedValid($sender,$param)
	{
		$this->getPage()->getClientScript()->registerEndScript
						('','submitBtnClicked();');	
		
	}
	
	public function submitBtnClicked($sender,$param)
	{
		$arrGaji = $param->CallbackParameter->GajiTable;
		
		var_dump($arrGaji);
		$data = 0;
		foreach($arrGaji as $row)
		{
			if($row->jnsBayar == '0')
				$data++;
			else
			{
				if($row->idBank != '' && $row->norek != '')
					$data++;	
			}
		}
		if($data > 0)
		{
			$BayarRekapGajiRecord = new BayarRekapGajiRecord();
			$BayarRekapGajiRecord->no_pembayaran = $this->GenerateNoDocument("RG");
			$BayarRekapGajiRecord->tgl_pembayaran = $this->ConvertDate($this->tgl_bayar->Text,'2');
			$BayarRekapGajiRecord->id_rekap = $this->idRekapGaji->Value;
			$BayarRekapGajiRecord->user = $this->User->IsUser;
			$BayarRekapGajiRecord->save();
			
			$totalGajiDibayar = 0;
			foreach($arrGaji as $row)
			{
				$RekapGajiDetailRecord = RekapGajiDetailRecord::finder()->findByPk($row->id_edit);
				$RekapGajiDetailRecord->status = '1';
				$RekapGajiDetailRecord->id_bayar =$BayarRekapGajiRecord->id;
				
				$RekapGajiDetailRecord->jns_bayar =$row->jnsBayar;
				
				if($row->jnsBayar == '0')
					$RekapGajiDetailRecord->id_bank = '8';
				else
				{
					$RekapGajiDetailRecord->id_bank = $row->idBank;
					$RekapGajiDetailRecord->no_ref = $row->norek;	
				}
				
				$RekapGajiDetailRecord->id_coa = '835';	
				$RekapGajiDetailRecord->save();	
				$totalGajiDibayar += $RekapGajiDetailRecord->jml_gaji_dibayarkan;
				
				$this->InsertJurnalBukuBesar($RekapGajiDetailRecord->id,
											'7',
											'1',
											$BayarRekapGajiRecord->no_pembayaran,
											$BayarRekapGajiRecord->tgl_pembayaran,
											date("G:i:s"),
											'835',
											$RekapGajiDetailRecord->id_bank,
											"Pembayaran Gaji Kepada ".$row->namaKaryawan,
											$RekapGajiDetailRecord->jml_gaji_dibayarkan);
				
				$this->InsertJurnalUmum($BayarRekapGajiRecord->id,
											'8',
											'0',
											$BayarRekapGajiRecord->tgl_pembayaran,
											date("G:i:s"),
											"Beban Gaji Karyawan",
											$RekapGajiDetailRecord->jml_gaji_dibayarkan,
											$BayarRekapGajiRecord->no_pembayaran);
											
				$this->InsertJurnalUmum($BayarRekapGajiRecord->id,
											'8',
											'1',
											$BayarRekapGajiRecord->tgl_pembayaran,
											date("G:i:s"),
											'Kas',
											$RekapGajiDetailRecord->jml_gaji_dibayarkan,
											$BayarRekapGajiRecord->no_pembayaran,
											$RekapGajiDetailRecord->id_bank);
											
			}
			
			$BayarRekapGajiRecord->total_gaji_dibayarkan = $totalGajiDibayar;
			$BayarRekapGajiRecord->save();
			
			$this->InsertJurnalPengeluaranKas($BayarRekapGajiRecord->id,
												$BayarRekapGajiRecord->no_pembayaran,
												'3',
												$BayarRekapGajiRecord->tgl_pembayaran,
												date("G:i:s"),
												'Gaji Karyawan',
												'Beban Gaji',
												'',
												$totalGajiDibayar,
												0);
	
			
			$sql = "SELECT id FROM tbt_rekap_gaji_detail WHERE id_rekap = '".$this->idRekapGaji->Value."' AND status = '0' AND deleted ='0' ";
			$arrCek = $this->queryAction($sql,'S');
			
			if($arrCek)
				$status = '1';
			else
				$status = '2';
				
			$RekapGajiRecord = RekapGajiRecord::finder()->findByPk($this->idRekapGaji->Value);
			$RekapGajiRecord->status = $status;
			$RekapGajiRecord->save();
			
			$this->InsertLabaRugi($BayarRekapGajiRecord->id,
									'7',
									'1',
									$BayarRekapGajiRecord->tgl_pembayaran,
									date("G:i:s"),
									"Beban Gaji Karyawan",
									$totalGajiDibayar,
									$BayarRekapGajiRecord->no_pembayaran);
			
			/*$this->InsertJurnalUmum($BayarRekapGajiRecord->id,
									'8',
									'0',
									$BayarRekapGajiRecord->tgl_pembayaran,
									date("G:i:s"),
									"Beban Gaji Karyawan",
									$totalGajiDibayar,
									$BayarRekapGajiRecord->no_pembayaran);
										
			$this->InsertJurnalUmum($BayarRekapGajiRecord->id,
										'8',
										'1',
										$BayarRekapGajiRecord->tgl_pembayaran,
										date("G:i:s"),
										'Kas',
										$totalGajiDibayar,
										$BayarRekapGajiRecord->no_pembayaran);*/
										
			$tblBody = $this->BindGrid();
			$tblBodyHistory = $this->BindGridHistory();
			$this->idRekapGaji->Value = "";	
			$this->getPage()->getClientScript()->registerEndScript
							('','
							toastr.info("Data Berhasil Disimpan");
							jQuery("#table-1").dataTable().fnDestroy();
							jQuery("#table-1 tbody").empty();
							jQuery("#table-1 tbody").append("'.$tblBody.'");
							jQuery("#table-history").dataTable().fnDestroy();
							jQuery("#table-history tbody").empty();
							jQuery("#table-history tbody").append("'.$tblBodyHistory.'");
							jQuery("a[href=\"#listTab\"]").tab("show");
							BindGrid();
							BindGridHistory();
							cetakClicked('.$BayarRekapGajiRecord->id.');');	
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.error("Data Belum Dipilih atau Data Yang Dipilih Tidak Lengkap !");
						unloadContent();');	
		}
		
		
	}
	

	public function cetakClicked($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$url = "index.php?page=Hrd.cetakPembayaranGajiPdf&id=".$id;
		
		$folderApp = explode("/",$_SERVER['REQUEST_URI']);
		$urlTemp="http://".$_SERVER['HTTP_HOST']."/".$folderApp[1]."/".$url;
		
		$this->getPage()->getClientScript()->registerEndScript
							('','
							var url = "'.$urlTemp.'";
							window.open(url, "_blank");
							unloadContent();');	
							
		//$this->Response->redirect($this->Service->constructUrl('Hrd.cetakPembayaranGajiPdf',array("id"=>$id)));
	}
	
}
?>
