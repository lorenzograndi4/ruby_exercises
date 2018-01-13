class Shrimp
  SHRIMP_STRING = ['Shrimp!']

  def initialize(app)
  @app = app
  end

  def call(env)
    puts SHRIMP_STRING
    status, headers, response = @app.call(env)
    response_body = ""
    response.each { |part| response_body += part }
    response_body += "&lt;pre&gt;#{SHRIMP_STRING}&lt;/pre&gt;"

    headers["Content-Length"] = response_body.length.to_s

    [status, headers, response_body]
  end
end