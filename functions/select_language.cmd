rem Select language

cls
echo:
echo:
echo   %red_strong% 1 %reset_color% %lo_zhtw:~1,-1%
echo:
echo   %green_strong% 2 %reset_color% %lo_zhcn:~1,-1%
echo:
echo   %yellow_strong% 3 %reset_color% %lo_enus:~1,-1%
echo:
echo:
echo   %blue_strong% C %reset_color% %lang_cancel_select_cookies:~1,-1%
echo:

choice /c 123c /n /m %lang_select_locale%
if %errorlevel%==1 set locale=zh-TW
if %errorlevel%==2 set locale=zh-CN
if %errorlevel%==3 set locale=en-US
if %errorlevel%==4 exit /b 0