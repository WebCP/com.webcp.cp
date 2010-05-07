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
				{if $this->user->userID != 0}{lang}cp.header.userNote.user{/lang}{else}{lang}cp.header.userNote.guest{/lang}{/if}
			</p>
			<div id="userMenu">
				<ul>
					{if $this->user->userID != 0}
						<li><a href="index.php?action=UserLogout&amp;t={@SECURITY_TOKEN}{@SID_ARG_2ND}"><img src="{icon}logoutS.png{/icon}" alt="" /> <span>{lang}cp.header.userMenu.logout{/lang}</span></a></li>
						<li><a href="index.php?form=UserProfileEdit{@SID_ARG_2ND}"><img src="{icon}editS.png{/icon}" alt="" /> <span>{lang}cp.header.userMenu.profile{/lang}</span></a></li>
						{if $additionalUserMenuItems|isset}{@$additionalUserMenuItems}{/if}
						
						{if $this->user->getPermission('admin.general.canUseAcp')}
							<li><a href="acp/index.php?packageID={@PACKAGE_ID}"><img src="{icon}acpS.png{/icon}" alt="" /> <span>{lang}cp.header.userMenu.acp{/lang}</span></a></li>
						{/if}
					{else}
						<li><a href="index.php?form=UserLogin{@SID_ARG_2ND}" id="loginButton"><img src="{icon}loginS.png{/icon}" alt="" id="loginButtonImage" /> <span>{lang}cp.header.userMenu.login{/lang}</span></a></li>
						
						{if !REGISTER_DISABLED}<li><a href="index.php?page=Register{@SID_ARG_2ND}"><img src="{icon}registerS.png{/icon}" alt="" /> <span>{lang}cp.header.userMenu.register{/lang}</span></a></li>{/if}
						
						{if $this->language->countAvailableLanguages() > 1}
							<li><a id="changeLanguage" class="hidden"><img src="{icon}language{@$this->language->getLanguageCode()|ucfirst}S.png{/icon}" alt="" /> <span>{lang}cp.header.userMenu.changeLanguage{/lang}</span></a>
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
	
	{if !$this->user->userID && !LOGIN_USE_CAPTCHA}
		<script type="text/javascript">
			//<![CDATA[
			document.observe("dom:loaded", function() {
				var loginFormVisible = false;
				
				var loginBox = $('quickLoginBox');
				var loginButton = $('loginButton');
				
				if (loginButton && loginBox) {
					loginBox.setStyle('left: ' + loginButton.cumulativeOffset()[0] + 'px; top: ' + (loginButton.cumulativeOffset()[1] + loginButton.getHeight() + 5) + 'px; display: none');
					loginBox.removeClassName('hidden');
				}
				
				function showLoginForm() {
					
					
					if (loginBox) {
						if (loginBox.visible()) {
							new Effect.Parallel([
								new Effect.BlindUp(loginBox, { duration: 0.3 }),
								new Effect.Fade(loginBox, { duration: 0.3 })
							], { duration: 0.3 });
							//loginBox.fade({ duration: 0.3 });
							loginFormVisible = false;
						}
						else {
							new Effect.Parallel([
								new Effect.BlindDown(loginBox, { duration: 0.3 }),
								new Effect.Appear(loginBox, { duration: 0.3 })
							], { duration: 0.3 });
							//loginBox.appear({ duration: 0.3 });
							loginFormVisible = true;
						}
					}
					
					return false;
				}
				
				document.getElementById('loginButton').onclick = function() { return showLoginForm(); };
				document.getElementById('loginButton').ondblclick = function() { document.location.href = fixURL('index.php?form=UserLogin{@SID_ARG_2ND_NOT_ENCODED}'); };
				document.getElementById('quickLoginUsername').onfocus = function() { if (this.value == '{lang}wcf.user.username{/lang}') this.value=''; };
				document.getElementById('quickLoginUsername').onblur = function() { if (this.value == '') this.value = '{lang}wcf.user.username{/lang}'; };
				document.getElementById('loginButtonImage').src = document.getElementById('loginButtonImage').src.replace(/loginS\.png/, 'loginOptionsS.png');
			});
			//]]>
		</script>
	{/if}
	
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
	{if OFFLINE == 1 && $this->user->getPermission('user.cp.canViewDLDBOffline')}
		<div class="warning">
			{lang}cp.global.offline{/lang}
			<p>{if OFFLINE_MESSAGE_ALLOW_HTML}{@OFFLINE_MESSAGE}{else}{@OFFLINE_MESSAGE|htmlspecialchars|nl2br}{/if}</p>
		</div>
	{/if}
{/capture}
</div>
<div id="mainContainer">
{if $additionalHeaderContents|isset}{@$additionalHeaderContents}{/if}