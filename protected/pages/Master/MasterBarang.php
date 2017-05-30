<?PHP
class MasterBarang extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$sqlSatuan = "SELECT id,nama FROM tbm_satuan WHERE deleted ='0' ";
			$arrSatuan = $this->queryAction($sqlSatuan,'S');
			$this->DDSatuan->DataSource = $arrSatuan;
			$this->DDSatuan->DataBind();
			
			$sqlKategori = "SELECT id,nama FROM tbm_kategori_barang WHERE deleted ='0' ";
			$arrKategori = $this->queryAction($sqlKategori,'S');
			$this->DDKategori->DataSource = $arrKategori;
			$this->DDKategori->DataBind();
			
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
					tbm_barang.id,
					tbm_barang.nama,
					tbm_barang.kelompok_id,
					tbm_barang.kategori_id,
					tbm_kategori_barang.nama AS kategori,
					tbm_barang.min_stock,
					tbm_barang.max_stock,
					tbm_barang.max_beli_bulanan
				FROM 
					tbm_barang
				INNER JOIN tbm_kategori_barang ON tbm_kategori_barang.id = tbm_barang.kategori_id
				WHERE 
					tbm_barang.deleted = '0' 
				ORDER BY 
					tbm_barang.id ASC ";
		$BarangRecord = $this->queryAction($sql,'S');
		
		$count = count($BarangRecord);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($BarangRecord as $row)
			{
				$stokList ='';
				$sqlStock = "SELECT
								SUM(tbd_stok_barang.stok) AS stok
							FROM
								tbd_stok_barang
							WHERE
								tbd_stok_barang.deleted = '0'
							AND tbd_stok_barang.id_barang = '".$row['id']."'
							GROUP BY
								tbd_stok_barang.id_barang ";
				$arrStock = $this->queryAction($sqlStock,'S');
				
				if($arrStock)
					$stok = $arrStock[0]['stok'];
				else
					$stok = 0;
				
				$realQty = $this->getTargetUom($row['id'],$stok); 
				
				foreach($realQty as $rowQty)
				{
					$stokList .= $rowQty['qty']." ".$rowQty['name']."<br>";
				}
				$idMaxSatuan = BarangSatuanRecord::finder()->find('urutan = ? AND id_barang = ? AND deleted = ?','1',$row['id'],'0')->id_satuan;
				$MaxSatuanName = SatuanRecord::finder()->findByPk($idMaxSatuan)->nama;
				
				if($row['kelompok_id'] == '0')
					$kelompokBarang = "Assets";
				else
					$kelompokBarang = "Barang Lancar";
					
				$tblBody .= '<tr>';
				$tblBody .= '<td class=\"details-control dont_shown\"><input type=\"hidden\" value=\"'.$row['id'].'\"></td>';
				$tblBody .= '<td>'.mysql_escape_string($row['nama']).'</td>';
				$tblBody .= '<td>'.$kelompokBarang.'</td>';
				$tblBody .= '<td>'.$row['kategori'].'</td>';
				$tblBody .= '<td>'.$stokList.'</td>';
				$tblBody .= '<td>'.$row['min_stock'].' '.$MaxSatuanName.'</td>';
				$tblBody .= '<td>'.$row['max_stock'].' '.$MaxSatuanName.'</td>';
				$tblBody .= '<td>'.$row['max_beli_bulanan'].' '.$MaxSatuanName.'</td>';
				$tblBody .= '<td>';
				if($row['kategori_id'] != '5')
				{
					$tblBody .= '<a href=\"#\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
					$tblBody .= '<a href=\"#\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';	
				}		
				
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
		$BarangRecord = BarangRecord::finder()->findByPk($id);
		if($BarangRecord)
		{
			$this->modalJudul->Text = 'Edit Barang';
			$this->idBarang->Value = $id;
			$this->nama->Text = $BarangRecord->nama;
			$this->DDKategori->SelectedValue = $BarangRecord->kategori_id;
			$this->DDKelompok->SelectedValue = $BarangRecord->kelompok_id;
			$this->min_stock->Text = $BarangRecord->min_stock;
			$this->max_stock->Text = $BarangRecord->max_stock;
			$this->max_beli_bulanan->Text = $BarangRecord->max_beli_bulanan;
			
			$sql = "SELECT
						tbm_satuan_barang.id,
						tbm_satuan_barang.id_satuan,
						tbm_satuan_barang.urutan,
						tbm_satuan.nama,
						tbm_satuan_barang.jumlah
					FROM
						tbm_satuan_barang
					INNER JOIN tbm_satuan ON tbm_satuan.id = tbm_satuan_barang.id_satuan
					WHERE
						tbm_satuan_barang.id_barang = '$id'
						AND tbm_satuan_barang.deleted != '1'
					ORDER BY
						tbm_satuan_barang.urutan ASC ";
			$arrSatuanBarang = $this->queryAction($sql,'S');
			foreach($arrSatuanBarang as $row)
			{
				$arr[] = array("id"=>$row['id'],
								"urutan"=>$row['urutan'],
								"jumlah"=>$row['jumlah'],
								"idSatuan"=>$row['id_satuan'],
								"nmSatuan"=>$row['nama'],
								"deleted"=>'0');
			}
			$this->arrSatuan->Value = json_encode($arr,true);
			$tblBody = $this->bindSatuan();
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#tableSatuan").dataTable().fnDestroy();
					jQuery("#tableSatuan tbody").empty();
					jQuery("#tableSatuan tbody").append("'.$tblBody.'");
					unloadContent();
					jQuery("#modal-1").modal("show");
					BindGridSatuan();');
					
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
		$BarangRecord = BarangRecord::finder()->findByPk($id);
		if($BarangRecord)
		{
			$BarangRecord->deleted = '1';
			$BarangRecord->save();
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
		$nama = trim($this->nama->Text);
		$kategori = $this->DDKategori->SelectedValue;
		$satuan = $this->DDKategori->SelectedValue;
		$arrSatuan = json_decode($this->arrSatuan->Value,true);
		$save = true;
		if(count($arrSatuan) > 0)
		{
			$dataList = 0;
			foreach($arrSatuan as $row)
			{
				if($row['deleted'] != '1')
					$dataList++;
			}
			
			if($dataList == 0)
				$save = false;
		}
		else
		{
			$save = false;
		}
		
		if($save)
		{
			if($this->idBarang->Value != '')
			{
				$BarangRecord = BarangRecord::finder()->findByPk($this->idBarang->Value);
				$msg = "Data Berhasil Diedit";
			}
			else
			{
				$BarangRecord = new BarangRecord();
				$msg = "Data Berhasil Disimpan";
			}
			
			$BarangRecord->nama = $nama;
			$BarangRecord->kategori_id = $kategori;
			$BarangRecord->kelompok_id = $this->DDKelompok->SelectedValue;
			$BarangRecord->min_stock = $this->min_stock->Text;
			$BarangRecord->max_stock = $this->max_stock->Text;
			$BarangRecord->max_beli_bulanan = $this->max_beli_bulanan->Text;
			
			$BarangRecord->save();
				
			foreach($arrSatuan as $row)
			{
				if($row['id'] == '0')
					$BarangSatuanRecord = new BarangSatuanRecord();
				else
					$BarangSatuanRecord = BarangSatuanRecord::finder()->findByPk($row['id']);
					
				if($row['deleted'] != '1')
				{
					$BarangSatuanRecord->id_barang = $BarangRecord->id;
					$BarangSatuanRecord->id_satuan = $row['idSatuan'];
					$BarangSatuanRecord->jumlah = $row['jumlah'];
					$BarangSatuanRecord->urutan = $row['urutan'];
				}
				elseif($row['deleted'] == '1')
				{
						
					$BarangSatuanRecord->deleted = '1'; 
				}
						
				$BarangSatuanRecord->save();
			}
			
			$this->arrSatuan->Value = '';
			$this->idBarang->Value = '';
			$this->nama->Text = '';
			$this->DDSatuan->SelectedValue = 'empty';
			$this->DDKategori->SelectedValue = 'empty';
			$tblBody = $this->BindGrid();
			
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.info("'.$msg.'");
						jQuery("#modal-1").modal("hide");
						jQuery("#table-1").dataTable().fnDestroy();
						jQuery("#table-1 tbody").empty();
						jQuery("#table-1 tbody").append("'.$tblBody.'");
						BindGrid();');	
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
						('','
						toastr.error("Satuan Barang Belum Dimasukkan !");');	
		}
	}
	
	public function clearForm()
	{
	}
	
	
	public function tambahBtnClicked($sender,$param)
	{
		$arr = json_decode($this->arrSatuan->Value,true);
		$idSatuan = $this->DDSatuan->SelectedValue;
		$jumlah = $this->Jumlah->Text;
		$stFind = '0';
		$id = '0';
		if(count($arr) == 0)
		{
			$urutan = 1;
			$jumlah = 1;
			
		}
		else
		{
			foreach($arr as $row)
			{
				$urutan = $row['urutan'] + 1;
				
				if($row['idSatuan'] == $idSatuan && $row['deleted'] != '1')
					$stFind = '1';
				
			}
		}
		
		if($stFind == '0')
		{
			$SatuanNama = SatuanRecord::finder()->findByPk($idSatuan)->nama;
			$arr[] = array("id"=>$id,"urutan"=>$urutan,"jumlah"=>$jumlah,"idSatuan"=>$idSatuan,"nmSatuan"=>$SatuanNama,"deleted"=>'0');
			
			$this->Jumlah->Text = '';;
			$this->DDSatuan->SelectedValue = '';
			$this->arrSatuan->Value = json_encode($arr,true);
			$tblBody = $this->bindSatuan();
			
			$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#tableSatuan").dataTable().fnDestroy();
					jQuery("#tableSatuan tbody").empty();
					jQuery("#tableSatuan tbody").append("'.$tblBody.'");
					unloadContent();
					BindGridSatuan();');
					
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					toastr.error("Satuan Tersebut Sudah Dimasukkan !");
					');
		}
	}
	
	public function deleteSatuan($sender,$param)
	{
		$urutan = $param->CallbackParameter->urutan;
		$arr = json_decode($this->arrSatuan->Value,true);
		
		foreach($arr as $subKey => $subArray)
		{
			if($subArray['urutan'] == $urutan)
			{
				if($subArray['id'] == '0')
					unset($arr[$subKey]);	
				else
					$arr[$subKey]['deleted'] = '1';
			}
		}
		
		$this->arrSatuan->Value = json_encode($arr,true);
		
		$tblBody = $this->bindSatuan();
		$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#tableSatuan").dataTable().fnDestroy();
					jQuery("#tableSatuan tbody").empty();
					jQuery("#tableSatuan tbody").append("'.$tblBody.'");
					unloadContent();
					BindGridSatuan();');
	}
	
	public function bindSatuan()
	{
		$arr = json_decode($this->arrSatuan->Value,true);
		
		$tblBody = '';
		if(count($arr) > 0)
		{
			foreach($arr as $row)
			{
				if($row['deleted'] != '1')
				{
					$tblBody .= '<tr>';
					$tblBody .= '<td>'.$row['urutan'].'</td>';
					$tblBody .= '<td>'.$row['nmSatuan'].'</td>';
					$tblBody .= '<td>'.$row['jumlah'].'</td>';
					$tblBody .= '<td>';
					$tblBody .= '<a href=\"javascript:void(0)\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteSatuan('.$row['urutan'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>';	
					$tblBody .=	'</td>';			
					$tblBody .= '</tr>';
				}
			}
		}
		
		return $tblBody;
		/*$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#tableSatuan").dataTable().fnDestroy();
					jQuery("#tableSatuan tbody").empty();
					jQuery("#tableSatuan tbody").append("'.$tblBody.'");
					unloadContent();
					BindGridSatuan();');	*/
	}
	
	public function generateDetailCallback($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		
		$sql = "SELECT
					tbm_satuan_barang.id,
					tbm_satuan_barang.urutan,
					tbm_satuan.nama,
					tbm_satuan_barang.jumlah
				FROM
					tbm_satuan_barang
				INNER JOIN tbm_satuan ON tbm_satuan.id = tbm_satuan_barang.id_satuan
				WHERE
					tbm_satuan_barang.id_barang = '$id'
					AND tbm_satuan_barang.deleted != '1'
				ORDER BY
					tbm_satuan_barang.urutan ASC ";
		$arrSatuanBarang = $this->queryAction($sql,'S');
		
		if(count($arrSatuanBarang) > 0)
		{
			foreach($arrSatuanBarang as $row)
			{
					$tblBody .= '<tr>';
					$tblBody .= '<td>'.$row['urutan'].'</td>';
					$tblBody .= '<td>'.$row['nama'].'</td>';
					$tblBody .= '<td>'.$row['jumlah'].'</td>';			
					$tblBody .= '</tr>';
			}
		}
		$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#tableDetail-'.$id.' tbody").empty();
					jQuery("#tableDetail-'.$id.' tbody").append("'.$tblBody.'");
					unloadContent();');
	}
	
}
?>
