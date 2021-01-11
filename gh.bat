@echo off
set IMAGE_NAME=aalmann/gh-cli

if "%GH_TOKEN%" == "" (
    echo No token GH_TOKEN given. This will not work for the most of the commands.
    set TOKEN_ENV=
) else (
    echo GH_TOKEN found in environment. Will using it.
    set TOKEN_ENV=-e GH_TOKEN=%GH_TOKEN%
)

docker run %TOKEN_ENV% -v %CD%:/gh %IMAGE_NAME% %*

@echo on