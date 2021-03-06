<?PHP
class MainConf extends TPage
{
	public function queryAction($sql,$mode)
	{
		$conn = new TDbConnection("mysql:host=localhost;dbname=".Prado::getApplication()->Parameters['dbname'],Prado::getApplication()->Parameters['dbuser'],Prado::getApplication()->Parameters['dbpass']);				
			$conn->Persistent=true;
		$conn->Active=true;				
		if($mode == "C")//Use this with INSERT, DELETE and EMPTY operation
		{
			$comm=$conn->createCommand($sql);		
			$dataReader = $comm->query();						
		}
		else if($mode == "S")//Return for select statement
		{	
			$comm=$conn->createCommand($sql);		
			$dataReader = $comm->query();
			$rows=$dataReader->readAll();				
			
		}		
		else if($mode == "R") //Return set of rows
		{	
			$comm=$conn->createCommand($sql);		
			$dataReader = $comm->query();
			$rows=$dataReader;		
			
		}			
		else if($mode == "D") //Droped table
		{
			$que = "DROP TABLE IF EXISTS " . $sql;
			$comm=$conn->createCommand($que);		
			$dataReader = $comm->query();						
		}
		else if($mode == "X") //Droped table
		{
			$comm=$conn->createCommand($sql);
			$dataReader = $comm->query();
			$row=$dataReader->read();
			$rows = $row[count];	
		}	
		return $rows;
		$conn->Active=false;				
	}
	
	public function ConvertDate($tgl,$mode)
	{
		 if($mode == "1"){ //to normal
		 	$strtmp = substr($tgl,8,2) . "-" . substr($tgl,5,2)  . "-" . substr($tgl,0,4);
		}elseif($mode == "2"){ //to mysql		 
		 	$strtmp = substr($tgl,6,4) . "-" . substr($tgl,3,2)  . "-" . substr($tgl,0,2);
		}else{//to tgl indonesia 
				$blnIndo=$this->namaBulan(substr($tgl,5,2));
				$strtmp=substr($tgl,8,2) . " " . $blnIndo  . " " . substr($tgl,0,4);
			}		
		
		 return $strtmp;
	}
	
	public function GenerateNoDO($bln,$thn,$tipeCommodity)
	{
		$query = "SELECT 
						id 
					FROM 
						tbt_contract_sales
					WHERE
					MONTH(tbt_contract_sales.tgl_do) = '$bln'
					AND YEAR(tbt_contract_sales.tgl_do) = '$thn' 
					AND tbt_contract_sales.commodity_type = '$tipeCommodity' ";
		$arr = $this->queryAction($query,'S');
		
		$count = count($arr) + 1;
		
		if($count < 10)
			$tmp = "0000";
		elseif($count < 100)
			$tmp = "000";	
		elseif($count < 1000)
			$tmp = "00";
		elseif($count < 10000)
			$tmp = "0";
		else
			$tmp = "";
		
		$blnrmw = $this->bulanRomawi($bln);
		
		if($tipeCommodity == '0')
		{
			$noDoc = "DO-CPO";
			$noDocSKP = "SKP-CPO";
		}
		elseif($tipeCommodity == '1')
		{
			$noDoc = "DO-PK";
			$noDocSKP = "SKP-PK";
		}
		elseif($tipeCommodity == '2')
		{
			$noDoc = "DO-FIB";
			$noDocSKP = "SKP-FIB";
		}
		elseif($tipeCommodity == '3')
		{
			$noDoc = "DO-CK";
			$noDocSKP = "SKP-CK";
		}
					
		$noTransDO = $tmp.$count."/PT.SH/".$noDoc."/".$blnrmw."/".$thn;
		$noTransSK = $tmp.$count."/PT.SH/".$noDocSKP."/".$blnrmw."/".$thn;
		
		$arrDoc = array("noDO"=>$noTransDO,"noSKP"=>$noTransSK);
		return $arrDoc;
	}
	
	public function GenerateNoSales($bln,$thn,$tipeCommodity)
	{
		$query = "SELECT 
						id 
					FROM 
						tbt_contract_sales
					WHERE
					MONTH(tbt_contract_sales.tgl_kontrak) = '$bln'
					AND YEAR(tbt_contract_sales.tgl_kontrak) = '$thn' 
					AND commodity_type = '$tipeCommodity' ";
		$arr = $this->queryAction($query,'S');
		
		$count = count($arr) + 1;
		
		if($count < 10)
			$tmp = "0000";
		elseif($count < 100)
			$tmp = "000";	
		elseif($count < 1000)
			$tmp = "00";
		elseif($count < 10000)
			$tmp = "0";
		else
			$tmp = "";
		
		$blnrmw = $this->bulanRomawi($bln);
		
		if($tipeCommodity == '0')
			$noDoc = "CPO";
		elseif($tipeCommodity == '1')
			$noDoc = "PK";
		elseif($tipeCommodity == '2')
			$noDoc = "FIB";
		elseif($tipeCommodity == '3')
			$noDoc = "CK";
					
		$noTrans = $tmp.$count."/PT.SH/".$noDoc."/".$blnrmw."/".$thn;
		
		return $noTrans;
	}
	
