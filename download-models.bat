set "LLAMA_CACHE=models/"

@REM Each block below only calls -hf (which downloads to LLAMA_CACHE) if the
@REM model isn't already present, so re-running this script after adding a
@REM new entry to models.ini only fetches what's missing.

if not exist "models\models--unsloth--Qwen3.6-27B-MTP-GGUF\snapshots\5cb35eb3dcbf52dbce5f87dbc64df6aaffadcace\Qwen3.6-27B-UD-Q4_K_XL.gguf" (
  llama-cli -hf unsloth/Qwen3.6-27B-MTP-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL
)

if not exist "models\models--unsloth--Qwen3.6-35B-A3B-MTP-GGUF\snapshots\5bc3e238d916f48a861bac2f8a1990a0e9b7e98d\Qwen3.6-35B-A3B-UD-Q4_K_XL.gguf" (
  llama-cli -hf unsloth/Qwen3.6-35B-A3B-MTP-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL
)

if not exist "models\models--unsloth--gemma-4-31B-it-qat-GGUF\snapshots\1f1e54258d4a2cf7522856a5789045d9f2ea6d16\gemma-4-31B-it-qat-UD-Q4_K_XL.gguf" (
  llama-cli -hf unsloth/gemma-4-31B-it-qat-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL
)

if not exist "models\models--unsloth--gemma-4-26B-A4B-it-qat-GGUF\snapshots\c1f25db7cf31985b52caa1db777eb72d17ca1c7c\gemma-4-26B-A4B-it-qat-UD-Q4_K_XL.gguf" (
  llama-cli -hf unsloth/gemma-4-26B-A4B-it-qat-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL
)

if not exist "models\models--unsloth--North-Mini-Code-1.0-GGUF\snapshots\e306bb4bf0df610f5471d97a01de2b6e0b24d356\North-Mini-Code-1.0-UD-Q4_K_XL.gguf" (
  llama-cli -hf unsloth/North-Mini-Code-1.0-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL
)

if not exist "models\models--unsloth--Laguna-S-2.1-GGUF\snapshots\0d1759155994f502f12d8ce84d73cf316e00f42e\Laguna-S-2.1-UD-Q2_K_XL.gguf" (
  llama-cli -hf unsloth/Laguna-S-2.1-GGUF:UD-Q2_K_XL -st -p "hi" -n 1 < NUL
)

if not exist "models\models--unsloth--Muse-Glimmer-30B-GGUF\snapshots\faa5b025c584459c13febfa5c59883516710ae39\Muse-Glimmer-30B-UD-Q4_K_XL.gguf" (
  llama-cli -hf unsloth/Muse-Glimmer-30B-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL
)

if not exist "models\models--unsloth--Qwen3.8-27B-GGUF\snapshots\f1bfb127c64f7072bdd2cad55f258b9c8b2910fe\Qwen3.8-27B-UD-Q4_K_XL.gguf" (
  llama-cli -hf unsloth/Qwen3.8-27B-GGUF:UD-Q4_K_XL -st -p "hi" -n 1 < NUL
)

@REM DeepSeek-V4-Flash-0731 UD-IQ2_XXS is split into 3 shards (00001-00003 of 00003); -hf
@REM fetches all shards automatically when given the quant tag, same as any other quant
@REM here. Checked against the last shard so an interrupted/partial download re-runs
@REM (llama-cli -hf resumes rather than re-fetching completed shards).
if not exist "models\models--unsloth--DeepSeek-V4-Flash-0731-GGUF\snapshots\fbbb5b93fb787c21338159b0af3318bb3f4d9768\UD-IQ2_XXS\DeepSeek-V4-Flash-0731-UD-IQ2_XXS-00003-of-00003.gguf" (
  llama-cli -hf unsloth/DeepSeek-V4-Flash-0731-GGUF:UD-IQ2_XXS -st -p "hi" -n 1 < NUL
)

@REM Qwen3.8-Flash-Next UD-Q2_K_XL is also split into 3 shards; -hf fetches them all.
@REM Its root-level MTP/ folder isn't fetched -- not usable yet, --spec-type draft-mtp
@REM support for this arch (llama.cpp PR #28243) is still unmerged (see models.ini).
if not exist "models\models--unsloth--Qwen3.8-Flash-Next-GGUF\snapshots\38bb39ee97821de2c9009abb7e93950eec396e66\UD-Q2_K_XL\Qwen3.8-Flash-Next-UD-Q2_K_XL-00003-of-00003.gguf" (
  llama-cli -hf unsloth/Qwen3.8-Flash-Next-GGUF:UD-Q2_K_XL -st -p "hi" -n 1 < NUL
)

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

@REM DSpark draft model isn't fetched by -hf either (root-level file, doesn't match the
@REM quant-tag naming pattern) -- needed now that models.ini's deepseek-v4-flash-0731
@REM entry uses it as model-draft for --spec-type draft-dspark.
for /f "delims=" %%H in (models\models--unsloth--DeepSeek-V4-Flash-0731-GGUF\refs\main) do set "DEEPSEEK_HASH=%%H"
if not exist "models\models--unsloth--DeepSeek-V4-Flash-0731-GGUF\snapshots\%DEEPSEEK_HASH%\dspark-DeepSeek-V4-Flash-0731-Q8_0.gguf" (
  curl -L -o "models\models--unsloth--DeepSeek-V4-Flash-0731-GGUF\snapshots\%DEEPSEEK_HASH%\dspark-DeepSeek-V4-Flash-0731-Q8_0.gguf" "https://huggingface.co/unsloth/DeepSeek-V4-Flash-0731-GGUF/resolve/main/dspark-DeepSeek-V4-Flash-0731-Q8_0.gguf"
)
