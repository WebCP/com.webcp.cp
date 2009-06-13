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

class JobHandlerPackageInstallationPlugin extends AbstractXMLPackageInstallationPlugin
{
	public $tagName = 'jobhandler';

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

		// Loop through the array and install or uninstall cronjobs.
		foreach ($xml['children'] as $key => $block)
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
						
						// check required attributes
						if (!isset($item['name'])) 
						{
							throw new SystemException("Required 'name' attribute for jobhandler tag is missing.", 13023);
						}
						
						if (!isset($item['file'])) 
						{
							throw new SystemException("Required 'file' attribute for jobhandler tag is missing.", 13023);
						}
						
						$jobhandlerFile = $jobhandlerName = $jobhandlerDescription = '';
						$timeExec = $data = '';
						$volatile = 1;
						
						// make xml tags-names (keys in array) to lower case
						$this->keysToLowerCase($item);
						
						$jobhandlerName = $item['name'];
						$jobhandlerFile = $item['file'];
						
						if (isset($item['description']))
							$jobhandlerDescription = $item['description'];
						
						if (isset($item['timeExec']))
						{
							$timeExec = $item['timeExec'];
							
							if (!in_array($timeExec, array('immediately','hourchange','daychange','weekchange','monthchange','yearchange')))
								throw new SystemException("unknown 'timeExec' attribute for jobhandler tag");
						}
							
						if (isset($item['volatile']))
							$volatile = $item['volatile'];
						
						if (isset($item['data']))
							$data = $item['data'];
							
						if ($volatile == 0 && $timeExec)
						{
							$sql = "INSERT INTO		cp" . CP_N . "_jobhandler_tasks 
													(jobhandlerName, timeExec, nextExec, volatile, data) 
									VALUES 			('" . escapeString($jobhandlerName) . "',
													'" . escapeString($timeExec) . "',
													" . TIME_NOW . ",
													" . intval($volatile) . ",
													'" . escapeString($data) . "')";
							WCF :: getDB()->sendQuery($sql);
						}
						
						$sql = "INSERT INTO		cp" . CP_N . "_jobhandler 
												(jobhandlerName, jobhandlerFile, jobhandlerDescription) 
								VALUES 			('" . escapeString($jobhandlerName) . "', 
												 '" . escapeString($jobhandlerFile) . "',
												 '" . escapeString($jobhandlerDescription) . "')";
						WCF :: getDB()->sendQuery($sql); 
					}
				}
				// Handle the delete instructions.
				else if ($block['name'] == 'delete')
				{
					if ($this->installation->getAction() == 'update')
					{
						// Loop through items and delete them.
						$jobhandlerNames = '';
						foreach ($block['children'] as $item)
						{
							// check required attributes
							if (!isset($item['attrs']['name']))
							{
								throw new SystemException("Required 'name' attribute for 'jobhandler'-tag is missing.", 13023);
							}
							// Create a string with all item names which should be deleted (comma seperated).
							if (!empty($jobhandlerNames))
								$jobhandlerNames .= ',';
							$jobhandlerNames .= "'" . escapeString($item['attrs']['name']) . "'";
						}
						
						// Delete items.
						if (!empty($jobhandlerNames))
						{
							$sql = "DELETE FROM	cp" . CP_N . "_jobhandler
									WHERE		jobhandlerName IN (" . $jobhandlerNames . ")";
							$sql = "DELETE FROM	cp" . CP_N . "_jobhandler_tasks
									WHERE		jobhandlerName IN (" . $jobhandlerNames . ")";
							WCF :: getDB()->sendQuery($sql);
						}
					}
				}
			}
		}
	}
}
?>