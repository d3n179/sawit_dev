<?PHP
class BukuKas extends MainConf
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
				
				$sqlBank = "SELECT id,nama FROM tbm_bank WHERE deleted != '1' ";
				$arrBank = $this->queryAction($sqlBank,'S');
				$this->DDBank->DataSource = $arrBank;
				$this->DDBank->DataBind();
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
		$idBank = $this->DDBank->SelectedValue;
		$sqlTrans = "SELECT
						tbt_jurnal_buku_besar.id,
						tbm_bank.nama AS asal_kas,
						tbt_jurnal_buku_besar.sumber_transaksi,
						tbt_jurnal_buku_besar.no_transaksi,
						tbt_jurnal_buku_besar.tgl_transaksi,
						tbt_jurnal_buku_besar.wkt_transaksi,
						tbm_coa.kode_coa,
						tbt_jurnal_buku_besar.keterangan,
						tbt_jurnal_buku_besar.jns_transaksi,
						tbt_jurnal_buku_besar.saldo_transaksi,
						tbt_jurnal_buku_besar.saldo_akhir
					FROM
						tbt_jurnal_buku_besar
					INNER JOIN tbm_bank ON tbm_bank.id = tbt_jurnal_buku_besar.id_bank
					INNER JOIN tbm_coa ON tbm_coa.id = tbt_jurnal_buku_besar.id_coa
					WHERE
						tbt_jurnal_buku_besar.id_bank = '$idBank' ";
		
		if($periode == '0')
		{
			$bulan = $this->DDBulan->SelectedValue;
			$tahun = $this->DDTahun->SelectedValue;
			if($bulan != '' && $tahun != '')
			{
				$sqlTrans .="AND MONTH(tbt_jurnal_buku_besar.tgl_transaksi) = '$bulan' AND YEAR(tbt_jurnal_buku_besar.tgl_transaksi) = '$tahun' ";
			}
		}
		elseif($periode == '1')
		{
			$tahun = $this->DDTahun->SelectedValue;
			if($tahun != '')
			{
				$sqlTrans .="AND YEAR(tbt_jurnal_buku_besar.tgl_transaksi) = '$tahun' ";
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
				$sqlTrans .="AND tbt_jurnal_buku_besar.tgl_transaksi BETWEEN '$tgl1' AND '$tgl2' ";
			}
		}	
		
		$sqlTrans .="ORDER BY
						tbt_jurnal_buku_besar.id ASC";
		$arrTrans = $this->queryAction($sqlTrans,'S');
		$tblBody = '';
		$this->setViewState('sql',$sqlTrans);
		if($arrTrans && $this->DDBank->SelectedValue != '' && $this->DDBulan->SelectedValue != '' && $this->DDTahun->SelectedValue != '')
		{
			
			foreach($arrTrans as $row)
			{
				if($row['sumber_transaksi'] == '1')
					$sumberTrans = "Pembayaran PO";
				elseif($row['sumber_transaksi'] == '2')
					$sumberTrans = "Pembayaran TBS";
				elseif($row['sumber_transaksi'] == '3')
					$sumberTrans = "Penerimaan Penjualan";
				elseif($row['sumber_transaksi'] == '4')
					$sumberTrans = "Expense Transaction";
				elseif($row['sumber_transaksi'] == '5')
					$sumberTrans = "Revenue Transaction";
								
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$row['asal_kas'].'</td>';
				$tblBody .= '<td>'.$sumberTrans.'</td>';
				$tblBody .= '<td>'.$row['no_transaksi'].'</td>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_transaksi'],'3').'</td>';
				$tblBody .= '<td>'.$row['wkt_transaksi'].'</td>';
				$tblBody .= '<td>'.$row['kode_coa'].'</td>';
				$tblBody .= '<td>'.$row['keterangan'].'</td>';
				
				if($row['jns_transaksi'] == '0')//DEBET
				{
					$tblBody .= '<td>'.number_format($row['saldo_transaksi'],2,'.',',').'</td>';
					$tblBody .= '<td>'.number_format(0,2,'.',',').'</td>';
				}
				elseif($row['jns_transaksi'] == '1')//KREDIT
				{
					$tblBody .= '<td>'.number_format(0,2,'.',',').'</td>';
					$tblBody .= '<td>'.number_format($row['saldo_transaksi'],2,'.',',').'</td>';
				}
				$tblBody .= '<td>'.number_format($row['saldo_akhir'],2,'.',',').'</td>';	
					
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
	
	
	public function cetakLapBukuKas()
	{
		if($this->DDBulan->SelectedValue != '' && $this->DDTahun->SelectedValue != '' && $this->DDBank->SelectedValue != '')
		{
			$session=new THttpSession;
			$session->open();
			$session['cetakBukuKasSql'] = $this->getViewState('sql');
			
			$this->Response->redirect($this->Service->constructUrl('Keuangan.cetakBukuKasPdf',
				array(
					'periode'=>$this->Periode->SelectedValue,
					'bln'=>$this->DDBulan->SelectedValue,
					'thn'=>$this->DDTahun->SelectedValue,
					'mingguan'=>$this->mingguan->Text,
					'idBank'=>$this->DDBank->SelectedValue)));
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					toastr.error("Pilih Bulan Dan Tahun !");
					');
		}
	}
	
}
?>
