CACLS ../../approot /t /e /p "Network Service":c      
CACLS ../../sitesroot /t /e /p "Network Service":c
%windir%\system32\inetsrv\appcmd set config -section:applicationPools -applicationPoolDefaults.processModel.idleTimeout:00:00:00

EXIT /b 0