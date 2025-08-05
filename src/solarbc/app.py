"""Typer app."""

from loguru import logger
from rich.logging import RichHandler
from typer import Typer

# Reconfigure loguru to use RichHandler
logger.remove()
logger.add(
    RichHandler(markup=True, rich_tracebacks=True), format="{message}", level="INFO"
)


app = Typer()
