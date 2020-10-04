function Get-LangMessage {
    param(
        [string]$modname,
        [string]$lang,
        [string]$msg
    )
    $filepath = "${PSScriptRoot}/../l10n/${modname}/${lang}.yaml"
    if(!(Test-Path $filepath)) {
        $filepath = "${PSScriptRoot}/../l10n/${modname}/en.yaml"
    }
    if((Test-path "${PSScriptroot}\..\..\")){
        & "${PSScriptRoot}\..\..\bin\hsl10n.exe" --file $filepath --msg $msg;
    }
}
Export-ModuleMember Get-LangMessage;