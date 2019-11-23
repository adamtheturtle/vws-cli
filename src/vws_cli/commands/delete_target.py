import sys

import click
from vws import VWS
from vws.exceptions import UnknownTarget

from vws_cli.options.credentials import (
    server_access_key_option,
    server_secret_key_option,
)
from vws_cli.options.targets import target_id_option


@click.command(name='delete-target')
@server_access_key_option
@server_secret_key_option
@target_id_option
def delete_target(
    server_access_key: str,
    server_secret_key: str,
    target_id: str,
) -> None:
    vws_client = VWS(
        server_access_key=server_access_key,
        server_secret_key=server_secret_key,
    )

    try:
        vws_client.delete_target(target_id=target_id)
    except UnknownTarget:
        click.echo(f'Target "{target_id}" does not exist.', err=True)
        sys.exit(1)