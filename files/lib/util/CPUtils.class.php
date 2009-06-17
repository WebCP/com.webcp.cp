<?php
/*
 * Copyright (c) 2009 Tobias Friebel
 * Authors: Tobias Friebel <TobyF@Web.de>
 *
 * Lizenz: GPL
 *
 * $Id$
 */

class CPUtils
{
	/**
	 * Get next GID/UID from DB
	 *
	 * @return integer
	 */
	public static function getNewGUID()
	{
		$sql = "SELECT 	MAX(guid) AS GUID
				FROM	cp" . CP_N . "_user";

		$guid = WCF :: getDB()->getFirstRow($sql);

		if (!$guid['GUID'])
			return 10000;
		else
			return ++$guid['GUID'];
	}
	
	/**
	 * Get homedir from username
	 *
	 * @param string $username
	 *
	 * @return string
	 */
	public static function getHomeDir($username)
	{
		return FileUtil :: addTrailingSlash(FileUtil :: getRealPath(HOMEDIR_PREFIX . '/' . $username . '/'));
	}

	/**
	 * validate if path is correct
	 *
	 * @param string $path
	 * @param string $homePath
	 * @param boolean $homeIsOK
	 * @param boolean $checkExist
	 *
	 * @return boolean
	 */
	public static function validatePath($path, $homePath, $homeIsOK = true, $checkExist = true)
	{
		$path = FileUtil :: getRealPath($path);

		if ((file_exists($path) || $checkExist) && !is_dir($path))
			return false;

		//check if path begins with homePath
		if (stripos($path, $homePath) !== 0)
			return false;

		//if homePath no further checks are neccessary
		if ($homeIsOK)
			return true;

		//if path is different to homePath
		if ($path != $homePath)
			return true;

		return false;
	}
}
?>