{include file='header'}
<script type="text/javascript" src="{@RELATIVE_WCF_DIR}js/MultiPagesLinks.class.js"></script>

<div class="mainHeadline">
	<img src="{@RELATIVE_WCF_DIR}icon/cronjobsL.png" alt="" />
	<div class="headlineContainer">
		<h2>{lang}cp.acp.jobhandlertask.list{/lang}</h2>
		<p>{lang}cp.acp.jobhandler.lastRun{/lang}</p>
	</div>
</div>

<div class="contentHeader">
	{pages print=true assign=pagesLinks link="index.php?page=JobhandlerTaskList&pageNo=%d&sortField=$sortField&sortOrder=$sortOrder"|concat:SID_ARG_2ND_NOT_ENCODED}
</div>

<div class="border titleBarPanel">
	<div class="containerHead"><h3>{lang}cp.acp.jobhandlertask.list.count{/lang}</h3></div>
</div>
<div class="border borderMarginRemove">
	<table class="tableList">
		<thead>
			<tr class="tableHead">
				<th class="columnJobhandlerTaskID{if $sortField == 'jobhandlerTaskID'} active{/if}"><div><a href="index.php?page=JobhandlerTaskList&amp;pageNo={@$pageNo}&amp;sortField=jobhandlerTaskID&amp;sortOrder={if $sortField == 'jobhandlerTaskID' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{@SID_ARG_2ND}">{lang}cp.acp.jobhandler.jobhandlerTaskID{/lang}{if $sortField == 'jobhandlerTaskID'} <img src="{@RELATIVE_WCF_DIR}icon/sort{@$sortOrder}S.png" alt="" />{/if}</a></div></th>
				<th class="columnJobhandler{if $sortField == 'jobhandler'} active{/if}"><div><a href="index.php?page=JobhandlerTaskList&amp;pageNo={@$pageNo}&amp;sortField=jobhandler&amp;sortOrder={if $sortField == 'jobhandler' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{@SID_ARG_2ND}">{lang}cp.acp.jobhandler.jobhandler{/lang}{if $sortField == 'jobhandler'} <img src="{@RELATIVE_WCF_DIR}icon/sort{@$sortOrder}S.png" alt="" />{/if}</a></div></th>
				<th class="columnLastExec{if $sortField == 'lastExec'} active{/if}"><div><a href="index.php?page=JobhandlerTaskList&amp;pageNo={@$pageNo}&amp;sortField=lastExec&amp;sortOrder={if $sortField == 'lastExec' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{@SID_ARG_2ND}">{lang}cp.acp.jobhandler.lastExec{/lang}{if $sortField == 'lastExec'} <img src="{@RELATIVE_WCF_DIR}icon/sort{@$sortOrder}S.png" alt="" />{/if}</a></div></th>
				<th class="columnNextExec{if $sortField == 'nextExec'} active{/if}"><div><a href="index.php?page=JobhandlerTaskList&amp;pageNo={@$pageNo}&amp;sortField=nextExec&amp;sortOrder={if $sortField == 'nextExec' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{@SID_ARG_2ND}">{lang}cp.acp.jobhandler.nextExec{/lang}{if $sortField == 'nextExec'} <img src="{@RELATIVE_WCF_DIR}icon/sort{@$sortOrder}S.png" alt="" />{/if}</a></div></th>
				<th class="columnVolatile{if $sortField == 'volatile'} active{/if}"><div><a href="index.php?page=JobhandlerTaskList&amp;pageNo={@$pageNo}&amp;sortField=volatile&amp;sortOrder={if $sortField == 'volatile' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{@SID_ARG_2ND}">{lang}cp.acp.jobhandler.volatile{/lang}{if $sortField == 'volatile'} <img src="{@RELATIVE_WCF_DIR}icon/sort{@$sortOrder}S.png" alt="" />{/if}</a></div></th>
				<th class="columnData{if $sortField == 'data'} active{/if}"><div><a href="index.php?page=JobhandlerTaskList&amp;pageNo={@$pageNo}&amp;sortField=data&amp;sortOrder={if $sortField == 'data' && $sortOrder == 'ASC'}DESC{else}ASC{/if}{@SID_ARG_2ND}">{lang}cp.acp.jobhandler.data{/lang}{if $sortField == 'data'} <img src="{@RELATIVE_WCF_DIR}icon/sort{@$sortOrder}S.png" alt="" />{/if}</a></div></th>
				
				{if $additionalColumns|isset}{@$additionalColumns}{/if}
			</tr>
		</thead>
		<tbody>
		{foreach from=$jobhandler item=jh}
			<tr class="{cycle values="container-1,container-2"}">
				<td class="columnJobhandlerTaskID">{@$jh.jobhandlerTaskID}</td>
				<td class="columnJobhandler">{@$jh.jobhandler}</td>
				<td class="columnLastExec columnDate">
					{if $jh.lastExec != 0}
						{@$jh.lastExec|shorttime}
					{/if}
				</td>
				<td class="columnNextExec">{lang}cp.acp.jobhandler.nextExec.{$jh.nextExec}{/lang}</td>
				<td class="columnVolatile">
					{if $jh.volatile == 1}
						{lang}cp.global.yes{/lang}
					{else}
						{lang}cp.global.no{/lang}
					{/if}
				</td>
				<td class="columnData">{$jh.data|truncate:50:' ...'}</td>

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