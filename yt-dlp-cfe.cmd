rem Set echo off, root path, UTF-8 encoding, setlocal, enable delayed expansion
echo off
cd /D "%~dp0"
chcp 65001 > nul
setlocal enabledelayedexpansion

rem Set Const
set _BIN_PATH_=.\bin
set _YT_DLP_BIN_=%_BIN_PATH_%\yt-dlp.exe
set _FFMPEG_LOCATION_=--ffmpeg-location %_BIN_PATH_%
set _VIDEO_PARAMS_=--embed-thumbnail --embed-metadata --windows-filenames --force-overwrites --embed-subs --convert-subs srt --sub-langs all,-live_chat
set _AUDIO_PARAMS_=--embed-thumbnail --embed-metadata --windows-filenames --force-overwrites

rem Load color code, locale name, initial variables
call ".\functions\colors.cmd"
call ".\locales\locale_name.cmd"
set url=
set title=
set output_file_name=null
set output_path_type=desktop
set output_path_type_name=null
set output_path=null
set output_path_full_name=null
set cookies_from_browser=
set cookies_option=null
set locale=null

rem Set is_dev to true to skip input URL and go to MENU directly (for development use only)
set is_dev=false
::set is_dev=true

rem Detect system language
call ".\functions\detect_language.cmd"

rem Set language
:SET_LANGUAGE
call ".\functions\set_language.cmd"

rem Set cookies from browser
:SET_COOKIES_FROM_BROWSER
call ".\functions\set_cookies.cmd"

rem If is_dev is true, goto INPUT_URL
if %is_dev%==true goto INPUT_URL

rem Menu
:MENU
cls
echo:
echo    %cyan%《yt-dlp-cfe》%reset_color%                                                     %white_strong% L %reset_color% %lang_locale:~1, -1%%locale%
echo                                                                       %yellow_strong% C %reset_color% Cookies: %cookies_from_browser%
echo %lang_youtube_url:~1,-1%: %green%%url%%reset_color%
echo:
echo %lang_video_title:~1,-1%: %magenta%%title%%reset_color%
echo:

rem Check url type (playlist or single video)
call ".\functions\check_url_type.cmd"

rem Set output folder
call ".\functions\set_output_folder.cmd"

echo:
echo    %magenta_strong% I %reset_color% %lang_input_url:~1,-1%
echo:
echo:
echo    %red_strong% V %reset_color% %lang_download_as_mp4:~1,-1%
echo:
echo    %green_strong% B %reset_color% %lang_download_as_best:~1,-1%
echo:
echo:
echo    %yellow_strong% M %reset_color% %lang_download_as_mp3:~1,-1%
echo:
echo    %blue_strong% A %reset_color% %lang_download_as_aac:~1,-1%
echo:
echo:
echo    %cyan_strong% Q %reset_color% %lang_exit:~1,-1%
echo:

choice /c vbmaidlc0q /n /m %lang_please_choose%
if %errorlevel%==1 goto MP4
if %errorlevel%==2 goto BEST_VIDEO
if %errorlevel%==3 goto MP3
if %errorlevel%==4 goto AAC
if %errorlevel%==5 goto INPUT_URL
if %errorlevel%==6 goto SWITCH_OUTPUT_PATH
if %errorlevel%==7 goto SELECT_LANGUAGE
if %errorlevel%==8 goto SELECT_COOKIES_FROM_BROWSER
if %errorlevel%==9 goto REFRESH_MENU
if %errorlevel%==10 goto END

rem Download as MP4
:MP4
if "%url%"=="" (
    call ".\functions\alert_url_is_empty.cmd"
    goto MENU
)

echo:
choice /n /m "%lang_do_you_want_to_continue:~1, -1%%red_strong%%lang_download_as_mp4:~1,-1%%reset_color%%bold%%lang_will_overwrite:~1,-1%%reset_color%? [%green%Y%reset_color%, %red%N%reset_color%]"
if %errorlevel%==1 (
    cls
    %_YT_DLP_BIN_% --output %output_path_full_name% %_FFMPEG_LOCATION_% %cookies_option% %_VIDEO_PARAMS_% -t mp4 %url%
    goto DOWNLOAD_COMPLETE
)
goto MENU

rem Download as Best Video
:BEST_VIDEO
if "%url%"=="" (
    call ".\functions\alert_url_is_empty.cmd"
    goto MENU
)

echo:
choice /n /m "%lang_do_you_want_to_continue:~1, -1%%green_strong%%lang_download_as_best:~1,-1%%reset_color%%bold%%lang_will_overwrite:~1,-1%%reset_color%? [%green%Y%reset_color%, %red%N%reset_color%]"
if !ERRORLEVEL!==1 (
    cls
    %_YT_DLP_BIN_% --output %output_path_full_name% %_FFMPEG_LOCATION_% %cookies_option% %_VIDEO_PARAMS_% -f "bestvideo+bestaudio/best" --merge-output-format mkv %url%
    goto DOWNLOAD_COMPLETE
)
goto MENU

rem Download as MP3
:MP3
if "%url%"=="" (
    call ".\functions\alert_url_is_empty.cmd"
    goto MENU
)

echo:
choice /n /m "%lang_do_you_want_to_continue:~1, -1%%yellow_strong%%lang_download_as_mp3:~1,-1%%reset_color%%bold%%lang_will_overwrite:~1,-1%%reset_color%? [%green%Y%reset_color%, %red%N%reset_color%]"
if !ERRORLEVEL!==1 (
    cls
    %_YT_DLP_BIN_% --output %output_path_full_name% %_FFMPEG_LOCATION_% %cookies_option% %_AUDIO_PARAMS_% -t mp3 %url%
    goto DOWNLOAD_COMPLETE
)
goto MENU

rem Download as AAC
:AAC
if "%url%"=="" (
    call ".\functions\alert_url_is_empty.cmd"
    goto MENU
)

echo:
choice /n /m "%lang_do_you_want_to_continue:~1, -1%%blue_strong%%lang_download_as_aac:~1,-1%%reset_color%%bold%%lang_will_overwrite:~1,-1%%reset_color%? [%green%Y%reset_color%, %red%N%reset_color%]"
if !ERRORLEVEL!==1 (
    cls
    %_YT_DLP_BIN_% --output %output_path_full_name% %_FFMPEG_LOCATION_% %cookies_option% %_AUDIO_PARAMS_% -t aac %url%
    goto DOWNLOAD_COMPLETE
)
goto MENU

rem Download complete
:DOWNLOAD_COMPLETE
echo:
echo %cyan% %lang_download_complete:~1, -1% %reset_color%
pause
goto MENU

rem Input url
:INPUT_URL
call ".\functions\input_url.cmd"
goto MENU

rem Switch output folder
:SWITCH_OUTPUT_PATH
if %output_path_type%==desktop (
    set output_path_type=downloads
) else (
    set output_path_type=desktop
)
goto MENU

rem Select language
:SELECT_LANGUAGE
call ".\functions\select_language.cmd"
goto SET_LANGUAGE

rem Select cookies from browser
:SELECT_COOKIES_FROM_BROWSER
call ".\functions\select_cookies_from_browser.cmd"
goto SET_COOKIES_FROM_BROWSER

rem Refresh
:REFRESH_MENU
goto MENU

rem Quit
:END
echo:
choice /n /m "%lang_do_you_want_end:~1, -1%? [%green%Y%reset_color%, %red%N%reset_color%]"
if !ERRORLEVEL!==1 (
    exit /b 0
)

goto MENU