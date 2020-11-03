# AWSRoute53Failover_powershell
This script grabs a list of route53 health checks using powershell.  Then inverts the health checks tagged as DREvent:enabled.  Inverting the health check causes route53's failover record to see the primary site as down from the primary record to the secondary record.  This is useful for DR testing or maintenance windows.
