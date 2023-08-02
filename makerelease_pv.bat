if !%VERSION% == ! goto FAIL

taskkill /IM AltSnap.exe 2> nul

del AltSnap%version%bin_x64.zip
del AltSnap%version%bin.zip
del AltSnap%version%src.zip
del AltSnap%version%bin.zip
del AltSnap%version%-x64-inst.exe

:: make i686 version
make clean
make
call nsi.bat
call ziprelease_pv.bat
rename AltSnap_bin.zip AltSnap%version%bin.zip

:: make x64 version
make -fMakefileX64 clean
make -fMakefileX64
call nsi.bat
rename AltSnap%VERSION%-inst.exe AltSnap%VERSION%-x64-inst.exe 
call ziprelease_pv.bat
rename AltSnap_bin.zip AltSnap%version%bin_x64.zip

:: need nsi installed
:: rhash --sha256 AltSnap%VERSION%-x64-inst.exe > SHA256.TXT
:: rhash --sha256 AltSnap%VERSION%-inst.exe >> SHA256.TXT
:: sha256sum AltSnap%VERSION%-x64-inst.exe > SHA256.TXT
:: sha256sum AltSnap%VERSION%-inst.exe >> SHA256.TXT

call zzip_pv.bat
rename AltSnap_src.zip AltSnap%version%src.zip

@GOTO END
:FAIL
@echo Error set the VERSION env variable!

:END
