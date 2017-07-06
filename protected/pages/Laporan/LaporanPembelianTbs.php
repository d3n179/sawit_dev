<?PHP
class LaporanPembelianTbs extends MainConf
{

	public function onLoadComplete($param)
	{
		parent::onLoadComplete($param);
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
			$this->DDTahun->SelectedValue = date("Y");
			$this->DDBulan->SelectedValue = date("m");
			
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
	
	public function BindGrid()
	{
		$periode = $this->Periode->SelectedValue;
		
		$sqlTrans = "SELECT
						tbt_tbs_order.no_tbs_order,
						tbt_tbs_order.tgl_transaksi,
						tbm_jenis_kendaraan.jenis_kendaraan,
						tbm_pemasok.no_sp,
						tbt_tbs_order_detail.no_polisi,
						tbm_barang.nama AS barang,
						tbm_pemasok.nama AS pemasok,
						tbt_tbs_order_detail.netto_2,
						tbt_tbs_order_detail.harga,
						tbt_tbs_order_detail.subtotal_tbs,
						tbt_tbs_order_detail.netto_1,
						tbt_tbs_order_detail.jumlah_bongkar,
						tbt_tbs_order_detail.subtotal_spsi,
						tbt_tbs_order_detail.fee,
						tbt_tbs_order_detail.subtotal_fee,
						tbt_tbs_order_detail.ppn,
						tbt_tbs_order_detail.pph,
						tbt_tbs_order_detail.total_tbs_order,
						tbm_setting_komidel.singkatan AS kategori_tbs
					FROM
						tbt_tbs_order
					INNER JOIN tbt_tbs_order_detail ON tbt_tbs_order_detail.id_tbs_order = tbt_tbs_order.id
					INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_tbs_order.id_pemasok
					INNER JOIN tbm_barang ON tbm_barang.id = tbt_tbs_order.id_barang
					INNER JOIN tbm_setting_komidel ON tbm_setting_komidel.id = tbt_tbs_order_detail.id_komidel
					INNER JOIN tbm_jenis_kendaraan ON tbm_jenis_kendaraan.id = tbt_tbs_order_detail.id_jenis_kendaraan
					WHERE
						tbt_tbs_order.deleted = '0'
					AND tbt_tbs_order. STATUS != '0'
					AND tbt_tbs_order_detail.deleted = '0' ";
						
		
		
		if($this->DDPemasok->SelectedValue != '')
		{
			$sqlTrans .=" AND tbm_pemasok.id = '".$this->DDPemasok->SelectedValue."' ";
		}
		
		if($periode == '0')
		{
			$bulan = $this->DDBulan->SelectedValue;
			$tahun = $this->DDTahun->SelectedValue;
			if($bulan != '' && $tahun != '')
			{
				$sqlTrans .="AND MONTH(tbt_tbs_order.tgl_transaksi) = '$bulan' AND YEAR(tbt_tbs_order.tgl_transaksi) = '$tahun' ";
			}
		}
		elseif($periode == '1')
		{
			$tahun = $this->DDTahun->SelectedValue;
			if($tahun != '')
			{
				$sqlTrans .="AND YEAR(tbt_tbs_order.tgl_transaksi) = '$tahun' ";
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
				$sqlTrans .="AND tbt_tbs_order.tgl_transaksi BETWEEN '$tgl1' AND '$tgl2' ";
			}
		}	
		elseif($periode == '3')
		{
			$harian = $this->harian->Text;
			if($harian != '')
			{
				$tgl = $this->ConvertDate($harian,'2');
				$sqlTrans .="AND tbt_tbs_order.tgl_transaksi = '$tgl' ";
			}
		}		
		var_dump($sqlTrans);
		$this->setViewState('sql',$sqlTrans);
		
		$arrTrans = $this->queryAction($sqlTrans,'S');
		$tblBody = '';
		if($arrTrans)
		{
			foreach($arrTrans as $row)
			{
				$jml1 = $row['subtotal_tbs'] - $row['subtotal_spsi'];
				$jml2 = $row['subtotal_tbs'] - $row['subtotal_spsi'] + $row['subtotal_fee'];
				$ppn = $row['subtotal_tbs'] * ($row['ppn'] / 100);
				$pph = $row['subtotal_tbs'] * ($row['pph'] / 100);
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_transaksi'],'3').'</td>';
				$tblBody .= '<td>'.$row['jenis_kendaraan'].'</td>';
				$tblBody .= '<td>'.$row['kategori_tbs'].'</td>';		
				$tblBody .= '<td>'.$row['netto_2'].'</td>';		
				$tblBody .= '<td>'.number_format($row['harga'],2,'.',',').'</td>';		
				$tblBody .= '<td>'.number_format($row['subtotal_tbs'],2,'.',',').'</td>';	
				$tblBody .= '<td>'.$row['netto_1'].'</td>';	
				$tblBody .= '<td>'.$row['jumlah_bongkar'].'</td>';		
				$tblBody .= '<td>'.number_format($row['subtotal_spsi'],2,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($jml1,2,'.',',').'</td>';	
				$tblBody .= '<td>'.$row['fee'].'</td>';	
				$tblBody .= '<td>'.number_format($row['subtotal_fee'],2,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($jml2,2,'.',',').'</td>';		
				$tblBody .= '<td>'.number_format($ppn,2,'.',',').'</td>';	
				$tblBody .= '<td>'.number_format($pph,2,'.',',').'</td>';		
				$tblBody .= '<td>'.number_format($row['total_tbs_order'],2,'.',',').'</td>';		
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = '';
		}
		var_dump($tblBody);
		return $tblBody;
	}
	
	public function cariBtnClicked($sender,$param)
	{
		
		$tblBody = $this->BindGrid();
		$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#table-1").dataTable().fnDestroy();
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					BindGrid();
					unloadContent();
					');
	}
	
	
	public function cetakLaporanTimbangan($sender,$param)
	{
		$session=new THttpSession;
		$session->open();
		$session['cetakLapPembelianTbsSql'] = $this->getViewState('sql');

				$url = "index.php?page=Laporan.cetakLaporanPembelianTbsPdf&pemasok=".$this->DDPemasok->SelectedValue."&periode=".$this->Periode->SelectedValue."&bln=".$this->DDBulan->SelectedValue."&thn=".$this->DDTahun->SelectedValue."&mingguan=".$this->mingguan->Text."&harian=".$this->harian->Text;
		
		$folderApp = explode("/",$_SERVER['REQUEST_URI']);
		$urlTemp="http://".$_SERVER['HTTP_HOST']."/".$folderApp[1]."/".$url;
		
		$this->getPage()->getClientScript()->registerEndScript
							('','
							var url = "'.$urlTemp.'";
							window.open(url, "_blank");
							unloadContent();');	
	}
	
}
?>
