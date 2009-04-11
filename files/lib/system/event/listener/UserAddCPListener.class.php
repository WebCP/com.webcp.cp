<?php
/*
 * Copyright (c) 2009 Tobias Friebel
 * Authors: Tobias Friebel <TobyF@Web.de>
 *
 * Lizenz: GPL
 *
 * $Id$
 */

require_once(WCF_DIR.'lib/system/event/EventListener.class.php');

class UserAddCPListener implements EventListener
{
	/**
	 * @see EventListener::execute()
	 */
	public function execute($eventObj, $className, $eventName)
	{
		if ($eventName == 'validate')
		{
			if (strpos($eventObj->username, ' ') !== false)
			{
				$eventObj->errorType['username'] = 'notValid';
			}
		}
		else
		{
			// create cp user record
			$sql = "INSERT IGNORE INTO	cp" . CP_N . "_user
							(userID,
							 cpLastActivityTime,
							 homedir,
							 guid
							)
					VALUES	(" . $eventObj->user->userID . ",
							 " . TIME_NOW . ",
							'" . CPUtils :: getHomeDir($eventObj->user->username) . "',
							 " . CPUtils :: getNewGUID() . ")";
			WCF :: getDB()->sendQuery($sql);
		}
	}
}
?>