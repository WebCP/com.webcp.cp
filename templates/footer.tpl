</div>
<div id="footerContainer">
	<div id="footer">
		{include file=footerMenu}
		<div id="footerOptions" class="footerOptions">
			<div class="footerOptionsInner">
				<ul>
					{if $additionalFooterOptions|isset}{@$additionalFooterOptions}{/if}
					<li id="toTopLink" class="last extraButton"><a href="#top" title="{lang}wcf.global.scrollUp{/lang}"><img src="{icon}upS.png{/icon}" alt="{lang}wcf.global.scrollUp{/lang}" /> <span class="hidden">{lang}wcf.global.scrollUp{/lang}</span></a></li>
				</ul>
			</div>
		</div>
		<p class="copyright">{lang}cp.global.copyright{/lang}</p>
	</div>
</div>