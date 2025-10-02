"""refactor

Revision ID: 241fd68a9462
Revises: 9550dffe1c7c
Create Date: 2025-09-27 22:38:23.700313

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '241fd68a9462'
down_revision: Union[str, Sequence[str], None] = '9550dffe1c7c'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    pass


def downgrade() -> None:
    """Downgrade schema."""
    pass
