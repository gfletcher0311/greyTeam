$users = @(
    @{Name="orcatrainer"; Group="Administrators"},
    @{Name="pandasafetyspecialist"; Group="Administrators"},
    @{Name="beekeeper"; Group="Users"},
    @{Name="crocodilefeeder"; Group="Users"},
    @{Name="cagecleaner"; Group="Users"},
    @{Name="birdfeeder"; Group="Users"},
    @{Name="sealwaterer"; Group="Users"}
)


foreach ($user in $users) {
	$username = $user.Name
	$group = $user.Group


	if(!(Get-LocalUser -Name $username -ErrorAction silentlyContinue)) {
		New-LocalUser -Name $username -PAssword (ConvertTo-SecureString "z00!" -AsPlainText -Force) -PasswordNeverExpires
		Write-Host "Created user: $username"
	} else {
		Write-Host "User $username already exists"
	}

	Add-LocalGroupMember -Group $group -Member $username --ErrorAction silentlyContinue
	Write-Host "Added user $username to group $group"

