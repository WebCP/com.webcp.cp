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

require_once (WCF_DIR .'lib/system/WCFACP.class.php');

class CPACP extends WCFACP
{
	protected function getOptionsFilename()
	{
		return CP_DIR . 'options.inc.php';
	}
}
?>