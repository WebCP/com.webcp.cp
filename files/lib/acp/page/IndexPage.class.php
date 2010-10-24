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

require_once(WCF_DIR.'lib/page/AbstractPage.class.php');
require_once(WCF_DIR.'lib/data/feed/FeedReaderSource.class.php');
require_once(WCF_DIR.'lib/acp/package/PackageInstallationQueue.class.php');

class IndexPage extends AbstractPage
{
	public $templateName= 'index';
	public $news = array();
	public $updates = array();

	/**
	 * @see Page::readData()
	 */
	public function readData() {
		parent::readData();

		// updates
		if (WCF::getUser()->getPermission('admin.system.package.canUpdatePackage')) {
			require_once(WCF_DIR.'lib/acp/package/update/PackageUpdate.class.php');
			$this->updates = PackageUpdate::getAvailableUpdates();
		}
				
		// news
		$this->news = FeedReaderSource::getEntries(5);
		foreach ($this->news as $key => $news) {
			$this->news[$key]['description'] = preg_replace('/href="(.*?)"/e', '\'href="'.RELATIVE_WCF_DIR.'acp/dereferrer.php?url=\'.rawurlencode(\'$2\').\'" class="externalURL"\'', $news['description']);
		}
	}
	
	/**
	 * @see Page::assignVariables()
	 */
	public function assignVariables() {
		parent::assignVariables();
		
		WCF::getTPL()->assign(array(
			'updates' => $this->updates,
			'news' => $this->news
		));
	}
}
?>
