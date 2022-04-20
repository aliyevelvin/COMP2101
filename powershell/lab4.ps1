echo "hardwaredescription"
function hardwaredescription {
 get-wmiobject -class win32_computersystem |
 foreach {
          new-object -TypeName psobject -property @{
                 Domain = $_.Domain
                 Manufacturer = $_.Manufacturer
                 Model = $_.Model
                 Name = $_.Name
                 PrimaryOwnerName = $_.PrimaryOwnerName
                 "Totalphysicalmemory(MB)" = $_.TotalPhysicalMemory/1mb
          }
 }|  Format-list Domain,Manufacturer,Model,Name,PrimaryOwnerName,"Totalphysicalmemory(MB)"

 }
 hardwaredescription

 echo "operating system and version"

 function Operatingsystemandversion {
 get-wmiobject -class win32_operatingsystem |
 foreach {
          new-object -TypeName psobject -property @{
                 VersionNumber = $_.Version
                 Name = $_.Name
          }
 }|  Format-list VersionNumber,Name


 }
 Operatingsystemandversion

 echo "processor description with speed, number of cores, size"

 function processorinformation {

  get-wmiobject -class win32_processor |
 foreach {
          new-object -TypeName psobject -property @{
                 Speed = $_.MaxClockSpeed
                 NumberofCores = $_.NumberOfCores
                 Description = $_.Description
                 SizeofL3 = $_.L3CacheSize
                 SpeedofL3 = $_.L3CacheSpeed
          }
 }| Format-list Speed,NumberofCores,Description,SizeofL3,SpeedofL3

 }
 processorinformation

echo "installed ram"

function Raminformation {
 get-wmiobject -class win32_physicalmemory |
 foreach {
          new-object -TypeName psobject -property @{
                 Manufacture = $_.Manufacturer
                 Bank = $_.Banklabel
                 Description = $_.Description
                 Slot = $_.Devicelocator
                 "Size(MB)" = $_.capacity/1mb
          }
          $RAMINSTALLED += $_.capacity/1mb
 }| Format-table Manufacture,Bank,Description,Slot,"Size(MB)"
 "Total RAM:${RAMINSTALLED}MB"
 }
 Raminformation

 echo "physical disk drives"

 function diskdrives {
  $diskdrives = Get-CIMInstance CIM_diskdrive

   foreach ($disk in $diskdrives) {
       $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
       foreach ($partition in $partitions) {
             $logicaldisks = $partition | get-cimassociatedinstance -resultclassname CIM_logicaldisk
             foreach ($logicaldisk in $logicaldisks) {
                      new-object -typename psobject -property @{Manufacturer=$disk.Manufacturer
                                                                model=$disk.Model
                                                                Drive=$logicaldisk.deviceid
                                                                "Size(GB)"=$logicaldisk.size / 1gb -as [int]
                                                                "spaceusage(GB)"=($logicaldisk.size - $logicaldisk.FreeSpace ) /1gb -as [int]
                                                                } | Format-Table Manufacturer,model,Drive,"Size(GB)","spaceusage(GB)" 
            } 
       }
 } 

}

diskdrives

echo "network adapter"

function networkadapterconfiguration {
 Get-CimInstance -className Win32_NetworkAdapterConfiguration | Where-Object IPEnabled -EQ "True" |
     foreach{
                 New-Object -TypeName psobject -Property @{Description =$_.Description
                                                           Index =$_.Index
                                                           IPAddress=$_.ipaddress
                                                           SubnetMask = $_.Ipsubnet
                                                           DNSName=$_.dnsdomain
                                                           DNSServer=$_.DNSServersearchorder
                                                           }
         }|Format-Table Description,Index,IPAddress, Subnetmask,DNSName,DNSServer
}
networkadapterconfiguration


echo "video card company, description, current screen"

function videocardinformation {
get-wmiobject -class win32_videocontroller |
 foreach {
          new-object -TypeName psobject -property @{
                 Manufacture = $_.AdapterCompatibility
                 Description = $_.Description
                 CurrentScreenPixels = [string]$_.CurrentHorizontalResolution  + "x"  + $_.CurrentVerticalResolution
          }

 }| Format-list Manufacture,Description,CurrentScreenPixels
}

videocardinformation



