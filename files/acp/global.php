<?php
/*
 * +-----------------------------------------+
 * | Copyright (c) 2009 Tobias Friebel		 |
 * +-----------------------------------------+
 * | Authors: Tobias Friebel <TobyF@Web.de>  |
 * +-----------------------------------------+
 *
 * Project: WCF Control Panel
 *
 * $Id$
 */

define('RELATIVE_CP_DIR', '../');
define('IS_ACP', true);

$packageDirs = array();
require_once(dirname(dirname(__FILE__)).'/config.inc.php');

require_once(RELATIVE_WCF_DIR.'global.php');
if (!count($packageDirs)) $packageDirs[] = CP_DIR;
$packageDirs[] = WCF_DIR;

require_once(CP_DIR.'lib/system/CPACP.class.php');
new CPACP();

?>