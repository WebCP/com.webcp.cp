<?php
/*
 * Copyright (c) 2009 Tobias Friebel
 * Authors: Tobias Friebel <TobyF@Web.de>
 *
 * Lizenz: GPL
 *
 * $Id$
 */

require_once (CP_DIR . 'lib/system/session/CPSession.class.php');
require_once (CP_DIR . 'lib/system/session/CPUserSession.class.php');

// wcf imports
require_once (WCF_DIR . 'lib/system/session/CookieSessionFactory.class.php');

class CPSessionFactory extends CookieSessionFactory
{
	protected $userClassName = 'CPUserSession';
	protected $sessionClassName = 'CPSession';

	/**
	 * @see SessionFactory::create()
	 */
	public function create($foreignUserID = 0)
	{
		// create new session hash
		$sessionID = StringUtil :: getRandomID();

		$foreign = false;

		if ($foreignUserID != 0)
		{
			$user = new CPUserSession($foreignUserID);
			$foreign = true;
		}
		else
		{
			// check cookies for userID & password
			require_once (WCF_DIR . 'lib/system/auth/UserAuth.class.php');
			$user = UserAuth :: getInstance()->loginAutomatically(true, $this->userClassName);
		}

		if ($user === null)
		{
			// no valid user found
			// create guest user
			$user = new $this->guestClassName();
		}

		// update user session
		$user->update();

		// get spider information
		$spider = $this->isSpider(UserUtil :: getUserAgent());

		if ($user->userID != 0)
		{
			// user is no guest
			// delete all other sessions of this user
			Session::deleteSessions($user->userID, true, false);
		}
		$requestMethod = (!empty($_SERVER['REQUEST_METHOD']) ? $_SERVER['REQUEST_METHOD'] : '');

		// insert session into database
		$sql = "INSERT INTO 	wcf".WCF_N."_session
					(sessionID, packageID, userID, ipAddress, userAgent,
					lastActivityTime, requestURI, requestMethod,
					username".($spider ? ", spiderID" : "").")
			VALUES		('".$sessionID."',
					".PACKAGE_ID.",
					".$user->userID.",
					'".escapeString(UserUtil::getIpAddress())."',
					'".escapeString(UserUtil::getUserAgent())."',
					".TIME_NOW.",
					'".escapeString(UserUtil::getRequestURI())."',
					'".escapeString($requestMethod)."',
					'".($spider ? escapeString($spider['spiderName']) : escapeString($user->username))."'
					".($spider ? ", ".$spider['spiderID'] : "").")";
		WCF::getDB()->sendQuery($sql);
		
		// save user data
		$serializedUserData = '';
		if (ENABLE_SESSION_DATA_CACHE && get_class(WCF::getCache()->getCacheSource()) == 'MemcacheCacheSource') {
			require_once(WCF_DIR.'lib/system/cache/source/MemcacheAdapter.class.php');
			MemcacheAdapter::getInstance()->getMemcache()->set('session_userdata_-'.$sessionID, $user);
		}
		else {
			$serializedUserData = serialize($user);
			try {
				$sql = "INSERT INTO 	wcf".WCF_N."_session_data
							(sessionID, userData)
					VALUES 		('".$sessionID."',
							'".escapeString($serializedUserData)."')";
				WCF::getDB()->sendQuery($sql);
			}
			catch (DatabaseException $e) {
				// horizon update workaround
				$sql = "UPDATE 	wcf".WCF_N."_session
					SET	userData = '".escapeString($serializedUserData)."'
					WHERE	sessionID = '".$sessionID."'";
				WCF::getDB()->sendQuery($sql);
			}
		}

		// return new session object
		return new $this->sessionClassName(null, array (
			'sessionID' => $sessionID,
			'packageID' => PACKAGE_ID,
			'userID' => $user->userID,
			'ipAddress' => UserUtil :: getIpAddress(),
			'userAgent' => UserUtil :: getUserAgent(),
			'lastActivityTime' => TIME_NOW,
			'requestURI' => UserUtil :: getRequestURI(),
			'requestMethod' => $requestMethod,
			'userData' => $serializedUserData,
			'sessionVariables' => '',
			'username' => ($spider ? $spider['spiderName'] : $user->username),
			'spiderID' => ($spider ? $spider['spiderID'] : 0),
			'isNew' => true,
			'foreign' => $foreign
		));
	}
}
?>