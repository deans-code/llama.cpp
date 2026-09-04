# Follow-ups

Things worth re-checking later, mostly upstream llama.cpp PRs that were
unmerged/broken/unverified at the time an entry was added to `models.ini`.
Each item names what to check and where the relevant context lives.

## qwen3.8-flash-next

- **MTP speculative decoding**: `--spec-type draft-mtp` support for this
  arch is ggml-org/llama.cpp#28243, still open/draft as of 2026-09-04 (last
  checked same day). The repo ships a root-level `MTP/` folder that isn't
  fetched by `download-models.bat` yet. Once merged: add the MTP file fetch,
  add `model-draft`/`spec-type = draft-mtp`/`spec-draft-n-max` to the entry.
- **Quantized KV cache**: currently overridden to `cache-type-k/-v = f16`
  (against the `[*]` wildcard's `q8_0`) on the strength of a single report
  (hospedales.com) describing a crash. Never independently re-tested against
  the build that fixed the `qwen4exp` "unknown architecture" error
  (b10795-6703d7894) or later. Try `q8_0` on a current build; if it works,
  drop the override (saves KV cache memory).
- **`-ot "ple_ngram_embd=CPU"`**: taken from a single-source X/Twitter post
  by the PR author, never independently verified. Confirm it actually keeps
  the n-gram embedding table off the Vulkan backend (and is still the
  correct tensor-name pattern) rather than silently being a no-op.
- **mmproj auto-selection**: `-hf`'s default mmproj pick for this repo was
  never verified against the `mmproj-BF16.gguf` path hardcoded in
  `models.ini` (Muse Glimmer's `-hf` pull silently picked the wrong one
  once, see that entry's history). Confirm the downloaded file actually
  matches, or add an explicit fetch override like Muse Glimmer's.

## deepseek-v4-flash-0731

- **Quantized KV cache**: overridden to `f16` because
  ggml-org/llama.cpp#26423 (closed "not planned") showed the arch-scoped
  rotation-disable fix (#25391) was closed unmerged, i.e. `q8_0` K-cache was
  still corrupting output. Re-check upstream status and try `q8_0` again if
  it's actually been fixed since -- would meaningfully cut this entry's
  tightest resource (memory).
- **`swa-full`**: left unset since it's unclear whether it does anything for
  this arch's CSA/HCA compressed-attention wrapper caches (as opposed to the
  standard SWA cache path the flag was written for). Worth confirming either
  way once there's clearer documentation or someone's tested it.
- **ctx-size / KV-cache sizing**: the ~21KB/token estimate is a rough
  approximation (dense-layer cost divided by each layer's `compress_ratios`
  entry), not verified against llama.cpp's actual implementation of CSA/HCA.
  If real memory headroom turns out bigger than estimated, `ctx-size` could
  likely go up from 131072; if smaller, it needs to come down. Check actual
  memory usage against the estimate next time this model is run.
- **UD-Q2_K_XL variant**: this was raised as a possible upgrade from
  UD-IQ2_XXS but never resolved -- decide whether to replace the existing
  entry or add a second one, given the larger quant's memory footprint is
  even tighter against the 112GB budget.

## Not yet added

- **GLM-5.3-Flash** (`unsloth/GLM-5.3-Flash-GGUF`, UD-IQ2_XXS requested):
  not added at all. `glm5next` arch has two competing unmerged PRs
  (ggml-org/llama.cpp#27752, #27754), both still open/draft as of
  2026-09-04, with known bugs (deep-context collapse, a Metal int32
  overflow addressed separately in #28210). Unsloth's own docs currently
  require building from their fork (`unslothai/llama.cpp`,
  `glm5next/upstream` branch) rather than mainline/winget. Revisit once one
  of the PRs merges into mainline; re-check quant sizing against whatever
  the actual memory budget is at that time (last known: UD-IQ2_XXS ~102GB).

## General

- All entries added this session assume specific llama.cpp winget build
  states at the time of writing; re-verify architecture support, known
  bugs, and flag names against `llama-server --help` / `llama-cli --help`
  on whatever build is current when picking this list back up, since this
  is unusually fast-moving territory (several arches merged within days of
  these models' release).
