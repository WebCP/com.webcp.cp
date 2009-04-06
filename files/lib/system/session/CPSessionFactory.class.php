<?php
/*
 * Copyright (c) 2009 Tobias Friebel
 * Authors: Tobias Friebel <TobyF@Web.de>
 *
 * Lizenz: GPL
 *
 * $Id$
 */

require_once (CP_DIR . 'lib/system/session/CPSession.class.php');
require_once (CP_DIR . 'lib/system/session/CPUserSession.class.php');

// wcf imports
require_once (WCF_DIR . 'lib/system/session/CookieSessionFactory.class.php');

class CPSessionFactory extends CookieSessionFactory
{
	protected $userClassName = 'CPUserSession';
	protected $sessionClassName = 'CPSession';
}
?>