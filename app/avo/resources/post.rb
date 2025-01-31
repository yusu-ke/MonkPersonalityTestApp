class Avo::Resources::Post < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :temple_name, as: :text
    field :comment, as: :text
    field :user_id, as: :number
    field :post_images, as: :code
    field :user, as: :belongs_to
    field :view_counts, as: :has_many
    field :map, as: :has_one
  end
end
