<?php
/*
 * Copyright (c) 2009 Tobias Friebel
 * Authors: Tobias Friebel <TobyF@Web.de>
 *
 * Lizenz: GPL
 *
 * $Id$
 */

require_once(WCF_DIR.'lib/system/event/EventListener.class.php');
require_once(CP_DIR.'lib/data/user/CPUser.class.php');

class UserAddCPListener implements EventListener
{
	/**
	 * @see EventListener::execute()
	 */
	public function execute($eventObj, $className, $eventName)
	{
		if ($eventName == 'readParameters' && $className == 'UserAddForm')
		{
			$sql = "SELECT 	username AS name
					FROM 	wcf" . WCF_N . "_user
					ORDER BY SUBSTRING_INDEX(username, '" . USER_PREFIX . "', -1) + 0 DESC
					LIMIT 1";
			$postFix = WCF :: getDB()->getFirstRow($sql);

			if (empty($postFix))
			{
				$eventObj->username = USER_PREFIX . '1';
			}
			else
			{
				$postFix = intval(str_replace(USER_PREFIX, '', $postFix['name']));
				$eventObj->username = USER_PREFIX . ++$postFix;
			}

			$eventObj->adminname = WCF :: getUser()->username;
			$eventObj->adminID = WCF :: getUser()->userID;
			$eventObj->cpUser->isCustomer = 0;
			$eventObj->sendWelcomeMail = 1;
			$eventObj->password = UserRegistrationUtil :: getNewPassword();
			$eventObj->confirmPassword = $eventObj->password;
		}
		elseif ($eventName == 'readData' && $className == 'UserEditForm')
		{
			// if user is editet and we do not save, get old data for display
			if (!count($_POST))
			{
				$eventObj->cpUser = new CPUser($eventObj->userID);

				$u = new User($eventObj->cpUser->adminID);
				$eventObj->adminname = $u->username;
				$eventObj->adminID = $u->userID;
				$eventObj->sendWelcomeMail = 0;
			}
		}
		elseif ($eventName == 'readFormParameters')
		{
			if (isset($_POST['adminname'])) $eventObj->adminname = StringUtil::trim($_POST['adminname']);
			else $eventObj->adminname = '';
			
			if (isset($_POST['isCustomer'])) $eventObj->cpUser->isCustomer = intval($_POST['isCustomer']);
			else $eventObj->cpUser->isCustomer = 0;
			
			if (isset($_POST['sendWelcomeMail'])) $eventObj->sendWelcomeMail = intval($_POST['sendWelcomeMail']);
			else $eventObj->sendWelcomeMail = 0;
		}
		elseif ($eventName == 'validate')
		{
			// username muss be unixcompatible
			if (!preg_match('/^[a-z0-9\-_]+$/i', $eventObj->username))
			{
				$eventObj->errorType['username'] = 'notValid';
			}
			
			if (WCF :: getUser()->getPermission('admin.general.isSuperAdmin'))
			{
				try 
				{
					if (empty($eventObj->adminname))
					{
						throw new UserInputException('adminname', 'empty');
					}
					
					// get admin
					$user = new UserSession(null, null, $eventObj->adminname);
					if (!$user->userID) 
					{
						throw new UserInputException('adminname', 'notFound');
					}
					
					if (!$user->getPermission('admin.general.canUseAcp'))
					{
						throw new UserInputException('adminname', 'notValid');
					}
						
					$eventObj->cpUser->adminID = $user->userID;
				}
				catch (UserInputException $e) 
				{
					$eventObj->errorType[$e->getField()] = $e->getType();
				}
			}
			else
			{
				$eventObj->cpUser->adminID = WCF :: getUser()->userID;
			}
			
			// create new password, if neccessary
			if ($eventObj->sendWelcomeMail && $eventObj->password == '')
			{
				$eventObj->password = UserRegistrationUtil :: getNewPassword();
				$eventObj->confirmPassword = $eventObj->password;
			}
		}
		elseif ($eventName == 'saved')
		{
			// create cp user record
			$sql = "INSERT IGNORE INTO	cp" . CP_N . "_user
							(userID,
							 adminID,
							 isCustomer,
							 cpLastActivityTime
							)
					VALUES	(" . $eventObj->user->userID . ",
							 " . $eventObj->cpUser->adminID . ",
							 " . $eventObj->cpUser->isCustomer . ",
							 " . TIME_NOW . " 
							)
					ON DUPLICATE KEY UPDATE
							adminID = VALUES(adminID),
							isCustomer = VALUES(isCustomer)";
			WCF :: getDB()->sendQuery($sql);
			
			if ($eventObj->sendWelcomeMail == 1)
			{
				$welcomeMail = ACPNoteUtil :: getFormattedNote('newUserMail', 
																$eventObj->languageID, 
																$eventObj->user, 
																array('password' => $eventObj->password,
																	  'PAGE_TITLE' => PAGE_TITLE,
																	  'PAGE_URL' => PAGE_URL));
				
				if (MAIL_USE_FORMATTED_ADDRESS)	
					$from = MAIL_FROM_NAME . ' <' . MAIL_FROM_ADDRESS . '>';
				else 
					$from = MAIL_FROM_ADDRESS;

				//disable for next save (if edit)
				$eventObj->sendWelcomeMail = 0;
				
				if (empty($welcomeMail))
					return;
				
				try 
				{
					require_once(WCF_DIR.'lib/data/mail/Mail.class.php');
					
					$mail = new Mail(array($eventObj->user->username => $eventObj->user->email), 
									 WCF :: getLanguage()->get('cp.user.welcomeMailSubject', array('PAGE_TITLE' => PAGE_TITLE)), 
									 $welcomeMail, 
									 $from);
					$mail->send();
				}
				catch (SystemException $e) {} // ignore errors		
			}
		}
		elseif ($eventName == 'assignVariables')
		{
			WCF :: getTPL()->assign('adminname', $eventObj->adminname);
			WCF :: getTPL()->assign('isCustomer', $eventObj->cpUser->isCustomer);
			WCF :: getTPL()->assign('errorType', $eventObj->errorType);
			WCF :: getTPL()->assign('sendWelcomeMail', $eventObj->sendWelcomeMail);
			WCF :: getTPL()->append('additionalFields', WCF :: getTPL()->fetch('userAddAdmin'));
		}
	}
}
?>
