set "LLAMA_CACHE=models/"

@REM llama-cli -hf unsloth/Qwen3.6-27B-MTP-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL
@REM llama-cli -hf unsloth/Qwen3.6-35B-A3B-MTP-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL
@REM llama-cli -hf unsloth/gemma-4-31B-it-qat-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL
@REM llama-cli -hf unsloth/gemma-4-26B-A4B-it-qat-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL
@REM llama-cli -hf unsloth/North-Mini-Code-1.0-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL
@rem llama-cli -hf unsloth/Laguna-S-2.1-GGUF:UD-Q2_K_XL -st -p "hi" -n 1 < NUL
@rem llama-cli -hf unsloth/Muse-Glimmer-30B-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL

@REM Muse Glimmer's -hf pull auto-selects the Q8_0 mmproj; fetch the BF16 one
@REM directly to match the other vision models' mmproj quality here.
for /f "delims=" %%H in (models\models--unsloth--Muse-Glimmer-30B-GGUF\refs\main) do set "MUSE_GLIMMER_HASH=%%H"
if not exist "models\models--unsloth--Muse-Glimmer-30B-GGUF\snapshots\%MUSE_GLIMMER_HASH%\mmproj-Muse-Glimmer-30B-BF16.gguf" (
  curl -L -o "models\models--unsloth--Muse-Glimmer-30B-GGUF\snapshots\%MUSE_GLIMMER_HASH%\mmproj-Muse-Glimmer-30B-BF16.gguf" "https://huggingface.co/unsloth/Muse-Glimmer-30B-GGUF/resolve/main/mmproj-Muse-Glimmer-30B-BF16.gguf"
  del "models\models--unsloth--Muse-Glimmer-30B-GGUF\snapshots\%MUSE_GLIMMER_HASH%\mmproj-Muse-Glimmer-30B-Q8_0.gguf"
)

@REM MTP draft file isn't fetched by -hf/-hfd (it doesn't match the quant-tag naming pattern), so pull it directly
for /f "delims=" %%H in (models\models--unsloth--gemma-4-26B-A4B-it-qat-GGUF\refs\main) do set "GEMMA_MTP_HASH=%%H"
if not exist "models\models--unsloth--gemma-4-26B-A4B-it-qat-GGUF\snapshots\%GEMMA_MTP_HASH%\mtp-gemma-4-26B-A4B-it.gguf" (
  curl -L -o "models\models--unsloth--gemma-4-26B-A4B-it-qat-GGUF\snapshots\%GEMMA_MTP_HASH%\mtp-gemma-4-26B-A4B-it.gguf" "https://huggingface.co/unsloth/gemma-4-26B-A4B-it-qat-GGUF/resolve/main/mtp-gemma-4-26B-A4B-it.gguf"
)

for /f "delims=" %%H in (models\models--unsloth--gemma-4-31B-it-qat-GGUF\refs\main) do set "GEMMA31_MTP_HASH=%%H"
if not exist "models\models--unsloth--gemma-4-31B-it-qat-GGUF\snapshots\%GEMMA31_MTP_HASH%\mtp-gemma-4-31B-it.gguf" (
  curl -L -o "models\models--unsloth--gemma-4-31B-it-qat-GGUF\snapshots\%GEMMA31_MTP_HASH%\mtp-gemma-4-31B-it.gguf" "https://huggingface.co/unsloth/gemma-4-31B-it-qat-GGUF/resolve/main/mtp-gemma-4-31B-it.gguf"
)