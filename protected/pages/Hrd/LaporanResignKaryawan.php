<?PHP
class LaporanResignKaryawan extends MainConf
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
				
				$sql = "SELECT id,nama FROM tbm_jabatan WHERE deleted = '0' ";
				$arr = $this->queryAction($sql,'S');
				$this->DDJabatan->DataSource = $arr;
				$this->DDJabatan->DataBind();
				
				$sql = "SELECT id,nama FROM tbm_golongan_karyawan WHERE deleted = '0' ";
				$arr = $this->queryAction($sql,'S');
				$this->DDGolongan->DataSource = $arr;
				$this->DDGolongan->DataBind();
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
						tbm_jabatan.nama AS jabatan,
						tbt_resign_employee.tgl_resign,
						tbt_resign_employee.kategori_resign,
						tbt_resign_employee.keterangan
					FROM
						tbm_karyawan
					INNER JOIN tbt_resign_employee ON tbt_resign_employee.id_karyawan = tbm_karyawan.id
					INNER JOIN tbm_golongan_karyawan ON tbm_golongan_karyawan.id = tbm_karyawan.id_golongan
					INNER JOIN tbm_jabatan ON tbm_jabatan.id = tbm_karyawan.id_jabatan
					WHERE
						tbm_karyawan.deleted = '0' ";
		if($periode == '0')
		{
			$bulan = $this->DDBulan->SelectedValue;
			$tahun = $this->DDTahun->SelectedValue;
			if($bulan != '' && $tahun != '')
			{
				$sqlTrans .=" AND MONTH(tbt_resign_employee.tgl_resign) = '$bulan' AND YEAR(tbt_resign_employee.tgl_resign) = '$tahun' ";
			}
		}
		elseif($periode == '1')
		{
			$tahun = $this->DDTahun->SelectedValue;
			if($tahun != '')
			{
				$sqlTrans .="AND YEAR(tbt_resign_employee.tgl_resign) = '$tahun' ";
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
				$sqlTrans .="AND tbt_resign_employee.tgl_resign BETWEEN '$tgl1' AND '$tgl2' ";
			}
		}	
		elseif($periode == '3')
		{
			$harian = $this->harian->Text;
			if($harian != '')
			{
				$tgl = $this->ConvertDate($harian,'2');
				$sqlTrans .="AND tbt_resign_employee.tgl_resign = '$tgl' ";
			}
		}
		
		if($this->DDJabatan->SelectedValue != '')
		{
			$sqlTrans .=" AND tbm_karyawan.id_jabatan = '".$this->DDJabatan->SelectedValue."' ";
		}
		
		if($this->DDGolongan->SelectedValue != '')
		{
			$sqlTrans .=" AND tbm_karyawan.id_golongan = '".$this->DDGolongan->SelectedValue."' ";
		}
		
		if($this->nmKaryawan->Text != '')
		{
			$sqlTrans .=" AND tbm_karyawan.nama LIKE '".$this->nmKaryawan->Text."%' ";
		}
		
			
		//$sqlTrans .="ORDER BY 
							//tbt_stok_in_out.id_barang,tbt_stok_in_out.tgl,tbt_stok_in_out.wkt ASC ";
							var_dump($sqlTrans);
		$this->setViewState('sql',$sqlTrans);
		$arrTrans = $this->queryAction($sqlTrans,'S');
		$tblBody = '';
		if($arrTrans)
		{
			foreach($arrTrans as $row)
			{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$row['jabatan'].'</td>';
				$tblBody .= '<td>'.$row['golongan'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_resign'],'3').'</td>';
				$tblBody .= '<td>'.$row['kategori_resign'].'</td>';
				$tblBody .= '<td>'.$row['keterangan'].'</td>';
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
	
	public function cetakLapKartuStok()
	{
		//if($this->DDBulan->SelectedValue != '' && $this->DDTahun->SelectedValue != '')
		//{
			$session=new THttpSession;
			$session->open();
			$session['cetakLapResignKaryawanSql'] = $this->getViewState('sql');
					
					$url = "index.php?page=Hrd.cetakLapResignKaryawanPdf&periode=".$this->Periode->SelectedValue."&bln=".$this->DDBulan->SelectedValue."&thn=".$this->DDTahun->SelectedValue."&mingguan=".$this->mingguan->Text."&harian=".$this->harian->Text;
		
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