	public function GenerateNoDocument($kode,$month='',$year='')
	{
		if($kode == "RO")
		{
			$tblTrans = 'tbt_request_order';
			$fieldTgl = 'tgl_ro';
		}
		elseif($kode == "PO")
		{
			$tblTrans = 'tbt_purchase_order';
			$fieldTgl = 'tgl_po';
		}
		elseif($kode == "RC")
		{
			$tblTrans = 'tbt_receiving_order';
			$fieldTgl = 'tgl_terima';
		}
		elseif($kode == "TBS")
		{
			$tblTrans = 'tbt_tbs_order';
			$fieldTgl = 'tgl_transaksi';
		}
		elseif($kode == "PAY")
		{
			$tblTrans = 'tbt_pembayaran_tbs';
			$fieldTgl = 'tgl_pembayaran';
		}
		elseif($kode == "PO-PAY")
		{
			$tblTrans = 'tbt_pembayaran_po';
			$fieldTgl = 'tgl_pembayaran';
		}
		elseif($kode == "PRC")
		{
			$tblTrans = 'tbt_processing_tbs';
			$fieldTgl = 'tgl_processing';
		}
		elseif($kode == "EXP")
		{
			$tblTrans = 'tbt_expense_transaction';
			$fieldTgl = 'tgl_transaksi';
		}
		elseif($kode == "REV")
		{
			$tblTrans = 'tbt_revenue_transaction';
			$fieldTgl = 'tgl_transaksi';
		}
		elseif($kode == "PROC")
		{
			$tblTrans = 'tbt_processing_product';
			$fieldTgl = 'tgl_processing';
		}
		elseif($kode == "STK")
		{
			$tblTrans = 'tbt_stock_opname';
			$fieldTgl = 'tgl_stock_opname';
		}
		elseif($kode == "COM")
		{
			$tblTrans = 'tbt_commodity_transaction';
			$fieldTgl = 'tgl_transaksi';
		}
		elseif($kode == "RG")
		{
			$tblTrans = 'tbt_bayar_rekap_gaji';
			$fieldTgl = 'tgl_pembayaran';
		}
		
		if($month == '')
			$month = date("m");
		
		if($year == '')	
			$year = date("Y");
		
		$query = "SELECT 
						id 
					FROM 
						".$tblTrans."
					WHERE
					MONTH(".$tblTrans.".".$fieldTgl.") = $month
					AND YEAR(".$tblTrans.".".$fieldTgl.") = $year ";
					
		$arr = $this->queryAction($query,'S');
		
		$urut = count($arr)+1;
		
		if($urut < 10)
			$tmp = "0000";
		elseif($urut < 100)
			$tmp = "000";	
		elseif($urut < 1000)
			$tmp = "00";
		elseif($urut < 10000)
			$tmp = "0";
		else
			$tmp = "";
			
		$noTrans = $kode."/".$year."/".$month."/".$tmp.$urut;
		
		return $noTrans;
	}
	
	public function bulanRomawi($month)
	{
		$nmBln=array('01'=>'I','02'=>'II','03'=>'III','04'=>'IV','05'=>'V','06'=>'VI','07'=>'VII','08'=>'VIII','09'=>'IX','10'=>'X','11'=>'XI','12'=>'XII');
		$sayBln = $nmBln[$month];
		return $sayBln;
	}
	
	public function getTempVariable($temp)
	{
		$temp = intval($temp);
		$defaultTemp = 30;
		$varTemp = 0.909;
		
		while($defaultTemp < 100)
		{
			if($temp == $defaultTemp)
				break;
			else
			{
				$defaultTemp++;
				$varTemp = $varTemp - 0.0007;
				
			}
		}
		
		return $varTemp;
		
	}
	
	public function decimalHours($time)
	{
		$hms = explode(":", $time);
		return ($hms[0] + ($hms[1]/60) + ($hms[2]/3600));
	}

	public function AddPlayTime($times) 
	{

		// loop throught all the times
		foreach ($times as $time) {
			list($hour, $minute) = explode(':', $time);
			$minutes += $hour * 60;
			$minutes += $minute;
		}

		$hours = floor($minutes / 60);
		$minutes -= $hours * 60;

		// returns the time already formatted
		return sprintf('%02d:%02d', $hours, $minutes);
	}

	public function GetLastProductPrice($idBarang)
	{
		$sql =  "SELECT
					tbm_barang_harga.harga
				FROM 
					tbm_barang_harga
				WHERE
					tbm_barang_harga.id_barang = '$idBarang'
				AND tbm_barang_harga.deleted ='0' 
				ORDER BY tbm_barang_harga.id DESC
				LIMIT 1 ";
				
		$arr = $this->queryAction($sql,'S');
		
		if($arr)
		{
			$hargaBeli = $arr[0]['harga'];
		}
		else
		{
			$hargaBeli = 0;
		}
		
		
		return $hargaBeli;
	}
	
