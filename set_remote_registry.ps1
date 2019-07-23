
$computers = get-adcomputers -filter * # Если хотим на всех рабочих станциях домена запустить службу
$service_name = "RemoteRegistry"
(Get-Service  $service_name).status

<# На данный момент не имею возможности провести тетстирование кода на работоспособность, поэтому взял
Invoke-Command (она была указана в документации команды )
#>

Invoke-Command -ComputerName $computers -Credential Get-Credential -ScriptBlock{
    $service_name = ""
    
    if((Get-Service  $service_name).status -ne "Running")
    {

    try   {
            Set-Service -InputObject $S -Status Running
            echo "На рабочей станции $env:COMPUTERNAME служба $service_name запущена успешно"
          }
    catch {
           echo "На рабочей станции $env:COMPUTERNAME служба $service_name не запущена"
          }
    }
     else {echo "На рабочей станции $env:COMPUTERNAME служба $service_name уже запущена"}
} # >> ./RemoteRegistry_status.txt
