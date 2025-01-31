class Avo::Resources::User < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :email, as: :text
    field :provider, as: :text
    field :uid, as: :text
    field :role, as: :select, enum: ::User.roles
    field :posts, as: :has_many
    field :view_counts, as: :has_many
  end
end
