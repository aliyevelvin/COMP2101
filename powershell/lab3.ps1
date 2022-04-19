Get-CimInstance -className Win32_NetworkAdapterConfiguration | Where-Object IPEnabled -EQ "True" |
     foreach{
                 New-Object -TypeName psobject -Property @{Description =$_.Description
                                                           Index =$_.Index
                                                           IPaddress=$_.ipaddress
                                                           Subnetmask = $_.Ipsubnet
                                                           DNsName=$_.dnsdomain
                                                           DNSserver=$_.DNSServersearchorder
                                                           }
         }|Format-Table Description,Index,IPaddress, Subnetmask,DNsName,DNSserver