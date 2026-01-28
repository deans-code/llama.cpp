@echo off

set /p upgrade="Would you like to upgrade llama.cpp to the latest version? (Y/N): "

if /i "%upgrade%"=="Y" (
    echo Upgrading llama.cpp to the latest version...
    winget upgrade llama.cpp
    echo.
) else (
    echo Skipping upgrade.
    echo.
)

echo.
echo ========================================
echo Select a model to run:
echo ========================================
echo 1. GLM-4.7-Flash-UD-Q8_K_XL.gguf
echo 2. GLM-4.7-Flash-UD-Q6_K_XL.gguf
echo 3. LFM2.5-1.2B-Thinking-F16.gguf
echo 4. gpt-oss-20b-F16.gguf
echo 5. Qwen3-4B-Instruct-2507-UD-Q4_K_XL.gguf
echo ========================================
echo.

set /p choice="Enter your choice (1, 2, 3, 4, or 5): "

if "%choice%"=="1" (
    goto :GLM-4.7-Flash-UD-Q8_K_XL
) else if "%choice%"=="2" (
    goto :GLM-4.7-Flash-UD-Q6_K_XL
) else if "%choice%"=="3" (
    goto :LFM2.5-1.2B-Thinking-F16
) else if "%choice%"=="4" (
    goto :gpt-oss-20b-F16
) else if "%choice%"=="5" (
    goto :Qwen3-4B-Instruct-2507-UD-Q4_K_XL
) else (
    echo Invalid choice. Exiting.
    pause
    exit /b 1
)

:GLM-4.7-Flash-UD-Q8_K_XL
echo.
echo Running llama.cpp with GLM-4.7-Flash-UD-Q8_K_XL.gguf
echo.

REM Recommended settings available on Hugging Face: https://huggingface.co/unsloth/GLM-4.7-Flash-GGUF

start "" wt.exe pwsh.exe -NoExit -Command ^
"llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model '%~dp0models\GLM-4.7-Flash-UD-Q8_K_XL.gguf' ^
--device Vulkan0 ^
--sleep-idle-seconds 1000 ^
--metrics ^
--verbose ^
--jinja ^
--ctx-size 32768 ^
--threads -1 ^
--batch-size 2048 ^
--ubatch-size 512 ^
--parallel 4 ^
--cont-batching ^
--cache-prompt ^
--fit on ^
--flash-attn on ^
--repeat-penalty 1.05 ^
--temp 0.7 ^
--top-p 0.9 ^
--min-p 0.05"
goto :eof

:GLM-4.7-Flash-UD-Q6_K_XL
echo.
echo Running llama.cpp with GLM-4.7-Flash-UD-Q6_K_XL.gguf
echo.

REM Recommended settings available on Hugging Face: https://huggingface.co/unsloth/GLM-4.7-Flash-GGUF

start "" wt.exe pwsh.exe -NoExit -Command ^
"llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model '%~dp0models\GLM-4.7-Flash-UD-Q6_K_XL.gguf' ^
--device Vulkan0 ^
--sleep-idle-seconds 1000 ^
--metrics ^
--verbose ^
--jinja ^
--ctx-size 32768 ^
--threads -1 ^
--batch-size 2048 ^
--ubatch-size 512 ^
--parallel 4 ^
--cont-batching ^
--cache-prompt ^
--fit on ^
--flash-attn on ^
--repeat-penalty 1.05 ^
--temp 0.7 ^
--top-p 0.9 ^
--min-p 0.05"
goto :eof

:LFM2.5-1.2B-Thinking-F16
echo.
echo Running llama.cpp with LFM2.5-1.2B-Thinking-F16.gguf
echo.

start "" wt.exe pwsh.exe -NoExit -Command ^
"llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model '%~dp0models\LFM2.5-1.2B-Thinking-F16.gguf' ^
--device Vulkan0 ^
--sleep-idle-seconds 1000 ^
--metrics ^
--verbose ^
--jinja ^
--ctx-size 16384 ^
--threads -1 ^
--batch-size 1024 ^
--ubatch-size 256 ^
--parallel 4 ^
--cont-batching ^
--cache-prompt ^
--fit on ^
--flash-attn on ^
--repeat-penalty 1.1 ^
--temp 0.8 ^
--top-p 0.95 ^
--top-k 40 ^
--min-p 0.05"
goto :eof

:gpt-oss-20b-F16
echo.
echo Running llama.cpp with gpt-oss-20b-F16.gguf
echo.

start "" wt.exe pwsh.exe -NoExit -Command ^
"llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model '%~dp0models\gpt-oss-20b-F16.gguf' ^
--device Vulkan0 ^
--sleep-idle-seconds 1000 ^
--metrics ^
--verbose ^
--jinja ^
--ctx-size 32768 ^
--threads -1 ^
--batch-size 2048 ^
--ubatch-size 512 ^
--parallel 4 ^
--cont-batching ^
--cache-prompt ^
--fit on ^
--flash-attn on ^
--repeat-penalty 1.05 ^
--temp 0.7 ^
--top-p 0.9 ^
--min-p 0.05"
goto :eof

:Qwen3-4B-Instruct-2507-UD-Q4_K_XL
echo.
echo Running llama.cpp with Qwen3-4B-Instruct-2507-UD-Q4_K_XL.gguf
echo.

start "" wt.exe pwsh.exe -NoExit -Command ^
"llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model '%~dp0models\Qwen3-4B-Instruct-2507-UD-Q4_K_XL.gguf' ^
--device Vulkan0 ^
--sleep-idle-seconds 1000 ^
--metrics ^
--verbose ^
--jinja ^
--ctx-size 131072 ^
--threads -1 ^
--batch-size 2048 ^
--ubatch-size 512 ^
--parallel 4 ^
--cont-batching ^
--cache-prompt ^
--fit on ^
--flash-attn on ^
--repeat-penalty 1.05 ^
--temp 0.7 ^
--top-p 0.8 ^
--top-k 20 ^
--min-p 0.05"
goto :eof