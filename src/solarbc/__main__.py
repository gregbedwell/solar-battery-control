"""Entry point for the Solar Battery Control application."""

from loguru import logger

from solarbc.app import app


@app.command()
def main():
    """Say hello."""
    logger.info("[bold green]Hello, World![/]")


if __name__ == "__main__":
    app()