	public function get_time_difference($time1, $time2)
	{
		$time1 = strtotime("1/1/1980 $time1");
		$time2 = strtotime("1/1/1980 $time2");
		
		if ($time2 < $time1)
		{
			$time2 = $time2 + 86400;
		}
		
		return ($time2 - $time1) / 3600;
		
	}  
	
	public function getTargetUom($productId,$qtyProduct,$uomInitial='0',$stTarget='0',$uomTarget='0')
	{	
		if($uomInitial == '0')
		{
			$sqlUomInitial = "SELECT id_satuan FROM tbm_satuan_barang WHERE deleted ='0' AND id_barang = '".$productId."' ORDER BY urutan DESC LIMIT 1";
			$arrInitial = $this->queryAction($sqlUomInitial,'S');
			foreach($arrInitial as $rowInitial)
			{
				$uomInitial = $rowInitial['id_satuan'];
			}
		}
		//var_dump($productId);
		//var_dump($uomInitial);
		if($stTarget == '0')
		{
			$UomOrder = BarangSatuanRecord::finder()->find('id_barang = ? AND id_satuan = ? AND deleted = ?',$productId,$uomInitial,'0')->urutan;
			$sqlMaxOrder = "SELECT urutan,jumlah FROM tbm_satuan_barang WHERE deleted ='0' AND id_barang = '$productId' ORDER BY urutan DESC LIMIT 1";
			$arrMax = $this->queryAction($sqlMaxOrder,'S');
			foreach($arrMax as $row)
			{
				$UomOrderMax = $row['urutan'];
				$qtyMax = $row['jumlah'];
			}
			if($UomOrder == $UomOrderMax)
			{
				$conversionQty = $qtyProduct;
			}
			else
			{
				$conversionQty = $qtyProduct;
				$sqlConvert = "SELECT 
									urutan,
									jumlah 
								FROM 
									tbm_satuan_barang 
								WHERE 
									deleted ='0' 
									AND id_barang = '".$productId."' 
									AND urutan > ".$UomOrder."
								ORDER BY urutan ASC ";
				$arrConvert = $this->queryAction($sqlConvert,'S');
				foreach($arrConvert as $rowConvert)
				{
					$conversionQty = $conversionQty * $rowConvert['jumlah'];
				}
			}
			$sqlOrderUom = "SELECT 
								tbm_satuan_barang.id,
								tbm_satuan_barang.id_barang,
								tbm_satuan_barang.id_satuan,
								tbm_satuan_barang.jumlah,
								tbm_satuan_barang.urutan ,
								tbm_satuan.id AS id_satuan,
								tbm_satuan.nama
							FROM
								tbm_satuan_barang 
								INNER JOIN tbm_satuan ON tbm_satuan.id = tbm_satuan_barang.id_satuan
							WHERE 
								tbm_satuan_barang.deleted ='0' 
								AND tbm_satuan_barang.id_barang ='".$productId."' 
								AND tbm_satuan.deleted = '0' ";
			
			$sqlOrderUom .= "ORDER BY urutan DESC ";
			$arrOrderUom = $this->queryAction($sqlOrderUom,'S');
			$realQty = $conversionQty;
			//var_dump($realQty);
			$arrQty = array();
			
			$sqlFirst = "SELECT urutan,jumlah FROM tbm_satuan_barang WHERE deleted ='0' AND id_barang = '$productId' ORDER BY urutan ASC LIMIT 1";
			$urutanFirst = $this->queryAction($sqlFirst,'S');
			foreach($arrOrderUom as $rowOrder)
			{
				if($rowOrder['urutan'] == $urutanFirst[0]['urutan'])
				{
					
					$arrQty[] = array("qty"=>intval($realQty),"name"=>$rowOrder['nama'],"id"=>$rowOrder['id_satuan']);
				}
				else
				{
					if($realQty % $rowOrder['jumlah'] != 0)
					{
						
						$arrQty[] = array("qty"=>$realQty % $rowOrder['jumlah'],"name"=>$rowOrder['nama'],"id"=>$rowOrder['id_satuan']);
					}
				}
				$realQty = $realQty / $rowOrder['jumlah'];
			}
				//var_dump($arrQty);
			usort($arrQty, function($a, $b) {
								return $a['order'] - $b['order'];
							});
			return $arrQty;
		}
		else
		{
			if($uomTarget == '0')
			{
				$sqlUomTarget = "SELECT id_satuan FROM tbm_satuan_barang WHERE deleted ='0' AND id_barang = '".$productId."' ORDER BY urutan DESC LIMIT 1";
				$arrTarget = $this->queryAction($sqlUomTarget,'S');
				foreach($arrTarget as $rowTarget)
				{
					$uomTarget = $rowTarget['id_satuan'];
				}
			}
		
			$UomOrderTarget = BarangSatuanRecord::finder()->find('id_barang = ? AND id_satuan = ? AND deleted = ?',$productId,$uomTarget,'0')->urutan;
			$UomOrderInitial = BarangSatuanRecord::finder()->find('id_barang = ? AND id_satuan = ? AND deleted = ?',$productId,$uomInitial,'0')->urutan;
			
			if($UomOrderTarget !=  $UomOrderInitial)
			{
				$sqlOrderUom = "SELECT 
								tbm_satuan_barang.id,
								tbm_satuan_barang.id_barang,
								tbm_satuan_barang.id_satuan,
								tbm_satuan_barang.jumlah,
								tbm_satuan_barang.urutan ,
								tbm_satuan.id AS id_satuan,
								tbm_satuan.nama
							FROM
								tbm_satuan_barang 
								INNER JOIN tbm_satuan ON tbm_satuan.id = tbm_satuan_barang.id_satuan
							WHERE 
								tbm_satuan_barang.deleted ='0' 
								AND tbm_satuan_barang.id_barang ='".$productId."' 
								AND tbm_satuan.deleted = '0' ";
								
				if($UomOrderTarget > $UomOrderInitial)
				{
					$sqlOrderUom .="AND tbm_satuan_barang.urutan > ".$UomOrderInitial." ";
					$sqlSort = "ASC";
				}
				elseif($UomOrderTarget <  $UomOrderInitial)
				{
					$sqlOrderUom .="AND tbm_satuan_barang.urutan < ".$UomOrderInitial." ";
					$sqlSort = "DESC";
				}
				
				$sqlOrderUom .= " ORDER BY urutan ".$sqlSort ;
				//var_dump($sqlOrderUom);
				
				$arrOrderUom = $this->queryAction($sqlOrderUom,'S');
				
				if($UomOrderTarget > $UomOrderInitial)
				{
					foreach($arrOrderUom as $rowUom)
					{	
						$qtyProduct = $qtyProduct * $rowUom['jumlah'];	
								
						if($rowUom['urutan'] == $UomOrderTarget)
								break;
						
						
					}
				}
				elseif($UomOrderTarget <  $UomOrderInitial)
				{
					foreach($arrOrderUom as $rowUom)
					{
						if($rowUom['urutan'] == $UomOrderTarget)
							break;
							
						$qtyProduct = $qtyProduct / $rowUom['jumlah'];
							
							
						
					}
				}
				
				return intval($qtyProduct);
			}
			else
			{
				//
				return intval($qtyProduct);
			}
			
			
		}
	}
	
