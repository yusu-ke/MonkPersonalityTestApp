class Avo::Resources::Map < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :post_id, as: :number
    field :address, as: :text
    field :latitude, as: :number
    field :longitude, as: :number
    field :marker_image, as: :text
    field :post, as: :belongs_to
  end
end
