# dot source all script files
Get-ChildItem -Path "$PSScriptRoot\functions" -Recurse -File -Filter '*.ps1' | ForEach-Object {
	. $_.FullName

	# Export all functions except internal
	if ($_.FullName -notlike '*\internal\*') {
		Export-ModuleMember $_.BaseName
	}
}

if(Test-PSCore){
	$libsDirectory = "$PSScriptRoot\lib\netstandard20"	
}
else{
	$libsDirectory = "$PSScriptRoot\lib\net461"
}

# Load all package dlls
try {
	foreach ($path in (Get-ChildItem $libsDirectory | Where-Object { $_.Name -like '*.dll' } | Select-Object -ExpandProperty FullName)){
		Add-Type -Path $path -ErrorAction Stop
	}
}
catch {
	Write-Error $_.Exception
}