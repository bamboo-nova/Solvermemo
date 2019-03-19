class RankingsController < ApplicationController
  def code
    @ranking_counts = UserCode.ranking
    @codes = Code.find(@ranking_counts.keys)
  end
end
