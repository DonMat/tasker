class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at

  def email
    object.email_address
  end
end
