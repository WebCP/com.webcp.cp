CREATE TABLE cp1_1_user (
  userID int(11) unsigned NOT NULL auto_increment,
  customernumber varchar(255) NOT NULL default '0',
  diskspace bigint(30) NOT NULL default '0',
  diskspace_used bigint(30) NOT NULL default '0',
  ftps int(15) NOT NULL default '0',
  ftps_used int(15) NOT NULL default '0',
  subdomains int(15) NOT NULL default '0',
  subdomains_used int(15) NOT NULL default '0',
  documentroot varchar(255) NOT NULL default '/',
  standardsubdomain int(11) NOT NULL default '0',
  guid int(5) NOT NULL default '0',
  ftp_lastaccountnumber int(11) NOT NULL default '0',
  phpenabled tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (userID)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE cp1_1_diskspace (
  id int(11) unsigned NOT NULL auto_increment,
  userID int(11) NOT NULL default '0',
  year int(4) unsigned zerofill NOT NULL default '0000',
  month int(2) unsigned zerofill NOT NULL default '00',
  day int(2) unsigned zerofill NOT NULL default '00',
  stamp int(11) unsigned NOT NULL default '0',
  webspace bigint(30) unsigned NOT NULL default '0',
  mail bigint(30) unsigned NOT NULL default '0',
  mysql bigint(30) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `userID` (`userID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE cp1_1_cron_tasks (
  id int(11) unsigned NOT NULL auto_increment,
  type int(11) NOT NULL default '0',
  data text NOT NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
