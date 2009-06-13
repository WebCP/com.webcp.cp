CREATE TABLE cp1_1_user (
  	userID int(11) unsigned NOT NULL auto_increment PRIMARY KEY,
  	guid int(5) NOT NULL default '0',
  	cpLastActivityTime int(10) NOT NULL default '0',
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

CREATE TABLE cp1_1_jobhandler_tasks (
	jobhandlerTaskID int(10) unsigned NOT NULL auto_increment,
	jobhandlerName varchar(20) NOT NULL,
	timeExec varchar(20) NOT NULL,
	lastExec int(10) unsigned NOT NULL default 0,
	nextExec int(10) unsigned NOT NULL default 0,
	volatile TINYINT NOT NULL default 1,
	data TEXT NOT NULL,
	PRIMARY KEY (jobhandlerTaskID),
	KEY (jobhandlerName)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE cp1_1_jobhandler (
	jobhandlerName varchar(20) NOT NULL,
	jobhandlerFile varchar(100) NOT NULL,
	jobhandlerDescription text NOT NULL,
	PRIMARY KEY (jobhandlerName)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8;