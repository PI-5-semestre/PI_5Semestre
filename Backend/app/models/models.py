from sqlalchemy import Column, Integer, String, Boolean, DateTime, ForeignKey, Index, Enum, DECIMAL, Table, CheckConstraint, select
from sqlalchemy.orm import Mapped, mapped_column, relationship, Session
from sqlalchemy.sql import func
from sqlalchemy.dialects.postgresql import JSONB
from datetime import datetime
from enum import Enum as PyEnum
from typing import Optional, List
from decimal import Decimal
from . import Base

class AccountType(PyEnum):
    DELIVERY_MAN = "DELIVERY_MAN"
    ADMINISTRATIVE = "ADMINISTRATIVE"
    BENEFITED = "BENEFITED"
    INDEFINED = "INDEFINED"

class InstitutionType(PyEnum):
    ONGS = "ONGS"
    CHURCH = "CHURCH"

class SituationType(PyEnum):
    PENDING = "PENDING"
    ACTIVE = "ACTIVE"
    INACTIVE = "INACTIVE"
    SUSPENDED = "SUSPENDED"

class KinshipType(PyEnum):
    PARENTS = "PARENTS"
    CHILDREN = "CHILDREN"
    SIBLINGS = "SIBLINGS"
    SPOUSE = "SPOUSE"
    GRANDPARENTS = "GRANDPARENTS"
    GRANDCHILDREN = "GRANDCHILDREN"
    UNCLES_AUNTS = "UNCLES_AUNTS"
    NEPHEWS_NIECES = "NEPHEWS_NIECES"
    COUSINS = "COUSINS"
    PARENTS_IN_LAW = "PARENTS_IN_LAW"
    CHILD_IN_LAW = "CHILD_IN_LAW"
    SIBLINGS_IN_LAW = "SIBLINGS_IN_LAW"
    STEP_PARENTS = "STEP_PARENTS"
    STEP_CHILDREN = "STEP_CHILDREN"
    GODPARENTS = "GODPARENTS"
    GODCHILDREN = "GODCHILDREN"
    OTHER = "OTHER"

family_authorized_accounts = Table(
    'family_authorized_accounts',
    Base.metadata,
    Column('family_id', Integer, ForeignKey('families.id', ondelete='CASCADE'), primary_key=True),
    Column('account_id', Integer, ForeignKey('accounts.id', ondelete='CASCADE'), primary_key=True),
    Column('created', DateTime, server_default=func.now()),
    Column('active', Boolean, default=True),
    Column('login', String(200), nullable=True),
    Column('name', String(200), nullable=True),
    Column('cpf', String(11), nullable=True),
    Column('kinship', Enum(KinshipType), nullable=True),
    Index('family_auth_accounts_family_id_idx', 'family_id'),
    Index('family_auth_accounts_account_id_idx', 'account_id'),
)

class Account(Base):
    __tablename__ = 'accounts'

    id: Mapped[int] = mapped_column(primary_key=True)
    created: Mapped[datetime] = mapped_column(server_default=func.now())
    modified: Mapped[datetime] = mapped_column(
        server_default=func.now(), 
        onupdate=func.now()
    )
    active: Mapped[bool] = mapped_column(default=True)
    login: Mapped[str] = mapped_column(String(50), nullable=False, unique=True)
    senha: Mapped[str] = mapped_column(String(255), nullable=False)
    account_type: Mapped[AccountType] = mapped_column(
        Enum(AccountType), 
        nullable=False
    )
    family_id: Mapped[Optional[int]] = mapped_column(
        ForeignKey('families.id', ondelete='SET NULL', use_alter=True), 
        nullable=True
    )
    
    family: Mapped[Optional["Family"]] = relationship(
        "Family", 
        back_populates="accounts",
        foreign_keys=[family_id]
    )
    familias_responsavel: Mapped[List["Family"]] = relationship(
        "Family", 
        back_populates="responsavel",
        foreign_keys="Family.responsavel_id"
    )
    familias_autorizadas: Mapped[List["Family"]] = relationship(
        "Family",
        secondary=family_authorized_accounts,
        back_populates="contas_autorizadas"
    )

    __table_args__ = (
        Index('accounts_login_idx', 'login'),
        Index('accounts_family_id_idx', 'family_id'),
        Index('accounts_account_type_idx', 'account_type'),
        Index('accounts_active_idx', 'active'),
    )
    
    def __repr__(self):
        return f"<Account(id={self.id}, login='{self.login}', type='{self.account_type.value}')>"

