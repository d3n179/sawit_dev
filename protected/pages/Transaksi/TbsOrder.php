<?PHP
class TbsOrder extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			
			$sqlPemasok = "SELECT
							tbm_pemasok.id,
							tbm_pemasok.nama
						FROM
							tbm_pemasok
							INNER JOIN tbm_kategori_pemasok ON tbm_kategori_pemasok.id = tbm_pemasok.kategori_id
						WHERE
							tbm_pemasok.deleted = '0' 
							AND tbm_kategori_pemasok.jenis_kategori = '0' ";
					
			$arrPemasok= $this->queryAction($sqlPemasok,'S');
			$this->DDPemasok->DataSource = $arrPemasok;
			$this->DDPemasok->DataBind();
			
			$sqlKendaraan = "SELECT
							tbm_jenis_kendaraan.id,
							tbm_jenis_kendaraan.jenis_kendaraan
						FROM
							tbm_jenis_kendaraan
						WHERE
							tbm_jenis_kendaraan.deleted = '0' ";
					
			$arrKendaraan= $this->queryAction($sqlKendaraan,'S');
			$this->DDJenisKendaraan->DataSource = $arrKendaraan;
			$this->DDJenisKendaraan->DataBind();
			$arrJnsKendaraan = array();
			foreach($this->queryAction($sqlKendaraan,'S') as $row)
			{
				$arrJnsKendaraan[] = array("id"=>$row['id'],"text"=>$row['jenis_kendaraan']);
			}
			$this->arrJnsKendaraan->Value = json_encode($arrJnsKendaraan,true);
			
			$sqlBarang = "SELECT
							tbm_barang.id,
							tbm_barang.nama
						FROM
							tbm_barang
						INNER JOIN 
							tbm_kategori_barang ON tbm_kategori_barang.id = tbm_barang.kategori_id
						WHERE
							tbm_barang.deleted = '0' 
							AND tbm_kategori_barang.tipe_kategori = '1' ";
					
			$arrBarang = $this->queryAction($sqlBarang,'S');
			$this->DDBarang->DataSource = $arrBarang;
			$this->DDBarang->DataBind();
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
	
	
	public function komidelCallbackBAK($sender,$param)
	{
		$komidel = $param->CallBackParameter->komidel;
		
		$sql = "SELECT
					tbm_setting_komidel.id,
					tbm_setting_komidel.operator,
					tbm_setting_komidel.komidel,
					tbm_setting_komidel.nama
				FROM
					tbm_setting_komidel
				WHERE
					tbm_setting_komidel.deleted = '0'
				ORDER BY
					tbm_setting_komidel.komidel ASC ";
					
		$arrKomidel = $this->queryAction($sql,'S');
		$kategoriTbs = '';
		$idKomidel = '';
		if($arrKomidel)
		{
			foreach($arrKomidel as $row)
			{
				if($row['operator'] == '<=')
				{
					if($komidel <= $row['komidel'])
					{
						$kategoriTbs = $row['nama'];
						$idKomidel = $row['id'];
						break;
					}
				}
				elseif($row['operator'] == '>=')
				{
					if($komidel >= $row['komidel'])
					{
						$kategoriTbs = $row['nama'];
						$idKomidel = $row['id'];
						break;
					}
				}
				
			}
		}
		
		$this->idKomidel->Value = $idKomidel;
		$this->kategori_tbs->Text = $kategoriTbs;
	}
	
	public function komidelCallback($sender,$param)
	{
		$komidel = $param->CallBackParameter->komidel;
		
		$sql = "SELECT
					tbm_setting_komidel.id,
					tbm_setting_komidel.operator,
					tbm_setting_komidel.komidel,
					tbm_setting_komidel.nama
				FROM
					tbm_setting_komidel
				WHERE
					tbm_setting_komidel.deleted = '0'
				ORDER BY
					tbm_setting_komidel.komidel ASC ";
					
		$arrKomidel = $this->queryAction($sql,'S');
		$kategoriTbs = '';
		$idKomidel = '';
		$this->arrKomidel->value = json_encode($arrKomidel,true);
		$this->getPage()->getClientScript()->registerEndScript
		('','
			unloadContent();
			');
		
		/*$this->idKomidel->Value = $idKomidel;
		$this->kategori_tbs->Text = $kategoriTbs;*/
	}
	
	public function komidelDetailCallback($sender,$param)
	{
		$id = $param->CallBackParameter->id;
		$komidel = $param->CallBackParameter->komidel;
		$jnsKendaraanId = $param->CallBackParameter->jnsKendaraanId;
		$jnsKendaraanName = $param->CallBackParameter->jnsKendaraanName;
		$noPolisi = $param->CallBackParameter->noPolisi;
		$bruto = $param->CallBackParameter->bruto;
		$tarra = $param->CallBackParameter->tarra;
		$netto_1 = $param->CallBackParameter->netto_1;
		$potonganVal = $param->CallBackParameter->potonganVal;
		$hsilPotongan = $param->CallBackParameter->hsilPotongan;
		$netto_2 = $param->CallBackParameter->netto_2;
		$jmlTandan = $param->CallBackParameter->jmlTandan;
		
		$sql = "SELECT
					tbm_setting_komidel.id,
					tbm_setting_komidel.operator,
					tbm_setting_komidel.komidel,
					tbm_setting_komidel.nama
				FROM
					tbm_setting_komidel
				WHERE
					tbm_setting_komidel.deleted = '0'
				ORDER BY
					tbm_setting_komidel.komidel ASC ";
					
		$arrKomidel = $this->queryAction($sql,'S');
		$kategoriTbs = '';
		$idKomidel = '';
		if($arrKomidel)
		{
			foreach($arrKomidel as $row)
			{
				if($row['operator'] == '<=')
				{
					if($komidel <= $row['komidel'])
					{
						$kategoriTbs = $row['nama'];
						$idKomidel = $row['id'];
						break;
					}
				}
				elseif($row['operator'] == '>=')
				{
					if($komidel >= $row['komidel'])
					{
						$kategoriTbs = $row['nama'];
						$idKomidel = $row['id'];
						break;
					}
				}
				
			}
		}
		var_dump($idKomidel);
		var_dump($potongan);
		var_dump($hsilPotongan);
		
		/*$this->getPage()->getClientScript()->registerEndScript
		('','
			console.log("dfsdfgdfgdf");
		');*/
		
		$this->getPage()->getClientScript()->registerEndScript
		('','
			console.log('.$id.');
			UpdateBarang('.$id.','.$jnsKendaraanId.',"'.$jnsKendaraanName.'","'.$noPolisi.'",'.$bruto.','.$tarra.','.$netto_1.','.$potonganVal.','.$hsilPotongan.','.$netto_2.','.$jmlTandan.','.$komidel.','.$idKomidel.',"'.$kategoriTbs.'");
		');
		
	}
	
	public function tambahBtnClicked()
	{
		$this->getPage()->getClientScript()->registerEndScript
		('','
			unloadContent();
			tambahBtnClicked();
		');
	}
	
	public function BindGrid()
	{
		$sql = "SELECT
					tbt_tbs_order.id,
					tbt_tbs_order.no_tbs_order,
					tbt_tbs_order.tgl_transaksi,
					tbt_tbs_order.wkt_transaksi,
					tbm_pemasok.nama AS pemasok,
					tbm_barang.nama AS barang,
					COUNT(tbt_tbs_order_detail.id) AS jumlah_kendaraan,
					SUM(tbt_tbs_order_detail.netto_2) AS total_berat,
					tbt_tbs_order.status
				FROM
					tbt_tbs_order
				INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_tbs_order.id_barang
				INNER JOIN tbt_tbs_order_detail ON tbt_tbs_order_detail.id_tbs_order = tbt_tbs_order.id
				WHERE
					tbt_tbs_order.deleted = '0'
					AND tbt_tbs_order.status = '0'
					AND tbt_tbs_order_detail.deleted = '0'
					AND tbt_tbs_order.tgl_transaksi = CURDATE()
				GROUP BY 
					tbt_tbs_order.id
				ORDER BY 
					tbt_tbs_order.id ASC ";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		if($count > 0)
		{
			foreach($Record as $row)
			{
				$actionBtn='';
				
				if($row['status'] == '0')
				{
					$actionBtn .= '<a href=\"javascript:void(0)\"  class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
					$actionBtn .= '<a href=\"javascript:void(0)\"  class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';
				}
				
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['no_tbs_order'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_transaksi'],'3').'</td>';
				$tblBody .= '<td>'.$row['wkt_transaksi'].'</td>';
				$tblBody .= '<td>'.$row['pemasok'].'</td>';
				$tblBody .= '<td>'.$row['barang'].'</td>';
				$tblBody .= '<td>'.$row['jumlah_kendaraan'].'</td>';
				$tblBody .= '<td>'.number_format($row['total_berat'],2,'.',',').'</td>';
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
	
	public function detailClicked($sender,$param)
	{
		$sql = "SELECT
					tbm_barang.nama,
					SUM(tbt_tbs_order_detail.netto_2) AS jml_masuk,
					tbm_setting_komidel.nama AS kategori_tbs
				FROM
					tbt_tbs_order
				INNER JOIN tbt_tbs_order_detail ON tbt_tbs_order_detail.id_tbs_order = tbt_tbs_order.id
				INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_tbs_order.id_barang
				INNER JOIN tbm_setting_komidel ON tbm_setting_komidel.id = tbt_tbs_order_detail.id_komidel
				WHERE
					tbt_tbs_order.deleted = '0'
					AND  tbt_tbs_order_detail.deleted='0'
				AND tbt_tbs_order.tgl_transaksi = CURDATE()
				GROUP BY
					tbm_barang.id,
					tbm_setting_komidel.id
				ORDER BY
					tbt_tbs_order.id ASC";
		$Record = $this->queryAction($sql,'S');
		
		$count = count($Record);
		$tblBody = '';
		$JmlBuah = 0;
		if($count > 0)
		{
			foreach($Record as $row)
			{
				$actionBtn='';
				
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$row['kategori_tbs'].'</td>';	
				$tblBody .= '<td>'.number_format($row['jml_masuk'],2,'.',',').'</td>';
				$tblBody .= '</tr>';
				$JmlBuah += $row['jml_masuk'];
			}
		}
		else
		{
			$tblBody = '';
		}
		$tblfoot = '';
		$tblfoot .= '<tr>';
		$tblfoot .= '<td colspan=\"2\" align=\"center\"><Strong>TOTAL</Strong></td>';
		$tblfoot .= '<td><Strong>'.number_format($JmlBuah,2,'.',',').'</Strong></td>';	
		$tblfoot .= '</tr>';
		
		$this->getPage()->getClientScript()->registerEndScript
						('','
						jQuery("#table-2").dataTable().fnDestroy();
						jQuery("#table-2 tbody").empty();
						jQuery("#table-2 tbody").append("'.$tblBody.'");
						jQuery("#table-2 tfoot").empty();
						jQuery("#table-2 tfoot").append("'.$tblfoot.'");
						BindGridDetail();');	
						
	}
	
	public function editForm($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		$Record = TbsOrderRecord::finder()->findByPk($id);
		if($Record)
		{
			$this->idTbsOrder->Value = $Record->id;
			$this->DDBarang->SelectedValue = $Record->id_barang;
			$this->DDPemasok->SelectedValue = $Record->id_pemasok;
			$this->tgl_transaksi->Text = $this->ConvertDate($Record->tgl_transaksi,'1');
			$sql = "SELECT
						tbt_tbs_order_detail.id AS id_edit,
						tbt_tbs_order_detail.id_jenis_kendaraan AS JnsKendaraan,
						tbm_jenis_kendaraan.jenis_kendaraan AS JnsKendaraanName,
						tbt_tbs_order_detail.no_polisi AS NoPolisi,
						tbt_tbs_order_detail.bruto AS Brutto,
						tbt_tbs_order_detail.tarra AS Tarra,
						tbt_tbs_order_detail.netto_1 AS Netto_I,
						tbt_tbs_order_detail.potongan AS Potongan,
						tbt_tbs_order_detail.hasil_potongan AS HasilPotongan,
						tbt_tbs_order_detail.netto_2 AS Netto_II,
						tbt_tbs_order_detail.jml_tandan AS JmlTandan,
						tbt_tbs_order_detail.komidel AS Komidel,
						tbt_tbs_order_detail.id_komidel AS KategoriTbs,
						tbm_setting_komidel.nama AS KategoriTbsName
					FROM
						tbt_tbs_order_detail
					INNER JOIN tbm_jenis_kendaraan ON tbm_jenis_kendaraan.id = tbt_tbs_order_detail.id_jenis_kendaraan
					INNER JOIN tbm_setting_komidel ON tbm_setting_komidel.id = tbt_tbs_order_detail.id_komidel
					WHERE
						tbt_tbs_order_detail.id_tbs_order = '".$Record->id."'
					AND tbt_tbs_order_detail.deleted = '0' ";
			$arr = $this->queryAction($sql,'S');
			$arrJson = json_encode($arr,true);
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					RenderTempTable('.$arrJson.');
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
		$Record = TbsOrderRecord::finder()->findByPk($id);
		if($Record)
		{
			$Record->deleted = '1';
			$Record->save();
			
			$sqlDelete = "UPDATE tbt_tbs_order_detail SET deleted ='1' WHERE id_tbs_order = '".$id."' ";
			$this->queryAction($sqlDelete,'C');
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
	
	public function importBtnClicked($sender,$param)
	{
		$sql = "SELECT
					tbm_setting_komidel.id,
					tbm_setting_komidel.operator,
					tbm_setting_komidel.komidel,
					tbm_setting_komidel.nama
				FROM
					tbm_setting_komidel
				WHERE
					tbm_setting_komidel.deleted = '0'
				ORDER BY
					tbm_setting_komidel.komidel ASC ";
					
		$arrKomidel = $this->queryAction($sql,'S');
		$kategoriTbs = '';
		$idKomidel = '';
		
		$sqlParent = "SELECT
							transaksi_tbs_juni.TANGGAL,
							transaksi_tbs_juni.KATEGORI_TBS,
							transaksi_tbs_juni.SUPPLIER,
							(
								SELECT
									tbm_pemasok.id
								FROM
									tbm_pemasok
								WHERE
									lower(tbm_pemasok.nama) = lower(
										transaksi_tbs_juni.SUPPLIER
									)
								AND tbm_pemasok.deleted = '0'
								LIMIT 1
							) AS id_pemasok
						FROM
							transaksi_tbs_juni
						GROUP BY
							transaksi_tbs_juni.TANGGAL,
							transaksi_tbs_juni.KATEGORI_TBS,
							transaksi_tbs_juni.SUPPLIER ";
		$arrParent = $this->queryAction($sqlParent,'S');
		foreach($arrParent as $row)
		{
			if($row['id_pemasok'] == '')
			{
				$PemasokRecord = new PemasokRecord();
				$PemasokRecord->kategori_id = '2';
				$PemasokRecord->nama = $row['SUPPLIER'];;
				$PemasokRecord->alamat = '';
				$PemasokRecord->telepon = '';
				$PemasokRecord->fax = '';
				$PemasokRecord->contact_person = '';
				$PemasokRecord->fee = 0;
				$PemasokRecord->no_sp = '002';
				$PemasokRecord->id_kategori_harga = 2;
				$PemasokRecord->deleted = '0';
				$PemasokRecord->save();
			}
		}
		$arrParent2 = $this->queryAction($sqlParent,'S');
		foreach($arrParent2 as $row)
		{
			if($row['KATEGORI_TBS'] == 'BUAH LUAR' || $row['KATEGORI_TBS'] == '1')
				$idBarang = '1021';
			elseif($row['KATEGORI_TBS'] == 'BUAH KEBUN' || $row['KATEGORI_TBS'] == '0')
				$idBarang = '1020';
			
			$tglOrder = $row['TANGGAL'];
			$arrTglOrder = explode("/",$tglOrder);
			$TBSDATE = $arrTglOrder[2].'-'.$arrTglOrder[1].'-'.$arrTglOrder[0];
				
			$Record = new TbsOrderRecord();
			$msg = "Data Berhasil Disimpan";
			$Record->no_tbs_order = $this->GenerateNoDocument('TBS');
			$Record->id_barang = $idBarang;
			$Record->id_pemasok = $row['id_pemasok'];
			$Record->tgl_transaksi = $TBSDATE;
			$Record->wkt_transaksi = date("G:i:s");
			$Record->status= '0';
			$Record->deleted= '0';
			$Record->save(); 
			
			$sqlDetail = "SELECT
							transaksi_tbs_juni.*,
							(
								SELECT
									tbm_jenis_kendaraan.id
								FROM
									tbm_jenis_kendaraan
								WHERE
									lower(
										tbm_jenis_kendaraan.jenis_kendaraan
									) = lower(
										transaksi_tbs_juni.KENDARAAN
									)
							) AS ID_KENDARAAN_DB
						FROM
							transaksi_tbs_juni 
						WHERE 
							transaksi_tbs_juni.TANGGAL = '".$row['TANGGAL']."'
							AND transaksi_tbs_juni.KATEGORI_TBS = '".$row['KATEGORI_TBS']."'
							AND transaksi_tbs_juni.SUPPLIER = '".$row['SUPPLIER']."' ";	
			$arrDetail = $this->queryAction($sqlDetail,'S');
			foreach($arrDetail as $rowDetail)
			{
				
				if($arrKomidel)
				{
					foreach($arrKomidel as $rowKomidel)
					{
						if($rowKomidel['operator'] == '<=')
						{
							if(intval($rowDetail['KOMIDEL']) <= $rowKomidel['komidel'])
							{
								$kategoriTbs = $rowKomidel['nama'];
								$idKomidel = $rowKomidel['id'];
								break;
							}
						}
						elseif($rowKomidel['operator'] == '>=')
						{
							if(intval($rowDetail['KOMIDEL']) >= $rowKomidel['komidel'])
							{
								$kategoriTbs = $rowKomidel['nama'];
								$idKomidel = $rowKomidel['id'];
								break;
							}
						}
						
					}
				}
		
				$TbsOrderDetailRecord = new TbsOrderDetailRecord();
				$TbsOrderDetailRecord->id_tbs_order = $Record->id;
				$TbsOrderDetailRecord->id_jenis_kendaraan = $rowDetail['ID_KENDARAAN_DB'];
				$TbsOrderDetailRecord->no_polisi = $rowDetail['NO_POLISI'];
				$TbsOrderDetailRecord->bruto =  $rowDetail['BRUTTO'];
				$TbsOrderDetailRecord->tarra =  $rowDetail['TARRA'];
				$TbsOrderDetailRecord->netto_1 =  $rowDetail['NETTO_I'];
				$TbsOrderDetailRecord->potongan =  $rowDetail['POTONGAN'] * 100;
				$TbsOrderDetailRecord->hasil_potongan =  $rowDetail['HSL_POTONGAN'];
				$TbsOrderDetailRecord->netto_2 =  $rowDetail['NETTO_II'];
				$TbsOrderDetailRecord->jml_tandan =  $rowDetail['JLH_TANDAN'];
				$TbsOrderDetailRecord->komidel =  intval($rowDetail['KOMIDEL']);
				$TbsOrderDetailRecord->id_komidel = $idKomidel;
				$TbsOrderDetailRecord->deleted = '0';
				$TbsOrderDetailRecord->save();
			}
		}
				
		$this->getPage()->getClientScript()->registerEndScript
								('','
								toastr.info("'.$msg.'");');	
			
	}
	
	public function submitBtnClicked($sender,$param)
	{
		//if($this->Page->IsValid)
		//{
			$idTbsOrder = $this->idTbsOrder->Value;
			$idBarang = $this->DDBarang->SelectedValue;
			$idPemasok = $this->DDPemasok->SelectedValue;
			$tglTransaksi = $this->ConvertDate($this->tgl_transaksi->Text,'2');
			$currentDate = date("Y-m-d");
			$now = time(); // or your date as well
			$your_date = strtotime($tglTransaksi);
			$datediff = $now - $your_date;

			$diff = floor($datediff / (60 * 60 * 24));


			
			if($diff < 2)
			{
				
				$TbsOrderTable = $param->CallBackParameter->TbsOrderTable;
				
			
				
				if($idTbsOrder != '')
				{
					$Record = TbsOrderRecord::finder()->findByPk($idTbsOrder);
					$msg = "Data Berhasil Diedit";
					
				}
				else
				{
					$Record = TbsOrderRecord::finder()->find('id_pemasok = ? AND id_barang = ? AND tgl_transaksi = ? AND status = ? AND deleted = ? ',$idPemasok,$idBarang,$this->ConvertDate($this->tgl_transaksi->Text,'2'),'0','0');
					
					if(!$Record)
					{
						$Record = new TbsOrderRecord();
						$msg = "Data Berhasil Disimpan";
						$Record->no_tbs_order = $this->GenerateNoDocument('TBS');
						$Record->id_barang = $idBarang;
						$Record->id_pemasok = $idPemasok;
						$Record->tgl_transaksi = $this->ConvertDate($this->tgl_transaksi->Text,'2');
						$Record->wkt_transaksi = date("G:i:s");
						$Record->status= '0';
						$Record->deleted= '0';
						$Record->save(); 
					}
					else
					{
						$msg = "Data Berhasil Ditambahkan ke transaksi sebelumnya";
					}
				}
				
				foreach($TbsOrderTable as $row)
				{
					if($row->id_edit != '')
						$TbsOrderDetailRecord = TbsOrderDetailRecord::finder()->findByPk($row->id_edit);
					else
						$TbsOrderDetailRecord = new TbsOrderDetailRecord();
					
					$TbsOrderDetailRecord->id_tbs_order = $Record->id;
					$TbsOrderDetailRecord->id_jenis_kendaraan = $row->JnsKendaraan;
					$TbsOrderDetailRecord->no_polisi = $row->NoPolisi;
					$TbsOrderDetailRecord->bruto = $row->Brutto;
					$TbsOrderDetailRecord->tarra = $row->Tarra;
					$TbsOrderDetailRecord->netto_1 = $row->Netto_I;
					$TbsOrderDetailRecord->potongan = $row->Potongan;
					$TbsOrderDetailRecord->hasil_potongan = $row->HasilPotongan;
					$TbsOrderDetailRecord->netto_2 = $row->Netto_II;
					$TbsOrderDetailRecord->jml_tandan = $row->JmlTandan;
					$TbsOrderDetailRecord->komidel = $row->Komidel;
					$TbsOrderDetailRecord->id_komidel = $row->KategoriTbs;
					$TbsOrderDetailRecord->deleted = $row->deleted;
					$TbsOrderDetailRecord->save();
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
			}
			else
			{
				$this->getPage()->getClientScript()->registerEndScript
								('','
								toastr.error("Tanggal Transaksi Melebihi H - 1 !");
								unloadContent();');	
			}
			
		//}
	}

}
?>
