#This script will invert the health checks of your route53 failover DNS entries, if you have the tag DREvent set to disabled
#This is useful if you have an active/passive datacenter and you need to manually send your DNS records to the passive datacenter.
#For Example, if you want to do a DR test, but dont want to shutdown your primary datacenter completely

#this isn't needed if your environment is in a failed state.  It is used if you need to manually failover to your DR site.

#You might need more logic if you have over 100 health checks

##########################
#Code walkthrough
##########################
#get a list of all healthchecks
#Get-R53HealthCheckList | ForEach-Object -Process {Get-R53TagsForResource -ResourceId $_.Id -ResourceType healthcheck} 

#Filter the resource ID to only the Key:Value pair of DREvent:disabled
#DREvent:disabled means that you are not currently forcing your environment to a failed state.
# ForEach-Object -Process { if ($_.Tags.Key -Contains "DREvent" -and $_.Tags.Value -Contains "disabled" )

#invert the health check
#Update-R53HealthCheck -HealthCheckId $_.ResourceId -Inverted 1

#update tag to show its in a failover state
#Edit-R53TagsForResource -ResourceId $_.ResourceId -ResourceType healthcheck -AddTag @{"Key"="DREvent"; "Value"="enabled"}} }

#All together
Get-R53HealthCheckList | ForEach-Object -Process {Get-R53TagsForResource -ResourceId $_.Id -ResourceType healthcheck} | ForEach-Object -Process { if ($_.Tags.Key -Contains "DREvent" -and $_.Tags.Value -Contains "disabled" ) {Update-R53HealthCheck -HealthCheckId $_.ResourceId -Inverted 1; Edit-R53TagsForResource -ResourceId $_.ResourceId -ResourceType healthcheck -AddTag @{"Key"="DREvent"; "Value"="enabled"}} }