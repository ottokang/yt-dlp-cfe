rem Detect system locale
if %locale%==null (
    for /f "tokens=3" %%a in ('reg query "HKCU\Control Panel\International" /v LocaleName ^| findstr LocaleName') do set locale=%%a
)