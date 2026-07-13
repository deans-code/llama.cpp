set "LLAMA_CACHE=models/"

llama-cli -hf unsloth/Qwen3.6-27B-MTP-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL
llama-cli -hf unsloth/Qwen3.6-35B-A3B-MTP-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL
llama-cli -hf unsloth/gemma-4-31B-it-qat-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL
llama-cli -hf unsloth/gemma-4-26B-A4B-it-qat-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL

@REM MTP draft file isn't fetched by -hf/-hfd (it doesn't match the quant-tag naming pattern), so pull it directly
for /f "delims=" %%H in (models\models--unsloth--gemma-4-26B-A4B-it-qat-GGUF\refs\main) do set "GEMMA_MTP_HASH=%%H"
if not exist "models\models--unsloth--gemma-4-26B-A4B-it-qat-GGUF\snapshots\%GEMMA_MTP_HASH%\mtp-gemma-4-26B-A4B-it.gguf" (
  curl -L -o "models\models--unsloth--gemma-4-26B-A4B-it-qat-GGUF\snapshots\%GEMMA_MTP_HASH%\mtp-gemma-4-26B-A4B-it.gguf" "https://huggingface.co/unsloth/gemma-4-26B-A4B-it-qat-GGUF/resolve/main/mtp-gemma-4-26B-A4B-it.gguf"
)

for /f "delims=" %%H in (models\models--unsloth--gemma-4-31B-it-qat-GGUF\refs\main) do set "GEMMA31_MTP_HASH=%%H"
if not exist "models\models--unsloth--gemma-4-31B-it-qat-GGUF\snapshots\%GEMMA31_MTP_HASH%\mtp-gemma-4-31B-it.gguf" (
  curl -L -o "models\models--unsloth--gemma-4-31B-it-qat-GGUF\snapshots\%GEMMA31_MTP_HASH%\mtp-gemma-4-31B-it.gguf" "https://huggingface.co/unsloth/gemma-4-31B-it-qat-GGUF/resolve/main/mtp-gemma-4-31B-it.gguf"
)