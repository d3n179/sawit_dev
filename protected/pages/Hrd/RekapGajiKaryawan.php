<?PHP
class RekapGajiKaryawan extends MainConf
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
				$tahun = date("Y");
				$bulan = date("m");
				$arrThn[] = array("id"=>$tahun,'nama'=>$tahun);
				 
				$a = 20;
				$i = 1;
				while($i < $a)
				{
					$arrThn[] = array("id"=>$tahun-$i,'nama'=>$tahun-$i); 
					$i++;
				}
				$this->DDTahun->DataSource = $arrThn;
				$this->DDTahun->DataBind();
				
				$this->DDBulan->SelectedValue = $bulan;
				$this->DDTahun->SelectedValue = $tahun;
				
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
	
	function array_insert(&$array, $position, $insert)
	{
		if (is_int($position)) {
			array_splice($array, $position, 0, $insert);
		} else {
			$pos   = array_search($position, array_keys($array));
			$array = array_merge(
				array_slice($array, 0, $pos),
				$insert,
				array_slice($array, $pos)
			);
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
						tbm_karyawan.nama
					FROM
						tbm_karyawan
					INNER JOIN tbm_jabatan ON tbm_jabatan.id = tbm_karyawan.id_jabatan
					INNER JOIN tbm_department ON tbm_department.id = tbm_jabatan.id_department
					WHERE
						tbm_karyawan.deleted = '0'
					AND tbm_jabatan.deleted = '0'
					AND tbm_department.deleted = '0'
					GROUP BY
						tbm_karyawan.id";
		
		
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
				$arrTmp = array("idKaryawan"=>$idK,
								"gaji_pokok"=>0,
								"tunjangan_natura"=>0,
								"incentive"=>0,
								"tunjangan_jabatan"=>0,
								"tunjangan_komunikasi"=>0,
								"premi_karyawan"=>0,
								"total_gaji"=>0,
								"lembur_lpp_jam"=>0,
								"lembur_lpp_tarif"=>0,
								"lembur_lpp_total"=>0,
								"lembur_lppml_jam"=>0,
								"lembur_lppml_tarif"=>0,
								"lembur_lppml_total"=>0,
								"lembur_lpplk_jam"=>0,
								"lembur_lpplk_tarif"=>0,
								"lembur_lpplk_total"=>0,
								"total_lembur"=>0,
								"mangkir"=>0,
								"terlambat_masuk_kerja"=>0,
								"total_mangkir_terlambat"=>0,
								"total_gaji_kotor"=>0,
								"bpjs_kesehatan_perusahaan"=>0,
								"bpjs_kesehatan"=>0,
								"bpjs_ketenagakerjaan_perusahaan"=>0,
								"bpjs_ketenagakerjaan"=>0,
								"pinjaman"=>0,
								"kantin"=>0,
								"koperasi"=>0,
								"total_potongan"=>0,
								"gaji_dibayarkan"=>0);
				
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
				$tblBody .= '<td>'.number_format($GolonganKaryawanRecord->gaji_pokok,0,'.',',').'</td>';
				$totalGajiKotor += $GolonganKaryawanRecord->gaji_pokok;
				$arrTmp['gaji_pokok'] = $GolonganKaryawanRecord->gaji_pokok;
				
				$tblBody .= '<td>'.number_format($KaryawanRecord->tunjangan_natura,0,'.',',').'</td>';	
				$totalGajiKotor += $KaryawanRecord->tunjangan_natura;
				$arrTmp['tunjangan_natura'] = $KaryawanRecord->tunjangan_natura;
				
				$tblBody .= '<td>'.number_format($IncentiveRecord->jml_incentive,0,'.',',').'</td>';
				$totalGajiKotor += $IncentiveRecord->jml_incentive;
				$arrTmp['incentive'] = $IncentiveRecord->jml_incentive;
					
				$tblBody .= '<td>'.number_format($JabatanRecord->tunjangan_jabatan,0,'.',',').'</td>';	
				$totalGajiKotor += $JabatanRecord->tunjangan_jabatan;
				$arrTmp['tunjangan_jabatan'] = $JabatanRecord->tunjangan_jabatan;
				
				$tblBody .= '<td>'.number_format($JabatanRecord->tunjangan_komunikasi,0,'.',',').'</td>';	
				$totalGajiKotor += $JabatanRecord->tunjangan_komunikasi;
				$arrTmp['tunjangan_komunikasi'] = $JabatanRecord->tunjangan_komunikasi;
				
				$tblBody .= '<td>'.number_format($JabatanRecord->premi_karyawan,0,'.',',').'</td>';	
				$totalGajiKotor += $JabatanRecord->premi_karyawan;
				$arrTmp['premi_karyawan'] = $JabatanRecord->premi_karyawan;
				
				$tblBody .= '<td>'.number_format($totalGajiKotor,0,'.',',').'</td>';	
				$arrTmp['total_gaji'] = $totalGajiKotor;
				
				$sqlLpp = "SELECT
								SUM(
									tbt_lembur_karyawan.lama_lembur
								) AS lama_lembur
							FROM
								tbt_lembur_karyawan
							WHERE
								tbt_lembur_karyawan.id_karyawan = '$idK'
							AND MONTH(tbt_lembur_karyawan.tgl) = '$month'
							AND YEAR(tbt_lembur_karyawan.tgl) = '$year'
							AND tbt_lembur_karyawan.jns_lembur = '1'
							AND tbt_lembur_karyawan.deleted != '1' ";
				$arrLpp = $this->queryAction($sqlLpp,'S');
				$tarifLpp = (1/173) * $GolonganKaryawanRecord->gaji_pokok;
				$jmlLpp = $arrLpp[0]['lama_lembur'] * $tarifLpp;
				$tblBody .= '<td>'.$arrLpp[0]['lama_lembur'].'</td>';	
				$tblBody .= '<td>'.number_format($tarifLpp,0,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($jmlLpp,0,'.',',').'</td>';	
				$totalLembur += $jmlLpp;
				$arrTmp['lembur_lpp_jam'] = $arrLpp[0]['lama_lembur'];
				$arrTmp['lembur_lpp_tarif'] = $tarifLpp;
				$arrTmp['lembur_lpp_total'] = $jmlLpp;
				
				$sqlLppml = "SELECT
								SUM(
									tbt_lembur_karyawan.lama_lembur
								) AS lama_lembur
							FROM
								tbt_lembur_karyawan
							WHERE
								tbt_lembur_karyawan.id_karyawan = '$idK'
							AND MONTH(tbt_lembur_karyawan.tgl) = '$month'
							AND YEAR(tbt_lembur_karyawan.tgl) = '$year'
							AND tbt_lembur_karyawan.jns_lembur = '2'
							AND tbt_lembur_karyawan.deleted != '1' ";
				$arrLppml = $this->queryAction($sqlLppml,'S');
				$tarifLppml = ((1/173) * $GolonganKaryawanRecord->gaji_pokok) * 1.5;
				$jmlLppml = $arrLppml[0]['lama_lembur'] * $tarifLppml;
				$tblBody .= '<td>'.$arrLppml[0]['lama_lembur'].'</td>';	
				$tblBody .= '<td>'.number_format($tarifLppml,0,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($jmlLppml,0,'.',',').'</td>';	
				$totalLembur += $jmlLppml;
				$arrTmp['lembur_lppml_jam'] = $arrLppml[0]['lama_lembur'];
				$arrTmp['lembur_lppml_tarif'] = $tarifLppml;
				$arrTmp['lembur_lppml_total'] = $jmlLppml;
				
				$sqlLpplk = "SELECT
								SUM(
									tbt_lembur_karyawan.lama_lembur
								) AS lama_lembur
							FROM
								tbt_lembur_karyawan
							WHERE
								tbt_lembur_karyawan.id_karyawan = '$idK'
							AND MONTH(tbt_lembur_karyawan.tgl) = '$month'
							AND YEAR(tbt_lembur_karyawan.tgl) = '$year'
							AND tbt_lembur_karyawan.jns_lembur = '3'
							AND tbt_lembur_karyawan.deleted != '1' ";
				$arrLpplk = $this->queryAction($sqlLpplk,'S');
				$tarifLpplk = ((1/173) * $GolonganKaryawanRecord->gaji_pokok) * 2;
				$jmlLpplk = $arrLpplk[0]['lama_lembur'] * $tarifLpplk;
				$tblBody .= '<td>'.$arrLpplk[0]['lama_lembur'].'</td>';	
				$tblBody .= '<td>'.number_format($tarifLpplk,0,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($jmlLpplk,0,'.',',').'</td>';	
				$totalLembur += $jmlLpplk;
				$arrTmp['lembur_lpplk_jam'] = $arrLpplk[0]['lama_lembur'];
				$arrTmp['lembur_lpplk_tarif'] = $tarifLpplk;
				$arrTmp['lembur_lpplk_total'] = $jmlLpplk;
				
				$tblBody .= '<td>'.number_format($totalLembur,0,'.',',').'</td>';	
				$totalGajiKotor += $totalLembur;
				$arrTmp['total_lembur'] = $totalLembur;
				
				$sqlMangkir = "SELECT
									COUNT(
										tbm_jadwal.id
									) AS mangkir
								FROM
									tbm_jadwal
								WHERE
									tbm_jadwal.idkaryawan = '$idK'
								AND tbm_jadwal.st_hadir = '1'
								AND MONTH(tbm_jadwal.tanggal) = '$month'
								AND YEAR(tbm_jadwal.tanggal) = '$year' ";
				$arrMangkir = $this->queryAction($sqlMangkir,'S');
				$jmlMangkir = $arrMangkir[0]['mangkir'];
				$totalMangkir = ($GolonganKaryawanRecord->gaji_pokok / 25) * $jmlMangkir;
				$baris++;
				$kolom = 11;
				$tblBody .= '<td>'.number_format($totalMangkir,0,'.',',').'</td>';	
				$totalTelatMangkir += $totalMangkir;
				$arrTmp['mangkir'] = $totalMangkir;
				
				$sqlTelat = "SELECT
									COUNT(
										tbm_jadwal.id
									) AS telat
								FROM
									tbm_jadwal
								WHERE
									tbm_jadwal.idkaryawan = '$idK'
								AND tbm_jadwal.st_hadir = '0'
								AND tbm_jadwal.st_telat = '1'
								AND MONTH(tbm_jadwal.tanggal) = '$month'
								AND YEAR(tbm_jadwal.tanggal) = '$year' ";
				$arrTelat = $this->queryAction($sqlTelat,'S');
				$jmlTelat = $arrTelat[0]['telat'];
				$totalTelat = ($GolonganKaryawanRecord->gaji_pokok / 25 / 7) * $jmlTelat;
				$baris++;
				$kolom = 11;
				$tblBody .= '<td>'.number_format($totalTelat,0,'.',',').'</td>';	
				$totalTelatMangkir += $totalTelat;
				$arrTmp['terlambat_masuk_kerja'] = $totalTelat;
				
				$tblBody .= '<td>'.number_format($totalTelatMangkir,0,'.',',').'</td>';	
				$totalGajiKotor -= $totalTelatMangkir;
				$arrTmp['total_mangkir_terlambat'] = $totalTelat;
				
				$tblBody .= '<td>'.number_format($totalGajiKotor,0,'.',',').'</td>';	
				$arrTmp['total_gaji_kotor'] = $totalGajiKotor;
				
				if($KaryawanRecord->st_bpjs_kesehatan == '1')
				{
					/*if($KaryawanRecord->tambahan_keluarga > 0)
						$multiplyBpjs = $KaryawanRecord->tambahan_keluarga + 1;
					else
						$multiplyBpjs = 1;*/
					
					$BpjsKaryawanRecord = BpjsKaryawanRecord::finder()->find('id_karyawan = ? AND jns_bpjs = ? AND deleted = ?',$KaryawanRecord->id,'0','0');
					
					if($BpjsKaryawanRecord)	
					{
						$Pengali = 1 + $BpjsKaryawanRecord->tambahan_keluarga;
						$bpjsKesehatan = $BpjsKaryawanRecord->karyawan * $Pengali;
						$bpjsKesehatanPerusahaan = $BpjsKaryawanRecord->perusahaan;
					}
					else
					{
						$bpjsKesehatan = 0;
						$bpjsKesehatanPerusahaan = 0;
					}
				}
				else
				{
					$bpjsKesehatan = 0;
					$bpjsKesehatanPerusahaan = 0;
				}
				
				$tblBody .= '<td>'.number_format($bpjsKesehatan,0,'.',',').'</td>';
				$totalPotongan += $bpjsKesehatan;
				$arrTmp['bpjs_kesehatan'] = $bpjsKesehatan;
				$arrTmp['bpjs_kesehatan_perusahaan'] = $bpjsKesehatanPerusahaan;
				
				if($KaryawanRecord->st_bpjs_ketenagakerjaan == '1')
				{
					//$bpjsTenagaKerja = $GolonganKaryawanRecord->gaji_pokok * (2/100);
					
					$BpjsKaryawanRecord = BpjsKaryawanRecord::finder()->find('id_karyawan = ? AND jns_bpjs = ? AND deleted = ?',$KaryawanRecord->id,'1','0');
					
					if($BpjsKaryawanRecord)	
					{
						$bpjsTenagaKerja = $BpjsKaryawanRecord->karyawan;
						$bpjsTenagaKerjaPerusahaan = $BpjsKaryawanRecord->perusahaan;
					}
					else
					{
						$bpjsTenagaKerja = 0;
						$bpjsTenagaKerjaPerusahaan = 0;
					}
						
				}
				else
				{
					$bpjsTenagaKerja = 0;
					$bpjsTenagaKerjaPerusahaan = 0;
				}
				
				$tblBody .= '<td>'.number_format($bpjsTenagaKerja,0,'.',',').'</td>';
				$totalPotongan += $bpjsTenagaKerja;
				$arrTmp['bpjs_ketenagakerjaan'] = $bpjsTenagaKerja;
				$arrTmp['bpjs_ketenagakerjaan_perusahaan'] = $bpjsTenagaKerjaPerusahaan;
				
				$sqlPinjaman = "SELECT
									SUM(
										tbt_expense_karyawan.jml_expense
									) AS jml_expense
								FROM
									tbt_expense_karyawan
								WHERE
									tbt_expense_karyawan.id_karyawan = '$idK'
								AND tbt_expense_karyawan.jns_expense = '1'
								AND MONTH(tbt_expense_karyawan.tgl) = '$month'
								AND YEAR(tbt_expense_karyawan.tgl) = '$year'
								AND tbt_expense_karyawan.deleted != '1' ";
				$arrPinjaman = $this->queryAction($sqlPinjaman,'S');
				$jmlPinjaman = $arrPinjaman[0]['jml_expense'];
				$tblBody .= '<td>'.number_format($jmlPinjaman,0,'.',',').'</td>';
				$totalPotongan += $jmlPinjaman;
				$arrTmp['pinjaman'] = $jmlPinjaman;
				
				$sqlKantin = "SELECT
									SUM(
										tbt_expense_karyawan.jml_expense
									) AS jml_expense
								FROM
									tbt_expense_karyawan
								WHERE
									tbt_expense_karyawan.id_karyawan = '$idK'
								AND tbt_expense_karyawan.jns_expense = '2'
								AND MONTH(tbt_expense_karyawan.tgl) = '$month'
								AND YEAR(tbt_expense_karyawan.tgl) = '$year'
								AND tbt_expense_karyawan.deleted != '1' ";
				$arrKantin = $this->queryAction($sqlKantin,'S');
				$jmlKantin = $arrKantin[0]['jml_expense'];
				$tblBody .= '<td>'.number_format($jmlKantin,0,'.',',').'</td>';
				$totalPotongan += $jmlKantin;
				$arrTmp['kantin'] = $jmlKantin;
				
				$sqlKoperasi = "SELECT
									SUM(
										tbt_expense_karyawan.jml_expense
									) AS jml_expense
								FROM
									tbt_expense_karyawan
								WHERE
									tbt_expense_karyawan.id_karyawan = '$idK'
								AND tbt_expense_karyawan.jns_expense = '3'
								AND MONTH(tbt_expense_karyawan.tgl) = '$month'
								AND YEAR(tbt_expense_karyawan.tgl) = '$year'
								AND tbt_expense_karyawan.deleted != '1' ";
				$arrKoperasi = $this->queryAction($sqlKoperasi,'S');
				$jmlKoperasi = $arrKoperasi[0]['jml_expense'];
				$tblBody .= '<td>'.number_format($jmlKoperasi,0,'.',',').'</td>';
				$totalPotongan += $jmlKoperasi;
				$arrTmp['koperasi'] = $jmlKoperasi;
				
				$tblBody .= '<td>'.number_format($totalPotongan,0,'.',',').'</td>';
				$arrTmp['total_potongan'] = $totalPotongan;
				
				$gajiDibayarkan = $totalGajiKotor - $totalPotongan;
				$tblBody .= '<td>'.number_format($gajiDibayarkan,0,'.',',').'</td>';
				$arrTmp['gaji_dibayarkan'] = $gajiDibayarkan;
				
				$tblBody .= '</tr>';
				
				$arrGaji[] = $arrTmp;
			}
		}
		else
		{
			$tblBody = '';
		}
		var_dump($arrGaji);
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
					$RekapGajiDetailRecord->gaji_pokok= $row['gaji_pokok'];
					$RekapGajiDetailRecord->tunjangan_natura= $row['tunjangan_natura'];
					$RekapGajiDetailRecord->incentive= $row['incentive'];
					$RekapGajiDetailRecord->tunjangan_jabatan= $row['tunjangan_jabatan'];
					$RekapGajiDetailRecord->tunjangan_komunikasi= $row['tunjangan_komunikasi'];
					$RekapGajiDetailRecord->premi_karyawan= $row['premi_karyawan'];
					$RekapGajiDetailRecord->total_gaji= $row['total_gaji'];
					$RekapGajiDetailRecord->lembur_lpp_jam= $row['lembur_lpp_jam'];
					$RekapGajiDetailRecord->lembur_lpp_tarif= $row['lembur_lpp_tarif'];
					$RekapGajiDetailRecord->lembur_lpp_total= $row['lembur_lpp_total'];
					$RekapGajiDetailRecord->lembur_lppml_jam= $row['lembur_lppml_jam'];
					$RekapGajiDetailRecord->lembur_lppml_tarif= $row['lembur_lppml_tarif'];
					$RekapGajiDetailRecord->lembur_lppml_total= $row['lembur_lppml_total'];
					$RekapGajiDetailRecord->lembur_lpplk_jam= $row['lembur_lpplk_jam'];
					$RekapGajiDetailRecord->lembur_lpplk_tarif= $row['lembur_lpplk_tarif'];
					$RekapGajiDetailRecord->lembur_lpplk_total= $row['lembur_lpplk_total'];
					$RekapGajiDetailRecord->total_lembur= $row['total_lembur'];
					$RekapGajiDetailRecord->mangkir= $row['mangkir'];
					$RekapGajiDetailRecord->terlambat_masuk_kerja= $row['terlambat_masuk_kerja'];
					$RekapGajiDetailRecord->total_mangkir_terlambat= $row['total_mangkir_terlambat'];
					$RekapGajiDetailRecord->total_gaji_kotor = $row['total_gaji_kotor'];
					$RekapGajiDetailRecord->bpjs_kesehatan = $row['bpjs_kesehatan'];
					$RekapGajiDetailRecord->bpjs_ketenagakerjaan = $row['bpjs_ketenagakerjaan'];
					$RekapGajiDetailRecord->bpjs_kesehatan_perusahaan = $row['bpjs_kesehatan_perusahaan'];
					$RekapGajiDetailRecord->bpjs_ketenagakerjaan_perusahaan = $row['bpjs_ketenagakerjaan_perusahaan'];
					$RekapGajiDetailRecord->pinjaman= $row['pinjaman'];
					$RekapGajiDetailRecord->kantin= $row['kantin'];
					$RekapGajiDetailRecord->koperasi= $row['koperasi'];
					$RekapGajiDetailRecord->total_potongan= $row['total_potongan'];
					$RekapGajiDetailRecord->jml_gaji_dibayarkan = $row['gaji_dibayarkan'];
					$RekapGajiDetailRecord->deleted = '0';
					$RekapGajiDetailRecord->save();
					
					$totalGaji += $row['gaji_dibayarkan'];
				}
				
				$RekapGajiRecord->total_gaji_dibayarkan = $totalGaji;
				$RekapGajiRecord->save();
				
				$this->InsertJurnalUmum($RekapGajiRecord->id,
										'9',
										'0',
										date("Y-m-d"),
										date("G:i:s"),
										"Beban Gaji",
										$totalGaji,
										$RekapGajiRecord->id);
										
				$this->InsertJurnalUmum($RekapGajiRecord->id,
										'9',
										'1',
										date("Y-m-d"),
										date("G:i:s"),
										"Hutang Gaji",
										$totalGaji,
										$RekapGajiRecord->id);
										
				$this->InsertJurnalBukuBesar($RekapGajiRecord->id,
											'9',
											'0',
											$RekapGajiRecord->id,
											date("Y-m-d"),
											date("G:i:s"),
											'',
											'',
											"Beban Gaji",
											"Rekap Gaji Bulan ".$bulan." Tahun ".$tahun,
											$totalGaji);
				
				$this->InsertJurnalBukuBesar($RekapGajiRecord->id,
											'9',
											'0',
											$RekapGajiRecord->id,
											date("Y-m-d"),
											date("G:i:s"),
											'',
											'',
											"Hutang Gaji",
											"Rekap Gaji Bulan ".$bulan." Tahun ".$tahun,
											$totalGaji);
																	
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
	
	public function importBtnClicked()
	{
		$sql = "SELECT
					tbm_karyawan.id,
					rekap_gaji_juni.nama,
					rekap_gaji_juni.gaji_pokok,
					rekap_gaji_juni.tunjangan_natura,
					rekap_gaji_juni.incentive,
					rekap_gaji_juni.tunjangan_jabatan,
					rekap_gaji_juni.tunjangan_komunikasi,
					rekap_gaji_juni.premi_karyawan,
					rekap_gaji_juni.total_gaji,
					rekap_gaji_juni.lembur_lpp_jam,
					rekap_gaji_juni.lembur_lpp_tarif,
					rekap_gaji_juni.lembur_lpp_total,
					rekap_gaji_juni.lembur_lppml_jam,
					rekap_gaji_juni.lembur_lppml_tarif,
					rekap_gaji_juni.lembur_lppml_total,
					rekap_gaji_juni.lembur_lpplk_jam,
					rekap_gaji_juni.lembur_lpplk_tarif,
					rekap_gaji_juni.lembur_lpplk_total,
					rekap_gaji_juni.total_lembur,
					rekap_gaji_juni.mangkir,
					rekap_gaji_juni.terlambat_masuk_kerja,
					rekap_gaji_juni.total_mangkir_terlambat,
					rekap_gaji_juni.total_gaji_kotor,
					rekap_gaji_juni.bpjs_kesehatan,
					rekap_gaji_juni.bpjs_ketenagakerjaan,
					rekap_gaji_juni.pinjaman,
					rekap_gaji_juni.kantin,
					rekap_gaji_juni.koperasi,
					rekap_gaji_juni.total_potongan,
					rekap_gaji_juni.jml_gaji_dibayarkan,
					rekap_gaji_juni.status_bayar,
					rekap_gaji_juni.tgl_pembayaran
				FROM
					rekap_gaji_juni
				LEFT JOIN tbm_karyawan ON LOWER(tbm_karyawan.nama) = LOWER(rekap_gaji_juni.nama)
				AND tbm_karyawan.deleted = '0' ";
		$arr = $this->queryAction($sql,'S');
		if($arr)
		{
			$RekapGajiRecord = new RekapGajiRecord();
			$RekapGajiRecord->bulan = '06';
			$RekapGajiRecord->tahun = '2017';
			$RekapGajiRecord->status = '2';
			$RekapGajiRecord->deleted = '0';
			$RekapGajiRecord->save();
			
			$BayarRekapGajiRecord = new BayarRekapGajiRecord();
			$BayarRekapGajiRecord->no_pembayaran = $this->GenerateNoDocument("RG",'07','2017');
			$BayarRekapGajiRecord->tgl_pembayaran = '2017-07-05';
			$BayarRekapGajiRecord->id_rekap = $RekapGajiRecord->id;
			$BayarRekapGajiRecord->user = $this->User->IsUser;
			$BayarRekapGajiRecord->deleted = '0';
			$BayarRekapGajiRecord->save();
			
			$totalGaji = 0;
			foreach($arr as $row)
			{
				if($row['jml_gaji_dibayarkan'] > 0)
				{
					$RekapGajiDetailRecord = new RekapGajiDetailRecord();
					$RekapGajiDetailRecord->id_rekap = $RekapGajiRecord->id;
					$RekapGajiDetailRecord->id_bayar = $BayarRekapGajiRecord->id;
					$RekapGajiDetailRecord->id_karyawan = $row['id'];
					$RekapGajiDetailRecord->gaji_pokok= $row['gaji_pokok'];
					$RekapGajiDetailRecord->tunjangan_natura= $row['tunjangan_natura'];
					$RekapGajiDetailRecord->incentive= $row['incentive'];
					$RekapGajiDetailRecord->tunjangan_jabatan= $row['tunjangan_jabatan'];
					$RekapGajiDetailRecord->tunjangan_komunikasi= $row['tunjangan_komunikasi'];
					$RekapGajiDetailRecord->premi_karyawan= $row['premi_karyawan'];
					$RekapGajiDetailRecord->total_gaji= $row['total_gaji'];
					$RekapGajiDetailRecord->lembur_lpp_jam= $row['lembur_lpp_jam'];
					$RekapGajiDetailRecord->lembur_lpp_tarif= $row['lembur_lpp_tarif'];
					$RekapGajiDetailRecord->lembur_lpp_total= $row['lembur_lpp_total'];
					$RekapGajiDetailRecord->lembur_lppml_jam= $row['lembur_lppml_jam'];
					$RekapGajiDetailRecord->lembur_lppml_tarif= $row['lembur_lppml_tarif'];
					$RekapGajiDetailRecord->lembur_lppml_total= $row['lembur_lppml_total'];
					$RekapGajiDetailRecord->lembur_lpplk_jam= $row['lembur_lpplk_jam'];
					$RekapGajiDetailRecord->lembur_lpplk_tarif= $row['lembur_lpplk_tarif'];
					$RekapGajiDetailRecord->lembur_lpplk_total= $row['lembur_lpplk_total'];
					$RekapGajiDetailRecord->total_lembur= $row['total_lembur'];
					$RekapGajiDetailRecord->mangkir= $row['mangkir'];
					$RekapGajiDetailRecord->terlambat_masuk_kerja= $row['terlambat_masuk_kerja'];
					$RekapGajiDetailRecord->total_mangkir_terlambat= $row['total_mangkir_terlambat'];
					$RekapGajiDetailRecord->total_gaji_kotor= $row['total_gaji_kotor'];
					$RekapGajiDetailRecord->bpjs_kesehatan= $row['bpjs_kesehatan'];
					$RekapGajiDetailRecord->bpjs_ketenagakerjaan= $row['bpjs_ketenagakerjaan'];
					$RekapGajiDetailRecord->pinjaman= $row['pinjaman'];
					$RekapGajiDetailRecord->kantin= $row['kantin'];
					$RekapGajiDetailRecord->koperasi= $row['koperasi'];
					$RekapGajiDetailRecord->total_potongan= $row['total_potongan'];
					$RekapGajiDetailRecord->jml_gaji_dibayarkan = $row['jml_gaji_dibayarkan'];
					$RekapGajiDetailRecord->status = '1';
					$RekapGajiDetailRecord->id_bank = '11';
					$RekapGajiDetailRecord->jns_bayar = '1';
					$RekapGajiDetailRecord->id_coa = '835';	
					$RekapGajiDetailRecord->deleted = '0';
					$RekapGajiDetailRecord->save();
					
					$this->UbahSaldoKas('1',$RekapGajiDetailRecord->id_bank,$RekapGajiDetailRecord->jml_gaji_dibayarkan);
				
					$this->InsertJurnalUmum($BayarRekapGajiRecord->id,
									'8',
									'0',
									$BayarRekapGajiRecord->tgl_pembayaran,
									date("G:i:s"),
									'Beban Gaji',
									$RekapGajiDetailRecord->jml_gaji_dibayarkan,
									$BayarRekapGajiRecord->no_pembayaran,
									$RekapGajiDetailRecord->id_bank);
					
					$this->InsertJurnalUmum($BayarRekapGajiRecord->id,
									'8',
									'1',
									$BayarRekapGajiRecord->tgl_pembayaran,
									date("G:i:s"),
									'Kas Bank',
									$RekapGajiDetailRecord->jml_gaji_dibayarkan,
									$BayarRekapGajiRecord->no_pembayaran,
									$RekapGajiDetailRecord->id_bank);
					
					/*$this->InsertJurnalBukuBesar($BayarRekapGajiRecord->id,
												'7',
												'1',
												$BayarRekapGajiRecord->no_pembayaran,
												$BayarRekapGajiRecord->tgl_pembayaran,
												date("G:i:s"),
												'',
												'',
												'Hutang Gaji',
												'Pembayaran Gaji Karyawan Kepada '.$row->namaKaryawan,
												$RekapGajiDetailRecord->jml_gaji_dibayarkan);
					
					$this->InsertJurnalBukuBesar($BayarRekapGajiRecord->id,
												'7',
												'1',
												$BayarRekapGajiRecord->no_pembayaran,
												$BayarRekapGajiRecord->tgl_pembayaran,
												date("G:i:s"),
												'',
												'',
												$namaAkun,
												'Pembayaran Gaji Karyawan Kepada '.$row->namaKaryawan,
												$RekapGajiDetailRecord->jml_gaji_dibayarkan);	*/
					$totalGaji += $row['jml_gaji_dibayarkan'];
				}
			}
			
			$RekapGajiRecord->total_gaji_dibayarkan = $totalGaji;
			$RekapGajiRecord->save();
			
			$BayarRekapGajiRecord->total_gaji_dibayarkan = $totalGaji;
			$BayarRekapGajiRecord->save();
			
			$this->InsertJurnalPengeluaranKas($BayarRekapGajiRecord->id,
												$BayarRekapGajiRecord->no_pembayaran,
												'3',
												$BayarRekapGajiRecord->tgl_pembayaran,
												date("G:i:s"),
												'Gaji Karyawan',
												'Beban Gaji',
												'',
												$totalGaji,
												0);
		}
	}
	
	public function cetakLapKartuStok()
	{
		//if($this->DDBulan->SelectedValue != '' && $this->DDTahun->SelectedValue != '')
		//{
		//$this->Response->redirect($this->Service->constructUrl('Hrd.cetakLapRekapGajiKaryawan',
		$url = "index.php?page=Hrd.cetakLaporanRekapGajiKaryawanPreviewPdf&bulan=".$this->DDBulan->SelectedValue."&tahun=".$this->DDTahun->SelectedValue;
		
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
				'tahun'=>$this->DDTahun->SelectedValue)));
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
