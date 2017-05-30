<?php
Prado::using('System.Security.TDbUserManager');
//session_start();

class PageUser extends TDbUser
{
	public function createUser($username)
	{
		$username = strtoupper($username);
		$userRecord=UserRecord::finder()->find('username = ?',$username);
		
		if($userRecord instanceof UserRecord) // if found
		{
			$user=new PageUser($this->Manager);
			$user->Name=strtoupper($username);  // set username	
			
			//$ssid = session_id();
			
			$name = strtoupper($userRecord->nama);
			$realname = strtoupper($userRecord->nama);
			$group = $userRecord->group;
			//$idObrav = $userRecord->openbravo_id;
			//$roleObrav = $userRecord->openbravo_role;
			//$businessPartner = $userRecord->business_partner;
			
			$user->setState('statPosition',$statPosition);
			$user->setState('userName',$name);
			//$user->setState('userId',$userRecord->id);
			$user->setState('userGroup',$group);
			$user->setState('user',$username);
			$user->setState('time',time());
			
			$userRecord->wkt_log=date('G:i:s');
			$userRecord->tgl_log=date('Y-m-d');
			$userRecord->st_log='1';
			//$userRecord->ssid=$ssid;
			$userRecord->Save();
			
			$UserGroup = $userRecord->group;
			//collect menu
			$sql = "SELECT
						tbm_menu.id,
						tbm_menu.parent_id,
						tbm_menu.nama,
						tbm_menu.link,
						tbm_menu.icon,
						tbm_menu.deleted
					FROM
						tbm_menu
					INNER JOIN tbm_user_menu_group ON tbm_user_menu_group.menu_id = tbm_menu.id 
					AND tbm_user_menu_group.user_group_id = '$UserGroup' AND tbm_user_menu_group.st = '1'
					WHERE
						tbm_menu.deleted = '0'
						AND tbm_menu.aktif = '1'
					ORDER BY
						tbm_menu.urutan ASC ";
						
			$arrChild = MainConf::queryAction($sql,'S');	
			$ParentList = ''; 
			
			foreach($arrChild as $rowChild)
			{
				if($ParentList == '')
					$ParentList .= $rowChild['parent_id'];
				else
					$ParentList .= ','.$rowChild['parent_id'];
			}
			
			$sqlParent = "SELECT
						tbm_menu.id,
						tbm_menu.parent_id,
						tbm_menu.nama,
						tbm_menu.link,
						tbm_menu.icon,
						tbm_menu.deleted
					FROM
						tbm_menu
					WHERE
						tbm_menu.deleted = '0'
						AND tbm_menu.parent_id = '0'
						AND tbm_menu.id IN (".$ParentList.")
					ORDER BY
						tbm_menu.urutan ASC ";
			$arrParent = MainConf::queryAction($sqlParent,'S');	
			$arrMenu = array();
			foreach($arrParent as $rowParent)
			{
				$arrMenu[] = array("id"=>$rowParent['id'],
									"parent_id"=>$rowParent['parent_id'],
									"nama"=>$rowParent['nama'],
									"link"=>$rowParent['link'],
									"icon"=>$rowParent['icon'],
									"deleted"=>$rowParent['deleted']);
			}
			
			foreach($arrChild as $rowChild)
			{
				$arrMenu[] = array("id"=>$rowChild['id'],
									"parent_id"=>$rowChild['parent_id'],
									"nama"=>$rowChild['nama'],
									"link"=>$rowChild['link'],
									"icon"=>$rowChild['icon'],
									"deleted"=>$rowChild['deleted']);
			}
			
			$UserMenu = $arrMenu;
			$user->setState('UserMenu',$UserMenu);
			
			$user->IsGuest=false;  
			return $user;
		}
		else
			return null;
	}
	
	public function validateUser($username,$password)
	{
		//$passVal=base64_encode(sha1($password,true));
		$passVal = md5($password);
		//var_dump($passVal);
		return UserRecord::finder()->findBy_username_AND_password($username,$passVal)!==null;		
	}
	
	
	public function getIsUserName()
	{
		return $this->getState('userName');
	}
	
	public function getIsRealName()
	{
		return $this->getState('userName');
	}
	
	public function getIsIdUser()
	{
		return $this->getState('userId');
	}
	
	public function getIsUser()
	{
		return $this->getState('user');
	}
	
	public function getIsUserGroup()
	{
			return $this->getState('userGroup');
	}
	
	public function getIsAppAuth()
	{
		return $this->getState('AppAuth');
	}
	
	public function getIsAppRole()
	{
		return $this->getState('authorized');
	}
	
	public function getIsAdmin()
	{
		return $this->isInRole('admin');
	}
	
	public function getIsPegawai()
	{
		return $this->isInRole('pegawai');
	}
	
	public function getUserMenu()
	{
		return $this->getState('UserMenu');
	}
	
	public function getTime()
	{
		return $this->getState('time');
	}
	
	public function setTime()
	{
		return $this->getState('time');
	}
	
	public function setStLog()
	{
		return $this->getState('time');
	}
	
}
?>
