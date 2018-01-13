class Wisdom
  def initialize(app)
    @app = app
  end

  def call(env)
    Thread.current[:wisdom] = `fortune`
    @app.call(env)
  end
end
