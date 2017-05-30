<?PHP
class LaporanBarangRusak extends MainConf
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
				
				$sql="SELECT
					tbm_kategori_barang.id,
					tbm_kategori_barang.nama
				FROM
					tbm_kategori_barang
				WHERE
					tbm_kategori_barang.deleted = '0'
				ORDER BY
					tbm_kategori_barang.id";
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
						tbt_mutasi_barang.id,
						tbt_mutasi_barang_detail.id_barang,
						tbm_barang.nama,
						tbt_mutasi_barang_detail.jml,
						tbt_mutasi_barang_detail.id_satuan,
						tbm_satuan.nama AS satuan,
						tbt_mutasi_barang.tgl_transaksi,
						tbt_mutasi_barang.wkt_transaksi
					FROM 
						tbt_mutasi_barang_detail
					INNER JOIN tbm_barang ON tbm_barang.id = tbt_mutasi_barang_detail.id_barang
					INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_mutasi_barang_detail.id_satuan
					INNER JOIN tbt_mutasi_barang ON tbt_mutasi_barang.id = tbt_mutasi_barang_detail.id_transaksi
					WHERE
						tbt_mutasi_barang_detail.deleted ='0' 
						AND tbt_mutasi_barang.deleted ='0' ";
		
		if($periode == '0')
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
				
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_transaksi'],'3').'</td>';
				$tblBody .= '<td>'.$row['wkt_transaksi'].'</td>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$row['satuan'].'</td>';
				$tblBody .= '<td>'.$row['jml'].'</td>';	
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
			$session['cetakLapBarangRusakSql'] = $this->getViewState('sql');
		
			$this->Response->redirect($this->Service->constructUrl('Inventory.cetakLapBarangRusakPdf',
				array(
				'periode'=>$this->Periode->SelectedValue,
				'bln'=>$this->DDBulan->SelectedValue,
				'thn'=>$this->DDTahun->SelectedValue,
				'mingguan'=>$this->mingguan->Text,
				'harian'=>$this->harian->Text)));
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
