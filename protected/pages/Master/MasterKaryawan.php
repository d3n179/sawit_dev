<?PHP
class MasterKaryawan extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
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
	
	public function onPreRender($param)
	{
		parent::onPreRender($param);
		
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$sql = "SELECT 
						id,
						nama
					FROM 
						tbm_cabang 
					WHERE 
						deleted ='0' ";
			$arr = $this->queryAction($sql,'S');
			$this->id_cabang->DataSource = $arr;
			$this->id_cabang->DataBind();
			
			$sql = "SELECT 
						id,
						nama
					FROM 
						tbm_jabatan 
					WHERE 
						deleted ='0' ";
			$arr = $this->queryAction($sql,'S');
			$this->id_jabatan->DataSource = $arr;
			$this->id_jabatan->DataBind();
			
			$sql = "SELECT 
						id,
						nama
					FROM 
						tbm_kota
					WHERE 
						deleted ='0' ";
			$arr = $this->queryAction($sql,'S');
			$this->id_kota->DataSource = $arr;
			$this->id_kota->DataBind();
			
			$sql = "SELECT 
						id,
						nama
					FROM 
						tbm_agama
					WHERE 
						deleted ='0' ";
			$arr = $this->queryAction($sql,'S');
			$this->id_agama->DataSource = $arr;
			$this->id_agama->DataBind();
			
			$sql = "SELECT 
						id,
						nama
					FROM 
						tbm_pendidikan
					WHERE 
						deleted ='0' ";
			$arr = $this->queryAction($sql,'S');
			$this->id_pendidikan->DataSource = $arr;
			$this->id_pendidikan->DataBind();	
			
			$sql = "SELECT 
						id,
						nama
					FROM 
						tbm_status_karyawan
					WHERE 
						deleted ='0' ";
			$arr = $this->queryAction($sql,'S');
			$this->status_karyawan->DataSource = $arr;
			$this->status_karyawan->DataBind();	
			
			$sql = "SELECT 
						id,
						nama
					FROM 
						tbm_golongan_karyawan
					WHERE 
						deleted ='0' ";
			$arr = $this->queryAction($sql,'S');
			$this->golongan_karyawan->DataSource = $arr;
			$this->golongan_karyawan->DataBind();	
			
			$sql = "SELECT 
						id,
						nama
					FROM 
						tbm_bank
					WHERE 
						deleted ='0' ";
			$arr = $this->queryAction($sql,'S');
			$this->id_bank->DataSource = $arr;
			$this->id_bank->DataBind();	
							
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#table-1 tbody").append("'.$tblBody.'");');	
		}
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbm_karyawan.id,
					a.nama AS cabang,
					tbm_karyawan.nik,
					tbm_karyawan.nama,
					c.nama AS department,
					d.nama AS subdepartment,
					tbm_jabatan.nama AS jabatan,
					tbm_karyawan.tglawalkerja,
					tbm_karyawan.tgllahir,
					tbm_status_karyawan.nama AS status_karyawan,
					b.nama AS posisi_dinas
				FROM
					tbm_karyawan
				INNER JOIN tbm_cabang a ON a.id = tbm_karyawan.id_cabang
				INNER JOIN tbm_cabang b ON b.id = tbm_karyawan.posisi_dinas
				INNER JOIN tbm_jabatan ON tbm_jabatan.id = tbm_karyawan.id_jabatan
				INNER JOIN tbm_department c ON c.id = tbm_jabatan.id_department
				INNER JOIN tbm_department d ON d.id = tbm_jabatan.id_subdepartment
				INNER JOIN tbm_status_karyawan ON tbm_status_karyawan.id = tbm_karyawan.status_karyawan
				WHERE
					tbm_karyawan.deleted = '0'
					AND a.deleted = '0' 
					AND b.deleted = '0' 
					AND c.deleted = '0' 
					AND d.deleted = '0' 
					AND tbm_jabatan.deleted = '0'
				ORDER BY 
					tbm_karyawan.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
				$date1 = $row['tglawalkerja'];
				$date2 = date('Y-m-d');
				$diff = abs(strtotime($date2) - strtotime($date1));
				$years = floor($diff / (365*60*60*24));
				$masaKerja = $years." Tahun";
				
				$date1 = $row['tgllahir'];
				$date2 = date('Y-m-d');
				$diff = abs(strtotime($date2) - strtotime($date1));
				$years = floor($diff / (365*60*60*24));
				$umur = $years." Tahun";
			
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['cabang'].'</td>';
				$tblBody .= '<td>'.$row['nik'].'</td>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$row['department'].'</td>';
				$tblBody .= '<td>'.$row['subdepartment'].'</td>';
				$tblBody .= '<td>'.$row['jabatan'].'</td>';
				$tblBody .= '<td>'.$masaKerja.'</td>';
				$tblBody .= '<td>'.$umur.'</td>';
				$tblBody .= '<td>'.$row['status_karyawan'].'</td>';
				$tblBody .= '<td>'.$row['posisi_dinas'].'</td>';
				$tblBody .= '<td>';
				$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
				$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';	
				$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-blue btn-sm btn-icon icon-left\" OnClick=\"cetakClicked('.$row['id'].')\"><i class=\"entypo-print\"></i>Slip Gaji</a>&nbsp;&nbsp;';	
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
	
	public function tenagaKerjaChanged()
	{
		$this->upah_tenaga_kerja->Text = '';
		$this->perusahaan_tenaga_kerja->Text = '';
		$this->karyawan_tenaga_kerja->Text = '';
			
		if($this->st_bpjs_ketenagakerjaan->SelectedValue == '1')
		{
			if($this->golongan_karyawan->SelectedValue != '')
			{
				$GolonganKaryawanRecord = GolonganKaryawanRecord::finder()->findByPk($this->golongan_karyawan->SelectedValue);
				if($GolonganKaryawanRecord)
				{
					$this->upah_tenaga_kerja->Text = $GolonganKaryawanRecord->gaji_pokok;
					$upah = $GolonganKaryawanRecord->gaji_pokok;
					$perusahaan = $upah * (4.54/100);
					$karyawan = $upah * (2/100);
					$this->perusahaan_tenaga_kerja->Text = $perusahaan;
					$this->karyawan_tenaga_kerja->Text = $karyawan;
					$this->total_tenaga_kerja->Text = $perusahaan + $karyawan;
				}
			}
			$this->upah_tenaga_kerja->Enabled = true;
			$this->perusahaan_tenaga_kerja->Enabled = true;
			$this->karyawan_tenaga_kerja->Enabled = true;
		}
		else
		{
			$this->upah_tenaga_kerja->Enabled = false;
			$this->perusahaan_tenaga_kerja->Enabled = false;
			$this->karyawan_tenaga_kerja->Enabled = false;
		}
	}
	
	public function bpjsChanged()
	{
		$this->upah_kesehatan->Text = '';
		$this->perusahaan_kesehatan->Text = '';
		$this->karyawan_kesehatan->Text = '';
		$this->tambahan_keluarga->Text = '';
		$this->total_kesehatan->Text = '';
		
		if($this->st_bpjs_kesehatan->SelectedValue == '1')
		{
			if($this->golongan_karyawan->SelectedValue != '')
			{
				$GolonganKaryawanRecord = GolonganKaryawanRecord::finder()->findByPk($this->golongan_karyawan->SelectedValue);
				if($GolonganKaryawanRecord)
				{
					$this->upah_kesehatan->Text = $GolonganKaryawanRecord->gaji_pokok;
					$upah = $GolonganKaryawanRecord->gaji_pokok;
					$perusahaan = $upah * (4/100);
					$karyawan = $upah * (1/100);
					$this->perusahaan_kesehatan->Text = $perusahaan;
					$this->karyawan_kesehatan->Text = $karyawan;
					
					$initPengali = 1;
					$pengali = $this->tambahan_keluarga->Text + $initPengali;
					$this->total_kesehatan->Text = $perusahaan + ($karyawan + $pengali);
				}
			}
			
			$this->tambahan_keluarga->Enabled = true;
			$this->upah_kesehatan->Enabled = true;
			$this->perusahaan_kesehatan->Enabled = true;
			$this->karyawan_kesehatan->Enabled = true;
		
		}
		else
		{
			$this->tambahan_keluarga->Enabled = false;
			$this->upah_kesehatan->Enabled = false;
			$this->perusahaan_kesehatan->Enabled = false;
			$this->karyawan_kesehatan->Enabled = false;
		}
	}
	
	public function editForm($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$Record = KaryawanRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->modalJudul->Text = 'Edit Karyawan';
			$this->idKaryawan->Value = $id;
			
			$this->id_cabang->SelectedValue = $Record->id_cabang;
			$this->id_jabatan->SelectedValue = $Record->id_jabatan;
			
			$this->golongan_karyawan->SelectedValue = $Record->id_golongan;
			$this->ptkp->SelectedValue = $Record->id_ptkp;
			$this->tunjangan_natura->Text = $Record->tunjangan_natura;
			$this->ktp->Text = $Record->ktp;
			$this->nik->Text = $Record->nik;
			$this->nama->Text = $Record->nama;
			$this->jkel->SelectedValue = $Record->jkel;
			$this->tmplahir->Text = $Record->tmplahir;
			$this->tgllahir->Text = $this->ConvertDate($Record->tgllahir,'1');
			$this->alamat->Text = $Record->alamat;
			$this->id_kota->SelectedValue = $Record->id_kota;
			$this->status_kawin->SelectedValue = $Record->status_kawin;
			$this->id_agama->SelectedValue = $Record->id_agama;
			$this->id_pendidikan->SelectedValue = $Record->id_pendidikan;
			$this->telp->Text = $Record->telp;
			$this->tglawalkerja->Text = $this->ConvertDate($Record->tglawalkerja,'1');
			
			$this->status_karyawan->SelectedValue = $Record->status_karyawan;
			$this->id_bank->SelectedValue = $Record->id_bank;
			$this->norek->Text = $Record->norek;
			$this->id_cabang->SelectedValue = $Record->posisi_dinas;
			$this->st_bpjs_kesehatan->SelectedValue = $Record->st_bpjs_kesehatan;
			$this->bpjsChanged();
			
			if($Record->st_bpjs_kesehatan == '1')
			{
				$BpjsKaryawanRecord = BpjsKaryawanRecord::finder()->find('id_karyawan = ? AND jns_bpjs = ? AND deleted = ?',$Record->id,'0','0');
				if($BpjsKaryawanRecord)
				{
					$this->upah_kesehatan->Text = $BpjsKaryawanRecord->jumlah_upah;
					$this->perusahaan_kesehatan->Text = $BpjsKaryawanRecord->perusahaan;
					$this->karyawan_kesehatan->Text = $BpjsKaryawanRecord->karyawan;
					$this->tambahan_keluarga->Text = $BpjsKaryawanRecord->tambahan_keluarga;
					$this->total_kesehatan->Text = $BpjsKaryawanRecord->total_bpjs;
				}
			}
			
			$this->st_bpjs_ketenagakerjaan->SelectedValue = $Record->st_bpjs_ketenagakerjaan;
			$this->tenagaKerjaChanged();
			if($Record->st_bpjs_ketenagakerjaan == '1')
			{
				$BpjsKaryawanRecord = BpjsKaryawanRecord::finder()->find('id_karyawan = ? AND jns_bpjs = ? AND deleted = ?',$Record->id,'1','0');
				if($BpjsKaryawanRecord)
				{
					$this->upah_tenaga_kerja->Text = $BpjsKaryawanRecord->jumlah_upah;
					$this->perusahaan_tenaga_kerja->Text = $BpjsKaryawanRecord->perusahaan;
					$this->karyawan_tenaga_kerja->Text = $BpjsKaryawanRecord->karyawan;
					$this->total_tenaga_kerja->Text = $BpjsKaryawanRecord->total_bpjs;
				}
			}
			
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
		$Record = KaryawanRecord::finder()->findByPk($id);
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
	
	public function cetakGaji($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		if($id != '0')
		{
			$Record = KaryawanRecord::finder()->findByPk($id);
			if($Record)
			{
				$this->idKaryawanCetak->Value = $id;
				$this->nama_karyawan_lbl->Text = $Record->nama;
				$this->nik_lbl->Text = $Record->nik;
				
				$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						jQuery("#karyawanPanel").show();
						jQuery("#modal-2").modal("show");
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
		else
		{
			$this->idKaryawanCetak->Value = $id;
				
				$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						jQuery("#karyawanPanel").hide();
						jQuery("#modal-2").modal("show");
						');
		}
	}
	
	
	
	public function cetakDataKaryawan()
	{
		$url = "index.php?page=Master.cetakDataKaryawanPdf";
		
		$folderApp = explode("/",$_SERVER['REQUEST_URI']);
		$urlTemp="http://".$_SERVER['HTTP_HOST']."/".$folderApp[1]."/".$url;
		
		$this->getPage()->getClientScript()->registerEndScript
							('','
							var url = "'.$urlTemp.'";
							window.open(url, "_blank");
							unloadContent();');	
			
	}
	
	public function cetakBtnClicked()
	{
		if($this->idKaryawanCetak->Value != '0')
		{
			$this->Response->redirect($this->Service->constructUrl('Hrd.cetakSlipGajiPdf',
				array(
					'bulan'=>$this->DDBulan->SelectedValue,
					'tahun'=>$this->DDTahun->SelectedValue,
					'nik'=>$this->nik_lbl->Text,
					'id'=>$this->idKaryawanCetak->Value)));
		}	
		else
		{
			$this->Response->redirect($this->Service->constructUrl('Hrd.cetakMultiSlipGajiPdf',
				array(
					'bulan'=>$this->DDBulan->SelectedValue,
					'tahun'=>$this->DDTahun->SelectedValue,
					'nik'=>$this->nik_lbl->Text,
					'id'=>$this->idKaryawanCetak->Value)));
		}
	}
	
	public function submitBtnClicked($sender,$param)
	{
			if($this->idKaryawan->Value != '')
			{
				$Record = KaryawanRecord::finder()->findByPk($this->idKaryawan->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$Record = new KaryawanRecord();
				$msg = "Data Berhasil Disimpan";
				
			}
			
			$cab = $this->id_cabang->SelectedValue;
			$tglKerja = $this->ConvertDate($this->tglawalkerja->Text,'2');
			$nama = $this->nama->Text;
			$ktp = $this->ktp->Text;
				
			$nik = $cab.substr($tglKerja,5,2).substr($tglKerja,2,2).substr($nama,0,3).substr($ktp,-2);
			$sqlCount = "SELECT id FROM tbm_karyawan WHERE nik LIKE '$nik%' ";
			$counterQuery = $this->queryAction($sqlCount,'S');
				
			$count = count($counterQuery) + 1;
				
			if($count < 10)
				$numUrut = '0000';
			elseif($count < 100)
				$numUrut = '000';
			elseif($count < 1000)
				$numUrut = '00';
			elseif($count < 10000)
				$numUrut = '0';
			else
				$numUrut = '';
					
			$nik = $nik.$numUrut.$count;
				
			
				
			$Record->id_cabang = $this->id_cabang->SelectedValue;
			$Record->id_jabatan = $this->id_jabatan->SelectedValue;
			$Record->id_golongan = $this->golongan_karyawan->SelectedValue;
			$Record->id_ptkp = $this->ptkp->SelectedValue;
			$Record->tunjangan_natura = $this->tunjangan_natura->text;
			$Record->ktp = $this->ktp->Text;
			$Record->nik = $this->nik->Text;
			$Record->nama = $this->nama->Text;
			$Record->jkel = $this->jkel->SelectedValue;
			$Record->tmplahir = $this->tmplahir->Text;
			$Record->tgllahir = $this->ConvertDate($this->tgllahir->Text,'2');
			$Record->alamat = $this->alamat->Text;
			$Record->id_kota = $this->id_kota->SelectedValue;
			$Record->status_kawin = $this->status_kawin->SelectedValue;
			$Record->id_agama = $this->id_agama->SelectedValue;
			$Record->id_pendidikan = $this->id_pendidikan->SelectedValue;
			$Record->telp = $this->telp->Text;
			$Record->tglawalkerja = $this->ConvertDate($this->tglawalkerja->Text,'2');
			$Record->aktif = '0';
			$Record->status_karyawan = $this->status_karyawan->SelectedValue;
			$Record->id_bank = $this->id_bank->SelectedValue;
			$Record->norek = $this->norek->Text;
			$Record->posisi_dinas = $this->id_cabang->SelectedValue;
			$Record->st_bpjs_kesehatan = $this->st_bpjs_kesehatan->SelectedValue;
			$Record->st_bpjs_ketenagakerjaan = $this->st_bpjs_ketenagakerjaan->SelectedValue;
			$Record->tambahan_keluarga = $this->tambahan_keluarga->text;
			$Record->save(); 
			
			
			if($Record->st_bpjs_kesehatan == '1')
			{
				$BpjsKaryawanRecord = BpjsKaryawanRecord::finder()->find('id_karyawan = ? AND jns_bpjs = ? AND deleted = ?',$Record->id,'0','0');
				if(!$BpjsKaryawanRecord)
				{
					$BpjsKaryawanRecord = new BpjsKaryawanRecord();
					$BpjsKaryawanRecord->id_karyawan = $Record->id;
					$BpjsKaryawanRecord->jns_bpjs = '0';
				}
				
				
				$BpjsKaryawanRecord->jumlah_upah = str_replace(",","",$this->upah_kesehatan->Text);
				$BpjsKaryawanRecord->perusahaan = str_replace(",","",$this->perusahaan_kesehatan->Text);
				$BpjsKaryawanRecord->karyawan = str_replace(",","",$this->karyawan_kesehatan->Text);
				$BpjsKaryawanRecord->tambahan_keluarga = $this->tambahan_keluarga->Text;
				$BpjsKaryawanRecord->total_bpjs = str_replace(",","",$this->total_kesehatan->Text);
				$BpjsKaryawanRecord->save();
			}
			else
			{
				$BpjsKaryawanRecord = BpjsKaryawanRecord::finder()->find('id_karyawan = ? AND jns_bpjs = ? AND deleted = ?',$Record->id,'0','0');
				if($BpjsKaryawanRecord)
				{
					$BpjsKaryawanRecord->deleted = '1';
					$BpjsKaryawanRecord->save();
				}
			}
			
			if($Record->st_bpjs_ketenagakerjaan == '1')
			{
				$BpjsKaryawanRecord = BpjsKaryawanRecord::finder()->find('id_karyawan = ? AND jns_bpjs = ? AND deleted = ?',$Record->id,'1','0');
				if(!$BpjsKaryawanRecord)
				{
					$BpjsKaryawanRecord = new BpjsKaryawanRecord();
					$BpjsKaryawanRecord->id_karyawan = $Record->id;
					$BpjsKaryawanRecord->jns_bpjs = '1';
				}
				
				$BpjsKaryawanRecord->jumlah_upah = str_replace(",","",$this->upah_tenaga_kerja->Text);
				$BpjsKaryawanRecord->perusahaan = str_replace(",","",$this->perusahaan_tenaga_kerja->Text);
				$BpjsKaryawanRecord->karyawan = str_replace(",","",$this->karyawan_tenaga_kerja->Text);
				$BpjsKaryawanRecord->total_bpjs = str_replace(",","",$this->total_tenaga_kerja->Text);
				$BpjsKaryawanRecord->save();
			}
			else
			{
				$BpjsKaryawanRecord = BpjsKaryawanRecord::finder()->find('id_karyawan = ? AND jns_bpjs = ? AND deleted = ?',$Record->id,'1','0');
				if($BpjsKaryawanRecord)
				{
					$BpjsKaryawanRecord->deleted = '1';
					$BpjsKaryawanRecord->save();
				}	
			}
			
			$tblBody = $this->BindGrid();
			
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("'.$msg.'");
						clearForm();
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						BindGrid();');	
		
	}
	
	
}
?>
