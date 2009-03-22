{include file="documentHeader"}
<head>
	<title>{lang}cp.index.title{/lang} - {PAGE_TITLE}</title>

	{include file='headInclude' sandbox=false}
</head>
<body>
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

</div>

{include file='footer' sandbox=false}

</body>
</html>