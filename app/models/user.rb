class User < ApplicationRecord
  
  has_many :microposts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :micropost
  has_many :messages, dependent: :destroy
  has_many :sent_messages, through: :messages, source: :receive_user
  has_many :reverses_of_message, class_name: 'Message', foreign_key: 'receive_user_id'
  has_many :received_messages, through: :reverses_of_message, source: :user
  # 自分が作った通知=active_notification
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  # 自分宛ての通知=passive_notifications
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy
  
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save :downcase_email
  before_create :create_activation_digest
  mount_uploader :picture, PictureUploader
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validate  :picture_size
  validates :name, presence: true, unless: :uid? #他省略
  validates :email, presence: true, unless: :uid?
  has_secure_password validations: false
  validates :password, presence: true, unless: :uid?
  
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # ユーザーのログイン情報を破棄する
  def forget
    update_attribute(:remember_digest, nil)
  end
  
 # アカウントを有効にする
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # パスワード再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # パスワード再設定のメールを送信する
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
    # パスワード再設定の期限(2時間以上前にメール発行した場合)が切れている場合はtrueを返す
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  #auth hashからユーザ情報を取得
  #データベースにユーザが存在するならユーザ取得して情報更新する；存在しないなら新しいユーザを作成する
  def self.find_or_create_from_auth(auth)
    n = 6
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    image = auth[:info][:image]
    email = auth[:info][:email]
    #ユーザはSNSで登録情報を変更するかもしれので、毎回データベースの情報も更新する
    self.find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.picture = image
      user.email = email
      # パスワードを適当に用意＝＞バリデーション回避
      user.password = format("%0#{n}d", SecureRandom.random_number(10**n))
      user.remember_token = auth["credentials"]["token"]
      user.save!
    end
  end
  
  # 以下お気に入り機能
  def like(micropost)
    unless self == micropost.like_users
      self.favorites.find_or_create_by(micropost_id: micropost.id)
    end
  end
  
  def unlike(micropost)
    favorite = self.favorites.find_by(micropost_id: micropost.id)
    favorite.destroy if favorite
  end
  
  def like?(micropost)
    self.likes.include?(micropost)
  end
  # ここまでお気に入り
  
  # ユーザーモデルにSNS認証が要求されたときにユーザーを生成する専用のメソッド
  # authorizations.rbにて使われる
  # def User.create_from_auth!(auth)
  #   create(:name => auth['info']['name'], :picture => auth['info']['image'], :email => auth['info']['email'])
  # end
  
  private
    # メールアドレス小文字化
    def downcase_email
      self.email = email.downcase
    end
    
    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
    
    # アップロードされた画像のサイズをバリデーションする
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
  
end
