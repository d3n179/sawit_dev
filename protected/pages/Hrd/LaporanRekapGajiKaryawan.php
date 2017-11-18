<?PHP
class LaporanRekapGajiKaryawan extends MainConf
{

	public function onLoadComplete($param)
	{
		parent::onLoadComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			//$this->cariBtnClicked($sender,$param);
			if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
			{
				//$this->cariBtnClicked($sender,$param);
				$sqlRekapGaji = "SELECT tbt_rekap_gaji.tahun AS id,tbt_rekap_gaji.tahun AS nama FROM tbt_rekap_gaji WHERE deleted != '1' GROUP BY tahun";
				$arrThn = $this->queryAction($sqlRekapGaji,'S');
				
				$this->DDTahun->DataSource = $arrThn;
				$this->DDTahun->DataBind();
				
				
			}
		}
		
	}
	
	public function onPreRender($param)
	{
		parent::onPreRender($param);
		
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
		}
	}
	
	public function periodeChanged()
	{
		$periode = $this->Periode->SelectedValue;
		if($periode == '0')
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#panelMingguan").hide();
					jQuery("#panelTahunan").show();
					jQuery("#panelBulanan").show();
					');
		}
		elseif($periode == '1')
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#panelMingguan").hide();
					jQuery("#panelTahunan").show();
					jQuery("#panelBulanan").hide();
					');
		}
		elseif($periode == '2')
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#panelMingguan").show();
					jQuery("#panelTahunan").hide();
					jQuery("#panelBulanan").hide();
					');
		}
	}
	
	public function cariBtnClicked($sender,$param)
	{
		$periode = $this->Periode->Text;
		
		$arrGaji = array();
		if($this->DDBulan->SelectedValue != '' && $this->DDTahun->SelectedValue)
		{
		$sqlTrans = "SELECT
						tbm_karyawan.id,
						tbm_karyawan.nik,
						tbm_karyawan.nama,
						tbt_rekap_gaji_detail.gaji_pokok,
						tbt_rekap_gaji_detail.tunjangan_natura,
						tbt_rekap_gaji_detail.incentive,
						tbt_rekap_gaji_detail.tunjangan_jabatan,
						tbt_rekap_gaji_detail.tunjangan_komunikasi,
						tbt_rekap_gaji_detail.premi_karyawan,
						tbt_rekap_gaji_detail.total_gaji,
						tbt_rekap_gaji_detail.lembur_lpp_jam,
						tbt_rekap_gaji_detail.lembur_lpp_tarif,
						tbt_rekap_gaji_detail.lembur_lpp_total,
						tbt_rekap_gaji_detail.lembur_lppml_jam,
						tbt_rekap_gaji_detail.lembur_lppml_tarif,
						tbt_rekap_gaji_detail.lembur_lppml_total,
						tbt_rekap_gaji_detail.lembur_lpplk_jam,
						tbt_rekap_gaji_detail.lembur_lpplk_tarif,
						tbt_rekap_gaji_detail.lembur_lpplk_total,
						tbt_rekap_gaji_detail.total_lembur,
						tbt_rekap_gaji_detail.mangkir,
						tbt_rekap_gaji_detail.terlambat_masuk_kerja,
						tbt_rekap_gaji_detail.total_mangkir_terlambat,
						tbt_rekap_gaji_detail.total_gaji_kotor,
						tbt_rekap_gaji_detail.bpjs_kesehatan,
						tbt_rekap_gaji_detail.bpjs_ketenagakerjaan,
						tbt_rekap_gaji_detail.pinjaman,
						tbt_rekap_gaji_detail.kantin,
						tbt_rekap_gaji_detail.koperasi,
						tbt_rekap_gaji_detail.total_potongan,
						tbt_rekap_gaji_detail.jml_gaji_dibayarkan
					FROM
						tbt_rekap_gaji_detail
					INNER JOIN tbt_rekap_gaji ON tbt_rekap_gaji.id = tbt_rekap_gaji_detail.id_rekap
					INNER JOIN tbm_karyawan ON tbm_karyawan.id = tbt_rekap_gaji_detail.id_karyawan
					WHERE
						tbm_karyawan.deleted = '0'
                    AND tbm_karyawan.aktif = '0'   
					AND tbt_rekap_gaji_detail.deleted = '0'
					AND tbt_rekap_gaji.bulan = '".$this->DDBulan->SelectedValue."' AND tbt_rekap_gaji.tahun = '".$this->DDTahun->SelectedValue."'";
		
		var_dump($sqlTrans);
		$month = $this->DDBulan->SelectedValue;
		$year = $this->DDTahun->SelectedValue;
				
		$arrTrans = $this->queryAction($sqlTrans,'S');
		$tblBody = '';
		if($arrTrans)
		{
			foreach($arrTrans as $row)
			{
				$totalGajiKotor = 0;
				$totalTelatMangkir = 0;
				$totalPotongan = 0;
				$idK = $row['id'];
				$KaryawanRecord = KaryawanRecord::finder()->findByPk($idK);
				$JabatanRecord = JabatanRecord::finder()->findByPk($KaryawanRecord->id_jabatan);
				$DepartmentRecord = DepartmentRecord::finder()->findByPk($JabatanRecord->id_department);
				$SubDepartmentRecord = DepartmentRecord::finder()->findByPk($JabatanRecord->id_subdepartment);
				$KantorCabangRecord = KantorCabangRecord::finder()->findByPk($KaryawanRecord->id_cabang);
				$LevelDistribusiRecord = LevelDistribusiRecord::finder()->findByPk($JabatanRecord->id_level_distribusi);
				$GolonganKaryawanRecord = GolonganKaryawanRecord::finder()->findByPk($KaryawanRecord->id_golongan);
				
				$IncentiveRecord = IncentiveRecord::finder()->find('id_karyawan = ? AND bulan = ? AND tahun = ? ',$idK,$month,$year);
				
				if($KaryawanRecord->id_ptkp == '0')
					$snk = 'S';
				if($KaryawanRecord->id_ptkp == '1')
					$snk = 'K-0';
				if($KaryawanRecord->id_ptkp == '2')
					$snk = 'K-1';
				if($KaryawanRecord->id_ptkp == '3')
					$snk = 'K-2';
				if($KaryawanRecord->id_ptkp == '4')
					$snk = 'K-3';
			
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$DepartmentRecord->nama.'</td>';
				$tblBody .= '<td>'.$row['nik'].'</td>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$JabatanRecord->nama.'</td>';	
				$tblBody .= '<td>'.$GolonganKaryawanRecord->nama.'</td>';	
				$tblBody .= '<td>'.$snk.'</td>';	
				$tblBody .= '<td>'.$this->ConvertDate($KaryawanRecord->tglawalkerja,'3').'</td>';	
				$tblBody .= '<td>'.number_format($row['gaji_pokok'],0,'.',',').'</td>';
				$tblBody .= '<td>'.number_format($row['tunjangan_natura'],0,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($row['incentive'],0,'.',',').'</td>';
				$tblBody .= '<td>'.number_format($row['tunjangan_jabatan'],0,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($row['tunjangan_komunikasi'],0,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($row['premi_karyawan'],0,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($row['total_gaji'],0,'.',',').'</td>';	
				
				$tblBody .= '<td>'.$row['lembur_lpp_jam'].'</td>';	
				$tblBody .= '<td>'.number_format($row['lembur_lpp_tarif'],0,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($row['lembur_lpp_total'],0,'.',',').'</td>';	
				
				$tblBody .= '<td>'.$row['lembur_lppml_jam'].'</td>';	
				$tblBody .= '<td>'.number_format($row['lembur_lppml_tarif'],0,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($row['lembur_lppml_total'],0,'.',',').'</td>';	
				
				$tblBody .= '<td>'.$row['lembur_lpplk_jam'].'</td>';	
				$tblBody .= '<td>'.number_format($row['lembur_lpplk_tarif'],0,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($row['lembur_lpplk_total'],0,'.',',').'</td>';	
			
				$tblBody .= '<td>'.number_format($row['total_lembur'],0,'.',',').'</td>';	
				
				$tblBody .= '<td>'.number_format($row['mangkir'],0,'.',',').'</td>';	
				
				$tblBody .= '<td>'.number_format($row['terlambat_masuk_kerja'],0,'.',',').'</td>';	
				
				
				$tblBody .= '<td>'.number_format($row['total_mangkir_terlambat'],0,'.',',').'</td>';	
				
				$tblBody .= '<td>'.number_format($row['total_gaji_kotor'],0,'.',',').'</td>';	
				
				
				$tblBody .= '<td>'.number_format($row['bpjs_kesehatan'],0,'.',',').'</td>';
				
				$tblBody .= '<td>'.number_format($row['bpjs_ketenagakerjaan'],0,'.',',').'</td>';
				
				$tblBody .= '<td>'.number_format($row['pinjaman'],0,'.',',').'</td>';
				
				$tblBody .= '<td>'.number_format($row['kantin'],0,'.',',').'</td>';
				
				$tblBody .= '<td>'.number_format($row['koperasi'],0,'.',',').'</td>';
				$tblBody .= '<td>'.number_format($row['total_potongan'],0,'.',',').'</td>';
				
				$tblBody .= '<td>'.number_format($row['jml_gaji_dibayarkan'],0,'.',',').'</td>';
				
				$tblBody .= '</tr>';
				
				//$arrGaji[] = array("idKaryawan"=>$row['id'],"Gaji"=>$gajiDibayarkan);
			}
		}
		else
		{
			$tblBody = '';
		}
		
		$this->arrGaji->Value = json_encode($arrGaji,true);
		$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#table-1").dataTable().fnDestroy();
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					BindGrid();
					unloadContent();
					');
		}
		else
		{
			$tblBody = '';
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#table-1").dataTable().fnDestroy();
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					BindGrid();
					unloadContent();
					');
		}
	}
	
	public function detailClicked($sender,$param)
	{
		$idTrans = $param->CallbackParameter->id;
		$sqlDetail = "SELECT
						tbt_penjualan_detail.id,
						tbt_penjualan_detail.id_barang,
						tbm_barang.nama AS barang,
						tbt_penjualan_detail.jml,
						tbt_penjualan_detail.harga,
						tbt_penjualan_detail.total
					FROM
						tbt_penjualan_detail
					INNER JOIN tbm_barang ON tbm_barang.id = tbt_penjualan_detail.id_barang
					WHERE
						tbt_penjualan_detail.deleted ='0'
						AND tbt_penjualan_detail.id_transaksi = '$idTrans' ";
		$arrDetail = $this->queryAction($sqlDetail,'S');
		
		$tblBody = '';
		if($arrDetail > 0)
		{
			foreach($arrDetail as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['barang'].'</td>';
				$tblBody .= '<td>'.$row['jml'].'</td>';
				$tblBody .= '<td>'.$row['harga'].'</td>';
				$tblBody .= '<td>'.$row['total'].'</td>';			
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = '';
		}
		
		$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#tableDetail").dataTable().fnDestroy();
					jQuery("#tableDetail tbody").empty();
					jQuery("#tableDetail tbody").append("'.$tblBody.'");
					BindGridDetail();
					jQuery("#modal-2").modal("show");
					unloadContent();
					');
		
	}
	
	public function closingClicked()
	{
		$bulan = $this->DDBulan->SelectedValue;
		$tahun = $this->DDTahun->SelectedValue;
		$arrGaji = json_decode($this->arrGaji->Value,true);
		
		if(count($arrGaji) > 0)
		{
			$RekapGajiRecord = RekapGajiRecord::finder()->find('bulan = ? AND tahun = ? AND deleted = ?',$bulan,$tahun,'0');
			if(!$RekapGajiRecord)
			{
				$RekapGajiRecord = new RekapGajiRecord();
				$RekapGajiRecord->bulan = $bulan;
				$RekapGajiRecord->tahun = $tahun;
				$RekapGajiRecord->status = '0';
				$RekapGajiRecord->deleted = '0';
				$RekapGajiRecord->save();
				
				$totalGaji = 0;
				foreach($arrGaji as $row)
				{
					$RekapGajiDetailRecord = RekapGajiDetailRecord::finder()->find('id_rekap = ? AND id_karyawan = ? AND deleted = ?',$RekapGajiRecord->id,$row['idKaryawan'],'0');
					
					if(!$RekapGajiDetailRecord)
						$RekapGajiDetailRecord = new RekapGajiDetailRecord();
						
					$RekapGajiDetailRecord->id_rekap = $RekapGajiRecord->id;
					$RekapGajiDetailRecord->id_karyawan = $row['idKaryawan'];
					$RekapGajiDetailRecord->jml_gaji_dibayarkan = $row['Gaji'];
					$RekapGajiDetailRecord->deleted = '0';
					$RekapGajiDetailRecord->save();
					
					$totalGaji += $row['Gaji'];
				}
				
				$RekapGajiRecord->total_gaji_dibayarkan = $totalGaji;
				$RekapGajiRecord->save();
				
				$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						toastr.info("Rekap Gaji Berhasil Diclosing !");
						');	
			}
			else
			{
				$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						toastr.error("Rekap Gaji Bulan Ini Sudah Diclosing Sebelumnya !");
						');	
			}
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						toastr.error("Rekap Gaji Belum Diproses !");
						');	
		}
	}
	
	public function cetakLapKartuStok()
	{
		//if($this->DDBulan->SelectedValue != '' && $this->DDTahun->SelectedValue != '')
		//{
		//$this->Response->redirect($this->Service->constructUrl('Hrd.cetakLapRekapGajiKaryawan',
		$url = "index.php?page=Hrd.cetakLaporanRekapGajiKaryawanPdf&bulan=".$this->DDBulan->SelectedValue."&tahun=".$this->DDTahun->SelectedValue;
		
		$folderApp = explode("/",$_SERVER['REQUEST_URI']);
		$urlTemp="http://".$_SERVER['HTTP_HOST']."/".$folderApp[1]."/".$url;
		
		$this->getPage()->getClientScript()->registerEndScript
							('','
							var url = "'.$urlTemp.'";
							window.open(url, "_blank");
							unloadContent();');	
			/*$this->Response->redirect($this->Service->constructUrl('Hrd.cetakLapRekapGajiKaryawan',
				array(
				'bulan'=>$this->DDBulan->SelectedValue,
				'tahun'=>$this->DDTahun->SelectedValue)));*/
		/*}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					toastr.error("Pilih Bulan Dan Tahun !");
					');
		}*/
	}
	
}
?>