	public function checkConversionPrice($productID,$UOm,$price)
	{
		$UomOrder = BarangSatuanRecord::finder()->find('id_barang = ? AND id_satuan = ? ',$productID,$UOm)->urutan;
		if($UomOrder == '1')
		{
			$pricePer = $price;
		}
		else
		{
			$sqlOrderUom = "SELECT 
								id,
								id_barang,
								id_satuan,
								jumlah,
								urutan 
							FROM
								tbm_satuan_barang 
							WHERE 
								deleted ='0' 
								AND id_barang ='$productID' 
								AND urutan > 1 
							ORDER BY urutan ASC ";
			$arrOrderUom = $this->queryAction($sqlOrderUom,'S');
			$qtyBefore = 1;
			$pricePer = $price;
			foreach($arrOrderUom as $rowOrder)
			{
				$pricePer = $pricePer / $rowOrder['jumlah'];
				$qtyBefore = $rowOrder['jumlah'];
				
				if($rowOrder['id_satuan'] == $UOm)
				{
					break;
				}
			}
		}
		return $pricePer;
		
	}
	
	public function GetPriceUom($productID,$urutan,$price)
	{
		$sqlOrderUom = "SELECT 
								id,
								id_barang,
								id_satuan,
								jumlah,
								urutan 
							FROM
								tbm_satuan_barang 
							WHERE 
								deleted ='0' 
								AND id_barang ='$productID' 
								AND urutan <= $urutan 
							ORDER BY urutan DESC ";
		$arrOrderUom = $this->queryAction($sqlOrderUom,'S');
		$pricePer = $price;
		foreach($arrOrderUom as $rowOrder)
		{
			if($rowOrder['urutan'] != 1)
			{
				$pricePer = $pricePer * $rowOrder['jumlah'];
			}
		}
		
		return $pricePer;
	}
	
	public function GetCurrentPriceUom($productID,$idSatuan,$price)
	{
		$sqlOrderUom = "SELECT 
								id,
								id_barang,
								id_satuan,
								jumlah,
								urutan 
							FROM
								tbm_satuan_barang 
							WHERE 
								deleted ='0' 
								AND id_barang ='$productID' 
							ORDER BY urutan ASC ";
		$arrOrderUom = $this->queryAction($sqlOrderUom,'S');
		$pricePer = $price;
		foreach($arrOrderUom as $rowOrder)
		{
			$pricePer = $pricePer / $rowOrder['jumlah'];
			
			if($rowOrder['id_satuan'] == $idSatuan)
				break;
		}
		
		return $pricePer;
	}
	
