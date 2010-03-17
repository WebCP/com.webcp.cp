<?php
/*
 * Copyright (c) 2009 Tobias Friebel
 * Authors: Tobias Friebel <TobyF@Web.de>
 *
 * Lizenz: GPL
 *
 * $Id$
 */

require_once (WCF_DIR . 'lib/acp/page/UserSuggestPage.class.php');

class CustomerSuggestPage extends UserSuggestPage
{
	/**
	 * @see Page::show()
	 */
	public function show()
	{
		AbstractPage :: show();
		
		header('Content-type: text/xml');
		echo "<?xml version=\"1.0\" encoding=\"" . CHARSET . "\"?>\n<suggestions>\n";
		
		if (!empty($this->query)) 
		{
			// get users
			$sql = "SELECT		username
					FROM		wcf" . WCF_N . "_user
					JOIN		cp" . CP_N . "_user USING (userID) 
					WHERE		username LIKE '".escapeString($this->query)."%'
								AND isCustomer = 1
					ORDER BY	username";
			$result = WCF::getDB()->sendQuery($sql, 10);
			while ($row = WCF::getDB()->fetchArray($result))
			{
				echo "<user><![CDATA[".StringUtil::escapeCDATA($row['username'])."]]></user>\n";
			}
		}
		echo '</suggestions>';
		exit();
	}
}
?>