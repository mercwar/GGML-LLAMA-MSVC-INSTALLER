cd c:\ggml
call "C:\Program Files (x86)\Microsoft Visual Studio\2022\BuildTools\VC\Auxiliary\Build\vcvars64.bat"
cl.exe /O2 /W4 c:\ggml\c_generator.c /Fe:c:\ggml\avis_mem_test.exe
c:\ggml\avis_mem_test.exe
pause
