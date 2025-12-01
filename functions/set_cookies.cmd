rem Set cookies from browser
if "%cookies_from_browser%"=="" (
    set "cookies_option=--no-cookies-from-browser"
) else (
    set "cookies_option=--cookies-from-browser %cookies_from_browser%"
)