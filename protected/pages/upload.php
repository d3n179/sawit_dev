<?php
class upload extends MainConf
{ 
	public function onPreInit ($param)
	{
		parent::onPreInit($param);
			
	}	
	
	public function onLoad($param)
	{
		parent::onLoad($param);
		
		if(!$this->IsPostBack && !$this->IsCallBack)  
		{
			if (!empty($_FILES))
			{		
				$fileTypes = array('jpg','jpeg','gif','png','JPG'); // File extensions
				
				$tempFile = $_FILES['file']['tmp_name'];
				$error = $_FILES["file"]["error"];
				$idDoc = $this->Request["idDoc"];
				$fileName = sha1(ReceivingOrderRecord::finder()->findByPk($idDoc)->no_document);//$this->Request["filename"];
				
				$targetPath = $_SERVER['DOCUMENT_ROOT'].dirname($_SERVER['REQUEST_URI'])."/gallery/ReceivingOrder/";
				
				$fileParts = pathinfo($_FILES['file']['name']);
				$extension = $fileParts['extension'];
				if(in_array($fileParts['extension'],$fileTypes))
				{
					if(move_uploaded_file($_FILES["file"]["tmp_name"],$targetPath.$fileName))
					{
						$return_arr[] = array("uploaded" =>"1",
								"msg" => "File Berhasil Diupload",
								"uploadLocation" => $targetPath,
								"filename" => $fileName,
								"extensions" => $extension);
					}
					else
					{
						$return_arr[] = array("uploaded" =>"0",
								"msg" => "File Gagal Diupload",
								"uploadLocation" => $targetPath,
								"filename" => $fileName,
								"extensions" => "");
					}
					
				} 
				else
				{
					$return_arr[] = array("uploaded" =>"0",
								"msg" => "Jenis File Tidak Sesuai",
								"uploadLocation" => $targetPath,
								"filename" => $fileName,
								"extensions" => "");
				}
			}
			else
			{
				$return_arr[] = array("uploaded" =>"0",
								"msg" => "File Kosong",
								"uploadLocation" => $targetPath,
								"filename" => $fileName,
								"extensions" => "");
			}
			
			echo json_encode($return_arr);
			exit();
		}
	}
	
	public function read_gps_location($img)
	{
		if (is_file($img)) {
			$info = exif_read_data($img);
			if (isset($info['GPSLatitude']) && isset($info['GPSLongitude']) &&
				isset($info['GPSLatitudeRef']) && isset($info['GPSLongitudeRef']) &&
				in_array($info['GPSLatitudeRef'], array('E','W','N','S')) && in_array($info['GPSLongitudeRef'], array('E','W','N','S'))) {

				$GPSLatitudeRef  = strtolower(trim($info['GPSLatitudeRef']));
				$GPSLongitudeRef = strtolower(trim($info['GPSLongitudeRef']));
				$DateTime = $info['DateTimeOriginal'];

				$lat_degrees_a = explode('/',$info['GPSLatitude'][0]);
				$lat_minutes_a = explode('/',$info['GPSLatitude'][1]);
				$lat_seconds_a = explode('/',$info['GPSLatitude'][2]);
				$lng_degrees_a = explode('/',$info['GPSLongitude'][0]);
				$lng_minutes_a = explode('/',$info['GPSLongitude'][1]);
				$lng_seconds_a = explode('/',$info['GPSLongitude'][2]);

				$lat_degrees = $lat_degrees_a[0] / $lat_degrees_a[1];
				$lat_minutes = $lat_minutes_a[0] / $lat_minutes_a[1];
				$lat_seconds = $lat_seconds_a[0] / $lat_seconds_a[1];
				$lng_degrees = $lng_degrees_a[0] / $lng_degrees_a[1];
				$lng_minutes = $lng_minutes_a[0] / $lng_minutes_a[1];
				$lng_seconds = $lng_seconds_a[0] / $lng_seconds_a[1];

				$lat = (float) $lat_degrees+((($lat_minutes*60)+($lat_seconds))/3600);
				$lng = (float) $lng_degrees+((($lng_minutes*60)+($lng_seconds))/3600);

				//If the latitude is South, make it negative. 
				//If the longitude is west, make it negative
				$GPSLatitudeRef  == 's' ? $lat *= -1 : '';
				$GPSLongitudeRef == 'w' ? $lng *= -1 : '';

				return array(
					'lat' => $lat,
					'lng' => $lng,
					'DateTime' => $DateTime 
				);
			}           
		}
		return false;
	}
			
}
?>
