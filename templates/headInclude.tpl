<meta http-equiv="content-type" content="text/html; charset={@CHARSET}" />
<meta http-equiv="content-script-type" content="text/javascript" />
<meta http-equiv="content-style-type" content="text/css" />
<meta name="description" content="{META_DESCRIPTION}" />
<meta name="keywords" content="{META_KEYWORDS}" />
<meta name="robots" content="noindex,nofollow" />

<!-- dynamic styles -->
<link rel="stylesheet" type="text/css" media="screen" href="{@RELATIVE_WCF_DIR}style/style-{@$this->getStyle()->styleID}.css" />

<script type="text/javascript">
	//<![CDATA[
	var SID_ARG_2ND	= '{@SID_ARG_2ND_NOT_ENCODED}';
	var RELATIVE_WCF_DIR = '{@RELATIVE_WCF_DIR}';
	var RELATIVE_CP_DIR = '{@RELATIVE_CP_DIR}';
	//]]>
</script>

<!-- hack styles -->
<!--[if lt IE 7]>
	<link rel="stylesheet" type="text/css" media="screen" href="{@RELATIVE_WCF_DIR}style/extra/ie6-fix.css" />
	<style type="text/css">
		{if !$this->getStyle()->getVariable('page.width')}
			#page { /* note: non-standard style-declaration */
				_width: expression(((document.body.clientWidth/screen.width)) < 0.7 ? "{$this->getStyle()->getVariable('page.width.min')}":"{$this->getStyle()->getVariable('page.width.max')}" );
			}
		{/if}
	</style>
<![endif]-->

<!--[if IE 7]>
	<link rel="stylesheet" type="text/css" media="screen" href="{@RELATIVE_WCF_DIR}style/extra/ie7-fix.css" />
<![endif]-->

{if $this->getStyle()->getVariable('global.favicon')}<link rel="shortcut icon" href="{@RELATIVE_WCF_DIR}icon/favicon/favicon{$this->getStyle()->getVariable('global.favicon')|ucfirst}.ico" type="image/x-icon" />{/if}

<script type="text/javascript" src="{@RELATIVE_WCF_DIR}js/default.js"></script>