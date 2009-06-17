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
							
						if (!in_array($item['nextExec'], array('asap','hourchange','daychange','weekchange','monthchange','yearchange')))
							throw new SystemException("unknown 'nextExec' attribute for jobhandlertask tag");
											
						$data = '';
						$volatile = 1;
						
						$jobhandler = $item['jobhandler'];
						
						$nextExec = $item['nextExec'];
													
						if (isset($item['volatile']))
							$volatile = $item['volatile'];
						
						if (isset($item['data']))
							$data = $item['data'];
							
						$sql = "INSERT INTO		cp" . CP_N . "_jobhandler_task 
												(jobhandler, nextExec, volatile, data, packageID) 
								VALUES 			('" . escapeString($jobhandler) . "',
												'" . escapeString($nextExec) . "',
												" . intval($volatile) . ",
												'" . escapeString($data) . "',
												".$this->installation->getPackageID().")";
						WCF :: getDB()->sendQuery($sql);
					}
				}
				// Handle the delete instructions.
				else if ($block['name'] == 'delete')
				{
					if ($this->installation->getAction() == 'update')
					{
						$sql = "DELETE FROM	cp".CP_N."_jobhandler_task
								WHERE		packageID = ".$this->installation->getPackageID();
						WCF::getDB()->sendQuery($sql);
					}
				}
			}
		}
	}
}
?>