class Institution(Base):
    __tablename__ = 'institutions'

    id: Mapped[int] = mapped_column(primary_key=True)
    created: Mapped[datetime] = mapped_column(server_default=func.now())
    modified: Mapped[datetime] = mapped_column(
        server_default=func.now(), 
        onupdate=func.now()
    )
    active: Mapped[bool] = mapped_column(default=True)
    name: Mapped[str] = mapped_column(String(200), nullable=False)
    institutions_type: Mapped[InstitutionType] = mapped_column(
        Enum(InstitutionType),
        nullable=False
    )
    
    __table_args__ = (
        Index('institutions_name_idx', 'name'),
        Index('institutions_type_idx', 'institutions_type'),
        Index('institutions_active_idx', 'active'),
    )
    
    def __repr__(self):
        return f"<Institution(id={self.id}, name='{self.name}', type='{self.institutions_type.value}')>"

class FamilyClosure(Base):
    __tablename__ = 'family_closure'
    
    ancestor_id: Mapped[int] = mapped_column(
        ForeignKey('families.id', ondelete='CASCADE'), 
        primary_key=True
    )
    descendant_id: Mapped[int] = mapped_column(
        ForeignKey('families.id', ondelete='CASCADE'), 
        primary_key=True
    )
    depth: Mapped[int] = mapped_column(nullable=False)
    
    ancestor: Mapped["Family"] = relationship(
        "Family", 
        foreign_keys=[ancestor_id],
        back_populates="descendant_closures"
    )
    descendant: Mapped["Family"] = relationship(
        "Family", 
        foreign_keys=[descendant_id],
        back_populates="ancestor_closures"
    )

    __table_args__ = (
        Index('family_closure_ancestor_depth_idx', 'ancestor_id', 'depth'),
        Index('family_closure_descendant_depth_idx', 'descendant_id', 'depth'),
        Index('family_closure_ancestor_id_idx', 'ancestor_id'),
        Index('family_closure_descendant_id_idx', 'descendant_id'),
    )
    
    def __repr__(self):
        return f"<FamilyClosure(ancestor={self.ancestor_id}, descendant={self.descendant_id}, depth={self.depth})>"

