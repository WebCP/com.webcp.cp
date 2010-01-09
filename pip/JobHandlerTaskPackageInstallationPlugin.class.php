<?php
/*
 * Copyright (c) 2009 Tobias Friebel  
 * Authors: Tobias Friebel <TobyF@Web.de>
 *
 * Lizenz: GPL
 *
 * $Id$
 */

// wcf imports
require_once (WCF_DIR . 'lib/acp/package/plugin/AbstractXMLPackageInstallationPlugin.class.php');

class JobHandlerTaskPackageInstallationPlugin extends AbstractXMLPackageInstallationPlugin
{
	public $tagName = 'jobhandlertask';
	public $tableName = 'jobhandler_task';
	private $cp_n = '1_1';
	
	/**
	 * will create our CP_N, this works in every case
	 * this PIP operates without CP_N and uses the current parent instead (like SqlPackageInstallationPlugin)
	 */
	private function getCP_N()
	{
		$standalonePackage = $this->installation->getPackage();
		
		if ($standalonePackage->getParentPackageID()) 
		{
			// package is a plugin; get parent package
			$standalonePackage = $standalonePackage->getParentPackage();
		}
			
		//this is our CP_N
		$this->cp_n = WCF_N.'_'.$standalonePackage->getInstanceNo();
	}

	/** 
	 * @see PackageInstallationPlugin::install()
	 */
	public function install()
	{
		parent :: install();
		
		if (!$xml = $this->getXML())
		{
			return;
		}
		
		// Create an array with the data blocks (import or delete) from the xml file.
		$xml = $xml->getElementTree('data');
		
		$this->getCP_N();

		// Loop through the array and install or uninstall cronjobs.
		foreach ($xml['children'] as $block)
		{
			if (count($block['children']))
			{
				// Handle the import instructions
				if ($block['name'] == 'import')
				{
					// Loop through items and create or update them.
					foreach ($block['children'] as $item)
					{
						// Extract item properties.
						foreach ($item['children'] as $child)
						{
							if (!isset($child['cdata']))
								continue;
							$item[$child['name']] = $child['cdata'];
						}
						
						// make xml tags-names (keys in array) to lower case
						$this->keysToLowerCase($item);
						
						// check required attributes
						if (!isset($item['jobhandler'])) 
							throw new SystemException("Required 'jobhandler' attribute for jobhandlertask tag is missing.", 13023);
							
						if (!in_array($item['nextexec'], array('asap','hourchange','daychange','weekchange','monthchange','yearchange')))
							throw new SystemException("unknown 'nextexec' attribute for jobhandlertask tag");
											
						$data = '';
						$volatile = $priority = 0;
						
						$jobhandler = $item['jobhandler'];
						
						$nextExec = $item['nextexec'];
													
						if (isset($item['volatile']))
							$volatile = $item['volatile'];
						
						if (isset($item['data']))
							$data = $item['data'];
							
						if (isset($item['priority']))
							$priority = $item['priority'];
							
						$sql = "INSERT INTO		cp" . $this->cp_n . "_jobhandler_task 
												(jobhandler, nextExec, volatile, priority, data, packageID) 
								VALUES 			('" . escapeString($jobhandler) . "',
												'" . escapeString($nextExec) . "',
												" . intval($volatile) . ",
												" . intval($priority) . ",
												'" . escapeString($data) . "',
												".$this->installation->getPackageID().")
								ON DUPLICATE KEY UPDATE 	nextExec = VALUES(nextExec	),
															volatile = VALUES(volatile),
															priority = VALUES(priority),
															data = VALUES(data)";
						WCF :: getDB()->sendQuery($sql);
					}
				}
				// Handle the delete instructions.
				else if ($block['name'] == 'delete')
				{
					if ($this->installation->getAction() == 'update')
					{
						$sql = "DELETE FROM	cp" . $this->cp_n . "_jobhandler_task
								WHERE		packageID = ".$this->installation->getPackageID();
						WCF::getDB()->sendQuery($sql);
					}
				}
			}
		}
	}
	
	/**
	 * @see	 PackageInstallationPlugin::hasUninstall()
	 */
	public function hasUninstall() 
	{
		// call hasUninstall event
		EventHandler::fireAction($this, 'hasUninstall');
		
		$this->getCP_N();

		$sql = "SELECT	COUNT(*) AS count
				FROM	cp" . $this->cp_n . "_jobhandler_task
				WHERE	packageID = ".$this->installation->getPackageID();
		$installationCount = WCF::getDB()->getFirstRow($sql);
		return $installationCount['count'];
	}
	
	/**
	 * @see	 PackageInstallationPlugin::uninstall()
	 */
	public function uninstall() 
	{
		// call uninstall event
		EventHandler::fireAction($this, 'uninstall');
		
		$this->getCP_N();
		
		$sql = "DELETE FROM	cp" . $this->cp_n . "_jobhandler_task
				WHERE		packageID = ".$this->installation->getPackageID();
		WCF::getDB()->sendQuery($sql);
	}
}
?>