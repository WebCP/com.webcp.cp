<?php
/*
 * +-----------------------------------------+
 * | Copyright (c) 2009 Tobias Friebel		 |
 * +-----------------------------------------+
 * | Authors: Tobias Friebel <TobyF@Web.de>  |
 * +-----------------------------------------+
 *
 * Project: WCF Control Panel
 *
 * $Id$
 */

require_once(WCF_DIR . 'lib/page/AbstractPage.class.php');

class IndexPage extends AbstractPage
{
	public $templateName = 'index';

	public function __construct()
	{
		if (!WCF :: getUser()->userID)
		{
			$this->templateName = 'login';
		}

		parent :: __construct();
	}
}
?>