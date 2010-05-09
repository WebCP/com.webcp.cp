{include file="documentHeader"}
<head>
	<title>{lang}cp.header.menu.start{/lang} - {PAGE_TITLE}</title>

	{include file='headInclude' sandbox=false}
</head>
<body{if $templateName|isset} id="tpl{$templateName|ucfirst}"{/if}>
{include file='header' sandbox=false}

<div id="main">

	<div class="mainHeadline">
		<img src="{@RELATIVE_CP_DIR}icon/indexL.png" alt="" />
		<div class="headlineContainer">
			<h2>{PAGE_TITLE}</h2>
			<p>{PAGE_DESCRIPTION}</p>
		</div>
	</div>

	{if $userMessages|isset}{@$userMessages}{/if}

	<table class="tableList">
		<thead>
			<tr class="tableHead">
				<td colspan="2">{lang}cp.index.address{/lang}</td>
			<tr>
		</thead>
		<tbody>
			<tr class="container-1">
				<td>{lang}wcf.user.name{/lang}</td>
				<td>{$this->user->title} {$this->user->firstname} {$this->user->lastname}</td>
			</tr>
			<tr class="container-2">
				<td>{lang}wcf.user.option.company{/lang}</td>
				<td>{$this->user->company}</td>
			</tr>
			<tr class="container-1">
				<td>{lang}wcf.user.option.street{/lang}</td>
				<td>{$this->user->street}</td>
			</tr>
			<tr class="container-2">
				<td>{lang}wcf.user.option.zipCode{/lang} {lang}wcf.user.option.city{/lang}</td>
				<td>{$this->user->zipCode} {$this->user->city}</td>
			</tr>
			<tr class="container-1">
				<td>{lang}wcf.user.email{/lang}</td>
				<td>{$this->user->email}</td>
			</tr>
			<tr class="container-2">
				<td>{lang}wcf.user.option.customerID{/lang}</td>
				<td>{$this->user->customerID}</td>
			</tr>
		</tbody>
	</table>
	<br /><br />
	<table class="tableList">
		<thead>
			<tr class="tableHead">
				<td colspan="2">{lang}cp.index.account{/lang}</td>
			<tr>
		</thead>
		<tbody>
			<tr class="container-1">
				<td>{lang}wcf.user.username{/lang}</td>
				<td>{$this->user->username}</td>
			</tr>
			{foreach from=$displayData key=desc item=item}
				<tr class="container-{cycle values='2,1'}">
					<td>{lang}{$desc}{/lang}</td>
					<td>{@$item}</td>
				</tr>
			{/foreach}
		</tbody>
	</table>

</div>

{include file='footer' sandbox=false}

</body>
</html>