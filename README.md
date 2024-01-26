# <img src="./utils/images/azure_logo.png" alt="Azure Logo" style="width:30px;height:30px;"/> Decoding Azure OpenAI

Welcome to "Decoding Azure OpenAI: A Developer's Guide". This comprehensive guide is tailored to assist developers in constructing robust Large Language Model (LLM) architectures and applications using Azure OpenAI as the core processing engine. The goal is to tackle the complexities developers encounter, offer pragmatic solutions to intricate challenges, and unlock the immense potential of Azure's OpenAI services.


## 🛠️ From Challenges to Solutions

The series embraces a focused problem-solution framework, pairing each challenge with a detailed article and a complementary Jupyter notebook. This structured approach ensures a comprehensive understanding of the solution conceptually and practically.


| 🚩 **Challenge** | 📚 **Article** | 📓 **Practice** |
|:----------------:|:--------------:|:---------------:|
| Unpacking Azure OpenAI API Headers | [Read Article](https://medium.com/p/6dbe881e732a/edit) | [Try It Out](https://github.com/your-repo/notebook-link-for-rate-limits) |


New entries will be added regularly, broadening your practical knowledge and skills in applying Azure OpenAI to real-world challenges. This resource is crafted for anyone looking to deepen their understanding and hands-on experience with Azure OpenAI technologies.

## 🔧 Prerequisites

Please make sure you have met all the prerequisites for this project. A detailed guide on how to set up your environment and get ready to run all the notebooks and code in this repository can be found in the [SETTINGS.md](SETTINGS.md) file. Please follow the instructions there to ensure a smooth exprience.

## 🌲 Project Tree Structure

```markdown
📂 gbbai-azure-ai-aoai
┣ 📂 notebooks <- For development, EDA, and quick testing (Jupyter notebooks for analysis and development).
┣ 📂 src <- Houses main source code for data processing, feature engineering, modeling, inference, and evaluation.
┣ 📂 test <- Runs unit and integration tests for code validation and QA.
┣ 📂 utils <- Contains utility functions and shared code used throughout the project.
┣ 📜 .env.sample <- Sample environment variables file. Replace with your own.
┣ 📜 .pre-commit-config.yaml <- Config for pre-commit hooks ensuring code quality and consistency.
┣ 📜 01-headers-api-response.ipynb <- Jupyter notebook for the workshop.
┣ 📜 CHANGELOG.md <- Logs project changes, updates, and version history.
┣ 📜 environment.yaml <- Conda environment configuration.
┣ 📜 Makefile <- Simplifies common development tasks and commands.
┣ 📜 pyproject.toml <- Configuration file for build system requirements and packaging-related metadata.
┣ 📜 README.md <- Overview, setup instructions, and usage details of the project.
┣ 📜 requirements-codequality.txt <- Requirements for code quality tools and libraries.
┣ 📜 requirements.txt <- General project dependencies.
```