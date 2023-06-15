"""migrations

Revision ID: b8cfb3868838
Revises: 0cca0828c813
Create Date: 2023-06-14 14:55:05.133271

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'b8cfb3868838'
down_revision = '0cca0828c813'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('resident', sa.Column('residence_id', sa.UUID(), nullable=True))
    op.create_foreign_key(None, 'resident', 'residence', ['residence_id'], ['id'])
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint(None, 'resident', type_='foreignkey')
    op.drop_column('resident', 'residence_id')
    # ### end Alembic commands ###
