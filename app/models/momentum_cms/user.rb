class MomentumCms::User < ActiveRecord::Base

  # == MomentumCms ==========================================================

  self.table_name = 'momentum_cms_users'

  # == Constants ============================================================

  attr_accessor :remember_me, :token

  # == Relationships ========================================================

  # == Extensions ===========================================================

  authenticates_with_sorcery!

  # == Validations ==========================================================

  validates :password, length: { minimum: 3 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  validates :email, presence: true
  validates :email, uniqueness: true


  # == Scopes ===============================================================
  # == Callbacks ============================================================
  # == Class Methods ========================================================
  # == Instance Methods =====================================================

end
