rem Select cookies from browser

cls
echo:
echo:
echo   %red_strong% 1 %reset_color% Brave
echo   %green_strong% 2 %reset_color% Chrome
echo   %yellow_strong% 3 %reset_color% Chromium
echo   %blue_strong% 4 %reset_color% Edge
echo   %magenta_strong% 5 %reset_color% Firefox
echo   %cyan_strong% 6 %reset_color% Opera
echo   %white_strong% 7 %reset_color% Safari
echo   %red_strong% 8 %reset_color% Vivaldi
echo   %green_strong% 9 %reset_color% Whale
echo:
echo   %yellow_strong% D %reset_color% %lang_disable_cookies:~1,-1%
echo:
echo   %blue_strong% C %reset_color% %lang_cancel_select_cookies:~1,-1%
echo:
echo:

choice /c 123456789dc /n /m %lang_select_cookies_from_prompt%
if %errorlevel%==1 set cookies_from_browser=brave
if %errorlevel%==2 set cookies_from_browser=chrome
if %errorlevel%==3 set cookies_from_browser=chromium
if %errorlevel%==4 set cookies_from_browser=edge
if %errorlevel%==5 set cookies_from_browser=firefox
if %errorlevel%==6 set cookies_from_browser=opera
if %errorlevel%==7 set cookies_from_browser=safari
if %errorlevel%==8 set cookies_from_browser=vivaldi
if %errorlevel%==9 set cookies_from_browser=whale
if %errorlevel%==10 set cookies_from_browser=
if %errorlevel%==11 exit /b 0