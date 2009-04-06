CREATE TABLE cp1_1_user (
  userID int(11) unsigned NOT NULL auto_increment PRIMARY KEY,
  guid int(5) NOT NULL default '0',
  cpLastActivityTime int(10) NOT NULL default '0',
  homeDir varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE cp1_1_diskspace (
  diskspaceid int(11) unsigned NOT NULL auto_increment PRIMARY KEY,
  userID int(11) NOT NULL default '0',
  day date NOT NULL,
  diskspace bigint(30) unsigned NOT NULL default '0',
  mailspace bigint(30) unsigned NOT NULL default '0',
  mysqlspace bigint(30) unsigned NOT NULL default '0',
  KEY userID (userID)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE cp1_1_cron_tasks (
  id int(11) unsigned NOT NULL auto_increment,
  type int(11) NOT NULL default '0',
  data text NOT NULL,
  PRIMARY KEY  (id)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
