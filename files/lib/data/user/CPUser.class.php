<?php
// wcf imports
require_once (WCF_DIR . 'lib/data/user/User.class.php');

class CPUser extends User
{
	/**
	 * @see UserProfile::__construct()
	 */
	public function __construct($userID = null, $row = null, $username = null, $email = null)
	{
		$this->sqlSelects .= 'cp_user.*,';
		$this->sqlJoins .= ' LEFT JOIN cp' . CP_N . '_user cp_user ON (cp_user.userID = user.userID) ';
		parent :: __construct($userID, $row, $username, $email);
	}
}

?>