"""rename_columns_to_english

Revision ID: 46b8ebf5be45
Revises: 673e054cbb93
Create Date: 2025-11-08 20:54:31.662180

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '46b8ebf5be45'
down_revision: Union[str, Sequence[str], None] = '673e054cbb93'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    # Rename columns from Portuguese to English
    op.alter_column('account_families', 'cep', new_column_name='zip_code')
    op.alter_column('account_families', 'rua', new_column_name='street')
    op.alter_column('account_families', 'numero', new_column_name='number')
    op.alter_column('account_families', 'bairro', new_column_name='neighborhood')
    op.alter_column('account_families', 'estado', new_column_name='state')
    op.alter_column('account_families', 'renda', new_column_name='income')
    
    # Update constraint names
    op.execute('ALTER TABLE account_families DROP CONSTRAINT IF EXISTS check_estado_length')
    op.execute('ALTER TABLE account_families DROP CONSTRAINT IF EXISTS check_renda_positive')
    op.execute('ALTER TABLE account_families ADD CONSTRAINT check_state_length CHECK (length(state) = 2)')
    op.execute('ALTER TABLE account_families ADD CONSTRAINT check_income_positive CHECK (income >= 0)')


def downgrade() -> None:
    """Downgrade schema."""
    # Rename columns back from English to Portuguese
    op.alter_column('account_families', 'zip_code', new_column_name='cep')
    op.alter_column('account_families', 'street', new_column_name='rua')
    op.alter_column('account_families', 'number', new_column_name='numero')
    op.alter_column('account_families', 'neighborhood', new_column_name='bairro')
    op.alter_column('account_families', 'state', new_column_name='estado')
    op.alter_column('account_families', 'income', new_column_name='renda')
    
    # Restore original constraint names
    op.execute('ALTER TABLE account_families DROP CONSTRAINT IF EXISTS check_state_length')
    op.execute('ALTER TABLE account_families DROP CONSTRAINT IF EXISTS check_income_positive')
    op.execute('ALTER TABLE account_families ADD CONSTRAINT check_estado_length CHECK (length(estado) = 2)')
    op.execute('ALTER TABLE account_families ADD CONSTRAINT check_renda_positive CHECK (renda >= 0)')
