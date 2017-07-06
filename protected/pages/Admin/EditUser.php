<?PHP
class EditUser extends MainConf
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
		}
	}
	
	public function onLoadComplete($param)
	{
		parent::onLoadComplete($param);
		
		if(!$this->Page->IsPostBack && !$this->Page->IsCallBack)  
		{
			$this->username->Text = strtolower($this->User->IsUser);
			$this->nama->Text = strtolower($this->User->IsUserName);
		}
	}
	
	public function updateUserClicked()
	{
		$username = $this->username->Text;
		$nama = $this->nama->Text;
		$password_lama = md5($this->password_lama->Text);
		$password_baru = md5($this->password_baru->Text);
		$ketik_ulang = md5($this->ketik_ulang->Text);
		
		if($password_baru == $ketik_ulang)
		{
			$UserRecord = UserRecord::finder()->find('username = ? AND password = ? ',$username,$password_lama);
			if($UserRecord)
			{
				$UserRecord->password = $password_baru;
				$UserRecord->nama = $nama;
				$UserRecord->save();
				
				$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					toastr.info("Password User Berhasil Diubah !");
					');	
					
			}
			else
			{
				$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					toastr.error("Password Salah !");
					');	
			}
		}
		else
		{
			$this->getPage()->getClientScript()->registerEndScript
					('','
					unloadContent();
					toastr.error("Password Tidak Sama !");
					');	
		}
		
		
	}
	
}
?>
