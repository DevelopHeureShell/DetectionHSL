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
        $exename = "hsl10n"
        if(Test-Path "C:\Windows\System32") {
            $exename = "${exename}.exe"
        }
        & "${PSScriptRoot}\..\..\bin\${exename}" --file $filepath --msg $msg;
    }
}
Export-ModuleMember Get-LangMessage;