rem Check if deno is installed

where deno > nul 2>&1
if %ERRORLEVEL%==0 (
    set "is_deno=true"
) else (
    set "is_deno=false"
)