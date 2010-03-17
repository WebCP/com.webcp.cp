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
		</p>
	</div>
</div>