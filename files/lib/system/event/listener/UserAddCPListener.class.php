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
		if ($eventName == 'readParameters')
		{
			if (empty($eventObj->username))
			{
				$sql = "SELECT 	username AS name
						FROM 	wcf" . WCF_N . "_user
						ORDER BY SUBSTRING_INDEX(username, '" . USER_POSTFIX . "', -1) + 0 DESC
						LIMIT 1";
				$postFix = WCF :: getDB()->getFirstRow($sql);
	
				if (empty($postFix))
				{
					$eventObj->username = USER_POSTFIX . '1';
				}
				else
				{
					$postFix = intval(str_replace(USER_POSTFIX, '', $postFix['name']));
					$eventObj->username = USER_POSTFIX . ++$postFix;
				}	
			}
		}
		elseif ($eventName == 'validate')
		{
			if (!preg_match('/^[a-z0-9\-_]+$/i', $eventObj->username))
			{
				$eventObj->errorType['username'] = 'notValid';
			}
		}
		elseif ($eventName == 'saved')
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
			
			if ($eventObj->user->isCustomer == 1)
				JobhandlerUtils :: addJob('createhome', array('userID' => $eventObj->user->userID));
		}
	}
}
?>