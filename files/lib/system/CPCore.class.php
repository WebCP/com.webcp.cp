<?php
// wcf imports
require_once(WCF_DIR . 'lib/page/util/menu/PageMenuContainer.class.php');
require_once(WCF_DIR . 'lib/page/util/menu/UserCPMenuContainer.class.php');
require_once(WCF_DIR . 'lib/system/style/StyleManager.class.php');

/**
 * This class extends the main WCF class by WCFCP specific functions.
 *
 * @author		Tobias Friebell
 * @copyright	2009-2011 Tobias Friebel
 * @license		GPL
 * @package		com.toby.cp
 * @subpackage	system
 * @category	WCFCP
 */

class CPCore extends WCF implements PageMenuContainer, UserCPMenuContainer
{
	protected static $pageMenuObj= null;
	protected static $userCPMenuObj= null;
	public static $availablePagesDuringOfflineMode = array(
		'page' => array('Captcha', 'LegalNotice'),
		'form' => array('UserLogin'),
		'action' => array('UserLogout')
	);

	/**
	 * Calls all init functions of the WCF class.
	 */
	public function __construct()
	{
		parent :: __construct();

		$this->initAuth();
	}

	/**
	 * Does the user authentication.
	 */
	protected function initAuth()
	{
		if ((!isset($_REQUEST['form']) || $_REQUEST['form'] != 'UserLogin') &&
			(!isset($_REQUEST['page']) || $_REQUEST['page'] != 'Captcha') &&
			(!isset($_REQUEST['page']) || $_REQUEST['page'] != 'LegalNotice') &&
			(!isset($_REQUEST['action']) || $_REQUEST['action'] == 'UserLogout')
		   )
		{
			if (WCF::getUser()->userID == 0)
			{
				HeaderUtil::redirect('index.php?form=UserLogin'.SID_ARG_2ND_NOT_ENCODED);
				exit;
			}
		}
	}

	/**
	 * @see WCF::initTPL()
	 */
	protected function initTPL()
	{
		// init style to get template pack id
		StyleManager :: changeStyle(0);

		global $packageDirs;

		require_once (WCF_DIR . 'lib/system/template/StructuredTemplate.class.php');

		self :: $tplObj= new StructuredTemplate(self :: getStyle()->templatePackID,
												self :: getLanguage()->getLanguageID(),
												ArrayUtil :: appendSuffix($packageDirs, 'templates/')
												);

		$this->assignDefaultTemplateVariables();

		self::getTPL()->assign('executeCronjobs',
								WCF::getCache()->get('cronjobs-'.PACKAGE_ID, 'nextExec') < TIME_NOW
								);

		self::getTPL()->assign('timezone', DateUtil::getTimezone());

		// check offline mode
		if (OFFLINE && !self :: getUser()->getPermission('admin.general.canUseAcp'))
		{
			$showOfflineError= true;
			foreach (self :: $availablePagesDuringOfflineMode as $type => $names)
			{
				if (isset ($_REQUEST[$type]))
				{
					foreach ($names as $name)
					{
						if ($_REQUEST[$type] == $name)
						{
							$showOfflineError = false;
							break 2;
						}
					}
					break;
				}
			}

			if ($showOfflineError)
			{
				self :: getTPL()->display('offline');
				exit;
			}
		}

		// user ban
		if (self :: getUser()->banned
			&& (!isset ($_REQUEST['page']) || $_REQUEST['page'] != 'LegalNotice')
			&& (!isset ($_REQUEST['action']) || $_REQUEST['action'] != 'UserLogout')
			)
		{
			require_once (WCF_DIR . 'lib/system/exception/PermissionDeniedException.class.php');
			throw new PermissionDeniedException();
		}
	}

	/**
	 * @see WCF::loadDefaultCacheResources()
	 */
	protected function loadDefaultCacheResources()
	{
		parent :: loadDefaultCacheResources();
		WCF :: getCache()->addResource('cronjobs-'.PACKAGE_ID, WCF_DIR.'cache/cache.cronjobs-'.PACKAGE_ID.'.php', WCF_DIR.'lib/system/cache/CacheBuilderCronjobs.class.php');
		WCF :: getCache()->addResource('help-'.PACKAGE_ID, WCF_DIR.'cache/cache.help-'.PACKAGE_ID.'.php', WCF_DIR.'lib/system/cache/CacheBuilderHelp.class.php');
	}

	/**
	 * Returns the active style object.
	 *
	 * @return	Style
	 */
	public static final function getStyle()
	{
		return StyleManager :: getStyle();
	}

	/**
	 * @see WCF::initSession()
	 */
	protected function initSession()
	{
		// start session
		require_once(CP_DIR.'lib/system/session/CPSessionFactory.class.php');
		$factory = new CPSessionFactory();
		self::$sessionObj = $factory->get();
		self::$userObj = self::getSession()->getUser();
	}

	/**
	 * Initialises the page header menu.
	 */
	protected static function initPageMenu()
	{
		require_once (WCF_DIR . 'lib/page/util/menu/PageMenu.class.php');
		self :: $pageMenuObj= new PageMenu();

		if (PageMenu :: getActiveMenuItem() == '')
			PageMenu :: setActiveMenuItem('cp.header.menu.start');
	}

	/**
	 * Initialises the page header menu.
	 */
	protected static function initUserCPMenu()
	{
		require_once (WCF_DIR . 'lib/page/util/menu/UserCPMenu.class.php');
		self :: $userCPMenuObj= UserCPMenu :: getInstance();
	}

	/**
	 * @see WCF::getOptionsFilename()
	 */
	protected function getOptionsFilename()
	{
		return CP_DIR . 'options.inc.php';
	}

	/**
	 * @see HeaderMenuContainer::getHeaderMenu()
	 */
	public static final function getPageMenu()
	{
		if (self :: $pageMenuObj === null)
		{
			self :: initPageMenu();
		}

		return self :: $pageMenuObj;
	}

	/**
	 * @see UserCPMenuContainer::getUserCPMenu()
	 */
	public static final function getUserCPMenu()
	{
		if (self :: $userCPMenuObj === null)
		{
			self :: initUserCPMenu();
		}

		return self :: $userCPMenuObj;
	}
}
?>