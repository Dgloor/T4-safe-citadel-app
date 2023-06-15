"""migrations

Revision ID: 99918de266dd
Revises: aa487e6c68c7
Create Date: 2023-06-14 13:00:05.216689

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '99918de266dd'
down_revision = 'aa487e6c68c7'
branch_labels = None
depends_on = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('residence', sa.Column('resident_id', sa.UUID(), nullable=True))
    op.create_foreign_key(None, 'residence', 'resident', ['resident_id'], ['id'])
    op.drop_constraint('resident_residence_id_fkey', 'resident', type_='foreignkey')
    op.drop_column('resident', 'residence_id')
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('resident', sa.Column('residence_id', sa.UUID(), autoincrement=False, nullable=True))
    op.create_foreign_key('resident_residence_id_fkey', 'resident', 'residence', ['residence_id'], ['id'])
    op.drop_constraint(None, 'residence', type_='foreignkey')
    op.drop_column('residence', 'resident_id')
    # ### end Alembic commands ###