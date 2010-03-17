				<fieldset>
					<legend>{lang}cp.user.general{/lang}</legend>
					{if $this->user->getPermission('admin.general.isSuperAdmin')}
					<div class="formElement{if $errorType.adminname|isset} formError{/if}">
						<div class="formFieldLabel">
							<label for="adminname">{lang}cp.user.adminname{/lang}</label>
						</div>
						<div class="formField">
							<input type="text" class="inputText" id="adminname" name="adminname" value="{$adminname}" />
							<script type="text/javascript" src="{@RELATIVE_WCF_DIR}js/Suggestion.class.js"></script>
							<script type="text/javascript">
								//<![CDATA[
								suggestion.setSource('index.php?page=AdminSuggest{@SID_ARG_2ND_NOT_ENCODED}');
								suggestion.enableIcon(true);
								suggestion.init('adminname');
								//]]>
							</script>
							
							{if $errorType.adminname|isset}
								<p class="innerError">
									{if $errorType.adminname == 'empty'}{lang}wcf.global.error.empty{/lang}{/if}
									{if $errorType.adminname == 'notValid'}{lang}cp.global.invalidAdmin{/lang}{/if}
								</p>
							{/if}
						</div>
						<div class="formFieldDesc hidden" id="adminnameHelpMessage">
							<p>{lang}cp.user.adminname.description{/lang}</p>
						</div>
					</div>
					<script type="text/javascript">//<![CDATA[
						inlineHelp.register('adminname');
					//]]></script>
				
					{/if}
					<div class="formElement{if $errorType.isCustomer|isset} formError{/if}">
						<div class="formFieldLabel">
							<label for="isCustomer">{lang}cp.user.isCustomer{/lang}</label>
						</div>
						<div class="formField">
							<input type="checkbox" class="inputText" id="isCustomer" name="isCustomer" value="1" {if $isCustomer}checked="checked" {/if}/>
						</div>
						<div class="formFieldDesc hidden" id="isCustomerHelpMessage">
							<p>{lang}cp.user.isCustomer.description{/lang}</p>
						</div>
					</div>
					<script type="text/javascript">//<![CDATA[
						inlineHelp.register('isCustomer');
					//]]></script>
				</fieldset>