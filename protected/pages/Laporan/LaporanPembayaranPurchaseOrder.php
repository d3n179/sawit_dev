<?PHP
class LaporanPembayaranPurchaseOrder extends MainConf
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
					tbt_pembayaran_po.no_pembayaran,
					tbt_pembayaran_po.tgl_pembayaran,
					tbt_purchase_order.no_po,
					tbm_pemasok.nama,
					tbt_pembayaran_po.jns_bayar,
					tbt_pembayaran_po.total_pembayaran
				FROM
					tbt_pembayaran_po
				INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_pembayaran_po.id_po
				INNER JOIN tbm_pemasok ON tbm_pemasok.id = tbt_purchase_order.id_supplier
				INNER JOIN tbt_purchase_order_detail ON tbt_purchase_order_detail.id_po = tbt_purchase_order.id
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_purchase_order_detail.id_barang
				WHERE
					tbt_pembayaran_po.deleted = '0' ";
						
		if($this->noPo->Text != '')
		{
			$sqlTrans .=" AND tbt_purchase_order.no_po = '".$this->noPo->Text."' ";
		}
		
		if($this->nmPemasok->Text != '')
		{
			$sqlTrans .=" AND tbm_pemasok.nama LIKE '%".$this->nmPemasok->Text."%' ";
		}
		
		if($this->kodeBarang->Text != '')
		{
			$sqlTrans .=" AND tbm_barang.kode_barang = '".$this->kodeBarang->Text."' ";
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
				$sqlTrans .="AND MONTH(tbt_pembayaran_po.tgl_pembayaran) = '$bulan' AND YEAR(tbt_pembayaran_po.tgl_pembayaran) = '$tahun' ";
			}
		}
		elseif($periode == '1')
		{
			$tahun = $this->DDTahun->SelectedValue;
			if($tahun != '')
			{
				$sqlTrans .="AND YEAR(tbt_pembayaran_po.tgl_pembayaran) = '$tahun' ";
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
				$sqlTrans .="AND tbt_pembayaran_po.tgl_pembayaran BETWEEN '$tgl1' AND '$tgl2' ";
			}
		}	
		elseif($periode == '3')
		{
			$harian = $this->harian->Text;
			if($harian != '')
			{
				$tgl = $this->ConvertDate($harian,'2');
				$sqlTrans .="AND tbt_pembayaran_po.tgl_pembayaran = '$tgl' ";
			}
		}	
		
		$sqlTrans .= " GROUP BY
					tbt_pembayaran_po.id ";
					
		$this->setViewState('sql',$sqlTrans);
		var_dump($sqlTrans);
				
		$arrTrans = $this->queryAction($sqlTrans,'S');
		$tblBody = '';
		if($arrTrans)
		{
			foreach($arrTrans as $row)
			{
				if($row['jns_bayar'] == '0')
					$jnsBayar = 'Cash';
				else
					$jnsBayar = 'Bank Transfer';
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['no_pembayaran'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_pembayaran'],'3').'</td>';
				$tblBody .= '<td>'.$row['no_po'].'</td>';
				$tblBody .= '<td>'.$row['nama'].'</td>';
				$tblBody .= '<td>'.$jnsBayar.'</td>';
				$tblBody .= '<td>'.number_format($row['total_pembayaran'],2,'.',',').'</td>';		
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
					tbt_purchase_order_detail.id,
					tbt_purchase_order_detail.id_barang,
					tbm_barang.nama,
					tbt_purchase_order_detail.id_satuan,
					tbm_satuan.nama AS satuan,
					tbt_purchase_order_detail.harga_satuan_besar,
					tbt_purchase_order_detail.harga_satuan,
					tbt_purchase_order_detail.jumlah,
					tbt_purchase_order_detail.discount,
					tbt_purchase_order_detail.subtotal
				FROM
					tbt_purchase_order_detail
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_purchase_order_detail.id_barang
				INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_purchase_order_detail.id_satuan
				WHERE
					tbt_purchase_order_detail.deleted = '0'
				AND tbt_purchase_order_detail.id_po = '$id'
				ORDER BY
					tbt_purchase_order_detail.id ASC ";
					
		$arr = $this->queryAction($sql,'S');
		if(count($arr) > 0)
		{
			foreach($arr as $row)
			{
					$tblBody .= '<tr>';
					$tblBody .= '<td>'.$row['nama'].'</td>';
					$tblBody .= '<td>'.$row['satuan'].'</td>';
					$tblBody .= '<td>'.number_format($row['harga_satuan'],2,'.',',').'</td>';
					$tblBody .= '<td>'.$row['jumlah'].'</td>';	
					$tblBody .= '<td>'.$row['discount'].'</td>';	
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
		$session['cetakLapPembayaranPurchaseOrderSql'] = $this->getViewState('sql');
		
		$this->Response->redirect($this->Service->constructUrl('Laporan.cetakLaporanPembayaranPurchaseOrderPdf',
			array(
				'periode'=>$this->Periode->SelectedValue,
				'bln'=>$this->DDBulan->SelectedValue,
				'thn'=>$this->DDTahun->SelectedValue,
				'mingguan'=>$this->mingguan->Text,
				'harian'=>$this->harian->Text)));
	}
	
}
?>
