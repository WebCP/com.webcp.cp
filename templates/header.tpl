<div id="headerContainer">
	<a id="top"></a>
	<div id="userPanel" class="userPanel">
		<div class="userPanelInner">
			<p id="userNote">
				{if $this->user->userID != 0}{lang}cp.header.menu.user{/lang}{else}{lang}cp.header.menu.guest{/lang}{/if}
			</p>
			<div id="userMenu">
				<ul>
					{if $this->user->userID != 0}
						<li id="userMenuLogout"><a href="index.php?action=UserLogout&amp;t={@SECURITY_TOKEN}{@SID_ARG_2ND}"><img src="{icon}logoutS.png{/icon}" alt="" /> <span>{lang}cp.header.menu.logout{/lang}</span></a></li>
					{/if}
					<li id="userMenuLanguage" class="languagePicker options"><a id="changeLanguage" class="hidden"><img src="{icon}language{@$this->language->getLanguageCode()|ucfirst}S.png{/icon}" alt="" /> <span>{lang}cp.header.menu.changeLanguage{/lang}</span></a>
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
				</ul>
			</div>
		</div>
	</div>	
<div class="rahmen">
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
						<img src="{@RELATIVE_CP_DIR}images/cp-header-logo.png" title="{lang}{PAGE_TITLE}{/lang}" alt="" />
					</a>
				{/if}
			</div>
		</div>
	</div>
</div>
{* user messages system*}
{capture append=userMessages}
	{if $this->user->userID}
		
		{if SYSTEM_MESSAGE == 1}
			<div class="warning">
				{lang}cp.global.systemMessage{/lang}
				<p>{if SYSTEM_MESSAGE_ALLOW_HTML}{@SYSTEM_MESSAGE_TEXT}{else}{@SYSTEM_MESSAGE_TEXT|htmlspecialchars|nl2br}{/if}</p></p>
			</div>
		{/if}
		
		{if $updates|count > 0}
			<form method="post" action="acp/index.php">
				<div class="error" id="updates-content">
					<h3 class="subHeadline">{lang}cp.acp.index.updates{/lang}</h3>
					<p class="description">{lang}cp.acp.index.updates.description{/lang}</p>
					
					<ul>
						{foreach from=$updates item=update}
							<li{if $update.version.updateType == 'security'} class="formError"{/if}>
								{lang}cp.acp.index.updates.update{/lang}
							</li>
						{/foreach}
					</ul>
					
					<p><input type="submit" value="{lang}cp.acp.index.updates.startUpdate{/lang}" /></p>
				</div>
			</form>
		{/if}
		
	{/if}
	{if OFFLINE == 1 && $this->user->getPermission('user.cp.canViewOffline')}
		<div class="warning">
			{lang}cp.global.offline{/lang}
			<p>{if OFFLINE_MESSAGE_ALLOW_HTML}{@OFFLINE_MESSAGE}{else}{@OFFLINE_MESSAGE|htmlspecialchars|nl2br}{/if}</p>
		</div>
	{/if}
{/capture}
</div>
<div class="rahmen">
{if $this->user->userID}
<div id="navContainer">
{include file=headerMenu}
</div>
{/if}
<div id="mainContainer">
	
{if $additionalHeaderContents|isset}{@$additionalHeaderContents}{/if}
