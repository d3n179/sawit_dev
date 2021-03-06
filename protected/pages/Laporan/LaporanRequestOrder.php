<?PHP
class LaporanRequestOrder extends MainConf
{

	public function onLoadComplete($param)
	{
		parent::onLoadComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$sql = "SELECT
						tbm_kategori_barang.id,
						tbm_kategori_barang.nama
					FROM
						tbm_kategori_barang
					WHERE
						tbm_kategori_barang.deleted = '0' AND tbm_kategori_barang.tipe_kategori = '0' ";
			$arr = $this->queryAction($sql,'S');
			$this->DDKategori->DataSource = $arr;
			$this->DDKategori->DataBind();
			
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
	
	public function BindGrid()
	{
		$periode = $this->Periode->SelectedValue;
		
		$sqlTrans = "SELECT
					tbt_request_order.id,
					tbt_request_order.`status`,
					tbt_request_order.no_ro,
					tbt_request_order.tgl_ro,
					tbt_request_order.catatan,
					COUNT(
						tbt_request_order_detail.id
					) AS jml_item,
					SUM(
						tbt_request_order_detail.subtotal
					) AS total_biaya
				FROM
					tbt_request_order
				INNER JOIN tbt_request_order_detail ON tbt_request_order_detail.id_ro = tbt_request_order.id
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_request_order_detail.id_barang
				INNER JOIN tbm_kategori_barang ON tbm_kategori_barang.id = tbm_barang.kategori_id
				WHERE
					tbt_request_order.deleted = '0'
				AND tbt_request_order_detail.deleted = '0' ";
						
		if($this->noRo->Text != '')
		{
			$sqlTrans .=" AND tbt_request_order.no_ro = '".$this->noRo->Text."' ";
		}
		
		
		if($this->nmBarang->Text != '')
		{
			$sqlTrans .=" AND tbm_barang.nama LIKE '%".$this->nmBarang->Text."%' ";
		}
		
		if($this->DDKategori->SelectedValue != '')
		{
			$sqlTrans .=" AND tbm_kategori_barang.id = '".$this->DDKategori->SelectedValue."' ";
		}
		
		if($periode == '0')
		{
			$bulan = $this->DDBulan->SelectedValue;
			$tahun = $this->DDTahun->SelectedValue;
			if($bulan != '' && $tahun != '')
			{
				$sqlTrans .="AND MONTH(tbt_request_order.tgl_ro) = '$bulan' AND YEAR(tbt_request_order.tgl_ro) = '$tahun' ";
			}
		}
		elseif($periode == '1')
		{
			$tahun = $this->DDTahun->SelectedValue;
			if($tahun != '')
			{
				$sqlTrans .="AND YEAR(tbt_request_order.tgl_ro) = '$tahun' ";
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
				$sqlTrans .="AND tbt_request_order.tgl_ro BETWEEN '$tgl1' AND '$tgl2' ";
			}
		}	
		
		$sqlTrans .= " GROUP BY
					tbt_request_order.id ";
					
		$this->setViewState('sql',$sqlTrans);
		var_dump($sqlTrans);
				
		$arrTrans = $this->queryAction($sqlTrans,'S');
		$tblBody = '';
		if($arrTrans)
		{
			foreach($arrTrans as $row)
			{
				$tglRo = $this->ConvertDate($row['tgl_ro'],'3');
				$tblBody .= '<tr>';
				$tblBody .= '<td class=\"details-control dont_shown\"><input type=\"hidden\" value=\"'.$row['id'].'\"></td>';
				$tblBody .= '<td>'.$row['no_ro'].'</td>';
				$tblBody .= '<td>'.$tglRo.'</td>';
				$tblBody .= '<td>'.$row['jml_item'].'</td>';
				$tblBody .= '<td>'.number_format($row['total_biaya'],2,'.',',').'</td>';	
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = '';
		}
		
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
	
	public function generateDetailCallback($sender,$param)
	{
		$id = $param->CallbackParameter->id;
		
		$sql = "SELECT
					tbt_request_order_detail.id,
					tbt_request_order_detail.id_barang,
					tbm_barang.nama,
					tbt_request_order_detail.id_satuan,
					tbm_satuan.nama AS satuan,
					tbt_request_order_detail.harga_satuan_besar,
					tbt_request_order_detail.harga_satuan,
					tbt_request_order_detail.jumlah,
					tbt_request_order_detail.subtotal
				FROM
					tbt_request_order_detail
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_request_order_detail.id_barang
				INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_request_order_detail.id_satuan
				WHERE
					tbt_request_order_detail.deleted = '0'
				AND tbt_request_order_detail.id_ro = '$id'
				ORDER BY
					tbt_request_order_detail.id ASC ";
					
		$arr = $this->queryAction($sql,'S');
		var_dump($sql);
		if(count($arr) > 0)
		{
			foreach($arr as $row)
			{
					$tblBody .= '<tr>';
					$tblBody .= '<td>'.$row['nama'].'</td>';
					$tblBody .= '<td>'.$row['satuan'].'</td>';
					$tblBody .= '<td>'.number_format($row['harga_satuan'],2,'.',',').'</td>';
					$tblBody .= '<td>'.$row['jumlah'].'</td>';	
					$tblBody .= '<td>'.number_format($row['subtotal'],2,'.',',').'</td>';			
					$tblBody .= '</tr>';
			}
		}
		$this->getPage()->getClientScript()->registerEndScript
					('','
					jQuery("#tableDetail-'.$id.' tbody").empty();
					jQuery("#tableDetail-'.$id.' tbody").append("'.$tblBody.'");
					unloadContent();');
	}
	
	public function cetakLaporanTimbangan($sender,$param)
	{
		$session=new THttpSession;
		$session->open();
		$session['cetakLapRequestOrderSql'] = $this->getViewState('sql');

				
				$url = "index.php?page=Laporan.cetakLaporanRequestOrderPdf&periode=".$this->Periode->SelectedValue."&bln=".$this->DDBulan->SelectedValue."&thn=".$this->DDTahun->SelectedValue."&mingguan=".$this->mingguan->Text;
		
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
