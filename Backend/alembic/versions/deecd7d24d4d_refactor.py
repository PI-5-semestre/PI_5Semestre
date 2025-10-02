"""refactor

Revision ID: deecd7d24d4d
Revises: 241fd68a9462
Create Date: 2025-09-27 23:31:42.865154

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = 'deecd7d24d4d'
down_revision: Union[str, Sequence[str], None] = '241fd68a9462'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    pass


def downgrade() -> None:
    """Downgrade schema."""
    pass
