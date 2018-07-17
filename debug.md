
Check the guid task
Get-ScheduledTask ovnsetguid | Get-ScheduledTaskInfo

Proper Result:


LastRunTime        : 7/17/2018 9:01:01 AM
LastTaskResult     : 0
NextRunTime        : 7/17/2018 2:00:00 PM
NumberOfMissedRuns : 0
TaskName           : ovnsetguid
TaskPath           : \
PSComputerName     :


To Check guid:
 ovs-vsctl get Open_vSwitch . external_ids:system-id

Proper Result:
ovs-vsctl get Open_vSwitch . external_ids:system-id
"bc2f7e9f-c616-43fb-9f3e-5d3d55679121"

NOTE: The guid value will be different

To Trigger Run:

Start-ScheduledTask -TaskName ovnsetguid


