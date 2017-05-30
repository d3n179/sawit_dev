<?php include"conf/modulview.php"; ?>

<link rel="stylesheet" type="text/css" href="css/component.css" />
<script src="js/modernizr.custom.js"></script>

<div class='row-fluid'>
	<div class='span12'>
		<div class='box'>
			<div class='box-head'>
				<i class='icon-table'></i>
					<span>CETAK SLIP GAJI</span>
			</div>
			<div class='box-body box-body-nopadding'>
				<div class='main clearfix'>
					<div id="formProses">
						<form method='POST' id='prosesForm' enctype='multipart/form-data' action='#'>
									<table class='table table-nomargin'>
										<tr>
											<td>NIK</td>   
											<td> : <input type='text' name='nik' id='nik' style='width:200px;' ></td>
										</tr>
										<tr>
													<td>Bulan</td>   
													<td> : <select style='width:120px;' name='bulan' id='bulan'>
															<option value='01' >Januari</option>
															<option value='02' >Februari</option>
															<option value='03' >Maret</option>
															<option value='04' >April</option>
															<option value='05' >Mei</option>
															<option value='06' >Juni</option>
															<option value='07' >Juli</option>
															<option value='08' >Agustus</option>
															<option value='09' >September</option>
															<option value='10' >Oktober</option>
															<option value='11' >November</option>
															<option value='12' >Desember</option>
															</select></td>
										</tr>
										<tr>
													<td>Tahun</td>   
													<td> : <select style='width:120px;' name='tahun' id='tahun'>
															<?PHP
																$thn = date("Y");
																$i = 8;
																while($i > 0)
																{
																	echo "<option value='$thn'>$thn</option>";
																	$thn--;
																	$i--;
																} 
															?>
													</select></td>
												</tr>
									</table>
									<table>
										<tr>
											<td><input type='button' class='btn btn-primary' value='Proses' onClick='prosesForm()'></td>
											<td><a href='#' class='btn btn-primary' onClick='cetakClicked()'>Cetak</a>	</td>
										</tr>
									</table>
						</form>	
					</div>
							
					<div align='center' id="formData">
						
					</div>
				</div>
			</div>
		</div>
	</div>	
</div>
<script src="js/classie.js"></script>
<script src="js/modalEffects.js"></script>
<script type="text/javascript">
	
	jQuery( document ).ready(function() 
	{
	});
	
	function prosesForm()
	{
		var nik = $("#nik").val();
		var bulan = $("#bulan").val();
		var tahun = $("#tahun").val();
		jQuery.ajax({
					url: "modul/cetak/prosesCetakSlipGaji.php?nik="+nik+"&bulan="+bulan+"&tahun="+tahun,
					dataType: 'json',
					type: 'post',
					success: function(data) {
						if(data.st == '0')
						{
							alert(data.msg);
						}
						else
						{
							$('#formData').html(data.table);
						}
						 
					},
					error: function(data) {
						// console.log(data);      
					}
				});
	}
	
	function cetakClicked()
	{
		var idKaryawan = '';
		var nik = $("#nik").val();
		var bulan = $("#bulan").val();
		var tahun = $("#tahun").val();
		window.location.href = "modul/cetak/cetakExcel.php?id="+idKaryawan+"&bulan="+bulan+"&tahun="+tahun+"&nik="+nik;
	}
	
	
</script>
