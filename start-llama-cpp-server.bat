@echo off
choice /c YN /n /m "Check for and install a llama.cpp update via winget before starting the server? [Y/N] "
if errorlevel 2 goto skip_update
winget upgrade --id ggml.llamacpp -e --accept-package-agreements --accept-source-agreements
:skip_update

llama-server ^
  --models-preset models.ini ^
  --models-max 4 ^
  --host 0.0.0.0 ^
  --port 8080
