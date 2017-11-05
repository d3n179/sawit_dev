<?PHP
class ProcessingTbs extends MainConf
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
						('','
						jQuery("#table-1 tbody").append("'.$tblBody.'");');	
		}
	}
	
	
	public function BindGrid()
	{
		$sql = "SELECT 
					tbt_processing_tbs.id,
					tbt_processing_tbs.no_processing,
					tbt_processing_tbs.tgl_processing,
					tbt_processing_tbs.version
				FROM 
					tbt_processing_tbs
				WHERE 
					tbt_processing_tbs.deleted = '0' 
				ORDER BY 
					tbt_processing_tbs.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
				$tglProcessing = $this->ConvertDate($row['tgl_processing'],'3');
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['no_processing'].'</td>';
				$tblBody .= '<td>'.$tglProcessing.'</td>';
				$tblBody .= '<td>';
				
				if($row['tgl_processing'] == date("Y-m-d") && $row['version'] == 1)
				{
					$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
					//$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';	
				}
				
				$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-info btn-sm btn-icon icon-left\" OnClick=\"cetakClicked('.$row['id'].')\"><i class=\"entypo-print\" ></i>Cetak</a>&nbsp;&nbsp;</br>';
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
		$Record = ProcessingTbsRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Processing Tbs';
			$this->idProcessing->Value = $id;
			
			$this->tbs_awal->Text = $Record->tbs_awal;
			$this->tbs_kebun->Text = $Record->tbs_kebun;
			$this->tbs_luar->Text = $Record->tbs_luar;
			$this->tbs_potongan->Text = $Record->tbs_potongan;
			$this->tbs_rbs_mentah->Text = $Record->tbs_rbs_mentah;
			$this->tbs_rbs_masak->Text = $Record->tbs_rbs_masak;
			$this->tbs_restan_ramp->Text = $Record->tbs_restan_ramp;
			$this->tbs_restan_lantai->Text = $Record->tbs_restan_lantai;
			$this->tbs_proses_shift_1->Text = $Record->tbs_proses_shift_1;
			$this->tbs_proses_shift_2->Text = $Record->tbs_proses_shift_2;
			$this->bst_kemarin->Text = $Record->bst_kemarin;
			$this->oil_in_process->Text = $Record->oil_in_process;
			$this->pk_bsk->Text = $Record->pk_bsk;
			$this->cst_1->Text = $Record->cst_1;
			$this->cst_2->Text = $Record->cst_2;
			$this->cst_3->Text = $Record->cst_3;
			$this->ot_1->Text = $Record->ot_1;
			$this->ot_2->Text = $Record->ot_2;
			$this->rcv_1->Text = $Record->rcv_1;
			$this->rcv_2->Text = $Record->rcv_2;
			$this->rcv_3->Text = $Record->rcv_3;
			$this->cot->Text = $Record->cot;
			
			$this->cst_1_temp->Text = $Record->cst_1_temp;
			$this->cst_2_temp->Text = $Record->cst_2_temp;
			$this->cst_3_temp->Text = $Record->cst_3_temp;
			$this->ot_1_temp->Text = $Record->ot_1_temp;
			$this->ot_2_temp->Text = $Record->ot_2_temp;
			$this->rcv_1_temp->Text = $Record->rcv_1_temp;
			$this->rcv_2_temp->Text = $Record->rcv_2_temp;
			$this->rcv_3_temp->Text = $Record->rcv_3_temp;
			$this->cot_temp->Text = $Record->cot_temp;
			
			$this->bst1_cpo_isi->Text = $Record->bst1_cpo_isi;
			$this->temp_bst1->Text = $Record->temp_bst1;
			$this->bst1_cpo_ffa->Text = $Record->bst1_cpo_ffa;
			$this->bst1_cpo_moist->Text = $Record->bst1_cpo_moist;
			$this->bst1_cpo_impurities->Text = $Record->bst1_cpo_impurities;
			$this->bst2_cpo_isi->Text = $Record->bst2_cpo_isi;
			$this->temp_bst2->Text = $Record->temp_bst2;
			$this->bst2_cpo_ffa->Text = $Record->bst2_cpo_ffa;
			$this->bst2_cpo_moist->Text = $Record->bst2_cpo_moist;
			$this->bst2_cpo_impurities->Text = $Record->bst2_cpo_impurities;
			$this->ffa_cst_1->Text = $Record->ffa_cst_1;
			$this->ffa_cst_2->Text = $Record->ffa_cst_2;
			$this->ffa_cst_3->Text = $Record->ffa_cst_3;
			$this->ffa_ot_1->Text = $Record->ffa_ot_1;
			$this->ffa_ot_2->Text = $Record->ffa_ot_2;
			$this->ffa_rcv_1->Text = $Record->ffa_rcv_1;
			$this->ffa_rcv_2->Text = $Record->ffa_rcv_2;
			$this->ffa_rcv_3->Text = $Record->ffa_rcv_3;
			$this->ffa_cot->Text = $Record->ffa_cot;
			$this->bsk_no_1->Text = $Record->bsk_no_1;
			$this->bsk_no_2->Text = $Record->bsk_no_2;
			$this->bsk_no_3->Text = $Record->bsk_no_3;
			$this->bsk_lantai->Text = $Record->bsk_lantai;
			$this->nut_silo_no_1->Text = $Record->nut_silo_no_1;
			$this->nut_silo_no_2->Text = $Record->nut_silo_no_2;
			$this->nut_silo_no_3->Text = $Record->nut_silo_no_3;
			$this->nut_silo_no_4->Text = $Record->nut_silo_no_4;
			$this->nut_silo_lantai->Text = $Record->nut_silo_lantai;
			$this->kernel_silo_no_1->Text = $Record->kernel_silo_no_1;
			$this->kernel_silo_no_2->Text = $Record->kernel_silo_no_2;
			$this->kernel_silo_no_3->Text = $Record->kernel_silo_no_3;
			$this->kernel_silo_lantai->Text = $Record->kernel_silo_lantai;
			$this->pengiriman_cpo->Text = $Record->pengiriman_cpo;
			$this->pengiriman_kernel->Text = $Record->pengiriman_kernel;
			$this->pengiriman_cangkang->Text = $Record->pengiriman_cangkang;
			$this->pengiriman_fibre->Text = $Record->pengiriman_fibre;
			$this->pengiriman_limbah->Text = $Record->pengiriman_limbah;
			$this->reject_cpo->Text = $Record->reject_cpo;
			$this->pengiriman_jangkos->Text = $Record->pengiriman_jangkos;
			$this->pengiriman_cpo_pagi_malam->Text = $Record->pengiriman_cpo_pagi_malam;
			$this->pengiriman_cpo_pagi_ini->Text = $Record->pengiriman_cpo_pagi_ini;
			$this->pengiriman_cpo_ffa_tinggi->Text = $Record->pengiriman_cpo_ffa_tinggi;
			$this->oil_dalam_mobil_cpo->Text = $Record->oil_dalam_mobil_cpo;
			$this->oil_dalam_mobil_cpo_malam->Text = $Record->oil_dalam_mobil_cpo_malam;
			$this->reject_kernel->Text = $Record->reject_kernel;
			$this->mutu_cpo_ffa->Text = $Record->mutu_cpo_ffa;
			$this->mutu_cpo_moisture->Text = $Record->mutu_cpo_moisture;
			$this->mutu_cpo_impurities->Text = $Record->mutu_cpo_impurities;
			$this->drain_minyak->Text = $Record->drain_minyak;
			$this->mutu_pk_moisture->Text = $Record->mutu_pk_moisture;
			$this->mutu_pk_impurities->Text = $Record->mutu_pk_impurities;
			$this->nomor_kolam_tanah->Text = $Record->nomor_kolam_tanah;
			$this->kolam_tanah->Text = $Record->kolam_tanah;
			$this->oil_recovered_ffa->Text = $Record->oil_recovered_ffa;
			$this->oil_recovered_moisture->Text = $Record->oil_recovered_moisture;
			$this->pengutipan_minyak->Text = $Record->pengutipan_minyak;
			$this->produksi_abu_janjang_goni->Text = $Record->produksi_abu_janjang_goni;
			$this->produksi_abu_janjang_kg->Text = $Record->produksi_abu_janjang_kg;
			$this->bss_no_1->Text = $Record->bss_no_1;
			$this->bss_no_2->Text = $Record->bss_no_2;
			$this->bss_no_3->Text = $Record->bss_no_3;
			$this->bss_lantai->Text = $Record->bss_lantai;
			$this->etc_cst1_kg_cm->Text = $Record->etc_cst1_kg_cm;
			$this->etc_cst1_kg->Text = $Record->etc_cst1_kg;
			$this->etc_cst2_kg_cm->Text = $Record->etc_cst2_kg_cm;
			$this->etc_cst2_kg->Text = $Record->etc_cst2_kg;
			$this->etc_cst3_kg_cm->Text = $Record->etc_cst3_kg_cm;
			$this->etc_cst3_kg->Text = $Record->etc_cst3_kg;
			$this->etc_ot1_kg_cm->Text = $Record->etc_ot1_kg_cm;
			$this->etc_ot1_kg->Text = $Record->etc_ot1_kg;
			$this->etc_ot2_kg_cm->Text = $Record->etc_ot2_kg_cm;
			$this->etc_ot2_kg->Text = $Record->etc_ot2_kg;
			$this->etc_rcv1_kg_cm->Text = $Record->etc_rcv1_kg_cm;
			$this->etc_rcv1_kg->Text = $Record->etc_rcv1_kg;
			$this->etc_rcv2_kg_cm->Text = $Record->etc_rcv2_kg_cm;
			$this->etc_rcv2_kg->Text = $Record->etc_rcv2_kg;
			$this->etc_rcv3_kg_cm->Text = $Record->etc_rcv3_kg_cm;
			$this->etc_rcv3_kg->Text = $Record->etc_rcv3_kg;
			$this->etc_cot_kg_cm->Text = $Record->etc_cot_kg_cm;
			$this->etc_cot_kg->Text = $Record->etc_cot_kg;
			$this->etc_bst1_kg_cm->Text = $Record->etc_bst1_kg_cm;
			$this->etc_bst1_kg->Text = $Record->etc_bst1_kg;
			$this->etc_bst2_kg_cm->Text = $Record->etc_bst2_kg_cm;
			$this->etc_bst2_kg->Text = $Record->etc_bst2_kg;
			$this->etc_ks1_kg_cm->Text = $Record->etc_ks1_kg_cm;
			$this->etc_ks1_kg->Text = $Record->etc_ks1_kg;
			$this->etc_ks2_kg_cm->Text = $Record->etc_ks2_kg_cm;
			$this->etc_ks2_kg->Text = $Record->etc_ks2_kg;
			$this->etc_ks3_kg_cm->Text = $Record->etc_ks3_kg_cm;
			$this->etc_ks3_kg->Text = $Record->etc_ks3_kg;
			$this->etc_ns1_kg_cm->Text = $Record->etc_ns1_kg_cm;
			$this->etc_ns1_kg->Text = $Record->etc_ns1_kg;
			$this->etc_ns2_kg_cm->Text = $Record->etc_ns2_kg_cm;
			$this->etc_ns2_kg->Text = $Record->etc_ns2_kg;
			$this->etc_ns3_kg_cm->Text = $Record->etc_ns3_kg_cm;
			$this->etc_ns3_kg->Text = $Record->etc_ns3_kg;
			$this->etc_ns4_kg_cm->Text = $Record->etc_ns4_kg_cm;
			$this->etc_ns4_kg->Text = $Record->etc_ns4_kg;
			$this->etc_bsk1_kg_cm->Text = $Record->etc_bsk1_kg_cm;
			$this->etc_bsk1_kg->Text = $Record->etc_bsk1_kg;
			$this->etc_bsk2_kg_cm->Text = $Record->etc_bsk2_kg_cm;
			$this->etc_bsk2_kg->Text = $Record->etc_bsk2_kg;
			$this->etc_bsk3_kg_cm->Text = $Record->etc_bsk3_kg_cm;
			$this->etc_bsk3_kg->Text = $Record->etc_bsk3_kg;
			$this->etc_bss1_kg_cm->Text = $Record->etc_bss1_kg_cm;
			$this->etc_bss1_kg->Text = $Record->etc_bss1_kg;
			$this->etc_bss2_kg_cm->Text = $Record->etc_bss2_kg_cm;
			$this->etc_bss2_kg->Text = $Record->etc_bss2_kg;
			$this->etc_bss3_kg_cm->Text = $Record->etc_bss3_kg_cm;
			$this->etc_bss3_kg->Text = $Record->etc_bss3_kg;
			$this->jam_olah_tbs_1->Text = $Record->jam_olah_tbs_1;
			$this->jam_olah_tbs_2->Text = $Record->jam_olah_tbs_2;
			$this->jam_olah_nut_1->Text = $Record->jam_olah_nut_1;
			$this->jam_olah_nut_2->Text = $Record->jam_olah_nut_2;
			$this->jam_start_1->Text = $Record->jam_start_1;
			$this->jam_start_2->Text = $Record->jam_start_2;
			$this->jam_stop_1->Text = $Record->jam_stop_1;
			$this->jam_stop_2->Text = $Record->jam_stop_2;
			$this->jam_main_1->Text = $Record->jam_main_1;
			$this->jam_main_2->Text = $Record->jam_main_2;
			$this->jam_down_1->Text = $Record->jam_down_1;
			$this->jam_down_2->Text = $Record->jam_down_2;
			$Record->save(); 
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					jQuery("#modal-1").modal("show");
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
		$Record = ProcessingTbsRecord::finder()->findByPk($id);
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
	
	public function importBtnClicked()
	{
		$sqlParent = "SELECT
							lhp_april_2017.tgl
						FROM
							lhp_april_2017
						GROUP BY
							lhp_april_2017.tgl
						ORDER BY lhp_april_2017.tgl ASC";
		$arrParent = $this->queryAction($sqlParent,'S');
		foreach($arrParent as $rowParent)
		{		
			$tglTemp = explode("-",$rowParent['tgl']);
			$tglLhp =  $rowParent['tgl'];//$tglTemp[2].'-'.$tglTemp[0].'-'.$tglTemp[1];
					
			$Record = new ProcessingTbsRecord();
			$msg = "Data Berhasil Disimpan";
			$Record->no_processing = $this->GenerateNoDocument('PRC',$tglTemp[1],$tglTemp[0]);
			$Record->tgl_processing = $tglLhp;
			$Record->wkt_processing = date("G:i:s");
						
			$sql = "SELECT
						lhp_april_2017.field_name_1,
						lhp_april_2017.value_field_1,
						lhp_april_2017.field_name_2,
						lhp_april_2017.value_field_2,
						lhp_april_2017.tgl
					FROM
						lhp_april_2017
					WHERE 
						lhp_april_2017.tgl = '".$rowParent['tgl']."'
					ORDER BY
						lhp_april_2017.tgl ";
			$arr = $this->queryAction($sql,'S');
			if($arr)
			{
				foreach($arr as $row)
				{
					if($row['field_name_1'] != '')
					{
						if($row['field_name_1'] != 'pengiriman_bunpress')
							$Record->$row['field_name_1'] = $row['value_field_1'];
					}
						
					if($row['field_name_2'] != '')
						$Record->$row['field_name_2'] = $row['value_field_2'];
				}
			}
			$Record->save();
			$this->UpdateReporting($Record->id,0,$tglLhp,$tglTemp[1],$tglTemp[0]);
		}
	}
	
	public function submitBtnClicked($sender,$param)
	{
		$tglLhp = $this->ConvertDate($this->tgl_processing->Text,'2');
		$sqlValid = "SELECT id FROM tbt_processing_tbs WHERE tgl_processing >= '$tglLhp' ";
		$arrValid = $this->queryAction($sqlValid,'S');
		
		if(count($arrValid) > 0)
		{
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.error("Sudah Ada Proses LHP yg dilakukan setelah tanggal tersebut !!");');
		}
		else
		{
			$this->simpanData();
		}
	}
	
	public function simpanData()
	{
		$Persediaan_Today = round($this->tbs_awal->Text + $this->tbs_kebun->Text + $this->tbs_luar->Text + $this->tbs_potongan->Text);
		$Cap_Rebusan = ($this->tbs_proses_shift_1->Text == 0 && $this->tbs_proses_shift_2->Text == 0 ? 0 : floor($Persediaan_Today / ($this->tbs_proses_shift_1->Text + $this->tbs_proses_shift_2->Text + $this->tbs_rbs_mentah->Text + $this->tbs_rbs_masak->Text + $this->tbs_restan_ramp->Text + $this->tbs_restan_lantai->Text)));
		$Olah_Brutto_today = round(($this->tbs_proses_shift_1->Text + $this->tbs_proses_shift_2->Text) * $Cap_Rebusan);
		$Olah_Netto_today  = ($Olah_Brutto_today == 0 ? 0 : round($Olah_Brutto_today - $this->tbs_potongan->Text));
		
		$stockBarangTbs = 0;
		$BarangKategoriRecord = BarangKategoriRecord::finder()->find('tipe_kategori = ? AND deleted != ? ','1','1');
		if($BarangKategoriRecord)
		{
			$idKategori = $BarangKategoriRecord->id;
			$sql = "SELECT tbm_barang.id FROM tbm_barang WHERE tbm_barang.kategori_id = '$idKategori' AND deleted != '1' "; 
			$arrBarang = $this->queryAction($sql,'S');
			foreach($arrBarang as $rowBarang)
			{
				$StockBarangRecord = StockBarangRecord::finder()->find('id_barang = ? AND deleted != ? ',$rowBarang['id'],'1');
				if($StockBarangRecord)
					$stockBarangTbs += $this->getTargetUom($rowBarang['id'],$StockBarangRecord->stok,'0','1','0');
			}
		}
		
		/*$BarangRecord = BarangRecord::finder()->find('kategori_id = ? AND deleted = ?','1','0');
		if($BarangRecord)
		{
			$StockBarangRecord = StockBarangRecord::finder()->find('id_barang = ? AND deleted = ? ',$BarangRecord->id,'0');
			if($StockBarangRecord)
				$stockBarangTbs = $this->getTargetUom($BarangRecord->id,$StockBarangRecord->stok,'0','1','0');
			else
				$stockBarangTbs = 0;
		}
		else
		{
			$stockBarangTbs = 0;
		}*/
		
		if($stockBarangTbs >= $Olah_Netto_today)
		{
			$stStok = '1';
		}
		else
		{
			$stStok = '0';
		}
		
		if($stStok == '1')
		{
			if($this->idProcessing->Value != '')
			{
				$Record = ProcessingTbsRecord::finder()->findByPk($this->idProcessing->Value);
				$Record->version = 2;
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new ProcessingTbsRecord();
				$msg = "Data Berhasil Disimpan";
				$Record->no_processing = $this->GenerateNoDocument('PRC');
				$Record->tgl_processing = $this->ConvertDate($this->tgl_processing->Text,'2');//date("Y-m-d");
				$Record->wkt_processing = date("G:i:s");
			}
			
			$Record->tbs_awal = $this->tbs_awal->Text;
			$Record->tbs_kebun = $this->tbs_kebun->Text;
			$Record->tbs_luar = $this->tbs_luar->Text;
			$Record->tbs_potongan = $this->tbs_potongan->Text;
			$Record->tbs_rbs_mentah = $this->tbs_rbs_mentah->Text;
			$Record->tbs_rbs_masak = $this->tbs_rbs_masak->Text;
			$Record->tbs_restan_ramp = $this->tbs_restan_ramp->Text;
			$Record->tbs_restan_lantai = $this->tbs_restan_lantai->Text;
			$Record->tbs_proses_shift_1 = $this->tbs_proses_shift_1->Text;
			$Record->tbs_proses_shift_2 = $this->tbs_proses_shift_2->Text;
			$Record->bst_kemarin = $this->bst_kemarin->Text;
			$Record->oil_in_process = $this->oil_in_process->Text;
			$Record->pk_bsk = $this->pk_bsk->Text;
			$Record->cst_1 = $this->cst_1->Text;
			$Record->cst_2 = $this->cst_2->Text;
			$Record->cst_3 = $this->cst_3->Text;
			$Record->ot_1 = $this->ot_1->Text;
			$Record->ot_2 = $this->ot_2->Text;
			$Record->rcv_1 = $this->rcv_1->Text;
			$Record->rcv_2 = $this->rcv_2->Text;
			$Record->rcv_3 = $this->rcv_3->Text;
			$Record->cot = $this->cot->Text;
			
			$Record->cst_1_temp = $this->cst_1_temp->Text;
			$Record->cst_2_temp = $this->cst_2_temp->Text;
			$Record->cst_3_temp = $this->cst_3_temp->Text;
			$Record->ot_1_temp = $this->ot_1_temp->Text;
			$Record->ot_2_temp = $this->ot_2_temp->Text;
			$Record->rcv_1_temp = $this->rcv_1_temp->Text;
			$Record->rcv_2_temp = $this->rcv_2_temp->Text;
			$Record->rcv_3_temp = $this->rcv_3_temp->Text;
			$Record->cot_temp = $this->cot_temp->Text;
			$Record->bst1_cpo_isi = $this->bst1_cpo_isi->Text;
			$Record->temp_bst1 = $this->temp_bst1->Text;
			$Record->bst1_cpo_ffa = $this->bst1_cpo_ffa->Text;
			$Record->bst1_cpo_moist = $this->bst1_cpo_moist->Text;
			$Record->bst1_cpo_impurities = $this->bst1_cpo_impurities->Text;
			$Record->bst2_cpo_isi = $this->bst2_cpo_isi->Text;
			$Record->temp_bst2 = $this->temp_bst2->Text;
			$Record->bst2_cpo_ffa = $this->bst2_cpo_ffa->Text;
			$Record->bst2_cpo_moist = $this->bst2_cpo_moist->Text;
			$Record->bst2_cpo_impurities = $this->bst2_cpo_impurities->Text;
			$Record->ffa_cst_1 = $this->ffa_cst_1->Text;
			$Record->ffa_cst_2 = $this->ffa_cst_2->Text;
			$Record->ffa_cst_3 = $this->ffa_cst_3->Text;
			$Record->ffa_ot_1 = $this->ffa_ot_1->Text;
			$Record->ffa_ot_2 = $this->ffa_ot_2->Text;
			$Record->ffa_rcv_1 = $this->ffa_rcv_1->Text;
			$Record->ffa_rcv_2 = $this->ffa_rcv_2->Text;
			$Record->ffa_rcv_3 = $this->ffa_rcv_3->Text;
			$Record->ffa_cot = $this->ffa_cot->Text;
			$Record->bsk_no_1 = $this->bsk_no_1->Text;
			$Record->bsk_no_2 = $this->bsk_no_2->Text;
			$Record->bsk_no_3 = $this->bsk_no_3->Text;
			$Record->bsk_lantai = $this->bsk_lantai->Text;
			$Record->nut_silo_no_1 = $this->nut_silo_no_1->Text;
			$Record->nut_silo_no_2 = $this->nut_silo_no_2->Text;
			$Record->nut_silo_no_3 = $this->nut_silo_no_3->Text;
			$Record->nut_silo_no_4 = $this->nut_silo_no_4->Text;
			$Record->nut_silo_lantai = $this->nut_silo_lantai->Text;
			$Record->kernel_silo_no_1 = $this->kernel_silo_no_1->Text;
			$Record->kernel_silo_no_2 = $this->kernel_silo_no_2->Text;
			$Record->kernel_silo_no_3 = $this->kernel_silo_no_3->Text;
			$Record->kernel_silo_lantai = $this->kernel_silo_lantai->Text;
			$Record->pengiriman_cpo = $this->pengiriman_cpo->Text;
			$Record->pengiriman_kernel = $this->pengiriman_kernel->Text;
			$Record->pengiriman_cangkang = $this->pengiriman_cangkang->Text;
			$Record->pengiriman_fibre = $this->pengiriman_fibre->Text;
			$Record->pengiriman_limbah = $this->pengiriman_limbah->Text;
			$Record->reject_cpo = $this->reject_cpo->Text;
			$Record->pengiriman_jangkos = $this->pengiriman_jangkos->Text;
			$Record->pengiriman_cpo_pagi_malam = $this->pengiriman_cpo_pagi_malam->Text;
			$Record->pengiriman_cpo_pagi_ini = $this->pengiriman_cpo_pagi_ini->Text;
			$Record->pengiriman_cpo_ffa_tinggi = $this->pengiriman_cpo_ffa_tinggi->Text;
			$Record->oil_dalam_mobil_cpo = $this->oil_dalam_mobil_cpo->Text;
			$Record->oil_dalam_mobil_cpo_malam = $this->oil_dalam_mobil_cpo_malam->Text;
			$Record->reject_kernel = $this->reject_kernel->Text;
			$Record->mutu_cpo_ffa = $this->mutu_cpo_ffa->Text;
			$Record->mutu_cpo_moisture = $this->mutu_cpo_moisture->Text;
			$Record->mutu_cpo_impurities = $this->mutu_cpo_impurities->Text;
			$Record->drain_minyak = $this->drain_minyak->Text;
			$Record->mutu_pk_moisture = $this->mutu_pk_moisture->Text;
			$Record->mutu_pk_impurities = $this->mutu_pk_impurities->Text;
			$Record->nomor_kolam_tanah = $this->nomor_kolam_tanah->Text;
			$Record->kolam_tanah = $this->kolam_tanah->Text;
			$Record->oil_recovered_ffa = $this->oil_recovered_ffa->Text;
			$Record->oil_recovered_moisture = $this->oil_recovered_moisture->Text;
			$Record->pengutipan_minyak = $this->pengutipan_minyak->Text;
			$Record->produksi_abu_janjang_goni = $this->produksi_abu_janjang_goni->Text;
			$Record->produksi_abu_janjang_kg = $this->produksi_abu_janjang_kg->Text;
			$Record->bss_no_1 = $this->bss_no_1->Text;
			$Record->bss_no_2 = $this->bss_no_2->Text;
			$Record->bss_no_3 = $this->bss_no_3->Text;
			$Record->bss_lantai = $this->bss_lantai->Text;
			$Record->etc_cst1_kg_cm = $this->etc_cst1_kg_cm->Text;
			$Record->etc_cst1_kg = $this->etc_cst1_kg->Text;
			$Record->etc_cst2_kg_cm = $this->etc_cst2_kg_cm->Text;
			$Record->etc_cst2_kg = $this->etc_cst2_kg->Text;
			$Record->etc_cst3_kg_cm = $this->etc_cst3_kg_cm->Text;
			$Record->etc_cst3_kg = $this->etc_cst3_kg->Text;
			$Record->etc_ot1_kg_cm = $this->etc_ot1_kg_cm->Text;
			$Record->etc_ot1_kg = $this->etc_ot1_kg->Text;
			$Record->etc_ot2_kg_cm = $this->etc_ot2_kg_cm->Text;
			$Record->etc_ot2_kg = $this->etc_ot2_kg->Text;
			$Record->etc_rcv1_kg_cm = $this->etc_rcv1_kg_cm->Text;
			$Record->etc_rcv1_kg = $this->etc_rcv1_kg->Text;
			$Record->etc_rcv2_kg_cm = $this->etc_rcv2_kg_cm->Text;
			$Record->etc_rcv2_kg = $this->etc_rcv2_kg->Text;
			$Record->etc_rcv3_kg_cm = $this->etc_rcv3_kg_cm->Text;
			$Record->etc_rcv3_kg = $this->etc_rcv3_kg->Text;
			$Record->etc_cot_kg_cm = $this->etc_cot_kg_cm->Text;
			$Record->etc_cot_kg = $this->etc_cot_kg->Text;
			$Record->etc_bst1_kg_cm = $this->etc_bst1_kg_cm->Text;
			$Record->etc_bst1_kg = $this->etc_bst1_kg->Text;
			$Record->etc_bst2_kg_cm = $this->etc_bst2_kg_cm->Text;
			$Record->etc_bst2_kg = $this->etc_bst2_kg->Text;
			$Record->etc_ks1_kg_cm = $this->etc_ks1_kg_cm->Text;
			$Record->etc_ks1_kg = $this->etc_ks1_kg->Text;
			$Record->etc_ks2_kg_cm = $this->etc_ks2_kg_cm->Text;
			$Record->etc_ks2_kg = $this->etc_ks2_kg->Text;
			$Record->etc_ks3_kg_cm = $this->etc_ks3_kg_cm->Text;
			$Record->etc_ks3_kg = $this->etc_ks3_kg->Text;
			$Record->etc_ns1_kg_cm = $this->etc_ns1_kg_cm->Text;
			$Record->etc_ns1_kg = $this->etc_ns1_kg->Text;
			$Record->etc_ns2_kg_cm = $this->etc_ns2_kg_cm->Text;
			$Record->etc_ns2_kg = $this->etc_ns2_kg->Text;
			$Record->etc_ns3_kg_cm = $this->etc_ns3_kg_cm->Text;
			$Record->etc_ns3_kg = $this->etc_ns3_kg->Text;
			$Record->etc_ns4_kg_cm = $this->etc_ns4_kg_cm->Text;
			$Record->etc_ns4_kg = $this->etc_ns4_kg->Text;
			$Record->etc_bsk1_kg_cm = $this->etc_bsk1_kg_cm->Text;
			$Record->etc_bsk1_kg = $this->etc_bsk1_kg->Text;
			$Record->etc_bsk2_kg_cm = $this->etc_bsk2_kg_cm->Text;
			$Record->etc_bsk2_kg = $this->etc_bsk2_kg->Text;
			$Record->etc_bsk3_kg_cm = $this->etc_bsk3_kg_cm->Text;
			$Record->etc_bsk3_kg = $this->etc_bsk3_kg->Text;
			$Record->etc_bss1_kg_cm = $this->etc_bss1_kg_cm->Text;
			$Record->etc_bss1_kg = $this->etc_bss1_kg->Text;
			$Record->etc_bss2_kg_cm = $this->etc_bss2_kg_cm->Text;
			$Record->etc_bss2_kg = $this->etc_bss2_kg->Text;
			$Record->etc_bss3_kg_cm = $this->etc_bss3_kg_cm->Text;
			$Record->etc_bss3_kg = $this->etc_bss3_kg->Text;
			$Record->jam_olah_tbs_1 = $this->jam_olah_tbs_1->Text;
			$Record->jam_olah_tbs_2 = $this->jam_olah_tbs_2->Text;
			$Record->jam_olah_nut_1 = $this->jam_olah_nut_1->Text;
			$Record->jam_olah_nut_2 = $this->jam_olah_nut_2->Text;
			$Record->jam_start_1 = $this->jam_start_1->Text;
			$Record->jam_start_2 = $this->jam_start_2->Text;
			$Record->jam_stop_1 = $this->jam_stop_1->Text;
			$Record->jam_stop_2 = $this->jam_stop_2->Text;
			$Record->jam_main_1 = $this->jam_main_1->Text;
			$Record->jam_main_2 = $this->jam_main_2->Text;
			$Record->jam_down_1 = $this->jam_down_1->Text;
			$Record->jam_down_2 = $this->jam_down_2->Text;
			$Record->save(); 
			
			$NilaiBahanBaku = 0;
			foreach($arrBarang as $rowBarang)
			{
				$StockBarangRecord = StockBarangRecord::finder()->find('id_barang = ? AND deleted != ? ',$rowBarang['id'],'1');
				if($StockBarangRecord)
				{
					$stokAwal = $StockBarangRecord->stok;
					$stokIn = 0;
					$stokOut = $Olah_Netto_today;
					
					if($StockBarangRecord->stok > $Olah_Netto_today)
					{
						$stokAkhir = $StockBarangRecord->stok - $Olah_Netto_today;
						$StockBarangRecord->stok = $stokAkhir;
						
					}
					else
					{
						$stokAkhir = 0;
						$StockBarangRecord->stok = 0;
					}
					$StockBarangRecord->save();
					
					$hargaSatuanBesar = $this->GetLastProductPrice($rowBarang['id']);
					
					if($hargaSatuanBesar > 0)
					{
						$sqlSatuanAkhir = "SELECT 
												tbm_satuan_barang.id,
												tbm_satuan_barang.id_satuan 
											FROM 
												tbm_satuan_barang 
											WHERE 
												tbm_satuan_barang.deleted != '1' 
												AND tbm_satuan_barang.id_barang = '".$rowBarang['id']."'
											ORDER BY tbm_satuan_barang.urutan DESC LIMIT 1 ";
						$arrSatuanAkhir = $this->queryAction($sqlSatuanAkhir,'S');
						$idSatuanAkhir = $arrSatuanAkhir[0]['id_satuan'];
						
						$hargaReal = $this->checkConversionPrice($rowBarang['id'],$idSatuanAkhir,$hargaSatuanBesar);
					}
					else
					{
						$hargaReal = 0;
					}
				
					$nilaiOut = $hargaReal * $stokOut;
					$StockInOutRecord = new StockInOutRecord();
					$StockInOutRecord->id_barang = $rowBarang['id'];
					$StockInOutRecord->stok_awal = $stokAwal;
					$StockInOutRecord->stok_in = 0;
					$StockInOutRecord->nilai_in = 0;
					$StockInOutRecord->stok_out = $stokOut;
					$StockInOutRecord->nilai_out = $nilaiOut;
					$StockInOutRecord->stok_akhir = $stokAkhir;
					$StockInOutRecord->keterangan = '';
					$StockInOutRecord->id_transaksi = $Record->id;
					$StockInOutRecord->jns_transaksi = "9";
					$StockInOutRecord->tgl = date("Y-m-d");
					$StockInOutRecord->wkt= date("G:i:s");
					$StockInOutRecord->username = $this->User->IsUser;
					$StockInOutRecord->save();
					
					$NilaiBahanBaku += $nilaiOut;
				}
			}
			
			$this->InsertJurnalUmum($Record->id,
										'12',
										'0',
										date("Y-m-d"),
										date("G:i:s"),
										'Persediaan Barang Dagangan',
										$NilaiBahanBaku,
										$Record->no_processing);
							
			$this->InsertJurnalUmum($Record->id,
										'12',
										'1',
										date("Y-m-d"),
										date("G:i:s"),
										'Persediaan Bahan Baku',
										$NilaiBahanBaku,
										$Record->no_processing);
							
			$this->InsertJurnalBukuBesar($Record->id,
											'12',
											'0',
											$Record->no_processing,
											date("Y-m-d"),
											date("G:i:s"),
											'',
											'',
											'Persediaan Barang Dagangan',
											'Produksi Barang Dagangan',
											$NilaiBahanBaku);
							
			$this->InsertJurnalBukuBesar($Record->id,
											'12',
											'1',
											$Record->no_processing,
											date("Y-m-d"),
											date("G:i:s"),
											'',
											'',
											'Persediaan Bahan Baku',
											'Produksi Barang Dagangan',
											$NilaiBahanBaku);
											
			//$stockBarangTbs -= $Olah_Netto_today;
			//$StockBarangRecord->stok = $stockBarangTbs;
			//$StockBarangRecord->save();
			$tglLhp = $this->ConvertDate($this->tgl_processing->Text,'2');
			$arrTglLhp = explode("-",$tglLhp);
			
			$this->UpdateReporting($Record->id,$hargaSatuanBesar,$tglLhp,$arrTglLhp[1],$arrTglLhp[0]);
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("'.$msg.'");
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
						toastr.error("Stok Kelapa Sawit Tidak Cukup Untuk melakukan rendeman !!");');
		}
		
	}
	
	public function UpdateReporting($idProcessing,$hargaSatuanBesar,$tglLhp,$bulanLhp,$tahunLhp)
	{
		$record = ProcessingTbsRecord::finder()->findByPk($idProcessing);
		
		if($record->bst1_cpo_isi > 0)
			$Oil_Recovered_Total_isi_BST1 = $record->bst1_cpo_isi * $record->etc_bst1_kg_cm * $this->getTempVariable($record->temp_bst1) + $record->etc_bst1_kg * $this->getTempVariable($record->temp_bst1);
		else
			$Oil_Recovered_Total_isi_BST1 = 0;
		
		
		if($record->bst2_cpo_isi > 0)
			$Oil_Recovered_Total_isi_BST2 = $record->bst2_cpo_isi * $record->etc_bst2_kg_cm * $this->getTempVariable($record->temp_bst2) + $record->etc_bst2_kg * $this->getTempVariable($record->temp_bst2);
		else
			$Oil_Recovered_Total_isi_BST2 = 0;
			
		$Oil_In_Process_CST1_Kg = $record->cst_1 * $record->etc_cst1_kg_cm * $this->getTempVariable($record->cst_1_temp);
		$Oil_In_Process_CST2_Kg = $record->cst_2 * $record->etc_cst2_kg_cm * $this->getTempVariable($record->cst_2_temp);
		$Oil_In_Process_CST3_Kg = $record->cst_3 * $record->etc_cst3_kg_cm * $this->getTempVariable($record->cst_3_temp);

		$Oil_In_Process_OT1_Kg = $record->ot_1 * $record->etc_ot1_kg_cm  * $this->getTempVariable($record->ot_1_temp) + $record->etc_ot1_kg * $this->getTempVariable($record->ot_1_temp);
		$Oil_In_Process_OT2_Kg = $record->ot_2 * $record->etc_ot2_kg_cm  * $this->getTempVariable($record->ot_2_temp) + $record->etc_ot2_kg * $this->getTempVariable($record->ot_2_temp);

		$Oil_In_Process_RCV1_Kg = $record->rcv_1 * $record->etc_rcv1_kg_cm * $this->getTempVariable($record->rcv_1_temp);
		$Oil_In_Process_RCV2_Kg = $record->rcv_2 * $record->etc_rcv2_kg_cm * $this->getTempVariable($record->rcv_2_temp);
		$Oil_In_Process_RCV3_Kg = $record->rcv_3 * $record->etc_rcv3_kg_cm * $this->getTempVariable($record->rcv_3_temp);

		$COT_Kg = $record->cot * $record->etc_cot_kg_cm;

		$NS1_Kg = ($record->nut_silo_no_1 > 0 ? $record->nut_silo_no_1 * $record->etc_ns1_kg_cm + $record->etc_ks3_kg : 0);
		$NS2_Kg = ($record->nut_silo_no_2 > 0 ? $record->nut_silo_no_2 * $record->etc_ns2_kg_cm + $record->etc_ns1_kg : 0);
		$NS3_Kg = ($record->nut_silo_no_3 > 0 ? $record->nut_silo_no_3 * $record->etc_ns3_kg_cm + $record->etc_ns2_kg : 0);
		$NS4_Kg = ($record->nut_silo_no_4 > 0 ? $record->nut_silo_no_4 * $record->etc_ns4_kg_cm + $record->etc_ns3_kg : 0);

		$KS1_Kg = ($record->kernel_silo_no_1 > 0 ? $record->kernel_silo_no_1 * $record->etc_ks1_kg_cm - 0 * 0 + $record->etc_bst2_kg : 0);
		$KS2_Kg = ($record->kernel_silo_no_2 > 0 ? $record->kernel_silo_no_2 * $record->etc_ks2_kg_cm - 0 * 0 + $record->etc_ks1_kg : 0);
		$KS3_Kg = ($record->kernel_silo_no_3 > 0 ? $record->kernel_silo_no_3 * $record->etc_ks3_kg_cm - 0 * 0 + $record->etc_ks2_kg : 0);

		$BSK1_Kg = ($record->bsk_no_1 > 0 ? $record->bsk_no_1 * $record->etc_bsk1_kg_cm + $record->etc_ns4_kg : 0);
		$BSK2_Kg = ($record->bsk_no_2 > 0 ? $record->bsk_no_2 * $record->etc_bsk2_kg_cm + $record->etc_bsk1_kg : 0);
		$BSK3_Kg = ($record->bsk_no_3 > 0 ? $record->bsk_no_3 * $record->etc_bsk3_kg_cm + $record->etc_bsk2_kg : 0);

		$BSS1_Kg = ($record->bss_no_1 > 0 ? $record->bss_no_1 * $record->etc_bss1_kg_cm + $record->etc_bsk3_kg : 0);
		$BSS2_Kg = ($record->bss_no_2 > 0 ? $record->bss_no_2 * $record->etc_bss2_kg_cm + $record->etc_bss1_kg : 0);
		$BSS3_Kg = ($record->bss_no_3 > 0 ? $record->bss_no_3 * $record->etc_bss3_kg_cm + $record->etc_bss2_kg : 0);

		$cpo_bst1 = $Oil_Recovered_Total_isi_BST1 -  $record->etc_bst1_kg;
		$cpo_cut_bst1 = $record->etc_bst1_kg;
		$cpo_bst2 = $Oil_Recovered_Total_isi_BST2 ;
		$cpo_cut_bst2 = $record->etc_bst2_kg;
		$cpo_in_process = $Oil_In_Process_CST1_Kg + $Oil_In_Process_CST2_Kg + $Oil_In_Process_CST2_Kg + $Oil_In_Process_OT1_Kg + $Oil_In_Process_OT2_Kg + $Oil_In_Process_RCV1_Kg + $Oil_In_Process_RCV2_Kg + $Oil_In_Process_RCV3_Kg;
		$cpo_total = $cpo_bst1 + $cpo_cut_bst1 + $cpo_bst2 + $cpo_cut_bst2 + $cpo_in_process;
		
		$StockCPORecord = StockBarangRecord::finder()->find('id_barang = ? AND deleted = ? ','10','0');
		if($StockCPORecord)
		{
			$stokAwal = $StockCPORecord->stok;
			$stokIn = $cpo_total;
			$stokOut = 0;
			$stokAkhir = $StockCPORecord->stok + $cpo_total;
			
			$StockCPORecord->stok = $stokAkhir;
			$StockCPORecord->save();
		}
		else
		{
			$stokAwal = 0;
			$stokIn = $cpo_total;
			$stokOut = 0;
			$stokAkhir = $cpo_total;
			
			$StockCPORecord = new StockBarangRecord();
			$StockCPORecord->id_barang = '10';
			$StockCPORecord->stok = $cpo_total;
			$StockCPORecord->expired_date = '0000-00-00';
			$StockCPORecord->deleted = '0';
			$StockCPORecord->save();
		}
		
		$StockInOutRecord = new StockInOutRecord();
		$StockInOutRecord->id_barang = '10';
		$StockInOutRecord->stok_awal = $stokAwal;
		$StockInOutRecord->stok_in = $stokIn;
		$StockInOutRecord->nilai_in = 0;
		$StockInOutRecord->stok_out = $stokOut;
		$StockInOutRecord->nilai_out = 0;
		$StockInOutRecord->stok_akhir = $stokAkhir;
		$StockInOutRecord->keterangan = '';
		$StockInOutRecord->id_transaksi = $idProcessing;
		$StockInOutRecord->jns_transaksi = "9";
		$StockInOutRecord->tgl = date("Y-m-d");
		$StockInOutRecord->wkt= date("G:i:s");
		$StockInOutRecord->username = $this->User->IsUser;
		$StockInOutRecord->save();
		
		$BarangHargaRecord = new BarangHargaRecord();
		$BarangHargaRecord->id_barang = '10';
		$BarangHargaRecord->tgl = date("Y-m-d");
		$BarangHargaRecord->harga = $hargaSatuanBesar;
		$BarangHargaRecord->deleted = '0';
		$BarangHargaRecord->save();
							
		$pk_bsk = $BSK1_Kg + $BSK2_Kg + $BSK3_Kg + $record->bsk_lantai;
		$pk_ks = $KS1_Kg + $KS2_Kg + $KS3_Kg + $record->kernel_silo_lantai;
		
		$StockBSKRecord = StockBarangRecord::finder()->find('id_barang = ? AND deleted = ? ','11','0');
		if($StockBSKRecord)
		{
			$stokAwal = $StockBSKRecord->stok;
			$stokIn = $pk_bsk;
			$stokOut = 0;
			$stokAkhir = $StockBSKRecord->stok + $pk_bsk;
			
			$StockBSKRecord->stok = $stokAkhir;
			$StockBSKRecord->save();
		}
		else
		{
			$stokAwal = 0;
			$stokIn = $pk_bsk;
			$stokOut = 0;
			$stokAkhir = $pk_bsk;
			
			$StockBSKRecord = new StockBarangRecord();
			$StockBSKRecord->id_barang = '11';
			$StockBSKRecord->stok = $pk_bsk;
			$StockBSKRecord->expired_date = '0000-00-00';
			$StockBSKRecord->deleted = '0';
			$StockBSKRecord->save();
		}
		
		
		$StockInOutRecord = new StockInOutRecord();
		$StockInOutRecord->id_barang = '11';
		$StockInOutRecord->stok_awal = $stokAwal;
		$StockInOutRecord->stok_in = $stokIn;
		$StockInOutRecord->nilai_in = 0;
		$StockInOutRecord->stok_out = $stokOut;
		$StockInOutRecord->nilai_out = 0;
		$StockInOutRecord->stok_akhir = $stokAkhir;
		$StockInOutRecord->keterangan = '';
		$StockInOutRecord->id_transaksi = $idProcessing;
		$StockInOutRecord->jns_transaksi = "9";
		$StockInOutRecord->tgl = date("Y-m-d");
		$StockInOutRecord->wkt= date("G:i:s");
		$StockInOutRecord->username = $this->User->IsUser;
		$StockInOutRecord->save();
		
		$BarangHargaRecord = new BarangHargaRecord();
		$BarangHargaRecord->id_barang = '11';
		$BarangHargaRecord->tgl = date("Y-m-d");
		$BarangHargaRecord->harga = $hargaSatuanBesar;
		$BarangHargaRecord->deleted = '0';
		$BarangHargaRecord->save();
		
		$nut_silo = $NS1_Kg + $NS2_Kg + $NS3_Kg + $NS4_Kg + $record->nut_silo_lantai;

		$shell_bss = $BSS1_Kg + $BSS2_Kg + $BSS3_Kg + $record->bss_lantai;

		$Persediaan_Today = round($record->tbs_awal + $record->tbs_kebun + $record->tbs_luar +  $record->tbs_potongan);

		$Cap_Rebusan = ($record->tbs_proses_shift_1 == 0 && $record->tbs_proses_shift_2 == 0 ? 0 : round($Persediaan_Today / ($record->tbs_proses_shift_1 + $record->tbs_proses_shift_2 + $record->tbs_rbs_mentah + $record->tbs_rbs_masak + $record->tbs_restan_ramp + $record->tbs_restan_lantai)));

		$Olah_Brutto_today = round(($record->tbs_proses_shift_1 + $record->tbs_proses_shift_2) * $Cap_Rebusan);

		$Olah_Netto_today  = ($Olah_Brutto_today == 0 ? 0 : round($Olah_Brutto_today - $record->tbs_potongan));
			
		$Olah_Akhir = ($Olah_Brutto_today == 0 ? round($Persediaan_Today - $record->tbs_potongan) : round($Persediaan_Today - $Olah_Brutto_today));

		$Jam_Olah_Tbs_Today = $this->AddPlayTime(array($record->jam_olah_tbs_1,$record->jam_olah_tbs_2));
		$Jam_Olah_Tbs_Today = $Jam_Olah_Tbs_Today.":00";
		$Jam_Olah_Nut_Today = $this->AddPlayTime(array($record->jam_olah_nut_1,$record->jam_olah_nut_2));
		$Jam_Olah_Nut_Today = $Jam_Olah_Nut_Today.":00";
		$Jam_Main_Today = $this->AddPlayTime(array($record->jam_main_1,$record->jam_main_2));
		$Jam_Main_Today = $Jam_Main_Today.":00";
		$Jam_Down_Today = $this->AddPlayTime(array($record->jam_down_1,$record->jam_down_2));
		$Jam_Down_Today = $Jam_Down_Today.":00";

		$Cap_Olah_Tbs_Today = round($Olah_Brutto_today / $this->decimalHours($Jam_Olah_Tbs_Today));	

		$rbs_mentah_kg = $record->tbs_rbs_mentah * $Cap_Rebusan;
		$rbs_masak_kg = $record->tbs_rbs_masak * $Cap_Rebusan;
		$rbs_ramp_kg = $record->tbs_restan_ramp * $Cap_Rebusan;
		$rbs_lantai_kg = $record->tbs_restan_lantai * $Cap_Rebusan;

		$CPO_Today = ceil($cpo_in_process + $record->pengiriman_cpo + $record->pengiriman_cpo_pagi_ini + $Oil_Recovered_Total_isi_BST1 + $Oil_Recovered_Total_isi_BST2 + 0 + $record->oil_dalam_mobil_cpo - ($record->oil_in_process + $record->pengiriman_cpo_pagi_malam ) - $record->reject_cpo - $record->oil_dalam_mobil_cpo_malam - $record->bst_kemarin);
		$PK_Today = round($pk_bsk + $record->pengiriman_kernel)-($record->pk_bsk + $record->reject_kernel);
		$OER_Today = round($CPO_Today / ($Olah_Netto_today * 0.01),2);
		$KER_Today = round($PK_Today / ($Olah_Netto_today * 0.01),2);
		
		$sql = "SELECT
					tbt_processing_tbs.id
				FROM
					tbt_processing_tbs
				WHERE
					tbt_processing_tbs.deleted = '0'
				AND MONTH(tbt_processing_tbs.tgl_processing) = '".$bulanLhp."'	
				AND YEAR(tbt_processing_tbs.tgl_processing) = '".$tahunLhp."'	
				AND tbt_processing_tbs.tgl_processing < '".$tglLhp."'
				ORDER BY
					tbt_processing_tbs.tgl_processing DESC
				LIMIT 1 ";
		$arr = $this->queryAction($sql,'S');
		
		if($arr)
		{
			$idPrevProcessing = $arr[0]['id'];
			$PrevProcessingTbsReportingRecord = ProcessingTbsReportingRecord::finder()->find('id_processing = ? ',$idPrevProcessing);
			$ProcessingTbsReportingRecord = ProcessingTbsReportingRecord::finder()->find('id_processing = ?',$idProcessing);
			
			if(!$ProcessingTbsReportingRecord)
			{
				$ProcessingTbsReportingRecord = new ProcessingTbsReportingRecord();
				$ProcessingTbsReportingRecord->id_processing = $idProcessing;
			}
				
				$ProcessingTbsReportingRecord->tbs_kebun_sum = $PrevProcessingTbsReportingRecord->tbs_kebun_sum + $record->tbs_kebun;
				$ProcessingTbsReportingRecord->tbs_luar_sum = $PrevProcessingTbsReportingRecord->tbs_luar_sum + $record->tbs_luar;
				$ProcessingTbsReportingRecord->tbs_potongan_sum = $PrevProcessingTbsReportingRecord->tbs_potongan_sum + $record->tbs_potongan;
				$ProcessingTbsReportingRecord->tbs_persediaan_sum = $PrevProcessingTbsReportingRecord->tbs_persediaan_sum + $Persediaan_Today;
				$ProcessingTbsReportingRecord->tbs_olah_netto_sum = $PrevProcessingTbsReportingRecord->tbs_olah_netto_sum + $Olah_Netto_today;
				$ProcessingTbsReportingRecord->tbs_olah_brutto_sum = $PrevProcessingTbsReportingRecord->tbs_olah_brutto_sum + $Olah_Brutto_today;
				$ProcessingTbsReportingRecord->kirim_cpo_sum = $record->pengiriman_cpo + $PrevProcessingTbsReportingRecord->kirim_cpo_sum - $record->reject_cpo;
				$ProcessingTbsReportingRecord->kirim_pk_sum = $PrevProcessingTbsReportingRecord->kirim_pk_sum + $record->pengiriman_kernel;
				$ProcessingTbsReportingRecord->kirim_cangkang_sum = $PrevProcessingTbsReportingRecord->kirim_cangkang_sum + $record->pengiriman_cangkang; 
				$ProcessingTbsReportingRecord->kirim_fibre_sum = $PrevProcessingTbsReportingRecord->kirim_fibre_sum + $record->pengiriman_fibre; 
				$ProcessingTbsReportingRecord->kirim_limbah_sum = $PrevProcessingTbsReportingRecord->kirim_limbah_sum + $record->pengiriman_limbah; 
				$ProcessingTbsReportingRecord->kirim_jangkos_sum = $PrevProcessingTbsReportingRecord->kirim_jangkos_sum + $record->pengiriman_jangkos; 
				$ProcessingTbsReportingRecord->jam_olah_tbs_sum = $this->AddPlayTime(array($PrevProcessingTbsReportingRecord->jam_olah_tbs_sum,$Jam_Olah_Tbs_Today));
				$ProcessingTbsReportingRecord->jam_olah_nut_sum = $this->AddPlayTime(array($PrevProcessingTbsReportingRecord->jam_olah_nut_sum,$Jam_Olah_Nut_Today));
				$ProcessingTbsReportingRecord->jam_main_sum = $this->AddPlayTime(array($PrevProcessingTbsReportingRecord->jam_main_sum,$Jam_Main_Today));
				$ProcessingTbsReportingRecord->jam_down_sum = $this->AddPlayTime(array($PrevProcessingTbsReportingRecord->jam_down_sum,$Jam_Down_Today));
				$ProcessingTbsReportingRecord->cpo_sum = $PrevProcessingTbsReportingRecord->cpo_sum + $CPO_Today;
				$ProcessingTbsReportingRecord->pk_sum = $PrevProcessingTbsReportingRecord->pk_sum + $PK_Today;
				$ProcessingTbsReportingRecord->reject_cpo_sum = $PrevProcessingTbsReportingRecord->reject_cpo_sum + $record->reject_cpo;
				$ProcessingTbsReportingRecord->reject_kernel_sum = $PrevProcessingTbsReportingRecord->reject_kernel_sum + $record->reject_kernel;
				$ProcessingTbsReportingRecord->save();
				
		}
		else
		{
			$ProcessingTbsReportingRecord = ProcessingTbsReportingRecord::finder()->find('id_processing = ?',$idProcessing);
			
			if(!$ProcessingTbsReportingRecord)
			{
				$ProcessingTbsReportingRecord = new ProcessingTbsReportingRecord();
				$ProcessingTbsReportingRecord->id_processing = $idProcessing;
			}
				
				$ProcessingTbsReportingRecord->tbs_kebun_sum = 0;
				$ProcessingTbsReportingRecord->tbs_luar_sum = 0;
				$ProcessingTbsReportingRecord->tbs_potongan_sum = 0;
				$ProcessingTbsReportingRecord->tbs_persediaan_sum = 0;
				$ProcessingTbsReportingRecord->tbs_olah_netto_sum = 0;
				$ProcessingTbsReportingRecord->tbs_olah_brutto_sum = 0;
				$ProcessingTbsReportingRecord->kirim_cpo_sum = 0;
				$ProcessingTbsReportingRecord->kirim_pk_sum = 0;
				$ProcessingTbsReportingRecord->kirim_cangkang_sum = 0;
				$ProcessingTbsReportingRecord->kirim_fibre_sum = 0;
				$ProcessingTbsReportingRecord->kirim_limbah_sum = 0;
				$ProcessingTbsReportingRecord->kirim_jangkos_sum = 0;
				$ProcessingTbsReportingRecord->jam_olah_tbs_sum = 0;
				$ProcessingTbsReportingRecord->jam_olah_nut_sum = 0;
				$ProcessingTbsReportingRecord->jam_main_sum = 0;
				$ProcessingTbsReportingRecord->jam_down_sum = 0;
				$ProcessingTbsReportingRecord->cpo_sum = 0;
				$ProcessingTbsReportingRecord->pk_sum = 0;
				$ProcessingTbsReportingRecord->reject_cpo_sum = 0;
				$ProcessingTbsReportingRecord->reject_kernel_sum = 0;
				$ProcessingTbsReportingRecord->save();
		}
		
		$record->tbs_akhir = $Olah_Akhir;
		$record->bst_akhir = $cpo_bst1 + $cpo_cut_bst1 + $cpo_bst2 + $cpo_cut_bst2;
		$record->bst_in_process = $cpo_in_process;
		$record->pk_bsk_akhir = $pk_bsk;
		$record->save();
	}
	
	public function cetakClicked($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$url = "index.php?page=Inventory.cetakProcessingOrderPdf&idProcessing=".$id;
		
		$folderApp = explode("/",$_SERVER['REQUEST_URI']);
		$urlTemp="http://".$_SERVER['HTTP_HOST']."/".$folderApp[1]."/".$url;
		
		$this->getPage()->getClientScript()->registerEndScript('',"
					var url = '".$urlTemp."';
					window.open(url, '_blank');
					unloadContent();
		");
		
		/*$this->getPage()->getClientScript()->registerEndScript('',"
		jQuery('#cetakFrame').attr('src','".$url."')
		jQuery('#modal-2').modal('show');
		unloadContent();
		");*/
	}
	
	public function checkProcessing()
	{
		$Record =  ProcessingTbsRecord::finder()->find('tgl_processing = ? AND deleted = ?',date("Y-m-d"),'0');
		$queryStockBuahKebun = "SELECT
									SUM(tbd_stok_barang.stok) AS stok
								FROM
									tbd_stok_barang
								WHERE
									tbd_stok_barang.deleted = '0'
								AND tbd_stok_barang.id_barang = '1020' ";
		$arrBuahKebun = $this->queryAction($queryStockBuahKebun,'S');
		$stokBuahKebun = $arrBuahKebun[0]['stok'];
		
		$queryStockBuahLuar = "SELECT
									SUM(tbd_stok_barang.stok) AS stok
								FROM
									tbd_stok_barang
								WHERE
									tbd_stok_barang.deleted = '0'
								AND tbd_stok_barang.id_barang = '1021' ";
		$arrBuahLuar = $this->queryAction($queryStockBuahLuar,'S');
		$stokBuahLuar = $arrBuahLuar[0]['stok'];
		
		if($Record)
		{
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.error("Data Processing Hari Ini Sudah Dimasukkan Sebelumnya !");
						clearForm();
						jQuery("#modal-1").modal("hide");
						unloadContent();');	
		}
		else
		{
			$sql = "SELECT
						tbt_processing_tbs.id
					FROM
						tbt_processing_tbs
					WHERE
						tbt_processing_tbs.deleted = '0'
					AND tbt_processing_tbs.tgl_processing < CURDATE()
					ORDER BY
						tbt_processing_tbs.tgl_processing DESC
					LIMIT 1 ";
			$arr = $this->queryAction($sql,'S');
			if($arr)
			{
				$idProcessing = $arr[0]['id'];
				$Record = ProcessingTbsRecord::finder()->findByPk($idProcessing);
				
				$tbs_akhir = $Record->tbs_akhir;
				$bst_akhir= $Record->bst_akhir;
				$bst_in_process = $Record->bst_in_process;
				$pk_bsk_akhir = $Record->pk_bsk_akhir;
			}
			else
			{
				$tbs_akhir = '';
				$bst_akhir = '';
				$bst_in_process = '';
				$pk_bsk_akhir = '';
			}
		
			$this->getPage()->getClientScript()->registerEndScript
						('','
						clearForm();
						jQuery("#'.$this->tbs_awal->getClientID().'").val("'.$tbs_akhir.'");
						jQuery("#'.$this->tbs_kebun->getClientID().'").val("'.$stokBuahKebun.'");
						jQuery("#'.$this->tbs_luar->getClientID().'").val("'.$stokBuahLuar.'");
						jQuery("#'.$this->bst_kemarin->getClientID().'").val("'.$bst_akhir.'");
						jQuery("#'.$this->oil_in_process->getClientID().'").val("'.$bst_in_process.'");
						jQuery("#'.$this->pk_bsk->getClientID().'").val("'.$pk_bsk_akhir.'");
						jQuery("#modal-1").modal("show");
						unloadContent();');	
		}
	}
	
}
?>
