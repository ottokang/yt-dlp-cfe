rem Input YouTube URL

rem If in dev mode, set a URL for testing
if %is_dev%==true (
    set "input_url="
    goto CHECK_INPUT
)

rem Input URL prompt
cls
echo:
echo:
echo %cyan%%lang_input_url_prompt:~1,-1% %reset_color% %green%
set "input_url="
set /p input_url="> "
echo %reset_color%

:CHECK_INPUT
rem Check if input is empty
if "%input_url%"=="" (
    echo:
    echo %yellow%%lang_did_not_input_url:~1,-1%%reset_color%
    pause
    goto INPUT_URL_END
)

rem Clean URL (symols like &, ?...)
for /f "delims=" %%a in ('powershell -command "[System.Net.WebUtility]::HtmlEncode('%input_url%').Split('&')[0]"') do (
    set "input_url=%%a"
)

for /f "delims=" %%a in ('powershell -command "'%input_url%' -replace '\?feature=shared'"') do (
    set "input_url=%%a"
)

rem Validate URL
echo %lang_clean_url:~1,-1%: %yellow%"%input_url%"%reset_color%
echo:
echo %blue%%lang_checking_url:~1,-1%%reset_color%
echo:

rem Get video json information
%_YT_DLP_BIN_% %_FFMPEG_LOCATION_% %cookies_option% --dump-single-json --simulate --flat-playlist "%input_url%" > info.json
if %errorlevel%==0 (
    for /f "tokens=*" %%a in ('powershell -command "(Get-Content info.json -Encoding UTF8 | ConvertFrom-Json).title"') do set "title=%%a"
) else (
    echo:
    echo %red%%lang_invaild_url:~1,-1%%reset_color%
    pause
    goto INPUT_URL_END
)

rem Delete temp file, set URL
del info.json
set "url=%input_url%"
goto INPUT_URL_END

:INPUT_URL_END
exit /b 0