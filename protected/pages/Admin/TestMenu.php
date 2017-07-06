<?PHP
class TestMenu extends MainConf
{

	public function onLoadComplete($param)
	{
		parent::onLoadComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			//$this->cariBtnClicked($sender,$param);
			if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
			{
				
			}
		}
		
	}
	
	public function onPreRender($param)
	{
		parent::onPreRender($param);
		
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$sql = "SELECT
						coa_copy.Ac_Code AS id,
						coa_copy.Job_Gr_Code AS pId,
						CONCAT(coa_copy.Ac_Code,' - ',coa_copy.NAMA_AKUN) AS `name`,

					IF (
						coa_copy.Job_Gr_Code = '0',
						'true',
						'false'
					) AS OPEN
					FROM
						coa_copy";
			$arrMenu = $this->queryAction($sql,'S');
			$this->menuList->Value = json_encode($arrMenu,true);
		}
	}
	
	public function cariBtnClicked($sender,$param)
	{
		$arrRekapNeraca = array();
		$tahun = date("Y");
		$bulan = date("m");
		$jmlAktivaLancar = 0;
		$jmlAktivaTetap = 0;
		$jmlAktiva = 0;
		$kas = BankRecord::finder()->findByPk('8');
		if($kas)
		{
			if($kas->saldo > 0 )
				$kasSaldo = $kas->saldo;
			else
				$kasSaldo = 0;
		}
		else
			$kasSaldo = 0;
			
		$jmlAktivaLancar += $kasSaldo;	
		
		$sqlKasBank = "SELECT SUM(tbm_bank.saldo) AS saldo_bank FROM tbm_bank WHERE tbm_bank.deleted = '0' AND tbm_bank.id != '8' ";
		$arrKasBank = $this->queryAction($sqlKasBank,'S');
		
		if($arrKasBank)
		{
			if($arrKasBank[0]['saldo_bank'] > 0 )
				$kasBank = $arrKasBank[0]['saldo_bank'];
			else
				$kasBank = 0;
		}
		else
			$kasBank = 0;
		
		$jmlAktivaLancar += $kasBank;	
		
		$sqlJual= "SELECT SUM(tbt_penerimaan_penjualan.total_penjualan) AS total_penjualan FROM tbt_penerimaan_penjualan WHERE tbt_penerimaan_penjualan.deleted = '0' ";
		$arrJual = $this->queryAction($sqlJual,'S');
		
		if($arrJual)
		{
			if($arrJual[0]['total_penjualan'] > 0 )
				$piutang = $arrJual[0]['total_penjualan'];
			else
				$piutang = 0;
				
			if($piutang > 0)
			{
				$sqlBayarJual= "SELECT SUM(tbt_penerimaan_penjualan_detail.total_pembayaran) AS total_pembayaran FROM tbt_penerimaan_penjualan_detail WHERE tbt_penerimaan_penjualan_detail.deleted = '0' ";
				$arrBayar = $this->queryAction($sqlBayarJual,'S');
				
				if($arrBayar)
				{
					$piutang -= $arrBayar[0]['total_pembayaran'];
				}
			}
		}
		else
			$piutang = 0;
		
		$jmlAktivaLancar += $piutang;	
		
		$barangDagangan = 0;	
		
		$sqlCpoStok = "SELECT SUM(tbd_stok_barang.stok) AS stok FROM tbd_stok_barang WHERE tbd_stok_barang.deleted = '0' AND tbd_stok_barang.id_barang = '10' ";
		$arrCpoStok = $this->queryAction($sqlCpoStok,'S');
		$stokCpo = $arrCpoStok[0]['stok'];
		
		$sqlCpoHarga = "SELECT tbm_barang_harga.harga FROM tbm_barang_harga WHERE tbm_barang_harga.deleted = '0' AND tbm_barang_harga.id_barang = '10' ORDER BY tbm_barang_harga.id DESC LIMIT 1";
		$arrCpoHarga = $this->queryAction($sqlCpoHarga,'S');
		$hargaCpo = $arrCpoHarga[0]['harga'];
		
		$barangDagangan += ($stokCpo * $hargaCpo);	
		
		$sqlPkStok = "SELECT SUM(tbd_stok_barang.stok) AS stok FROM tbd_stok_barang WHERE tbd_stok_barang.deleted = '0' AND tbd_stok_barang.id_barang = '11' ";
		$arrPkStok = $this->queryAction($sqlPkStok,'S');
		$stokPk = $arrPkStok[0]['stok'];
		
		$sqlPkHarga = "SELECT tbm_barang_harga.harga FROM tbm_barang_harga WHERE tbm_barang_harga.deleted = '0' AND tbm_barang_harga.id_barang = '11' ORDER BY tbm_barang_harga.id DESC LIMIT 1";
		$arrPkHarga = $this->queryAction($sqlPkHarga,'S');
		$hargaPk = $arrPkHarga[0]['harga'];
		
		$barangDagangan += ($stokPk * $hargaPk);	
		
		$jmlAktivaLancar += $barangDagangan;	
		
		$jmlAktiva += $jmlAktivaLancar;
		
		$jmlUtangDagang = 0;
		$sqlTtlTbsOrder = "SELECT
							SUM(
								tbt_tbs_order_detail.total_tbs_order
							) AS total_tbs_order
								FROM
									tbt_tbs_order_detail
								INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_tbs_order_detail.id_tbs_order
								WHERE
									tbt_tbs_order.status = '1'
									AND tbt_tbs_order.deleted = '0' 
									AND tbt_tbs_order_detail.deleted = '0' ";
		$arrTtlTbsOrder = $this->queryAction($sqlTtlTbsOrder,'S');
		$ttlTbsOrder = $arrTtlTbsOrder[0]['total_tbs_order'];
		if($ttlTbsOrder > 0)
		{
			$sqlBayar = "SELECT
								SUM(
									tbt_pembayaran_tbs.jumlah_pembayaran
								) AS total_pembayaran
							FROM
								tbt_pembayaran_tbs
							INNER JOIN tbt_tbs_order ON tbt_tbs_order.id = tbt_pembayaran_tbs.id_tbs_order
							WHERE
							 tbt_pembayaran_tbs.deleted = '0'
							AND tbt_tbs_order.`status` = '1'
							AND tbt_tbs_order.deleted = '0' ";
				$arrttlByrOrder = $this->queryAction($sqlBayar,'S');
				$ttlByrOrder = $arrttlByrOrder[0]['total_pembayaran'];
				$ttlTbsOrder -= $ttlByrOrder;
		}
		$jmlUtangDagang += $ttlTbsOrder;		
		
		$ttlPo = 0;
		$sqlPO ="SELECT
						tbt_purchase_order.id,
						tbt_purchase_order.dp,
						tbt_purchase_order.ppn
					FROM
						tbt_purchase_order
					WHERE
						tbt_purchase_order.`status` = '2' 
						AND tbt_purchase_order.deleted ='0' ";
				$arrPo = $this->queryAction($sqlPO,'S');
				foreach($arrPo as $rowPo)
				{
					$idPo = $rowPo['id'];
					$ppn = $rowPo['ppn'];
					
					$sqlTtlPO = "SELECT
									SUM(
										tbt_receiving_order_detail.subtotal
									) AS total_po
								FROM
									tbt_receiving_order_detail
								INNER JOIN tbt_receiving_order ON tbt_receiving_order.id = tbt_receiving_order_detail.id_parent
								INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_receiving_order.id_po
								WHERE
									tbt_purchase_order.id = '".$idPo."'
									AND tbt_receiving_order.deleted = '0' 
									AND tbt_receiving_order_detail.deleted = '0' 
								GROUP BY
									tbt_purchase_order.id ";
					$arrTtlPO = $this->queryAction($sqlTtlPO,'S');
					$ttlPo += $arrTtlPO[0]['total_po'];
					
					$sqlBiaya = "SELECT
									SUM(
										tbt_purchase_order_biaya_lain.biaya
									) AS Total_Biaya
								FROM
									tbt_purchase_order_biaya_lain
								INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_purchase_order_biaya_lain.id_po
								WHERE
									tbt_purchase_order.id = '".$idPo."'
								AND tbt_purchase_order_biaya_lain.deleted = '0'
								GROUP BY
									tbt_purchase_order.id";
									
					$arrTtlBiaya = $this->queryAction($sqlBiaya,'S');
					//$ttlPo += $arrTtlBiaya[0]['Total_Biaya'];
					
					$ppnCurrency = $ttlPo * ($rowPo['ppn'] / 100);
					$ttlPo += $ppnCurrency + $arrTtlBiaya[0]['Total_Biaya'];
					$ttlPo -= $rowPo['dp'];
				}
		
		if($ttlPo > 0)
		{
			$sqlBayar = "SELECT
								SUM(
									tbt_pembayaran_po.total_pembayaran
								) AS total_pembayaran
							FROM
								tbt_pembayaran_po
							INNER JOIN tbt_purchase_order ON tbt_purchase_order.id = tbt_pembayaran_po.id_po
							WHERE
								tbt_pembayaran_po.deleted = '0'
							AND tbt_purchase_order.`status` = '2'
							AND tbt_purchase_order.deleted = '0' ";
				$arrttlByrPo = $this->queryAction($sqlBayar,'S');
				$ttlByrPo = $arrttlByrPo[0]['total_pembayaran'];
				$ttlPo -= $ttlByrPo;
		}
		$jmlUtangDagang += $ttlPo;	
		
		$jmlUtangGaji = 0;
		$sqlUtangGaji = "SELECT
					SUM(tbt_rekap_gaji.total_gaji_dibayarkan) AS total_gaji_dibayarkan
				FROM
					tbt_rekap_gaji
				WHERE
					tbt_rekap_gaji.deleted = '0'
					AND tbt_rekap_gaji.status != '2'";
		$arrUtangGaji = $this->queryAction($sqlUtangGaji,'S');
		$jmlUtangGaji += $arrUtangGaji[0]['total_gaji_dibayarkan'];
		
		if($jmlUtangGaji > 0)
		{
			$sqlBayar = "SELECT SUM(tbt_bayar_rekap_gaji.total_gaji_dibayarkan) AS total_gaji_dibayarkan FROM tbt_bayar_rekap_gaji INNER JOIN tbt_rekap_gaji ON tbt_rekap_gaji.id = tbt_bayar_rekap_gaji.id_rekap WHERE tbt_rekap_gaji.status != '2' ";
			$arrBayar = $this->queryAction($sqlBayar,'S');
			$jmlUtangGaji -= $arrBayar[0]['total_gaji_dibayarkan'];
		}
		
		$jmlUtang =	$jmlUtangDagang + $jmlUtangGaji;	
		
		$currentDate = date("Y-m-d");
		$currentYear = intval(date("Y"));
		$currentMonth = intval(date("m"));
		$AktivaTetapList = array();
		$sqlAktivaTetap = "SELECT
							tbm_aktiva_tetap.id,
							tbm_aktiva_tetap.nama,
							tbm_aktiva_tetap.harga_perolehan
						FROM
							tbm_aktiva_tetap
						WHERE
							tbm_aktiva_tetap.deleted = '0'
						AND CURDATE() > tbm_aktiva_tetap.tgl_perolehan
						AND CURDATE() < tbm_aktiva_tetap.tgl_akhir_peggunaan ";		
		$arrAktivaTetap = $this->queryAction($sqlAktivaTetap,'S');
		foreach($arrAktivaTetap as $rowAktivaTetap)
		{
			$akumulasiSusut = 0;
			$sqlSusut = "SELECT
							tbd_penyusutan_aktiva.id
						FROM
							tbd_penyusutan_aktiva
						WHERE
							tbd_penyusutan_aktiva.deleted = '0'
						AND tbd_penyusutan_aktiva.id_aktiva = '".$rowAktivaTetap['id']."'
						AND tbd_penyusutan_aktiva.tahun <= ".$currentYear." 
						ORDER BY 
							tbd_penyusutan_aktiva.tahun ASC ";
			$arrSusut = $this->queryAction($sqlSusut,'S');
			foreach($arrSusut as $rowSusut)
			{
				$sqlSusutDetail = "SELECT
										tbd_penyusutan_aktiva_detail.id,
										tbd_penyusutan_aktiva_detail.tahun,
										tbd_penyusutan_aktiva_detail.bulan,
										tbd_penyusutan_aktiva_detail.nilai_penyusutan_bulanan
									FROM
										tbd_penyusutan_aktiva_detail
									WHERE
										tbd_penyusutan_aktiva_detail.deleted = '0'
									AND tbd_penyusutan_aktiva_detail.id_penyusutan = '".$rowSusut['id']."'
									ORDER BY 
										tbd_penyusutan_aktiva_detail.tahun,bulan ";
										
				$arrSusutDetail = $this->queryAction($sqlSusutDetail,'S');
				foreach($arrSusutDetail as $rowSusutDetail)
				{
					$akumulasiSusut += $rowSusutDetail['nilai_penyusutan_bulanan'];
					
					if($rowSusutDetail['tahun'] == $currentYear && $rowSusutDetail['bulan'] == $currentMonth)
						break;
				}
			}
			
			$AktivaTetapList[] = array("nama_aktiva"=>$rowAktivaTetap['nama'],"nilai_aktiva"=>$rowAktivaTetap['harga_perolehan'],"akumulasi_penyusutan"=>$akumulasiSusut);
		}	
		
		$tblBody = '';
		$tblBody .= '<tr>';
		$tblBody .= '<td colspan=\"5\"><strong>Aktiva</strong></td>';
		$tblBody .= '</tr>';
		$tblBody .= '<tr>';
		$tblBody .= '<td colspan=\"5\"><strong>Aktiva Lancar</strong></td>';
		$tblBody .= '</tr>';	
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\">Kas</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($kasSaldo,2,".",",").'</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '</tr>';
		$arrRekapNeraca[] = array("kelompok_neraca"=>"1","nama_akun"=>"Kas","nilai_akun"=>$kasSaldo);
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\">Kas di Bank</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($kasBank,2,".",",").'</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '</tr>';
		$arrRekapNeraca[] = array("kelompok_neraca"=>"1","nama_akun"=>"Kas di Bank","nilai_akun"=>$kasBank);
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\">Piutang Dagang </td>';
		$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($piutang,2,".",",").'</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '</tr>';	
		$arrRekapNeraca[] = array("kelompok_neraca"=>"1","nama_akun"=>"Piutang Dagang","nilai_akun"=>$piutang);
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\">Persediaan Barang Dagangan </td>';
		$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($barangDagangan,2,".",",").'</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '</tr>';	
		$arrRekapNeraca[] = array("kelompok_neraca"=>"1","nama_akun"=>"Persediaan Barang Dagangan","nilai_akun"=>$barangDagangan);
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\" align=\"right\">Jumlah Aktiva Lancar</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"><strong>'.number_format($jmlAktivaLancar,2,".",",").'</strong></td>';
		$tblBody .= '</tr>';
		$tblBody .= '<tr>';
		$tblBody .= '<td colspan=\"5\"><strong>Aktiva Tetap</strong></td>';
		$tblBody .= '</tr>';	
		
		foreach($AktivaTetapList as $rowAktivaTetap)
		{
			$tblBody .= '<tr>';
			$tblBody .= '<td width=\"5%\"></td>';
			$tblBody .= '<td width=\"40%\">'.$rowAktivaTetap['nama_aktiva'].' </td>';
			$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($rowAktivaTetap['nilai_aktiva'],2,".",",").'</td>';
			$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
			$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
			$tblBody .= '</tr>';
			$arrRekapNeraca[] = array("kelompok_neraca"=>"2","nama_akun"=>$rowAktivaTetap['nama_aktiva'],"nilai_akun"=>$rowAktivaTetap['nilai_aktiva']);
			$tblBody .= '<tr>';
			$tblBody .= '<td width=\"5%\"></td>';
			$tblBody .= '<td width=\"40%\">Akumulasi Penyusutan '.ucwords($rowAktivaTetap['nama_aktiva']).' </td>';
			$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($rowAktivaTetap['akumulasi_penyusutan'],2,".",",").'</td>';
			$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
			$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
			$tblBody .= '</tr>';
			$arrRekapNeraca[] = array("kelompok_neraca"=>"2","nama_akun"=>"Akumulasi Penyusutan ".ucwords($rowAktivaTetap['nama_aktiva']),"nilai_akun"=>$rowAktivaTetap['akumulasi_penyusutan']);
			$tblBody .= '<tr>';
			$tblBody .= '<td width=\"5%\"></td>';
			$tblBody .= '<td width=\"40%\"></td>';
			$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
			$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($rowAktivaTetap['nilai_aktiva']-$rowAktivaTetap['akumulasi_penyusutan'],2,".",",").'</td>';
			$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
			$tblBody .= '</tr>';
			
			$jmlAktivaTetap += ($rowAktivaTetap['nilai_aktiva']-$rowAktivaTetap['akumulasi_penyusutan']);
			
		
		}
		
		$jmlAktiva += $jmlAktivaTetap;	
		
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\" align=\"right\">Jumlah Aktiva Tetap</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"><strong>'.number_format($jmlAktivaTetap,2,".",",").'</strong></td>';
		$tblBody .= '</tr>';
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\" align=\"right\"><strong>Jumlah Aktiva</strong></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"><strong>'.number_format($jmlAktiva,2,".",",").'</strong></td>';
		$tblBody .= '</tr>';
		$tblBody .= '<tr>';
		$tblBody .= '<td colspan=\"5\"><strong>Kewajiban</strong></td>';
		$tblBody .= '</tr>';
		$tblBody .= '<tr>';
		$tblBody .= '<td colspan=\"5\"><strong>Utang Lancar</strong></td>';
		$tblBody .= '</tr>';
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\">Utang Dagang</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($jmlUtangDagang,2,".",",").'</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '</tr>';
		$arrRekapNeraca[] = array("kelompok_neraca"=>"3","nama_akun"=>"Utang Dagang","nilai_akun"=>$jmlUtangDagang);
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\">Utang Gaji</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\">'.number_format($jmlUtangGaji,2,".",",").'</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '</tr>';
		$arrRekapNeraca[] = array("kelompok_neraca"=>"3","nama_akun"=>"Utang Gaji","nilai_akun"=>$jmlUtangGaji);
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\" align=\"right\">Jumlah Utang</td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"><strong>'.number_format($jmlUtang,2,".",",").'</strong></td>';
		$tblBody .= '</tr>';
		$tblBody .= '<tr>';
		$tblBody .= '<td width=\"5%\"></td>';
		$tblBody .= '<td width=\"40%\" align=\"right\"><strong>Jumlah Kewajiban</strong></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"></td>';
		$tblBody .= '<td width=\"20%\" align=\"right\"><strong>'.number_format($jmlUtang,2,".",",").'</strong></td>';
		$tblBody .= '</tr>';
		
		$this->setViewState('arrRekapNeraca',$arrRekapNeraca);
		
		$this->getPage()->getClientScript()->registerEndScript
					('','
					console.log("'.$tblBody.'");
					jQuery("#table-1 tbody").empty();
					jQuery("#table-1 tbody").append("'.$tblBody.'");
					unloadContent();
					');
		
	}
	
	public function closingClicked()
	{
		$bulan = date("m");
		$tahun = date("Y");
		$arrRekapNeraca = $this->getViewState('arrRekapNeraca');
		
		if(count($arrRekapNeraca) > 0)
		{
			$RekapNeracaRecord = RekapNeracaRecord::finder()->find('bulan = ? AND tahun = ? AND deleted = ?',$bulan,$tahun,'0');
			if(!$RekapNeracaRecord)
			{
				$RekapNeracaRecord = new RekapNeracaRecord();
				$RekapNeracaRecord->bulan = $bulan;
				$RekapNeracaRecord->tahun = $tahun;
				$RekapNeracaRecord->deleted = '0';
				$RekapNeracaRecord->save();
				
				foreach($arrRekapNeraca as $row)
				{
					$RekapNeracaDetailRecord = new RekapNeracaDetailRecord();
						
					$RekapNeracaDetailRecord->id_rekap = $RekapNeracaRecord->id;
					$RekapNeracaDetailRecord->kelompok_akun = $row['kelompok_neraca'];
					$RekapNeracaDetailRecord->nama_akun = $row['nama_akun'];
					$RekapNeracaDetailRecord->nilai_akun = $row['nilai_akun'];
					$RekapNeracaDetailRecord->deleted = '0';
					$RekapNeracaDetailRecord->save();
					
				}
				
				$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						toastr.info("Neraca Bulan Ini Berhasil Diclosing !");
						');	
			}
			else
			{
				$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						toastr.error("Neraca Bulan Ini Sudah Diclosing Sebelumnya !");
						');	
			}
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
						('','
						unloadContent();
						toastr.error("Rekap Neraca Belum Diproses !");
						');	
		}
	}
	
}
?>
