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

require_once (WCF_DIR . 'lib/system/WCFACP.class.php');

class CPACP extends WCFACP
{

	protected function getOptionsFilename()
	{
		return CP_DIR . 'options.inc.php';
	}

	/**
	 * Initialises the template engine.
	 */
	protected function initTPL()
	{
		global $packageDirs;
		
		self :: $tplObj = new ACPTemplate(self :: getLanguage()->getLanguageID(), ArrayUtil :: appendSuffix($packageDirs, 'acp/templates/'));
		$this->assignDefaultTemplateVariables();
	}

	/**
	 * Does the user authentication.
	 */
	protected function initAuth()
	{
		parent :: initAuth();
		
		// user ban
		if (self :: getUser()->banned)
		{
			throw new PermissionDeniedException();
		}
	}

	/**
	 * @see WCF::assignDefaultTemplateVariables()
	 */
	protected function assignDefaultTemplateVariables()
	{
		parent :: assignDefaultTemplateVariables();
		
		self :: getTPL()->assign(array (
			// add jump to board link 			
			'additionalHeaderButtons' => '<li><a href="' . RELATIVE_CP_DIR . 'index.php?page=Index"><img src="' . RELATIVE_CP_DIR . 'icon/cpS.png" alt="" /> <span>' . WCF :: getLanguage()->get('cp.acp.jumpToCP') . '</span></a></li>', 
			// individual page title
			'pageTitle' => WCF :: getLanguage()->get(StringUtil :: encodeHTML(PAGE_TITLE)) . ' - ' . StringUtil :: encodeHTML(PACKAGE_NAME . ' ' . PACKAGE_VERSION)
		));
	}
}
?>