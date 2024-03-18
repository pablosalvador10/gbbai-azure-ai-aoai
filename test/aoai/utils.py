"""
This script contains a utility function for interacting with the Azure OpenAI API.
"""

from requests import Response

from typing import Dict, List, Optional


def extract_rate_limit_and_usage_info(response: Response) -> Dict[str, Optional[int]]:
    """
    Extracts rate limiting information from the Azure Open API response headers and usage information from the payload.

    :param response: The response object returned by a requests call.
    :return: A dictionary containing the remaining requests, remaining tokens, and usage information
            including prompt tokens, completion tokens, total tokens, utilization, and retry after ms.
    """
    headers = response.headers
    usage = response.json().get("usage", {})
    return {
        "remaining-requests": headers.get("x-ratelimit-remaining-requests"),
        "remaining-tokens": headers.get("x-ratelimit-remaining-tokens"),
        "prompt-tokens": usage.get("prompt_tokens"),
        "completion_tokens": usage.get("completion_tokens"),
        "total_tokens": usage.get("total_tokens"),
        "utilization": headers.get("azure-openai-deployment-utilization"),
        "retry-after-ms": headers.get("retry-after-ms"),
    }