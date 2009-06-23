CREATE TABLE cp1_1_user (
  	userID int(10) unsigned NOT NULL auto_increment PRIMARY KEY,
  	guid int(5) NOT NULL default '0',
  	cpLastActivityTime int(10) NOT NULL default 0,
  	homeDir varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE cp1_1_diskspace (
  	diskspaceID int(11) unsigned NOT NULL auto_increment PRIMARY KEY,
  	userID int(11) NOT NULL default '0',
  	day date NOT NULL,
  	diskspace bigint(30) unsigned NOT NULL default '0',
  	mailspace bigint(30) unsigned NOT NULL default '0',
  	mysqlspace bigint(30) unsigned NOT NULL default '0',
  	KEY userID (userID)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE cp1_1_jobhandler_task (
	jobhandlerTaskID int(10) unsigned NOT NULL auto_increment,
	jobhandler varchar(20) NOT NULL,
	nextExec varchar(20) NOT NULL default 'asap',
	lastExec int(10) unsigned NOT NULL default 0,
	volatile TINYINT NOT NULL default 1,
	userID int(10) unsigned NOT NULL default 0,
	data TEXT NOT NULL,
	packageID int(10) unsigned NOT NULL default 0,
	PRIMARY KEY (jobhandlerTaskID),
	KEY (jobhandler),
	KEY (packageID),
	UNIQUE (jobhandler, nextExec, userID)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;