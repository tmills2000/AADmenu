currMenu = 0;$menuSelector = 0;
$email = $env:USERNAME + "@clydeinc.com";

class Menu {
	[String[]]$options 
	[String]$menuName

	## Constructor with array argument. ##
	## Need to change this so that the Main Menu doesn't have a back option ##
	Menu ([String]$name, [String[]]$optionList) {
		$this.options = @(foreach ($option in $optionList) {$option},'Back','Quit')
		$this.menuName = $name
	}
	

	[void] PrintMenu() {
		$i = 0
		Write-Host $this.menuName
		Write-Host "---------------"
		foreach ($option in $this.options) {
			Write-Host $option -NoNewline
			## Format so the options line up ##
			Write-Host " [ "$i"  ]" 
			$i++
		}
	}
}

## Need to create a session class for these two ##
## I think that would be better than having functions ##
function Establish-Connection {
	Connect-AzureAD -AccountID $email | Out-Null
	$connected = $true
	clear
	Write-Host "Connected to Azure"
}


function Terminate-Connection {
	Disconnect-AzureAD
	$connected = $false
	Write-Host "Disconnected from Azure"
	Sleep 1000
	exit
}


## Start of main code ##

clear;
echo "Welcome to the AAD Menu."
Read-Host "Press {Enter} to login to Azure"
## Establish-Connection

$JSON = Get-Content 'menu.json' | Out-String | ConvertFrom-Json

[Menu]$Main_Menu = [Menu]::new($JSON.name, $JSON.option)

$Main_Menu.PrintMenu()
