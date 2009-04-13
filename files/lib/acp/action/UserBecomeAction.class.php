<?php
// wcf imports
require_once (WCF_DIR . 'lib/action/AbstractAction.class.php');
require_once (CP_DIR . 'lib/system/session/CPSessionFactory.class.php');

class UserBecomeAction extends AbstractAction
{
	public $userID = 0;
	public $url = '';

	/**
	 * @see Action::readParameters()
	 */
	public function readParameters()
	{
		parent::readParameters();

		if (isset($_REQUEST['userID'])) $this->userID = intval($_REQUEST['userID']);
		if (isset($_REQUEST['url'])) $this->url = $_REQUEST['url'];
	}

	/**
	 * @see Action::execute()
	 */
	public function execute()
	{
		parent :: execute();

		if (WCF :: getUser()->getPermission('admin.user.canBecomeUser') && $this->userID != 0)
		{
			$factory = new CPSessionFactory();
			$sessionObj = $factory->create($this->userID);

			$url = '../index.php?s=' . $sessionObj->sessionID;
			HeaderUtil::redirect($url);
			exit;
		}

		if (!empty($this->url) && (strpos($this->url, 'searchID=0') !== false || strpos($this->url, 'searchID=') === false))
			HeaderUtil::redirect($this->url);
		else
			HeaderUtil::redirect('index.php?form=UserList&packageID='.PACKAGE_ID.SID_ARG_2ND_NOT_ENCODED);
		exit;
	}
}
?>