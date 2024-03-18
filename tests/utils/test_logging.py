import logging

import pytest

from utils.ml_logging import KEYINFO_LEVEL_NUM, get_logger


# Patch the logging module during the tests to capture log records
@pytest.fixture
def caplog(caplog):
    """
    Fixture to set the logging level to DEBUG for the tests.
    """
    caplog.set_level(logging.DEBUG)
    return caplog


def test_get_logger_default_level(caplog):
    """
    Test that the default logging level is INFO.
    """
    logger = get_logger()
    test_message = "This is an INFO message"

    logger.info(test_message)

    assert len(caplog.records) == 1
    assert caplog.records[0].levelname == "INFO"
    assert caplog.records[0].msg == test_message


def test_get_logger_custom_level(caplog):
    """
    Test that the logging level can be set to a custom level (WARNING).
    """
    logger = get_logger(level=logging.WARNING)
    test_message = "This is a WARNING message"

    logger.warning(test_message)

    assert len(caplog.records) == 1
    assert caplog.records[0].levelname == "WARNING"
    assert caplog.records[0].msg == test_message


def test_get_logger_keyinfo_level(caplog):
    """
    Test that the logging level can be set to a custom level (KEYINFO).
    """
    logger = get_logger(level=KEYINFO_LEVEL_NUM)
    test_message = "This is a KEYINFO message"

    logger.log(KEYINFO_LEVEL_NUM, test_message)

    assert len(caplog.records) == 1
    assert caplog.records[0].levelname == "KEYINFO"
    assert caplog.records[0].msg == test_message
