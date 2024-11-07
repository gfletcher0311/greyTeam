Import-Module ActiveDirectory
# PAth of the CSV file
#Format: Firstname, lastname, username, password
$csvPath = "C:\Users\Administrator\Downloads\users.csv"

#^ be sure you know the path to the csv file is the same as
# when copying over ansible.

$ADDomainName = "seneca.zoo"

#Importing the csv file
$users = Import-Csv -Path $csvPath

#looping through each of the users
foreach ($user in $users) {
    New-ADUser `
        -GivenName $user.FirstName `
        -Surname $user.LastName `
        -Name ($user.FirstName + " " + $user.LastName) `
        -SamAccountName $user.Username `
        -UserPrincipalName ($user.Username+"@"+$ADDomainName) `
        -AccountPassword (ConvertTo-SecureString "z00!" -AsPlainText -Force) `
        -Enabled $true `
        -Server "seneca.zoo" 
    Write-Host "Created user: $($user.FirstName) $($user.LastName) in domain: $ADDomainName"


    switch ($user.GroupType) {
        "Domain Admins" { Add-ADGroupMemver -Identity "Domain Admins" -Members $user.Username }
        "Domain Users" { Add-ADGroupMember -Identity "Domain Users" -Members $user.Username }
        "Local Admins" { Add-ADGroupMember -Identity "Administrators" -Members $user.Username }
        "Local Users" { Add-ADGroupMember -Identity "Users" -Members $user.Username }
        default { Write-Host "Unknown GroupType for $($user.Username)" }
    }
    Write-Host "Added $($user.Username) to $($user.GroupType) group"
}
