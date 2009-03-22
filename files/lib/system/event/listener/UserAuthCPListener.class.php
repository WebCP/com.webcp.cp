<?php

require_once(WCF_DIR.'lib/system/event/EventListener.class.php');
require_once(CP_DIR.'lib/system/auth/UserAuthCP.class.php');

class UserAuthCPListener implements EventListener
{
	/**
	 * @see EventListener::execute()
	 */
	public function execute($eventObj, $className, $eventName)
	{
		UserAuthCP :: getInstance();
	}
}
?>