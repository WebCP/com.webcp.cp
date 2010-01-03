{if $additionalFooterContents|isset}{@$additionalFooterContents}{/if}
</div>
<div id="footerContainer">
	<div id="footer">
		{include file=footerMenu}
		<div id="footerOptions" class="footerOptions">
			<div class="footerOptionsInner">
				<ul>
					{if $additionalFooterOptions|isset}{@$additionalFooterOptions}{/if}
					{if SHOW_CLOCK}<li id="date" class="date" title="{@TIME_NOW|fulldate} UTC{if $timezone > 0}+{@$timezone}{else if $timezone < 0}{@$timezone}{/if}"><img src="{icon}dateS.png{/icon}" alt="" /> <span>{@TIME_NOW|fulldate}</span></li>{/if}
					<li id="toTopLink" class="last extraButton"><a href="#top" title="{lang}wcf.global.scrollUp{/lang}"><img src="{icon}upS.png{/icon}" alt="{lang}wcf.global.scrollUp{/lang}" /> <span class="hidden">{lang}wcf.global.scrollUp{/lang}</span></a></li>
				</ul>
			</div>
		</div>
		<p class="copyright">
			{lang}cp.global.copyright{/lang}
					{if SHOW_CLOCK}<li id="date" class="date" title="{@TIME_NOW|fulldate} UTC{if $timezone > 0}+{@$timezone}{else if $timezone < 0}{@$timezone}{/if}"><img src="{icon}dateS.png{/icon}" alt="" /> <span>{@TIME_NOW|fulldate}</span></li>{/if}
		</p>
	</div>
</div>
{if !$this->user->userID && !LOGIN_USE_CAPTCHA}
	<div class="border loginPopup hidden" id="quickLoginBox">
		<form method="post" action="index.php?form=UserLogin" class="container-1">
			<div>
				<input tabindex="1" type="text" class="inputText" id="quickLoginUsername" name="loginUsername" value="{lang}wcf.user.username{/lang}" title="{lang}wcf.user.username{/lang}" />
				<input tabindex="2" type="password" class="inputText" name="loginPassword" value="" title="{lang}wcf.user.password{/lang}" />
				{if $this->session->requestMethod == "GET"}<input type="hidden" name="url" value="{$this->session->requestURI}" />{/if}
				{@SID_INPUT_TAG}
				<input tabindex="4" type="image" class="inputImage" src="{icon}submitS.png{/icon}" alt="{lang}wcf.global.button.submit{/lang}" />
			</div>
			<p><label><input tabindex="3" type="checkbox" id="useCookies" name="useCookies" value="1" /> {lang}dldb.header.login.useCookies{/lang}</label></p>
		</form>
	</div>
{/if}