# Resources for running Llama.cpp locally

## :movie_camera: Background

I have explored running language models locally using [LM Studio](https://lmstudio.ai/), and [Ollama](https://ollama.com/).

Under the hood both of these tools use [Llama.cpp](https://github.com/ggml-org/llama.cpp) runtimes.

I am now exploring using Llama.cpp directly to run local LLMs, primarily as a server for integration into applications and CLIs, such as using the [OpenCode](https://github.com/sst/opencode) CLI against a locally hosted model instead of a cloud provider.

## :white_check_mark: Scope

- [x] Configure Llama.cpp environment.
- [x] Create script to execute Llama.cpp with predefined parameters.
- [x] Add support for multiple LLMs.
- [x] Support per-model parameters, for tweaking settings based on model performance.
- [x] Integrate into OpenCode.
- [x] Identify method for verifying GPU offload.
- [x] Apply AI generated optimial llama-server parameter values.

## :telescope: Future Gazing

- [ ] Design method of benchmarking performance, automate repeatable tests.
- [ ] Apply improvements to each model execution using benchmarking results.

## :beetle: Known defects

No known defects.

## :crystal_ball: Use of AI

[GitHub Copilot](https://github.com/features/copilot) and [Claude Code](https://claude.com/product/claude-code) were used to assist in the development of this software.

## :rocket: Getting Started

### :computer: System Requirements

#### Software

![Windows](https://img.shields.io/badge/Windows-11-blueviolet "Windows")
![Llama.cpp](https://img.shields.io/badge/LM_Studio-latest-blueviolet "LLama.cpp")
![VS Code Insiders](https://img.shields.io/badge/VS_Code_Insiders-latest-blueviolet "VS Code Insiders")
![Windows Terminal](https://img.shields.io/badge/Windows_Terminal-latest-blueviolet "Windows Terminal")
![GPU-Z](https://img.shields.io/badge/GPU--Z-latest-blueviolet "GPU-Z")

> [!NOTE]
> Other operating systems and versions will work, where versions are specified treat as minimums.

> [!NOTE]
> TechPowerUp's [GPU-Z](https://www.techpowerup.com/gpuz/) is optional. This application provides a simple method of verifying GPU offload.

#### Hardware

A system capable of running Llama.cpp is required.

Details of my personal system are below.

![APU](https://img.shields.io/badge/APU-AMD_Ryzen_AI_Max_395+-yellow "APU")

> [!NOTE]
> The hardware in use on my PC includes an Accelerated Processor Unit (APU) which combines CPU and GPU on a single chip. Llama.cpp is focused on supporting a [wide range of hardware](https://github.com/ggml-org/llama.cpp?tab=readme-ov-file#description). Performance will depend upon your hardware, the use of CPU v GPU, the models you choose to run and other operational factors.

### :floppy_disk: System Configuration

Installation of Llama.cpp via Winget, no other configuration needed.

> [!NOTE]
> Works on my machine!

### :wrench: Development Setup

Clone the repository.

Run `download-models.bat` to fetch the models defined in `models.ini` from Hugging Face into the `models` directory.

> [!NOTE]
> `models.ini` shows which models I am currently experimenting with, and defines their per-model server settings (context size, sampling parameters, speculative decoding, vision support, etc.). Edit this file to add, remove, or tune models.

Scripts can be executed within the VS Code terminal window, or via any other supported terminal e.g. Windows Terminal.

## :zap: Features

- `download-models.bat` fetches and caches each configured model from Hugging Face.
- `start-llama-cpp-server.bat` launches Llama.cpp's server in router mode, serving every model defined in `models.ini` simultaneously over HTTP; which model to use is chosen per-request via the API's `model` field, no restart required to switch.
- Per-model configuration via `models.ini`, including speculative decoding (MTP draft models) and vision (multimodal projector) support where the model provides them.

## :paperclip: Usage

Run `download-models.bat` once to fetch the models configured in `models.ini`.

Run `start-llama-cpp-server.bat` to start the Llama.cpp server. All configured models are served over HTTP (default `http://0.0.0.0:8080`); select which one to use via the `model` field in each API request.

> [!NOTE]
> The server binds to `0.0.0.0` rather than `127.0.0.1` so that OpenCode running under WSL can reach it across the WSL/Windows network boundary.

Run GPU-Z to verify GPU offload.

## :raised_hands: Thanks

Thanks to [Nico Domino](https://github.com/ndom91) who shared his [GLM-4.7-Flash Strix Halo Docker setup](https://github.com/ndom91/GLM-4.7-Flash-Strix-Halo), I used this as a basis for running my own local Llama.cpp server.

Thanks also to the open source contributors of [Llama.cpp](https://github.com/ggml-org/llama.cpp).

## :wave: Contributing

This repository was created primarily for my own exploration of the technologies involved.

## :gift: License

I have selected an appropriate license using [this tool](https://choosealicense.com/).

This software is licensed under the [MIT](LICENSE) license.

## :book: Further reading

More detailed information can be found in the documentation:
* [Resources](docs/resources.md)
* [llama-server parameters](docs/llama-server-parameters.md)