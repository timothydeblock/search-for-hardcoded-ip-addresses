$FilesOfInterest = (
	"*.ini","*.txt","*.config","*.bat","*.cmd","*.ps1",
	"*.psm1","*.hta","*.vbs","*.wsf","*.xml","*.cfg",
	"*.json","*.py","*.pl","*.website","*.prefs","*.lua",
	"*.js","*.htm","*.html","*.url"
)

$pattern = "(?:(?:1\d\d|2[0-5][0-5]|2[0-4]\d|0?[1-9]\d|0?0?\d)\.){3}(?:1\d\d|2[0-5][0-5]|2[0-4]\d|0?[1-9]\d|0?0?\d)"
# Simplier regex (172\.\d+\.\d+\.\d+)

function FindFilesWithContent($Input_Path, $Include, $Pattern){
	# recursively search for all files match the $searchExtensions list;
	# force the search and suppress standard access errors.
	try{
        $input_path = 'C:\ps\'
		Get-ChildItem -Path:$input_path -Include:$Include `
			-Recurse -Force -ErrorAction:SilentlyContinue |
			?{!$_.PSIsContainer} |
		ForEach-Object{
			Write-Progress $_.FullName;
			$item = $_;
			Get-Content $_ -ErrorAction SilentlyContinue |
			ForEach-Object {
				if($_ -match $Pattern){
					#create synthetic type - there are better ways
					"" | select filename,match | %{
						$_.filename = $item.FullName;
						$_.match = $matches[0]; #fill value
						return $_ #emit it to pipeline
					}
				}
	
			}
		}
	}
	catch{
		## generally suppressing errors likely to occur with volatile files in user paths
	}
}

#$env:homedrive\$env:homepath
#$env:appdata
FindFilesWithContent -Root $env:homedrive\$env:homepath -Include $FilesOfInterest -Pattern $pattern | Export-Csv C:\ps\extracted_ip_addresses.csv