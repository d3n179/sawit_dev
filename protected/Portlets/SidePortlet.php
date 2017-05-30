<?php
Prado::using('Application.Portlets.Portlet');
class SidePortlet extends Portlet
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
			$page = $this->Request['page'];	
			$MenuRecord = MenuRecord::finder()->find('link = ? AND aktif = ? AND deleted = ?',$page,'1','0');
			$this->userRealName->Text = $this->User->IsRealName;
			$parentId = $MenuRecord->parent_id;
			$menuId = $MenuRecord->id;
			$UserMenu = $this->User->UserMenu;
			$sql = "SELECT
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
						AND tbm_menu.aktif = '1'
					ORDER BY
						tbm_menu.urutan ASC ";
						
			$arrChild = MainConf::queryAction($sql,'S');	
			$SideMenuList = $this->buildMenu($UserMenu,'0');
			/*if($arrParent)
			{
				foreach($arrParent as $rowParent)
				{
					$idparent = $rowParent['parent_id'];
					
					if($idparent == $parentId)
						$classParent = 'class="opened active"';
					else
						$classParent = '';
					
					$modul = MenuRecord::finder()->findByPk($rowParent['parent_id']);	
					$SideMenuList .= '<li '.$classParent.'>
										<a href="#">
											<i class="'.$modul->icon.'"></i>
											<span class="title">'.$modul->nama.'</span>
										</a>';
										
					/*$sqlChild = "SELECT 
										tbm_menu.id,
										tbm_menu.nama,
										tbm_menu.link
									FROM 
										tbm_menu 
									WHERE
										tbm_menu.parent_id = '$idparent'
										AND tbm_menu.deleted = '0'
										AND tbm_menu.aktif ='1' ";*/
				
					//$arrChild = $UserMenu['menu'];//MainConf::queryAction($sqlChild,'S');	
					/*usort($arrChild, function($a, $b) {
						return $a['urutan'] - $b['urutan'];
					});*/
					/*if($arrChild)
					{	$SideMenuList .= '<ul>';
						foreach($arrChild as $rowChild)
						{				
							$idChild = $rowChild['id'];
							if($rowChild['parent_id'] == $idparent)
							{
								if($idChild == $menuId)
									$classChild = 'class="active"';
								else
									$classChild = '';
								$SideMenuList .= '	<li '.$classChild.'>
															<a href="index.php?page='.$rowChild['link'].'">
																<span class="title">'.$rowChild['nama'].'</span>
															</a>
														</li>';
							}
						}
						$SideMenuList .= '</ul>';
					}
					$SideMenuList .= '</li>';
				}
				
			}*/ 
			$this->SideMenuLiteral->text = $SideMenuList;
		}
		
		if($this->Page->IsCallBack)    
		{	
			
		}
	}
	
	public function buildMenu($arrMenu,$parentId = '0')
	{
		$SideMenuList = '';
		
		foreach($arrMenu as $row)
		{
			if($row['parent_id'] == $parentId)
			{
				$search =  $this->arr_search($arrMenu,'parent_id',$row['id']); //array_search($row['id'], array_column($arrMenu, 'parent_id'));	
				
				if($row['icon'] != '')
					$iClass = '<i class="'.$row['icon'].'"></i>';
				else
					$iClass = '';
					
				if($row['link'] != '')
				{
					$link = $row['link'];
				}
				else
				{
					$link = '#';
				}
				
						$SideMenuList .= '<li>
													<a href="index.php?page='.$link.'">
														'.$iClass.'
														<span class="title">'.$row['nama'].'</span>
													</a>';
							
							if(count($search) > 0)
							{
								$SideMenuList .= '<ul>';
								$SideMenuList .= $this->buildMenu($arrMenu,$row['id']);
									
								$SideMenuList .= '</ul>';
								
							}
							
							$SideMenuList .= '</li>';	
								
			}
		}
		
		return $SideMenuList;
	}
	
	public function arr_search($array,$filterField,$filterValue)
	{
		$arr = array();
		foreach($array as $row)
		{
			if($row[$filterField] == $filterValue)
				$arr[] = array('id'=>$row['id']);
		}
		
		return $arr;
	}
	public function logoutProses($sender,$param)
	{
		MainConf::prosesLogout();
	}
	
}

?>
