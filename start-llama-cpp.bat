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
echo 6. Qwen3-Coder-Next-UD-Q4_K_XL.gguf
echo 7. Qwen3.5-35B-A3B-UD-Q6_K_XL.gguf (thinking, precise coding tasks)
echo 8. Qwen3.5-35B-A3B-UD-Q6_K_XL.gguf (thinking, general tasks)
echo 9. Qwen3.5-35B-A3B-UD-Q6_K_XL.gguf (non-thinking, general tasks)
echo 10. Qwen3.5-35B-A3B-UD-Q6_K_XL.gguf (non-thinking, reasoning tasks)
echo 11. Devstral-Small-2-24B-Instruct-2512-BF16.gguf
echo ========================================
echo.

set /p choice="Enter your choice (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, or 11): "

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
) else if "%choice%"=="6" (
    goto :Qwen3-Coder-Next-UD-Q4_K_XL
) else if "%choice%"=="7" (
    goto :Qwen3.5-35B-A3B-UD-Q6_K_XL-Thinking-Precise
) else if "%choice%"=="8" (
    goto :Qwen3.5-35B-A3B-UD-Q6_K_XL-Thinking-General
) else if "%choice%"=="9" (
    goto :Qwen3.5-35B-A3B-UD-Q6_K_XL-Non-thinking-General
) else if "%choice%"=="10" (
    goto :Qwen3.5-35B-A3B-UD-Q6_K_XL-Non-thinking-Reasoning
) else if "%choice%"=="11" (
    goto :Devstral-Small-2-24B-Instruct-2512-BF16
) else (
    echo Invalid choice. Exiting.
    pause
    exit /b 1
)

REM Global documentation:
REM REM ctx-size is divided by parallel. Coding agents can exceed smaller values. Try parallel value of 1.
REM Multi-modal support with -hf: https://github.com/ggml-org/llama.cpp/blob/master/docs/multimodal.md

REM List of Llama.cpp parameters:
REM https://github.com/ggml-org/llama.cpp/blob/master/tools/server/README.md

:GLM-4.7-Flash-UD-Q8_K_XL
echo.
echo Running llama.cpp with GLM-4.7-Flash-UD-Q8_K_XL.gguf
echo.

REM https://unsloth.ai/docs/models/glm-4.7-flash

llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model %~dp0models\GLM-4.7-Flash-UD-Q8_K_XL.gguf ^
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
--temp 1.0 ^
--top-p 0.95 ^
--min-p 0.01 ^
--repeat_penalty 1.0
goto :eof

:GLM-4.7-Flash-UD-Q6_K_XL
echo.
echo Running llama.cpp with GLM-4.7-Flash-UD-Q6_K_XL.gguf
echo.

REM https://unsloth.ai/docs/models/glm-4.7-flash

llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model %~dp0models\GLM-4.7-Flash-UD-Q6_K_XL.gguf ^
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
--temp 1.0 ^
--top-p 0.95 ^
--min-p 0.01 ^
--repeat_penalty 1.0
goto :eof

:LFM2.5-1.2B-Thinking-F16
echo.
echo Running llama.cpp with LFM2.5-1.2B-Thinking-F16.gguf
echo.

REM https://unsloth.ai/docs/models/tutorials/lfm2.5

llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model %~dp0models\LFM2.5-1.2B-Thinking-F16.gguf ^
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
--temp 0.1 ^
--top-p 0.1 ^
--top-k 50 ^
--min-p 0.05 ^
--repeat_penalty 1.05
goto :eof

:gpt-oss-20b-F16
echo.
echo Running llama.cpp with gpt-oss-20b-F16.gguf
echo.

REM https://unsloth.ai/docs/models/gpt-oss-how-to-run-and-fine-tune#run-gpt-oss-20b

llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model %~dp0models\gpt-oss-20b-F16.gguf ^
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
--temp 1.0 ^
--top-k 0
--top-p 1.0 ^
--min-p 0.05
goto :eof

:Qwen3-4B-Instruct-2507-UD-Q4_K_XL
echo.
echo Running llama.cpp with Qwen3-4B-Instruct-2507-UD-Q4_K_XL.gguf
echo.

REM https://unsloth.ai/docs/models/qwen3-how-to-run-and-fine-tune/qwen3-2507

llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model %~dp0models\Qwen3-4B-Instruct-2507-UD-Q4_K_XL.gguf ^
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
--top-p 0.8 ^
--top-k 20 ^
--min-p 0.00 ^
--presence_penalty 0.0
goto :eof

:Qwen3-Coder-Next-UD-Q4_K_XL
echo.
echo Running llama.cpp with Qwen3-Coder-Next-UD-Q4_K_XL.gguf
echo.

REM https://unsloth.ai/docs/models/qwen3-coder-next

llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model %~dp0models\Qwen3-Coder-Next-UD-Q4_K_XL.gguf ^
--device Vulkan0 ^
--sleep-idle-seconds 1000 ^
--metrics ^
--verbose ^
--jinja ^
--ctx-size 131072 ^
--threads -1 ^
--batch-size 2048 ^
--ubatch-size 512 ^
--parallel 1 ^
--cont-batching ^
--cache-prompt ^
--fit on ^
--flash-attn on ^
--repeat-penalty 1.05 ^
--temp 1.0 ^
--top-p 0.95 ^
--top-k 40 ^
--min-p 0.01 ^
--presence-penalty 0.0 ^
--repeat_penalty 1.0
goto :eof