	public function terbilang($num,$nonDecimal=false) {
		  $digits = array(
			0 => "Nol",
			1 => "satu",
			2 => "dua",
			3 => "tiga", 
			4 => "empat",
			5 => "lima",
			6 => "enam",
			7 => "tujuh",
			8 => "delapan",
			9 => "sembilan");
		  $orders = array(
			 0 => "",
			 1 => "puluh",
			 2 => "ratus",
			 3 => "ribu",
			 6 => "juta",
			 9 => "miliar",
			12 => "triliun",
			15 => "kuadriliun");
		
		  $is_neg = $num < 0; $num = "$num";
		
		  //// angka di kiri desimal
		
		  $int = ""; if (preg_match("/^[+-]?(\d+)/", $num, $m)) $int = $m[1];
		  $mult = 0; $wint = "";
		
		  // ambil ribuan/jutaan/dst
		  while (preg_match('/(\d{1,3})$/', $int, $m)) {
			
			// ambil satuan, puluhan, dan ratusan
			$s = $m[1] % 10; 
			$p = ($m[1] % 100 - $s)/10;
			$r = ($m[1] - $p*10 - $s)/100;
			
			// konversi ratusan
			if ($r==0) $g = "";
			elseif ($r==1) $g = "se$orders[2]";
			else $g = $digits[$r]." $orders[2]";
			
			// konversi puluhan dan satuan
			if ($p==0) {
			  if ($s==0);
			  elseif ($s==1) $g = ($g ? "$g ".$digits[$s] :
										($mult==0 ? $digits[1] : "se"));                                                                                
			  else $g = ($g ? "$g ":"") . $digits[$s];
			} elseif ($p==1) {
			  if ($s==0) $g = ($g ? "$g ":"") . "se$orders[1]";
			  elseif ($s==1) $g = ($g ? "$g ":"") . "sebelas";
			  else $g = ($g ? "$g ":"") . $digits[$s] . " belas";
			} else {
			  $g = ($g ? "$g ":"").$digits[$p]." puluh".
				   ($s > 0 ? " ".$digits[$s] : "");
			}
		
			// gabungkan dengan hasil sebelumnya                    
			$wint = ($g ? $g.($g=="se" ? "":" ").$orders[$mult]:"").
					($wint ? " $wint":""); 
			
			
			// pangkas ribuan/jutaan/dsb yang sudah dikonversi
			$int = preg_replace('/\d{1,3}$/', '', $int);
			$mult+=3;
		  }
		  if (!$wint) $wint = $digits[0];
		  
		  //// angka di kanan desimal
		
		  $frac = ""; if (preg_match("/\.(\d+)/", $num, $m)) $frac = $m[1];
		  $wfrac = "";
		  
		  if($nonDecimal==false){
				for ($i=0; $i<strlen($frac); $i++) {
				$wfrac .= ($wfrac ? " ":"").$digits[substr($frac,$i,1)];
				}             
			}
			
		  $wintEYD=str_ireplace("sejuta","satu juta",$wint);
		  return ($is_neg ? "minus ":"").$wintEYD.($wfrac ? " koma $wfrac":"");
		}
		
	public function namaBulan($month)
	{
		$nmBln=array('01'=>'Januari','02'=>'Februari','03'=>'Maret','04'=>'April','05'=>'Mei','06'=>'Juni','07'=>'Juli','08'=>'Agustus','09'=>'September','10'=>'Oktober','11'=>'November','12'=>'Desember');
		$sayBln = $nmBln[$month];
		return $sayBln;
	}
	
	public function collectSelectionResult($input)
    {
        $indices=$input->SelectedIndices;
        $result='';
        foreach($indices as $index)
        {
            $item=$input->Items[$index];
            $result.="$item->Value,";
        }
		$v = strlen($result) - 1;
		$res=substr($result,0,$v);
        return $res;
    }
    
    public function collectSelectionResultText($input)
    {
        $indices=$input->SelectedIndices;
        $result='';
        foreach($indices as $index)
        {
            $item=$input->Items[$index];
            $result.="$item->Text,";
        }
                $v = strlen($result) - 1;
                $res=substr($result,0,$v);
        return $res;
    }
    
    protected function collectSelectionListResult($input)
	{
		$indices=$input->SelectedIndices;		
		foreach($indices as $index)
		{
			$item=$input->Items[$index];
			return $index;
		}		
	}
	
	public function formatCurrency($data,$dec=0) 
	{
		return number_format($data,$dec,'.',',');
	}
	
	public function toInt($str)
	{
		return preg_replace("/([^0-9\\.])/i", "", $str);
	}
	
	public static function prosesLogout()
	{
		$user = Prado::getApplication()->User->Name;
		//var_dump($user);
		$userData = UserRecord::finder()->findByPk($user);
		$userData->st_log = '0';
		$userData->ssid = '';
		$userData->save();
		
		Prado::getApplication()->getModule('auth')->logout();
		$url=Prado::getApplication()->Service->constructUrl(Prado::getApplication()->Service->DefaultPage);
		Prado::getApplication()->Response->redirect($url);
	}
	
