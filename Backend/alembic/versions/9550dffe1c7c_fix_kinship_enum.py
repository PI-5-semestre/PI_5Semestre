"""fix_kinship_enum

Revision ID: 9550dffe1c7c
Revises: 5328d24d81c4
Create Date: 2025-09-21 19:15:34.210408

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '9550dffe1c7c'
down_revision: Union[str, Sequence[str], None] = '5328d24d81c4'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    # Primeiro, remover o enum existente e recriar com os valores corretos
    op.execute("DROP TYPE IF EXISTS kinshiptype CASCADE")
    
    # Criar o enum com todos os valores corretos
    op.execute("""
    CREATE TYPE kinshiptype AS ENUM (
        'PARENTS',
        'CHILDREN', 
        'SIBLINGS',
        'SPOUSE',
        'GRANDPARENTS',
        'GRANDCHILDREN',
        'UNCLES_AUNTS',
        'NEPHEWS_NIECES',
        'COUSINS',
        'PARENTS_IN_LAW',
        'CHILD_IN_LAW',
        'SIBLINGS_IN_LAW',
        'STEP_PARENTS',
        'STEP_CHILDREN',
        'GODPARENTS',
        'GODCHILDREN',
        'OTHER'
    )
    """)
    
    # Recriar a coluna kinship na tabela family_authorized_accounts
    op.execute("ALTER TABLE family_authorized_accounts ADD COLUMN kinship_new kinshiptype")
    op.execute("ALTER TABLE family_authorized_accounts DROP COLUMN IF EXISTS kinship")
    op.execute("ALTER TABLE family_authorized_accounts RENAME COLUMN kinship_new TO kinship")


def downgrade() -> None:
    """Downgrade schema."""
    # Reverter as mudanças se necessário
    op.execute("ALTER TABLE family_authorized_accounts DROP COLUMN IF EXISTS kinship")
    op.execute("DROP TYPE IF EXISTS kinshiptype")
