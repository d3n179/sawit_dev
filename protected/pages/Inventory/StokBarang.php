<?PHP
class StokBarang extends MainConf
{

	public function onPreRenderComplete($param)
	{
		parent::onPreRenderComplete($param);
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			
		}
		
	}
	
	public function onPreRender($param)
	{
		parent::onPreRender($param);
		
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$tblBody = $this->BindGrid();
			$this->getPage()->getClientScript()->registerEndScript
						('','jQuery("#table-1 tbody").append("'.$tblBody.'");');	
		}
	}
	
	
	public function BindGrid()
	{
		$sql = "SELECT 
					tbm_barang.id,
					tbm_barang.nama,
					tbm_barang.kelompok_id,
					tbm_barang.kategori_id,
					tbm_kategori_barang.nama AS kategori,
					tbm_barang.min_stock,
					tbm_barang.max_stock,
					tbm_barang.max_beli_bulanan
				FROM 
					tbm_barang
				INNER JOIN tbm_kategori_barang ON tbm_kategori_barang.id = tbm_barang.kategori_id
				WHERE 
					tbm_barang.deleted = '0' 
					AND tbm_barang.kategori_id != '5'
					AND tbm_barang.id = '84'
				ORDER BY 
					tbm_barang.id ASC ";
		$BarangRecord = $this->queryAction($sql,'S');
		
		$count = count($BarangRecord);
		$tblBody = '';
		if($count > 0)
		{
			
			foreach($BarangRecord as $row)
			{
				$stokList ='';
				$sqlStock = "SELECT
								SUM(tbd_stok_barang.stok) AS stok
							FROM
								tbd_stok_barang
							WHERE
								tbd_stok_barang.deleted = '0'
							AND tbd_stok_barang.id_barang = '".$row['id']."'
							GROUP BY
								tbd_stok_barang.id_barang ";
				$arrStock = $this->queryAction($sqlStock,'S');
				
				if($arrStock)
					$stok = $arrStock[0]['stok'];
				else
					$stok = 0;
				
				$realQty = $this->getTargetUom($row['id'],$stok); 
				$stokList = '';
				foreach($realQty as $rowQty)
				{
					$stokList .= $rowQty['qty']." ".$rowQty['name']."<br>";
				}
				$idMaxSatuan = BarangSatuanRecord::finder()->find('urutan = ? AND id_barang = ? AND deleted = ?','1',$row['id'],'0')->id_satuan;
				$MaxSatuanName = SatuanRecord::finder()->findByPk($idMaxSatuan)->nama;
				
				if($row['kelompok_id'] == '0')
					$kelompokBarang = "Assets";
				else
					$kelompokBarang = "Barang Lancar";
					
				$tblBody .= '<tr>';
				$tblBody .= '<td>'.mysql_escape_string($row['nama']).'</td>';
				$tblBody .= '<td>'.$kelompokBarang.'</td>';
				$tblBody .= '<td>'.$row['kategori'].'</td>';
				$tblBody .= '<td>'.$stokList.'</td>';
				//$tblBody .= '<td>';
				/*if($row['kategori_id'] != '5')
				{
					$tblBody .= '<a href=\"#\" class=\"btn btn-default btn-sm btn-icon icon-left\" OnClick=\"editClicked('.$row['id'].')\"><i class=\"entypo-pencil\" ></i>Edit</a>&nbsp;&nbsp;';
					$tblBody .= '<a href=\"#\" class=\"btn btn-danger btn-sm btn-icon icon-left\" OnClick=\"deleteClicked('.$row['id'].')\"><i class=\"entypo-cancel\"></i>Hapus</a>&nbsp;&nbsp;';	
				}	*/	
				
				//$tblBody .=	'</td>';			
				$tblBody .= '</tr>';
			}
		}
		else
		{
			$tblBody = '';
		}
		return 	$tblBody;
	}
	
	
	
}
?>
