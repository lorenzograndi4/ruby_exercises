class Cowsay
  def call(env)
    out = `cowsay #{Thread.current[:wisdom] || 'oops'}`
    custom_header = "%s" % Thread.current[:wisdom]

    [
      '200',
      { 'Content-Type' => 'text/html',
        'X-Fortune' => "#{custom_header}"},
      [ "<pre>#{out}</pre>" ]
    ]
  end
end
