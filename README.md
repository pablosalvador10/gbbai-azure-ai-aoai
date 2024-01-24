# Azure AI Solutions Quick Start Template <img src="./utils/images/azure_logo.png" alt="Azure Logo" style="width:30px;height:30px;"/>

Welcome to the Azure AI Solutions Quick Start Template! This repository is designed to be a rapid launchpad for your Azure AI projects. Whether you're working in an enterprise or academic environment, this template integrates best practices to ensure a smooth development journey from start to finish.

## 💼 Using this Template: Your Gateway to Advanced AI Development & Collaboration!

- **🔄 Development Workflow**: Get to know our optimized workflow, designed to foster effective collaboration and a focus on product-centric development. See our [CONTRIBUTING GUIDE](./CONTRIBUTING.md) for more details.

- **🚀 Advanced AI Development Process**: Understand the specifics of managing Azure AI projects, from issue reporting to pull requests, while adhering to best practices in advanced feature development and complex system troubleshooting.

- **🔍 Testing & QA for AI Systems**: Learn about the importance of rigorous testing in AI projects and discover efficient development and testing techniques tailored for AI systems with tools like Jupyter Notebooks and `%%ipytest`.

- **🔢 Version & Branching Strategies for AI Projects**: Get to know our versioning system and explore the project’s branching strategy, which ensures smooth transitions between development, staging, and production, especially for AI-driven applications.

- To stay updated with the latest developments and document significant changes to this project, please refer to [CHANGELOG.md](CHANGELOG.md).

## 🔧 Prerequisites

Please make sure you have met all the prerequisites for this project. A detailed guide on how to set up your environment and get ready to run all the notebooks and code in this repository can be found in the [SETTINGS.md](SETTINGS.md) file. Please follow the instructions there to ensure a smooth exprience.

## 🌲 Project Tree Structure

```markdown
📂 gbbai-azure-ai-template
┣ 📂 notebooks <- For development, EDA, and quick testing (Jupyter notebooks for analysis and development).
┣ 📂 src <- Houses main source code for data processing, feature engineering, modeling, inference, and evaluation.
┣ 📂 test <- Runs unit and integration tests for code validation and QA.
┣ 📂 utils <- Contains utility functions and shared code used throughout the project.
┣ 📜 .env.sample <- Sample environment variables file. Replace with your own.
┣ 📜 .pre-commit-config.yaml <- Config for pre-commit hooks ensuring code quality and consistency.
┣ 📜 01-workshop.ipynb <- Jupyter notebook for the workshop.
┣ 📜 CHANGELOG.md <- Logs project changes, updates, and version history.
┣ 📜 USAGE.md <- Guidelines for using this template.
┣ 📜 environment.yaml <- Conda environment configuration.
┣ 📜 Makefile <- Simplifies common development tasks and commands.
┣ 📜 pyproject.toml <- Configuration file for build system requirements and packaging-related metadata.
┣ 📜 README.md <- Overview, setup instructions, and usage details of the project.
┣ 📜 requirements-codequality.txt <- Requirements for code quality tools and libraries.
┣ 📜 requirements.txt <- General project dependencies.
```