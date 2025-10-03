rem If URL is empty, exit
if "%url%"=="" (
    echo %lang_url_type:~1,-1%:
    echo:
    exit /b 0
)

rem Check if URL is a playlist or a single video, and set output file name
echo %url% | findstr /C:"?list=" > nul
if %errorlevel%==0 (
    set output_file_name="%%(playlist)s\%%(playlist_index)s. %%(title)s.%%(ext)s"
    echo %lang_url_type:~1,-1%: %yellow%%lang_playlist:~1,-1%%reset_color%
) else (
    set output_file_name="%%(title)s.%%(ext)s"
    echo %lang_url_type:~1,-1%: %blue%%lang_single_video:~1,-1%%reset_color%
)
echo: