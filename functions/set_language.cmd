rem If locale file not exist, use en-US as default
if not exist ".\locales\%locale%.cmd" (
    call ".\locales\en-US.cmd"
) else (
    call ".\locales\%locale%.cmd"
)