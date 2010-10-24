{include file='header'}
<script type="text/javascript" src="{@RELATIVE_WCF_DIR}js/Suggestion.class.js"></script>
<script type="text/javascript" src="{@RELATIVE_WCF_DIR}js/TabMenu.class.js"></script>
<script type="text/javascript">
	//<![CDATA[
	var tabMenu = new TabMenu();
	onloadEvents.push(function() { tabMenu.showSubTabMenu('{if $updates|count > 0}updates{elseif $news|count > 0}news{else}credits{/if}') });
	//]]>
</script>

<div class="mainHeadline">
	<img src="{@RELATIVE_WCF_DIR}icon/acpL.png" alt="" />
	<div class="headlineContainer">
		<h2>{lang}cp.acp.index{/lang}</h2>
	</div>
</div>


{if $additionalFields|isset}{@$additionalFields}{/if}

<div class="tabMenu">
	<ul>
		{if $updates|count > 0}<li id="updates"><a href="javascript: void(0);" onclick="tabMenu.showSubTabMenu('updates');"><span>{lang}cp.acp.index.updates{/lang}</span></a></li>{/if}
		{if $news|count > 0}<li id="news"><a onclick="tabMenu.showSubTabMenu('news');"><span>{lang}cp.acp.index.news{/lang}</span></a></li>{/if}
		<li id="credits"><a href="javascript: void(0);" onclick="tabMenu.showSubTabMenu('credits');"><span>{lang}cp.acp.index.credits{/lang}</span></a></li>
		{if $additionalTabs|isset}{@$additionalTabs}{/if}
	</ul>
</div>
<div class="subTabMenu">
	<div class="containerHead"><div> </div></div>
</div>

{if $updates|count > 0}
	<form method="post" action="index.php?form=PackageUpdate">
		<div class="border tabMenuContent hidden" id="updates-content">
			<div class="container-1">
				<h3 class="subHeadline">{lang}cp.acp.index.updates{/lang}</h3>
				<p class="description">{lang}cp.acp.index.updates.description{/lang}</p>
				
				<ul>
					{foreach from=$updates item=update}
						<li{if $update.version.updateType == 'security'} class="formError"{/if}>
							{lang}cp.acp.index.updates.update{/lang}
							<input type="hidden" name="updates[{@$update.packageID}]" value="{$update.version.packageVersion}" />
						</li>
					{/foreach}
				</ul>
				
				<p><input type="submit" value="{lang}cp.acp.index.updates.startUpdate{/lang}" /></p>
				<input type="hidden" name="packageID" value="{@PACKAGE_ID}" />
				{@SID_INPUT_TAG}
			</div>
		</div>
	</form>
{/if}

{if $news|count > 0}
	<div class="border tabMenuContent hidden" id="news-content">
		<div class="container-1">
			<h3 class="subHeadline">{lang}cp.acp.index.news{/lang}</h3>
			
			{foreach from=$news item=newsItem}
				{*<div>
					<p class="smallFont">{if $newsItem.author}{$newsItem.author} | {/if}{@$newsItem.pubDate|time}</p>
					<h4><a href="{@RELATIVE_WCF_DIR}acp/dereferrer.php?url={$newsItem.link|rawurlencode}" class="externalURL">{@$newsItem.title}</a></h4>
					
					{@$newsItem.description}
				</div>*}
				<div class="message content">
					<div class="messageInner container-{cycle name='results' values='1,2'}">
						<p class="light smallFont">{if $newsItem.author}{$newsItem.author} - {/if}{@$newsItem.pubDate|time}</p>
						<h4><a href="{@RELATIVE_WCF_DIR}acp/dereferrer.php?url={$newsItem.link|rawurlencode}" class="externalURL">{@$newsItem.title}</a></h4>

						<div class="messageBody">
							{@$newsItem.description}
						</div>
						<hr />
					</div>
				</div>
			{/foreach}
		</div>
	</div>
{/if}

<div class="border tabMenuContent hidden" id="credits-content">
	<div class="container-1">
		<h3 class="subHeadline">{lang}cp.acp.index.credits{/lang}</h3>

		<div class="formElement">
			<p class="formFieldLabel">{lang}cp.acp.index.credits.developedBy{/lang}</p>
			<p class="formField">Toby</p>
		</div>

		<div class="formElement">
			<p class="formFieldLabel">{lang}cp.acp.index.credits.developer{/lang}</p>
			<p class="formField">Toby</p>
		</div>

		<div class="formElement">
			<p class="formFieldLabel">{lang}cp.acp.index.credits.designer{/lang}</p>
			<p class="formField">Toby</p>
		</div>

		<div class="formElement">
			<p class="formFieldLabel">{lang}cp.acp.index.credits.translators{/lang}</p>
			<p class="formField">Panther</p>
		</div>
	</div>
</div>

{if $additionalTabContents|isset}{@$additionalTabContents}{/if}

{include file='footer'}
