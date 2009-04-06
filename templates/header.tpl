<div id="page">
	<a id="top"></a>
	<div id="userPanel" class="userPanel">
		<p id="userNote">
			{if $this->user->userID != 0}{lang}cp.header.userNote.user{/lang}{else}{lang}cp.header.userNote.guest{/lang}{/if}
		</p>
		<div id="userMenu">
			<ul>
				{if $this->user->userID != 0}
					<li><a href="index.php?action=UserLogout&amp;t={@SECURITY_TOKEN}{@SID_ARG_2ND}"><img src="{@RELATIVE_WCF_DIR}icon/logoutS.png" alt="" /> <span>{lang}cp.header.userMenu.logout{/lang}</span></a></li>
					<li><a href="index.php?form=UserProfileEdit{@SID_ARG_2ND}"><img src="{@RELATIVE_WCF_DIR}icon/profileS.png" alt="" /> <span>{lang}cp.header.userMenu.profile{/lang}</span></a></li>
					{if $this->user->getPermission('admin.general.canUseAcp')}
						<li><a href="acp/index.php?packageID={@PACKAGE_ID}"><img src="{@RELATIVE_WCF_DIR}icon/acpS.png" alt="" /> <span>{lang}cp.header.userMenu.acp{/lang}</span></a></li>
					{/if}
				{else}
					{if $this->language->countAvailableLanguages() > 1}
						<li><a id="changeLanguage" class="hidden"><img src="{@RELATIVE_WCF_DIR}icon/language{@$this->language->getLanguageCode()|ucfirst}S.png" alt="" /> <span>{lang}cp.header.userMenu.changeLanguage{/lang}</span></a>
							<div class="hidden" id="changeLanguageMenu">
								<ul>
									{foreach from=$this->language->getAvailableLanguageCodes() item=guestLanguageCode key=guestLanguageID}
										<li{if $guestLanguageID == $this->language->getLanguageID()} class="active"{/if}><a rel="nofollow" href="{if $this->session->requestURI && $this->session->requestMethod == 'GET'}{$this->session->requestURI}{if $this->session->requestURI|strpos:'?'}&amp;{else}?{/if}{else}index.php?{/if}l={$guestLanguageID}{@SID_ARG_2ND}"><img src="{@RELATIVE_WCF_DIR}icon/language{@$guestLanguageCode|ucfirst}S.png" alt="" /> <span>{lang}wcf.global.language.{@$guestLanguageCode}{/lang}</span></a></li>
									{/foreach}
								</ul>
							</div>
							<script type="text/javascript">
								//<![CDATA[
								onloadEvents.push(function() { document.getElementById('changeLanguage').className=''; });
								popupMenuList.register('changeLanguage');
								//]]>
							</script>
							<noscript>
								<form method="get" action="index.php">
									<div>
										<label><img src="{@RELATIVE_WCF_DIR}icon/language{@$this->language->getLanguageCode()|ucfirst}S.png" alt="" />
											<select name="l" onchange="this.form.submit()">
												{htmloptions options=$this->language->getLanguages() selected=$this->language->getLanguageID() disableEncoding=true}
											</select>
										</label>
										{@SID_INPUT_TAG}
										<input type="image" class="inputImage" src="{@RELATIVE_WCF_DIR}icon/submitS.png" alt="{lang}wcf.global.button.submit{/lang}" />
									</div>
								</form>
							</noscript>
						</li>
					{/if}
				{/if}
			</ul>
		</div>
	</div>

	<div id="header" class="border">
		<div id="logo">
			<h1 class="pageTitle"><a href="index.php?page=Index{@SID_ARG_2ND}">{PAGE_TITLE}</a></h1>
			{if $this->getStyle()->getVariable('page.logo.image')}
				<a href="index.php?page=Index{@SID_ARG_2ND}" class="pageLogo">
					<img src="{$this->getStyle()->getVariable('page.logo.image')}" title="{PAGE_TITLE}" alt="" />
				</a>
			{/if}
		</div>

		{include file=headerMenu}
	</div>

{* user messages system*}
{capture append=userMessages}
	{if $this->user->userID}

		{if $this->user->activationCode && REGISTER_ACTIVATION_METHOD == 1}<p class="warning">{lang}wcf.user.register.needsActivation{/lang}</p>{/if}

		{if $this->user->showPmPopup && $this->user->pmOutstandingNotifications && $this->user->getOutstandingNotifications()|count > 0}
			<div class="info" id="pmOutstandingNotifications">
				<a href="index.php?page=PM&amp;action=disableNotifications{@SID_ARG_2ND}" onclick="return (((new AjaxRequest()).openGet(this.href + '&ajax=1') && (document.getElementById('pmOutstandingNotifications').style.display = 'none')) ? false : false)" class="close"><img src="{@RELATIVE_WCF_DIR}icon/pmCancelS.png" alt="" title="{lang}wcf.pm.notification.cancel{/lang}" /></a>
				<p>{lang}wcf.pm.notification.report{/lang}</p>
				<ul>
					{foreach from=$this->user->getOutstandingNotifications() item=outstandingNotification}
						<li>
							<a href="index.php?page=PMView&amp;pmID={@$outstandingNotification->pmID}{@SID_ARG_2ND}#pm{@$outstandingNotification->pmID}">{$outstandingNotification->subject}</a> {lang}wcf.pm.messageFrom{/lang} <a href="index.php?page=User&amp;userID={@$outstandingNotification->userID}{@SID_ARG_2ND}">{$outstandingNotification->username}</a>
						</li>
					{/foreach}
				</ul>
			</div>
		{/if}
	{/if}
{/capture}