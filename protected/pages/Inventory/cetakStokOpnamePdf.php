<?PHP
class cetakStokOpnamePdf extends MainConf
{
	public function onPreInit($param)
	{
		parent::onPreInit($param);	
		$this->getResponse()->setContentType("application/pdf");
	}
	public function onLoad($param)
	{	
		$profilPerusahaan = $this->profilPerusahaan();	
			
		$pdf=new reportKwitansi('P','mm','legal');
		$pdf->AliasNbPages(); 
		$pdf->AddPage();
		
		$pdf->Image('protected/pages/Laporan/logo-01.png',5,8,25);	
		$pdf->SetFont('Arial','B',12);
		$pdf->Cell(10,10,'','0',0,'C');
		$pdf->Cell(0,10,strtoupper($profilPerusahaan->nama),'0',0,'C');
		
		
		$pdf->Ln(8);			
		$pdf->SetFont('Arial','',9);
		$pdf->Cell(10,10,'','0',0,'C');
		$pdf->Cell(0,10,$profilPerusahaan->alamat,'0',0,'C');	
		$pdf->Ln(4);
		$pdf->Cell(0,10,'           '.$profilPerusahaan->telepon,'0',0,'C');	
		$pdf->Ln(3);
		$pdf->Cell(0,5,'','B',1,'C');
		$pdf->Ln(3);		
		$pdf->SetFont('Arial','BU',10);
		
		$id = $this->Request['id'];
		$StockOpnameRecord = StockOpnameRecord::finder()->findByPk($id);
		$tglStok = $this->ConvertDate($StockOpnameRecord->tgl_stock_opname,'3');
		$pdf->SetFont('Arial','B',10);
		$pdf->Cell(0,5,'STOCK OPNAME','0',0,'C');
		$pdf->Ln(5);
		$pdf->Cell(0,5,'TANGGAL : '.$tglStok,'0',0,'C');
		$pdf->Ln(5);
		$pdf->SetAligns(array('C','C','C','C','C','C'));
		$pdf->SetWidths(array(30,30,50,30,30,25));
		$pdf->Row(array('Nama Barang','Satuan','Stok Awal','Stok Akhir','Perbedaan','Status'));
		//$pdf->Ln(1);
		$pdf->SetFont('Arial','',8);
		$pdf->SetAligns(array('L','L','R','R','R','L'));
		$sql = "SELECT
					tbt_stock_opname_detail.id,
					tbt_stock_opname_detail.id_barang,
					tbt_stock_opname_detail.id_satuan,
					tbm_barang.nama AS nama_barang,
					tbm_satuan.nama AS nama_satuan,
					tbt_stock_opname_detail.stok_awal,
					tbt_stock_opname_detail.stok_akhir,
					tbt_stock_opname_detail.perbedaan,
					tbt_stock_opname_detail.`status`
				FROM
					tbt_stock_opname_detail
				INNER JOIN tbm_barang ON tbm_barang.id = tbt_stock_opname_detail.id_barang
				INNER JOIN tbm_satuan ON tbm_satuan.id = tbt_stock_opname_detail.id_satuan
				WHERE
					tbt_stock_opname_detail.id_stock_opname = '$id'
				AND tbt_stock_opname_detail.deleted = '0'";
		$arrData=$this->queryAction($sql,'S');
		$i = 1;
		$idPo = '';
		foreach($arrData as $row)
		{	
			if($row['status'] == '1')
				$status = 'Surplus';
			elseif($row['status'] == '2')
				$status = 'Deficit';
			elseif($row['status'] == '3')
				$status = 'Equal';
			else
				$status = '';
				
			$pdf->Row(array($row['nama_barang'],
							$row['nama_satuan'],
							$row['stok_awal'],
							$row['stok_akhir'],
							$row['perbedaan'],
							$status));
			$i++;
		}
		
		$pdf->Output();	
	}
	
}
?>
