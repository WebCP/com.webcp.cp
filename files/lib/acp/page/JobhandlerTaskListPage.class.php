<?php
/*
 * Copyright (c) 2009 Tobias Friebel  
 * Authors: Tobias Friebel <TobyF@Web.de>
 *
 * Lizenz: GPL
 *
 * $Id$
 */

require_once (WCF_DIR . 'lib/page/SortablePage.class.php');

class JobhandlerListPage extends SortablePage
{
	// system
	public $templateName = 'jobhandlerTaskList';
	public $defaultSortField = 'jobhandlerTaskID';
	
	/**
	 * list of jobhandlers
	 * 
	 * @var	array
	 */
	public $jobhandler = array ();
	
	/**
	 * last run of backend
	 * 
	 * @var integer
	 */
	public $lastRun = 0;

	/**
	 * @see Page::readData()
	 */
	public function readData()
	{
		parent :: readData();
		
		$this->readJobhandler();
		
		$this->lastRun = CPUtils :: getTimeOfLastRun();
	}

	/**
	 * Gets the list of cronjobs.
	 */
	protected function readCronjobs()
	{
		$sql = "SELECT		jobhandler.*
				FROM		cp" . CP_N . "_jobhandler_tasks jobhandler
				ORDER BY	jobhandler.".$this->sortField." ".$this->sortOrder;
		$result = WCF :: getDB()->sendQuery($sql, $this->itemsPerPage, ($this->pageNo - 1) * $this->itemsPerPage);
		while ($row = WCF :: getDB()->fetchArray($result))
		{			
			$this->jobhandler[] = $row;
		}
	}

	/**
	 * @see Page::assignVariables()
	 */
	public function assignVariables()
	{
		parent :: assignVariables();
		
		WCF :: getTPL()->assign(array (
			'jobhandler' => $this->jobhandler,
			'lastRun' => $this->lastRun 
		));
	}

	/**
	 * @see MultipleLinkPage::countItems()
	 */
	public function countItems()
	{
		parent :: countItems();
		
		// count cronjobs
		$sql = "SELECT	COUNT(*) AS count
				FROM	cp" . CP_N . "_jobhandler_tasks jobhandler";
		$row = WCF :: getDB()->getFirstRow($sql);
		return $row['count'];
	}

	/**
	 * @see SortablePage::validateSortField()
	 */
	public function validateSortField()
	{
		parent :: validateSortField();
		
		switch ($this->sortField)
		{
			case 'jobhandlerTaskID':
			case 'jobhandlerName':
			case 'lastExec':
			case 'nextExec':
			case 'startMinute':
			case 'startHour':
			case 'startDom':
			case 'startMonth':
			case 'startDow':
			case 'volatile':
			case 'data':
			break;
			default:
				$this->sortField = $this->defaultSortField;
		}
	}

	/**
	 * @see Page::show()
	 */
	public function show()
	{
		// set active menu item.
		CPACP :: getMenu()->setActiveMenuItem('cp.acp.menu.link.jobhandlertasks.view');
		
		parent :: show();
	}
}
?>