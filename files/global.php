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

// include config
$packageDirs = array();
require_once(dirname(__FILE__).'/config.inc.php');

// include WCF
require_once(RELATIVE_WCF_DIR.'global.php');
if (!count($packageDirs)) $packageDirs[] = CP_DIR;
$packageDirs[] = WCF_DIR;

// starting OH core
require_once(CP_DIR.'lib/system/CPCore.class.php');
new CPCore();

?>