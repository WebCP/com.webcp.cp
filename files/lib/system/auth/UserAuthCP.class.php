<?php

// imports
if (!defined('NO_IMPORTS'))
{
	require_once (WCF_DIR . 'lib/system/auth/UserAuthDefault.class.php');
	require_once (WCF_DIR . 'lib/system/event/EventHandler.class.php');
}

class UserAuthCP extends UserAuthDefault
{
	/**
	 * Returns an instance of the enabled user auth class.
	 *
	 * @return	UserAuth
	 */
	public static function getInstance()
	{
		if (self :: $instance === null)
		{
			self :: $instance = new UserAuthCP();
		}
		return self :: $instance;
	}

	/**
	 * @see UserAuth::supportsPersistentLogins()
	 */
	public function supportsPersistentLogins()
	{
		return false;
	}

	/**
	 * @see UserAuth::loginManually()
	 */
	public function loginManually($username, $password, $userClassname = 'CPUserSession')
	{
		$user = parent :: loginManually($username, $password, $userClassname);

		if ($user->isCustomer == 0)
			throw new UserInputException('username', 'notFound');

		return $user;
	}
}

?>