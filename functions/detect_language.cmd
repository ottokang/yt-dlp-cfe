rem Detect system locale
for /f "tokens=3" %%a in ('reg query "HKCU\Control Panel\International" /v LocaleName ^| findstr LocaleName') do set locale=%%a

rem If locale file not exist, use en-US as default
if not exist ".\locales\%locale%.cmd" (
    set "locale=en-US"
)