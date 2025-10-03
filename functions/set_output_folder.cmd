rem Set output folder
if %output_path_type%==desktop (
    set output_path="%USERPROFILE%\Desktop\"
    set output_path_type_name=%lang_output_path_desktop:~1,-1%
) else if %output_path_type%==downloads (
    set output_path="%USERPROFILE%\Downloads\"
    set output_path_type_name=%lang_output_path_downloads:~1,-1%
)
set output_path_full_name="%output_path:~1,-1%%output_file_name:~1,-1%"

echo %lang_output_path:~1,-1%: %yellow%%output_path_type_name%%reset_color%%lang_press_to_change_path:~1,-1%
echo: