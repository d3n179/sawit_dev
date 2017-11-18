<?PHP
class KartuStokTbs extends MainConf
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
				
				$sql="SELECT
					tbm_kategori_barang.id,
					tbm_kategori_barang.nama
				FROM
					tbm_kategori_barang
				WHERE
					tbm_kategori_barang.deleted = '0'
					AND tbm_kategori_barang.tipe_kategori = '1'
				ORDER BY
					tbm_kategori_barang.id ";
				$arrKateg = $this->queryAction($sql,'S');
				$this->DDKategBarang->DataSource = $arrKateg;
				$this->DDKategBarang->DataBind();
				
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
		
		$sqlTrans = "SELECT 
						tbt_stok_in_out.id,
						tbt_stok_in_out.id_barang,
						tbm_barang.nama,
						tbt_stok_in_out.stok_awal,
						tbt_stok_in_out.stok_in,
						tbt_stok_in_out.nilai_in,
						tbt_stok_in_out.stok_out,
						tbt_stok_in_out.nilai_out,
						tbt_stok_in_out.stok_akhir,
						tbt_stok_in_out.keterangan,
						tbt_stok_in_out.id_transaksi,
						tbt_stok_in_out.jns_transaksi,
						tbt_stok_in_out.tgl,
						tbt_stok_in_out.wkt
					FROM 
						tbt_stok_in_out
					INNER JOIN tbm_barang ON tbm_barang.id = tbt_stok_in_out.id_barang
					INNER JOIN tbm_kategori_barang ON tbm_kategori_barang.id = tbm_barang.kategori_id
					WHERE
						tbt_stok_in_out.deleted ='0' 
						AND tbm_kategori_barang.tipe_kategori = '1'";
		
		if($periode == '0')
		{
			$bulan = $this->DDBulan->SelectedValue;
			$tahun = $this->DDTahun->SelectedValue;
			if($bulan != '' && $tahun != '')
			{
				$sqlTrans .="AND MONTH(tbt_stok_in_out.tgl) = '$bulan' AND YEAR(tbt_stok_in_out.tgl) = '$tahun' ";
			}
		}
		elseif($periode == '1')
		{
			$tahun = $this->DDTahun->SelectedValue;
			if($tahun != '')
			{
				$sqlTrans .="AND YEAR(tbt_stok_in_out.tgl) = '$tahun' ";
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
				$sqlTrans .="AND tbt_stok_in_out.tgl BETWEEN '$tgl1' AND '$tgl2' ";
			}
		}	
		
		if($this->DDKategBarang->SelectedValue != '')
			$sqlTrans .= " AND tbm_barang.kategori_id = '".$this->DDKategBarang->SelectedValue."' ";
			
		if($this->nmBarang->Text != '')
		{
			$sqlTrans .= "AND tbm_barang.nama LIKE '".$this->nmBarang->Text."%' ";
		}
		//$sqlTrans .="ORDER BY 
							//tbt_stok_in_out.id_barang,tbt_stok_in_out.tgl,tbt_stok_in_out.wkt ASC ";
		$this->setViewState('sql',$sqlTrans);
		$arrTrans = $this->queryAction($sqlTrans,'S');
		$tblBody = '';
		if($arrTrans)
		{
			foreach($arrTrans as $row)
			{
				$stokAwalList = '';
				$stokInList = '';
				$stokOutList = '';
				$stokAkhirList = '';
				
				if($row['jns_transaksi'] == '0')
					$jnsTrans = "Penjualan";
				elseif($row['jns_transaksi'] == '1')
					$jnsTrans = "Pembelian";
				elseif($row['jns_transaksi'] == '2')
					$jnsTrans = "Pembelian Kelapa Sawit";
				elseif($row['jns_transaksi'] == '3')
					$jnsTrans = "Pemakaian Produksi";
				elseif($row['jns_transaksi'] == '4')
					$jnsTrans = "Barang Rusak";
				elseif($row['jns_transaksi'] == '5')
					$jnsTrans = "Expired";
				elseif($row['jns_transaksi'] == '6')
					$jnsTrans = "Produksi Barang";
				elseif($row['jns_transaksi'] == '7')
					$jnsTrans = "Penjualan Commodity";
				elseif($row['jns_transaksi'] == '8')
					$jnsTrans = "Stok Opname";
				elseif($row['jns_transaksi'] == '9')
					$jnsTrans = "Rendeman TBS";
				
				$stokAwal = $this->getTargetUom($row['id_barang'],$row['stok_awal']); 
				foreach($stokAwal as $rowQty)
				{
					$stokAwalList .= number_format($rowQty['qty'],2,'.',',')." ".$rowQty['name']."<br>";
				}
				
				$stokIn = $this->getTargetUom($row['id_barang'],$row['stok_in']); 
				foreach($stokIn as $rowQty)
				{
					$stokInList .= number_format($rowQty['qty'],2,'.',',')." ".$rowQty['name']."<br>";
				}
				
				$stokOut = $this->getTargetUom($row['id_barang'],$row['stok_out']); 
				foreach($stokOut as $rowQty)
				{
					$stokOutList .= number_format($rowQty['qty'],2,'.',',')." ".$rowQty['name']."<br>";
				}
				
				$stokAkhir = $this->getTargetUom($row['id_barang'],$row['stok_akhir']); 
				foreach($stokAkhir as $rowQty)
				{
					$stokAkhirList .= number_format($rowQty['qty'],2,'.',',')." ".$rowQty['name']."<br>";
				}
					
				//var_dump($arrTot[0]['total_item']);
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['tgl'].'</td>';
				$tblBody .= '<td>'.$row['wkt'].'</td>';
				$tblBody .= '<td>'.$jnsTrans.'</td>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$stokAwalList.'</td>';
				$tblBody .= '<td>'.$stokInList.'</td>';
				$tblBody .= '<td>'.number_format($row['nilai_in'],2,'.',',').'</td>';
				$tblBody .= '<td>'.$stokOutList.'</td>';	
				$tblBody .= '<td>'.number_format($row['nilai_out'],2,'.',',').'</td>';
				$tblBody .= '<td>'.$stokAkhirList.'</td>';		
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
	
	
	public function cetakLapKartuStok()
	{
		//if($this->DDBulan->SelectedValue != '' && $this->DDTahun->SelectedValue != '')
		//{
			$session=new THttpSession;
			$session->open();
			$session['cetakKartuStokSql'] = $this->getViewState('sql');
	
				
				$url = "index.php?page=Inventory.cetakKartuStokPdf&periode=".$this->Periode->SelectedValue."&bln=".$this->DDBulan->SelectedValue."&thn=".$this->DDTahun->SelectedValue."&mingguan=".$this->mingguan->Text;
		
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
