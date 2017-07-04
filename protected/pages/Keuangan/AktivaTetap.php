<?PHP
class AktivaTetap extends MainConf
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
	
	
	public function tambahBtnClicked()
	{
		$tgl_perolehan = $this->ConvertDate($this->tgl_perolehan->Text,2);
		$tahunAwal = intval(substr($tgl_perolehan,0,4));
		$umur_ekonomis = $this->umur_ekonomis->Text;
		$nilai_perolehan = str_replace(",","",$this->harga_perolehan->Text);
		$tahunAkhir = $tahunAwal + ($umur_ekonomis - 1);
		$bulanAwal = intval(substr($tgl_perolehan,5,2));
		$tgl_akhir_peggunaan = date('Y-m-d',strtotime($tgl_perolehan. " + ".$umur_ekonomis." year"));
		//$new_date = strtotime('+ 1 year', $date); 
		/*
		var_dump($tgl_akhir_peggunaan);
		var_dump($tahunAwal);
		var_dump($tahunAkhir);*/
		var_dump($tgl_perolehan);
		var_dump($bulanAwal);
		$tarifPenyusutan = (100 / 100) / $umur_ekonomis * 2;
		$akumulasiPenyusutan = 0;
		$batasBulan = 12;
		$bulan = $bulanAwal;
		$arrPenyusutan = array();
		$arrPenyusutan[] = array("tahunPenyusutan"=>"","blnAwal"=>"","jmlBulan"=>"","jmlPenyusutan"=>"","nilaiAktiva"=>round($nilai_perolehan,0));
		while($tahunAwal <= $tahunAkhir)
		{
			if($tahunAwal == $tahunAkhir)
				$batasBulan = $bulanAwal;
			else
				$batasBulan = 12;
				
			$jmlBulan = 1;
			$blnAwal = $bulan;
			while($bulan < $batasBulan)
			{
				$jmlBulan++;
				$bulan++;
			}
			
			var_dump($tahunAwal);
			var_dump($tahunAkhir);
			
				
			$bulan = 1;
			$tahunPenyusutan = $tahunAwal;
			$jmlPenyusutan = $tarifPenyusutan * ($jmlBulan/12) * ($nilai_perolehan);
			$nilai_perolehan -= round($jmlPenyusutan,0);
			$arrPenyusutan[] = array("tahunPenyusutan"=>$tahunPenyusutan,"blnAwal"=>$blnAwal,"jmlBulan"=>$jmlBulan,"jmlPenyusutan"=>round($jmlPenyusutan,0),"nilaiAktiva"=>round($nilai_perolehan,0));
			$tahunAwal++;
		}
		var_dump($arrPenyusutan);
		$thnKe = 0; 
		$tblBody = '';
		foreach($arrPenyusutan as $row)
		{
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$thnKe.'</td>';
				$tblBody .= '<td>'.$row['tahunPenyusutan'].'</td>';
				$tblBody .= '<td>'.$row['jmlPenyusutan'].'</td>';
				$tblBody .= '<td>'.$row['nilaiAktiva'].'</td>';		
				$tblBody .= '</tr>';
				$thnKe++;
		}
		
		$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#table-detail").dataTable().fnDestroy();
						jQuery("#table-detail tbody").empty();
						jQuery("#table-detail tbody").append("'.$tblBody.'");
						BindGridDetail();');
						
		/*$this->getPage()->getClientScript()->registerEndScript
		('','
			unloadContent();
			tambahBtnClicked();
		');*/
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbm_aktiva_tetap.id,
					tbm_aktiva_tetap.kode_akun,
					tbm_aktiva_tetap.nama,
					tbm_aktiva_tetap.tgl_perolehan,
					tbm_aktiva_tetap.harga_perolehan,
					tbm_aktiva_tetap.nilai_residu,
					tbm_aktiva_tetap.umur_ekonomis,
					tbm_aktiva_tetap.jumlah_aktiva
				FROM
					tbm_aktiva_tetap
				WHERE
					tbm_aktiva_tetap.deleted = '0'
				GROUP BY 
					tbm_aktiva_tetap.id
				ORDER BY 
					tbm_aktiva_tetap.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
				$actionBtn='';
				
				//if($row['status'] == '0')
				//{
					$actionBtn .= '<a href=\"javascript:void(0)\"  class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
					$actionBtn .= '<a href=\"javascript:void(0)\"  class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';
				//}
				
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['kode_akun'].'</td>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_perolehan'],'3').'</td>';
				$tblBody .= '<td>'.$row['harga_perolehan'].'</td>';
				$tblBody .= '<td>'.$row['nilai_residu'].'</td>';
				$tblBody .= '<td>'.$row['umur_ekonomis'].' Tahun</td>';
				$tblBody .= '<td>'.$row['jumlah_aktiva'].'</td>';
				$tblBody .= '<td>';
				$tblBody .= $actionBtn;
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
		$Record = AktivaTetapRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->idAktivaTetap->Value = $Record->id;
			$this->kode_akun->Text = $Record->kode_akun;
			$this->nama->Text = $Record->nama;
			$this->tgl_perolehan->Text = $this->ConvertDate($Record->tgl_perolehan,'1');
			$this->harga_perolehan->Text = $Record->harga_perolehan;
			$this->nilai_residu->Text = $Record->nilai_residu;
			$this->umur_ekonomis->Text = $Record->umur_ekonomis;
			$this->jumlah_aktiva->Text = $Record->jumlah_aktiva;
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
		$Record = AktivaTetapRecord::finder()->findByPk($id);
		if($Record)
		{
			$Record->deleted = '1';
			$Record->save();
			
			$sqlDelete = "UPDATE tbd_penyusutan_aktiva SET deleted = '1' WHERE id_aktiva = '".$Record->id."' ";
			$this->queryAction($sqlDelete,'C');
			
			$sqlDeleteDetail = "UPDATE tbd_penyusutan_aktiva_detail INNER JOIN tbd_penyusutan_aktiva ON tbd_penyusutan_aktiva.id = tbd_penyusutan_aktiva_detail.id_penyusutan
							SET tbd_penyusutan_aktiva_detail.deleted = '1' WHERE tbd_penyusutan_aktiva.id_aktiva = '".$Record->id."' ";
			$this->queryAction($sqlDeleteDetail,'C');
			
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
		//if($this->Page->IsValid)
		//{
			$idAktivaTetap = $this->idAktivaTetap->Value;
			$kode_akun = strtoupper($this->kode_akun->Text);
			$nama = strtoupper($this->nama->Text);
			$tgl_perolehan = $this->ConvertDate($this->tgl_perolehan->Text,'2');
			$harga_perolehan = str_replace(",","",$this->harga_perolehan->Text);
			$nilai_residu = str_replace(",","",$this->nilai_residu->Text);
			$umur_ekonomis = $this->umur_ekonomis->Text;
			if($idAktivaTetap != '')
			{
				$Record = AktivaTetapRecord::finder()->findByPk($idAktivaTetap);
				$msg = "Data Berhasil Diedit";
					
			}
			else
			{
					$Record = new AktivaTetapRecord();
					$msg = "Data Berhasil Disimpan";
			}
			
			$Record->kode_akun = $kode_akun;
			$Record->nama = $nama;
			$Record->tgl_perolehan = $tgl_perolehan;
			$Record->harga_perolehan = $harga_perolehan;
			$Record->nilai_residu = $nilai_residu;
			$Record->umur_ekonomis= $umur_ekonomis;
			$Record->tgl_akhir_peggunaan= date('Y-m-d',strtotime($tgl_perolehan. " + ".$umur_ekonomis." year"));
			$Record->jumlah_aktiva = $this->jumlah_aktiva->Text;
			$Record->save(); 	
			
			$sqlDelete = "UPDATE tbd_penyusutan_aktiva SET deleted = '1' WHERE id_aktiva = '".$Record->id."' ";
			$this->queryAction($sqlDelete,'C');
			
			$sqlDeleteDetail = "UPDATE tbd_penyusutan_aktiva_detail INNER JOIN tbd_penyusutan_aktiva ON tbd_penyusutan_aktiva.id = tbd_penyusutan_aktiva_detail.id_penyusutan
							SET tbd_penyusutan_aktiva_detail.deleted = '1' WHERE tbd_penyusutan_aktiva.id_aktiva = '".$Record->id."' ";
			$this->queryAction($sqlDeleteDetail,'C');
			
			$tahunAwal = intval(substr($tgl_perolehan,0,4));
			$nilai_perolehan = str_replace(",","",$this->harga_perolehan->Text);
			$tahunAkhir = $tahunAwal + ($umur_ekonomis - 1);
			$bulanAwal = intval(substr($tgl_perolehan,5,2));
			$tgl_akhir_peggunaan = date('Y-m-d',strtotime($tgl_perolehan. " + ".$umur_ekonomis." year"));
			$tarifPenyusutan = (100 / 100) / $umur_ekonomis * 2;
			$akumulasiPenyusutan = 0;
			$batasBulan = 12;
			$bulan = $bulanAwal;
			$arrPenyusutan = array();
			$arrPenyusutan[] = array("tahunPenyusutan"=>"","blnAwal"=>"","jmlBulan"=>"","jmlPenyusutan"=>"","penyusutanBulanan"=>"","nilaiAktiva"=>round($nilai_perolehan,0));
			while($tahunAwal <= $tahunAkhir)
			{
				if($tahunAwal == $tahunAkhir)
					$batasBulan = $bulanAwal;
				else
					$batasBulan = 12;
					
				$jmlBulan = 1;
				$blnAwal = $bulan;
				while($bulan < $batasBulan)
				{
					$jmlBulan++;
					$bulan++;
				}
					
				$bulan = 1;
				$tahunPenyusutan = $tahunAwal;
				$jmlPenyusutan = $tarifPenyusutan * ($jmlBulan/12) * ($nilai_perolehan);
				$nilai_perolehan -= round($jmlPenyusutan,0);
				$penyusutanBulanan = round($jmlPenyusutan/$jmlBulan,0);
				$arrPenyusutan[] = array("tahunPenyusutan"=>$tahunPenyusutan,"blnAwal"=>$blnAwal,"jmlBulan"=>$jmlBulan,"jmlPenyusutan"=>round($jmlPenyusutan,0),"penyusutanBulanan"=>$penyusutanBulanan,"nilaiAktiva"=>round($nilai_perolehan,0));
				$tahunAwal++;
			}
			
			$thnKe = 0; 
			$tblBody = '';
			foreach($arrPenyusutan as $row)
			{
				$PenyusutanAktivaTetapRecord = new PenyusutanAktivaTetapRecord();
				$PenyusutanAktivaTetapRecord->id_aktiva = $Record->id;
				$PenyusutanAktivaTetapRecord->tahun_ke = $thnKe;
				$PenyusutanAktivaTetapRecord->tahun = $row['tahunPenyusutan'];
				$PenyusutanAktivaTetapRecord->jml_bulan = $row['jmlBulan'];
				$PenyusutanAktivaTetapRecord->nilai_penyusutan = $row['jmlPenyusutan'];
				$PenyusutanAktivaTetapRecord->nilai_aktiva = $row['nilaiAktiva'];
				$PenyusutanAktivaTetapRecord->save();
				if($row['jmlBulan'] > 0)
				{
					$bulan = 1;
					$bulanAwal = $row['blnAwal'];
					while($bulan <= $row['jmlBulan'])
					{
						$hari = cal_days_in_month(CAL_GREGORIAN, $bulanAwal, $row['tahunPenyusutan']);
						
						$PenyusutanAktivaTetapDetailRecord = new PenyusutanAktivaTetapDetailRecord();
						$PenyusutanAktivaTetapDetailRecord->id_penyusutan = $PenyusutanAktivaTetapRecord->id;
						$PenyusutanAktivaTetapDetailRecord->tahun = $row['tahunPenyusutan'];
						$PenyusutanAktivaTetapDetailRecord->bulan = $bulanAwal;
						$PenyusutanAktivaTetapDetailRecord->nilai_penyusutan_bulanan = $row['penyusutanBulanan'];
						$PenyusutanAktivaTetapDetailRecord->jumlah_hari = $hari;
						$PenyusutanAktivaTetapDetailRecord->nilai_penyusutan_harian = round($row['penyusutanBulanan'] / $hari,0);
						$PenyusutanAktivaTetapDetailRecord->save();
						$bulanAwal++;
						$bulan++;
					}
				}
				$thnKe++;
			}
				
			$tblBody = $this->BindGrid();
				
			$this->getPage()->getClientScript()->registerEndScript
							('','
							toastr.info("'.$msg.'");
							jQuery("#table-1").dataTable().fnDestroy();
							jQuery("#table-1 tbody").empty();
							jQuery("#table-1 tbody").append("'.$tblBody.'");
							jQuery("a[href=\"#listTab\"]").tab("show");
							BindGrid();');	
			
			
		//}
	}

}
?>
