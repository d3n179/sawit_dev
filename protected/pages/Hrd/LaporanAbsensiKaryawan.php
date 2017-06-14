<?PHP
class LaporanAbsensiKaryawan extends MainConf
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
				$this->DDBulan->SelectedValue = date("m");
				$this->DDTahun->SelectedValue = date("Y");
				
				
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
					jQuery("#panelHarian").hide();
					jQuery("#panelMingguan").hide();
					jQuery("#panelTahunan").show();
					jQuery("#panelBulanan").show();
					
					');
		}
		elseif($periode == '1')
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#panelHarian").hide();
					jQuery("#panelMingguan").hide();
					jQuery("#panelTahunan").show();
					jQuery("#panelBulanan").hide();
					');
		}
		elseif($periode == '2')
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#panelHarian").hide();
					jQuery("#panelMingguan").show();
					jQuery("#panelTahunan").hide();
					jQuery("#panelBulanan").hide();
					');
		}
		elseif($periode == '3')
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#panelHarian").show();
					jQuery("#panelMingguan").hide();
					jQuery("#panelTahunan").hide();
					jQuery("#panelBulanan").hide();
					');
		}
	}
	
	public function cariBtnClicked($sender,$param)
	{
		$periode = $this->Periode->Text;
		
		$sqlTrans = "SELECT
						tbm_karyawan.id,
						tbm_karyawan.nama,
						tbm_golongan_karyawan.nama AS golongan,
						tbm_jabatan.nama AS jabatan
					FROM
						tbm_karyawan
					INNER JOIN tbm_golongan_karyawan ON tbm_golongan_karyawan.id = tbm_karyawan.id_golongan
					INNER JOIN tbm_jabatan ON tbm_jabatan.id = tbm_karyawan.id_jabatan
					WHERE
						tbm_karyawan.deleted = '0'
					AND tbm_karyawan.aktif = '0'";
		$bulan = $this->DDBulan->SelectedValue;
		$tahun = $this->DDTahun->SelectedValue;
		/*if($periode == '0')
		{
			$bulan = $this->DDBulan->SelectedValue;
			$tahun = $this->DDTahun->SelectedValue;
			if($bulan != '' && $tahun != '')
			{
				$sqlTrans .="AND MONTH(tbt_mutasi_barang.tgl_transaksi) = '$bulan' AND YEAR(tbt_mutasi_barang.tgl_transaksi) = '$tahun' ";
			}
		}
		elseif($periode == '1')
		{
			$tahun = $this->DDTahun->SelectedValue;
			if($tahun != '')
			{
				$sqlTrans .="AND YEAR(tbt_mutasi_barang.tgl_transaksi) = '$tahun' ";
			}
		}				
		elseif($periode == '2')
		{
			$mingguan = $this->mingguan->Text;
			if($mingguan != '')
			{
				$mingguan = explode("-",$mingguan);
				$tgl1 = trim(str_replace("/","-",$mingguan[0]));
				$tgl2 = trim(str_replace("/","-",$mingguan[1]));
				$tgl1 = explode("-",$tgl1);
				$tgl2 = explode("-",$tgl2);
				
				$tgl1 = $tgl1[1]."-".$tgl1[0]."-".$tgl1[2];
				$tgl2 = $tgl2[1]."-".$tgl2[0]."-".$tgl2[2];
				
				$tgl1 = $this->ConvertDate($tgl1,'2');
				$tgl2 = $this->ConvertDate($tgl2,'2');
				$sqlTrans .="AND tbt_mutasi_barang.tgl_transaksi BETWEEN '$tgl1' AND '$tgl2' ";
			}
		}	
		elseif($periode == '3')
		{
			$harian = $this->harian->Text;
			if($harian != '')
			{
				$tgl = $this->ConvertDate($harian,'2');
				$sqlTrans .="AND tbt_mutasi_barang.tgl_transaksi = '$tgl' ";
			}
		}*/
		
			
		//$sqlTrans .="ORDER BY 
							//tbt_stok_in_out.id_barang,tbt_stok_in_out.tgl,tbt_stok_in_out.wkt ASC ";
		$this->setViewState('sql',$sqlTrans);
		$arrTrans = $this->queryAction($sqlTrans,'S');
		$tblBody = '';
		if($arrTrans)
		{
			foreach($arrTrans as $row)
			{
				$arrDetail = $this->getDetailAbsensi($row['id'],$bulan,$tahun);
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$row['jabatan'].'</td>';
				$tblBody .= '<td>'.$row['golongan'].'</td>';
				$tblBody .= '<td>'.$arrDetail['HariKerja'].'</td>';
				$tblBody .= '<td>'.$arrDetail['Hadir'].'</td>';	
				$tblBody .= '<td>'.$arrDetail['Terlambat'].'</td>';
				$tblBody .= '<td>'.$arrDetail['Mangkir'].'</td>';	
				$tblBody .= '<td>'.$arrDetail['LemburLPP'].'</td>';	
				$tblBody .= '<td>'.$arrDetail['LemburLPPML'].'</td>';	
				$tblBody .= '<td>'.$arrDetail['LemburLPPLK'].'</td>';	
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = '';
		}
		
		
		$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#table-1").dataTable().fnDestroy();
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					BindGrid();
					unloadContent();
					');
	}
	
	public function getDetailAbsensi($idKaryawan,$month,$year)
	{
		$sql = "SELECT
					COUNT(tbm_jadwal.id) AS hari_kerja
				FROM
					tbm_jadwal
				WHERE
					MONTH (tbm_jadwal.tanggal) = '$month'
				AND YEAR (tbm_jadwal.tanggal) = '$year'
				AND tbm_jadwal.idkaryawan = '$idKaryawan' ";
		$arr = $this->queryAction($sql,'S');
		$HariKerja = $arr[0]['hari_kerja'];
		
		$sql = "SELECT
					COUNT(tbm_jadwal.id) AS hadir
				FROM
					tbm_jadwal
				WHERE
					MONTH (tbm_jadwal.tanggal) = '$month'
				AND YEAR (tbm_jadwal.tanggal) = '$year'
				AND tbm_jadwal.idkaryawan = '$idKaryawan' 
				AND tbm_jadwal.st_hadir = '0'";
		$arr = $this->queryAction($sql,'S');
		$Hadir = $arr[0]['hadir'];
		
		$sql = "SELECT
					COUNT(tbm_jadwal.id) AS terlambat
				FROM
					tbm_jadwal
				WHERE
					MONTH (tbm_jadwal.tanggal) = '$month'
				AND YEAR (tbm_jadwal.tanggal) = '$year'
				AND tbm_jadwal.idkaryawan = '$idKaryawan' 
				AND tbm_jadwal.st_hadir = '0'
				AND tbm_jadwal.st_telat = '1' ";
		$arr = $this->queryAction($sql,'S');
		$Terlambat = $arr[0]['terlambat'];
		
		$sql = "SELECT
					COUNT(tbm_jadwal.id) AS mangkir
				FROM
					tbm_jadwal
				WHERE
					MONTH (tbm_jadwal.tanggal) = '$month'
				AND YEAR (tbm_jadwal.tanggal) = '$year'
				AND tbm_jadwal.idkaryawan = '$idKaryawan' 
				AND tbm_jadwal.st_hadir = '1'";
		$arr = $this->queryAction($sql,'S');
		$Mangkir = $arr[0]['mangkir'];
		
		$sql = "SELECT
					SUM(
						tbt_lembur_karyawan.lama_lembur
					) AS lama_lembur
				FROM
					tbt_lembur_karyawan
				WHERE
					MONTH (tbt_lembur_karyawan.tgl) = '$month'
				AND YEAR (tbt_lembur_karyawan.tgl) = '$year'
				AND tbt_lembur_karyawan.id_karyawan = '$idKaryawan'
				AND tbt_lembur_karyawan.jns_lembur = '1'";
				
		$arr = $this->queryAction($sql,'S');
		$LemburLPP = $arr[0]['lama_lembur'];
		
		$sql = "SELECT
					SUM(
						tbt_lembur_karyawan.lama_lembur
					) AS lama_lembur
				FROM
					tbt_lembur_karyawan
				WHERE
					MONTH (tbt_lembur_karyawan.tgl) = '$month'
				AND YEAR (tbt_lembur_karyawan.tgl) = '$year'
				AND tbt_lembur_karyawan.id_karyawan = '$idKaryawan'
				AND tbt_lembur_karyawan.jns_lembur = '2'";
				
		$arr = $this->queryAction($sql,'S');
		$LemburLPPML = $arr[0]['lama_lembur'];
		
		$sql = "SELECT
					SUM(
						tbt_lembur_karyawan.lama_lembur
					) AS lama_lembur
				FROM
					tbt_lembur_karyawan
				WHERE
					MONTH (tbt_lembur_karyawan.tgl) = '$month'
				AND YEAR (tbt_lembur_karyawan.tgl) = '$year'
				AND tbt_lembur_karyawan.id_karyawan = '$idKaryawan'
				AND tbt_lembur_karyawan.jns_lembur = '3'";
				
		$arr = $this->queryAction($sql,'S');
		$LemburLPPLK = $arr[0]['lama_lembur'];
		
		return array("HariKerja"=>$HariKerja,"Hadir"=>$Hadir,"Terlambat"=>$Terlambat,"Mangkir"=>$Mangkir,"LemburLPP"=>$LemburLPP,"LemburLPPML"=>$LemburLPPML,"LemburLPPLK"=>$LemburLPPLK);
	}
	
	public function cetakLapKartuStok()
	{
		//if($this->DDBulan->SelectedValue != '' && $this->DDTahun->SelectedValue != '')
		//{
			$session=new THttpSession;
			$session->open();
			$session['cetakLapAbsensiKaryawanSql'] = $this->getViewState('sql');
					$url = "index.php?page=Hrd.cetakLapAbsensiKaryawanPdf&periode=".$this->Periode->SelectedValue."&bln=".$this->DDBulan->SelectedValue."&thn=".$this->DDTahun->SelectedValue."&mingguan=".$this->mingguan->Text."&harian=".$this->harian->Text;
		
		$folderApp = explode("/",$_SERVER['REQUEST_URI']);
		$urlTemp="http://".$_SERVER['HTTP_HOST']."/".$folderApp[1]."/".$url;
		
		$this->getPage()->getClientScript()->registerEndScript
							('','
							var url = "'.$urlTemp.'";
							window.open(url, "_blank");
							unloadContent();');	
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
