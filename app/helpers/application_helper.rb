module ApplicationHelper
  def default_meta_tags
    og_image = case @result&.name
    when "法然上人"
      image_url("法然ogp.png")
    when "親鸞聖人"
      image_url("親鸞ogp.png")
    when "一遍上人"
      image_url("一遍ogp.png")
    when "日蓮聖人"
      image_url("日蓮ogp.png")
    when "栄西禅師"
      image_url("栄西ogp.png")
    when "道元禅師"
      image_url("道元ogp.png")
    else
      image_url("ogp.png")
    end

    {
      site: "名僧マッチ",
      title: "名僧マッチ：あなたに合う名僧を選ぶ診断サービス",
      reverse: true,
      charset: "utf-8",
      description: "簡単診断であなたにぴったりな歴史的な名僧に出会うことができます。",
      keywords: "仏教, 性格診断 ,歴史",
      canonical: request.original_url,
      separator: "|",
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: "website",
        url: request.original_url,
        image: og_image,
        locale: "ja-JP"
      },
      twitter: {
        card: "summary_large_image",
        title: "名僧マッチ（診断×歴史の名僧）",
        description: "簡単診断であなたにぴったりな歴史的な名僧に出会うことができます。",
        image: og_image
      }
    }
  end
end
