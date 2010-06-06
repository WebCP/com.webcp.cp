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

require_once (WCF_DIR . 'lib/page/AbstractPage.class.php');

class IndexPage extends AbstractPage
{
	public $templateName = 'index';
	
	protected $displayData = array ();

	/**
	 * @see Page::assignVariables()
	 */
	public function assignVariables()
	{
		parent :: assignVariables();
		
		WCF :: getTPL()->assign('displayData', $this->displayData);
	}

	/**
	 * add something to indexdisplay
	 *
	 * @param string $lang
	 * @param string $var
	 */
	public function addDisplay($lang, $var)
	{
		if (!array_key_exists($lang, $this->displayData))
			$this->displayData[$lang] = $var;
	}
}
?>