	public function InsertLabaRugi($id_transaksi,$sumber_transaksi,$jns_transaksi,$tgl_transaksi,$wkt_transaksi,$keterangan,$jumlah_transaksi,$no_transaksi)
	{
		/*
		 * Sumber Transaksi -> 0 = Setor Modal Awal
		 * Sumber Transaksi -> 1 = Beban Bayar PO
		 * Sumber Transaksi -> 2 = Beban Bayar Tbs Order
		 * Sumber Transaksi -> 3 = Penerimaan Penjualan Commodity
		 * Sumber Transaksi -> 4 = Pengeluaran Lain-lain / Expense Transaction
		 * Sumber Transaksi -> 5 = Pendapatan Lain-lain / Revenue Transaction
		 * Sumber Transaksi -> 6 = Uang Muka Pembelian
		 * Sumber Transaksi -> 7 = Beban Bayar Gaji Karyawan
		 */
		 
		$LabaRugiRecord = new LabaRugiRecord();
		$LabaRugiRecord->id_transaksi = $id_transaksi;
		$LabaRugiRecord->sumber_transaksi = $sumber_transaksi;
		$LabaRugiRecord->jns_transaksi = $jns_transaksi;
		$LabaRugiRecord->tgl_transaksi = $tgl_transaksi;
		$LabaRugiRecord->wkt_transaksi = $wkt_transaksi;
		$LabaRugiRecord->keterangan = $keterangan;
		$LabaRugiRecord->jumlah_transaksi = $jumlah_transaksi;
		$LabaRugiRecord->no_transaksi = $no_transaksi;
		$LabaRugiRecord->deleted = '0';
		$LabaRugiRecord->save();
	}
	
	public function InsertJurnalUmum($id_transaksi,$sumber_transaksi,$jns_transaksi,$tgl_transaksi,$wkt_transaksi,$keterangan,$jumlah_saldo,$no_transaksi,$id_bank = '0')
	{
		/*
		 * $sumber_transaksi = 0 -> Saldo Awal
		 * $sumber_transaksi = 8 -> DP Purchase Order
		 * */
		$JurnalUmumRecord = new JurnalUmumRecord();
		$JurnalUmumRecord->id_transaksi = $id_transaksi;
		$JurnalUmumRecord->sumber_transaksi = $sumber_transaksi;
		$JurnalUmumRecord->jns_transaksi = $jns_transaksi;
		$JurnalUmumRecord->tgl_transaksi = $tgl_transaksi;
		$JurnalUmumRecord->wkt_transaksi = $wkt_transaksi;
		$JurnalUmumRecord->keterangan = $keterangan;
		$JurnalUmumRecord->jumlah_saldo = $jumlah_saldo;
		$JurnalUmumRecord->no_transaksi = $no_transaksi;
		$JurnalUmumRecord->id_bank = $id_bank;
		$JurnalUmumRecord->deleted = '0';
		$JurnalUmumRecord->save();
	}
	
	public function InsertJurnalPembelian($id_transaksi,$no_transaksi,$jns_transaksi,$tgl_transaksi,$wkt_transaksi,$keterangan,$nama_akun='',$ref='',$jumlah)
	{
		/*
		 * JnsTransaksi = 1 -> Pembelian
		 * JnsTransaksi = 2 -> Serba-serbi
		 * */
		$JurnalPembelianRecord = new JurnalPembelianRecord();
		$JurnalPembelianRecord->id_transaksi = $id_transaksi;
		$JurnalPembelianRecord->no_transaksi = $no_transaksi;
		$JurnalPembelianRecord->jns_transaksi = $jns_transaksi;
		$JurnalPembelianRecord->tgl_transaksi = $tgl_transaksi;
		$JurnalPembelianRecord->wkt_transaksi = $wkt_transaksi;
		$JurnalPembelianRecord->keterangan = $keterangan;
		$JurnalPembelianRecord->nama_akun = $nama_akun;
		$JurnalPembelianRecord->ref = $ref;
		$JurnalPembelianRecord->jumlah = $jumlah;
		$JurnalPembelianRecord->deleted = '0';
		$JurnalPembelianRecord->save();
	}
	
