<?php
/*
 * Copyright (c) 2009 Tobias Friebel
 * Authors: Tobias Friebel <TobyF@Web.de>
 *
 * Lizenz: GPL
 *
 * $Id$
 */

require_once (WCF_DIR . 'lib/system/session/UserSession.class.php');

class CPUserSession extends UserSession
{
	protected $outstandingNotifications = null;

	/**
	 * @see UserSession::__construct()
	 */
	public function __construct($userID = null, $row = null, $username = null)
	{
		$this->sqlSelects .= "	cp_user.*, cp_user.userID AS cpUserID,";
		$this->sqlJoins .= " 	LEFT JOIN cp" . CP_N . "_user cp_user ON (cp_user.userID = user.userID)";
		parent :: __construct($userID, $row, $username);
	}

	/**
	 * Updates the user session.
	 */
	public function update()
	{
		if (!$this->cpUserID)
		{
			// define default values
			$this->data['cpLastActivityTime'] = TIME_NOW;

			// create cp user record
			$sql = "INSERT IGNORE INTO	cp" . CP_N . "_user
							(userID, cpLastActivityTime)
					VALUES	(" . $this->userID . ", " . $this->cpLastActivityTime . ")";
			WCF :: getDB()->registerShutdownUpdate($sql);
		}
		else
		{
			CPUserSession :: updateCPLastActivityTime($this->userID);
		}
	}

	/**
	 * Initialises the user session.
	 */
	public function init()
	{
		parent :: init();

		$this->outstandingNotifications = null;
	}

	/**
	 * Updates the last activity timestamp in cp user database.
	 *
	 * @param	integer		$userID
	 * @param	integer		$timestamp
	 */
	public static function updateCPLastActivityTime($userID, $timestamp = TIME_NOW)
	{
		// update boardLastActivity in wbb user table
		$sql = "UPDATE	cp" . CP_N . "_user
				SET		cpLastActivityTime = " . $timestamp . "
				WHERE	userID = " . $userID;
		WCF :: getDB()->registerShutdownUpdate($sql);
	}

	/**
	 * @see	PM::getOutstandingNotifications()
	 */
	public function getOutstandingNotifications()
	{
		//TODO: Implement something useful here

		return $this->outstandingNotifications;
	}
}
?>