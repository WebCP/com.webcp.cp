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
	 * @param mixed $data
	 * @param string $nextExec
	 * 
	 * @return null
	 */
	public static function addJob($jobhandler, $data, $nextExec = 'asap')
	{
		if (!in_array($nextExec, array('asap','hourchange','daychange','weekchange','monthchange','yearchange')))
			throw new SystemException('Unknown "'.$nextExec.'" nextExec, allowed are: asap, hourchange, daychange, weekchange, monthchange, yearchange');
		
		$sql = "INSERT INTO cp" . CP_N . "_jobhandler_task 
				(jobhandler, data, nextExec)
				VALUES ('" . escapeString($jobhandler) . "',
						'" . escapeString(serialize($data)) . "',
						'" . escapeString($nextExec) . "')";
		
		WCF :: getDB()->sendQuery($sql);
	}
}

?>