	public function InsertJurnalPengeluaranKas($id_transaksi,$no_transaksi,$jns_transaksi,$tgl_transaksi,$wkt_transaksi,$keterangan,$nama_akun='',$ref='',$jumlah,$potongan=0)
	{
		/*
		 * JnsTransaksi = 1 -> Bayar Hutang / Utang Dagang
		 * JnsTransaksi = 2 -> Pembelian Tunai
		 * JnsTransaksi = 3 -> Serba-serbi
		 * */
		 
		$JurnalPengeluaranKasRecord = new JurnalPengeluaranKasRecord();
		$JurnalPengeluaranKasRecord->id_transaksi = $id_transaksi;
		$JurnalPengeluaranKasRecord->no_transaksi = $no_transaksi;
		$JurnalPengeluaranKasRecord->jns_transaksi = $jns_transaksi;
		$JurnalPengeluaranKasRecord->tgl_transaksi = $tgl_transaksi;
		$JurnalPengeluaranKasRecord->wkt_transaksi = $wkt_transaksi;
		$JurnalPengeluaranKasRecord->keterangan = $keterangan;
		$JurnalPengeluaranKasRecord->nama_akun = $nama_akun;
		$JurnalPengeluaranKasRecord->ref = $ref;
		$JurnalPengeluaranKasRecord->jumlah = $jumlah;
		$JurnalPengeluaranKasRecord->potongan = $potongan;
		$JurnalPengeluaranKasRecord->deleted = '0';
		$JurnalPengeluaranKasRecord->save();
	}
	
	public function InsertJurnalPenjualan($id_transaksi,$no_transaksi,$jns_transaksi,$tgl_transaksi,$wkt_transaksi,$keterangan,$syarat='',$ref='',$jumlah)
	{
		$JurnalPenjualanRecord = new JurnalPenjualanRecord();
		$JurnalPenjualanRecord->id_transaksi = $id_transaksi;
		$JurnalPenjualanRecord->no_transaksi = $no_transaksi;
		$JurnalPenjualanRecord->jns_transaksi = $jns_transaksi;
		$JurnalPenjualanRecord->tgl_transaksi = $tgl_transaksi;
		$JurnalPenjualanRecord->wkt_transaksi = $wkt_transaksi;
		$JurnalPenjualanRecord->keterangan = $keterangan;
		$JurnalPenjualanRecord->syarat = $syarat;
		$JurnalPenjualanRecord->ref = $ref;
		$JurnalPenjualanRecord->jumlah = $jumlah;
		$JurnalPenjualanRecord->deleted = '0';
		$JurnalPenjualanRecord->save();
	}
	
	public function InsertJurnalPenerimaanKas($id_transaksi,$no_transaksi,$jns_transaksi,$tgl_transaksi,$wkt_transaksi,$keterangan,$nama_akun='',$ref='',$jumlah,$potongan=0)
	{
		/*
		 * JnsTransaksi = 1 -> Bayar Piutang / Piutang Dagang
		 * JnsTransaksi = 2 -> Jual Tunai
		 * JnsTransaksi = 3 -> Serba-serbi
		 * */
		 
		$JurnalPenerimaanKasRecord = new JurnalPenerimaanKasRecord();
		$JurnalPenerimaanKasRecord->id_transaksi = $id_transaksi;
		$JurnalPenerimaanKasRecord->no_transaksi = $no_transaksi;
		$JurnalPenerimaanKasRecord->jns_transaksi = $jns_transaksi;
		$JurnalPenerimaanKasRecord->tgl_transaksi = $tgl_transaksi;
		$JurnalPenerimaanKasRecord->wkt_transaksi = $wkt_transaksi;
		$JurnalPenerimaanKasRecord->keterangan = $keterangan;
		$JurnalPenerimaanKasRecord->nama_akun = $nama_akun;
		$JurnalPenerimaanKasRecord->ref = $ref;
		$JurnalPenerimaanKasRecord->jumlah = $jumlah;
		$JurnalPenerimaanKasRecord->potongan = $potongan;
		$JurnalPenerimaanKasRecord->deleted = '0';
		$JurnalPenerimaanKasRecord->save();
	}
	
	public function UbahSaldoKas($jnsTrans,$idBank,$saldo)
	{
		$BankRecord = BankRecord::finder()->findByPk($idBank);
		if($BankRecord)
		{
			if($jnsTrans == '0')
				$BankRecord->saldo += $saldo;
			else
				$BankRecord->saldo -= $saldo;
				
			$BankRecord->save();
		}
	}
	
