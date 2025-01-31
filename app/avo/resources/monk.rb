class Avo::Resources::Monk < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :title, as: :text
    field :description, as: :textarea
    field :start_score, as: :number
    field :end_score, as: :number
    field :image_path, as: :text
    field :monk_description, as: :textarea
  end
end
