class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  has_many :books, dependent: :destroy
  

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end


class User < ApplicationRecord
  # ActiveStorageを利用する場合（もし未導入なら、ここの設定と以下のメソッドは適宜調整してください）
  has_one_attached :profile_image

  # 画像を表示するメソッド（サイズ指定可能）
  def get_profile_image(width, height)
    unless profile_image.attached?
      # assets/images/no_image.jpg を用意してください
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end