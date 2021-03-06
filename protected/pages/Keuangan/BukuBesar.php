<?PHP
class BukuBesar extends MainConf
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
				
				
				$sqlAkun = "SELECT id,nama_akun AS nama FROM tbt_jurnal_buku_besar WHERE deleted != '1' GROUP BY nama_akun";
				$arrAkun = $this->queryAction($sqlAkun,'S');
				$arrAkun[] = array("id"=>0,"nama"=>"Semua");
				$this->DDAkun->DataSource = $arrAkun;
				$this->DDAkun->DataBind();
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
		$namaAkun = $param->CallbackParameter->namaAkun;
		
		$sqlTrans = "SELECT
						*
					FROM
						tbt_jurnal_buku_besar
					WHERE
						tbt_jurnal_buku_besar.deleted != '1' 
						AND tbt_jurnal_buku_besar.saldo > 0 ";
		
		if($namaAkun != 'Semua')
		{
			$sqlTrans .= "AND tbt_jurnal_buku_besar.nama_akun = '$namaAkun' ";
		}
		
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
						tbt_jurnal_buku_besar.nama_akun ";
		$arrTrans = $this->queryAction($sqlTrans,'S');
		
		$tblBody = '';
		$this->setViewState('sql',$sqlTrans);
		if($arrTrans && $this->DDAkun->SelectedValue != '' && $this->DDBulan->SelectedValue != '' && $this->DDTahun->SelectedValue != '')
		{
			
			foreach($arrTrans as $row)
			{
				var_dump($sqlTrans);					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.$this->ConvertDate($row['tgl_transaksi'],'3').'</td>';
				$tblBody .= '<td>'.$row['nama_akun'].'</td>';
				$tblBody .= '<td>'.$row['keterangan'].'</td>';
				
				if($row['nama_akun'] == 'Kas' || $row['nama_akun'] == 'Kas Bank' || $row['nama_akun'] == 'Piutang' || $row['nama_akun'] == 'Perlengkapan' || $row['nama_akun'] == 'Persediaan Bahan Baku' || $row['nama_akun'] == 'Persediaan Barang Dagangan' || $row['nama_akun'] == 'Beban Perlengkapan' || $row['nama_akun'] == 'Beban Gaji' || $row['nama_akun'] == 'Beban Lain-lain')
				{
					if($row['jns_transaksi'] == '0')
					{
						$tblBody .= '<td align=\"right\">'.number_format($row['saldo'],2,'.',',').'</td>';
						$tblBody .= '<td align=\"right\">-</td>';
					}
					elseif($row['jns_transaksi'] == '1')
					{
						$tblBody .= '<td align=\"right\">-</td>';
						$tblBody .= '<td align=\"right\">'.number_format($row['saldo'],2,'.',',').'</td>';
					}
				}
				elseif($row['nama_akun'] == 'Modal' || $row['nama_akun'] == 'Hutang' || $row['nama_akun'] == 'Hutang Gaji' || $row['nama_akun'] == 'Pendapatan Lain-lain' || $row['nama_akun'] == 'Pendapatan')
				{
					if($row['jns_transaksi'] == '0')
					{
						$tblBody .= '<td align=\"right\">-</td>';
						$tblBody .= '<td align=\"right\">'.number_format($row['saldo'],2,'.',',').'</td>';
					}
					elseif($row['jns_transaksi'] == '1')
					{
						$tblBody .= '<td align=\"right\">'.number_format($row['saldo'],2,'.',',').'</td>';
						$tblBody .= '<td align=\"right\">-</td>';
					}
				}
				
				if($row['posisi_saldo_akhir'] == '0')
				{
					$tblBody .= '<td align=\"right\">'.number_format($row['saldo_akhir'],2,'.',',').'</td>';
					$tblBody .= '<td align=\"right\">-</td>';
				}
				elseif($row['posisi_saldo_akhir'] == '1')
				{
					$tblBody .= '<td align=\"right\">-</td>';
					$tblBody .= '<td align=\"right\">'.number_format($row['saldo_akhir'],2,'.',',').'</td>';
				}
					
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
		if($this->DDBulan->SelectedValue != '' && $this->DDTahun->SelectedValue != '' && $this->DDAkun->SelectedValue != '')
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
					'namaAkun'=>$this->DDAkun->SelectedValue)));
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
