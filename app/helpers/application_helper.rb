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
        url: request.original_url,
        image: 
        if @tweet_item.present?
          @tweet_item[0].image
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
