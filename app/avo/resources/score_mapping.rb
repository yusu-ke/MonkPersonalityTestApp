class Avo::Resources::ScoreMapping < Avo::BaseResource
  # self.includes = []
  # self.attachments = []
  # self.search = {
  #   query: -> { query.ransack(id_eq: params[:q], m: "or").result(distinct: false) }
  # }

  def fields
    field :id, as: :id
    field :question_id, as: :number
    field :option, as: :number
    field :score, as: :number
    field :question, as: :belongs_to
  end
end
