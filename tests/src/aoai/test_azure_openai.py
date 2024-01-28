"""
This script is a test suite for validating the functionality of the Azure OpenAI API interactions within our application.
"""

import logging
from unittest.mock import MagicMock, patch

from src.aoai.azure_openai import AzureOpenAIManager

# Create a logger
logger = logging.getLogger(__name__)


@patch.object(AzureOpenAIManager, "get_azure_openai_client")
def test_generate_completion_response(mock_openai_client):
    # Arrange
    mock_response = MagicMock()
    mock_choice = MagicMock()
    mock_choice.text = "test completion"
    mock_response.choices = [mock_choice]
    mock_openai_client.completions.create.return_value = mock_response

    manager = AzureOpenAIManager(
        api_key="test_key", azure_endpoint="test_endpoint", chat_model_name="test_model"
    )

    # Act
    completion = manager.generate_completion_response(query="test query")

    # Log intermediate output
    logger.info(f"Completion: {completion}")

    # Assert
    assert completion == "test completion"
    mock_openai_client.completions.create.assert_called_once()


@patch.object(AzureOpenAIManager, "get_azure_openai_client")
def test_generate_chat_response(mock_openai_client):
    # Arrange
    mock_response = MagicMock()
    mock_response.choices[0].message.content = "test response"
    mock_openai_client.chat.completions.create.return_value = mock_response

    manager = AzureOpenAIManager(
        api_key="test_key", azure_endpoint="test_endpoint", chat_model_name="test_model"
    )

    # Act
    response = manager.generate_chat_response(
        conversation_history=[], query="test query"
    )

    # Assert
    assert response == "test response"
    mock_openai_client.chat.completions.create.assert_called_once()


@patch.object(AzureOpenAIManager, "get_azure_openai_client")
def test_generate_embedding(mock_openai_client):
    # Arrange
    mock_response = MagicMock()
    mock_response.model_dump_json.return_value = "test embedding"
    mock_openai_client.embeddings.create.return_value = mock_response

    manager = AzureOpenAIManager(
        api_key="test_key", azure_endpoint="test_endpoint", chat_model_name="test_model"
    )

    # Act
    embedding = manager.generate_embedding(input_text="test input")

    # Assert
    assert embedding == "test embedding"
    mock_openai_client.embeddings.create.assert_called_once()


@patch("requests.Session")
def test_call_azure_openai_chat_completions_api(mock_session):
    # Arrange
    mock_response = MagicMock()
    mock_response.status_code = 200
    mock_response.json.return_value = {"result": "success"}
    mock_session.return_value.__enter__.return_value.post.return_value = mock_response

    manager = AzureOpenAIManager(
        api_key="test_key", azure_endpoint="test_endpoint", chat_model_name="test_model"
    )

    # Act
    status_code, response, _ = manager.call_azure_openai_chat_completions_api(
        body={"test": "body"}
    )

    # Assert
    assert status_code == 200
    assert response == {"result": "success"}
    mock_session.return_value.__enter__.return_value.post.assert_called_once_with(
        "test_endpoint/openai/deployments/test_model/chat/completions?api-version=2023-11-01",
        json={"test": "body"},
    )