class Family(Base):
    __tablename__ = 'families'
    
    id: Mapped[int] = mapped_column(primary_key=True)
    created: Mapped[datetime] = mapped_column(server_default=func.now())
    modified: Mapped[datetime] = mapped_column(
        server_default=func.now(), 
        onupdate=func.now()
    )
    active: Mapped[bool] = mapped_column(default=True)

    responsavel_id: Mapped[int] = mapped_column(
        ForeignKey('accounts.id', ondelete='RESTRICT'), 
        nullable=False
    )
    responsavel: Mapped["Account"] = relationship(
        "Account",
        foreign_keys=[responsavel_id],
        back_populates="familias_responsavel"
    )

    name: Mapped[str] = mapped_column(String(200), nullable=False)
    cpf: Mapped[str] = mapped_column(String(11), nullable=False, unique=True)
    mobile: Mapped[str] = mapped_column(String(15), nullable=False)
    family_size: Mapped[int] = mapped_column(nullable=False)
    
    address: Mapped[str] = mapped_column(String(300), nullable=False)
    number: Mapped[str] = mapped_column(String(10), nullable=False)
    complement: Mapped[Optional[str]] = mapped_column(String(100), nullable=True)
    zipcode: Mapped[str] = mapped_column(String(9), nullable=False)
    district: Mapped[str] = mapped_column(String(100), nullable=False)
    city: Mapped[str] = mapped_column(String(100), nullable=False)
    state: Mapped[str] = mapped_column(String(2), nullable=False)

    proof_address: Mapped[Optional[dict]] = mapped_column(JSONB, nullable=True)

    monthly_income: Mapped[Decimal] = mapped_column(DECIMAL(10, 2), nullable=False)
    description: Mapped[Optional[str]] = mapped_column(String(500), nullable=True)
    situation_type: Mapped[SituationType] = mapped_column(
        Enum(SituationType), 
        nullable=False,
        default=SituationType.PENDING
    )
    
    accounts: Mapped[List["Account"]] = relationship(
        "Account", 
        back_populates="family",
        foreign_keys="Account.family_id"
    )
    contas_autorizadas: Mapped[List["Account"]] = relationship(
        "Account",
        secondary=family_authorized_accounts,
        back_populates="familias_autorizadas"
    )
    ancestor_closures: Mapped[List["FamilyClosure"]] = relationship(
        "FamilyClosure",
        foreign_keys="FamilyClosure.descendant_id",
        back_populates="descendant",
        cascade="all, delete-orphan"
    )
    descendant_closures: Mapped[List["FamilyClosure"]] = relationship(
        "FamilyClosure",
        foreign_keys="FamilyClosure.ancestor_id",
        back_populates="ancestor",
        cascade="all, delete-orphan"
    )
    
    __table_args__ = (
        Index('families_name_idx', 'name'),
        Index('families_cpf_idx', 'cpf'),
        Index('families_active_idx', 'active'),
        Index('families_city_idx', 'city'),
        Index('families_situation_type_idx', 'situation_type'),
        Index('families_responsavel_id_idx', 'responsavel_id'),
        Index('families_proof_address_gin_idx', 'proof_address', postgresql_using='gin'),
        CheckConstraint('family_size > 0', name='family_size_positive'),
        CheckConstraint('monthly_income >= 0', name='monthly_income_positive'),
    )
    
    @classmethod
    def create(cls, session: Session, **kwargs):
        family = cls(**kwargs)
        session.add(family)
        session.flush()
        
        closure = FamilyClosure(
            ancestor_id=family.id, 
            descendant_id=family.id, 
            depth=0
        )
        session.add(closure)
        session.flush()
        
        return family
    
    def can_add_authorized_account(self, session: Session) -> bool:
        current_count = len(self.contas_autorizadas)
        return current_count < 2
    
    def add_authorized_account(self, session: Session, account: "Account"):
        if not self.can_add_authorized_account(session):
            raise ValueError("Família já possui o máximo de 2 contas autorizadas")
        
        if account in self.contas_autorizadas:
            raise ValueError("Conta já está autorizada para esta família")
            
        if account.id == self.responsavel_id:
            raise ValueError("Responsável não precisa ser adicionado como conta autorizada")
        
        self.contas_autorizadas.append(account)
        session.flush()
    
    def remove_authorized_account(self, session: Session, account: "Account"):
        if account not in self.contas_autorizadas:
            raise ValueError("Conta não está autorizada para esta família")
        
        self.contas_autorizadas.remove(account)
        session.flush()
    
    def get_all_authorized_accounts(self, session: Session) -> List["Account"]:
        authorized = [self.responsavel]
        authorized.extend(self.contas_autorizadas)
        return authorized
    
    def count_authorized_accounts(self) -> int:
        return 1 + len(self.contas_autorizadas)
    
    def can_account_receive_basket(self, account: "Account") -> bool:
        if account.id == self.responsavel_id:
            return True
        return account in self.contas_autorizadas
    
    def set_proof_address(self, filename: str, file_path: str, file_url: str = None, 
                         file_size: int = None, content_type: str = None):
        self.proof_address = {
            'filename': filename,
            'path': file_path,
            'url': file_url or file_path,
            'size': file_size,
            'content_type': content_type,
            'uploaded_at': datetime.now().isoformat()
        }
    
    def set_proof_address_simple(self, url_or_path: str):
        self.proof_address = {
            'url': url_or_path,
            'path': url_or_path,
            'uploaded_at': datetime.now().isoformat()
        }
    
    def get_proof_address_url(self) -> Optional[str]:
        if not self.proof_address:
            return None
        return self.proof_address.get('url') or self.proof_address.get('path')
    
    def get_proof_address_info(self) -> Optional[dict]:
        return self.proof_address
    
    def get_proof_address_filename(self) -> Optional[str]:
        if not self.proof_address:
            return None
        return self.proof_address.get('filename')
    
    def get_proof_address_size(self) -> Optional[int]:
        if not self.proof_address:
            return None
        return self.proof_address.get('size')
    
    def remove_proof_address(self):
        self.proof_address = None
    
    @property 
    def has_proof_address(self) -> bool:
        return (self.proof_address is not None and 
                bool(self.proof_address.get('path') or self.proof_address.get('url')))
    
    def can_add_child(self, session: Session, child: "Family") -> bool:
        if child.id == self.id:
            return False
            
        existing = session.query(FamilyClosure).filter(
            FamilyClosure.ancestor_id == child.id,
            FamilyClosure.descendant_id == self.id
        ).first()
        
        return existing is None
    
    def has_parent(self, session: Session) -> bool:
        parent = self.get_parent(session)
        return parent is not None
    
    def add_child(self, session: Session, child: "Family"):
        if not self.can_add_child(session, child):
            raise ValueError(f"Cannot add child {child.name}: would create a cycle")
        
        if child.has_parent(session):
            raise ValueError(f"Child {child.name} already has a parent")
        
        try:
            direct_relation = FamilyClosure(
                ancestor_id=self.id, 
                descendant_id=child.id, 
                depth=1
            )
            session.add(direct_relation)
            
            parent_ancestors = session.query(FamilyClosure).filter(
                FamilyClosure.descendant_id == self.id
            ).all()
            
            child_descendants = session.query(FamilyClosure).filter(
                FamilyClosure.ancestor_id == child.id
            ).all()
            
            for ancestor in parent_ancestors:
                for descendant in child_descendants:
                    if ancestor.ancestor_id != descendant.descendant_id:
                        new_closure = FamilyClosure(
                            ancestor_id=ancestor.ancestor_id,
                            descendant_id=descendant.descendant_id,
                            depth=ancestor.depth + descendant.depth + 1
                        )
                        session.add(new_closure)
            
            session.flush()
            
        except Exception as e:
            session.rollback()
            raise ValueError(f"Error adding child: {str(e)}")

    def remove_child(self, session: Session, child: "Family"):
        try:
            parent_ancestors = session.query(FamilyClosure).filter(
                FamilyClosure.descendant_id == self.id
            ).all()
            
            child_descendants = session.query(FamilyClosure).filter(
                FamilyClosure.ancestor_id == child.id
            ).all()
            
            for ancestor in parent_ancestors:
                for descendant in child_descendants:
                    session.query(FamilyClosure).filter(
                        FamilyClosure.ancestor_id == ancestor.ancestor_id,
                        FamilyClosure.descendant_id == descendant.descendant_id
                    ).delete(synchronize_session=False)
            
            session.flush()
            
        except Exception as e:
            session.rollback()
            raise ValueError(f"Error removing child: {str(e)}")
    
    def get_ancestors(self, session: Session, max_depth: Optional[int] = None) -> List["Family"]:
        query = session.query(Family).join(
            FamilyClosure, Family.id == FamilyClosure.ancestor_id
        ).filter(
            FamilyClosure.descendant_id == self.id,
            FamilyClosure.depth > 0
        ).order_by(FamilyClosure.depth)
        
        if max_depth:
            query = query.filter(FamilyClosure.depth <= max_depth)
            
        return query.all()
    
    def get_descendants(self, session: Session, max_depth: Optional[int] = None) -> List["Family"]:
        query = session.query(Family).join(
            FamilyClosure, Family.id == FamilyClosure.descendant_id
        ).filter(
            FamilyClosure.ancestor_id == self.id,
            FamilyClosure.depth > 0
        ).order_by(FamilyClosure.depth)
        
        if max_depth:
            query = query.filter(FamilyClosure.depth <= max_depth)
            
        return query.all()

    def get_parent(self, session: Session) -> Optional["Family"]:
        return session.query(Family).join(
            FamilyClosure, Family.id == FamilyClosure.ancestor_id
        ).filter(
            FamilyClosure.descendant_id == self.id,
            FamilyClosure.depth == 1
        ).first()
    
    def get_children(self, session: Session) -> List["Family"]:
        return session.query(Family).join(
            FamilyClosure, Family.id == FamilyClosure.descendant_id
        ).filter(
            FamilyClosure.ancestor_id == self.id,
            FamilyClosure.depth == 1
        ).all()
    
    def get_siblings(self, session: Session) -> List["Family"]:
        parent = self.get_parent(session)
        if not parent:
            return []
        
        siblings = parent.get_children(session)
        return [sibling for sibling in siblings if sibling.id != self.id]
    
    def get_root(self, session: Session) -> "Family":
        root = session.query(Family).join(
            FamilyClosure, Family.id == FamilyClosure.ancestor_id
        ).filter(
            FamilyClosure.descendant_id == self.id
        ).order_by(FamilyClosure.depth.desc()).first()
        
        return root or self
    
    def get_level(self, session: Session) -> int:
        max_depth = session.query(func.max(FamilyClosure.depth)).filter(
            FamilyClosure.descendant_id == self.id
        ).scalar()
        
        return max_depth or 0
    
    def is_ancestor_of(self, session: Session, other: "Family") -> bool:
        relation = session.query(FamilyClosure).filter(
            FamilyClosure.ancestor_id == self.id,
            FamilyClosure.descendant_id == other.id,
            FamilyClosure.depth > 0
        ).first()
        
        return relation is not None
    
    def is_descendant_of(self, session: Session, other: "Family") -> bool:
        return other.is_ancestor_of(session, self)
    
    def count_descendants(self, session: Session) -> int:
        return session.query(FamilyClosure).filter(
            FamilyClosure.ancestor_id == self.id,
            FamilyClosure.depth > 0
        ).count()
    
    def count_children(self, session: Session) -> int:
        return session.query(FamilyClosure).filter(
            FamilyClosure.ancestor_id == self.id,
            FamilyClosure.depth == 1
        ).count()
    
    async def get_authorized_accounts_with_details(self, async_session):
        query = select(
            family_authorized_accounts.c.account_id,
            family_authorized_accounts.c.login,
            family_authorized_accounts.c.name,
            family_authorized_accounts.c.cpf,
            family_authorized_accounts.c.kinship
        ).where(family_authorized_accounts.c.family_id == self.id)
        
        result = await async_session.execute(query)
        accounts_data = result.fetchall()
        
        return [
            {
                "account_id": row.account_id,
                "login": row.login,
                "name": row.name,
                "cpf": row.cpf,
                "kinship": row.kinship.value if row.kinship else None
            }
            for row in accounts_data
        ]

    @property
    def authorized_accounts(self):
        if not hasattr(self, '_authorized_accounts_data'):
            return None
        return self._authorized_accounts_data
        
    @authorized_accounts.setter
    def authorized_accounts(self, value):
        self._authorized_accounts_data = value

    def __repr__(self):
        return f"<Family(id={self.id}, name='{self.name}', cpf='{self.cpf}')>"