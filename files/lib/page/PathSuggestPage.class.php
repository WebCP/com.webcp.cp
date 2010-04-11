<?php
/*
 * Copyright (c) 2009 Tobias Friebel
 * Authors: Tobias Friebel <TobyF@Web.de>
 *
 * Lizenz: GPL
 *
 * $Id$
 */

require_once (WCF_DIR . 'lib/page/AbstractPage.class.php');

class PathSuggestPage extends AbstractPage
{
	const DO_NOT_LOG = true;
	public $query = '';
	public $path = '';

	/**
	 * @see Page::readParameters()
	 */
	public function readParameters()
	{
		parent :: readParameters();

		$this->path = WCF :: getUser()->homeDir;
		
		if (isset($_REQUEST['showFullPath']))
		{
			if (WCF :: getUser()->checkPermission('admin.general.canUseAcp'))
				$this->path = HOMEDIR_PREFIX;
		}

		if (isset($_REQUEST['query']))
		{
			$this->query = StringUtil :: trim($_REQUEST['query']);
			if (CHARSET != 'UTF-8')
				$this->query = StringUtil :: convertEncoding('UTF-8', CHARSET, $this->query);

			$path = FileUtil :: getRealPath($this->path . '/' . $this->query);
			$this->path = dirname($path . '.');

			if (!isset($_REQUEST['showFullPath']))
				$this->query = str_replace($this->path . '/', '', $path);
		}
	}

	/**
	 * @see Page::show()
	 */
	public function show()
	{
		parent :: show();

		header('Content-type: text/xml');
		echo "<?xml version=\"1.0\" encoding=\"" . CHARSET . "\"?>\n<suggestions>\n";

		$dirs = @scandir($this->path);

		foreach ($dirs as $dir)
		{
			if ($dir == '.' || $dir == '..' || !is_dir($this->path . '/' . $dir))
				continue;

			if ($this->query && stripos($dir, $this->query) !== 0)
				continue;

			$dDir = $this->path . '/' . $dir . '/';
			$dDir = str_replace(WCF :: getUser()->homeDir, '', $dDir);
			echo "<path><![CDATA[" . StringUtil :: escapeCDATA($dDir) . "]]></path>\n";
		}

		echo '</suggestions>';
		exit();
	}
}
?>