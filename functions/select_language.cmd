rem Select language

cls
echo:
echo:
echo   %red_strong% 1 %reset_color% 繁體中文
echo:
echo   %green_strong% 2 %reset_color% 简体中文
echo:
echo   %yellow_strong% 3 %reset_color% English (US)
echo:
echo:
echo   %blue_strong% C %reset_color% %LANG_cancel_and_return%
echo:

choice /c 123c /n /m "%LANG_select_locale%"
if %errorlevel%==1 set "locale=zh-TW"
if %errorlevel%==2 set "locale=zh-CN"
if %errorlevel%==3 set "locale=en-US"
if %errorlevel%==4 exit /b 0