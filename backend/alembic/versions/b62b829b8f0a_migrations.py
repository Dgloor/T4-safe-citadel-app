"""migrations

Revision ID: b62b829b8f0a
Revises: 9b2cadb7b34b
Create Date: 2023-06-14 01:04:43.701806

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = 'b62b829b8f0a'
down_revision = '9b2cadb7b34b'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column('visitor', 'updated_date')
    op.drop_column('visitor', 'created_date')
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('visitor', sa.Column('created_date', postgresql.TIMESTAMP(), autoincrement=False, nullable=True))
    op.add_column('visitor', sa.Column('updated_date', postgresql.TIMESTAMP(), autoincrement=False, nullable=True))
    # ### end Alembic commands ###