CREATE TABLE cp1_1_user (
  	userID int(10) unsigned NOT NULL auto_increment PRIMARY KEY,
  	adminID int(10) unsigned NOT NULL default '0',
  	isCustomer tinyint(1) unsigned NOT NULL default '0',
  	cpLastActivityTime int(10) NOT NULL default 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO 	wcf1_package_update_server
		(packageUpdateServerID, server, status, statusUpdate, errorText, updatesFile, timestamp, htUsername, htPassword)
VALUES 		(0, 'http://dev.hugin-hosting.de/packageserver', 'online', 1, NULL, 0, 1168257450, '', '');
