module ApplicationHelper
  def default_meta_tags
    {
      site: 'LOOK',
      reverse: true,
      separator: '|',
      description: 'ブラウザ上で服の組み合わせが試せるサービス。',
      keywords: '服,ファッション,コーディネート',
      canonical: request.original_url,
      noindex: ! Rails.env.production?,
      icon: [                  
        { href: image_url('favicon.png') },
        { href: image_url('ogp.png'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/png' },
      ],
      og: {
        site_name: 'LOOK',
        description: 'ブラウザ上で服の組み合わせが試せるサービス。', 
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'),
        locale: 'ja_JP',
      },
    }
  end
end
