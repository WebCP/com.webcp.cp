<?php
/*
 * Copyright (c) 2009 Tobias Friebel  
 * Authors: Tobias Friebel <TobyF@Web.de>
 *
 * Lizenz: GPL
 *
 * $Id$
 */

class JobhandlerUtils
{
	/**
	 * will get the time of the last run of backend from database
	 *
	 * @return integer
	 */
	public static function getTimeOfLastRun()
	{
		$sql = "SELECT 	optionValue
				FROM 	wcf" . WCF_N . "_option
				WHERE 	optionName = 'last_run_backend' AND packageID = " . PACKAGE_ID;
		
		$time = WCF :: getDB()->getFirstRow($sql);
		
		return $time['optionValue'];
	}

	/**
	 * Add an temporary job
	 *
	 * @param string $jobhandler
	 * @param integer $userID
	 * @param array $data
	 * @param string $nextExec
	 * @param int $priority
	 * 
	 * @return null
	 */
	public static function addJob($jobhandler, $userID, array $data = array(), $nextExec = 'asap', $priority = 0)
	{
		if (!in_array($nextExec, array('asap','hourchange','daychange','weekchange','monthchange','yearchange')))
			throw new SystemException('Unknown "'.$nextExec.'" nextExec, allowed are: asap, hourchange, daychange, weekchange, monthchange, yearchange');
		
		if (empty($data))
			$data['userID'] = $userID;	
		
		$sql = "INSERT IGNORE INTO cp" . CP_N . "_jobhandler_task 
				(jobhandler, data, nextExec, userID, priority)
				VALUES ('" . escapeString($jobhandler) . "',
						'" . escapeString(serialize($data)) . "',
						'" . escapeString($nextExec) . "',
						" . intval($userID) . ",
						" . intval($priority) . ")";
		
		WCF :: getDB()->sendQuery($sql);
	}
}

?>