:Qwen3.5-35B-A3B-UD-Q6_K_XL-Thinking-Precise
echo.
echo Running llama.cpp with Qwen3.5-35B-A3B-UD-Q6_K_XL.gguf
echo.

REM https://unsloth.ai/docs/models/qwen3.5#qwen3.5-35b-a3b

llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model %~dp0models\Qwen3.5-35B-A3B-UD-Q6_K_XL.gguf ^
--device Vulkan0 ^
--sleep-idle-seconds 1000 ^
--metrics ^
--verbose ^
--jinja ^
--ctx-size 16384 ^
--threads -1 ^
--batch-size 2048 ^
--ubatch-size 512 ^
--parallel 1 ^
--cont-batching ^
--cache-prompt ^
--fit on ^
--flash-attn on ^
--repeat-penalty 1.05 ^
--temp 0.6 ^
--top-p 0.95 ^
--top-k 20 ^
--min-p 0.0 ^
--presence-penalty 0.0
goto :eof

:Qwen3.5-35B-A3B-UD-Q6_K_XL-Thinking-General
echo.
echo Running llama.cpp with Qwen3.5-35B-A3B-UD-Q6_K_XL.gguf
echo.

REM https://unsloth.ai/docs/models/qwen3.5#qwen3.5-35b-a3b

llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model %~dp0models\Qwen3.5-35B-A3B-UD-Q6_K_XL.gguf ^
--device Vulkan0 ^
--sleep-idle-seconds 1000 ^
--metrics ^
--verbose ^
--jinja ^
--ctx-size 16384 ^
--threads -1 ^
--batch-size 2048 ^
--ubatch-size 512 ^
--parallel 1 ^
--cont-batching ^
--cache-prompt ^
--fit on ^
--flash-attn on ^
--repeat-penalty 1.05 ^
--temp 1.0 ^
--top-p 0.95 ^
--top-k 20 ^
--min-p 0.0 ^
--presence-penalty 0.0
goto :eof

:Qwen3.5-35B-A3B-UD-Q6_K_XL-Non-thinking-General
echo.
echo Running llama.cpp with Qwen3.5-35B-A3B-UD-Q6_K_XL.gguf
echo.

REM https://unsloth.ai/docs/models/qwen3.5#qwen3.5-35b-a3b

llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model %~dp0models\Qwen3.5-35B-A3B-UD-Q6_K_XL.gguf ^
--device Vulkan0 ^
--sleep-idle-seconds 1000 ^
--metrics ^
--verbose ^
--jinja ^
--ctx-size 16384 ^
--threads -1 ^
--batch-size 2048 ^
--ubatch-size 512 ^
--parallel 1 ^
--cont-batching ^
--cache-prompt ^
--fit on ^
--flash-attn on ^
--repeat-penalty 1.05 ^
--temp 0.7 ^
--top-p 0.8 ^
--top-k 20 ^
--min-p 0.0 ^
--chat-template-kwargs "{""enable_thinking"":false}" ^
--presence-penalty 0.0 
goto :eof

:Qwen3.5-35B-A3B-UD-Q6_K_XL-Non-thinking-Reasoning
echo.
echo Running llama.cpp with Qwen3.5-35B-A3B-UD-Q6_K_XL.gguf
echo.
pause

REM https://unsloth.ai/docs/models/qwen3.5#qwen3.5-35b-a3b

llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model %~dp0models\Qwen3.5-35B-A3B-UD-Q6_K_XL.gguf ^
--device Vulkan0 ^
--sleep-idle-seconds 1000 ^
--metrics ^
--verbose ^
--jinja ^
--ctx-size 16384 ^
--threads -1 ^
--batch-size 2048 ^
--ubatch-size 512 ^
--parallel 1 ^
--cont-batching ^
--cache-prompt ^
--fit on ^
--flash-attn on ^
--repeat-penalty 1.05 ^
--temp 1.0 ^
--top-p 0.95 ^
--top-k 20 ^
--min-p 0.0 ^
--chat-template-kwargs "{""enable_thinking"":false}" ^
--presence-penalty 0.0
pause
goto :eof

:Devstral-Small-2-24B-Instruct-2512-BF16
echo.
echo Running llama.cpp with Devstral-Small-2-24B-Instruct-2512-BF16.gguf
echo.
pause

REM https://unsloth.ai/docs/models/tutorials/devstral-2

llama-server ^
--host 127.0.0.1 ^
--port 8080 ^
--model %~dp0models\Qwen3.5-35B-A3B-UD-Q6_K_XL.gguf ^
--device Vulkan0 ^
--sleep-idle-seconds 1000 ^
--metrics ^
--verbose ^
--jinja ^
--ctx-size 16384 ^
--threads -1 ^
--batch-size 2048 ^
--ubatch-size 512 ^
--parallel 1 ^
--cont-batching ^
--cache-prompt ^
--fit on ^
--flash-attn on ^
--temp 0.15 ^
--min-p 0.01
pause
goto :eof