	public function InsertJurnalBukuBesar($idTrans,$sumberTrans,$jnsTrans,$noTrans,$tglTrans,$wktTrans,$idCoa,$idBank,$namaAkun,$keterangan,$saldo)
	{
		/*
		 * $sumberTrans = 0 -> Setor Saldo Awal
		 * $sumberTrans = 1 -> Bayar PO/Bayar DP PO
		 */
		 
		$sql = "SELECT
					*
				FROM
					tbt_jurnal_buku_besar
				WHERE
					tbt_jurnal_buku_besar.nama_akun = '$namaAkun'
				ORDER BY
					tbt_jurnal_buku_besar.id DESC
				LIMIT 1 ";
				
		$arrSaldo = $this->queryAction($sql,'S');
		
		if(count($arrSaldo) > 0)
		{
			if(($namaAkun == 'Beban Gaji' || $namaAkun == 'Beban Lain-lain' || $namaAkun == 'Beban Perlengkapan') && $arrSaldo[0]['status'] != '0')
			{
				$saldoAkhir = 0;
				$posisiSaldoAkhir = '0';
			}
			elseif(($namaAkun == 'Pendapatan' || $namaAkun == 'Pendapatan Lain-lain') && $arrSaldo[0]['status'] != '0')
			{
				$saldoAkhir = 0;
				$posisiSaldoAkhir = '1';
			}
			else
			{
				$saldoAkhir = $arrSaldo[0]['saldo_akhir'];
				$posisiSaldoAkhir = $arrSaldo[0]['posisi_saldo_akhir'];
			}
		}
		else
		{
			$saldoAkhir = 0;
			if($namaAkun=='Kas' || $namaAkun=='Kas Bank' || $namaAkun=='Piutang' || $namaAkun=='Perlengkapan' || $namaAkun == 'Persediaan Bahan Baku' || $namaAkun == 'Persediaan Barang Dagangan' || $namaAkun == 'Beban Gaji' || $namaAkun == 'Beban Lain-lain' || $namaAkun == 'Beban Perlengkapan')
				$posisiSaldoAkhir = '0';
			elseif($namaAkun == 'Modal' || $namaAkun == 'Hutang' || $namaAkun == 'Hutang Gaji' || $namaAkun == 'Pendapatan' || $namaAkun == 'Pendapatan Lain-lain')
				$posisiSaldoAkhir = '1';
		}
		
		if($namaAkun=='Kas' || $namaAkun=='Kas Bank' || $namaAkun=='Perlengkapan' || $namaAkun=='Piutang' || $namaAkun == 'Persediaan Bahan Baku' || $namaAkun == 'Persediaan Barang Dagangan' || $namaAkun == 'Beban Gaji' || $namaAkun == 'Beban Lain-lain' || $namaAkun == 'Beban Perlengkapan')
		{
			if($jnsTrans == '0')
			{
				if($posisiSaldoAkhir == '0')
				{
					$saldoAkhir += $saldo;
				}
				else
				{
					if($saldo > $saldoAkhir)
					{
						//$saldoAkhir = $saldo - $saldoAkhir;
						$saldoAkhir = 0;
						$posisiSaldoAkhir = '0';
					}
					else
					{
						$saldoAkhir -= $saldo;
					}
				}
			}
			elseif($jnsTrans == '1')
			{
				if($posisiSaldoAkhir == '0')
				{
					if($saldo > $saldoAkhir)
					{
						//$saldoAkhir = $saldo - $saldoAkhir;
						$saldoAkhir = 0;
						$posisiSaldoAkhir  = '1';
					}
					else
					{
						$saldoAkhir -= $saldo;
					}
				}
				else
				{
						$saldoAkhir += $saldo;
				}
			}
		}
		elseif($namaAkun == 'Modal' || $namaAkun == 'Hutang' || $namaAkun == 'Hutang Gaji' || $namaAkun == 'Pendapatan' || $namaAkun == 'Pendapatan Lain-lain')
		{
			if($jnsTrans == '0')
			{
				if($posisiSaldoAkhir == '1')
				{
					$saldoAkhir += $saldo;
				}
				else
				{
					if($saldo > $saldoAkhir)
					{
						//$saldoAkhir = $saldo - $saldoAkhir;
						$saldoAkhir = 0;
						$posisiSaldoAkhir = '1';
					}
					else
					{
						$saldoAkhir -= $saldo;
					}
				}
			}
			elseif($jnsTrans == '1')
			{
				if($posisiSaldoAkhir == '1')
				{
					if($saldo > $saldoAkhir)
					{
						//$saldoAkhir = $saldo - $saldoAkhir;
						$saldoAkhir = 0;
						$posisiSaldoAkhir  = '0';
					}
					else
					{
						$saldoAkhir -= $saldo;
					}
				}
				else
				{
						$saldoAkhir += $saldo;
				}
			}
		}	
		
		$JurnalBukuBesarRecord = new JurnalBukuBesarRecord();
		$JurnalBukuBesarRecord->id_transaksi = $idTrans;
		$JurnalBukuBesarRecord->sumber_transaksi = $sumberTrans;
		$JurnalBukuBesarRecord->jns_transaksi = $jnsTrans;
		$JurnalBukuBesarRecord->no_transaksi = $noTrans;
		$JurnalBukuBesarRecord->id_coa = $idCoa;
		$JurnalBukuBesarRecord->tgl_transaksi = $tglTrans;
		$JurnalBukuBesarRecord->wkt_transaksi = $wktTrans;
		$JurnalBukuBesarRecord->nama_akun = $namaAkun;
		$JurnalBukuBesarRecord->keterangan = $keterangan;
		$JurnalBukuBesarRecord->id_bank = $idBank;
		$JurnalBukuBesarRecord->saldo = $saldo;
		$JurnalBukuBesarRecord->saldo_akhir = $saldoAkhir;
		$JurnalBukuBesarRecord->posisi_saldo_akhir = $posisiSaldoAkhir;
		
		$JurnalBukuBesarRecord->save();
		
	}
	
	public function profilPerusahaan()
	{
		$PerusahaanRecord = PerusahaanRecord::finder()->findByPk('1');
		return $PerusahaanRecord;
	}
}
?>
