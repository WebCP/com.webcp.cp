<?php
// wcf imports
require_once (WCF_DIR . 'lib/data/user/UserProfile.class.php');

class CPUser extends UserProfile
{
	/**
	 * @see UserProfile::__construct()
	 */
	public function __construct($userID = null, $row = null, $username = null, $email = null)
	{
		$this->sqlJoins .= ' LEFT JOIN cp' . CP_N . '_user cp_user ON (cp_user.userID = user.userID) ';
		parent :: __construct($userID, $row, $username, $email);
	}
}

?>