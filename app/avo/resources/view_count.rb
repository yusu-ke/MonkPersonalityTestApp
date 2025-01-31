class Avo::Resources::ViewCount < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :user_id, as: :number
    field :post_id, as: :number
    field :user, as: :belongs_to
    field :post, as: :belongs_to
  end
end
