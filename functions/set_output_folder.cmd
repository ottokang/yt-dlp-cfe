rem Set output folder
if %output_path_type%==desktop (
    set "output_path=%USERPROFILE%\Desktop\"
    set "output_path_type_name=%LANG_output_path_desktop%"
) else if %output_path_type%==downloads (
    set "output_path=%USERPROFILE%\Downloads\"
    set "output_path_type_name=%LANG_output_path_downloads%"
)

rem Set output file with double quotes for yt-dlp
set output_path_full_name="%output_path%%output_file_name%"

echo %LANG_output_path%: %yellow%%output_path_type_name%%reset_color%%LANG_press_to_change_path%