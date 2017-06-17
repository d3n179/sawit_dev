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
				$tahun = date("Y");
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
						tbm_karyawan.nama
					FROM 
						tbm_karyawan
					WHERE
						tbm_karyawan.deleted = '0' ";
		
		
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
				$tblBody .= '<td>'.number_format($GolonganKaryawanRecord->gaji_pokok,0,'.',',').'</td>';
				$totalGajiKotor += $GolonganKaryawanRecord->gaji_pokok;
				
				$tblBody .= '<td>'.number_format($KaryawanRecord->tunjangan_natura,0,'.',',').'</td>';	
				$totalGajiKotor += $KaryawanRecord->tunjangan_natura;
				
				$tblBody .= '<td>'.number_format($IncentiveRecord->jml_incentive,0,'.',',').'</td>';
				$totalGajiKotor += $IncentiveRecord->jml_incentive;
					
				$tblBody .= '<td>'.number_format($JabatanRecord->tunjangan_jabatan,0,'.',',').'</td>';	
				$totalGajiKotor += $JabatanRecord->tunjangan_jabatan;
				
				$tblBody .= '<td>'.number_format($JabatanRecord->tunjangan_komunikasi,0,'.',',').'</td>';	
				$totalGajiKotor += $JabatanRecord->tunjangan_komunikasi;
				
				$tblBody .= '<td>'.number_format($JabatanRecord->premi_karyawan,0,'.',',').'</td>';	
				$totalGajiKotor += $JabatanRecord->premi_karyawan;
				
				$tblBody .= '<td>'.number_format($totalGajiKotor,0,'.',',').'</td>';	
				
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
				
				$tblBody .= '<td>'.number_format($totalLembur,0,'.',',').'</td>';	
				$totalGajiKotor += $totalLembur;
				
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
				$totalMangkir = ($GolonganKaryawanRecord->gaji_pokok / 25 / 7) * $jmlMangkir;
				$baris++;
				$kolom = 11;
				$tblBody .= '<td>'.number_format($totalMangkir,0,'.',',').'</td>';	
				$totalTelatMangkir += $totalMangkir;
				
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
				
				$tblBody .= '<td>'.number_format($totalTelatMangkir,0,'.',',').'</td>';	
				$totalGajiKotor -= $totalTelatMangkir;
				
				$tblBody .= '<td>'.number_format($totalGajiKotor,0,'.',',').'</td>';	
				
				if($KaryawanRecord->st_bpjs_kesehatan == '1')
				{
					if($KaryawanRecord->tambahan_keluarga > 0)
						$multiplyBpjs = $KaryawanRecord->tambahan_keluarga + 1;
					else
						$multiplyBpjs = 1;
						
					$bpjsKesehatan = ($GolonganKaryawanRecord->gaji_pokok * (1/100)) * $multiplyBpjs;
				}
				else
					$bpjsKesehatan = 0;
				
				$tblBody .= '<td>'.number_format($bpjsKesehatan,0,'.',',').'</td>';
				$totalPotongan += $bpjsKesehatan;
				
				if($KaryawanRecord->st_bpjs_ketenagakerjaan == '1')
					$bpjsTenagaKerja = $GolonganKaryawanRecord->gaji_pokok * (2/100);
				else
					$bpjsTenagaKerja = 0;
				
				$tblBody .= '<td>'.number_format($bpjsTenagaKerja,0,'.',',').'</td>';
				$totalPotongan += $bpjsTenagaKerja;
				
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
				
				$tblBody .= '<td>'.number_format($totalPotongan,0,'.',',').'</td>';
				
				$gajiDibayarkan = $totalGajiKotor - $totalPotongan;
				$tblBody .= '<td>'.number_format($gajiDibayarkan,0,'.',',').'</td>';
				
				$tblBody .= '</tr>';
				
				$arrGaji[] = array("idKaryawan"=>$row['id'],"Gaji"=>$gajiDibayarkan);
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
		
			$this->Response->redirect($this->Service->constructUrl('Hrd.cetakLapRekapGajiKaryawan',
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
