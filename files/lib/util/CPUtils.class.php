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

	public static function getHomeDir($username)
	{
		return FileUtil :: getRealPath(HOMEDIR_PREFIX . '/' . $username);
	}
}
?>