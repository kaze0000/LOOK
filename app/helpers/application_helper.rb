module ApplicationHelper
  def default_meta_tags
    {
      site: 'LOOK',
      reverse: true,
      separator: '|',
      description: 'ブラウザ上で試着ができるサービス。',
      keywords: '服,ファッション,コーディネート',
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: [                  
        { href: image_url('favicon.png') },
        { href: image_url('ogp.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        title: 'LOOK',
        site_name: 'LOOK',
        description: 'ブラウザ上で試着ができるサービス。', 
        type: 'website',
        url: 
        if @fitting.present?
          "https://www.look-closet.com/myclosets/fittings/#{@fitting_number}/secret"
        else
          request.original_url
        end,
        image: 
        if @tweet_item.present?
          "https://look-closet.s3.ap-northeast-1.amazonaws.com/fitting/#{@tweet_item.id}.png"
        else
          image_url('ogp.png')
        end,
        locale: 'ja_JP',
      },
      twitter: {
        card: 'summary_large_image',
        description: 'ブラウザ上で試着ができるサービス。',
        title: 'LOOK'
      }
    }
  end
end
