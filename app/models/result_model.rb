class ResultModel < Eps::Base
  def build
    games = Game.all
  end
end
