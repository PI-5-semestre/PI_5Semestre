"""rename visit

Revision ID: b0e292b831c5
Revises: 888cab4651a1
Create Date: 2025-10-19 12:21:50.705502

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision: str = 'b0e292b831c5'
down_revision: Union[str, Sequence[str], None] = '888cab4651a1'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    # Add family_id as nullable first
    op.add_column('visitfamilies', sa.Column('family_id', sa.Integer(), nullable=True))
    
    # Populate family_id with values from id_family
    op.execute("UPDATE visitfamilies SET family_id = id_family")
    
    # Now make it NOT NULL
    op.alter_column('visitfamilies', 'family_id', nullable=False)
    
    # Add visit_date as nullable first
    op.add_column('visitfamilies', sa.Column('visit_date', sa.DateTime(), nullable=True))
    
    # Populate visit_date with values from day_visit if exists, else current timestamp
    op.execute("UPDATE visitfamilies SET visit_date = COALESCE(day_visit, CURRENT_TIMESTAMP)")
    
    # Now make it NOT NULL
    op.alter_column('visitfamilies', 'visit_date', nullable=False)
    
    # Add attempt_count as nullable first
    op.add_column('visitfamilies', sa.Column('attempt_count', sa.Integer(), nullable=True))
    
    # Populate attempt_count with values from quantity if exists, else 0
    op.execute("UPDATE visitfamilies SET attempt_count = COALESCE(quantity, 0)")
    
    # Now make it NOT NULL
    op.alter_column('visitfamilies', 'attempt_count', nullable=False)
    
    # Alter description length
    op.alter_column('visitfamilies', 'description',
               existing_type=sa.VARCHAR(length=255),
               type_=sa.String(length=500),
               existing_nullable=True)
    
    # Drop old foreign key and create new one
    op.drop_constraint(op.f('visitfamilies_id_family_fkey'), 'visitfamilies', type_='foreignkey')
    op.create_foreign_key(None, 'visitfamilies', 'families', ['family_id'], ['id'])
    
    # Drop old columns
    op.drop_column('visitfamilies', 'quantity')
    op.drop_column('visitfamilies', 'day_visit')
    op.drop_column('visitfamilies', 'id_family')


def downgrade() -> None:
    """Downgrade schema."""
    # Reverse the changes
    op.add_column('visitfamilies', sa.Column('id_family', sa.INTEGER(), autoincrement=False, nullable=False))
    op.add_column('visitfamilies', sa.Column('day_visit', postgresql.TIMESTAMP(), autoincrement=False, nullable=False))
    op.add_column('visitfamilies', sa.Column('quantity', sa.INTEGER(), autoincrement=False, nullable=False))
    
    # Populate old columns
    op.execute("UPDATE visitfamilies SET id_family = family_id, day_visit = visit_date, quantity = attempt_count")
    
    # Drop new foreign key and create old one
    op.drop_constraint(None, 'visitfamilies', type_='foreignkey')
    op.create_foreign_key(op.f('visitfamilies_id_family_fkey'), 'visitfamilies', 'families', ['id_family'], ['id'])
    
    # Alter description back
    op.alter_column('visitfamilies', 'description',
               existing_type=sa.String(length=500),
               type_=sa.VARCHAR(length=255),
               existing_nullable=True)
    
    # Drop new columns
    op.drop_column('visitfamilies', 'attempt_count')
    op.drop_column('visitfamilies', 'visit_date')
    op.drop_column('visitfamilies', 'family_id')
