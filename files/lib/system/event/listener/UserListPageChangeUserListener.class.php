<?php
// wcf imports
require_once(WCF_DIR.'lib/system/event/EventListener.class.php');

class UserListPageChangeUserListener implements EventListener
{
	/**
	 * @see EventListener::execute()
	 */
	public function execute($eventObj, $className, $eventName)
	{
		if (!WCF::getUser()->getPermission('admin.user.canBecomeUser'))
			return;

		$url = rawurlencode($eventObj->url);
		$additionalButtons = array();

		foreach ($eventObj->users as $user)
		{
			if ($user->accessible)
			{
				$additionalButtons[$user->userID] = ' <a href="index.php?action=UserBecome&amp;userID='.$user->userID.'&amp;url='.$url.'&amp;packageID='.PACKAGE_ID.SID_ARG_2ND.'"><img src="'.RELATIVE_WCF_DIR.'icon/loginS.png" alt="" title="'.WCF::getLanguage()->get('cp.acp.user.button.become').'" /></a>';
			}
		}

		WCF::getTPL()->append('additionalButtons', $additionalButtons);
	}
}
?>