{if !$this->user->userID && !LOGIN_USE_CAPTCHA}
	{counter name='tabindex' start=4 print=false}
{else}
	{counter name='tabindex' start=0 print=false}
{/if}
<div id="headerContainer">
	<a id="top"></a>
	<div id="userPanel" class="userPanel">
		<div class="userPanelInner">
			<p id="userNote"> 
				{if $this->user->userID != 0}{lang}wbb.header.userNote.user{/lang}{else}{lang}wbb.header.userNote.guest{/lang}{/if}
			</p>
			<div id="userMenu">
				<ul>
					{if $this->user->userID != 0}
						<li><a href="index.php?action=UserLogout&amp;t={@SECURITY_TOKEN}{@SID_ARG_2ND}"><img src="{icon}logoutS.png{/icon}" alt="" /> <span>{lang}wbb.header.userMenu.logout{/lang}</span></a></li>
						<li><a href="index.php?form=UserProfileEdit{@SID_ARG_2ND}"><img src="{icon}editS.png{/icon}" alt="" /> <span>{lang}wbb.header.userMenu.profile{/lang}</span></a></li>
						
						{if $additionalUserMenuItems|isset}{@$additionalUserMenuItems}{/if}
						
						{if $this->user->getPermission('admin.general.canUseAcp')}
							<li><a href="acp/index.php?packageID={@PACKAGE_ID}"><img src="{icon}acpS.png{/icon}" alt="" /> <span>{lang}wbb.header.userMenu.acp{/lang}</span></a></li>
						{/if}
					{else}
						{if $this->language->countAvailableLanguages() > 1}
							<li><a id="changeLanguage" class="hidden"><img src="{icon}language{@$this->language->getLanguageCode()|ucfirst}S.png{/icon}" alt="" /> <span>{lang}wbb.header.userMenu.changeLanguage{/lang}</span></a>
								<div class="hidden" id="changeLanguageMenu">
									<ul>
										{foreach from=$this->language->getAvailableLanguageCodes() item=guestLanguageCode key=guestLanguageID}
											<li{if $guestLanguageID == $this->language->getLanguageID()} class="active"{/if}><a rel="nofollow" href="{if $this->session->requestURI && $this->session->requestMethod == 'GET'}{$this->session->requestURI}{if $this->session->requestURI|strpos:'?'}&amp;{else}?{/if}{else}index.php?{/if}l={$guestLanguageID}{@SID_ARG_2ND}"><img src="{icon}language{@$guestLanguageCode|ucfirst}S.png{/icon}" alt="" /> <span>{lang}wcf.global.language.{@$guestLanguageCode}{/lang}</span></a></li>
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
											<label><img src="{icon}language{@$this->language->getLanguageCode()|ucfirst}S.png{/icon}" alt="" />
												<select name="l" onchange="this.form.submit()">
													{htmloptions options=$this->language->getLanguages() selected=$this->language->getLanguageID() disableEncoding=true}
												</select>
											</label>
											{@SID_INPUT_TAG}
											<input type="image" class="inputImage" src="{icon}submitS.png{/icon}" alt="{lang}wcf.global.button.submit{/lang}" />
										</div>
									</form>
								</noscript>
							</li>
						{/if}
					{/if}
				</ul>
			</div>
		</div>
	</div>
	
	<div id="header">
		<div id="logo">
			<div class="logoInner">
				<h1 class="pageTitle"><a href="index.php?page=Index{@SID_ARG_2ND}">{lang}{PAGE_TITLE}{/lang}</a></h1>
				{if $this->getStyle()->getVariable('page.logo.image')}
					<a href="index.php?page=Index{@SID_ARG_2ND}" class="pageLogo">
						<img src="{$this->getStyle()->getVariable('page.logo.image')}" title="{lang}{PAGE_TITLE}{/lang}" alt="" />
					</a>
				{elseif $this->getStyle()->getVariable('page.logo.image.application.use') == 1}
					<a href="index.php?page=Index{@SID_ARG_2ND}" class="pageLogo">
						<img src="{@RELATIVE_WBB_DIR}images/wbb3-header-logo.png" title="{lang}{PAGE_TITLE}{/lang}" alt="" />
					</a>
				{/if}
			</div>
		</div>
	</div>
	
	{include file=headerMenu}
	
{* user messages system*}
{capture append=userMessages}
	{if $this->user->userID}
		
		{if SYSTEM_MESSAGE == 1}
			<div class="warning">
				{lang}cp.global.systemMessage{/lang}
				<p>{if SYSTEM_MESSAGE_ALLOW_HTML}{@SYSTEM_MESSAGE_TEXT}{else}{@SYSTEM_MESSAGE_TEXT|htmlspecialchars|nl2br}{/if}</p></p>
			</div>
		{/if}
		
	{/if}
{/capture}
</div>
<div id="mainContainer">