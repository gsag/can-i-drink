REM You must have been setted ReportGenerator exe on system environment variables.
REM You can download ReportGenerator on Github: https://github.com/danielpalme/ReportGenerator

SET CMD_EXE=flutter test --coverage
echo %CMD_EXE%
call %CMD_EXE%

SET CMD_EXE=ReportGenerator  "-reports:.\coverage\lcov.info" "-targetdir:.\coverage\reports" "-sourcedirs:.\lib" "-reporttypes:Html"
echo %CMD_EXE%
call %CMD_EXE%

SET CMD_EXE=ReportGenerator  "-reports:.\coverage\lcov.info" "-targetdir:.\coverage\badges" "-sourcedirs:.\lib" "-reporttypes:Badges"
echo %CMD_EXE%
call %CMD_EXE%

SET CMD_EXE=cd coverage\badges
echo %CMD_EXE%
call %CMD_EXE%

SET CMD_EXE=cd ..\..\
echo %CMD_EXE%
call %CMD_EXE%