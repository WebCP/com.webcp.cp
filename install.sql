CREATE TABLE cp1_1_user (
  userID int(11) unsigned NOT NULL auto_increment,
  customernumber varchar(255) NOT NULL default '',
  diskspace bigint(30) NOT NULL default '0',
  diskspace_used bigint(30) NOT NULL default '0',
  ftps int(15) NOT NULL default '0',
  ftps_used int(15) NOT NULL default '0',
  subdomains int(15) NOT NULL default '0',
  subdomains_used int(15) NOT NULL default '0',
  documentroot varchar(255) NOT NULL default '',
  standardsubdomain int(11) NOT NULL default '0',
  guid int(5) NOT NULL default '0',
  ftp_lastaccountnumber int(11) NOT NULL default '0',
  phpenabled tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (userID),
) ENGINE=MyISAM  DEFAULT;

CREATE TABLE `cp1_1_ftp_groups` (
  id int(20) NOT NULL auto_increment,
  userID int(11) NOT NULL default '0',
  groupname varchar(60) NOT NULL default '',
  gid int(5) NOT NULL default '0',
  members longtext NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `groupname` (`groupname`),
  KEY `userID` (`userID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

CREATE TABLE `cp1_1_ftp_users` (
  `id` int(20) NOT NULL auto_increment,
  `userID` int(11) NOT NULL default '0',
  `username` varchar(255) NOT NULL default '',
  `uid` int(5) NOT NULL default '0',
  `gid` int(5) NOT NULL default '0',
  `password` varchar(20) NOT NULL default '',
  `homedir` varchar(255) NOT NULL default '',
  `shell` varchar(255) NOT NULL default '/bin/false',
  `login_enabled` enum('N','Y') NOT NULL default 'N',
  `login_count` int(15) NOT NULL default '0',
  `last_login` datetime NOT NULL default '0000-00-00 00:00:00',
  `up_count` int(15) NOT NULL default '0',
  `up_bytes` bigint(30) NOT NULL default '0',
  `down_count` int(15) NOT NULL default '0',
  `down_bytes` bigint(30) NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `userID` (`userID`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

CREATE TABLE `cp1_1_diskspace` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `userID` int(11) NOT NULL default '0',
  `year` int(4) unsigned zerofill NOT NULL default '0000',
  `month` int(2) unsigned zerofill NOT NULL default '00',
  `day` int(2) unsigned zerofill NOT NULL default '00',
  `stamp` int(11) unsigned NOT NULL default '0',
  `webspace` bigint(30) unsigned NOT NULL default '0',
  `mail` bigint(30) unsigned NOT NULL default '0',
  `mysql` bigint(30) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `userID` (`userID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `cp1_1_domains` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `userID` int(11) NOT NULL default '0',
  `domain` varchar(255) NOT NULL default '',
  `adminid` int(11) unsigned NOT NULL default '0',
  `customerid` int(11) unsigned NOT NULL default '0',
  `aliasdomain` int(11) unsigned default NULL,
  `documentroot` varchar(255) NOT NULL default '',
  `ipandport` int(11) unsigned NOT NULL default '1',
  `isbinddomain` tinyint(1) NOT NULL default '0',
  `isemaildomain` tinyint(1) NOT NULL default '0',
  `email_only` tinyint(1) NOT NULL default '0',
  `iswildcarddomain` tinyint(1) NOT NULL default '0',
  `subcanemaildomain` tinyint(1) NOT NULL default '0',
  `caneditdomain` tinyint(1) NOT NULL default '1',
  `zonefile` varchar(255) NOT NULL default '',
  `dkim` tinyint(1) NOT NULL default '0',
  `dkim_id` int(11) unsigned NOT NULL,
  `dkim_privkey` text NOT NULL,
  `dkim_pubkey` text NOT NULL,
  `wwwserveralias` tinyint(1) NOT NULL default '1',
  `parentdomainid` int(11) unsigned NOT NULL default '0',
  `openbasedir` tinyint(1) NOT NULL default '0',
  `openbasedir_path` tinyint(1) NOT NULL default '0',
  `safemode` tinyint(1) NOT NULL default '0',
  `speciallogfile` tinyint(1) NOT NULL default '0',
  `specialsettings` text NOT NULL,
  `deactivated` tinyint(1) NOT NULL default '0',
  `bindserial` varchar(10) NOT NULL default '2000010100',
  `ssl` tinyint(4) NOT NULL default '0',
  `ssl_redirect` tinyint(4) NOT NULL default '0',
  `ssl_ipandport` tinyint(4) NOT NULL default '0',
  `add_date` int(11) NOT NULL default '0',
  `registration_date` date NOT NULL,
  `phpsettingid` int(11) unsigned NOT NULL default '1',
  `mod_fcgid_starter` int(4) default '-1',
  `mod_fcgid_maxrequests` int(4) default '-1',
  PRIMARY KEY  (`id`),
  KEY `userID` (`userID`),
  KEY `parentdomain` (`parentdomainid`),
  KEY `domain` (`domain`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

CREATE TABLE `cp1_1_ipsandports` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `ip` varchar(39) NOT NULL default '',
  `port` int(5) NOT NULL default '80',
  `listen_statement` tinyint(1) NOT NULL default '0',
  `namevirtualhost_statement` tinyint(1) NOT NULL default '0',
  `vhostcontainer` tinyint(1) NOT NULL default '0',
  `vhostcontainer_servername_statement` tinyint(1) NOT NULL default '0',
  `specialsettings` text NOT NULL,
  `ssl` tinyint(4) NOT NULL default '0',
  `ssl_cert` tinytext,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;

CREATE TABLE `cp1_1_panel_tasks` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `type` int(11) NOT NULL default '0',
  `data` text NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
