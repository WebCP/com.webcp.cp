{include file='header'}
<script type="text/javascript" src="{@RELATIVE_WCF_DIR}js/MultiPagesLinks.class.js"></script>

<div class="mainHeadline">
	<img src="{@RELATIVE_WCF_DIR}icon/cronjobsL.png" alt="" />
	<div class="headlineContainer">
		<h2>{lang}cp.acp.jobhandler.list{/lang}</h2>
		<p>{lang}cp.acp.jobhandler.lastRun{/lang}</p>
	</div>
</div>

<div class="contentHeader">
	{pages print=true assign=pagesLinks link="index.php?page=JobhandlerList&pageNo=%d&sortField=$sortField&sortOrder=$sortOrder"|concat:SID_ARG_2ND_NOT_ENCODED}
</div>

<div class="border titleBarPanel">
	<div class="containerHead"><h3>{lang}cp.acp.jobhandler.list.count{/lang}</h3></div>
</div>
<div class="border borderMarginRemove">
	<table class="tableList">
		<thead>
			<tr class="tableHead">
				<th class="columnJobhandlerName{if $sortField == 'jobhandlerName'} active{/if}"><div><a href="index.php?page=JobhandlerList&amp;pageNo={@$pageNo}&amp;sortField=jobhandlerName&amp;sortOrder={if $sortField == 'jobhandlerName' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{@SID_ARG_2ND}">{lang}cp.acp.jobhandler.jobhandlerName{/lang}{if $sortField == 'jobhandlerName'} <img src="{@RELATIVE_WCF_DIR}icon/sort{@$sortOrder}S.png" alt="" />{/if}</a></div></th>
				<th class="columnJobhandlerFile{if $sortField == 'jobhandlerFile'} active{/if}"><div><a href="index.php?page=JobhandlerList&amp;pageNo={@$pageNo}&amp;sortField=jobhandlerFile&amp;sortOrder={if $sortField == 'jobhandlerFile' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{@SID_ARG_2ND}">{lang}wcf.acp.cronjobs.startMinuteShort{/lang}{if $sortField == 'jobhandlerFile'} <img src="{@RELATIVE_WCF_DIR}icon/sort{@$sortOrder}S.png" alt="" />{/if}</a></div></th>
				<th class="columnJobhandlerDescription{if $sortField == 'jobhandlerDescription'} active{/if}"><div><a href="index.php?page=JobhandlerList&amp;pageNo={@$pageNo}&amp;sortField=jobhandlerDescription&amp;sortOrder={if $sortField == 'jobhandlerDescription' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{@SID_ARG_2ND}">{lang}wcf.acp.cronjobs.startHourShort{/lang}{if $sortField == 'jobhandlerDescription'} <img src="{@RELATIVE_WCF_DIR}icon/sort{@$sortOrder}S.png" alt="" />{/if}</a></div></th>
				
				{if $additionalColumns|isset}{@$additionalColumns}{/if}
			</tr>
		</thead>
		<tbody>
		{foreach from=$jobhandler item=jh}
			<tr class="{cycle values="container-1,container-2"}">
				<td class="columnJobhandlerName">{$jh.jobhandlerName}</td>
				<td class="columnJobhandlerFile">{$jh.jobhandlerFile}</td>
				<td class="columnJobhandlerDescription">{$jh.jobhandlerDescription|nl2br}</td>
				
				{if $jh.additionalColumns|isset}{@$jh.additionalColumns}{/if}
			</tr>
		{/foreach}
		</tbody>
	</table>
</div>

<div class="contentFooter">
	{@$pagesLinks}	
</div>

{include file='footer'}