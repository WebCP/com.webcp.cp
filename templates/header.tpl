<div id="page">
	<a id="top"></a>

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